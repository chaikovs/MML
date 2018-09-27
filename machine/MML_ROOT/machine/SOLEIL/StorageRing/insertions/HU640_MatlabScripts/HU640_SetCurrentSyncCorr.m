function res = HU640_SetCurrentSyncCorr(MainCurrentToSet, MainCurrentAbsTol, CHECurrentToSet, CHSCurrentToSet, CVECurrentToSet, CVSCurrentToSet)
% Drives either PS1 power supply, either PS2 power supply, either PS3 power
% supply (depending on POWERSUPPLYNAME), and the 4 correctors with the
% given currents.
% No cycling in this function!!

maxDelay_s = 20; %to edit
testTimePeriod_s = 1; %to edit
res = -1;
maxNumTests = round(maxDelay_s/testTimePeriod_s);

global POWERSUPPLYNAME;

if (strcmp(POWERSUPPLYNAME, 'ps1')==0&&strcmp(POWERSUPPLYNAME, 'ps2')==0&&strcmp(POWERSUPPLYNAME, 'ps3')==0)
    fprintf('%s', 'The global variable POWERSUPPLYNAME is not right. Please initialise the cycle!\n')
    return
end

idDevServ=['ans-c05/ei/l-hu640_' POWERSUPPLYNAME];
on_or_off = tango_command_inout2(idDevServ, 'State');
if(strcmp(on_or_off, 'ON') == 0)
    fprintf(['The Power Supply ', idDevServ, ' is OFF\n'])
end
attrCurrent = strcat(idDevServ, '/current');
writeattribute(attrCurrent, MainCurrentToSet);
writeattribute('ans-c05/ei/l-hu640_Corr4/current', CHECurrentToSet);
writeattribute('ans-c05/ei/l-hu640_Corr3/current', CHSCurrentToSet);
writeattribute('ans-c05/ei/l-hu640_Corr2/current', CVECurrentToSet);
writeattribute('ans-c05/ei/l-hu640_Corr1/current', CVSCurrentToSet);

actCur = 0;
for i = 1:maxNumTests
    actCur = readattribute([idDevServ, '/current']);
    if(abs(MainCurrentToSet - actCur) <= MainCurrentAbsTol)
        res = 0;
        return;
    end
    pause(testTimePeriod_s);
end
if(abs(MainCurrentToSet - actCur) > MainCurrentAbsTol)
    res = -1;
    fprintf('Failed to set the requested current\n');
end