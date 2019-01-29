function Res=Test_getBzmAp(BZPCurrent, BzmNumber)
    global SENSEOFCURRENT;
    global HU256CELL;
    SENSEOFCURRENT=1;
    HU256CELL=15;
    Res=HU256_GetBzmCurrentForAperiodic_modif(BZPCurrent, BzmNumber);