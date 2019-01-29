function res=HU256_TestShutDown(beamLineName)
%% Redemarrage d'un HU256 après un AT.
% A terminer
% F. Briquez, 23/08/2017
    res=-1;

    timeToWaitPerIteration_s=10;
    maxNbIterations=3;

    idName=['HU256_' beamLineName];
    deviceName=idGetUndDServer(idName);

    tango_ping(deviceName);
    if tango_error==-1
        fprintf ('Device not running for %s\n', idName)
        return
    else
        fprintf ('%s : device running \n', idName)
    end

    structure=tango_state(deviceName);
    if isempty(structure) || ~isstruct(structure)
        fprintf ('Could not get state of %s\n', idName)
        return
    else
        stateAtStart=structure.name;
        fprintf ('%s : state = %s\n', idName, stateAtStart)
    end

    
    if strcmpi(stateAtStart, 'FAULT')

        % Regarder status
        
        % Cas 1 : probleme de com

        statusString=tango_status(deviceName);

        [found, lineAfterLabel] = HU256_FindStringInStatus(statusString, 'SPI status:', 'unknown');

        if found == -1  % le status n'a pas la forme attendue
            return
        end

        if found == 0
            fprintf ('Communication problem on %s --> Init\n', idName)

            tango_command_inout(deviceName, 'Init');

            continueCondition=1;
            iteration=1;

            while (continueCondition)
                structure=tango_state(deviceName);
                state=structure.name;

                continueCondition = strcmpi(state, 'FAULT') && iteration<maxNbIterations ;

                pause(timeToWaitPerIteration_s)

            end

        end


%         tango_read_attribute('ans-c15/ei/m-hu256.2', 'functioningModeStr')
% 
% ans = 
% 
%            name: 'functioningModeStr'
%         quality: 0
%     quality_str: 'VALID'
%               m: 1
%               n: 28
%            time: 7.3693e+05
%           value: 'UNKNOWN OR NOT LISTED MODE ['
%      has_failed: 0
%           error: []
%         

% Disable


% Tables missing => upload

% on

%=> Fault

% Enable



% 

    elseif strcmpi(state, 'OFF')
    end


        
end

function [found, lineAfterLabel] = HU256_FindStringInStatus(statusString, labelString, stringToFind)

    found=-1;

    posStart=strfind(statusString, labelString);
    if isempty(posStart)
        fprintf ('Wrong status\n')
        return
    end
    partOfString=statusString(posStart(1)+length(labelString):length(statusString));
    posEnd=strfind(partOfString, char(10));
    lineAfterLabel=partOfString(1:posEnd(1)-1);
    
    findResult=strfind(lineAfterLabel, stringToFind);
        
    found=length(findResult);
    
    return
end

function res=HU256CheckCycles(beamLineName)
    
    res=-1;

    idName=['HU256_' beamLineName];
    deviceName=idGetUndDServer(idName);
    unix ['atktrend /home/data/GMI/Points_Redemarrage/Config_Trend_HU256_' upper(beamLineName) '.txt &'];
    
    tango_write_attribute(deviceName, 'functioningMode', 1);
    
    
    mode=tango_read_attribute(deviceName, 'functioninModeStr');
    if tango_error==-1
        return
    end
        
end

function res=HU256ChangeMode(beamLineName, modeString)
    res=-1;
    
    timeToWaitPerIteration_s=5;
    maxNbIterations=60;
    
    if strcmpi(modeString, 'LV')
        mode=0;
    elseif strcmpi(modeString, 'LH')
        mode=1;
    elseif strcmpi(modeString, 'AV')
        mode=2;
    elseif strcmpi(modeString, 'AH')
        mode=3;
    elseif strcmpi(modeString, 'CR')
        mode=4;
    else
        fprintf ('Wrong mode\n')
        return
    end
    
    idName=['HU256_' beamLineName];
    deviceName=idGetUndDServer(idName);
    
    structure=tango_read_attribute(deviceName, 'functioninModeStr');
    if tango_error==-1
        return
    end
    value=structure.value;
    actualMode=value(1);
    if strcmpi(actualMode, mode)
        res=0;
        return
    end
        
    tango_write_attribute(deviceName, 'functioningMode', mode);
    if tango_error==-1
        fprintf ('Error while setting mode %s on %s\n', modeString, idName);
        return
    end
    
    continueCondition=1;
    iteration=1;
    
    while (continueCondition)
        structure=tango_read_attribute(deviceName, 'functioninModeStr');
        value=structure.value;
        actualMode=value(1);
        continueCondition = ~strcmpi(actualMode, mode) && iteration<maxNbIterations ;
        
        if continueCondition
            pause(timeToWaitPerIteration_s);
        end
    end
    if actualMode==mode
        res=0;
    end
    return
end

function res=HU256SetCurrent(beamLineName, setPoint, modeString)
    res=-1;
    
    timeToWaitPerIteration_s=5;
    maxNbIterations=60;
        
    if strcmpi(modeString, 'LV')
        attributeName=currentBX1;
    elseif strcmpi(modeString, 'LH')
        attributeName=currentBZP;
    elseif strcmpi(modeString, 'AV')
        attributeName=currentBX1;
    elseif strcmpi(modeString, 'AH')
        attributeName=currentBZP;
    elseif strcmpi(modeString, 'CR')
        % Not supported
    else
        fprintf ('Wrong mode\n')
        return
    end
    
    if strcmpi(attributeName, 'BX1')
        tolerance=0.01; % A
    else
        tolerance=0.05; % A
    end
    
    idName=['HU256_' beamLineName];
    deviceServer=idGetUndDServer(idName);
    
    structure=tango_read_attribute(deviceName, attributeName);
    if tango_error==-1
        return
    end
    vector=structure.value;
    current=vector(1);
    if abs(current-setPoint)<=tolerance
        res=0;
        return
    end
        
    res=tango_write_attribute(deviceName, attributeName, setPoint);
    if res==-1
        fprintf ('Error while setting mode %s on %s\n', modeString, beamLineName);
        return
    end
    
    continueCondition=1;
    iteration=1;
    
    while (continueCondition)
        structure=tango_read_attribute(deviceName, attributeName);
        vector=structure.value;
        current=vector(1);
        continueCondition = abs(current-setPoint)>tolerance && iteration<maxNbIterations ;
        
        if continueCondition
            pause(timeToWaitPerIteration_s);
        end
    end
    if abs(value-setPoint)<=tolerance
        res=0;
    end
    return
end

function res=HU256_Status_ComIsOk(deviceName)
    res=-1;
    statusString=tango_status(deviceName);
    [found1, ~] = HU256_FindStringInStatus(statusString, 'profibus server status:', 'communication OK');
    [found2, ~] = HU256_FindStringInStatus(statusString, 'profibus proxy status:', 'communication is up and running');
        
    if found1 && found2
        res=0;
    end
    
    % profibus server status:  communication OK
    
    % profibus proxy status: profibus::Proxy::pfbs_exec_read_slave_inputs::failed to execute <ReadSlaveInputs> on profibus server ANS-C12/EI/DP.2 [tango ex. caught - see device log for details]
    % profibus proxy status: profibus communication is up and running -
    % connected to profibus server ANS-C12/EI/DP.2
    return
end

function res=HU256_Status_SpiIsOk(deviceName)
    res=-1;
    statusString=tango_status(deviceName);
    [found, ~] = HU256_FindStringInStatus(statusString, 'SPI status:', 'ready to accept request');
    if found
        res=0;
    end
    return
    % SPI status: unknown - could not obtain the SPI status byte!
    % SPI status: ready to accept request
end

function res=HU256_Status_PsAreOn(deviceName)
    res=-1;
    statusString=tango_status(deviceName);
    [found1, ~] = HU256_FindStringInStatus(statusString, 'main power supplies status:', 'all ps are ON');
    [found2, ~] = HU256_FindStringInStatus(statusString, 'corrector power supplies status:', 'all ps are ON');
    if found1 && found2
        res=0;
    end
    return
    % main power supplies status: all ps are ON
    % corrector power supplies status: all ps are ON
    % main power supplies : at least one ps is NOT in analog control mode (AC) - fix the problem!
    % main power supplies : at least one ps is NOT in analog control mode (AC)
    % - fix the problem!
    % main power supplies status: at least one ps is OFF
    % corrector power supplies status: at least one ps is OFF
end

function res=HU256_Status_TableAreUploaded(deviceName)
    res=-1;
    statusString=tango_status(deviceName);
    [found1, ~] = HU256_FindStringInStatus(statusString, 'profibus server status:', 'communication OK');
    [found2, ~] = HU256_FindStringInStatus(statusString, 'profibus proxy status:', 'communication is up and running');
        
    if found1 && found2
        res=0;
    end
    
    % profibus server status:  communication OK
    
    % profibus proxy status: profibus::Proxy::pfbs_exec_read_slave_inputs::failed to execute <ReadSlaveInputs> on profibus server ANS-C12/EI/DP.2 [tango ex. caught - see device log for details]
    % profibus proxy status: profibus communication is up and running -
    % connected to profibus server ANS-C12/EI/DP.2
    return
end


% LH Correction Tables: missing
% LV Correction Tables: missing
% AH Correction Tables: missing
% AV Correction Tables: missing
% CR Correction Tables: missing
% 
% TR LH->AH Correction Tables: missing
% TR AH->LH Correction Tables: missing
% TR C->LH Correction Tables: missing
% TR LH->C Correction Tables: missing
% TR LH->LV Correction Tables: missing
% TR LV->LH Correction Tables: missing
% TR AV->LH Correction Tables: missing
% TR LH->AV Correction Tables: missing
% LH Correction Tables: uploaded
% LV Correction Tables: uploaded
% AH Correction Tables: uploaded
% AV Correction Tables: uploaded
% CR Correction Tables: uploaded
% 
% TR LH->AH Correction Tables: uploaded
% TR AH->LH Correction Tables: uploaded
% TR C->LH Correction Tables: uploaded
% TR LH->C Correction Tables: uploaded
% TR LH->LV Correction Tables: uploaded
% TR LV->LH Correction Tables: uploaded
% TR AV->LH Correction Tables: uploaded
% TR LH->AV Correction Tables: uploaded
% 

