function Result=HU256_CalculateCorrCur(OrbitStructFullName, RefStName)
    
    BPMToSkip = -1;

    [mCorRespX, mCorRespZ] = idCalcCorRespMatr('HU256_CASSIOPEE', 1, '/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2006_10_13/CorrectorsResponseMeasurements');
    StMeas=load(OrbitStructFullName);
    X=StMeas.X;
    Z=StMeas.Z;
    RefStMeas=load(RefStName);
    XR=RefStMeas.X;
    ZR=RefStMeas.Z;
    ResV=-idLeastSqLinFit(mCorRespZ, Z-ZR, BPMToSkip);
    Bxc1=ResV(1);
    Bxc28=ResV(2);
    ResV=-idLeastSqLinFit(mCorRespX, X-XR, BPMToSkip);
    Bzc1=ResV(1);
    Bzc27= ResV(2);
    %Result=[Bxc1, Bxc28, Bzc1, Bzc27];
    Result=[Bzc1, Bzc27, Bxc1, Bxc28];
