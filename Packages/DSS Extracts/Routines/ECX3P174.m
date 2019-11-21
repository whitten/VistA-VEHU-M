ECX3P174 ;ALB/DAN - DSS FY2020 Conversion, Post-init ;6/17/19  11:28
 ;;3.0;DSS EXTRACTS;**174**;Dec 22, 1997;Build 33
 ;
POST ;Post-install items
 D TEST ;Set testing site information
 D MENU ;update menus
 Q
 ;
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2020")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option
 Q
 ;
MENU ;update menus
 N DA,DIE,DR,MENU,OPTION,CHECK,CHOICE,SYN,ORD,TYPE,OFF,UPDATE
 S TYPE="MENUDEL" F OFF=1:1 S CHOICE=$P($T(@TYPE+OFF),";;",2) Q:CHOICE="DONE"  D
 .S OPTION=$P(CHOICE,"^"),MENU=$P(CHOICE,"^",2)
 .S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 .D BMES^XPDUTL(">>> "_OPTION_" OPTION "_$S(CHECK:"REMOVED FROM ",1:"DOES NOT EXIST IN ")_MENU_" <<<")
 S TYPE="MENUADD" F OFF=1:1 S CHOICE=$P($T(@TYPE+OFF),";;",2) Q:CHOICE="DONE"  D
 .S OPTION=$P(CHOICE,"^"),MENU=$P(CHOICE,"^",2),SYN=$P(CHOICE,"^",3),ORD=$P(CHOICE,"^",4)
 .S CHECK=$$ADD^XPDMENU(MENU,OPTION,SYN,ORD)
 .D BMES^XPDUTL(">>> "_OPTION_" OPTION"_$S('CHECK:" NOT",1:"")_" ADDED TO "_MENU_" <<<")
 Q
 ;
MENUDEL ;Menu items to be deleted. Format is OPTION NAME^MENU TO BE REMOVED FROM
 ;;ECX LAB RESULTS TRANS EDIT^ECXLAB MAINTENACE
 ;;ECX UNTRANS LAR REPORT^ECXLAB MAINTENACE
 ;;ECX LAR LOINC RPT^ECXLAB MAINTENACE
 ;;ECXLAB MAINTENACE^ECX MAINTENANCE
 ;;DONE
MENUADD ;Menu items to be added. Format is OPTION NAME^MENU TO BE ADDED TO^SYNONYM^DISPLAY ORDER
 ;;ECX LAR LOINC RPT^ECX MAINTENANCE^LAB^4
 ;;ECXINDIV^ECX MAINTENANCE^DIV^7.5
 ;;ECX PHA COST AUDIT^ECX SOURCE AUDITS^PHA^8
 ;;DONE
