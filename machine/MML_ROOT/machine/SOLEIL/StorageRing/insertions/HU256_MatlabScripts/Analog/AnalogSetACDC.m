function OutPut=AnalogSetACDC(AC_Or_DC, Cell)
% Set the power supplies of the specified HU256 to AC or DC mode, depending on AC_Or_DC value
% Returns 1 if ok, -1 if mistake
% Written by F. Briquez, 29/04/2008

    OutPut=-1;
    PowerSuppliesNames={'BX1','BX2', 'BZP', 'Shim.1', 'Shim.2', 'Shim.3'};
%     AC_Strings={'Ac', 'Ac', 'AC', 'AC', 'AC', 'AC'};
    AC_Strings={'AC', 'AC', 'AC', 'AC', 'AC', 'AC'};
%     DC_Strings={'Dc', 'Dc', 'DC', 'DC', 'DC', 'DC'};
    DC_Strings={'DC', 'DC', 'DC', 'DC', 'DC', 'DC'};
    NumberOfChannels=[1, 1, 1, 5, 5, 6];
    NumberOfPowerSupplies= size(PowerSuppliesNames,2);
    BaseName=sprintf('ANS-C%02.0f/EI/M-HU256.2_', Cell)
    
    for i=1:NumberOfPowerSupplies
        TempDevServName=[BaseName PowerSuppliesNames{i}];
        if (strcmp(AC_Or_DC, 'AC'))
            Function=['Set' AC_Strings{i} 'Mode'];
        elseif (strcmp(AC_Or_DC, 'DC'))
            Function=['Set' DC_Strings{i} 'Mode'];
        else
            fprintf ('''AC_Or_DC'' must be ''AC'' or ''DC''\n')
            return
        end
        TempNumberOfChannels=NumberOfChannels(i)
        for Channel=1:TempNumberOfChannels
%             fprintf (['***' Function '****\n'])
%             tango_command_inout2(TempDevServName, Function, int16(Channel));
            tango_command_inout2(TempDevServName, Function, Channel);
        end
    end
    fprintf (sprintf('Power Supplies of HU256 in Cell %02.0f set to %s\n', Cell, AC_Or_DC))
    OutPut=1;
end
    