IBDEI0WG ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15772,1,5,0)
 ;;=5^HIV + Status (Asymptomatic)
 ;;^UTILITY(U,$J,358.3,15772,2)
 ;;=HIV + Status (Asymptomatic)^303392
 ;;^UTILITY(U,$J,358.3,15773,0)
 ;;=042.^^81^947^25
 ;;^UTILITY(U,$J,358.3,15773,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15773,1,4,0)
 ;;=4^042.
 ;;^UTILITY(U,$J,358.3,15773,1,5,0)
 ;;=5^HIV Disease (symptomatic)
 ;;^UTILITY(U,$J,358.3,15773,2)
 ;;=HIV Disease (symptomatic)^266500
 ;;^UTILITY(U,$J,358.3,15774,0)
 ;;=464.00^^81^947^2
 ;;^UTILITY(U,$J,358.3,15774,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15774,1,4,0)
 ;;=4^464.00
 ;;^UTILITY(U,$J,358.3,15774,1,5,0)
 ;;=5^Acute Laryngitis
 ;;^UTILITY(U,$J,358.3,15774,2)
 ;;=Acute Laryngitis^323469
 ;;^UTILITY(U,$J,358.3,15775,0)
 ;;=790.6^^81^947^1
 ;;^UTILITY(U,$J,358.3,15775,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15775,1,4,0)
 ;;=4^790.6
 ;;^UTILITY(U,$J,358.3,15775,1,5,0)
 ;;=5^Abnormal LFT's
 ;;^UTILITY(U,$J,358.3,15775,2)
 ;;=^87228
 ;;^UTILITY(U,$J,358.3,15776,0)
 ;;=780.60^^81^947^20
 ;;^UTILITY(U,$J,358.3,15776,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15776,1,4,0)
 ;;=4^780.60
 ;;^UTILITY(U,$J,358.3,15776,1,5,0)
 ;;=5^Fever
 ;;^UTILITY(U,$J,358.3,15776,2)
 ;;=^336764
 ;;^UTILITY(U,$J,358.3,15777,0)
 ;;=795.51^^81^947^55
 ;;^UTILITY(U,$J,358.3,15777,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15777,1,4,0)
 ;;=4^795.51
 ;;^UTILITY(U,$J,358.3,15777,1,5,0)
 ;;=5^Pos PPD w/o Active TB
 ;;^UTILITY(U,$J,358.3,15777,2)
 ;;=^340572
 ;;^UTILITY(U,$J,358.3,15778,0)
 ;;=482.9^^81^947^53
 ;;^UTILITY(U,$J,358.3,15778,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15778,1,4,0)
 ;;=4^482.9
 ;;^UTILITY(U,$J,358.3,15778,1,5,0)
 ;;=5^Pneumonia,Bacterial
 ;;^UTILITY(U,$J,358.3,15778,2)
 ;;=^12347
 ;;^UTILITY(U,$J,358.3,15779,0)
 ;;=571.42^^81^947^31
 ;;^UTILITY(U,$J,358.3,15779,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15779,1,4,0)
 ;;=4^571.42
 ;;^UTILITY(U,$J,358.3,15779,1,5,0)
 ;;=5^Hepatitis, Autoimunne
 ;;^UTILITY(U,$J,358.3,15779,2)
 ;;=^336610
 ;;^UTILITY(U,$J,358.3,15780,0)
 ;;=795.52^^81^947^54
 ;;^UTILITY(U,$J,358.3,15780,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15780,1,4,0)
 ;;=4^795.52
 ;;^UTILITY(U,$J,358.3,15780,1,5,0)
 ;;=5^Pos GMA Interferon w/o Active TB
 ;;^UTILITY(U,$J,358.3,15780,2)
 ;;=^340573
 ;;^UTILITY(U,$J,358.3,15781,0)
 ;;=682.0^^81^948^6
 ;;^UTILITY(U,$J,358.3,15781,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15781,1,4,0)
 ;;=4^682.0
 ;;^UTILITY(U,$J,358.3,15781,1,5,0)
 ;;=5^Cellulitis Of Face
 ;;^UTILITY(U,$J,358.3,15781,2)
 ;;=^271888
 ;;^UTILITY(U,$J,358.3,15782,0)
 ;;=681.00^^81^948^7
 ;;^UTILITY(U,$J,358.3,15782,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15782,1,4,0)
 ;;=4^681.00
 ;;^UTILITY(U,$J,358.3,15782,1,5,0)
 ;;=5^Cellulitis Of Finger NOS
 ;;^UTILITY(U,$J,358.3,15782,2)
 ;;=^271883
 ;;^UTILITY(U,$J,358.3,15783,0)
 ;;=682.7^^81^948^8
 ;;^UTILITY(U,$J,358.3,15783,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15783,1,4,0)
 ;;=4^682.7
 ;;^UTILITY(U,$J,358.3,15783,1,5,0)
 ;;=5^Cellulitis Of Foot
 ;;^UTILITY(U,$J,358.3,15783,2)
 ;;=^271895
 ;;^UTILITY(U,$J,358.3,15784,0)
 ;;=682.4^^81^948^9
 ;;^UTILITY(U,$J,358.3,15784,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15784,1,4,0)
 ;;=4^682.4
 ;;^UTILITY(U,$J,358.3,15784,1,5,0)
 ;;=5^Cellulitis Of Hand
 ;;^UTILITY(U,$J,358.3,15784,2)
 ;;=^271892
 ;;^UTILITY(U,$J,358.3,15785,0)
 ;;=682.6^^81^948^10
 ;;^UTILITY(U,$J,358.3,15785,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,15785,1,4,0)
 ;;=4^682.6
 ;;^UTILITY(U,$J,358.3,15785,1,5,0)
 ;;=5^Cellulitis Of Leg
 ;;^UTILITY(U,$J,358.3,15785,2)
 ;;=^271894
 ;;^UTILITY(U,$J,358.3,15786,0)
 ;;=682.1^^81^948^11
 ;;
 ;;$END ROU IBDEI0WG
