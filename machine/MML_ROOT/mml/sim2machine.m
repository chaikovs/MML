function sim2machine
%SIM2MACHINE - Sets the AT configuration to the online machine
%
%  Equivalent to:
%  ConfigSetpoint = getmachineconfig('Simulator');
%  setmachineconfig(ConfigSetpoint, 'Online');
%
%  See Also sim2machine, golden2sim

%
%  Written by Gregory J. Portmann 


% Get from the simulator
ConfigSetpoint = getmachineconfig('Simulator');


tmp = questdlg({ ...
        'sim2machine change all the lattice magnet setpoint in the storage ring', ...
        ' ', ...
        'Are you sure you want to do this?'}, ...
    'SIM2MACHINE','YES','NO','NO');

if strcmpi(tmp,'YES')
    % Set from the online machine
    setmachineconfig(ConfigSetpoint, 'Online');
else
    fprintf('   No change made to the Physics Data Structure\n');
    return
end

