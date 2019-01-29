function res=HU256_TotalCycling(HU256Cell, MainPowerSupplyName, Aperiodic, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable)
%Version Aperiodic

    global TESTWITHOUTPS;
    global CORRCURRTABLE;
    global HU256CELL;
    global BEAMLINENAME;
    
    TESTWITHOUTPS=0;    % =1 For Tests!!! (No power supply used)
    if (HU256Cell==4)
        BEAMLINENAME='PLEIADES';
        HU256CELL=HU256Cell;
    elseif (HU256Cell==12)
        BEAMLINENAME='ANTARES';
        HU256CELL=HU256Cell;
    elseif (HU256Cell==15)
        BEAMLINENAME='CASSIOPEE';
        HU256CELL=HU256Cell;
    else
        fprintf('Problem in HU256_TotalCycling -> HU256Cell must be :\n    4 (PLEIADES)\n    12 (ANTARES)\nor  15 (CASSIOPEE)\n')
        return
    end
    %global MAXDELAY;
    
    res=-1;
    %HU256_GoOnCycling(MainPowerSupplyName, 1, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
    fprintf('\n')
    HU256_GoOnCycling(MainPowerSupplyName, Aperiodic, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
    fprintf('-----------------------------------------------\n')
    
    %global ABSOLUTETOLERANCE;
    N=size(CORRCURRTABLE, 1);
    for i=2:2*N-2
        %HU256_GoOnCycling('', 1, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
        HU256_GoOnCycling('', Aperiodic, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
        fprintf('-----------------------------------------------\n')
    end
    %if(strcmp(NameOfTableToBuild, '')==1)
    HU256_GoOnCycling('', Aperiodic, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, '', DispCorrTable );
    %HU256_MainSetCurrent(0); %, ABSOLUTETOLERANCE);
    res=0;