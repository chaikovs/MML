function Result=HU256_CalculateCorrCur(OrbitStructFullName, RefStName)
    

    global HU256CELL;
    global BEAMLINENAME;
    fprintf('HU256_CalculateCorrCur -> BEAMLINENAME : %s\n', BEAMLINENAME)
    
    BPMToSkip = -1;
    if (HU256CELL==4)
        %CalibrationDirectory='/home/operateur/GrpGMI/HU256_PLEIADES/SESSION_2007_04_27/Calibration_correcteurs';
        CalibrationDirectory='/home/data/GMI/HU256_PLEIADES/SESSION_2016_09_12';
    elseif (HU256CELL==12)
        %CalibrationDirectory='/home/operateur/GrpGMI/HU256_ANTARES/SESSION_2007_06_05';
        CalibrationDirectory='/home/operateur/GrpGMI/HU256_ANTARES/SESSION_2007_06_07/Calibration3(bonne)';
    elseif (HU256CELL==15)
        CalibrationDirectory='/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2006_10_13/CorrectorsResponseMeasurements';
    else
        fprintf('Problem in HU256_CalculateCorrCur -> HU256Cell must be :\n    4 (PLEIADES)\n    12 (ANTARES)\nor  15 (CASSIOPEE)\n')
        return
    end
    fprintf('BEAMLINENAME : %s\tidName : %s\n', BEAMLINENAME, ['HU256_' BEAMLINENAME])
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
