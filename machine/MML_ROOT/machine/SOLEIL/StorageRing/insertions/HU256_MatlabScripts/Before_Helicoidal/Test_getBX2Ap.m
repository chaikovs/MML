function Res=Test_getBX2Ap()
    global SENSEOFCURRENT;

    SENSEOFCURRENT=1;
    N=11;
    
    for tu=1:1:N
        BX1=25*(tu-1);
        BX2=HU256_GetBX2CurrentForAperiodic(BX1);
        xu(tu)=BX1;
        Vu_1(tu)=BX1;
        Vu_2(tu)=BX2;
    end
        
    SENSEOFCURRENT=-1;

    for td=1:1:N-1
        BX1=25*(N-1-td);
        BX2=HU256_GetBX2CurrentForAperiodic(BX1);
        xd(td)=BX1;
        Vd_1(td)=BX1;
        Vd_2(td)=BX2;
    end
    V_1=[Vu_1 Vd_1];
    V_2=[Vu_2 Vd_2];
    V_3=0.8*V_1;
%     t=[tu td];
    t=1:1:2*N-1;
    
    plot (t, V_1, 'k-', t, V_2, 'b-', t, V_3, 'r-');