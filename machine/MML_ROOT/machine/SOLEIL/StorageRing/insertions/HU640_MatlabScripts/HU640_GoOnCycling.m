function res=HU640_GoOnCycling(MainPowerSupplyName, NameOfTableToUseForCorrection, OrbitsAcquisitionDirectory, NameOfTableToBuild, DispCorrTable )
    % Move from point to point on a cycle, with PS1, PS2 or PS3 power supply.
    % (only one at the same time)
    % To initialise the cycle, set MainPowerSupplyName to 'ps1', 'ps2' or 'ps3'
    % When initialised, go on the cycle by setting MainPowerSupplyName to ''
    % To go to 0A, down way, without breaking the cycle, set
    %   MainPowerSupplyName to 'off'. It will break the initialisation => a
    %   new one will have to be done.
    % NameOfTableToUseForCorrection is the full name (path+name) to the
    %   correction table where to get the currents to put in the correction
    %   coils. The table contains 9 columns: Main current, CHE Down, CHE
    %   Up, CHS Down, CHS Up, CVE Down, CVE Up, CVS Down, CVS Up.
    %   If no name is given, the correction currents remain unchanged!
    % If OrbitsAcquisitionDirectory='', no acquisition is done along the
    %   cycle. If it is not empty, acquisitions will be stored in the
    %   specified directory.
    % if NameOfTableToBuild='', no Correction Currents Table is built. If
    %   it is not empty, the table is saved in OrbitsAcquisitionDirectory.
    
    res=-1;
    
    debug=0;
    ListOfPS1Currents=[-500:20:500];
    ListOfPS2Currents=[-440:220:440];
    %ListOfPS2Currents=[-440:20:440];
    ListOfPS3Currents=[-360:20:360];
    CurrentRelativeTolerance=0.001;
    
    %fprintf('Alim: %s\n', MainPowerSupplyName)
    
    if (strcmp(OrbitsAcquisitionDirectory, '')==1&&strcmp(NameOfTableToBuild, '')==0)
        fprintf('You must specify an Directory where to store Orbits acquisition if you want to build a table!\n')
    end
    ScriptsDirectory=Pwd;
    if (strcmp(MainPowerSupplyName, 'ps1')==0&&strcmp(MainPowerSupplyName, 'ps2')==0&&strcmp(MainPowerSupplyName, 'ps3')==0&&strcmp(MainPowerSupplyName, '')==0&&strcmp(MainPowerSupplyName, 'off')==0)
        fprintf('MainPowerSupplyName must be '''', ''ps1'',  ''ps2'',  ''ps3'' or ''off''\n');
        return
    end

% Initialisation and moving power supplies
    if (strcmp(MainPowerSupplyName, 'ps1')==1||strcmp(MainPowerSupplyName, 'ps2')==1||strcmp(MainPowerSupplyName, 'ps3')==1) % MainPowerSupplyName='ps1' or 'ps2' or 'ps3' => The cycle will be initialised
        clear global SENSEOFCURRENT;
        clear global PRESENTCURRENT;
        clear global POWERSUPPLYNAME;
        clear global LISTOFCURRENTS;
        clear global REFORBIT;
        clear global CORRCURRTABLE;
        clear global RELATIVETOLERANCE;
        
        global SENSEOFCURRENT;
        global PRESENTCURRENT;
        global POWERSUPPLYNAME;
        global LISTOFCURRENTS;
        global REFORBIT;
        global CORRCURRTABLE;
        global RELATIVETOLERANCE;
        
        SENSEOFCURRENT=-1;
        PRESENTCURRENT=0;
        if (strcmp(MainPowerSupplyName, 'ps1')==1)
            POWERSUPPLYNAME='ps1';
            LISTOFCURRENTS=ListOfPS1Currents;
        elseif (strcmp(MainPowerSupplyName, 'ps2')==1)
            POWERSUPPLYNAME='ps2';
            LISTOFCURRENTS=ListOfPS2Currents;
        elseif (strcmp(MainPowerSupplyName, 'ps3')==1)
            POWERSUPPLYNAME='ps3';
            LISTOFCURRENTS=ListOfPS3Currents;
        end
        NumberOfCurrents=length(LISTOFCURRENTS);
        REFORBIT='';
        CORRCURRTABLE=zeros(NumberOfCurrents, 9);  % Colonnes : 1_Courant, 2_CVED, 3_CVEU, 4_CVSD, 5_CVSU, 6_CHED, 7_CHEU, 8_CHSD, 9_CHSU  (C=Corrector ; H=Horizontal ; V=Vertical ; E=Entr�e ; S=Sortie ; D=Down ; U=Up)
        if (debug==1)
            fprintf('Sens: %i ; PRESENTCURRENT: %d\n', SENSEOFCURRENT, PRESENTCURRENT)
        end
        RELATIVETOLERANCE=CurrentRelativeTolerance;
        CurrentAbsoluteTolerance=abs(PRESENTCURRENT*RELATIVETOLERANCE);
        if (strcmp(NameOfTableToUseForCorrection, '')==0)
            CorrCurrentsToPut=HU640_ExtractCorrCurrentsFromTable(NameOfTableToUseForCorrection);
            res=HU640_SetCurrentSyncCorr(PRESENTCURRENT, CurrentAbsoluteTolerance, CorrCurrentsToPut(1), CorrCurrentsToPut(2), CorrCurrentsToPut(3), CorrCurrentsToPut(4));
        else
            res=HU640_SetCurrentSync(PRESENTCURRENT, CurrentAbsoluteTolerance);
        end
        
        res=0;
    elseif  (strcmp(MainPowerSupplyName, '')==1)    % MainPowerSupplyName='' => The cycle is initialised yet. We stay on it.
        global SENSEOFCURRENT;
        global PRESENTCURRENT;
        global POWERSUPPLYNAME;
        global LISTOFCURRENTS;        
        global REFORBIT;
        global CORRCURRTABLE;
        global RELATIVETOLERANCE;
        
        ListOfCurrents=LISTOFCURRENTS;
        
        if (debug==1)
            fprintf('Sens: %i ; PRESENTCURRENT: %d ; POWERSUPPLYNAME: %s\n', SENSEOFCURRENT, PRESENTCURRENT, POWERSUPPLYNAME)
        end

        idDevServ=['ans-c05/ei/l-hu640_' POWERSUPPLYNAME];
        
        InitialCurrent=readattribute([idDevServ '/current']);
        
        %if (abs(PRESENTCURRENT-InitialCurrent)>CurrentAbsoluteTolerance)
        %    fprintf ('%s', 'The current read on the power supply dismatches from the current registered in the global variable ''PRESENTCURRENT''')
        %    return
        %end
        index=find(ListOfCurrents==PRESENTCURRENT);
        
        if (debug==1)
            fprintf('Index: %i ; Sens: %i ; PRESENTCURRENT: %d\n', index, SENSEOFCURRENT, PRESENTCURRENT)
        end

        fprintf('index : %i\tlength(ListOfCurrents) : %i\n', index, ListOfCurrents);

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
            CorrCurrentsToPut=HU640_ExtractCorrCurrentsFromTable(NameOfTableToUseForCorrection);
            res=HU640_SetCurrentSyncCorr(PRESENTCURRENT, CurrentAbsoluteTolerance, CorrCurrentsToPut(1), CorrCurrentsToPut(2), CorrCurrentsToPut(3), CorrCurrentsToPut(4));
        else
            res=HU640_SetCurrentSync(PRESENTCURRENT, CurrentAbsoluteTolerance);
        end
                
    elseif (strcmp(MainPowerSupplyName, 'off')==1)     % MainPowerSupplyName='off' => The cycle will be quickly gone on until 0A is reached by the down way.
        global SENSEOFCURRENT;
        global PRESENTCURRENT;
        global POWERSUPPLYNAME;
        global LISTOFCURRENTS;        
        global REFORBIT;
        global CORRCURRTABLE;
        global RELATIVETOLERANCE;
        %CurrentAbsoluteTolerance=abs(PRESENTCURRENT*RELATIVETOLERANCE);
        HU640_MainSetCurrent(0); %, CurrentAbsoluteTolerance);
        HU640_SetCorrectorsToZero();
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
    
       
% Orbits Acquisition
    if (strcmp(OrbitsAcquisitionDirectory, '')==0)
      pause(2);
      if (SENSEOFCURRENT==1)
          StringSenseOfCurrent='U';
      else
          StringSenseOfCurrent='D';
      end
      FileNameCore=['HU640_DESIRS_' upper(POWERSUPPLYNAME) '_' num2str(PRESENTCURRENT) '_' StringSenseOfCurrent];
      outStructElecBeam=HU640_MeasElecBeam(0, 1, [OrbitsAcquisitionDirectory filesep FileNameCore]);     %(inclPerturbMeas, dispData, fileNameCore)
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
        
        CorCurrents=HU640_CalculateCorrCur(outStructElecBeam.name, REFORBIT);
        global CORRCURRTABLE;
        
        i=find(LISTOFCURRENTS==PRESENTCURRENT);
        %CORRCURRTABLE(i, 9);  % Colonnes : 1_Courant, 2_CVED, 3_CVEU, 4_CVSD, 5_CVSU, 6_CHED, 7_CHEU, 8_CHSD, 9_CHSU
        %(C=Corrector ; H=Horizontal ; V=Vertical ; E=Entr�e ; S=Sortie ; D=Down ; U=Up)
        CORRCURRTABLE(i, 1)=PRESENTCURRENT;
        if (SENSEOFCURRENT==-1)
            CORRCURRTABLE(i, 2)=CorCurrents(1);
            CORRCURRTABLE(i, 4)=CorCurrents(2);
            CORRCURRTABLE(i, 6)=CorCurrents(3);
            CORRCURRTABLE(i, 8)=CorCurrents(4);
            if (i==1)
                CORRCURRTABLE(1, 3)=CORRCURRTABLE(1, 2);
                CORRCURRTABLE(1, 5)=CORRCURRTABLE(1, 4);
                CORRCURRTABLE(1, 7)=CORRCURRTABLE(1, 6);
                CORRCURRTABLE(1, 9)=CORRCURRTABLE(1, 8);
            end
        elseif (SENSEOFCURRENT==1)
            CORRCURRTABLE(i, 3)=CorCurrents(1);
            CORRCURRTABLE(i, 5)=CorCurrents(2);
            CORRCURRTABLE(i, 7)=CorCurrents(3);
            CORRCURRTABLE(i, 9)=CorCurrents(4);
            if (i==length(LISTOFCURRENTS))
                CORRCURRTABLE(i, 2)=CORRCURRTABLE(i, 3);
                CORRCURRTABLE(i, 4)=CORRCURRTABLE(i, 5);
                CORRCURRTABLE(i, 6)=CORRCURRTABLE(i, 7);
                CORRCURRTABLE(i, 8)=CORRCURRTABLE(i, 9);
            end
        end
        
        fid=fopen([OrbitsAcquisitionDirectory filesep NameOfTableToBuild], 'w+');
        fprintf(fid, '%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\t%8s\n', 'Current', 'CHE D', 'CHE U', 'CHS D', 'CHS U', 'CVE D', 'CVE U', 'CVS D', 'CVS U');
        for (i=1:size(CORRCURRTABLE, 1))
            fprintf(fid, '%+08.3f\t', CORRCURRTABLE(i, :));
            fprintf(fid, '\n');
        end
        fclose(fid);
        if (DispCorrTable~=0)
            Table=CORRCURRTABLE
        end
    end     % end of build table
    
    if (strcmp(NameOfTableToBuild, '')==1&&strcmp(OrbitsAcquisitionDirectory, '')==1)
        
        idDevServ=['ans-c05/ei/l-hu640_' POWERSUPPLYNAME];

        SetCurrent=readattribute([idDevServ '/current']);
        fprintf('Asked current: %7.3f A\tObtained current: %7.3f A\n', PRESENTCURRENT, SetCurrent)
    end
    
    res=0;
end
%return
    