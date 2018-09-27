function res=idChangeAttributeOnInsertions(Types, SubDevice, Attribute, Value)
    res=-1;
    
    timeToWaitAfterSucceed_s=1;
    timeToWaitBeforeRetry_s=2;
    maxNumberIterationsForRetry=3;
    lengthUndNames=20;
    lengthResult=10;
    lengthAttribute=6;
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
%         State=tango_state(DeviceServer);
%         StateBefore=State.name;

        Structure=tango_read_attribute(DeviceServer, Attribute);

        if isnumeric(Structure)
            if Structure==-1    % Failed
                if isnumeric(Value)
                    AttributeBefore=nan;
                else
                    AttributeBefore='x';
                end
            end
        elseif isstruct(Structure)
            
            if isnumeric(Value)
                Field=Structure.value;
                AttributeBefore=Field(1);
            else
                AttributeBefore=Structure.name;
            end
        end
        i=1;
        continueCondition=1;
        while (continueCondition)
%             resValue=tango_command_inout(DeviceServer, Command);
            tango_write_attribute(DeviceServer, Attribute, Value);
            if tango_error==-1
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
%         State=tango_state(DeviceServer);
%         StateAfter='';  % not understood but necessary... 
%         if ~isempty(State)
%             if isstruct(State)
%                 StateAfter=State.name;
%             end
%         end

        Structure=tango_read_attribute(DeviceServer, Attribute);
        if isnumeric(Structure)
            if Structure==-1
                if isnumeric(Value)
                    AttributeAfter=nan;
                else
                    AttributeAfter='x';
                end
            end
        else
            
            if isnumeric(Value)
                Field=Structure.value;
                AttributeAfter=Field(1);
            else
                AttributeAfter=Structure.name;
            end
        end
        
        if isnumeric(Value)
            fprintf ('%s\t %s %s :\t %s --> %s\n', increaseString([idName ':'], lengthUndNames, 'l'), Attribute, increaseString(resString, lengthResult, 'l'), increaseString(num2str(AttributeBefore), lengthAttribute, 'l'), increaseString(num2str(AttributeAfter), lengthAttribute, 'l'));
        else
            fprintf ('%s\t %s %s :\t %s --> %s\n', increaseString([idName ':'], lengthUndNames, 'l'), Attribute, increaseString(resString, lengthResult, 'l'), increaseString(AttributeBefore, lengthAttribute, 'l'), increaseString(AttributeAfter, lengthAttribute, 'l'));
        end
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