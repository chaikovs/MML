function result=HU256_MainSetCurrent(CurrentToSet)
%Version Aperiodic

% Does the cycle form PRESENTCURRENT to CurrentToSet on the down way, depending on where
% we are on the cycle (eg depending on SENSEOFCURRENT)
% NEEDS INITIALISATION BY GoOnCycling !!!!!

global SENSEOFCURRENT;
global PRESENTCURRENT;
global POWERSUPPLYNAME;
global LISTOFCURRENTS;        
global REFORBIT;
global CORRCURRTABLE;
global RELATIVETOLERANCE;
global APERIODIC;

if (strcmp(POWERSUPPLYNAME, 'bz')==0&&strcmp(POWERSUPPLYNAME, 'bx')==0)
    fprintf('The global variable POWERSUPPLYNAME is not right. Please initialise the cycle!\n')
    return
end

if (strcmp(POWERSUPPLYNAME, 'bz'))
    idDevServ='ANS-C15/EI/m-HU256.2-BZP';
elseif (strcmp(POWERSUPPLYNAME, 'bx'))
    idDevServ='ANS-C15/EI/m-HU256.2-BX';
    %InitialCurrent=readattribute([idDevServ '1' '/current']);
end
MinCurrent=LISTOFCURRENTS(1);
MaxCurrent=LISTOFCURRENTS(length(LISTOFCURRENTS));
InitialCurrent=PRESENTCURRENT;
CurrentAbsTol=abs(CurrentToSet*RELATIVETOLERANCE);

if (SENSEOFCURRENT==-1&&(abs(CurrentToSet-InitialCurrent)<=CurrentAbsTol))
   % Nothing is done
   % fprintf('courant nominal\n');
   result=0;
   
elseif (SENSEOFCURRENT==-1&&(CurrentToSet<InitialCurrent))
   result=HU256_SetCurrentSync(CurrentToSet, CurrentAbsTol);
   % fprintf('descendre courant\n');
   
elseif (SENSEOFCURRENT==-1&&(CurrentToSet>InitialCurrent))
    CurrentAbsTol=abs(MinCurrent*RELATIVETOLERANCE);
    result=HU256_SetCurrentSync(MinCurrent, CurrentAbsTol);
    pause(5);
    if (result==0)
        CurrentAbsTol=abs(MaxCurrent*RELATIVETOLERANCE);
        result=HU256_SetCurrentSync(MaxCurrent, CurrentAbsTol);
        pause(5);
        if (result==0)
            CurrentAbsTol=abs(CurrentToSet*RELATIVETOLERANCE);
            result=HU256_SetCurrentSync(CurrentToSet, CurrentAbsTol);
        end
    end 
    % fprintf('passer par min et max\n');
    
elseif (SENSEOFCURRENT==1)
    CurrentAbsTol=abs(MaxCurrent*RELATIVETOLERANCE);
    result=HU256_SetCurrentSync(MaxCurrent, CurrentAbsTol);
    pause(5);
    if (result==0)
        CurrentAbsTol=abs(CurrentToSet*RELATIVETOLERANCE);
        result=HU256_SetCurrentSync(CurrentToSet, CurrentAbsTol);
    end
    % fprintf('passer par max\n');
end
PRESENTCURRENT=CurrentToSet;
return