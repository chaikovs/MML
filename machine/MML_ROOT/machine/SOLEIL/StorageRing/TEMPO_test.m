%%


function check4feedbackflag
devLockName = getfamilydata('TANGO', 'SERVICELOCK');

devFOFBManager = 'ANS/DG/FOFB-MANAGER';

if strcmp(getmode(BPMxFamily),'Online') && strcmp(getmode(BPMyFamily),'Online')
    
        %look for already running FOFB
        xval = readattribute([devFOFBManager '/xFofbRunning']);
        zval = readattribute([devFOFBManager '/zFofbRunning']);
        if xval == 1 || zval == 1
            error('FOFB already running. Stop other application first!')
        end
    
    if readattribute('tdl-i08-m/vi/tdl.1/frontEndStateValue') > 40
        error('Frontend open')        
    end

end