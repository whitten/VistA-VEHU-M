PSJLMUDE ;BIR/MLM - SHOW FIELDS FOR EDIT (LISTMAN STYLE) ;Jul 06, 2018@08:26
 ;;5.0;INPATIENT MEDICATIONS;**7,47,50,63,64,58,80,116,110,111,164,175,201,181,254,267,228,315,317,338,373**;16 DEC 97;Build 3
 ;
 ;NFI-UD Fr#:2 chgs@init+4 to display non-formulary (N/F)
 ;also chgs @init+23
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191
 ; Reference to ^PSDRUG is supported by DBIA 2192
 ; Reference to $$GET^XPAR is supported by DBIA #2263
 ;
INIT(PSGP,PSGORD) ;
 N D,ND,PSJBCMA,PSJL,PSJLM,PSJLN,Q,QQ,PSJDUR,J K ^TMP("PSJUDE",$J),^TMP($J,"GMRAING")
 K:$G(PSJNORD) PSGOEEF S PSJLN=1
 D CLEAN^VALM10
 S PSJL=$S($D(PSGEFN(1)):$E(" *",PSGEFN(1)+1)_"(1)",1:"   "),PSJL=$$SETSTR^VALM1("Orderable Item: "_PSGPDN_$$OINF^PSJDIN(PSGPD),PSJL,5,74) D  D SETTMP D:$G(PSGOEEF(108))!($G(PSGOEEF(101))) HILITE(1)
 . NEW Q,PSJDDA,PSJVD F Q=0:0 S Q=$O(^PS(53.45,PSJSYSP,2,Q)) Q:'Q  S PSJDDA(+$G(^(Q,0)))=""
 . S PSJVD=$$DINFLUD^PSJDIN(PSGPD,.PSJDDA)
 . I $$OVRCHK^PSGSICH1(PSGP,PSGORD) S PSJVD="<OCI>"_PSJVD
 . S PSJL=$$SETSTR^VALM1(PSJVD,PSJL,(80-$L(PSJVD)),80)
 . D:PSJVD]"" CNTRL^VALM10(1,80-$L(PSJVD),$L(PSJVD),IORVON,IORVOFF,0)
 I $G(PSJORD)["P" D REQDT^PSJLIVMD(PSJORD)
 S PSJL="Instructions: "_PSGOINST D PTXT^PSJLMPRU(PSJL,"PSJUDE",6,80)
 S PSJL=$S($D(PSGEFN(2)):$E(" *",PSGEFN(2)+1)_"(2)",1:"    "),PSJL=$$SETSTR^VALM1("Dosage Ordered: "_PSGDO,PSJL,5,76) D SETTMP D:$G(PSGOEEF(109)) HILITE(2)
 I $G(PSGRDTX) S PSJDUR=$$FMTDUR^PSJLIVMD($P($G(PSGRDTX),U,2))
 I $G(PSJORD),($G(PSJDUR)="") S P=$S(PSJORD["U":5,PSJORD["V":"IV",PSJORD["P":"P",1:-1) S PSJDUR=$$GETDUR^PSJLIVMD(PSGP,+PSJORD,P)
 S PSJL=$$SETSTR^VALM1("Duration: "_$G(PSJDUR),PSJL,11,25)
 ;S PSJL=$$SETSTR^VALM1($S($D(PSGEFN(3)):$E(" *",PSGEFN(3)+1)_"(3)",1:"    ")_"Start: "_$P(PSGSDN,U,2),PSJL,54,26) D:$G(PSGOEEF(10)) HILITE(3) ;#373
 S PSJL=$$SETSTR^VALM1($S($D(PSGEFN(3)):$E(" *",PSGEFN(3)+1)_"(3)",1:"    ")_"Start: "_$P(PSGSDN,U,2),PSJL,52,28) D:$G(PSGOEEF(10)) HILITE(3) ;#373
 I $G(PSGORD)["P" N ND0,OLDO S ND0=@(PSGOEEWF_"0)") I $P(ND0,"^",24)="R" S OLDO=$P(ND0,"^",25) I OLDO,(OLDO["U") D
 . ;N OSTRT,OSTRTN S OSTRT=$G(@("^PS(55,"_PSGP_",5,"_+OLDO_",2)")),OSTRT=$P(OSTRT,"^",2) Q:'OSTRT  S OSTRTN=$$ENDTC^PSGMI(+OSTRT) ;#373
 . N OSTRT,OSTRTN S OSTRT=$G(@("^PS(55,"_PSGP_",5,"_+OLDO_",2)")),OSTRT=$P(OSTRT,"^",2) Q:'OSTRT  S OSTRTN=$$ENDTC2^PSGMI(+OSTRT) ;#373
 . ;S PSJL=$$SETSTR^VALM1($S($D(PSGEFN(3)):$E(" *",PSGEFN(3)+1)_"(3)",1:"    ")_"Start: "_OSTRTN,PSJL,54,26) ;#373
 . S PSJL=$$SETSTR^VALM1($S($D(PSGEFN(3)):$E(" *",PSGEFN(3)+1)_"(3)",1:"    ")_"Start: "_OSTRTN,PSJL,52,28) ;#373
 D SETTMP
 S PSJL=$S($D(PSGEFN(4)):$E(" *",PSGEFN(4)+1)_"(4)",1:"    "),PSJL=$$SETSTR^VALM1("Med Route: "_PSGMRN,PSJL,10,35) D:$G(PSGOEEF(3)) HILITE(4)
 ;I $G(PSJORD)["P" N PSGRNDT S PSGRNDT=$$LASTREN^PSJLMPRI(DFN,PSGORD) S:PSGRNDT PSGRNDT=$$ENDTC^PSGMI(+PSGRNDT),PSJL=$$SETSTR^VALM1("Renewed: "_PSGRNDT,PSJL,56,32) ;#373
 I $G(PSJORD)["P" N PSGRNDT S PSGRNDT=$$LASTREN^PSJLMPRI(DFN,PSGORD) S:PSGRNDT PSGRNDT=$$ENDTC2^PSGMI(+PSGRNDT),PSJL=$$SETSTR^VALM1("Renewed: "_PSGRNDT,PSJL,54,32) ;#373
 I '$G(PSGRNDT),$G(PSGRDTX) D
 . ;I $D(PSGRDTX)<10 S PSGRSDN=$$ENDTC^PSGMI(+PSGRDTX),PSJL=$$SETSTR^VALM1("REQUESTED START: "_PSGRSDN,PSJL,48,32) Q  ;#373
 . I $D(PSGRDTX)<10 S PSGRSDN=$$ENDTC2^PSGMI(+PSGRDTX),PSJL=$$SETSTR^VALM1("REQUESTED START: "_PSGRSDN,PSJL,46,34) Q  ;#373
 . ;I $G(PSGRDTX(+$G(PSJORD),"PSGRSD")),$P($G(PSGSDN),U,2) S PSGRSDN=$$ENDTC^PSGMI(PSGRDTX(+PSJORD,"PSGRSD")),PSJL=$$SETSTR^VALM1("Calc Start: "_PSGRSDN,PSJL,53,32) D  ;#373
 . I $G(PSGRDTX(+$G(PSJORD),"PSGRSD")),$P($G(PSGSDN),U,2) S PSGRSDN=$$ENDTC2^PSGMI(PSGRDTX(+PSJORD,"PSGRSD")),PSJL=$$SETSTR^VALM1("Calc Start: "_PSGRSDN,PSJL,51,34) D  ;#373
 .. I PSGSD'=PSGRDTX(+PSJORD,"PSGRSD") D CNTRL^VALM10(5,53,80,IORVON,IORVOFF)
 ; Indirect reference in PSGOEEWF below refers to either ^PS(53.1 or ^PS(55,DFN,5,. Naked reference refers to full indirect reference
 I $G(PSJORD)["U" N ND14 S ND14=$G(@(PSGOEEWF_"14,0)")) I ND14]"" S ND14=$G(^($P(ND14,"^",3),0)),RNDT=$P(ND14,"^") I RNDT D
 . ;N PSGRNDT S PSGRNDT=$$ENDTC^PSGMI(+RNDT),PSJL=$$SETSTR^VALM1("Renewed: "_PSGRNDT,PSJL,56,32) ;#373
 . N PSGRNDT S PSGRNDT=$$ENDTC2^PSGMI(+RNDT),PSJL=$$SETSTR^VALM1("Renewed: "_PSGRNDT,PSJL,54,34) ;#373
 D SETTMP
 I PSGORD]"" S PSJBCMA=$$BCMALG^PSJUTL2(PSGP,PSGORD)
 I $G(PSJBCMA)]"" S PSJL=$$SETSTR^VALM1(PSJBCMA,PSJL,1,52)
 ;S PSJL=$$SETSTR^VALM1($S($D(PSGEFN(5)):$E(" *",PSGEFN(5)+1)_"(5)",1:"     ")_" Stop: "_$P(PSGFDN,U,2),PSJL,54,26) D SETTMP D:$G(PSGOEEF(25))!($G(PSGOEEF(34))) HILITE(5)  ;#373
 S PSJL=$$SETSTR^VALM1($S($D(PSGEFN(5)):$E(" *",PSGEFN(5)+1)_"(5)",1:"     ")_" Stop: "_$P(PSGFDN,U,2),PSJL,52,28) D SETTMP D:$G(PSGOEEF(25))!($G(PSGOEEF(34))) HILITE(5)  ;#373
 S PSJL=$S($D(PSGEFN(6)):$E(" *",PSGEFN(6)+1)_"(6)",1:"   "),PSJL=$$SETSTR^VALM1("Schedule Type: "_PSGSTN,PSJL,6,45) D:$G(PSGOEEF(7)) HILITE(6)
 ;I $G(PSJORD)["P",$G(PSGRDTX(+$G(PSJORD),"PSGRFD")),$P($G(PSGFDN),U,2) S PSGRFDN=$$ENDTC^PSGMI(PSGRDTX(+PSJORD,"PSGRFD")),PSJL=$$SETSTR^VALM1("Calc Stop: "_PSGRFDN,PSJL,54,26) D  ;#373
 I $G(PSJORD)["P",$G(PSGRDTX(+$G(PSJORD),"PSGRFD")),$P($G(PSGFDN),U,2) S PSGRFDN=$$ENDTC2^PSGMI(PSGRDTX(+PSJORD,"PSGRFD")),PSJL=$$SETSTR^VALM1("Calc Stop: "_PSGRFDN,PSJL,52,28) D  ;#373
 . I PSGFD'=PSGRDTX(+PSJORD,"PSGRFD") D CNTRL^VALM10(7,54,80,IORVON,IORVOFF)
 D SETTMP
 S PSGSMN=$P("NO^YES",U,PSGSM+1)
 S PSJL=$S($D(PSGEFN(8)):$E(" *",PSGEFN(8)+1)_"(8)",1:"   "),PSJL=$$SETSTR^VALM1("Schedule: "_PSGSCH_$G(SCHMSG),PSJL,11,68) D SETTMP D:$G(PSGOEEF(26)) HILITE(8)
 S PSJL=$S($D(PSGEFN(9)):$E(" *",PSGEFN(9)+1)_"(9)",1:"   "),PSJL=$$SETSTR^VALM1("Admin Times: "_PSGAT,PSJL,8,71) D SETTMP D:'$G(PSGNOHI)&($G(PSGOEEF(39))!($G(PSGOEEF(41)))) HILITE(9) ;*315
 I +$G(PSGRF)>1 N PSGRMVD S PSGRMVD=$S(+$G(PSGRMVT):PSGRMVT,1:"") S PSJL=$$SETSTR^VALM1("Removal Times: "_PSGRMVD,PSJL,6,71) D SETTMP ;*315
 S PSJL=$S($D(PSGEFN(10)):$E(" *",PSGEFN(10)+1)_"(10)",1:"   "),PSJL=$$SETSTR^VALM1("Provider: "_PSGPRN,PSJL,11,68) D:$G(PSGOEEF(1)) HILITE(10) D SETTMP
 S PSJL=$S($D(PSGEFN(11)):$E(" *",PSGEFN(11))_" (11)",1:"   ")_" Special Instructions"_$S($P(PSGSI,"^",2)=1:"!: ",1:": ") D
 .I '$D(^PS(53.45,DUZ,5,1)),$G(PSGORD) D GETSI^PSJBCMA5(PSGP,PSGORD)
 .I '$P($G(^PS(53.45,DUZ,5,0)),"^",3) S PSJL=PSJL_$P($G(PSGSI),"^") D PTXT^PSJLMPRU(PSJL,"PSJUDE",1,80) Q
 .S PSJL=PSJL_" (see below)" D SETTMP N I S I=0 F J=1:1 S I=$O(^PS(53.45,DUZ,5,I)) Q:'I  S PSJL="      "_^PS(53.45,DUZ,5,I,0) D SETTMP
 S PSJL="" D SETTMP D:$G(PSGOEEF(8)) HILITE(11)
 ; E3R 16130
 I $O(^PS(53.45,PSJSYSP,2,1)) F  S PSJL="" D SETTMP Q:PSJLN>15
 S PSJL=$S($D(PSGEFN(12)):$E(" *",PSGEFN(12))_" (12)",1:"   ")_" Dispense Drug",PSJL=$$SETSTR^VALM1("U/D",PSJL,52,60),PSJL=$$SETSTR^VALM1("Inactive Date",PSJL,59,16) D  D SETTMP,CNTRL^VALM10(PSJLN-1,1,80,IOUON,IOUOFF,0)
 .I $$GET^XPAR("SYS","PSJ PADE OE BALANCES") D
 ..I '$G(VAIN(4)) N VAIN,DFN S DFN=$G(PSGP) D INP^VADPT
 ..N PSJORCL,PSJCLNK
 ..; If clinic order, quit if clinic location is not linked to PADE
 ..S PSJORCL=$S($G(PSGORD)["P":$G(^PS(53.1,+$G(PSGORD),"DSS")),$G(PSGORD)["U":$G(^PS(55,+$G(PSGP),5,+$G(PSGORD),8)),$G(PSGORD)["V":$G(^PS(55,+$G(PSGP),"IV",+$G(PSGORD),"DSS")),1:"")
 ..I PSJORCL,$P(PSJORCL,"^",2) S PSJCLNK=$$PADECL^PSJPAD50(+$G(PSJORCL)) Q:'PSJCLNK
 ..I '$G(PSJCLNK) Q:'$$PADEWD^PSJPAD50(+$G(VAIN(4)))   ; PADE device Inactive?
 ..S PSJL=$$SETSTR^VALM1("PADE",PSJL,75,5)
 NEW PSJX,PSJDLINE
 F Q=0:0 S Q=$O(^PS(53.45,PSJSYSP,2,Q)) Q:'Q  S ND=$G(^(Q,0)) D
 .S D=$P(ND,"^"),PSGID=$P(ND,"^",3) I PSGID S PSGID=$$ENDTC^PSGMI(PSGID)
 .S D=$S(D="":"NOT FOUND",'$D(^PSDRUG(D,0)):D,$P(^(0),"^")]"":$P(^(0),"^"),1:D_";PSDRUG(")
 .S PSJL="      "_D_$$DDNF^PSJDIN(+ND),PSJL=$$SETSTR^VALM1($S($P(ND,"^",2):$S($P(ND,"^",2)=.5:"1/2",$P(ND,"^",2)=.25:"1/4",1:$P(ND,"^",2)),$P(ND,"^",2)=0:0,1:1),PSJL,52,63) S:PSGID PSJL=$$SETSTR^VALM1(PSGID,PSJL,59,16) D  D SETTMP
 ..; PSJ*5*317 - If PSJ PADE OE BALANCES parameter is YES, PADE balances should display as identifier.
 ..I $$GET^XPAR("SYS","PSJ PADE OE BALANCES") D
 ...N PSJPDLOC,VAIN,PSJORCL,PSJCLNK,PSJCLND D INP^VADPT
 ...; If clinic order, quit if clinic location is not linked to PADE
 ...S PSJCLND=$S($G(PSGORD)["P":$G(^PS(53.1,+$G(PSGORD),"DSS")),$G(PSGORD)["U":$G(^PS(55,+$G(PSGP),5,+$G(PSGORD),8)),$G(PSGORD)["V":$G(^PS(55,+$G(PSGP),"IV",+$G(PSGORD),"DSS")),1:"")
 ...S PSJORCL=$S(+PSJCLND&$P(PSJCLND,"^",2):+PSJCLND,1:"")
 ...I PSJORCL,$P(PSJCLND,"^",2) S PSJCLNK=$$PADECL^PSJPAD50(+$G(PSJORCL)) Q:'PSJCLNK
 ...I '$G(PSJCLNK) Q:'$$PADEWD^PSJPAD50(+$G(VAIN(4)))   ; Quit if patient location not linked to PADE
 ...S PSJPDLOC=$S($G(PSJCLNK):PSJORCL_"C",1:"")
 ...S:'PSJPDLOC PSJPDLOC=+$G(VAIN(4))
 ...N PADE S PADE=$J($$DRGQTY^PSJPADSI(+ND,$S(PSJPDLOC["C":"CL",1:"WD"),+PSJPDLOC),5)
 ...S PSJL=$$SETSTR^VALM1(PADE,PSJL,74,5)
 ..S PSJX=$G(PSJX)+1
 ..S PSJDLINE=$S($P(^PS(53.45,PSJSYSP,2,0),U,3)>1:16,1:13) ;*228 - Highlight multiple dispense drugs
 ..I $G(PSGOEEF(109)) D CNTRL^VALM10(PSJDLINE+PSJX,7,73,IORVON_IOBON,IORVOFF_IOBOFF,0)
 I $S(PSGORD["P":$O(^PS(53.1,+$G(PSGORD),12,0)),1:$O(^PS(55,PSGP,5,+PSGORD,12,0))) S PSJL="Provider Comments:" D SETTMP S PSJL="" D
 .F Q=0:0 S Q=$S(PSGORD["P":$O(^PS(53.1,+$G(PSGORD),12,Q)),1:$O(^PS(55,PSGP,5,+PSGORD,12,Q))) Q:'Q  S PSJL=$G(^(Q,0)) D SETTMP
 D SETTMP S PSJL=$$SETSTR^VALM1($S($D(PSGEFN(7)):$E(" *",PSGEFN(7)+1)_"(7)",1:"   ")_"Self Med: "_PSGSMN,PSJL,1,24)
 S:PSGSM&PSGHSM PSJL=$$SETSTR^VALM1("  (HS)",PSJL,16,7) D SETTMP D:$G(PSGOEEF(5)) HILITE(7)
 D SETTMP S PSJL="Entry By: "_PSGEBN,PSJL=$$SETSTR^VALM1("Entry Date: "_$P(PSGLIN,U,2),PSJL,51,39) D SETTMP
 I $G(PSGLRN) D SETTMP S PSJL="Renewed By: "_$$ENNPN^PSGMI($P(PSGLRN,"^",2)) D SETTMP
 D SETTMP S PSJL="(13)"_" Comments:"
 D:'$O(^PS(53.45,PSJSYSP,1,0)) SETTMP
 D SETTMP F Q=0:0 S Q=$O(^PS(53.45,PSJSYSP,1,Q)) Q:'Q  S PSJWPL=PSJL_$S($E(PSJL)=" ":"",1:" ")_$G(^(Q,0)),PSJL="" D DISPLAY
 D SETTMP
 I PSGORD["P",($P($G(^PS(53.1,+PSGORD,0)),U,9)="P"),$O(^PS(53.1,+PSGORD,10,0)) D
 .D SETTMP S PSJL="CPRS Order Checks:" D SETTMP
 .F Q=0:0 S Q=$O(^PS(53.1,+PSGORD,10,Q)) Q:'Q  D
 ..;S PSJL="" D SETTMP S PSJL=$G(^PS(53.1,+PSGORD,10,Q,0)) D SETTMP
 ..S PSJL="" D SETTMP
 ..D FORMATTX($G(^PS(53.1,+PSGORD,10,Q,0)))
 ..S PSJL="Overriding Provider: "_$P($G(^PS(53.1,+PSGORD,10,Q,1)),U) D SETTMP
 ..S PSJL="Overriding Reason: " F X=0:0 S X=$O(^PS(53.1,+PSGORD,10,Q,2,X)) Q:'X   D
 ...S PSJL=PSJL_$G(^PS(53.1,+PSGORD,10,Q,2,X,0)) D SETTMP S PSJL="                   "
ACTFLG ;
 S ND4=$S(PSGORD["P":$G(^PS(53.1,+PSGORD,4)),1:$G(^PS(55,PSGP,5,+PSGORD,4)))
 S AT="",Y="12,13,D,18,19,H1,22,23,H0,15,16,R" F X=1:3:12 I $P(ND4,"^",$P(Y,",",X)),$P(ND4,"^",$P(Y,",",X+1)) S AT=$P(Y,",",X+2) Q
 I AT="",'$P(ND4,"^",$S($P(PSJSYSU,";",3)>1:3,1:1)) S AT="V"_$S($P(ND4,"^",18):"H1",$P(ND4,"^",22):"H0",$P(ND4,"^",15):"R",1:"")
 I AT]"" D
 .S PSJL="" D SETTMP
 .S PSJL="ORDER "_$S(AT["V":"NOT VERIFIED"_$S($P(AT,"V",2)="":"",1:" ("_$S(AT["H1":"ON HOLD",AT["H0":"OFF HOLD",1:"RENEWAL")_")"),1:"MARKED TO BE "_$S(AT["D":"CANCELLED",AT["H1":"PLACED ON HOLD",AT["H0":"TAKEN OFF OF HOLD",1:"RENEWED"))
 I AT'["V",AT["H1",$D(^PS(55,PSGP,5.1)) S AT=^(5.1) I $P(AT,"^",7),$P(AT,"^",10)]"" S PSJL=PSJL_"  ("_$P(AT,"^",10)_")"
 D SETTMP
 S VALMCNT=PSJLN-1
 K PSGSMN,Q,Y,Y1,Y2,PSGLRN
 S VALM("TITLE")=PSGSTAT_" UNIT DOSE "_$S((PSGSTAT="PENDING")&($G(PSGPRIO)]""):"("_PSGPRIO_")",$G(PSGPRIO)="DONE":"("_PSGPRIO_")",1:"") I $D(PSJLMP2) S VALMBG=16 K PSJLMP2
TEST ;
 I $G(PSGPFLG) S VALMSG="INVALID ORDERABLE ITEM"
 I $G(PSGDI) S VALMSG=$S($G(VALMSG)="":"INVALID",1:VALMSG_",")_" DISPENSE DRUG"
 I $G(PSGPI) S VALMSG=$S($G(VALMSG)="":"INVALID",1:VALMSG_",")_" PROVIDER"
 I $G(PSGDREQ) S CHK=1,VALMSG="DOSAGE IS REQUIRED" K PSGDREQ
 Q
DISPLAY ;
 S PSJL=PSJWPL D SETTMP
 Q
 ;
SETTMP ;
 S ^TMP("PSJUDE",$J,PSJLN,0)=PSJL,PSJLN=PSJLN+1,PSJL=""
 Q
 ;
HILITE(FLD) ;
 N COL,LIN,WID,X
 S X="$T("_FLD_"^PSJLMUDE)",@("X="_X),X=$P(X,";;",2),LIN=+X,COL=$P(X,",",2),LAB=$P(X,",",3),X=$P(X,",",4),WID=(LAB+$L(@X))
 I $G(PSGRF),FLD>9 S LIN=LIN+1 ;COMPENSATE FOR REMOVAL TIMES
 I FLD=7 S LIN=+$G(PSJLN)-1 Q:LIN<13
 D CNTRL^VALM10(LIN,COL,WID,IORVON_IOBON,IORVOFF_IOBOFF,0)
 Q
 ;
FORMATTX(PSJX) ;
 NEW PSJX1,Y,Y1
 S PSJX1=""
 F Y=1:1:$L(PSJX," ") S Y1=$P(PSJX," ",Y) D
 . I ($L(PSJX1)+$L(Y1)+1)>79 S:$E(PSJX1,1,1)=" " PSJX1=$E(PSJX1,2,$L(PSJX1)) S PSJL=PSJX1,PSJX1="" D SETTMP
 . S PSJX1=PSJX1_Y1_" "
 I PSJX1]"" S PSJL=PSJX1 D SETTMP
 K PSJX1
 Q
 ;
1 ;;1,5,16,PSGPDN
2 ;;3,5,16,PSGDO
3 ;;4,58,7,PSGSDN
4 ;;5,10,11,PSGMRN
5 ;;6,59,6,PSGFDN
6 ;;7,6,15,PSGSTN
7 ;;18,5,14,PSGSMN
8 ;;8,11,12,PSGSCH
9 ;;9,8,13,PSGAT
10 ;;10,11,10,PSGPRN
11 ;;11,7,22,PSGSI
ENKILL ;
 ; 373 - Additionally, KILL off PSJALLGY
 K PSGNOHI,PSGAT,PSGEB,PSGEFN,PSGFD,PSGHSM,PSGNEFD,PSGNESD,PSGOEEF,PSGOEER,PSGOFD,PSGOHSM,PSGOMR,PSGOMRN,PSGOPD,PSGOPDN,PSGOPR,PSGOSCH,PSGOSD,PSGOSM,PSGOST,PSGPD,PSGPDN,PSGPR,PSGSD,PSGSM,PSJALLGY Q
