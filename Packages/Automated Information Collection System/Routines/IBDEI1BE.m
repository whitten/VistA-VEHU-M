IBDEI1BE ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23285,0)
 ;;=789.07^^125^1404^1
 ;;^UTILITY(U,$J,358.3,23285,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23285,1,4,0)
 ;;=4^789.07
 ;;^UTILITY(U,$J,358.3,23285,1,5,0)
 ;;=5^Abdominal Pain, Generalized
 ;;^UTILITY(U,$J,358.3,23285,2)
 ;;=^303324
 ;;^UTILITY(U,$J,358.3,23286,0)
 ;;=788.0^^125^1404^21
 ;;^UTILITY(U,$J,358.3,23286,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23286,1,4,0)
 ;;=4^788.0
 ;;^UTILITY(U,$J,358.3,23286,1,5,0)
 ;;=5^Kidney Pain
 ;;^UTILITY(U,$J,358.3,23286,2)
 ;;=^265306
 ;;^UTILITY(U,$J,358.3,23287,0)
 ;;=338.0^^125^1404^9
 ;;^UTILITY(U,$J,358.3,23287,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23287,1,4,0)
 ;;=4^338.0
 ;;^UTILITY(U,$J,358.3,23287,1,5,0)
 ;;=5^Central Pain Syndrome
 ;;^UTILITY(U,$J,358.3,23287,2)
 ;;=^334189
 ;;^UTILITY(U,$J,358.3,23288,0)
 ;;=338.11^^125^1404^6
 ;;^UTILITY(U,$J,358.3,23288,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23288,1,4,0)
 ;;=4^338.11
 ;;^UTILITY(U,$J,358.3,23288,1,5,0)
 ;;=5^Acute Pain due to Trauma
 ;;^UTILITY(U,$J,358.3,23288,2)
 ;;=^334070
 ;;^UTILITY(U,$J,358.3,23289,0)
 ;;=338.12^^125^1404^7
 ;;^UTILITY(U,$J,358.3,23289,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23289,1,4,0)
 ;;=4^338.12
 ;;^UTILITY(U,$J,358.3,23289,1,5,0)
 ;;=5^Acute Post-Operative Pain
 ;;^UTILITY(U,$J,358.3,23289,2)
 ;;=^334071
 ;;^UTILITY(U,$J,358.3,23290,0)
 ;;=338.18^^125^1404^31
 ;;^UTILITY(U,$J,358.3,23290,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23290,1,4,0)
 ;;=4^338.18
 ;;^UTILITY(U,$J,358.3,23290,1,5,0)
 ;;=5^Postoperative Pain NOS
 ;;^UTILITY(U,$J,358.3,23290,2)
 ;;=^334072
 ;;^UTILITY(U,$J,358.3,23291,0)
 ;;=338.19^^125^1404^26
 ;;^UTILITY(U,$J,358.3,23291,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23291,1,4,0)
 ;;=4^338.19
 ;;^UTILITY(U,$J,358.3,23291,1,5,0)
 ;;=5^Other Acute Pain
 ;;^UTILITY(U,$J,358.3,23291,2)
 ;;=^334073
 ;;^UTILITY(U,$J,358.3,23292,0)
 ;;=338.21^^125^1404^12
 ;;^UTILITY(U,$J,358.3,23292,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23292,1,4,0)
 ;;=4^338.21
 ;;^UTILITY(U,$J,358.3,23292,1,5,0)
 ;;=5^Chronic Pain due to Trauma
 ;;^UTILITY(U,$J,358.3,23292,2)
 ;;=^334074
 ;;^UTILITY(U,$J,358.3,23293,0)
 ;;=338.22^^125^1404^13
 ;;^UTILITY(U,$J,358.3,23293,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23293,1,4,0)
 ;;=4^338.22
 ;;^UTILITY(U,$J,358.3,23293,1,5,0)
 ;;=5^Chronic Post-Thoracotomy Pain
 ;;^UTILITY(U,$J,358.3,23293,2)
 ;;=^334075
 ;;^UTILITY(U,$J,358.3,23294,0)
 ;;=338.28^^125^1404^28
 ;;^UTILITY(U,$J,358.3,23294,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23294,1,4,0)
 ;;=4^338.28
 ;;^UTILITY(U,$J,358.3,23294,1,5,0)
 ;;=5^Other Chronic Postop Pain
 ;;^UTILITY(U,$J,358.3,23294,2)
 ;;=^334076
 ;;^UTILITY(U,$J,358.3,23295,0)
 ;;=338.29^^125^1404^27
 ;;^UTILITY(U,$J,358.3,23295,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23295,1,4,0)
 ;;=4^338.29
 ;;^UTILITY(U,$J,358.3,23295,1,5,0)
 ;;=5^Other Chronic Pain
 ;;^UTILITY(U,$J,358.3,23295,2)
 ;;=^334077
 ;;^UTILITY(U,$J,358.3,23296,0)
 ;;=338.3^^125^1404^8
 ;;^UTILITY(U,$J,358.3,23296,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23296,1,4,0)
 ;;=4^338.3
 ;;^UTILITY(U,$J,358.3,23296,1,5,0)
 ;;=5^Cancer Associated Pain
 ;;^UTILITY(U,$J,358.3,23296,2)
 ;;=^334078
 ;;^UTILITY(U,$J,358.3,23297,0)
 ;;=338.4^^125^1404^11
 ;;^UTILITY(U,$J,358.3,23297,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23297,1,4,0)
 ;;=4^338.4
 ;;^UTILITY(U,$J,358.3,23297,1,5,0)
 ;;=5^Chronic Pain Syndrome
 ;;^UTILITY(U,$J,358.3,23297,2)
 ;;=^334079
 ;;^UTILITY(U,$J,358.3,23298,0)
 ;;=780.96^^125^1404^17
 ;;^UTILITY(U,$J,358.3,23298,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,23298,1,4,0)
 ;;=4^780.96
 ;;
 ;;$END ROU IBDEI1BE
