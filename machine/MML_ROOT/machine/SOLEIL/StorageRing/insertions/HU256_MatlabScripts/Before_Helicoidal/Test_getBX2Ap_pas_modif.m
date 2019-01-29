function Res=Test_getBX2Ap(BX1Current)
    global SENSEOFCURRENT;
    global HU256CELL;
    SENSEOFCURRENT=1;
    HU256CELL=15;
    
    Res=HU256_GetBX2CurrentForAperiodic_modif(BX1Current);