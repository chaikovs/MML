function res=HU256_TotalCycling(MainPowerSupplyName, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable)
         
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