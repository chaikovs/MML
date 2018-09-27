function res=HU256_GoOnCycling(MainPowerSupplyName, CurrentAbsoluteTolerance, OrbitsAcquisition)
    % Move from point to point on a cycle, with BZP power supply or with
    % BX1 and BX2 power supplies.
    % To initialise the cycle, set MainPowerSupplyName to 'bz' or 'bx'
    % When initialised, go on the cycle by setting MainPowerSupplyName to ''
    % To go to 0A, down way, without breaking the cycle, set
    % MainPowerSupplyName to 'off'
    
    res=-1;
    
    debug=0;
    ListOfZCurrents=[-200:20:200];
    ListOfXCurrents=[0:25:275];

    ScriptsDirectory=Pwd;
    if (strcmp(MainPowerSupplyName, 'bz')==0&&strcmp(MainPowerSupplyName, 'bx')==0&&strcmp(MainPowerSupplyName, '')==0&&strcmp(MainPowerSupplyName, 'off')==0)
        fprintf('%s', 'MainPowerSupplyName must be '''', ''bz'',  ''bx'' or ''off''');
        return
    end
    
    if (strcmp(MainPowerSupplyName, 'bz')==1||strcmp(MainPowerSupplyName, 'bx')==1) % MainPowerSupplyName='bz' or 'bx' => The cycle will be initialised
        clear global SENSEOFCURRENT;
        clear global PRESENTCURRENT;
        clear global POWERSUPPLYNAME;
        global SENSEOFCURRENT;
        global PRESENTCURRENT;
        global POWERSUPPLYNAME;
        SENSEOFCURRENT=-1;
        PRESENTCURRENT=0;
        if (strcmp(MainPowerSupplyName, 'bz')==1)
            POWERSUPPLYNAME='bz';
        else
            POWERSUPPLYNAME='bx';
        end
        
        if (debug==1)
            fprintf('Sens: %i ; PRESENTCURRENT: %d\n', SENSEOFCURRENT, PRESENTCURRENT)
        end
        
        res=0;
    elseif  (strcmp(MainPowerSupplyName, '')==1)    % MainPowerSupplyName='' => The cycle is initialised yet. We stay on it.
        global SENSEOFCURRENT;
        global PRESENTCURRENT;
        global POWERSUPPLYNAME;
        
            
        if (strcmp(POWERSUPPLYNAME, 'bz')==1)
            ListOfCurrents=ListOfZCurrents;
        elseif (strcmp(POWERSUPPLYNAME, 'bx')==1)
            ListOfCurrents=ListOfXCurrents;
        end

        if (debug==1)
            fprintf('Sens: %i ; PRESENTCURRENT: %d ; POWERSUPPLYNAME: %s\n', SENSEOFCURRENT, PRESENTCURRENT, POWERSUPPLYNAME)
        end

        idDevServ=['ANS-C15/EI/m-HU256.2-', upper(POWERSUPPLYNAME)];
        if (strcmp(POWERSUPPLYNAME, 'bz'))==1
            idDevServ=[idDevServ 'P'];
        else
            idDevServ=[idDevServ '1'];
        end
        InitialCurrent=readattribute([idDevServ '/current']);
        
        
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
        
        res=idSetCurrentSync_HU256(PRESENTCURRENT, CurrentAbsoluteTolerance);
                
    elseif (strcmp(MainPowerSupplyName, 'off')==1)     % MainPowerSupplyName='off' => The cycle will be quickly gone on until 0A is reached by the down way.
        HU256_MainSetCurrent(0, CurrentAbsoluteTolerance);
end

    if (OrbitsAcquisition==1)
      pause(2);
      FileNameCore=['HU256_CASSIOPEE_' upper(POWERSUPPLYNAME) '_' num2str(PRESENTCURRENT)];
      HU256_MeasElecBeam(0, 1, FileNameCore);     %(inclPerturbMeas, dispData, fileNameCore)
end
%return
    