GMRCCCRI ;DAL/PHH/MBJ - PROCESS HL7 RRI^I13 MESSAGES FROM HSRM ;8/29/18
 ;;3.0;CONSULT/REQUEST TRACKING;**123**;FEB 2019;Build 51
 ;
 ; Built from pieces of GMRCHL7I and modified for CCRA consult status update
 Q
 ; Documented API's and Integration Agreements
 ; ----------------------------------------------
 ; 2165   GENACK^HLMA1
 ; 2701   $$GETDFN^MPIF001
 ; 2701   $$GETICN^MPIF001
 ; 3535   MAKEADD^TIUSRVP2
 ; 10103  $$HL7TFM^XLFDT
 ;
EN ; Entry point for routine
 N FS,CS,RS,ES,SS,MID,HLQUIT,HLNODE,I13MSG,ABORT,ERR1,NAKMSG
 S FS=$G(HL("FS"),"|")
 S CS=$E($G(HL("ECH")),1) S:CS="" CS="^"
 S RS=$E($G(HL("ECH")),2) S:RS="" RS="~"
 S ES=$E($G(HL("ECH")),3) S:ES="" ES="\"
 S SS=$E($G(HL("ECH")),4) S:SS="" SS="&"
 S MID=$G(HL("MID"))
 S (HLQUIT,HLNODE)=0
 D COPYMSG(.I13MSG)
 Q:$$CHKMSG(.I13MSG)
 Q:$$PROCMSG(.I13MSG)
 D ACK("CA",MID)
 Q
 ;
COPYMSG(Y) ; Copy HL7 Message to array Y (by reference)
 ; Based on HL*1.6*56 VISTA HL7 Site Manager & Developer Manual
 ; Paragraph 9.7, page 9-4
 I $L($G(HLNEXT)) ;HL7 context
 E  Q
 N I,J
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 .S Y(I)=HLNODE,J=0
 .F  S J=$O(HLNODE(J)) Q:'J  D
 ..S Y(I)=Y(I)_HLNODE(J)
 Q
 ;
CHKMSG(Y) ; Check Message for all required segments
 N QUIT,REQSEG,SEGFND,I,SEGTYP,ICN,DFN
 S QUIT=0
 F REQSEG="MSH","RF1","PRD","PID","PV1" D  Q:QUIT
 .S (SEGFND,I)=0
 .F  S I=$O(Y(I)) Q:'I!(SEGFND)  D
 ..S SEGTYP=$E(Y(I),1,3)
 ..I SEGTYP=REQSEG S SEGFND=1
 ..;
 ..I SEGTYP="MSH",$P(Y(I),FS,10)="" D
 ...S QUIT=1
 ...D ACK("CE",MID,"MSH","",10,101,"MESSAGE CONTROL ID MISSING")
 ..;
 .I 'SEGFND D
 ..S QUIT=1
 ..D ACK("CE",MID,REQSEG,"","",100,REQSEG_" SEGMENT MISSING OR OUT OF ORDER")
 Q QUIT
 ;
PROCMSG(Y) ; Process message
 N QUIT,I,SEGTYP,GMRCRF1,GMRCPID,GMRCPRD,GMRCOBR,GMRCNTE,GMRCIEN,GMRCICN,GMRCEML
 N GMRCDFN,GMRCTIU,GMRCTIUS,ADDTXT,GMRCATIU,STID,PROGAUTH,REFDT,REFXDT,XDT
 S (QUIT,I)=0,GMRCEML=""
 F  S I=$O(Y(I)) Q:'I  D
 .S SEGTYP=$E(Y(I),1,3)
 .I SEGTYP="RF1" D RF1(Y(I),.GMRCRF1)
 .I SEGTYP="PID" D PID(Y(I),.GMRCPID)
 .I SEGTYP="PRD" D PRD(Y(I),.GMRCPRD)
 ;
 S GMRCIEN=+GMRCRF1,GMRCSTS=$P(GMRCRF1,FS,2)
 ;
 I 'GMRCIEN!('$D(^GMR(123,+GMRCIEN,0))) D  Q QUIT
 .S QUIT=1
 .D ACK("CE",MID,"RF1","",6,"VA207","INVALID IEN FOR CONSULT",1)
 ;
 S GMRCICN=GMRCPID
 S GMRCDFN=$$GETDFN^MPIF001($P(GMRCICN,"V"))
 I GMRCDFN'>0 D  Q QUIT
 .S QUIT=1
 .D ACK("CE",MID,"PID",1,3,"VA207",$P(GMRCDFN,"^",2),1)
 I GMRCICN'=$$GETICN^MPIF001(GMRCDFN) D  Q QUIT
 .S QUIT=1
 .D ACK("CE",MID,"PID",1,3,"VA207","ICN CHECKSUM DOES NOT MATCH CHECKSUM IN DATABASE",1)
 ;
 I $P(^GMR(123,GMRCIEN,0),"^",2)'=GMRCDFN D  Q QUIT
 .S QUIT=1
 .D ACK("CE",MID,"RF1","",6,"VA207","ICN DOES NOT MATCH PATIENT DFN IN CONSULT",1)
 ;
 ; check for valid VistA user via user email value, create NAK if invalid and quit
 S GMRCDT=$$NOW^XLFDT(),GMRCDT1=$$FMTE^XLFDT(GMRCDT,2)
 ; S XDT=$E($P(GMRCDT1,".",2)+1000000,2,5),GMRCDT1=$P(GMRCDT1,".")_XDT
 S GMRCUSER=$$LOW^XLFSTR(GMRCEML)
 I GMRCUSER'="" S GMRCUSER=$O(^VA(200,"ADUPN",$G(GMRCUSER),""))
 I GMRCUSER'>0 S (NAKMSG,ERR1)="HSRM USER DOESN'T HAVE AN ACCOUNT ON THIS SYSTEM",ABORT="1^"_ERR1
 I $G(NAKMSG)'="" S QUIT=1 D ANAK^GMRCCCR1($G(NAKMSG),$G(GMRCEML),$G(GMRCICN),$G(GMRCDFN),$G(GMRCIEN),GMRCDT1)
 I +$G(ABORT)>0 D MESSAGE2^GMRCCCR1(MID,.ABORT,GMRCIEN) Q 1
 ;
 ; Reject if Referral Status is not valid
 S STID=$P(GMRCSTS,CS)
 I "A,AC,AP,BP,C,D,P,RJ,X,"'[STID_"," D
 .S QUIT=1
 .D ACK("CE",MID,"RF1","",1,"VA207","INVALID REFERRAL STATUS",1)
 ;
 Q:QUIT
 S GMRCSTS=$S(STID="A":"SCHEDULED",STID="AC":"ACTIVE",STID="AP":"ACTIVE",STID="BP":"COMPLETE",STID="C":"ACTIVE",STID="D":"COMPLETE",STID="P":"PENDING",STID="RJ":"ACTIVE",STID="X":"CANCELLED",1:"")
 I GMRCSTS'="" D
 . ; file status into field 8 of consult file
 . K FDA S FDA(123,GMRCIEN_",",8)=GMRCSTS
 . D FILE^DIE("E","FDA")
 . K FDA,GMRCFDA
 . ;
 . S GMRCSTID=$S(STID="X":"CANCELLED",STID="A":"SCHEDULED",STID="BP":"COMPLETE/UPDATE",STID="D":"COMPLETE/UPDATE",1:"ADDED COMMENT")
 . S GMRCSTID=$O(^GMR(123.1,"B",GMRCSTID,""))
 . K FDA S FDA(123,GMRCIEN_",",9)=GMRCSTID
 . D FILE^DIE("","FDA") K FDA
 . ;
 . ; create consult note for new status
 . S GMRCFDA(123.02,"+1,"_GMRCIEN_",",.01)=GMRCDT
 . S GMRCFDA(123.02,"+1,"_GMRCIEN_",",1)=GMRCSTID
 . S GMRCFDA(123.02,"+1,"_GMRCIEN_",",2)=GMRCDT
 . S GMRCFDA(123.02,"+1,"_GMRCIEN_",",4)=GMRCUSER
 . D UPDATE^DIE("","GMRCFDA","GMRCCIEN")
 . S GMRCTXT(1)="CONSULT STATUS CHANGED TO "_GMRCSTS_" "_GMRCDT1
 . D WP^DIE(123.02,GMRCCIEN(1)_","_GMRCIEN_",",5,"","GMRCTXT","GMRCERR")
 . K FDA,GMRCFDA,GMRCCIEN,GMRCTXT,GMRCERR
 ;
 ; create consult note with new referral date from HSRM
 I REFDT]"" D
 . S GMRCFDA(123.02,"+1,"_GMRCIEN_",",.01)=GMRCDT
 . S GMRCFDA(123.02,"+1,"_GMRCIEN_",",2)=GMRCDT
 . S GMRCFDA(123.02,"+1,"_GMRCIEN_",",4)=GMRCUSER
 . D UPDATE^DIE("","GMRCFDA","GMRCCIEN","GMRCERR")
 . S GMRCTXT(1)="REFERRAL DATE IS "_REFDT ;
 . D WP^DIE(123.02,GMRCCIEN(1)_","_GMRCIEN_",",5,"","GMRCTXT","GMRCERR")
 . K FDA,GMRCFDA,GMRCCIEN,GMRCTXT,GMRCERR
 ;
 ; create consult note with new referral expiration date from HSRM
 I REFXDT]"" D
 . S GMRCFDA(123.02,"+1,"_GMRCIEN_",",.01)=GMRCDT
 . S GMRCFDA(123.02,"+1,"_GMRCIEN_",",2)=GMRCDT
 . S GMRCFDA(123.02,"+1,"_GMRCIEN_",",4)=GMRCUSER
 . D UPDATE^DIE("","GMRCFDA","GMRCCIEN")
 . S GMRCTXT(1)="REFERRAL EXPIRATION DATE IS "_REFXDT ;
 . D WP^DIE(123.02,GMRCCIEN(1)_","_GMRCIEN_",",5,"","GMRCTXT","GMRCERR")
 . K FDA,GMRCFDA,GMRCCIEN,GMRCTXT,GMRCERR
 ;
 ; create consult note with new program authority value from HSRM
 I PROGAUTH]"" D
 . S GMRCFDA(123.02,"+1,"_GMRCIEN_",",.01)=GMRCDT
 . S GMRCFDA(123.02,"+1,"_GMRCIEN_",",2)=GMRCDT
 . S GMRCFDA(123.02,"+1,"_GMRCIEN_",",4)=GMRCUSER
 . D UPDATE^DIE("","GMRCFDA","GMRCCIEN")
 . S GMRCTXT(1)="PROGRAM AUTHORITY IS "_PROGAUTH
 . D WP^DIE(123.02,GMRCCIEN(1)_","_GMRCIEN_",",5,"","GMRCTXT","GMRCERR")
 . K FDA,GMRCFDA,GMRCCIEN,GMRCTXT,GMRCERR
 ;
 K GMRCFDA,GMRCDT,GMRCDT1,GMRCCIEN,GMRCSTID,GMRCTXT,GMRCUSER
 Q QUIT
 ;
RF1(RF1SEG,RETVAL) ; Process RF1 Segment
 N GMRCSTS,GMRCIEN
 S GMRCSTS=$P(RF1SEG,FS,2)
 S GMRCIEN=$P(RF1SEG,FS,7)
 S REFDT=$P($P(RF1SEG,FS,8),CS)
 S REFXDT=$P($P(RF1SEG,FS,9),CS)
 S PROGAUTH=$P($P(RF1SEG,FS,11),CS,2)
 S RETVAL=GMRCIEN_FS_GMRCSTS
 Q
 ;
PID(PIDSEG,RETVAL) ; Process PID Segment
 N GMRCICN,I,J,GMRCI,GMRCJ
 S GMRCJ=$P(PIDSEG,FS,4),GMRCICN=""
 F J=1:1:$L(GMRCJ,RS) D  Q:GMRCICN'=""
 . S GMRCI=$P(GMRCJ,RS,J)
 . F I=1:1:$L(GMRCI,CS) D  Q:GMRCICN'=""
 .. I $P($P(GMRCJ,CS,I),RS)["NI" S GMRCICN=$P(GMRCI,CS,J) Q
 S RETVAL=GMRCICN
 Q
 ;
PRD(PRDSEG,RETVAL) ; Process PRD segment
 I $L(GMRCEML)>0 S RETVAL=GMRCEML Q RETVAL ; already found in previous PRD segment
 I $P($P(PRDSEG,FS,2),CS,1)'="RP" S RETVAL=0 Q RETVAL
 S GMRCEML=$P(PRDSEG,FS,6),GMRCEML=$P(GMRCEML,CS,4)
 S RETVAL=GMRCEML Q RETVAL
 ;
ACK(STAT,MID,SID,SEG,FLD,CD,TXT,ACKTYP) ; Creates ACKs for HL7 Message
 ;STAT = Status (Acknowledgment Code) (REQUIRED)
 ;MID = Message ID (REQUIRED)
 ;SID = Segment ID (set if ERR occurred in segment) (OPTIONAL)
 ;SEG = Segment location of error (OPTIONAL)
 ;FLD = Field location of error (OPTIONAL)
 ;CD = Error Code (OPTIONAL)
 ;TXT = Text describing error (OPTIONAL)
 ;ACKTYP = Acknowledgment Type (OPTIONAL)
 ;
 N HLA,EID,EIDS,RES,ERRI
 ;
 ;Make sure the parameters are defined
 S STAT=$G(STAT),MID=$G(MID),SID=$G(SID),SEG=$G(SEG)
 S FLD=$G(FLD),CD=$G(CD),TXT=$G(TXT)
 ;
 ;Create MSA Segment
 S HLA("HLA",1)="MSA"_FS_STAT_FS_MID
 S EID=$G(HL("EID"))
 S EIDS=$G(HL("EIDS"))
 Q:((EID="")!($G(HLMTIENS)="")!(EIDS=""))
 ;
 S RES=""
 ;If Segment ID (SID) is set, create ERR segment
 D:$L(SID)>0
 . K ERRARY
 . S HLA("HLA",2)="ERR"
 . S $P(HLA("HLA",2),FS,3)=SID_CS_SEG_CS_FLD
 . S $P(HLA("HLA",2),FS,5)="E"
 . ;
 . ; Commit Error
 . I '+$G(ACKTYP) D
 .. S $P(HLA("HLA",2),FS,4)=CD_CS_TXT_CS_"0357"
 . ;
 . ; Application Error
 . I +$G(ACKTYP)=1 D
 .. S ERRI=0
 .. S $P(HLA("HLA",2),FS,6)=CS_CS_CS_CD_CS_TXT
 .. ;Process Error
 .. S ERRI=ERRI+1
 .. S ERRARY(ERRI,2)=$P($G(HLA("HLA",2)),"|",3)
 .. I $P($G(HLA("HLA",2)),"|",6)'="" D  ;
 ... S ERRARY(ERRI,3)=$P($P($G(HLA("HLA",2)),"|",6),"^",4)_"^"_$P($P($G(HLA("HLA",2)),"|",6),"^",5)
 .. I $P($G(HLA("HLA",2)),"|",6)="" S ERRARY(ERRI,3)=$P($G(HLA("HLA",2)),"|",4)
 . I $D(ERRARY) D MESSAGE(MID,.ERRARY)
 . ; build message for MailMan
 ;
 D GENACK^HLMA1(EID,$G(HLMTIENS),EIDS,"LM",1,.RES)
 Q
MESSAGE(MSGID,ERRARY) ; Send a MailMan Message with the errors
 N MSGTEXT,DUZ,XMDUZ,XMSUB,XMTEXT,XMY,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,XMZ,XMMG,DATE,J
 S DATE=$$FMTE^XLFDT($$FMDATE^HLFNC($P(HL("DTM"),"-",1)))
 S XMSUB="GMRC CCRA Consult Updates from HSRM HL7 Error"
 S MSGTEXT(1)=" "
 S MSGTEXT(2)="Error in receiving HL7 message from HSRM"
 S MSGTEXT(3)="Date:       "_DATE
 S MSGTEXT(4)="Message ID: "_MSGID
 S MSGTEXT(5)="Error(s):"
 S I=0,J=5 F  S I=$O(ERRARY(I)) Q:'I  D
 . S J=J+1,MSGTEXT(J)=" "
 . S J=J+1,MSGTEXT(J)="   "_$P($G(ERRARY(I,3)),U)_" - "_$P($G(ERRARY(I,3)),U,2)
 . I $P($G(ERRARY(I,2)),U,1)'="" S J=J+1,MSGTEXT(J)="      Segment:       "_$P($G(ERRARY(I,2)),U,1)
 . I $P($G(ERRARY(I,2)),U,2)'="" S J=J+1,MSGTEXT(J)="      Sequence:      "_$P($G(ERRARY(I,2)),U,2)
 . I $P($G(ERRARY(I,2)),U,3)'="" S J=J+1,MSGTEXT(J)="      Field:         "_$P($G(ERRARY(I,2)),U,3)
 . I $P($G(ERRARY(I,2)),U,4)'="" S J=J+1,MSGTEXT(J)="      Fld Rep:       "_$P($G(ERRARY(I,2)),U,4)
 . I $P($G(ERRARY(I,2)),U,5)'="" S J=J+1,MSGTEXT(J)="      Component:     "_$P($G(ERRARY(I,2)),U,5)
 . I $P($G(ERRARY(I,2)),U,6)'="" S J=J+1,MSGTEXT(J)="      Sub-component: "_$P($G(ERRARY(I,2)),U,6)
 S XMTEXT="MSGTEXT("
 S XMDUZ="GMRC-CCRA<-HSRP Transaction Error"
 S XMY("G.GMRC HCP HL7 MESSAGES")=""  ;  ** CHECK THIS OUT **
 D ^XMD
 Q
