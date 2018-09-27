function errorCode = TEMPOchicane_statuscheck

errorCode =1; %
devLockName = getfamilydata('TANGO', 'SERVICELOCK');

devFOFBManager = 'ANS/DG/FOFB-MANAGER';

%look for already running FOFB
xval = readattribute([devFOFBManager '/xFofbRunning']);
zval = readattribute([devFOFBManager '/zFofbRunning']);
if xval == 0 & zval == 0
    f = errordlg('FOFB is running. Start it first!', 'TEMPOchicane');
    uiwait(f);
    errorCode = -1;
end

if readattribute('tdl-i08-m/vi/tdl.1/frontEndStateValue') > 40
    f= errordlg('Frontend open: close it first!', 'TEMPOchicane');
     uiwait(f);
     errorCode = -1;
end
