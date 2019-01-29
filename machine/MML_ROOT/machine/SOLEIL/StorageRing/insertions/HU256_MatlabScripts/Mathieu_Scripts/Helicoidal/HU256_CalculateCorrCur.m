function Result=HU256_CalculateCorrCur(OrbitStructFullName, RefStName)
%   Returns a vector containing the correction currents (in the order CVE, CHE, CVS, CHS)
%   The currents are calculated using 2 orbits acquisitions structures, which names (including path) are
%   OrbitStructFullName for orbit to correct, and RefStName for Reference orbit
%   Returns -1 if a problem accured
%   TESTWITHOUTBEAM=1; => no BPM measurement (replaced by random values between -10 and 10)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   New path for Oleg's scripts : /home/matlabML/machine/Soleil/StorageRing/insertions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    global HU256CELL;
    global BEAMLINENAME;
    global TESTWITHOUTBEAM;
    %HU256CELL=15;
    %BEAMLINE='CASSIOPEE';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    BPMToSkip = -1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    Result=-1;
    
    if (TESTWITHOUTBEAM~=1)
        if (HU256CELL==4)
            CalibrationDirectory='/home/operateur/GrpGMI/HU256_PLEIADES/SESSION_2007_04_27/Calibration_correcteurs';
        elseif (HU256CELL==12)
%             CalibrationDirectory='/home/operateur/GrpGMI/HU256_ANTARES/SESSION_2007_06_05';
            CalibrationDirectory='/home/operateur/GrpGMI/HU256_ANTARES/SESSION_2007_06_07/Calibration3(bonne)';
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
    else
        Result=zeros(1, 4);
        for i=1:4
            Value=rand(1);
            if (Value<0.5)
                Value=-Value;
            else
                Value=Value-0.5;
            end
            Value=Value*20;
            Result(i)=Value;
        end
    end
            
   