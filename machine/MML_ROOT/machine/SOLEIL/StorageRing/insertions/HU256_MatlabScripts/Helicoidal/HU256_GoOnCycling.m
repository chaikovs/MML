function res=HU256_GoOnCycling(MainPowerSupplyName, AperiodicOrHelicoidal, DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, ForceToStop_Ask_ForceToWrite, DispCorrTable )
%Version Aperiodic & Helicoidal

% If AperiodicOrHelicoidal = 0 or 1
    % Move from point to point on a cycle, with BZP power supply or with
    %   BX1 and BX2 power supplies.
    % - To initialise the cycle, set MainPowerSupplyName to 'bz' or 'bx'
    % - When initialised, go on the cycle by setting MainPowerSupplyName to ''
    % - To go to 0A, down way, without breaking the cycle, set
    %   MainPowerSupplyName to 'off'. It will break the initialisation => a
    %   new one will have to be done.
    % - If AperiodicOrHelicoidal=1, There will be AperiodicOrHelicoidal mode
    % NameOfTableToUseForCorrection is the full name (path+name) to the
    %   correction table where to get the currents to put in the correction
    %   coils. The table contains 9 columns: Main current, Bzc1 Down, Bzc1
    %   Up, Bzc27 Down, Bzc27 Up, Bxc1 Down, Bxc1 Up, Bxc28 Down, Bxc28 Up.
    %   If no name is given, the correction currents remain unchanged!
    % - If OrbitsAcquisitionDirectory='', no acquisition is done along the
    %   cycle. If it is not empty, acquisitions will be stored in the
    %   specified directory.
    % - if NameOfTableToBuild='', no Correction Currents Table is built. If
    %   it is not empty, the table is saved in OrbitsAcquisitionDirectory.
%    
% If AperiodicOrHelicoidal = 'hel' or ''
    % Move from point to point on a helicoidal cycle, with BZP power supply or with
    %   BX1 and BX2 power supplies.
    % - To initialise the helicoidal cycle, set AperiodicOrHelicoidal to 'hel'
    % - When initialised, go on the cycle by setting AperiodicOrHelicoidal to ''
    %   If MainPowerSupplyName = 'bz', bx current is not changed, but bz current is set to the next point
    %   If MainPowerSupplyName = 'bx', bz current is not changed, but bx current is set to the next point
    %       BZ CURRENT MUST BE ZERO!!
    % ?- To go to 0A, down way, without breaking the cycle, set
    % ?  MainPowerSupplyName to 'off'. It will break the initialisation => a
    % ?  new one will have to be done.
%
% When AperiodicOrHelicoidal = 'Hel' : Helicoidal mode is initialised => - HELICOIDAL is set to 1
%                                                                        - PRESENTCURRENT is set to 0
%                                                                        - POWERSUPPLY is set to 'bx'
%                                                                        - SENSEOFCURRENT is set to -1

% If SuffixForNameOfTableToBuild = 0 => No table built
% If SuffixForNameOfTableToBuild = '' => Table built (no suffix at the end of the name)

%HU256_GoOnCycling('bz', 'hel', '', 0, '', 0, 1)
%HU256_GoOnCycling('bz', 'hel', '', 0, '/home/operateur/GrpGMI/HU256_CASSIOPEE/MatlabScripts/Helicoidal/TempTests', 'i0', 1);
%HU256_TotalCycling(HU256Cell, MainPowerSupplyName, AperiodicOrHelicoidal, DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection, '/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2007_06_05', SuffixForNameOfTableToBuild, DispCorrTable)
    
    global HU256CELL;
    global BEAMLINENAME;
    global SENSEOFCURRENT;
    global PRESENTCURRENT;
    global BXPRESENTCURRENTFORHEL;
    global BXSENSEOFCURRENTFORHEL;
    global POWERSUPPLYNAME;
    global BXLISTOFCURRENTSFORHEL;
    %global BXREFORBITFORHEL;
    global LISTOFCURRENTS;
    global REFORBIT;
%     global CORRCURRTABLE;
    global RELATIVETOLERANCE;
    global APERIODIC;
    global MAXDELAY;
    global TESTWITHOUTPS;
    global TESTWITHOUTBEAM;
    global DEBUG;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     TESTWITHOUTPS=1;
%     TESTWITHOUTBEAM=1;
%     DEBUG=0;
%     HU256CELL=15;
%     BEAMLINENAME='PLEIADES';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    debug=DEBUG;
    
    %if (TESTWITHOUTPS==1)
        dispdata=1;     % Display ANS data (I, tau, Nu...) when making acquisitions
    %end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%     ListOfZCurrents=-200:100:200;    % pas de 50 : 5 points pour essai
  %  ListOfZCurrents=-200:20:200;      % pas de 20 : normal
     ListOfZCurrents=horzcat(-200:20:-20, -15:5:15, 20:20:200);
 %ListOfZCurrents=-200:10:200;      % pas de 10 : très précis
    
%     ListOfXCurrents=horzcat([0:125:250], [275]);       % pas de 125 : 4 points pour essai
%ListOfXCurrents=0:25:275;         % pas de 25 : normal
    %ListOfXCurrents=0:12.5:275;       % pas de 1HU256_SetCurrentSyncCorr2.5 : très précis
    %ListOfXCurrents=horzcat([0:50:250], [275]);    % pas de 50 : moins précis
    % ListOfXCurrents=horzcat(0:25:250, 255:10:275);    % pas de 25 puis pas de 10 au niveau du "plateau" : spécial étude de Pléiades
   ListOfXCurrents=horzcat(0:25:250, 255:5:275);    % pas de 25 puis pas de 5 au niveau du "plateau" : spécial étude de Pléiades
%     ListOfXCurrents=0:25:250;    % pas de 25 jusqu'à 250 : spécial étude de Pléiades
    
%Si Casssioppée
CassiopeeListOfXCurrents=horzcat(0:25:250, 255:10:275);
% CassiopeeListOfZCurrents=horzcat(-200:20:-20, -15:5:15, 20:20:200);
CassiopeeListOfZCurrents=-200:20:200; % Temp Version 04/10/08

%Si Pleiades
PleiadesListOfXCurrents=horzcat(0:25:250, 255:5:275);
PleiadesListOfZCurrents=-200:20:200;

%Si Antares
AntaresListOfXCurrents=0:25:275;
AntaresListOfZCurrents=-200:20:200;

    CurrentRelativeTolerance=0.001;
    MaxDelay=8; % délai max pour considérer que les alims ont atteint leur consigne (en secondes)
    TimeToWaitBeforeAcquisition=0; % Temps d'attente avant une acquisition (en secondes)
    ChromaticityMeasurement=0; % Mesure de chromaticité si 1. ATTENTION : PERTURBE LE FAISCEAU!!
    ForceToStop_Ask_ForceToWrite=1; % Si on tente de ré-écrire des courants de correction dans une matrice déjà pleine
                                    % -1 => on ne ré-écrit pas (conseillé si personne n'est présent)
                                    % 0 => on demande ce qu'on doit faire (conseillé si personne présente)
                                    % 1 => on ré-écrit (Déconseillé!!!)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    res=-1;
    pause on;
    HU256Cell=['ANS-C' num2str(HU256CELL, '%02.0f')];
    
%% General conditions

    Sofb=readattribute('ans/ca/service-locker/sofb');
%   Modif 31/05/2010  Sofb=readattribute('ANS/DG/PUB-SOFB/state1');
    if (Sofb==1)
        fprintf('Problem in HU256_GoOnCycling : the Slow Orbit Feed Back is running!! You should stop it before going on.\n')
%         return
    elseif (Sofb==0)
    else
        fprintf('Problem in HU256_GoOnCycling : the Slow Orbit Feed Back state is neither 0 nor 1!! It is unusual...\n')
        return
    end
    if (isa(SuffixForNameOfTableToBuild, 'char')==0&&SuffixForNameOfTableToBuild~=0)
        fprintf('Problem in HU256_GoOnCycling : SuffixForNameOfTableToBuild must be a string or a number equal to zero (no table built)\n')
        return
    end        
    if (strcmp(OrbitsAcquisitionDirectory, '')==1&&isa(SuffixForNameOfTableToBuild, 'char')==1)
        fprintf('Problem in HU256_GoOnCycling : You must specify a Directory where to store Orbits acquisition if you want to build a table!\n')
        return
    end
    
    if (strcmp(MainPowerSupplyName, 'bz')==0&&strcmp(MainPowerSupplyName, 'bx')==0&&strcmp(MainPowerSupplyName, '')==0&&strcmp(MainPowerSupplyName, 'off')==0)
        fprintf('Problem in HU256_GoOnCycling : MainPowerSupplyName must be '''', ''bz'',  ''bx'' or ''off''\n');
        return
    end
    if (strcmp(MainPowerSupplyName, '')==1&&isa(AperiodicOrHelicoidal, 'numeric')==0&&strcmp(AperiodicOrHelicoidal, 'hel')==0)
        fprintf('Problem in HU256_GoOnCycling : When going on a classical cycle using MainPowerSupply='''', AperiodicOrHelicoidal must be 0 or 1\n');
        return
    end
    if (isa(AperiodicOrHelicoidal, 'char'))
        if (strcmp(AperiodicOrHelicoidal, 'hel')==0&&strcmp(AperiodicOrHelicoidal, '')==0)
            fprintf('Problem in HU256_GoOnCycling : AperiodicOrHelicoidal as a string must be '''' (go on an helicoidal cycle) or ''hel'' (initialse an helicoidal cycle)\n');
            return
        end
        if (strcmp(AperiodicOrHelicoidal, '')==1&&strcmp(MainPowerSupplyName, 'bx')==0&&strcmp(MainPowerSupplyName, 'bz')==0)
            fprintf('Problem in HU256_GoOnCycling : When going on an helicoidal cycle using '''', MainPowerSupplyName must be ''bz'' or ''bx''\n');
            return
        end
    elseif (isa(AperiodicOrHelicoidal, 'numeric'))
        if (AperiodicOrHelicoidal~=0&&AperiodicOrHelicoidal~=1)
            fprintf('Problem in HU256_GoOnCycling : AperiodicOrHelicoidal as a number must be 0 or 1\n');
            return
        end
    end
    if (strcmp(MainPowerSupplyName, '')==1&&strcmp(APERIODIC, 'hel')==1&&isa(AperiodicOrHelicoidal, 'numeric')==1)
        fprintf('Problem in HU256_GoOnCycling : You can''t go on a classical cycle because an helicoidal one was initialised. Please initialise a classical cycle\n')
        return
    end
    if (isa(DirectoryOfTableToUseForCorrection, 'char')==0)
        fprintf('Problem in HU256_GoOnCycling : DirectoryOfTableToUseForCorrection must be a string\n')
        return
    end
    
    
    Init=0;
%% Initialisation and moving power supplies for classical modes
    if ((strcmp(MainPowerSupplyName, 'bz')==1||strcmp(MainPowerSupplyName, 'bx')==1)&&isa(AperiodicOrHelicoidal, 'numeric')==1) % MainPowerSupplyName='bz' or 'bx' => The cycle cycle will be initialised
        if (debug)
            fprintf('##Init classic\n')
        end
        APERIODIC=AperiodicOrHelicoidal;
        MAXDELAY=MaxDelay;
        
        SENSEOFCURRENT=-1;
        PRESENTCURRENT=0;
        BackupPRESENTCURRENT=PRESENTCURRENT;
        BackupSENSEOFCURRENT=SENSEOFCURRENT;
        if (strcmp(MainPowerSupplyName, 'bz')==1)
            POWERSUPPLYNAME='bz';
            LISTOFCURRENTS=ListOfZCurrents;
        else
            POWERSUPPLYNAME='bx';
            LISTOFCURRENTS=ListOfXCurrents;
        end
%         NumberOfCurrents=length(LISTOFCURRENTS); % Ligne suppressed (06/05/07) because Matlab says it is not used => To check
        REFORBIT='';
%         CORRCURRTABLE=zeros(NumberOfCurrents, 9);  % Colonnes : 1_Courant, 2_CVED, 3_CVEU, 4_CHED, 5_CHEU, 6_CVSD,
%         7_CVSU, 8_CHSD, 9_CHSU  % Ligne suppressed (06/05/07) because Matlab says it is not used => To check
        if (debug==1)
            fprintf('SENSEOFCURRENT: %i ; PRESENTCURRENT: %3.3f\n', SENSEOFCURRENT, PRESENTCURRENT)
        end
        RELATIVETOLERANCE=CurrentRelativeTolerance;
        CurrentAbsoluteTolerance=abs(PRESENTCURRENT*RELATIVETOLERANCE);
        if (isa(SuffixOfTableToUseForCorrection, 'char')==1)
            CorrCurrentsToPut=HU256_ExtractCorrCurrentsFromTable(DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection);
            if (CorrCurrentsToPut==-1)
                fprintf('Problem in HU256_GoOnCycling : HU256_ExtractCorrCurrentsFromTable failed\n')
                return
            end
            res=HU256_SetCurrentSyncCorr(PRESENTCURRENT, CurrentAbsoluteTolerance, CorrCurrentsToPut(1), CorrCurrentsToPut(2), CorrCurrentsToPut(3), CorrCurrentsToPut(4));
        else
            res=HU256_SetCurrentSyncCorr(PRESENTCURRENT, CurrentAbsoluteTolerance, 0, 0, 0, 0);
        end
        Init=1;

%% Initialisation and moving power supplies for helicoidal mode
    elseif (strcmp(AperiodicOrHelicoidal, 'hel')==1)
        if (debug)
            fprintf('##Init helico\n')
        end
        APERIODIC=AperiodicOrHelicoidal;
        MAXDELAY=MaxDelay;
        
        SENSEOFCURRENT=-1;
        PRESENTCURRENT=0;
        BXSENSEOFCURRENTFORHEL=1;
        BXPRESENTCURRENTFORHEL=0;
        BackupPRESENTCURRENT=PRESENTCURRENT;
        BackupSENSEOFCURRENT=SENSEOFCURRENT;
        BackupBXPRESENTCURRENTFORHEL=BXPRESENTCURRENTFORHEL;
        BackupBXSENSEOFCURRENTFORHEL=BXSENSEOFCURRENTFORHEL;
        POWERSUPPLYNAME='bx';
        
        if (HU256CELL==4)
            LISTOFCURRENTS=PleiadesListOfZCurrents;
            BXLISTOFCURRENTSFORHEL=PleiadesListOfXCurrents;
        elseif (HU256CELL==12)
            LISTOFCURRENTS=AntaresListOfZCurrents;
            BXLISTOFCURRENTSFORHEL=AntaresListOfXCurrents;
        elseif (HU256CELL==15)
            LISTOFCURRENTS=CassiopeeListOfZCurrents;
            BXLISTOFCURRENTSFORHEL=CassiopeeListOfXCurrents;
        end
        %NumberOfCurrents=length(LISTOFCURRENTS);
        REFORBIT='';
        %CORRCURRTABLE=zeros(NumberOfCurrents, 9);  % Colonnes : 1_Courant, 2_CVED, 3_CVEU, 4_CHED, 5_CHEU, 6_CVSD, 7_CVSU, 8_CHSD, 9_CHSU
        if (debug==1)
            fprintf('APERIODIC: %s ; SENSEOFCURRENT: %i ; PRESENTCURRENT: %3.3f ; BXSENSEOFCURRENTFORHEL: %i ; BXPRESENTCURRENTFORHEL : %3.3f\n', APERIODIC, SENSEOFCURRENT, PRESENTCURRENT, BXSENSEOFCURRENTFORHEL, BXPRESENTCURRENTFORHEL)
        end
        RELATIVETOLERANCE=CurrentRelativeTolerance;
        CurrentAbsoluteTolerance=abs(PRESENTCURRENT*RELATIVETOLERANCE);
        if (isa(SuffixOfTableToUseForCorrection, 'char')==1)
            CorrCurrentsToPut=HU256_ExtractCorrCurrentsFromTable(DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection);
            if (CorrCurrentsToPut==-1)
                fprintf('Problem in HU256_GoOnCycling : Couldn''t extract corretion currents from table with suffix ''%s''\n', SuffixOfTableToUseForCorrection)
                return
            end
            res=HU256_SetCurrentSyncCorr(PRESENTCURRENT, CurrentAbsoluteTolerance, CorrCurrentsToPut(1), CorrCurrentsToPut(2), CorrCurrentsToPut(3), CorrCurrentsToPut(4));
        else
            res=HU256_SetCurrentSyncCorr(PRESENTCURRENT, CurrentAbsoluteTolerance, 0, 0, 0, 0);
        end
        Init=1;
    end



%% Go on a cycle for classical modes
    
    if (Init==0)
    BackupPRESENTCURRENT=PRESENTCURRENT;
    BackupSENSEOFCURRENT=SENSEOFCURRENT;
        if (strcmp(MainPowerSupplyName, '')==1&&isa(APERIODIC, 'numeric')==1)    % MainPowerSupplyName='' => The cycle is initialised yet. We stay on it.
            if (debug)
                fprintf('##Go on classic\n')
            end
            if (isa(APERIODIC, 'char')==1)
                fprintf('Problem in HU256_GoOnCycling : You can''t go on a classic cycle while an helicoidal cycle was initialised\n')
                return
            end
            ListOfCurrents=LISTOFCURRENTS;
            if (debug==1)
                fprintf('Sens: %i ; PRESENTCURRENT: %d ; POWERSUPPLYNAME: %s\n', SENSEOFCURRENT, PRESENTCURRENT, POWERSUPPLYNAME)
            end
            index=find(ListOfCurrents==PRESENTCURRENT);
            if (debug==1)
                fprintf('Index: %i ; Sens: %i ; PRESENTCURRENT: %d\n', index, SENSEOFCURRENT, PRESENTCURRENT)
            end
            
            if (index==1||index==length(ListOfCurrents))
                SENSEOFCURRENT=SENSEOFCURRENT.*(-1);
            end
            index=index+SENSEOFCURRENT;
            
            PRESENTCURRENT=ListOfCurrents(index);
            if (debug==1)
                fprintf('Index: %i ; Sens: %i ; PRESENTCURRENT: %d\n', index, SENSEOFCURRENT, PRESENTCURRENT)
            end

            CurrentAbsoluteTolerance=abs(PRESENTCURRENT*RELATIVETOLERANCE);
%             if (strcmp(NameOfTableToUseForCorrection, '')==0)
%                 CorrCurrentsToPut=HU256_ExtractCorrCurrentsFromTable(NameOfTableToUseForCorrection);
%                 res=HU256_SetCurrentSyncCorr(PRESENTCURRENT, CurrentAbsoluteTolerance, CorrCurrentsToPut(1), CorrCurrentsToPut(2), CorrCurrentsToPut(3), CorrCurrentsToPut(4));
%             else
%                 res=HU256_SetCurrentSync(PRESENTCURRENT, CurrentAbsoluteTolerance);
%             end


%% Go on a cycle for helicoidal mode
        
        elseif (strcmp(AperiodicOrHelicoidal, '')==1)
            BackupPRESENTCURRENT=PRESENTCURRENT;
            BackupBXSENSEOFCURRENTFORHEL=BXSENSEOFCURRENTFORHEL;
            BackupSENSEOFCURRENT=SENSEOFCURRENT;
            BackupBXPRESENTCURRENTFORHEL=BXPRESENTCURRENTFORHEL;
            if (debug)
                fprintf('##Go on helico\n')
            end
            if (isa(APERIODIC, 'numeric')==1)
                fprintf('Problem in HU256_GoOnCycling : You can''t go on an helicoidal cycle while a classic cycle was initialised\n')
                return
            end
            ListOfCurrents=LISTOFCURRENTS;
            ListOfXCurrents=BXLISTOFCURRENTSFORHEL;

            if (strcmp(MainPowerSupplyName, 'bz')==1)
                if (BXSENSEOFCURRENTFORHEL==1&&BXPRESENTCURRENTFORHEL~=0)
                    fprintf('Problem in HU256_GoOnCycling : You can''t move BZP because BX is in the Up way. Reach the Down way for BX before going on.\n')
                    return
                end
                index=find(ListOfCurrents==PRESENTCURRENT);
                index=index+SENSEOFCURRENT;
                if (index==1||index==length(ListOfCurrents))
                    
                    SENSEOFCURRENT=SENSEOFCURRENT.*(-1);
                end
                PRESENTCURRENT=ListOfCurrents(index);
%                 CurrentToSet=PRESENTCURRENT;
                CurrentAbsoluteTolerance=abs(PRESENTCURRENT*RELATIVETOLERANCE);
                pause(TimeToWaitBeforeAcquisition);       %% Rajouté par Mathieu et Marie-Emmanuelle le 16/07/07
            else    % bx
                %ListOfCurrents=BXLISTOFCURRENTSFORHEL;
                index=find(ListOfXCurrents==BXPRESENTCURRENTFORHEL);
                index=index+BXSENSEOFCURRENTFORHEL;
                if (PRESENTCURRENT~=0||SENSEOFCURRENT~=-1)
                    fprintf('Problem in HU256_GoOnCycling : You can''t move bx if the bz cycle is not finished (Now bz=%3.3f). Move bz until it rises zero in the Down way and try again\n', PRESENTCURRENT)
                    return
                end
                
                if (index==1||index==length(ListOfXCurrents))
                    
                    BXSENSEOFCURRENTFORHEL=BXSENSEOFCURRENTFORHEL.*(-1);
                end
                
                BXPRESENTCURRENTFORHEL=ListOfXCurrents(index);
                CurrentToSet=BXPRESENTCURRENTFORHEL;
                CurrentAbsoluteTolerance=abs(BXPRESENTCURRENTFORHEL*RELATIVETOLERANCE);
            end
            if (debug==1)
                fprintf('Sens: %i ; PRESENTCURRENT: %d ; POWERSUPPLYNAME: %s\n', SENSEOFCURRENT, PRESENTCURRENT, POWERSUPPLYNAME)
            end
            POWERSUPPLYNAME=MainPowerSupplyName;
%             if (strcmp(NameOfTableToUseForCorrection, '')==0)
%                 CorrCurrentsToPut=HU256_ExtractCorrCurrentsFromTable(NameOfTableToUseForCorrection);
%                 res=HU256_SetCurrentSyncCorr(CurrentToSet, CurrentAbsoluteTolerance, CorrCurrentsToPut(1), CorrCurrentsToPut(2), CorrCurrentsToPut(3), CorrCurrentsToPut(4));
%             else
%                 res=HU256_SetCurrentSync(CurrentToSet, CurrentAbsoluteTolerance);
%             end
            

%% Finish the classic cycle        
        elseif (strcmp(MainPowerSupplyName, 'off')==1)     % MainPowerSupplyName='off' => The cycle will be quickly gone on until 0A is reached by the down way.
            if (debug)
                fprintf('##Finish classic\n')
            end
            %CurrentAbsoluteTolerance=abs(PRESENTCURRENT*RELATIVETOLERANCE);
            HU256_MainSetCurrent(0); %, CurrentAbsoluteTolerance);
            HU256_SetCorrectorsToZero();
            clear global SENSEOFCURRENT;
            clear global PRESENTCURRENT;
            clear global POWERSUPPLYNAME;
            clear global LISTOFCURRENTS;
            clear global REFORBIT;
            clear global CORRCURRTABLE;
            clear global RELATIVETOLERANCE;
            clear global HU256CELL;
            clear global BEAMLINENAME;
            clear global BXPRESENTCURRENTFORHEL;
            clear global BXSENSEOFCURRENTFORHEL;
            clear global BXLISTOFCURRENTSFORHEL;
            %clear global BXREFORBITFORHEL;
            clear global APERIODIC;
            clear global MAXDELAY;
            clear global TESTWITHOUTPS;
            res=1;
            return
        end


        if (debug==1)
            fprintf('PRESENTCURRENT: %6.3f\n', PRESENTCURRENT)
            fprintf('CurrentAbsoluteTolerance: %6.3f\n', CurrentAbsoluteTolerance)
        end
    end
    
%% 
    if (debug)
        fprintf('\nBackupPRESENTCURRENT : %3.3f, BackupSENSEOFCURRENT : %3.3f\n', BackupPRESENTCURRENT, BackupSENSEOFCURRENT)
        fprintf('PRESENTCURRENT : %3.3f, SENSEOFCURRENT : %3.3f\n', PRESENTCURRENT, SENSEOFCURRENT)
        if (isa(APERIODIC, 'char')==1)
            fprintf('BackupBXPRESENTCURRENTFORHEL : %f, BackupBXSENSEOFCURRENTFORHEL : %f\n', BackupBXPRESENTCURRENTFORHEL, BackupBXSENSEOFCURRENTFORHEL)
            fprintf('BXPRESENTCURRENTFORHEL : %3.3f, BXSENSEOFCURRENTFORHEL : %3.3f\n', BXPRESENTCURRENTFORHEL, BXSENSEOFCURRENTFORHEL)
        end
        fprintf('\n')
    end

%% Completing the name of the table to build
    if (isa(SuffixForNameOfTableToBuild, 'char'))   % Building of a table asked
        if (debug)
            fprintf('##Completing the name of the table(s)\n')
        end
        NameOfTableToBuild=HU256_GetTableFileNameForHel(SuffixForNameOfTableToBuild, 0);    % can be a string or a stucture of 2 strings
        if (debug)
            NameOfTableToBuild
            fprintf('PRESENTCURRENT : %f ; BXPRESENTCURRENTFORHEL : %f\n', PRESENTCURRENT, BXPRESENTCURRENTFORHEL)
        end
        if (isa(NameOfTableToBuild, 'struct')==1)   % helicoidal mode
            FullPathOfTableToBuild.U=[OrbitsAcquisitionDirectory filesep NameOfTableToBuild.U];
            FullPathOfTableToBuild.D=[OrbitsAcquisitionDirectory filesep NameOfTableToBuild.D];
        else    % linear modes
            FullPathOfTableToBuild=[OrbitsAcquisitionDirectory filesep NameOfTableToBuild];
        end
    end

%% If a table building is asked, we check if the table exists and is full yet. If yes, the building can be stopped or not, depending on ForceToStop_Ask_ForceToWrite.
    if (isa(SuffixForNameOfTableToBuild, 'char')==1)     %&&SuffixForNameOfTableToBuild~=0)
        Abort=0;
        if (debug)
            fprintf('##Checking of the status of the table(s)\n')
        end
        if (isa(APERIODIC, 'numeric')==1)  % classic mode
            if (isa(FullPathOfTableToBuild, 'struct')==1)
                fprintf('Big problem with GoOnCycling : is it helicoil or linear mode?\nIf this error appears, it means there is a mistake in the scripts!\n')
                return
            end
            if (strcmp(NameOfTableToBuild, '')==0)
%               FullPathOfTableToBuild=[OrbitsAcquisitionDirectory filesep NameOfTableToBuild]
%                 ExistsFull=HU256_CheckIfScriptTableExistsAndIsNotFull(FullPathOfTableToBuild, 0, ForceToStop_Ask_ForceToWrite, debug)
                ExistsFull=HU256_CheckIfTableExistsAndValueIsFull(OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, 0, ForceToStop_Ask_ForceToWrite, debug);
                if (ExistsFull==0)
                    Abort=1;
                elseif (ExistsFull==-2)
                    fprintf('Problem in GoOnCycling : HU256_CheckIfScriptTableExistsAndIsNotFull was not executed correctly\n')
                    return
                end
            end
        elseif (isa(APERIODIC, 'char')==1)  % helicoidal mode
            if (debug)
                fprintf('Helicoidal checking\n')
            end
            if (isa(FullPathOfTableToBuild, 'struct')==0)
                fprintf('Big problem 2 with GoOnCcycling : is it helicoil or linear mode?\nIf this error appears, it means there is a mistake in the scripts!\n')
                return
            end
            if (strcmp(NameOfTableToBuild.U, '')==0)
%                 ExistsFull.U=HU256_CheckIfScriptTableExistsAndIsNotFull(FullPathOfTableToBuild, 1, ForceToStop_Ask_ForceToWrite, debug)
                ExistsFull.U=HU256_CheckIfTableExistsAndValueIsFull(OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, 1, ForceToStop_Ask_ForceToWrite, debug);
                if (ExistsFull.U==0)
                    Abort=1;
                end
            end
            if (strcmp(NameOfTableToBuild.D, '')==0)
%                 ExistsFull.D=HU256_CheckIfScriptTableExistsAndIsNotFull(FullPathOfTableToBuild, -1, ForceToStop_Ask_ForceToWrite, debug)
                ExistsFull.D=HU256_CheckIfTableExistsAndValueIsFull(OrbitsAcquisitionDirectory, SuffixForNameOfTableToBuild, -1, ForceToStop_Ask_ForceToWrite, debug);
                if (ExistsFull.D==0)
                    Abort=1;
                end
            end
%             if (strcmp(NameOfTableToBuild.U, '')==0&&strcmp(NameOfTableToBuild.D, '')==0&&ExistsFull.U==0&&ExistsFull.D==0)    % Both Tables full => Building canceled
%                 Abort=1;
%             end
        end
        if (debug)
            ExistsFull
            Abort
        end
        if (Abort==1)
            fprintf('Aborted by user => the table was not updated\n')
            % Back to the previous values of the global variables
            PRESENTCURRENT=BackupPRESENTCURRENT;
            SENSEOFCURRENT=BackupSENSEOFCURRENT;
            if (isa(APERIODIC, 'char')==1)  % Helicoidal
                if (isempty(BackupBXPRESENTCURRENTFORHEL)==0)
                    BXPRESENTCURRENTFORHEL=BackupBXPRESENTCURRENTFORHEL;
                end
                if (isempty(BackupBXSENSEOFCURRENTFORHEL)==0)
                    BXSENSEOFCURRENTFORHEL=BackupBXSENSEOFCURRENTFORHEL;
                end
            end
            fprintf('Aborting : PRESENTCURRENT : %f, BXPRESENTCURRENTFORHEL : %f\n', PRESENTCURRENT, BXPRESENTCURRENTFORHEL)
            return
        end
    end     % end of "Building of a table asked"

%% Applying the new currents
    
	if (Init==0)
        if (debug)
            fprintf('##Applying new currents\n')
        end
        if (isa(SuffixOfTableToUseForCorrection, 'char')==1)    % With correction
            CorrCurrentsToPut=HU256_ExtractCorrCurrentsFromTable(DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection);
            if (DEBUG==1)
                fprintf('Debug GoOnCycling : Applying Currents with correction : %3.3f, %3.3f, %3.3f, %3.3f\n', CorrCurrentsToPut(1), CorrCurrentsToPut(2), CorrCurrentsToPut(3), CorrCurrentsToPut(4))
            end
            if (CorrCurrentsToPut==-1)
                fprintf('Problem in HU256_GoOnCycling : The correction currents couldn''t be extracted\n')
                return
            end
            res=HU256_SetCurrentSyncCorr(PRESENTCURRENT, CurrentAbsoluteTolerance, CorrCurrentsToPut(1), CorrCurrentsToPut(2), CorrCurrentsToPut(3), CorrCurrentsToPut(4));
        else    % without correction
            if (DEBUG==1)
                fprintf('Debug GoOnCycling : Applying Currents without correction\n')
            end
            res=HU256_SetCurrentSyncCorr(PRESENTCURRENT, CurrentAbsoluteTolerance, 0, 0, 0, 0);
        end
        if (res==-1)
            fprintf('Problem in HU256_GoOnCycling : The correction currents couldn''t be applied\n')
            return
        end
        
%         if (strcmp(MainPowerSupplyName, '')==1&&isa(APERIODIC, 'numeric')==1)   % Go on a classic cycle
%             if (isa(SuffixOfTableToUseForCorrection, 'char')==1)    % With correction
%                 NameOfCorrectionTable=HU256_GetTableFileNameForHel(SuffixOfTableToUseForCorrection, 0);
%                 if (isa(NameOfCorrectionTable, 'char')==0)
%                     fprintf('Problem in HU256_GoOnCycling : The name of table to use for correction is not correct\n')
%                     return
%                 end
%                 %FullPathForCorrectionTable=[DirectoryOfTableToUseForCorrection filesep NameOfTableForCorrection];
%                 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MODIFIER EXTRACT?
%                 CorrCurrentsToPut=HU256_ExtractCorrCurrentsFromTable(DirectoryOfTableToUseForCorrection, SuffixOfTableToUseForCorrection);
%                 if (CorrCurrentsToPut==-1)
%                     fprintf('Problem in HU256_GoOnCycling : The correction currents couldn''t be extracted\n')
%                     return
%                 end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 res=HU256_SetCurrentSyncCorr(PRESENTCURRENT, CurrentAbsoluteTolerance, CorrCurrentsToPut(1), CorrCurrentsToPut(2), CorrCurrentsToPut(3), CorrCurrentsToPut(4));
%             else    % Without correction
%                 if (debug)
%                     fprintf('GoOn Linear without correction, POWERSUPPLYNAME : %s , PRESENTCURRENT : %f\n', POWERSUPPLYNAME, PRESENTCURRENT)
%                 end
%                 res=HU256_SetCurrentSyncCorr(PRESENTCURRENT, CurrentAbsoluteTolerance, 0, 0, 0, 0);
%             end
% %             if (strcmp(NameOfTableToUseForCorrection, '')==0)
% %                 CorrCurrentsToPut=HU256_ExtractCorrCurrentsFromTable(NameOfTableToUseForCorrection);
% %                 res=HU256_SetCurrentSyncCorr(CurrentToSet, CurrentAbsoluteTolerance, CorrCurrentsToPut(1), CorrCurrentsToPut(2), CorrCurrentsToPut(3), CorrCurrentsToPut(4));
% %             else
% %                 res=HU256_SetCurrentSync(CurrentToSet, CurrentAbsoluteTolerance);
% %             end
%         elseif (isa(APERIODIC, 'char')==1)   % Go on a helicoidal cycle
%             if (isa(SuffixOfTableToUseForCorrection, 'char')==1)    % with correction
%                 NameOfCorrectionTables=HU256_GetTableFileNameForHel(SuffixOfTableToUseForCorrection, 0)
%                 if (isa (NameOfCorrectionTables, 'struct')==0)
%                     frpintf('Problem in HU256_GoOnCycling : The name(s) of table(s) to use for correction is/are not correct\n')
%                     return
%                 end
%                 if (BXSENSEOFCURRENTFORHEL==1)
%                     FullPathForCorrectionUTable=[DirectoryOfTableToUseForCorrection filesep NameOfCorrectionTables.U]
%                     %UTableFullName=[OrbitsAcquisitionDirectory filesep NameOfCorrectionTables.U]
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% A REMPLACER PAR EXTRACT ?
%                     UMatrix=HU256_Tab_GetMatrixFromTable(FullPathForCorrectionUTable, 1, debug)
%                     i=find(UMatrix(:,1)==BXPRESENTCURRENTFORHEL)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                     CorrCurrentsToPut=UMatrix(i, :)
% 
%                 else
%                      FullPathForCorrectionDTable=[DirectoryOfTableToUseForCorrection filesep NameOfCorrectionTables.D];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% A REMPLACER PAR EXTRACT ?
%                      DMatrix=HU256_Tab_GetMatrixFromTable(FullPathForCorrectionDTable, -1, debug);
%                      CorrCurrentsToPut=HU256_ExtractCorrCurrentsFromTable(DTableFullName);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 end
% 
%                 res=HU256_SetCurrentSyncCorr(0, CurrentAbsoluteTolerance, CorrCurrentsToPut(1), CorrCurrentsToPut(2), CorrCurrentsToPut(3), CorrCurrentsToPut(4));
%                 
%             else    % without correction
%                 if (debug)
%                     fprintf('GoOn Helicoil without correction, POWERSUPPLYNAME : %s , CurrentToSet : %f\n', POWERSUPPLYNAME, PRESENTCURRENT)
%                 end
%                 res=HU256_SetCurrentSyncCorr(0, CurrentAbsoluteTolerance, 0, 0, 0, 0);
%             end
%         end
	end   % end of if(init=0)


%% Orbits Acquisition
    if (strcmp(OrbitsAcquisitionDirectory, '')==0)  % Acquisition asked
        if (debug)
            fprintf('##Orbit acquisition\n')
        end
        if (TESTWITHOUTPS~=1)
            pause(TimeToWaitBeforeAcquisition);
        end
        if (isa(APERIODIC, 'numeric')==1)   % classic mode
            if (APERIODIC~=0&&APERIODIC~=1)
                fprintf ('Problem in HU256_GoOnCycling : APERIODIC should be O or 1, but it is %s\n', num2str(APERIODIC))
            end
            if (SENSEOFCURRENT==1)
                StringSenseOfCurrent='U';
            else
                StringSenseOfCurrent='D';
            end
            if (TESTWITHOUTBEAM~=1)
                FileNameCore=['HU256_' BEAMLINENAME '_' upper(POWERSUPPLYNAME) '_' num2str(PRESENTCURRENT) '_' StringSenseOfCurrent];
                outStructElecBeam=HU256_MeasElecBeam(ChromaticityMeasurement, dispdata, [OrbitsAcquisitionDirectory filesep FileNameCore]);     %(inclPerturbMeas, dispData, fileNameCore)
                fprintf ('DEBUG GoOnCycling - tango_error : %1.0f\n', tango_error)
            end
        else    % helicoidal mode
            if (strcmp(APERIODIC, '')&&strcmp(APERIODIC, 'hel'))
                fprintf ('Problem in HU256_GoOnCycling : APERIODIC should be '''' or ''hel'', but it is %s\n', APERIODIC)
            end
            if (SENSEOFCURRENT==1)
                StringSenseOfCurrent='U';
            else
                StringSenseOfCurrent='D';
            end
            if (BXSENSEOFCURRENTFORHEL==1)
                StringSenseOfXCurrent='U';
            else
                StringSenseOfXCurrent='D';
            end
            if (TESTWITHOUTBEAM~=1)
                FileNameCore=['HU256_' BEAMLINENAME '_BX_' num2str(BXPRESENTCURRENTFORHEL) '_' StringSenseOfXCurrent '_BZ_' num2str(PRESENTCURRENT) '_' StringSenseOfCurrent];
                outStructElecBeam=HU256_MeasElecBeam(ChromaticityMeasurement, dispdata, [OrbitsAcquisitionDirectory filesep FileNameCore]);     %(inclPerturbMeas, dispData, fileNameCore)
                fprintf ('DEBUG GoOnCycling - tango_error : %1.0f\n', tango_error)
            end
        end % end of mode selection
    end     % end of orbits acquisition



%% Build Table of correction currents
    % Modified on 05/06/2007 : REFORBIT is stored everytime we reach the point (Bx=0A, Bz=0A Down)
    if (strcmp(OrbitsAcquisitionDirectory, '')==0)
%   if (strcmp(OrbitsAcquisitionDirectoryOrbitsAcquisitionDirectory, '')==0)
%     if (isa(SuffixForNameOfTableToBuild, 'char')==1)    % Buidling of a table asked for
        if (debug)
            fprintf('##Building the table(s)\n')
        end
%         if (isempty(REFORBIT)==1)   % Creation of REFORBIT
%             if (debug==1)
%                 fprintf('No RefOrbit saved yet : isempty(REFORBIT) = %f\n', isempty(REFORBIT))
%                 fprintf('PRESENTCURRENT : %f SENSEOFCURRENT : %f BXPRESENTCURRENTFORHEL : %f\n', PRESENTCURRENT, SENSEOFCURRENT, BXPRESENTCURRENTFORHEL)
%             end
        if (isa(APERIODIC, 'numeric')==1)
            ConditionToStoreRefOrbit=(PRESENTCURRENT==0&&SENSEOFCURRENT==-1);
        elseif (isa(APERIODIC, 'char')==1)
            ConditionToStoreRefOrbit=(PRESENTCURRENT==0&&SENSEOFCURRENT==-1&&BXPRESENTCURRENTFORHEL==0);
        end
        if (ConditionToStoreRefOrbit)  % for helicoidal : &&BXPRESENTCURRENTFORHEL==0)
            if (TESTWITHOUTBEAM==1)
                outStructElecBeam.name='toto';  % acquisition is simulated
            else
                REFORBIT=outStructElecBeam.name; % acquisition is made and stored in REFORBIT      A RECHANGER TEST!!!!
                %REFORBIT='/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2008_02_03';
                %fprintf ('C''est bon');
            end
%             if (debug)
                fprintf('New Reference Orbit created : %s\n', REFORBIT)
%             end
        end
%             else 
        if (isempty(REFORBIT)==1)
            fprintf('****** Problem in HU256_GoOnCycling : No Correction Current calculated: The Reference Orbit was not stored ******\nSet : - BZP to 0A in the down way\n      - BX to 0A\n - Select an Acquisitions Directory\n')
            return
        end
%         else % else REFORBIT already present
%             if (debug==1)
%                 fprintf('RefOrbit saved yet\n')
%             end
%         end % end REFORBIT already present
    end     % After modif REFORBIT
    if (isa(SuffixForNameOfTableToBuild, 'char')==1)    % Buidling of a table asked for    % After modif REFORBIT
        if (TESTWITHOUTBEAM==1)
            outStructElecBeam.name='toto';  % acquisition is simulated
        end
        CorrCurrentsVector=HU256_CalculateCorrCur(outStructElecBeam.name, REFORBIT);
        
        if (isa(APERIODIC, 'numeric')==1)  % classic mode
            % If the table doesn't exist yet, a 'NaN' table is created. Else, the existing table is updated.
            if (ExistsFull==-1)
                CorrCurrTable=ones(size(LISTOFCURRENTS, 2), 9);
                CorrCurrTable=CorrCurrTable.*NaN;
                CorrCurrTable(:, 1)=LISTOFCURRENTS;
                if (debug)
                    fprintf('Creation of a new NaN table\n')
                end
            else
                CorrCurrTable=HU256_Tab_GetMatrixFromTable(FullPathOfTableToBuild, 0, debug);
                if (debug)
                    fprintf('Updating an old table\n')
                    fprintf('CorrCurrTable before update :\n')
                    disp(CorrCurrTable)
                end
            end

%             CorrCurrentsVector=HU256_CalculateCorrCur(outStructElecBeam.name, REFORBIT);
            CorrCurrTable=HU256_UpdateCorrMatrixFromCorrCurrents(CorrCurrTable, CorrCurrentsVector, POWERSUPPLYNAME);
            if (debug)
                fprintf('CorrCurrTable after update :\n')
                disp(CorrCurrTable)
            end
%             i=find(LISTOFCURRENTS==PRESENTCURRENT); % i = n° de ligne de la table
%             % j= j1+j2  % j = n° de colonne de la table
%             if (SENSEOFCURRENT==1)
%                 j2=1;
%                 j3=0;
%             else
%                 j2=0;
%                 j3=1;
%             end
%             for j1=1:1:4
%                 j=2*j1+j2;
%                 jElse=2*j1+j3;
%                 CorrCurrTable (i, j)=CorCurrents(j1);
%                 if (i==1||i==length(LISTOFCURRENTS))
%                     CorrCurrTable (i, jElse)=CorCurrents(j1);
%                 end
%             end
            if (DispCorrTable~=0)
                fprintf('CorrCurrTable\n');
                disp(CorrCurrTable);
            end
            HU256_Tab_SendMatrixToTable(CorrCurrTable, FullPathOfTableToBuild, 1);

        else    % Helicoidal
            % If the table doesn't exist yet, a 'NaN' table is created
            %CorrCurrTable=HU256_CheckIfScriptTableExistsAndIsNotFull(FullPathOfTableToBuild, 0, 0, 0);
            if (debug)
                fprintf('###Helicoidal Table building\n')
            end
%             CorCurrentsVector=HU256_CalculateCorrCur(outStructElecBeam.name, REFORBIT);
            if (debug)
                fprintf('FullPathOfTableToBuild.D : %s\n', FullPathOfTableToBuild.D)
            end
            if (strcmp(NameOfTableToBuild.D, '')==0)     % Values must be put in D Table
                if (debug)
                    fprintf('Values must be put in D Table\n')
                end
                if (ExistsFull.D==-1)   % D Table doesn't exist yet => The 'NaN' matrix is created
                    CorrCurrTableD=ones(size(LISTOFCURRENTS, 2), 9);
                    CorrCurrTableD=CorrCurrTableD.*NaN;
                    CorrCurrTableD(:, 1)=LISTOFCURRENTS;
                    if (debug)
                        fprintf('Nouvelle CorrCurrTableD\n')
                        disp (CorrCurrTableD)
                    end
                else    % The D Table exists => The matrix is taken from the actual table
                    CorrCurrTableD=HU256_Tab_GetMatrixFromTable(FullPathOfTableToBuild, -1, 1);
                    if (debug)
                        fprintf('récupération CorrCurrTableD\n')
                        disp (CorrCurrTableD)
                    end
                end
                
                % Updating the matrix and the table
                % j= j1+j2  % j = n° de colonne de la table
                CorrCurrTableD=HU256_UpdateCorrMatrixFromCorrCurrents(CorrCurrTableD, CorrCurrentsVector, 'bz');
%                 if (SENSEOFCURRENT==1)
%                     j2=1;
%                     j3=0;
%                 else
%                     j2=0;
%                     j3=1;
%                 end
%                 i=find(LISTOFCURRENTS==PRESENTCURRENT); % i = n° de ligne de la table
%                 for j1=1:1:4
%                     j=2*j1+j2;
%                     jElse=2*j1+j3;
%                     CorrCurrTableD (i, j)=CorCurrents(j1);
%                     if (i==1||i==length(LISTOFCURRENTS))
%                         CorrCurrTableD (i, jElse)=CorCurrents(j1);
%                     end
%                 end
                if (DispCorrTable~=0)
                    fprintf('CorrCurrTableD\n');
                    disp(CorrCurrTableD);
                end
                HU256_Tab_SendMatrixToTable(CorrCurrTableD, FullPathOfTableToBuild.D, 1);
            end

            %fprintf('FullPathOfTableToBuild.U : %s\n', FullPathOfTableToBuild.U)
            if (strcmp(NameOfTableToBuild.U, '')==0)     % Values must be put in U Table
                if (debug)
                    fprintf('Values must be put in U Table\n')
                end
                if (ExistsFull.U==-1)   % U Table doesn't exist yet => The 'NaN' matrix is created
                    CorrCurrTableU=ones(size(BXLISTOFCURRENTSFORHEL, 2), 5);
                    CorrCurrTableU=CorrCurrTableU.*NaN;
                    CorrCurrTableU(:, 1)=BXLISTOFCURRENTSFORHEL;
                    if (debug)
                        fprintf('Nouvelle CorrCurrTableU\n')
                        disp (CorrCurrTableU)
                    end
                else
                    CorrCurrTableU=HU256_Tab_GetMatrixFromTable(FullPathOfTableToBuild, 1, 1);
                    if (debug)
                        fprintf('récupération CorrCurrTableU\n')
                        disp (CorrCurrTableU)
                    end
                end     % The U Table exists => The matrix is taken from the actual table
            
                % Updating the matrix and the table
                % j= j1+j2  % j = n° de colonne de la table
                CorrCurrTableU=HU256_UpdateCorrMatrixFromCorrCurrents(CorrCurrTableU, CorrCurrentsVector, 'bx');
%                 if (SENSEOFCURRENT==1)
%                     j2=1;
%                     j3=0;
%                 else
%                     j2=0;
%                     j3=1;
%                 end
%                 i=find(BXLISTOFCURRENTSFORHEL==BXPRESENTCURRENTFORHEL); % i = n° de ligne de la table
%                 for j=1:1:4
%                     CorrCurrTableU (i, j+1)=CorCurrents(j);
% %                     if (i==1||i==length(BXLISTOFCURRENTSFORHEL))
% %                         CorrCurrTableD (i, jElse)=CorCurrents(j1);
% %                     end
%                 end
                if (DispCorrTable~=0)
                    fprintf('CorrCurrTableU\n');
                    disp(CorrCurrTableU);
                end
                HU256_Tab_SendMatrixToTable(CorrCurrTableU, FullPathOfTableToBuild.U, 1);
            
            end
        end     % end of mode selection
                
    end     % end of build table
    if (DEBUG)
        fprintf('PRESENTCURRENT : %f, BXPRESENTCURRENTFORHEL : %f\n', PRESENTCURRENT, BXPRESENTCURRENTFORHEL)
    end
%% If nothing is done except going on the cycle (no correction, no acquisition, no building of table) => a message is printed
    if (isa(SuffixForNameOfTableToBuild, 'numeric')==1&&SuffixForNameOfTableToBuild==0&&strcmp(OrbitsAcquisitionDirectory, '')==1&&TESTWITHOUTPS==0)
        if (debug)
            fprintf('##Simple view mode\n')
        end
        if (isa(APERIODIC, 'numeric')==1)
            idDevServ=[HU256Cell '/EI/m-HU256.2_', upper(POWERSUPPLYNAME)];
            if (strcmp(POWERSUPPLYNAME, 'bz'))==1
                idDevServ=[idDevServ 'P'];
            else
                idDevServ=[idDevServ '1'];
            end
            SetCurrent=readattribute([idDevServ '/current']);
            fprintf('Asked current: %7.3f A\tObtained current: %7.3f A\n', PRESENTCURRENT, SetCurrent)
        else
            BX1DevServ=[HU256Cell '/EI/m-HU256.2_' 'BX1/current'];
            BX2DevServ=[HU256Cell '/EI/m-HU256.2_' 'BX2/current'];
            BZPDevServ=[HU256Cell '/EI/m-HU256.2_' 'BZP/current'];
            fprintf('Asked BX current : %7.3f A\tObtained BX1 current : %7.3f A\tObtained BX2 current : %7.3f A\n', BXPRESENTCURRENTFORHEL, readattribute(BX1DevServ), readattribute(BX2DevServ))
            fprintf('Asked BZP current : %7.3f A\tObtained BZP current : %7.3f A\n', PRESENTCURRENT, readattribute(BZPDevServ))
        end
    end     % end of "no acquisition, no table, power supplies on"
%   fprintf('Bzm1 %3.3f\tBzm2 %3.3f\tBzm3 %3.3f\tBzm4 %3.3f\n', readattribute('ans-c15/ei/m-hu256.2/currentBZM1'), readattribute('ans-c15/ei/m-hu256.2/currentBZM2'), readattribute('ans-c15/ei/m-hu256.2/currentBZM3'), readattribute('ans-c15/ei/m-hu256.2/currentBZM4'));
    res=1;
%%    