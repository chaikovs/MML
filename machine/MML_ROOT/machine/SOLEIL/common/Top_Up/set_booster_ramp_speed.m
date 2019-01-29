function set_booster_ramp_speed(dt)
% set delay for booster power supply
% default = 5 s
% fast = 1 s
% dt en seconde

laps0=tango_get_device_property('BOO/AE/Dipole', 'StepTime');
fprintf('Laps initial= %s  µs \n',laps0{1})

laps=num2str(dt*1000);
tango_put_property2('BOO/AE/Dipole', 'StepTime',{laps})
tango_put_property2('BOO/AE/QD' , 'StepTime',{laps})
tango_put_property2('BOO/AE/QF' , 'StepTime',{laps})
tango_put_property2('BOO/AE/SD' , 'StepTime',{laps})
tango_put_property2('BOO/AE/SF' , 'StepTime',{laps})
fprintf('Laps = %s  µs\n',laps)