function Result=AnalogGetACDC(PowerSupply, Cell)
% Checks the status of the Device1 of the specified power supply of the specified HU256
% Returns the mode : AC or DC
% Returns '' (empty string) in case of mistake
% Written by F.Briquez, 29/04/2008


    Result='';
    if (strcmpi(PowerSupply, 'bzp'))
        PowerSupplyName='BZP';
        Token={'Set Value Internal : '};
        Reverse=0;
    elseif (strcmpi(PowerSupply, 'bx1'))
        PowerSupplyName='BX1';
        Token={'Set Value Internal : '};
        Reverse=0;
    elseif (strcmpi(PowerSupply, 'bx2'))
        PowerSupplyName='BX2';
        Token={'Set Value Internal : '};
        Reverse=0;
    elseif (strcmpi(PowerSupply, 'shim1'))
        PowerSupplyName='Shim.1';
        Token={'CH1ref: ', 'CH2ref: ', 'CH3ref: ', 'CH4ref: ', 'CH5ref: ', 'CH6ref: ', 'CH7ref: ', 'CH8ref: '};
        Reverse=1;
    elseif (strcmpi(PowerSupply, 'shim2'))
        PowerSupplyName='Shim.2';
        Token={'CH1ref: ', 'CH2ref: ', 'CH3ref: ', 'CH4ref: ', 'CH5ref: ', 'CH6ref: ', 'CH7ref: ', 'CH8ref: '};
        Reverse=1;
    elseif (strcmpi(PowerSupply, 'shim3'))
        PowerSupplyName='Shim.3';
        Token={'CH1ref: ', 'CH2ref: ', 'CH3ref: ', 'CH4ref: ', 'CH5ref: ', 'CH6ref: ', 'CH7ref: ', 'CH8ref: '};
        Reverse=1;
    else
        fprintf('PowerSupply should be ''bzp'', ''bx1'', ''bx2'', ''shim1'', ''shim2'' or ''shim3''. (No care of case)\n')
        return
    end
    
    if (Cell~=4&&Cell~=12&&Cell~=15)
        fprintf('Cell must be 4 (PLEIADES), 12 (ANTARES) or 15 (CASSIOPEE)\n')
        return
    end
    
    BaseName=sprintf('ANS-C%02.0f/EI/M-HU256.2_', Cell);
    DevServName=[BaseName PowerSupplyName];
    Status=tango_command_inout2(DevServName, 'Status');
    StatusLength=size(Status, 2);
%     fprintf('**Debug Token** %s\n', Token)
    TempResult=cell(1, size(Token, 2));
    for i=1:size(Token, 2)
%         fprintf('**Debug Token{i}** %s\n', Token{i})
        TokenLength=size(Token{i}, 2);
%         TempString=Status;
            Index=findstr(Status, Token{i})+TokenLength;
            TempString=strtok(Status(Index:StatusLength));
%             TempString
            
        TempString=strtok(TempString);
        if (strcmpi(TempString, 'AC')==0&&strcmpi(TempString, 'DC')==0)
            Index=findstr(TempString, '(');
            TempStringLength=size(TempString, 2);
            TempString=strtok(TempString(Index+1:TempStringLength));
        end
        if (size(TempString, 2)>2)
            TempString=TempString(1:2);
        end
        if (strcmpi(TempString, 'AC')==0&&strcmpi(TempString, 'DC')==0)
            fprintf('AnalogGetACDC : Error\n')
            return
        end
        TempResult{i}=TempString;
%         TempResult{i, 2}=TempRemain;
    
    end
    TempSize=size(TempResult, 2);
    if (TempSize~=1)
        for i=2:TempSize
            if (strcmp(TempResult{i}, TempResult{1})==0)
                fprintf ('AnalogGetACDC : All chanels have not the same mode\n')
                return
            end
        end
    end
    Result=TempResult{1};
    if (Reverse==1)
        if (strcmpi(Result, 'ac'))
            Result='DC';
        else
            Result='AC';
        end
    end
end
    