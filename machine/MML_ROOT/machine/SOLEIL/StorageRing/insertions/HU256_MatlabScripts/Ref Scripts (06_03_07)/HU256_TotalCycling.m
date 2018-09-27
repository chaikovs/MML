function res=HU256_TotalCycling(MainPowerSupplyName, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable)
    
    % This script can : - drive HU256 undulator along one cycle
    %                   - calculate correction tables along this cycle
    %                   - drive the correctors using a correction table
    % It uses the following files : - HU256_ExtractCorrCurrentsFromTable.m,
    %                               - HU256_GoOnCycling.m
    %                               - HU256_MainSetCurrent.m
    %                               - HU256_MeasElecBeam.m
    %                               - HU256_SetCorrectorsToZero.m
    %                               - HU256_SetCurrentSync.m
    %                               - HU256_SetCurrentSyncCorr.m
    %                               - HU256_CalculateCorrCur.m
    % Before using this script, you should check some details in these 4
    % scripts :
    % - HU256_GoOnCycling : * Min, Max and step of currents for PS1
    %                       * Min, Max and step of currents for PS2
    %                       * Min, Max and step of currents for PS3
    %                       * Relative tolerance on main power supplies
    %                       * Structure of the Orbit Acquisition created
    %                           filename
    % - HU256_SetCurrentSync and HU256_SetCurrentSyncCorr : * MaxDelay
    %                                                       *TestTimePeriod
    % - HU256_SetCorrectorsToZero : * Pause
    
    res=-1;
    %HU256_GoOnCycling(MainPowerSupplyName, 1, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
    fprintf('\n')
    HU256_GoOnCycling(MainPowerSupplyName, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
    fprintf('-----------------------------------------------\n')
    global CORRCURRTABLE;
    global ABSOLUTETOLERANCE;
    N=size(CORRCURRTABLE, 1);
    for (i=2:2*N-2)
        %HU256_GoOnCycling('', 1, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
        HU256_GoOnCycling('', NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
        fprintf('-----------------------------------------------\n')
    end
    %if(strcmp(NameOfTableToBuild, '')==1)
    HU256_GoOnCycling('', NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, '', DispCorrTable );
    %HU256_MainSetCurrent(0); %, ABSOLUTETOLERANCE);
    res=0;