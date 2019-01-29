function res=HU256_GoOnCycling(MainPowerSupplyName, Aperiodic, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable )
%Version Aperiodic

    % Move from point to point on a cycle, with BZP power supply or with
    %   BX1 and BX2 power supplies.
    % To initialise the cycle, set MainPowerSupplyName to 'bz' or 'bx'
    % When initialised, go on the cycle by setting MainPowerSupplyName to ''
    % To go to 0A, down way, without breaking the cycle, set
    %   MainPowerSupplyName to 'off'. It will break the initialisation => a
    %   new one will have to be done.
    % If Aperiodic=1, There will be Aperiodic mode
    % NameOfTableToUseForCorrection is the full name (path+name) to the
    %   correction table where to get the currents to put in the correction
    %   coils. The table contains 9 columns: Main current, Bzc1 Down, Bzc1
    %   Up, Bzc27 Down, Bzc27 Up, Bxc1 Down, Bxc1 Up, Bxc28 Down, Bxc28 Up.
    %   If no name is given, the correction currents remain unchanged!
    % If OrbitsAcquisitionDirectory='', no acquisition is done along the
    %   cycle. If it is not empty, acquisitions will be stored in the
    %   specified directory.
    % if NameOfTableToBuild='', no Correction Currents Table is built. If
    %   it is not empty, the table is saved in OrbitsAcquisitionDirectory.
    
    global HU256CELL;
    global BEAMLINENAME;
    global SENSEOFCURRENT;
    global PRESENTCURRENT;
    global POWERSUPPLYNAME;
    global LISTOFCURRENTS;
    global REFORBIT;
    global CORRCURRTABLE;
    global RELATIVETOLERANCE;
    global APERIODIC;
    global MAXDELAY;
    global TESTWITHOUTPS;
        
    res=-1;
    
    debug=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    %ListOfZCurrents=-200:100:200;    % pas de 50 : 5 points pour essai
    ListOfZCurrents=-200:20:200;      % pas de 20 : normal
    %ListOfZCurrents=-200:10:200;      % pas de 10 : très précis
    
    %ListOfXCurrents=horzcat([0:125:250], [275]);       % pas de 125 : 4 points pour essai
    ListOfXCurrents=0:25:275;         % pas de 25 : normal
    %ListOfXCurrents=0:12.5:275;       % pas de 1HU256_SetCurrentSyncCorr2.5 : très précis
    %ListOfXCurrents=horzcat([0:50:250], [275]);    % pas de 50 : moins précis
    
    CurrentRelativeTolerance=0.0001;
    MaxDelay=5; % délai max pour considérer que les alims ont atteint leur consigne (en secondes) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    HU256Cell=['ANS-C' num2str(HU256CELL, '%02.0f')];
    
    if (strcmp(OrbitsAcquisitionDirectory, '')==1&&strcmp(NameOfTableToBuild, '')==0)
        fprintf('You must specify a Directory where to store Orbits acquisition if you want to build a table!\n')
    end
    %ScriptsDirectory=Pwd;
    if (strcmp(MainPowerSupplyName, 'bz')==0&&strcmp(MainPowerSupplyName, 'bx')==0&&strcmp(MainPowerSupplyName, '')==0&&strcmp(MainPowerSupplyName, 'off')==0)
        fprintf('MainPowerSupplyName must be '''', ''bz'',  ''bx'' or ''off''\n');
        return
    end

% Initialisation and moving power suppliesHU256_SetCurrentSyncCorr
    if (strcmp(MainPowerSupplyName, 'bz')==1||strcmp(MainPowerSupplyName, 'bx')==1) % MainPowerSupplyName='bz' or 'bx' => The cycle will be initialised
        
        APERIODIC=Aperiodic;
        MAXDELAY=MaxDelay;
        
        SENSEOFCURRENT=-1;
        PRESENTCURRENT=0;
        if (strcmp(MainPowerSupplyName, 'bz')==1)
            POWERSUPPLYNAME='bz';
            LISTOFCURRENTS=ListOfZCurrents;
        else
            POWERSUPPLYNAME='bx';
            LISTOFCURRENTS=ListOfXCurrents;
        end
        NumberOfCurrents=length(LISTOFCURRENTS);
        REFORBIT='';
        CORRCURRTABLE=zeros(NumberOfCurrents, 9);  % Colonnes : 1_Courant, 2_CVED, 3_CVEU, 4_CHED, 5_CHEU, 6_CVSD, 7_CVSU, 8_CHSD, 9_CHSU
        if (debug==1)
            fprintf('Sens: %i ; PRESENTCURRENT: %d\n', SENSEOFCURRENT, PRESENTCURRENT)
        end
        RELATIVETOLERANCE=CurrentRelativeTolerance;
        CurrentAbsoluteTolerance=abs(PRESENTCURRENT*RELATIVETOLERANCE);
        if (strcmp(NameOfTableToUseForCorrection, '')==0)
            CorrCurrentsToPut=HU256_ExtractCorrCurrentsFromTable(NameOfTableToUseForCorrection);
            res=HU256_SetCurrentSyncCorr(PRESENTCURRENT, CurrentAbsoluteTolerance, CorrCurrentsToPut(1), CorrCurrentsToPut(2), CorrCurrentsToPut(3), CorrCurrentsToPut(4));
        else
            res=HU256_SetCurrentSync(PRESENTCURRENT, CurrentAbsoluteTolerance);
        end
        
        res=0;
    elseif  (strcmp(MainPowerSupplyName, '')==1)    % MainPowerSupplyName='' => The cycle is initialised yet. We stay on it.
        
        %if (strcmp(POWERSUPPLYNAME, 'bz')==1)
        %    ListOfCurrents=ListOfZCurrents;
        %elseif (strcmp(POWERSUPPLYNAME, 'bx')==1)
        %    ListOfCurrents=ListOfXCurrents;
        %end
        
        ListOfCurrents=LISTOFCURRENTS;
        
        if (debug==1)
            fprintf('Sens: %i ; PRESENTCURRENT: %d ; POWERSUPPLYNAME: %s\n', SENSEOFCURRENT, PRESENTCURRENT, POWERSUPPLYNAME)
        end

        idDevServ=[HU256Cell '/EI/m-HU256.2_' upper(POWERSUPPLYNAME)];
        if (strcmp(POWERSUPPLYNAME, 'bz'))==1
            idDevServ=[idDevServ 'P'];
        else
            idDevServ=[idDevServ '1'];
        end

        %InitialCurrent=readattribute([idDevServ '/current']);
        
        
        %if (abs(PRESENTCURRENT-InitialCurrent)>CurrentAbsoluteTolerance)
        %    fprintf ('%s', 'The current read on the power supply dismatches from the current registered in the global variable ''PRESENTCURRENT''')
        %    return
        %end
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
        if (strcmp(NameOfTableToUseForCorrection, '')==0)
            CorrCurrentsToPut=HU256_ExtractCorrCurrentsFromTable(NameOfTableToUseForCorrection);
            res=HU256_SetCurrentSyncCorr(PRESENTCURRENT, CurrentAbsoluteTolerance, CorrCurrentsToPut(1), CorrCurrentsToPut(2), CorrCurrentsToPut(3), CorrCurrentsToPut(4));
        else
            res=HU256_SetCurrentSync(PRESENTCURRENT, CurrentAbsoluteTolerance);
        end
                
    elseif (strcmp(MainPowerSupplyName, 'off')==1)     % MainPowerSupplyName='off' => The cycle will be quickly gone on until 0A is reached by the down way.

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
        return
    end
    
    if (debug==1)
        fprintf('PRESENTCURRENT: %6.3f\n', PRESENTCURRENT)
        fprintf('CurrentAbsoluteTolerance: %6.3f\n', CurrentAbsoluteTolerance)
    end
    
% Orbits Correction
    %if (strcmp(NameOfTableToUseForCorrection, '')==0)
       %fidCorr=fopen(NameOfTableToUseForCorrection, 'r');
       %index=find(LISTOF
       %index=find(ListOfCurrents==PRESENTCURRENT);
       %[Current, Bxc1D, Bxc1U, Bxc28D, Bxc28U, Bzc1D, Bzc1U, Bzc27D, Bzc27U] = textread(NameOfTableToUseForCorrection, '%f %f %f %f %f %f %f %f %f','delimiter', '\t', 'headerlines', 1);
       %index=find(Current==PRESENTCURRENT);
     %  fprintf('PRESENTCURRENT: %f', PRESENTCURRENT)
      % CorrCurrentsToPut=HU256_ExtractCorrCurrentsFromTable(NameOfTableToUseForCorrection);
    %end
       
% Orbits Acquisition
    if (strcmp(OrbitsAcquisitionDirectory, '')==0)
      pause(2);
      if (SENSEOFCURRENT==1)
          StringSenseOfCurrent='U';
      else
          StringSenseOfCurrent='D';
      end
      FileNameCore=['HU256_' BEAMLINENAME '_' upper(POWERSUPPLYNAME) '_' num2str(PRESENTCURRENT) '_' StringSenseOfCurrent];
      outStructElecBeam=HU256_MeasElecBeam(0, 1, [OrbitsAcquisitionDirectory filesep FileNameCore]);     %(inclPerturbMeas, dispData, fileNameCore)
    end     % end of orbits acquisition

% Build Table of correction currents
    if (strcmp(NameOfTableToBuild, '')==0)
        if (strcmp(OrbitsAcquisitionDirectory, '')==1)
           fprintf('No correction Current calculated: You should specify a directory where to store orbits acquisitions!\n')
           res=-1;
           return
        end
        if (strcmp(REFORBIT, '')==1)
            if (PRESENTCURRENT==0&&SENSEOFCURRENT==-1)
                REFORBIT=outStructElecBeam.name;
            else
                fprintf('No Correction Current calculated: The Reference Orbit was not stored (Go to 0A in the down way to correct)\n')
                return
            end
        end
        
        CorCurrents=HU256_CalculateCorrCur(outStructElecBeam.name, REFORBIT);
        %CorCurrents=[CVE, CHE, CVS, CHS]
        
        i=find(LISTOFCURRENTS==PRESENTCURRENT);
        %CORRCURRTABLE(i, 9);  % Colonnes : 1_Courant, 2_CVED, 3_CVEU, 4_CHED, 5_CHEU, 6_CVSD, 7_CVSU, 8_CHSD, 9_CHSU
        %CORRCURRTABLE(i, 9);  % Colonnes : 1_Courant, 2_Bxc1D, 3_Bxc1U, 4_Bzc1D, 5_Bzc1U, 6_Bxc28D, 7_Bxc28U, 8_Bzc27D, 9_Bzc27U
        %Avant modif : CORRCURRTABLE(i, 9);  % Colonnes : 1_Courant, 2_Bzc1D, 3_Bzc1U, 4_Bzc27D, 5_Bzc27U, 6_Bxc1D, 7_Bxc1U, 8_Bxc28D, 9_Bxc28U
        CORRCURRTABLE(i, 1)=PRESENTCURRENT;
        if (SENSEOFCURRENT==-1)
            CORRCURRTABLE(i, 2)=CorCurrents(1); %CVE
            CORRCURRTABLE(i, 4)=CorCurrents(2); %CHE
            CORRCURRTABLE(i, 6)=CorCurrents(3); %CVS
            CORRCURRTABLE(i, 8)=CorCurrents(4); %CHS
            if (i==1)
                CORRCURRTABLE(1, 3)=CORRCURRTABLE(1, 2); %CVE
                CORRCURRTABLE(1, 5)=CORRCURRTABLE(1, 4); %CHE
                CORRCURRTABLE(1, 7)=CORRCURRTABLE(1, 6); %CVS
                CORRCURRTABLE(1, 9)=CORRCURRTABLE(1, 8); %CHS
            end
        elseif (SENSEOFCURRENT==1)
            CORRCURRTABLE(i, 3)=CorCurrents(1); %CVE
            CORRCURRTABLE(i, 5)=CorCurrents(2); %CHE
            CORRCURRTABLE(i, 7)=CorCurrents(3); %CVS
            CORRCURRTABLE(i, 9)=CorCurrents(4); %CHS
            if (i==length(LISTOFCURRENTS))
                CORRCURRTABLE(i, 2)=CORRCURRTABLE(i, 3); %CVE
                CORRCURRTABLE(i, 4)=CORRCURRTABLE(i, 5); %CHE
                CORRCURRTABLE(i, 6)=CORRCURRTABLE(i, 7); %CVS
                CORRCURRTABLE(i, 8)=CORRCURRTABLE(i, 9); %CHS
            end
        end
        
        fid=fopen([OrbitsAcquisitionDirectory filesep NameOfTableToBuild], 'w+');
        fprintf(fid, '%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\n', 'Current', 'CVE D', 'CVE U', 'CHE D', 'CHE U', 'CVS D', 'CVS U', 'CHS D', 'CHS U');
        %Avant modif : fprintf(fid, '%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\n', 'Current', 'Bzc1 D', 'Bzc1 U', 'Bzc27 D', 'Bzc27 U', 'Bxc1 D', 'Bxc1 U', 'Bxc28 D', 'Bxc28 U');
        for i=1:size(CORRCURRTABLE, 1)
            fprintf(fid, '%+08.3f\t', CORRCURRTABLE(i, :));
            fprintf(fid, '\n');
        end
        fclose(fid);
        if (DispCorrTable~=0)
            CORRCURRTABLE %#ok<NOPRT>
        end
    end     % end of build table
    
    if (strcmp(NameOfTableToBuild, '')==1&&strcmp(OrbitsAcquisitionDirectory, '')==1&&TESTWITHOUTPS==0)
        idDevServ=[HU256Cell '/EI/m-HU256.2_', upper(POWERSUPPLYNAME)];
        if (strcmp(POWERSUPPLYNAME, 'bz'))==1
            idDevServ=[idDevServ 'P'];
        else
            idDevServ=[idDevServ '1'];
        end
        SetCurrent=readattribute([idDevServ '/current']);
        fprintf('Asked current: %7.3f A\tObtained current: %7.3f A\n', PRESENTCURRENT, SetCurrent)
    end
%   fprintf('Bzm1 %3.3f\tBzm2 %3.3f\tBzm3 %3.3f\tBzm4 %3.3f\n', readattribute('ans-c15/ei/m-hu256.2/currentBZM1'), readattribute('ans-c15/ei/m-hu256.2/currentBZM2'), readattribute('ans-c15/ei/m-hu256.2/currentBZM3'), readattribute('ans-c15/ei/m-hu256.2/currentBZM4'));
    res=0;
end
%return
    