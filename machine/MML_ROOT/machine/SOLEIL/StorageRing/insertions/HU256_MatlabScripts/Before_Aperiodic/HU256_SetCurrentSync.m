function res = HU256_SetCurrentSync(currentToSet, currentAbsTol)
% Drives either BZP power supply, either both BX1 and BX2 power supplies
% (at the same time), depending on POWERSUPPLYNAME.
% No cycling in this function!!

maxDelay_s = 20; %to edit
testTimePeriod_s = 1; %to edit
res = -1;
maxNumTests = round(maxDelay_s/testTimePeriod_s);

global POWERSUPPLYNAME;

if (strcmp(POWERSUPPLYNAME, 'bz')==0&&strcmp(POWERSUPPLYNAME, 'bx')==0)
    fprintf('%s', 'The global variable POWERSUPPLYNAME is not right. Please initialise the cycle!\n')
    return
end

if (strcmp(POWERSUPPLYNAME, 'bz')==1)
    idDevServ='ANS-C15/EI/m-HU256.2-BZP';
    on_or_off = tango_command_inout2(idDevServ, 'State');
    if(strcmp(on_or_off, 'ON') == 0)
        fprintf(['The Power Supply ', idDevServ, ' is OFF\n'])
    end
    attrCurrent = strcat(idDevServ, '/current');
    writeattribute(attrCurrent, currentToSet);
    actCur = 0;
    for i = 1:maxNumTests
        actCur = readattribute([idDevServ, '/current']);
        if(abs(currentToSet - actCur) <= currentAbsTol)
            res = 0;
            return;
        end
        pause(testTimePeriod_s);
    end
    if(abs(currentToSet - actCur) > currentAbsTol)
    	res = -1;
        fprintf('Failed to set the requested current\n');
    end
    
else
    idDevServ='ANS-C15/EI/m-HU256.2-BX';
    on_or_off1 = tango_command_inout2([idDevServ '1'], 'State');
    on_or_off2 = tango_command_inout2([idDevServ '2'], 'State');
    if(strcmp(on_or_off1, 'ON') == 0||strcmp(on_or_off2, 'ON')==0)
        fprintf(['One of the Power Supplies BX is OFF\n'])
    end
    attrCurrent1 = strcat([idDevServ '1'], '/current');
    attrCurrent2 = strcat([idDevServ '2'], '/current');
    writeattribute(attrCurrent1, currentToSet);
    writeattribute(attrCurrent2, currentToSet);
    actCur1 = 0;
    actCur2 = 0;
    for i = 1:maxNumTests
        actCur1 = readattribute([idDevServ '1' '/current']);
        actCur2 = readattribute([idDevServ '2' '/current']);
        if((abs(currentToSet - actCur1) <= currentAbsTol)&&(abs(currentToSet - actCur2) <= currentAbsTol))
            res = 0;
            return;
        end
        pause(testTimePeriod_s);
    end
    if((abs(currentToSet - actCur1) > currentAbsTol)||(abs(currentToSet - actCur2) > currentAbsTol))
        res = -1;
        fprintf('Failed to set the requested current\n\n');
    end



end
