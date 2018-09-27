function res=HU256_TotalCycling(HU256Cell, MainPowerSupplyName, AperiodicOrHelicoidal, DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable)
% Version Aperiodic & helicoidal
% - MainPowerSupplyName = 'bz', 'bx', 'inithel', 'off', 'ref', 'max' or 'all'
% - AperiodicOrHelicoidal = 0, 1, or 'Hel'
%
% If AperiodicOrHelicoidal = 0 or 1 : - MainPowerSupplyName = 'bz' => an entire cycle with bz power supply is made
%                                     - MainPowerSupplyName = 'bx' => an entire cycle with bx power supply is made
%                                     (Both cycles are periodic or aperiodic, depending on AperiodicOrHelicoidal value)
% If AperiodicOrHelicoidal = 'hel' :  - MainPowerSupplyName = 'bz' => an entire cycle with bz power supply is made at the
%                                       current bx value
%                                     - MainPowerSupplyName = 'bx' => the bx current is changed to the next one (only if
%                                       bz current is zero!)
%                                     - MainPowerSupplyName = 'off' => both currents are sent to zero taking the right way
%                                     - MainPowerSupplyName = 'ref' => same as 'off' for the moment
%                                     - MainPowerSupplyName = 'max' => Bx is put to max current, taking the rigth way. It
%                                     is needed to reach the down way of Bx
%                                     - MainPowerSupplyName = 'inithel' => to init helical mode (nothing is done except
%                                     initialising global variables)
% MainPowerSupplyName = 'all' (whatever AperiodicOrHelicoidal is) => An entire Helicoidal cycle is done (all bx and all
% NOT AVAILABLE YET!                    bz values)

    global TESTWITHOUTPS;
    global TESTWITHOUTBEAM;
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
    
    TESTWITHOUTBEAM=0;
    TESTWITHOUTPS=0;    % =1 For Tests!!! (No power supply used)
    DEBUG=0;    % =1 for debugging
    
    
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

    if (strcmp(MainPowerSupplyName, 'bz')==0&&strcmp(MainPowerSupplyName, 'bx')==0&&strcmp(MainPowerSupplyName, 'all')==0&&strcmp(MainPowerSupplyName, 'inithel')==0&&strcmp(MainPowerSupplyName, 'off')==0&&strcmp(MainPowerSupplyName, 'ref')==0&&strcmp(MainPowerSupplyName, 'max')==0)
        fprintf('Problem in HU256_TotalCycling -> MainPowerSupplyName must be ''bz'', ''bx'', ''inithel'', ''all'', ''off'', ''ref'' or ''max''\n')
        return
    end

    if (isa(AperiodicOrHelicoidal, 'numeric')==1)
        if (AperiodicOrHelicoidal~=0&&AperiodicOrHelicoidal~=1)
            fprintf('Problem in HU256_TotalCycling -> AperiodicOrHelicoidal, as a number, must be 0 or 1\n')
            return
        end
    elseif (isa(AperiodicOrHelicoidal, 'char')==1)
        if (strcmp(AperiodicOrHelicoidal, 'hel')==0)
            fprintf('Problem in HU256_TotalCycling -> AperiodicOrHelicoidal must be ''hel'' as a string\n')
            return
        end
    else
        fprintf('Problem in HU256_TotalCycling -> AperiodicOrHelicoidal must be a number or a string\n')
        return
    end

    if (isa(OrbitsAcquisitionDirectory, 'char')==0)
        fprintf('Problem in HU256_TotalCycling -> OrbitsAcquisitionDirectory must be a string\n')
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
    
    if (isa(DirectoryOfTableToUseForCorrection, 'char')==0)
        fprintf('Problem in HU256_TotalCycling -> DirectoryOfTableToUseForCorrection must be a string\n')
    end
    if (isa(SuffixOfTableToUseForCorrection, 'numeric')==1)
        if (SuffixOfTableToUseForCorrection~=0)
            fprintf('Problem in HU256_TotalCycling -> suffixOfTableToUseForCorrection, as a number, must be zero\n')
            return
        end
    elseif (isa(SuffixOfTableToUseForCorrection, 'char')==1)
    else
        fprintf('Problem in HU256_TotalCycling -> suffixOfTableToUseForCorrection must be zero or a string\n')
        return
    end
       
    ForceToStop_Ask_ForceToWrite=-1;
    
	if (isa(AperiodicOrHelicoidal, 'numeric')==1)    % Classic mode
            fprintf('\n')
            fprintf('\n----------------------------------------------------------------------------------------------------------------------------\n')
            %HU256_GoOnCycling(MainPowerSupplyName, AperiodicOrHelicoidal, DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, ForceToStop_Ask_ForceToWrite, DispCorrTable )
            % Init
            R=HU256_GoOnCycling(MainPowerSupplyName, AperiodicOrHelicoidal, DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, ForceToStop_Ask_ForceToWrite, DispCorrTable );
            if (R~=-1)
                fprintf('\n----------------------------------------------------------------------------------------------------------------------------\n')
                Test=0;
                while (Test==0)
                    % Go on until row n-1
                    R=HU256_GoOnCycling('', AperiodicOrHelicoidal, DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, ForceToStop_Ask_ForceToWrite, DispCorrTable);
                    fprintf('\n----------------------------------------------------------------------------------------------------------------------------\n')
                    if (R==-1)
                        fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in the middle\n')
                        return
                    end
                    row=find(LISTOFCURRENTS==PRESENTCURRENT);
                    row0=find(LISTOFCURRENTS==0);
                    Test=(row==row0+1&&SENSEOFCURRENT==-1);
                end
                % last step without building table
                R=HU256_GoOnCycling('', AperiodicOrHelicoidal, DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, '', 0, ForceToStop_Ask_ForceToWrite, DispCorrTable);
                if (R==-1)
                    fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly the last time\n')
                    return
                end
            else
                fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly the first time\n')
                    return
            end
%         end
%         fprintf('Classic mode\n')
%         fprintf('\n')
%         HU256_GoOnCycling(MainPowerSupplyName, AperiodicOrHelicoidal, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable )
%         disp AperiodicOrHelicoidal
%         fprintf('%f\t%f\n', isa(AperiodicOrHelicoidal, 'number'),  AperiodicOrHelicoidal)
%         fprintf('-----------------------------------------------\n')
%         N=size(LISTOFCURRENTS, 2);
%         for i=2:2*N-2
%             HU256_GoOnCycling('', AperiodicOrHelicoidal, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable )
%             fprintf('%f\t%f\n', isa(AperiodicOrHelicoidal, 'number'),  AperiodicOrHelicoidal)
%             fprintf('-----------------------------------------------\n')
%         end
%         HU256_GoOnCycling('', AperiodicOrHelicoidal, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, 0, DispCorrTable )
        
	else    % Helicoidal mode
        if (strcmp(MainPowerSupplyName, 'inithel')==1)
            fprintf('\n')
            fprintf('\n----------------------------------------------------------------------------------------------------------------------------\n')
%            R=HU256_GoOnCycling('bx', 'hel', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, ForceToStop_Ask_ForceToWrite, DispCorrTable );
             R=HU256_GoOnCycling('bx', 'hel', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, 0, ForceToStop_Ask_ForceToWrite, DispCorrTable );
            if (R==-1)
                fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly when initialising Helicoil\n')
                return
            end
        elseif (strcmp(MainPowerSupplyName, 'off')==1)
            if (DEBUG)
                fprintf('off : PRESENTCURRENT : %f, SENSEOFCURRENT : %f, BXPRESENTCURRENTFORHEL : %f, BXSENSEOFCURRENTFORHEL : %f !\n', PRESENTCURRENT, SENSEOFCURRENT, BXPRESENTCURRENTFORHEL, BXSENSEOFCURRENTFORHEL)
                fprintf('off bz!\n')
            end
            if (PRESENTCURRENT~=0)
                if (DEBUG)
                    fprintf('PRESENTCURRENT~=0 : %f, SENSEOFCURRENT~=-1 : %f, condition : %f\n', PRESENTCURRENT~=0, SENSEOFCURRENT~=-1, PRESENTCURRENT~=0||SENSEOFCURRENT~=-1)
                end
                while(PRESENTCURRENT~=0||SENSEOFCURRENT~=-1)
                    if (DEBUG)
                        fprintf('PRESENTCURRENT~=0 : %f, SENSEOFCURRENT~=-1 : %f, condition : %f\n', PRESENTCURRENT~=0, SENSEOFCURRENT~=-1, PRESENTCURRENT~=0||SENSEOFCURRENT~=-1)
                        fprintf('Bz toujours pas nul : %f !\n', PRESENTCURRENT )
                    end
                    R=HU256_GoOnCycling('bz', '', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, ForceToStop_Ask_ForceToWrite, DispCorrTable);
                    if (R==-1)
                        fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in making ''off'' a Bz Hel cycle\n')
                        return
                    end
                end
            end
            fprintf('off bx!\n')
            if (BXPRESENTCURRENTFORHEL~=0)
                if (DEBUG)
                    fprintf('BXPRESENTCURRENTFORHEL~=0 : %f, BXSENSEOFCURRENTFORHEL~=-1 : %f, condition : %f\n', BXPRESENTCURRENTFORHEL~=0, BXSENSEOFCURRENTFORHEL~=-1, BXPRESENTCURRENTFORHEL~=0||BXSENSEOFCURRENTFORHEL~=-1)
                end
                while(BXPRESENTCURRENTFORHEL~=0)    %||BXSENSEOFCURRENTFORHEL~=-1)
                    if (DEBUG)
                        fprintf('BXPRESENTCURRENTFORHEL~=0 : %f, BXSENSEOFCURRENTFORHEL~=-1 : %f, condition : %f\n', BXPRESENTCURRENTFORHEL~=0, BXSENSEOFCURRENTFORHEL~=-1, BXPRESENTCURRENTFORHEL~=0||BXSENSEOFCURRENTFORHEL~=-1)
                        fprintf('Bx toujours pas nul : %f !\n', BXPRESENTCURRENTFORHEL )
                    end
                    R=HU256_GoOnCycling('bx', '', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, ForceToStop_Ask_ForceToWrite, DispCorrTable);
                    if (R==-1)
                        fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in making ''off'' a Bx Hel cycle\n')
                        return
                    end
                end
            end
            if (DEBUG==1)
                fprintf('PRESENTCURRENT : %3.3f, SENSEOFCURRENT : %3.3f, BXPRESENTCURRENTFORHEL : %3.3f, BXSENSEOFCURRENTFORHEL : %3.3f\n', PRESENTCURRENT, SENSEOFCURRENT, BXPRESENTCURRENTFORHEL, BXSENSEOFCURRENTFORHEL)
            end
        
        elseif (strcmp(MainPowerSupplyName, 'all')==1)
            R=0;
            % Initialisation of helicoil 'all' cycle
            R=HU256_TotalCycling(HU256Cell, 'inithel', 'hel', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable);
            if (R==-1)
                fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in the initialisation of Hel ''all'' cycle\n')
                return
            end
            % First Bz cycle (at Bx=0)
            R=HU256_TotalCycling(HU256Cell, 'bz', 'hel', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable);
            if (R==-1)
                fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in an iteration of a Bz Hel cycle\n')
                return
            end
%             % First move of Bx
%             R=HU256_TotalCycling(HU256Cell, 'bz', 'hel', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable);
%             if (R==-1)
%                 fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in an iteration of a Bz Hel cycle\n')
%                 return
%             end
            Condition=0;
            while(Condition~=1)
                R=HU256_TotalCycling(HU256Cell, 'bx', 'hel', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable);
                if (R==-1)
                    fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in an Bx step of a Bz Hel cycle\n')
                    return
                end
                index=find(BXLISTOFCURRENTSFORHEL==BXPRESENTCURRENTFORHEL)
                if (index==-1)
                    fprintf('Problem in TotalCycling : BXPRESENTCURRENTFORHEL wasn''t found in BXLISTOFCURRENTSFORHEL\n')
                    return
                end
                Condition=(index==2&&BXSENSEOFCURRENTFORHEL==-1)   % BX current is just the one after zero => next step and cycle is finished
                if (index==length(BXLISTOFCURRENTSFORHEL)||BXSENSEOFCURRENTFORHEL==-1)
                    R=HU256_TotalCycling(HU256Cell, 'bz', 'hel', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable);
                    if (R==-1)
                        fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in an iteration of a Bz Hel cycle\n')
                        return
                    end
                end
            end
            R=HU256_TotalCycling(HU256Cell, 'off', 'hel', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, DispCorrTable);
            if (R==-1)
                fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in the ending of a Bz Hel cycle\n')
                return
            end
        elseif (strcmp(MainPowerSupplyName, 'ref')==1)
            if (DEBUG)
                fprintf('Debug TotalCycling ref : PRESENTCURRENT : %f, SENSEOFCURRENT : %f, BXPRESENTCURRENTFORHEL : %f, BXSENSEOFCURRENTFORHEL : %f !\n', PRESENTCURRENT, SENSEOFCURRENT, BXPRESENTCURRENTFORHEL, BXSENSEOFCURRENTFORHEL)
                fprintf('ref bz!\n')
            end
            if (PRESENTCURRENT~=0)
                if (DEBUG)
                    fprintf('Debug TotalCycling ref : PRESENTCURRENT~=0 : %f, SENSEOFCURRENT~=-1 : %f, condition : %f\n', PRESENTCURRENT~=0, SENSEOFCURRENT~=-1, PRESENTCURRENT~=0||SENSEOFCURRENT~=-1)
                end
                while(PRESENTCURRENT~=0||SENSEOFCURRENT~=-1)
                    if (DEBUG)
                        fprintf('Debug TotalCycling ref : PRESENTCURRENT~=0 : %f, SENSEOFCURRENT~=-1 : %f, condition : %f\n', PRESENTCURRENT~=0, SENSEOFCURRENT~=-1, PRESENTCURRENT~=0||SENSEOFCURRENT~=-1)
                        fprintf('Debug TotalCycling ref : Bz toujours pas nul : %f !\n', PRESENTCURRENT )
                    end
                    R=HU256_GoOnCycling('bz', '', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, 0, ForceToStop_Ask_ForceToWrite, DispCorrTable);
                    if (R==-1)
                        fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in making ''ref'' a Bz Hel cycle\n')
                        return
                    end
                end
            end
            fprintf('ref bx!\n')
            if (BXPRESENTCURRENTFORHEL~=0)
                if (DEBUG)
                    fprintf('Debug TotalCycling ref : BXPRESENTCURRENTFORHEL~=0 : %f, BXSENSEOFCURRENTFORHEL~=-1 : %f, condition : %f\n', BXPRESENTCURRENTFORHEL~=0, BXSENSEOFCURRENTFORHEL~=-1, BXPRESENTCURRENTFORHEL~=0||BXSENSEOFCURRENTFORHEL~=-1)
                end
                index0=find(BXLISTOFCURRENTSFORHEL==0);
                index=find(BXLISTOFCURRENTSFORHEL==BXPRESENTCURRENTFORHEL);
                while (index~=index0+1)   %(BXPRESENTCURRENTFORHEL~=0)    %||BXSENSEOFCURRENTFORHEL~=-1)
                    if (DEBUG)
                        fprintf('Debug TotalCycling ref : BXPRESENTCURRENTFORHEL~=0 : %f, BXSENSEOFCURRENTFORHEL~=-1 : %f, condition : %f\n', BXPRESENTCURRENTFORHEL~=0, BXSENSEOFCURRENTFORHEL~=-1, BXPRESENTCURRENTFORHEL~=0||BXSENSEOFCURRENTFORHEL~=-1)
                        fprintf('Debug TotalCycling ref : Bx toujours pas nul : %f !\n', BXPRESENTCURRENTFORHEL )
                    end
                    R=HU256_GoOnCycling('bx', '', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, 0, ForceToStop_Ask_ForceToWrite, DispCorrTable);
                    if (R==-1)
                        fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in making ''ref'' a Bx Hel cycle\n')
                        return
                    end
                    index=find(BXLISTOFCURRENTSFORHEL==BXPRESENTCURRENTFORHEL);
                end
                R=HU256_GoOnCycling('bx', '', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, 0, ForceToStop_Ask_ForceToWrite, DispCorrTable);
                if (R==-1)
                    fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in making ''ref'' a Bx Hel cycle\n')
                    return
                end
            end
            if (DEBUG==1)
                fprintf('Debug TotalCycling ref : PRESENTCURRENT : %3.3f, SENSEOFCURRENT : %3.3f, BXPRESENTCURRENTFORHEL : %3.3f, BXSENSEOFCURRENTFORHEL : %3.3f\n', PRESENTCURRENT, SENSEOFCURRENT, BXPRESENTCURRENTFORHEL, BXSENSEOFCURRENTFORHEL)
            end
        elseif (strcmp(MainPowerSupplyName, 'max')==1)
            if (DEBUG)
                fprintf('Debug TotalCycling max : PRESENTCURRENT : %f, SENSEOFCURRENT : %f, BXPRESENTCURRENTFORHEL : %f, BXSENSEOFCURRENTFORHEL : %f !\n', PRESENTCURRENT, SENSEOFCURRENT, BXPRESENTCURRENTFORHEL, BXSENSEOFCURRENTFORHEL)
                fprintf('max bz!\n')
            end
            if (PRESENTCURRENT~=0)
                if (DEBUG)
                    fprintf('Debug TotalCycling ref : PRESENTCURRENT~=0 : %f, SENSEOFCURRENT~=-1 : %f, condition : %f\n', PRESENTCURRENT~=0, SENSEOFCURRENT~=-1, PRESENTCURRENT~=0||SENSEOFCURRENT~=-1)
                end
                while(PRESENTCURRENT~=0||SENSEOFCURRENT~=-1)
                    if (DEBUG)
                        fprintf('Debug TotalCycling max : PRESENTCURRENT~=0 : %f, SENSEOFCURRENT~=-1 : %f, condition : %f\n', PRESENTCURRENT~=0, SENSEOFCURRENT~=-1, PRESENTCURRENT~=0||SENSEOFCURRENT~=-1)
                        fprintf('Debug TotalCycling max : Bz toujours pas nul : %f !\n', PRESENTCURRENT )
                    end
                    R=HU256_GoOnCycling('bz', '', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, 0, ForceToStop_Ask_ForceToWrite, DispCorrTable);
                    if (R==-1)
                        fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in making ''ref'' a Bz Hel cycle\n')
                        return
                    end
                end
            end
            fprintf('max bx!\n')
            index=find(BXLISTOFCURRENTSFORHEL==BXPRESENTCURRENTFORHEL);
            length(BXLISTOFCURRENTSFORHEL);
            if (index~=length(BXLISTOFCURRENTSFORHEL))  % BX is not max current
                if (DEBUG)
                    fprintf('Debug TotalCycling max : BXPRESENTCURRENTFORHEL~=0 : %f, BXSENSEOFCURRENTFORHEL~=-1 : %f, condition : %f\n', BXPRESENTCURRENTFORHEL~=0, BXSENSEOFCURRENTFORHEL~=-1, BXPRESENTCURRENTFORHEL~=0||BXSENSEOFCURRENTFORHEL~=-1)
                end
%                 indexMax=find(BXLISTOFCURRENTSFORHEL==length();
                
                while (index~=length(BXLISTOFCURRENTSFORHEL))   %(BXPRESENTCURRENTFORHEL~=0)    %||BXSENSEOFCURRENTFORHEL~=-1)
                    if (DEBUG)
                        fprintf('Debug TotalCycling max : BXPRESENTCURRENTFORHEL~=0 : %f, BXSENSEOFCURRENTFORHEL~=-1 : %f, condition : %f\n', BXPRESENTCURRENTFORHEL~=0, BXSENSEOFCURRENTFORHEL~=-1, BXPRESENTCURRENTFORHEL~=0||BXSENSEOFCURRENTFORHEL~=-1)
                        fprintf('Debug TotalCycling max : Bx toujours pas nul : %f !\n', BXPRESENTCURRENTFORHEL )
                    end
                    R=HU256_GoOnCycling('bx', '', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, ForceToStop_Ask_ForceToWrite, DispCorrTable);
                    if (R==-1)
                        fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in making ''ref'' a Bx Hel cycle\n')
                        return
                    end
                    index=find(BXLISTOFCURRENTSFORHEL==BXPRESENTCURRENTFORHEL);
                end
%                 R=HU256_GoOnCycling('bx', '', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, 0, ForceToStop_Ask_ForceToWrite, DispCorrTable);
%                 if (R==-1)
%                     fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in making ''ref'' a Bx Hel cycle\n')
%                     return
%                 end
            end
            if (DEBUG==1)
                fprintf('Debug TotalCycling ref : PRESENTCURRENT : %3.3f, SENSEOFCURRENT : %3.3f, BXPRESENTCURRENTFORHEL : %3.3f, BXSENSEOFCURRENTFORHEL : %3.3f\n', PRESENTCURRENT, SENSEOFCURRENT, BXPRESENTCURRENTFORHEL, BXSENSEOFCURRENTFORHEL)
            end       
        else    % not init, no off, no all, no ref
            if (strcmp(MainPowerSupplyName, 'bz')==1)
                fprintf('\n')
                %HU256_GoOnCycling(MainPowerSupplyName, AperiodicOrHelicoidal, DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, ForceToStop_Ask_ForceToWrite, DispCorrTable )
                % Init
%                 R=HU256_GoOnCycling(MainPowerSupplyName, AperiodicOrHelicoidal, DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, ForceToStop_Ask_ForceToWrite, DispCorrTable );
%                 if (R~=-1)
%                     fprintf('\n----------------------------------------------------------------------------------------------------------------------------\n')
                    Test=0;
                    while (Test==0)
                        % Go on until row n-1
                        fprintf('\n----------------------------------------------------------------------------------------------------------------------------\n')
                        R=HU256_GoOnCycling(MainPowerSupplyName, '', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, ForceToStop_Ask_ForceToWrite, DispCorrTable);
%                         fprintf('\n----------------------------------------------------------------------------------------------------------------------------\n')
                        if (R==-1)
                            fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in an iteration of a Bz Hel cycle\n')
                            return
                        end
                        if (strcmp(MainPowerSupplyName, 'bz')==1)
                            ListOfCurrents=LISTOFCURRENTS;
                            PresentCurrent=PRESENTCURRENT;
                            SenseOfCurrent=SENSEOFCURRENT;
                        else
                            ListOfCurrents=BXLISTOFCURRENTSFORHEL;
                            PresentCurrent=BXPRESENTCURRENTFORHEL;
                            SenseOfCurrent=BXSENSEOFCURRENTFORHEL;
                        end
                        row=find(ListOfCurrents==PresentCurrent);
                        row0=find(ListOfCurrents==0);
                        Test=(row==row0+1&&SenseOfCurrent==-1);
                    end
                    % last step without building table
                    R=HU256_GoOnCycling(MainPowerSupplyName, '', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, 0, ForceToStop_Ask_ForceToWrite, DispCorrTable);
%                     R=HU256_GoOnCycling('', AperiodicOrHelicoidal, DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, '', 0, ForceToStop_Ask_ForceToWrite, DispCorrTable);
                    if (R==-1)
                        fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly in the last iteration of a Bz Hel cycle\n')
                        return
                    end
%                 else
%                     fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly during the first iteration of a Bz Hel cycle\n')
%                         return
%                 end
            elseif (strcmp(MainPowerSupplyName, 'bx')==1)    % 'bx'
                fprintf('\n')
                fprintf('\n----------------------------------------------------------------------------------------------------------------------------\n')
                if (BXSENSEOFCURRENTFORHEL==1)
%                     R=HU256_GoOnCycling(MainPowerSupplyName, '', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, 0, ForceToStop_Ask_ForceToWrite, DispCorrTable );
                    R=HU256_GoOnCycling(MainPowerSupplyName, '', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, ForceToStop_Ask_ForceToWrite, DispCorrTable );
                else
                    R=HU256_GoOnCycling(MainPowerSupplyName, '', DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, ForceToStop_Ask_ForceToWrite, DispCorrTable );
                end
                if (R==-1)
                fprintf('Problem in TotalCycling : GoOnCycling wasn''t executed correctly when changing Bx\n')
                    return
                end
            else
                fprintf('Problem in TotalCycling : MainPowerSupply should be bz or bx... to check!!!!\n')
            end
        end
    end
    tango_command_inout('ans/ca/texttalker.2', 'DevTalk', ' ');
    res=1;
        


        