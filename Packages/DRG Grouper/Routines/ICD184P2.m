ICD184P2 ;BPOIFO/ESW - ICD/DIAGNOSIS ; 10/17/02 3:58pm
 ;;18.0;DRG Grouper;**4**;Oct 13,2000
 ;
 Q
 ;
ADDDIAG ; Add New Diagnoses (info taken from Fed Reg Table 6A)
 ;;
 N DIC,LINE,X,Y,ICDDIAG,DIAG,DESC,MDC,IDENT,CC,SEX,DRG,DRG1,DRG2,DRG3,DRG4,DRG5,DRG6,ECODE,CNT S CNT=0
 D BMES^XPDUTL(">>>Adding new diagnoses-Please verify that 82 added")
 F LINE=1:1 S X=$T(DIAG+LINE) S ICDDIAG=$P(X,";;",2) Q:ICDDIAG="EXIT"  D
 .S DIC="^ICD9(",DIC(0)="L"
 .S DIAG=$P(ICDDIAG,U,2) I DIAG="" S DIAG=$P(ICDDIAG,U,3)
 .S DESC=$P(ICDDIAG,U,3),MDC=$P(ICDDIAG,U,5)
 .S CC="" I $P(ICDDIAG,U,4)="Y" S CC=1
 .S ECODE=$P(ICDDIAG,U,8)
 .S DRG=$P(ICDDIAG,U,6),SEX=$P(ICDDIAG,U,7)
 .S (DRG1,DRG2,DRG3,DRG4,DRG5,DRG6)=""
 .S DRG1=$P(DRG,"~",1) I $P(DRG,"~",2) S DRG2=$P(DRG,"~",2) I $P(DRG,"~",3) S DRG3=$P(DRG,"~",3) I $P(DRG,"~",4) S DRG4=$P(DRG,"~",4) I $P(DRG,"~",5) S DRG5=$P(DRG,"~",5) I $P(DRG,"~",6) S DRG6=$P(DRG,"~",6)
 .S IDENT=""
 .S DIC("DR")="2///"_IDENT_";3///"_DIAG_";5///"_MDC_";9.5///"_SEX_";10///"_DESC_";60///"_DRG1_";61///"_DRG2_";62///"_DRG3_";63///"_DRG4_";64///"_DRG5_";65///"_DRG6_";70///"_CC_";101///"_ECODE
 .S X=$P(ICDDIAG,U)
 .; check for duplicates in case install being re-run
 .I +$O(^ICD9("BA",X_" ",0)) Q
 .K DO D FILE^DICN
 .I Y=-1 Q
 .S CNT=CNT+1
 D BMES^XPDUTL(">>> "_CNT_" diagnoses were added")
 Q
DIAG ;New Diagnoses
 ;;040.82^^TOXIC SHOCK SYNDROME^Y^18^423
 ;;066.4^^WEST NILE FEVER^N^18^421~422
 ;;277.02^CYST FIBROS W/PULM MANIF^CYSTIC FIBROSIS WITH PULMONARY MANIFESTATIOS^Y^4^79~80~81
 ;;277.03^CYST FIBR W/GASTRO MANIF^CYSTIC FIBROSIS WITH GASTROINTESTINAL MANIFESTATIONS^Y^6^188~189~190
 ;;277.09^CYST FIBR W/OTHER MANIFE^CYSTIC FIBROSIS WITH OTHERMANIFESTATIONS^Y^10^296~297~298
 ;;357.81^CHRONIC INFL DEMYELIN POLYNEUR^CHRONIC INFLAMMATORY DEMYELINATING POLYNEURITIS.^N^1^18~19
 ;;357.82^CRITICAL ILLNESS POLYNEUROPATH^CRITICAL ILLNESS POLYNEUROPATHY^N^1^18~19
 ;;357.89^OTHER INFLAM & TOXIC NEROPATHY^OTHER INFLAMMATORY AND TOXIC NEUROPATHY^N^1^18~19
 ;;359.81^^CRITICAL ILLNESS MYOPATHY ^N^1^34~35
 ;;359.89^^OTHER MYOPATHIES ^N^1^34~35
 ;;365.83^^AQUEOUS MISDIRECTION ^N^2^46~47~48
 ;;414.06^COR ATHEROS COR ART OFT HEART^CORONARY ATHEROSCLEROSIS OF CORONARY ARTERY OFTRANSPLANTED HEART^N^5^132~133
 ;;414.12^^DISSECTION OF CORONARY ARTERY^N^5^121~144~145
 ;;428.20^UNSPEC SYSTOL HEART FAILURE^UNSPECIFIED SYSTOLIC HEART FAILURE^Y^5^115~121~124~127
 ;;428.21^^ACUTE SYSTOLIC HEART FAILURE^Y^5^115~121~124~127
 ;;428.22^^CHRONIC SYSTOLIC HEART FAILURE^Y^5^115~121~124~127
 ;;428.23^ACUTE ON CHRON SYST HEART FAIL^ACUTE ON CHRONIC SYSTOLIC HEART FAILURE^Y^5^115~121~124~127
 ;;428.30^UNSPEC DIASTOL HEART FAILURE^UNSPECIFIED DIASTOLIC HEART FAILURE^Y^5^115~121~124~127
 ;;428.31^^ACUTE DIASTOLIC HEART FAILURE^Y^5^115~121~124~127
 ;;428.32^CHRON DIASTOL HEART FAILURE^CHRONIC DIASTOLIC HEART FAILURE^Y^5^115~121~124~127
 ;;428.33^ACUTE ON CHRON DIAST HEART^ACUTE ON CHRONIC DIASTOLIC HEART FAILURE.^Y^5^115~121~124~127
 ;;428.40^UNSP COM SYST & DIAST HEART^UNSPECIFIED COMBINED SYSTOLIC AND DIASTOLIC HEART FAILURE.^Y^5^115~121~124~127
 ;;428.41^ACUTE COM SYST & DIAST HEART^ACUTE COMBINED SYSTOLIC AND DIASTOLIC HEART FAILURE.^Y^5^115~121~124~127
 ;;428.42^CHRON COM SYST & DIAST HEART^CHRONIC COMBINED SYSTOLIC AND DIASTOLIC HEART FAILURE.^Y^5^115~121~124~127
 ;;428.43^ACUT CHR COM SYST& DIAST HEART^ACUTE ON CHRONIC COMBINED SYSTOLIC AND DIASTOLIC HEART FAILURE^Y^5^115~121~124~127
 ;;438.6^^ALTERATIONS OF SENSATIONS^N^1^12
 ;;438.7^^DISTURBANCES OF VISION^N^1^12
 ;;438.83^^FACIAL WEAKNESS ^N^1^12
 ;;438.84^^ATAXIA ^N^1^12
 ;;438.85^^VERTIGO ^N^1^12
 ;;443.21^^DISSECTION OF CAROTID ARTERY ^N^5^130~131
 ;;443.22^^DISSECTION OF ILIAC ARTERY ^N^5^130~131
 ;;443.23^^DISSECTION OF RENAL ARTERY ^N^11^331~332~333
 ;;443.24^^DISSECTION OF VERTEBRAL ARTERY^N^5^130~131
 ;;443.29^^DISSECTION OF OTHER ARTERY ^N^5^130~131
 ;;445.01^^ATHEROEMBOLISM UPPER EXTREMITY^Y^5^130~131
 ;;445.02^^ATHEROEMBOLISM LOWER EXTREMITY^Y^5^130~131
 ;;445.81^^ATHEROEMBOLISM, KIDNEY ^Y^11^331~332~333
 ;;445.89^^ATHEROEMBOLISM, OTHER SITE ^Y^5^130~131
 ;;454.8^VARIC VEINS LOW EXTR W/OTHER^VARICOSE VEINS OF THE LOWER EXTREMITIES, WITH OTHER COMPLICATIONS^N^5^130~131
 ;;459.10^POSTPHL SYND W/O COMPLIC^POSTPHLEBETIC SYNDROME WITHOUT COMPLICATIONS^N^5^130~131
 ;;459.11^POSTPHLEB SYNDR W/ULCER^POSTPHLEBETIC SYNDROME WITH ULCER.^N^5^130~131
 ;;459.12^POSTPHL SYNDR W/INFLAMM^POSTPHLEBETIC SYNDROME WITH INFLAMMATION^N^5^130~131
 ;;459.13^POSTPHL SYNDR W/ULCER&INFLAMM^POSTPHLEBETIC SYNDROME WITH ULCER AND INFLAMMATION.^N^5^130~131
 ;;459.19^POSTPHL SYNDR W/OTHER^POSTPHLEBETIC SYNDROME WITH OTHER COMPLICATION.^N^5^130~131
 ;;459.30^CHRON VENOUS HYPERT W/O COMPL^CHRONIC VENOUS HYPERTENSION WITHOUT COMPLICATIONS^N^5^130~131
 ;;459.31^CHRON VENOUS HYPERT W/ULCER^CHRONIC VENOUS HYPERTENSION WITH ULCER^N^5^130~131
 ;;459.32^CHRON VENOUS HYPERT W/INFLAM^CHRONIC VENOUS HYPERTENSION WITH INFLAMMATION^N^5^130~131
 ;;459.33^CHR HYPERT W/ULCER&INFLAMM^CHRONIC VENOUS HYPERTENSION WITH ULCER AND INFLAMMATION^N^5^130~131
 ;;459.39^CHR VENOUS HYPERT W/OTHER^CHRONIC VENOUS HYPERTENSION WITH OTHER COMPLICATION^N^5^130~131
 ;;537.84^DIELUL LESION STOMACH&DUODEN^DIELULAFOY LESION (HEMORRHAGIC) OF STOMACH AND DUODENUM^Y^6^174~175
 ;;569.86^DIEUL LESION OF INTESTINE^DIEULAFOY LESION (HEMORRHAGIC) OF INTESTINE^Y^6^188~189~190
 ;;633.00^ABDOMIN PREGN W/O INTRAUT^ABDOMINAL PREGNANCY WITHOUT INTRAUTERINE PREGNANCY^N^14^378^F
 ;;633.01^ABDOM PREGN W/INTRAUTERINE^ABDOMINAL PREGNANCY WITH INTRAUTERINE PREGNANCY^N^14^378^F
 ;;633.10^TUBAL PREGN W/O INTRAUTER^TUBAL PREGNANCY WITHOUT INTRAUTERINE PREGNANCY^N^14^378^F
 ;;633.11^TUBAL PREGN W/INTRAUTERINE^TUBAL PREGNANCY WITH INTRAUTERINE PREGNANCY^N^14^378^F
 ;;633.20^OVARIAN PREGN W/O INTRAUTERIN^OVARIAN PREGNANCY WITHOUT INTRAUTERINE PREGNANCY^N^14^378^F
 ;;633.21^OVARIAN PREGN W/INTRUTERINE^OVARIAN PREGNANCY WITH INTRAUTERINE PREGNANCY^N^14^378^F
 ;;633.80^OTH ECTOPIC PREGN W/O INTRAUT^OTHER ECTOPIC PREGNANCY WITHOUT INTRAUTERINE PREGNANCY^N^14^378^F
 ;;633.81^OTH ECTOPIC PREGN W/INTRAUTER^OTHER ECTOPIC PREGNANCY WITH INTRAUTERINE PREGNANCY.^N^14^378^F
 ;;633.90^UNSPEC EXTOPIC PREGN W/O INTR^UNSPECIFIED ECTOPIC PREGNANCY WITHOUT INTRAUTERINE PREGNANCY.^N^14^378^F
 ;;633.91^UNSPEC ECTOPIC PREGN W/INTRA^UNSPECIFIED ECTOPIC PREGNANCY WITH INTRAUTERINE PREGNANCY.^N^14^378^F
 ;;747.83^^PERSISTENT FETAL CIRCULATION^N^15^387~389
 ;;765.20^^UNSPECIFIED WEEKS OF GESTATION^N^15^391
 ;;765.21^LESS THAN 34 WEEKS OF GESTAT^LESS THAN 24 COMPLETED WEEKS OF GESTATION.^N^15^386
 ;;765.22^24 COMPL WEEKS OF GESTATION^24 COMPLETED WEEKS OF GESTATION^N^15^386
 ;;765.23^25-26 COMPL WEEKS OF GESTATION^25-26 COMPLETED WEEKS OF GESTATION^N^15^386
 ;;765.24^27-28 COMPL WEEKS OF GESTATION^27-28 COMPLETED WEEKS OF GESTATION^N^15^387~388
 ;;765.25^29-30 COMPL WEEKS OF GESTATION^29-30 COMPLETED WEEKS OF GESTATION^N^15^387~388
 ;;765.26^31-32 COMPL WEEKS OF GESTATION^31-32 COMPLETED WEEKS OF GESTATION^N^15^387~388
 ;;765.27^33-34 COMPL WEEKS OF GESTATION^33-34 COMPLETED WEEKS OF GESTATION^N^15^387~388
 ;;765.28^35-36 COMPL WEEKS OF GESTATION^35-36 COMPLETED WEEKS OF GESTATION^N^15^387~388
 ;;765.29^37 OR MORE COMP WEEK OF GESTAT^37 OR MORE COMPLETED WEEKS OF GESTATION^N^15^391
 ;;770.81^^PRIMARY APNEA OF NEWBORN^N^15^390
 ;;770.82^^OTHER APNEA OF NEWBORN^N^15^390
 ;;770.83^^CYANOTIC ATTACKS OF NEWBORN^N^15^390
 ;;770.84^^RESPIRATORY FAILURE OF NEWBORN^Y^15^387~389
 ;;770.89^OTHER RESPIR PROBL AFTER BIRTH^OTHER RESPIRATORY PROBLEMS AFTER BIRTH^N^15^390
 ;;771.81^^SEPTICEMIA [SEPSIS] OF NEWBORN^Y^15^387~389
 ;;771.82^URIN TRACT INFEC IF NEWB^URINARY TRACT INFECTION OF NEWBORN^N^15^387~389
 ;;771.83^^BACTEREMIA OF NEWBORN^Y^15^387~389
 ;;771.89^INFECT PECIFIC TO PERINATAL^OTHER INFECTIONS SPECIFIC TO THE PERINATAL PERIOD^N^15^387~389
 ;;EXIT
 Q
 ;
