function res=idApplyCommandOnInsertions(Command, Types, SubDevice)
    res=-1;
    
    timeToWaitAfterSucceed_s=1;
    timeToWaitBeforeRetry_s=2;
    maxNumberIterationsForRetry=3;
    lengthUndNames=20;
    lengthResult=10;
    lengthState=6;
    ListOfUndulators=idGetListOfInsertionDevices(Types);
    
    NbUndulators=size(ListOfUndulators, 1);
       
    for iUnd=1:NbUndulators
        idName=ListOfUndulators{iUnd, 1};
              
        DeviceServer=idGetUndDServer(idName);
        if ~isempty(SubDevice)
            if strcmpi(SubDevice, 'FFW') || strcmpi(SubDevice, 'OFFF')
                DeviceServer=[DeviceServer '_OFFF'];
            end
        end
        State=tango_state(DeviceServer);
        StateBefore=State.name;
        
        i=1;
        continueCondition=1;
        while (continueCondition)
            resValue=tango_command_inout(DeviceServer, Command);
            if resValue==-1
                resString='FAILED';
                i=i+1;
                continueCondition = (i<maxNumberIterationsForRetry);
                if continueCondition
                	pause (timeToWaitBeforeRetry_s);
                end
            else
                resString='succeeded';
                pause (timeToWaitAfterSucceed_s);
                continueCondition=0;
            end
        end
        State=tango_state(DeviceServer);
        StateAfter='';  % not understood but necessary... 
        if ~isempty(State)
            if isstruct(State)
                StateAfter=State.name;
            end
        end
        
        fprintf ('%s\t %s %s :\t %s --> %s\n', increaseString([idName ':'], lengthUndNames, 'l'), Command, increaseString(resString, lengthResult, 'l'), increaseString(StateBefore, lengthState, 'l'), increaseString(StateAfter, lengthState, 'l'));
        res=0;
    end
    return
end

function res=increaseString(inputString, n, justify)
    if findstr('l', justify)
        justify='left';
    elseif findstr('r', justify)
        justify='right';
    elseif findstr('c', justify)
        justify='center';
    else
        justify='';
    end
    outputString=sprintf('%*s', n, inputString);
    if ~isempty(justify)
        res=strjust(outputString, justify);
    end
    return
end