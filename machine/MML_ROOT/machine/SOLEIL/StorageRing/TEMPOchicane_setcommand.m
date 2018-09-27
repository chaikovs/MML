function TEMPOchicane_setcommand(commandName)
% TEMPOchicane_setcommand - send a command for all three power supplies of
% the TEMPO chicane
%
%  INPUTS - commandName, ex 'On', 'Off'
%
%  See Also TEMPOchicane_gui

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Query to begin measurement %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DisplayFlag = 'Display';

if strcmpi(DisplayFlag, 'Display')
    tmp = questdlg(sprintf('Send command %s', commandName), ...
        'TEMPOCHICANE','Yes','No','No');
    if strcmpi(tmp,'No')
        fprintf(sprintf('Warning: command %s cancelled by user\n', commandName));
        return
    end
end

deviceName = getfamilydata('TEMPOC','DeviceName');

fprintf('Setcommand %s on Chicane \n', commandName);

% Do not switch off power supplies if current is not zero
if strcmpi(commandName, 'Off')
    % check current are zero
    errorLevel = 1e-6;
    if any(abs(getsp('TEMPOC'))> errorLevel) 
       warning('Off command cancelled for current setpoint non zero')
       return;
    end
end

for ik=1:3,
    tango_command_inout2(deviceName{ik}, commandName);
end