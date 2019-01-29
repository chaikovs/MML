function res=HU256_TotalCycling(HU256Cell, MainPowerSupplyName, AperiodicOrHelicoidal, DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild)
% Version Aperiodic & helicoidal
% - MainPowerSupplyName = 'bz', 'bx' or 'all'
% - AperiodicOrHelicoidal = 0, 1, or 'Hel'
%
% If AperiodicOrHelicoidal = 0 or 1 : MainPowerSupplyName = 'bz' => an entire cycle with bz power supply is made
%                                     MainPowerSupplyName = 'bx' => an entire cycle with bx power supply is made
%                                     (Both cycles are periodic or aperiodic, depending on AperiodicOrHelicoidal value)
% If AperiodicOrHelicoidal = 'hel' :  MainPowerSupplyName = 'bz' => an entire cycle with bz power supply is made at the
%                                       current bx value
%                                     MainPowerSupplyName = 'bx' => the bx current is changed to the next one (only if
%                                       bz current is zero!)
% MainPowerSupplyName = 'all' (whatever AperiodicOrHelicoidal is) => An entire Helicoidal cycle is done (all bx and all
%                                                                       bz values)

    global TESTWITHOUTPS;
%     global CORRCURRTABLE;
    global HU256CELL;
    global BEAMLINENAME;
    global PRESENTCURRENT;
    global SENSEOFCURRENT;
    global BXPRESENTCURRENTFORHEL;
    global BXSENSEOFCURRENTFORHEL;
    global POWERSUPPLYNAME;
    global LISTOFCURRENTS;
    global BXLISTOFCURRENTSFORHEL;
    global DEBUG;
    
    res=-1;
    
    TESTWITHOUTPS=0;    % =1 For Tests!!! (No power supply used)
    DEBUG=1;    % =1 for debugging
    
    
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

    if (strcmp(MainPowerSupplyName, 'bz')==0&&strcmp(MainPowerSupplyName, 'bx')==0&&strcmp(MainPowerSupplyName, 'all')==0)
        fprintf('Problem in HU256_TotalCycling -> MainPowerSupplyName must be ''bz'', ''bx'' or ''all''\n')
        return
    end

    if (isa(AperiodicOrHelicoidal, 'numeric')==1)
        if (AperiodicOrHelicoidal~=0&&AperiodicOrHelicoidal~=1)
            fprintf('Problem in HU256_TotalCycling -> AperiodicOrHelicoidal, as a number, must be 0 or 1\n')
            return
        end
%     elseif (isa(AperiodicOrHelicoidal, 'char')==1)
%         if (strcmp(AperiodicOrHelicoidal, 'hel')==0)
%             fprintf('Problem in HU256_TotalCycling -> AperiodicOrHelicoidal, as a string, must be ''hel''\n')
%             return
%         end
%     else
        fprintf('Problem in HU256_TotalCycling -> AperiodicOrHelicoidal must be a number or a string\n')
        return
    end

    if (isa(SuffixForNameOfTableToBuild, 'numeric')==1)
        if (SuffixForNameOfTableToBuild~=0)
            fprintf('Problem in HU256_TotalCycling -> SuffixForNameOfTableToBuild, as a number, must be zero\n')
            return
        end
    elseif (isa(SuffixForNameOfTableToBuild, 'char')==1)
    else
        fprintf('Problem in HU256_TotalCycling -> SuffixForNameOfTableToBuild must be zero or a string\n')
        return
    end
        
%         SenseOfCurrent
%         HU256_GoOnCycling('', AperiodicOrHelicoidal, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable );
%         HU256_GoOnCycling(MainPowerSupplyName, AperiodicOrHelicoidal, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable )
        

	if (isa(AperiodicOrHelicoidal, 'numeric')==1)    % Classic mode
        fprintf('Classic mode\n')
        fprintf('\n')
        HU256_GoOnCycling(MainPowerSupplyName, AperiodicOrHelicoidal, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable )
        disp AperiodicOrHelicoidal
        fprintf('%f\t%f\n', isa(AperiodicOrHelicoidal, 'number'),  AperiodicOrHelicoidal)
        fprintf('-----------------------------------------------\n')
        N=size(LISTOFCURRENTS, 2);
        for i=2:2*N-2
            HU256_GoOnCycling('', AperiodicOrHelicoidal, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable )
            fprintf('%f\t%f\n', isa(AperiodicOrHelicoidal, 'number'),  AperiodicOrHelicoidal)
            fprintf('-----------------------------------------------\n')
        end
        HU256_GoOnCycling('', AperiodicOrHelicoidal, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, 0, DispCorrTable )
        
	else    % Helicoidal mode
        fprintf('Helicoidal mode\n')
        fprintf('\n')
        HU256_GoOnCycling(MainPowerSupplyName, '', NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable );
        fprintf('-----------------------------------------------\n')
        if (strcmp(MainPowerSupplyName, 'bz'))
            List=LISTOFCURRENTS;
        else
            List=BXLISTOFCURRENTSFORHEL;
        end
        N=size(List, 2);
        for i=2:2*N-2
            HU256_GoOnCycling(MainPowerSupplyName, '', NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable );
            fprintf('-----------------------------------------------\n')
        end
        HU256_GoOnCycling(MainPowerSupplyName, '', NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, 0, DispCorrTable );
	end
    res=0;
        
%     elseif (HELICOIDAL==1)
%         fprintf('\n')
%         %HU256_GoOnCycling(MainPowerSupplyName, Aperiodic, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
%         if (isa(MainPowerSupplyName, 'numeric')==1)
%             if (PRESENTCURRENT~=MainPowerSupplyName)  % Sending BX to MainPowerSupplyName
%                 %POWERSUPPLYNAME='bx';   % NECESSAIRE ?????
%                 HU256_GoOnCycling('bx', 0, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
%                 while (MainPowerSupplyName~=PRESENTCURRENT||SENSEOFCURRENT~=-1)
%                     HU256_GoOnCycling('', 0, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
%                 end
%                 
%             elseif (PRESENTCURRENT==MainPowerSupplyName)  % Making a BZ cycling
%                 %POWERSUPPLYNAME='bz';
%                 %SENSEOFCURRENT=-1;
%                 %PRESENTCURRENT=0;
%                 BXSenseOfCurrent=SENSEOFCURRENT;
%                 BXPresentCurrent=PRESENTCURRENT;
%                 fprintf('\n')
%                 HU256_GoOnCycling('bz', 0, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
%                 fprintf('-----------------------------------------------\n')
%                 N=size(CORRCURRTABLE, 1);
%                 for i=2:2*N-2
%                     %HU256_GoOnCycling('', 1, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
%                     HU256_GoOnCycling('', 0, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable );
%                     fprintf('-----------------------------------------------\n')
%                 end
%                 HU256_GoOnCycling('', Aperiodic, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, '', DispCorrTable );
%                 POWERSUPPLYNAME='bx';
%                 SENSEOFCURRENT=BXSenseOfCurrent;
%                 PRESENTCURRENT=BXPresentCurrent;
%                 res=0;
%             end
%         else
%             if (strcmp(MainPowerSupplyName, 'begin'))
%             elseif (strcmp(MainPowerSupplyName, 'all'))
%             end
%         end
%     end
%     if (MainPowerSupplyName<0||MainPowerSupplyName>275)   % BXCurrent is outside the limits
%         fprintf('Problem with HU256_TotalCycling : MainPowerSupplyName = %f but it should be between 0 and 275A.\n', MainPowerSupplyName)
%         return
%     else
%         HELICOIDAL=1;
%     end
%     elseif (isa(MainPowerSupplyName, 'char')==1)
%     if (strcmp(MainPowerSupplyName, 'bz')==1||strcmp(MainPowerSupplyName, 'bx')==1)
%         HELICOIDAL=0;
%     elseif (strcmp(MainPowerSupplyName, 'all')==1)
%         HELICOIDAL=1;
%     elseif (strcmp(MainPowerSupplyName, 'begin')==1)
%         HELICOIDAL=1;
%         %POWERSUPPLYNAME='bx';
%         SENSEOFCURRENT=1;
%         PRESENTCURRENT=0;   % BX=0
%     else
%         fprintf('Problem with HU256_TotalCycling : MainPowerSupplyName is %s but it should be a ''begin'', ''all'', ''bz'' or ''bx''\n', MainPowerSupplyName)
%         return
%     end


        