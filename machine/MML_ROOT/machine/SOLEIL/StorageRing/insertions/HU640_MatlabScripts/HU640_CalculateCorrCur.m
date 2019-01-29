function Result=HU640_CalculateCorrCur(OrbitStructFullName, RefStName)


    
    BPMToSkip = -1;
    global CHE
    global CHS
    global CVE
    global CVS
    [mCorRespX, mCorRespZ] = HU640_CalcCorRespMatr('HU640_DESIRS', 0, '/home/data/GMI/HU640_DESIRS/CORRECTEURS_ACTIFS');

    %[mCorRespX, mCorRespZ] = idCalcCorRespMatr('HU640_DESIRS', 0, '/home/operateur/GrpGMI/HU640_DESIRS/CORRECTEURS_ACTIFS');
    StMeas=load(OrbitStructFullName);
    X=StMeas.X;
    Z=StMeas.Z;
    RefStMeas=load(RefStName);
    XR=RefStMeas.X;
    ZR=RefStMeas.Z;
    ResV=-idLeastSqLinFit(mCorRespZ, Z-ZR, BPMToSkip);
    CVE=ResV(1);
    CVS=ResV(2);
    ResV=-idLeastSqLinFit(mCorRespX, X-XR, BPMToSkip);
    CHE=ResV(1);
    CHS= ResV(2);
    
    Result=[CHE, CHS, CVE, CVS];
