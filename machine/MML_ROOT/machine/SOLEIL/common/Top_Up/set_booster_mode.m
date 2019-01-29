function set_booster_mode(mode)
% mode = eco, on, off
% set setpoint relative to mode to Dipole, Qpole and sextupole

switch mode
    case 'eco'
       boo.DIPcurrent = 50 ;
       boo.QFcurrent  = 50 ;
       boo.QDcurrent  = 50 ;
       boo.SFcurrent  = 0  ;
       boo.SDcurrent  = 0  ;
    case 'on'
       boo.DIPcurrent = 545 ;
       boo.QFcurrent  = 201.765 ;
       boo.QDcurrent  = 162.611 ;
       boo.SFcurrent  = 15.  ;
       boo.SDcurrent  = 10.42  ;
    otherwise
       return
end

tango_write_attribute('BOO/AE/dipole','current',       boo.DIPcurrent);
tango_write_attribute('BOO/AE/QF','current',           boo.QFcurrent);
tango_write_attribute('BOO/AE/QD','current',           boo.QDcurrent);
tango_write_attribute('BOO/AE/SF','current',           boo.SFcurrent);
tango_write_attribute('BOO/AE/SD','current',           boo.SDcurrent);
% writeattribute('BOO/AE/dipole','waveformOffset',boo.DIPoffset);
% writeattribute('BOO/AE/QF','waveformOffset',    boo.QFpoffset);
% writeattribute('BOO/AE/QD','waveformOffset',    boo.QDpoffset);
% writeattribute('BOO/AE/SF','waveformOffset',    boo.SFpoffset);
% writeattribute('BOO/AE/SD','waveformOffset',    boo.SDpoffset);
