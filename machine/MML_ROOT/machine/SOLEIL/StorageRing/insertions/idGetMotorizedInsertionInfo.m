function res=idGetMotorizedInsertionInfo(idName, info)
    res=' ';
    
    if strcmp(idName, 'HU65_DEIMOS')
        SendCommandName='TlccSendCommand';
    else
        SendCommandName='SendCommand';
    end
    
    idDirectory=getfamilydata('Directory', idName);
    if isempty(idDirectory)
        fprintf ('idGetMotorizedInsertionInfo : idName ''%s'' is wrong!\n', idName)
        return
    end
    DeviceServer=idGetUndDServer(idName);
    
    % READPARAMS1
    ListData1={'InsertionType', 'MaxAxis', 'PosMode', 'Safety', 'ValidCorrectPos', 'ValidScanError', 'ValidLinearEncoder', 'GboError', 'BacklashValue', 'GapVel', 'Reserved', 'PhaseLevel', 'GapOffset', 'GapValue'};
    NbData1=length(ListData1);
    answer1=tango_command_inout(DeviceServer, SendCommandName, 'READPARAMS1');
    if ~strncmp(answer1, 'READPARAMS1 ', 12)
        fprintf ('idGetMotorizedInsertionInfo : wrong answer from TLCC for READPARAMS1 for ID %s\n', idName)
        return
    end
    answer1=answer1(13:length(answer1));
    Values1=sscanf(answer1, '%u');
    if length(Values1)~=NbData1
        fprintf ('idGetMotorizedInsertionInfo : wrong data format from TLCC for READPARAMS1 for ID %s\n', idName)
        return
    end
    
    % READPARAMS2
    ListData2={'LeftPhaseValue', 'RightPhaseValue', 'MaxGap', 'MinGap', 'MaxBacklashDistance', 'MaxTaper', 'MaxPhase', 'MinPhase', 'Accel', 'Decel', 'WindowQty', 'WindowPos', 'Unknown', 'Unknown'};
    NbData2=length(ListData2);
    answer2=tango_command_inout(DeviceServer, SendCommandName, 'READPARAMS2');
    if ~strncmp(answer2, 'READPARAMS2 ', 12)
        fprintf ('idGetMotorizedInsertionInfo : wrong answer from TLCC for READPARAMS2 for ID %s\n', idName)
        return
    end
    answer2=answer2(13:length(answer2));
    Values2=sscanf(answer2, '%u');
    if length(Values2)~=NbData2
        fprintf ('idGetMotorizedInsertionInfo : wrong data format from TLCC for READPARAMS2 for ID %s\n', idName)
        return
    end
    
    % READSTATUS
    ListDataStatus={'Power', 'Moving Gap', 'Moving Phase', 'Moving Offset', 'Alarm', 'Fault', 'Gap Open', 'Gap Closed', 'Warning', 'Ready', 'EMPHU Fan'};
    NbDataStatus=length(ListDataStatus);
    answerStatus=tango_command_inout(DeviceServer, SendCommandName, 'READSTATUS');
    if ~strncmp(answerStatus, 'READSTATUS ', 11)
        fprintf ('idGetMotorizedInsertionInfo : wrong answer from TLCC for READSTATUS for ID %s\n', idName)
        return
    end
    answerStatus=str2double(answerStatus(12:length(answerStatus)));
%     ValuesStatus=dec2bin(answerStatus, 16);
    ValuesStatus=NumberToArrayOfBits(answerStatus, 16);
    ValuesStatus=fliplr(ValuesStatus);
    
    % READINPUT (sécurités)
    ListDataInput={'MaxGap1', 'MaxGap2', 'MaxGap3', 'MaxGap4', 'MinGap1', 'MinGap2', 'MinGap3', 'MinGap4', 'PSW1', 'PSW2', 'PSW3', 'PSW4', 'VCSW1', 'VCSW2', 'VCSW3', 'VCSW4', 'TSW1', 'TSW2', 'Emergency1', 'Emergency2'};
    NbDataInput=length(ListDataInput);
    answerInput=tango_command_inout(DeviceServer, SendCommandName, 'READINPUT');
    if ~strncmp(answerInput, 'READINPUT ', 10)
        fprintf ('idGetMotorizedInsertionInfo : wrong answer from TLCC for READINPUT for ID %s\n', idName)
        return
    end
    answerInput=str2double(answerInput(11:length(answerInput)));
    %==============================
%     res=answerInput;
%     return
    %==============================
    
%     ValuesInput=dec2bin(answerInput, 28);
    ValuesInput=NumberToArrayOfBits(answerInput, 28);
    ValuesInput=fliplr(ValuesInput);
    %==============================
%     res=ValuesInput;
%     return
    %==============================
    
    
    % FB
    answerFB=tango_command_inout(DeviceServer, SendCommandName, 'GETFBMODE');
    if ~strncmp(answerFB, 'GETFBMODE ', 10)
        fprintf ('idGetMotorizedInsertionInfo : wrong answer from TLCC for GETFBMODE for ID %s\n', idName)
        return
    end
    answerFB=answerFB(11:length(answerFB));
    GapFB=str2double(answerFB(1));
    PhaseFB=str2double(answerFB(2));
        
    if isempty(info)
        for j=1:4
            if j==1
                NbData=NbData1;
                ListData=ListData1;
                Values=Values1;
            elseif j==2
                NbData=NbData2;
                ListData=ListData2;
                Values=Values2;
            elseif j==3
                NbData=NbDataStatus;
                ListData=ListDataStatus;
                Values=ValuesStatus;
            elseif j==4
                NbData=NbDataInput;
                ListData=ListDataInput;
                Values=ValuesInput;
            end
            for i=1:NbData
                Label=ListData{i};
                if ischar(Values)
                    Value=str2double(Values(length(Values)-i+1));
                else
                    Value=Values(i);
                end
                fprintf ('%s : %u\n', Label, Value)
            end
        end
        fprintf ('FB Gap : %u\nFB Phase : %u\n', GapFB, PhaseFB)
        
        %res=x;
        return
    else
        InfoFound1=FindStringInCell(info, ListData1);
        InfoFound2=FindStringInCell(info, ListData2);
        InfoFoundStatus=FindStringInCell(info, ListDataStatus);
        InfoFoundInput=FindStringInCell(info, ListDataInput);
        if InfoFound1~=-1
            res=Values1(InfoFound1);
        elseif InfoFound2~=-1
            res=Values2(InfoFound2);
        elseif InfoFoundStatus~=-1
            res=ValuesStatus(InfoFoundStatus);
        elseif InfoFoundInput~=-1
            res=ValuesInput(InfoFoundInput);
        elseif strcmp(info, 'FB Gap')
            res=GapFB;
        elseif strcmp(info, 'FB Phase')
            res=PhaseFB;
        end
    end
end

function res=FindStringInCell(StringToFind, CellOfStrings)
    n=length(CellOfStrings);
    res=-1;
    for i=1:n
        if strcmp(StringToFind, CellOfStrings{i})
            res=i;
            return
        end
    end
    return
end

function res=NumberToArrayOfBits(inputDecimalNumber, minNumberOfBits)
    res=-1;
    binString=dec2bin(inputDecimalNumber, minNumberOfBits);
    res=nan(1, length(binString));
    for i=1:length(binString)
        res(i)=str2double(binString(i));
    end
    return
end
    