function res = idSetCurrentSync(idDevServ, currentToSet, currentAbsTol)
% Written by Oleg ? Set one current of a power supply, using device of
% level 1
% 1) Sets power supply "idServ" ON
% 2) Sets setpoint "currentToSet" to attribute "idDevServ/currentPM"
% 3) Waits until current is reached (depending on maxNumTests and
% currentAbsTol)

maxDelay_s = 20; %to edit
testTimePeriod_s = 1; %to edit
res = -1;

maxNumTests = round(maxDelay_s/testTimePeriod_s);

on_or_off = tango_command_inout2(idDevServ, 'State');
if(strcmp(on_or_off, 'ON') == 0)
    tango_command_inout2(idDevServ, 'On');
    for i = 1:maxNumTests
        on_or_off = tango_command_inout2(idDevServ, 'State');
        if(strcmp(on_or_off, 'ON'))
            break;
        end
        pause(testTimePeriod_s);
    end
    if(strcmp(on_or_off, 'ON') == 0)
        fprintf('Failed to set the device ON');
        return;
    end
end

attrCurrent = strcat(idDevServ, '/currentPM');
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

