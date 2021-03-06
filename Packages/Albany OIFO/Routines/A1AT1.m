A1AT1 ; TRAVEL PACKAGE ; JCK/ALB ; 20 MAY 87
 ;VERSION 1.0
 ;THIS RTN CALCULATES & PRINTS ALL TRAVEL TOTALS FOR THE YEAR
 ;
INIT ;Initialize globals
 K ^UTILITY("A1ATPKG")
 ;
START ;Obtain all name & name reference locations
 F FQ=0:0 S FQ=$N(^DIZ(11669,"C",FQ)) Q:FQ'>0  F NMREF=0:0 S NMREF=$N(^DIZ(11669,"C",FQ,NMREF)) Q:NMREF'>0  S NAME=$P(^DIZ(11669,NMREF,0),"^",1) F FQNODE=0:0 S FQNODE=$N(^DIZ(11669,"C",FQ,NMREF,FQNODE)) Q:FQNODE'>0  D COSTS
 D GDTOT,PRINT,EXIT Q
 ;
COSTS ;Obtain all destination & cost values
 F DESTNODE=0:0 S DESTNODE=$N(^DIZ(11669,NMREF,1,FQNODE,1,DESTNODE)),ACTCST=$S($D(^DIZ(11669,NMREF,1,FQNODE,1,DESTNODE,2)):$P(^(2),"^",3),1:0) G:DESTNODE'>0 FQTOT Q:DESTNODE'>0  D NAMTOT
 Q
 ;
 ;
NAMTOT ; Calculate FQ totals per person
 I '$D(^UTILITY("A1ATPKG","FQTOT",NAME,FQ)) S ^(FQ)=0
 S ^UTILITY("A1ATPKG","FQTOT",NAME,FQ)=^UTILITY("A1ATPKG","FQTOT",NAME,FQ)+ACTCST Q
 ;
FQTOT ;Calculate all Grand Fiscal totals per quarter
 I '$D(^UTILITY("A1ATPKG","GD FQTOT",FQ)) S ^(FQ)=0
 S ^UTILITY("A1ATPKG","GD FQTOT",FQ)=^UTILITY("A1ATPKG","GD FQTOT",FQ)+^UTILITY("A1ATPKG","FQTOT",NAME,FQ)
 ;
 ;Calculate yearly totals per person
 I '$D(^UTILITY("A1ATPKG","YRTOT",NAME)) S ^(NAME)=0
 S ^UTILITY("A1ATPKG","YRTOT",NAME)=^UTILITY("A1ATPKG","YRTOT",NAME)+^UTILITY("A1ATPKG","FQTOT",NAME,FQ) Q
 Q
 ;
GDTOT ;Calculate grand yearly total
 I '$D(^UTILITY("A1ATPKG","GD YRTOT")) S ^("GD YRTOT")=0
 F TOT=1:1:4 S ^UTILITY("A1ATPKG","GD YRTOT")=^UTILITY("A1ATPKG","GD YRTOT")+$S($D(^UTILITY("A1ATPKG","GD FQTOT",TOT)):^(TOT),1:0)
 Q
 ;
 ;
PRINT ;Print heading & Travel results
 Q
 ;
EXIT ;Delete variables & quit
 ;
