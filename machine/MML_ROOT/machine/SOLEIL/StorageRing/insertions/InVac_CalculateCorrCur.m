function Result=InVac_CalculateCorrCur(UndName,OrbitStructFullName, RefStName)


    
    % BPMToSkip = -1;
    BPMToSkip = [35 78]; % rajoute par FM 09 03 2015 pour tenir compte des BPM HS a ce jour
    global CHE
    global CHS
    global CVE
    global CVS
    [mCorRespX, mCorRespZ] = InVac_CalcCorRespMatr(UndName, 0, ['/home/data/GMI/' UndName]);

    %[mCorRespX, mCorRespZ] = idCalcCorRespMatr('HU640_DESIRS', 0, '/home/data/GMI/HU640_DESIRS/CORRECTEURS_ACTIFS');
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
