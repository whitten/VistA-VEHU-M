PRCSREC2 ;WISC/KMB/DL-UPDATE 420 BALANCES FOR ISSUE BOOK,CONVERSION ;1/28/98  1400
 ;;5.1;IFCAP;**55,155,213**;4/21/95;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*213 Modify FCP Cost Center verification to
 ;            use ^TMP workfile to handle FCP's with
 ;            large number of attached cost centers
 ;
ISSUES(STATION,FY,CP,QUARTER,AMOUNT) ;
 N A
 S A=+STATION_"^"_(+CP)_"^"_FY_"^"_QUARTER_"^"_AMOUNT
 D EBAL^PRCSEZ(A,"O")
 QUIT
COST(STATION,CP) ;
 ;return FCP cost centers       ;PRC*5.1*213
 K ^TMP($J,"PRCCC")
 N CC
 I '$D(^PRC(420,STATION,1,+CP,2)) Q
 S CC=0 F  S CC=$O(^PRC(420,STATION,1,+CP,2,CC)) Q:'CC  I $D(^PRCD(420.1,CC,0)),'$P(^PRCD(420.1,CC,0),U,2) S ^TMP($J,"PRCCC",CC)=""
 QUIT
 ;
CONV(STRING,AMOUNT,COMMENT) ;
 ;after V5 installation, reconcile CP with adjustment trans.
 N A,CPNAME,IT,PRC,T,X,X1,Z
 Q:'$D(STRING)
 S PRC("SITE")=$P(STRING,"-"),PRC("FY")=$P(STRING,"-",2),PRC("QTR")=$P(STRING,"-",3),PRC("CP")=$P(STRING,"-",4)
 S T(2)="A" D:'$D(DT) DT^DICRW
 S PRC("BBFY")=+$$YEAR^PRC0C(PRC("FY"))
 S X=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("CP"),Z=STRING
 D EN1^PRCSUT3 Q:'$D(X)
 S X1=X D EN2^PRCSUT3 Q:'$D(X1)
 L +^PRCS(410,DA):15 Q:'$T
 S $P(^PRCS(410,DA,5),"^")=AMOUNT,$P(^(5),"^",2)=DT,$P(^(4),"^",2)=DT
 F IT=1,4 S $P(^PRCS(410,DA,IT),"^",4)=DT,$P(^(1),"^",IT)=DT
 F IT=1,3,8 S $P(^PRCS(410,DA,4),"^",IT)=AMOUNT
 S CPNAME=$P(^PRC(420,PRC("SITE"),1,+PRC("CP"),0),"^"),CPNAME=$E(CPNAME,1,30)
 S $P(^PRCS(410,DA,3),"^")=CPNAME
 S $P(^PRCS(410,DA,0),"^",2)="A",$P(^PRCS(410,DA,0),"^",4)=2,$P(^PRCS(410,DA,1),"^",3)="ST"
 S DA(1)=DA,DIC("P")=$P(^DD(410,60,0),"^",2),DIC="^PRCS(410,DA(1),""CO"","
 S DLAYGO=410,DIC(0)="LX",X=COMMENT D ^DIC
 L -^PRCS(410,DA)
 ;update 420 balance here
 S A=PRC("SITE")_"^"_+PRC("CP")_"^"_PRC("FY")_"^"_PRC("QTR")_"^"_AMOUNT
 D EBAL^PRCSEZ(A,"O"),EBAL^PRCSEZ(A,"C")
 K DIC,DLAYGO,DA QUIT
CREATE(STRING) ;create CP for user, return -1 if none created
 Q:'$D(STRING)
 N STATION,FUND,AO,OCP,OBJC,BFY,JOB,PROG,A,B,X,Y
 S X=$P(STRING,"-",2) K %DT D ^%DT
 S STATION=$P(STRING,"-"),BFY=$E(Y,1,3)+1700,FUND=$P(STRING,"-",3),AO=$P(STRING,"-",4),OCP=$P(STRING,"-",5),PROG=$E(OCP,1,4)
 S (OBJC,JOB)=""
 S:FUND="0151A7" PROG=9999 S:FUND="0151A1" PROG=9999 S:FUND="0151A7" OBJC=21 S:FUND="0151A1" OBJC=26
 S:OCP=971 PROG="MOD"
 S A=STATION_"~"_BFY_"~"_FUND_"~"_AO_"~"_PROG_"~"_OCP_"~"_OBJC_"~"_JOB
 S B=$$FIRST^PRC0B1("^PRCD(420.141,""B"","""_A_""",",0)
 I 'B S B=-1 QUIT B
 S B=+$P(^PRCD(420.141,B,0),"^",2),B=$P($G(^PRC(420,STATION,1,B,0)),"^")
 QUIT B
