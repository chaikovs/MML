function Result=HU256_CalculateCorrCur(OrbitStructFullName, RefStName)
    
    global HU256CELL;
    global BEAMLINENAME;

    BPMToSkip = -1;
    if (HU256CELL==4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% A CHANGER !!
        CalibrationDirectory='/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2006_10_13/CorrectorsResponseMeasurements';
    elseif (HU256CELL==12)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% A CHANGER !!
        CalibrationDirectory='/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2006_10_13/CorrectorsResponseMeasurements';
    elseif (HU256CELL==15)
        CalibrationDirectory='/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2006_10_13/CorrectorsResponseMeasurements';
    else
        fprintf('Problem in HU256_CalculateCorrCur -> HU256Cell must be :\n    4 (PLEIADES)\n    12 (ANTARES)\nor  15 (CASSIOPEE)\n')
        return
    end
    
    [mCorRespX, mCorRespZ] = idCalcCorRespMatr(['HU256_' BEAMLINENAME], 1, CalibrationDirectory);
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
    %Avant modif : Result=[Bxc1, Bzc1, Bxc28, Bzc27];
    Result=[CVE, CHE, CVS, CHS];
