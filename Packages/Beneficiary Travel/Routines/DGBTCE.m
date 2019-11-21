DGBTCE ;ALB/SCK/BLD,LAB - BENEFICIARY TRAVEL CLAIM RE-ENTER/EDIT ;03/20/2019
 ;;1.0;Beneficiary Travel;**2,14,17,20,30,37**;September 25, 2001;Build 1
 Q
SCREEN ;
 D QUIT^DGBTCE1
 S DGBTTOUT=""
 D SCREEN^DGBTEE1 Q:'$D(^DGBT(392,DGBTDT,0))  I DGBTTOUT=-1 S DGBTTOUT=1 Q
 I $D(DGBTOACT) I DGBTOACT'=DGBTACCT S DGBTVAR(0)=^DGBT(392,DGBTDT,0) D FILE
 S (DGBTMAL,DGBTFAB,DGBTME,DGBTCP,DGBTFLAG,DGBTDE,DGBTDCV,DGBTDCM,DGBTDPV,DGBTDPM)=0
 S:$G(DGBTACCT)'>0 DGBTACCT=$P($G(DGBTVAR(0)),U,6)
 I DGBTACCT=4!(DGBTACCT=5) I $$ABP^DGBTUTL(DFN) W !!,"*ALERT: Patient has an active bus pass, which expires on ",$$FMTE^XLFDT($$ABP^DGBTUTL(DFN)),".",! S DIR("A")="Press RETURN to continue",DIR(0)="E" D ^DIR K DIR ;20
 S DGBTAP=VADM(1),DIE="^DGBT(392,",DA=DGBTDT,DR=$S(DGBTACCT=4:"42//"_DGBTAP,DGBTACCT=5:"43;S DGBTCP=X;42//"_DGBTAP,1:"44")
 D ^DIE K DIE,DQ,DR I $D(DTOUT)!($D(Y)) S DGBTTOUT=1 Q
 I DGBTACCT=4!(DGBTACCT=5) S:$D(DGBTVAR("M")) DGBTWAY=$P(DGBTVAR("M"),"^"),DGBTMILE=$P(DGBTVAR("M"),"^",2) S:$D(DGBTVAR("D")) DGBTCITY=$P(DGBTVAR("D"),"^",4),DGBTSTAT=$P(DGBTVAR("D"),"^",5)
 S DGBTDIV=$P($G(^DGBT(392,DA,0)),U,11),DGBTRMK=$S($D(DGBTREC):$$DICLKUP^DGBTUTL(DGBTREC,DGBTDIV,4),1:"")
 S DIE="^DGBT(392,",DA=DGBTDT
 ;DGBT*1.0*37 replace 4 slashes 3///' the ' allows for the internal value of a pointer to be validated and pushed
 S DR="3///`"_DGBTELIG_";6///`"_DGBTACTN_";21;I X="""" S Y=24;22;I X="""" S Y=24;23;24;24.1;24.2;25;I X="""" S Y=28;26;I X="""" S Y=28;27;28;28.1;28.2"
 D ^DIE K DIE I $D(DTOUT)!($D(Y)) S DGBTTOUT=1 Q
 W:DGBTRMK]"" !!,*7,"MILEAGE REMARKS: ",DGBTRMK,!
 I DGBTACCT=4!(DGBTACCT=5) D  Q:$G(DGBTTOUT)
 .I $G(MONTOT)'="" N OTRIPTYP S OTRIPTYP=$$GET1^DIQ(392,DGBTDT,31,"I")
 . S DR="31//;S DGBTOWRT=X;32//;S DGBTML=X"
 . I DGBTACCT=5&(DGBTCP=1) S DGBTMR=DGBTMR1
 . S DIE="^DGBT(392,",DA=DGBTDT
 . D ^DIE K DIE,DQ,DR I $D(DTOUT)!($D(Y)) S DGBTTOUT=1
 .I ($G(MONTOT)'="")&($G(OTRIPTYP)'=$$GET1^DIQ(392,DGBTDT,31,"I")) D
 ..N NTRIPTYP S NTRIPTYP=$$GET1^DIQ(392,DGBTDT,31,"I")
 ..I (OTRIPTYP=1)&(NTRIPTYP=2) D  Q
 ...S $P(MONTOT,U)=$P(MONTOT,U)+1
 ...S $P(MONTOT,U,2)=$P(MONTOT,U,2)-1
 ...S $P(MONTOT,U,3)=$P(MONTOT,U,3)+1
 ..I (OTRIPTYP=2)&(NTRIPTYP=1) D  Q
 ...S $P(MONTOT,U)=$P(MONTOT,U)-1
 ...S $P(MONTOT,U,2)=$P(MONTOT,U,2)+1
 ...S $P(MONTOT,U,3)=$P(MONTOT,U,3)-1
 . N MODE S DIR(0)="Y",DIR("B")=$S($D(^DGBT(392,DGBTDT,"C")):"YES",1:"NO"),DIR("A")="COMMON CARRIER USED" D ^DIR K DIR S MODE=Y I $D(DIRUT),$G(DUOUT) S DGBTTOUT=-1 Q  ;20
 . I 'MODE,$D(^DGBT(392,DGBTDT,"C")) S $P(^DGBT(392,DGBTDT,"A"),"^",4)="" F I="B","C"  K ^DGBT(392,DGBTDT,I)
 . I $$GET1^DIQ(392,DGBTDT,44)'=""!($G(MODE)) S DIE="^DGBT(392,",DA=DGBTDT,DR="44COMMON CARRIER MODE" D ^DIE  I $D(Y) S DGBTTOUT=1 Q  ;20
 . S DIE="^DGBT(392,",DA=DGBTDT I $$UP^XLFSTR($$GET1^DIQ(392,DGBTDT,44))["BUS" S DR="52R;I X'=""P"" S Y="""";53R" D ^DIE I $D(Y) S DGBTTOUT=1 Q  ;20
 . I $$GET1^DIQ(392,DGBTDT,44)'="" S DIE="^DGBT(392,",DA=DGBTDT,DR="54;55;55.1" D ^DIE I $D(Y) S DGBTTOUT=1 Q  ;20
DIE1 ;
 S DGBTMLT=$S($D(DGBTVAR("M"))&((DGBTACCT=4)!(DGBTACCT=5)):$J((DGBTOWRT*DGBTML*DGBTMR),0,2),1:""),$P(^DGBT(392,DGBTDT,"M"),"^",3)=DGBTMLT,$P(DGBTVAR("M"),"^",3)=DGBTMLT
 ;
 S DIE="^DGBT(392,",DA=DGBTDT
 I 'DGBTCORE D
 . S DR="I DGBTACCT=4!(DGBTACCT=5) S Y=""@1"";41;7;@1;I DGBTMLFB=0 S Y=""@2"";34//;S DGBTMAL=X;35//;S DGBTFAB=X;@2;8//;S DGBTME=X"
 I DGBTCORE S DR="" D
 . S DR(1,392,1)="I DGBTACCT=4!(DGBTACCT=5) S Y=""@1"";41;@3;14;S DGBTCSL=$$AFTER^DGBTCSL(392,D0,X,$G(DGBTPRV)) S:DGBTCSL<1 Y=""@3"" W:DGBTCSL<1 ""   Required"" K DGBTPRV,DGBTCSL;"
 . S DR(1,392,2)="@1;I DGBTMLFB=0 S Y=""@2"";34//;S DGBTMAL=X;35//;S DGBTFAB=X;@2;8//;S DGBTME=X"
DIE3 ;
 D ^DIE K DIE,DQ,DR I $D(DTOUT)!($D(Y)) S DGBTTOUT=1 Q
 ;
TCOST ;CALCULATE TOTAL COST AND MONTHLY CUM. DEDUCTIBLE
MLFB ;
 S DGBTMAF=$S(DGBTMLFB:DGBTMAL+DGBTFAB,1:0),DGBTMETC=DGBTME+$S($D(DGBTMAL):DGBTMAL,1:0)
 I DGBTACCT'=4&(DGBTACCT'=5) S DGBTPA=DGBTMAF+DGBTME G CONT
 I $D(DGBTMLT) S DGBTTC=$S(DGBTMLT+DGBTMAF'>DGBTMETC:DGBTMLT+DGBTMAF,DGBTMLT+DGBTMAF>DGBTMETC&(DGBTME>0):DGBTMETC,DGBTME'>0:DGBTMLT+DGBTMAF,1:DGBTMETC)
 I DGBTACCT=5 S DGBTDE=0 S DGBTPA=$S((DGBTMLT+DGBTMAF)'=0:DGBTTC,1:DGBTMETC) G CONT
DED ;
 I $G(MONTOT)'="" N ODED S ODED=$$GET1^DIQ(392,DGBTDT,9)
 F I=$E(DGBTDT,1,5)_"00.2399":0 S I=$O(^DGBT(392,"C",DFN,I)) Q:'I!($E(I,1,5)>$E(DGBTDT,1,5))  I I'=DGBTDT S DGBTDCM=DGBTDCM+($P(^DGBT(392,I,0),"^",9))
 I $D(^DG(43.1,$O(^DG(43.1,(9999999.99999-DGBTDT))),"BT")) S DGBTRATE=^("BT"),DGBTDPV=$P(DGBTRATE,"^"),DGBTDPM=$P(DGBTRATE,"^",2),DGBTMR=$P(DGBTRATE,"^",3)
 I $D(^DGBT(392,DGBTDT,"M")) S:$P(^("M"),"^")=1 DGBTDPV=DGBTDPV/2 I DGBTWAY'=$P(^("M"),"^")!(DGBTMILE'=$P(^("M"),"^",2)) I $D(^DGBT(392,DGBTDT,0)) S $P(^(0),"^",9)="" K ^DGBT(392,"AD",$P(^(0),"^",2),$E(DGBTDT,2,5),DGBTDT)
 S DGBTDRM=DGBTDPM-DGBTDCM
 I DGBTDRM<0 S DGBTDRM=0
 I DGBTDE<0 S DGBTDE=0
 S DGBTDCV=$S(DGBTDCM'<DGBTDPM:0,DGBTDRM'<DGBTDPV&(DGBTTC'<DGBTDPV):DGBTDPV,DGBTDRM'<DGBTDPV&(DGBTTC'>DGBTDPV):DGBTTC,DGBTDRM'>DGBTDPV&(DGBTTC'>DGBTDRM):DGBTTC,DGBTDRM'>DGBTDPV&(DGBTTC'<DGBTDRM):DGBTDRM,1:0)
 I $P(MONTOT,"^",5)="YES"&('$G(CHZFLG)) S DGBTDCV=0 ;*30 modified to preserve waiver status of existing claims
DED1 ;
 S DR="I $P(^DGBT(392,DGBTDT,0),""^"",9)]"""" S Y=""@9"";9///"_DGBTDCV_";@9;9;S DGBTDE=X S:DGBTDE>DGBTTC DGBTDE=DGBTTC,DGBTFLAG=2 S:DGBTDE>DGBTDRM DGBTDE=DGBTDRM,DGBTFLAG=1"
DIE4 ;
 I $G(^DGBT(392,DGBTDT,0))'="" D
 .I $P(^DGBT(392,DGBTDT,0),U,9)="" S $P(^DGBT(392,DGBTDT,0),U,9)=+$G(DGBTDCV)
 S DIE="^DGBT(392,",DA=DGBTDT D ^DIE K DIE,DQ,DR I $D(DTOUT)!($D(Y)) S DGBTTOUT=1 Q
 I ($G(MONTOT)'="")&($G(ODED)'=DGBTDE) D
 .S $P(MONTOT,U,4)=$P(MONTOT,U,4)+DGBTDE
 .S $P(MONTOT,U,4)=$P(MONTOT,U,4)-ODED
CONT ;
 D CONT^DGBTCE1
 Q
FILE ;      Reset values if account changes
 S DGBTVAR(0)=$P(DGBTVAR(0),"^",1,6)_"^^0^^"_$S($L(DGBTVAR(0),"^")>10:$P(DGBTVAR(0),"^",10,$L(DGBTVAR(0),"^")),1:""),DGBTVAR("A")="^"_$P(DGBTVAR("A"),"^",2)_"^^^"_$S($L(DGBTVAR("A"),"^")>4:$P(DGBTVAR("A"),"^",5,$L(DGBTVAR("A"),"^")),1:"")
 I DGBTACCT<4 S DGBTVAR("M")="^^^"_$S($L(DGBTVAR("M"),"^")>3:$P(DGBTVAR("M"),"^",4,$L(DGBTVAR("M"),"^")),1:"")
 S ^DGBT(392,DGBTDT,0)=DGBTVAR(0),^("A")=DGBTVAR("A") S:DGBTACCT<4 ^("M")=DGBTVAR("M") S DA=DGBTDT,DIK="^DGBT(392," D IX^DIK
 Q
