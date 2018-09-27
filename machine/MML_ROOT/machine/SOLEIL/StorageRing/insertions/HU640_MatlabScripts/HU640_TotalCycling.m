function res=HU640_TotalCycling(MainPowerSupplyName, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable)
    
    % This script can : - drive HU640 undulator along one cycle
    %                   - calculate correction tables along this cycle
    %                   - drive the correctors using a correction table
    % It uses the following files : - HU640_ExtractCorrCurrentsFromTable.m,
    %                               - HU640_GoOnCycling.m
    %                               - HU640_MainSetCurrent.m
    %                               - HU640_MeasElecBeam.m
    %                               - HU640_SetCorrectorsToZero.m
    %                               - HU640_SetCurrentSync.m
    %                               - HU640_SetCurrentSyncCorr.m
    %                               - HU640_CalculateCorrCur.m
    % Before using this script, you should check some details in these 4
    % scripts :
    % - HU640_GoOnCycling : * Min, Max and step of currents for PS1
    %                       * Min, Max and step of currents for PS2
    %                       * Min, Max and step of currents for PS3
    %                       * Relative tolerance on main power supplies
    %                       * Structure of the Orbit Acquisition created
    %                           filename
    % - HU640_SetCurrentSync and HU640_SetCurrentSyncCorr : * MaxDelay
    %                                                       *TestTimePeriod
    % - HU640_SetCorrectorsToZero : * Pause

    res=-1;
    fprintf('\n')
    HU640_GoOnCycling(MainPowerSupplyName, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
    fprintf('-----------------------------------------------\n')
    global CORRCURRTABLE;
    global ABSOLUTETOLERANCE;
    N=size(CORRCURRTABLE, 1);
    for (i=2:2*N-2)
        HU640_GoOnCycling('', NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
        fprintf('-----------------------------------------------\n')
    end
    %if(strcmp(NameOfTableToBuild, '')==1)
    HU640_GoOnCycling('', NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, '', DispCorrTable );
    %HU640_MainSetCurrent(0); %, ABSOLUTETOLERANCE);
    res=0;