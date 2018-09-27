function Res=Test_getBzmAp(BzmNumber)
    global SENSEOFCURRENT;

    SENSEOFCURRENT=1;
    N=11;
    
    for tu=1:1:N
        BZP=20*(tu-1);
        Bzm=HU256_GetBzmCurrentForAperiodic(BZP, BzmNumber);
%         xu(tu)=BZP;
        Vu_1(tu)=BZP;
        Vu_2(tu)=Bzm;
    end
        
    SENSEOFCURRENT=-1;

    for td=1:1:N-1
        BZP=20*(N-1-td);
        Bzm=HU256_GetBzmCurrentForAperiodic(BZP, BzmNumber);
%         xd(td)=BX1;
        Vd_1(td)=BZP;
        Vd_2(td)=Bzm;
    end
    V_1=[Vu_1 Vd_1];
    V_2=[Vu_2 Vd_2];
%     V_3=0.8*V_1;
%     t=[tu td];
    t=1:1:2*N-1;
    
    plot (t, V_1, 'k-', t, V_2, 'b-');
    [t; V_1; V_2]