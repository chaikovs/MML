function result=HU256_MainSetCurrent(CurrentToSet, CurrentAbsTol)
% Does the cycle form PRESENTCURRENT to CurrentToSet on the down way, depending on where
% we are ont the cycle (eg depending on SENSEOFCURRENT)
% NEEDS INITIALISATION BY GoOnCycling !!!!!

global POWERSUPPLYNAME;
global PRESENTCURRENT;
global SENSEOFCURRENT;

if (strcmp(POWERSUPPLYNAME, 'bz')==0&&strcmp(POWERSUPPLYNAME, 'bx')==0)
    fprintf('%s', 'The global variable POWERSUPPLYNAME is not right. Please initialise the cycle!')
    return
end

if (strcmp(POWERSUPPLYNAME, 'bz'))
    MinCurrent=-200;
    MaxCurrent=200;
    idDevServ='ANS-C15/EI/m-HU256.2-BZP';
elseif (strcmp(POWERSUPPLYNAME, 'bx'))
    MinCurrent=0;
    MaxCurrent=275;
    idDevServ='ANS-C15/EI/m-HU256.2-BX';
    %InitialCurrent=readattribute([idDevServ '1' '/current']);
end
    InitialCurrent=PRESENTCURRENT;

if (SENSEOFCURRENT==-1&&(abs(CurrentToSet-InitialCurrent)<=CurrentAbsTol))
    % Nothing is done
   % fprintf('courant nominal\n');
   result=0;
   
elseif (SENSEOFCURRENT==-1&&(CurrentToSet<InitialCurrent))
   result=idSetCurrentSync_HU256(CurrentToSet, CurrentAbsTol);
   % fprintf('descendre courant\n');
   
elseif (SENSEOFCURRENT==-1&&(CurrentToSet>InitialCurrent))
    result=idSetCurrentSync_HU256(MinCurrent, CurrentAbsTol);
    pause(5);
    if (result==0)
        result=idSetCurrentSync_HU256(MaxCurrent, CurrentAbsTol);
        pause(5);
        if (result==0)
            result=idSetCurrentSync_HU256(CurrentToSet, CurrentAbsTol);
        end
    end 
    % fprintf('passer par min et max\n');
    
elseif (SENSEOFCURRENT==1)
    result=idSetCurrentSync_HU256(MaxCurrent, CurrentAbsTol);
    pause(5);
    if (result==0)
        result=idSetCurrentSync_HU256(CurrentToSet, CurrentAbsTol);
    end
    % fprintf('passer par max\n');
end
PRESENTCURRENT=CurrentToSet;
return