function res = HU256_SetCurrentSync(currentToSet, currentAbsTol)
%Version Aperiodic

% Drives either BZP power supply, either both BX1 and BX2 power supplies
% (at the same time), depending on POWERSUPPLYNAME.
% No cycling in this function!!

global HU256CELL;
global TESTWITHOUTPS;
global APERIODIC;
global POWERSUPPLYNAME;
global SENSEOFCURRENT;
global MAXDELAY;

testTimePeriod_s = 1; %to edit

HU256Cell=['ANS-C' num2str(HU256CELL, '%02.0f')];

res = -1;

maxNumTests = round(MAXDELAY/testTimePeriod_s);

if (strcmp(POWERSUPPLYNAME, 'bz')==0&&strcmp(POWERSUPPLYNAME, 'bx')==0)
    fprintf('%s', 'The global variable POWERSUPPLYNAME is not right. Please initialise the cycle!\n')
    return
end

if (strcmp(POWERSUPPLYNAME, 'bz')==1)
    
    if (TESTWITHOUTPS==1)
        if (APERIODIC==1&&SENSEOFCURRENT==-1&&currentToSet>=0)
            fprintf('BZP -> %3.3f\tBzm1 -> %3.3f\tBzm2 -> %3.3f\tBzm3 -> %3.3f\tBzm4 -> %3.3f\tBzm5 -> %3.3f\tBzm6 -> %3.3f\tBzm7 -> %3.3f\tBzm8 -> %3.3f\n', currentToSet, HU256_GetBzmCurrentForAperiodic(currentToSet, 1), HU256_GetBzmCurrentForAperiodic(currentToSet, 2), HU256_GetBzmCurrentForAperiodic(currentToSet, 3), HU256_GetBzmCurrentForAperiodic(currentToSet, 4), HU256_GetBzmCurrentForAperiodic(currentToSet, 5), HU256_GetBzmCurrentForAperiodic(currentToSet, 6), HU256_GetBzmCurrentForAperiodic(currentToSet, 7), HU256_GetBzmCurrentForAperiodic(currentToSet, 8))
        else
            fprintf('BZP -> %3.3f\tBzm1 -> %3.3f\tBzm2 -> %3.3f\tBzm3 -> %3.3f\tBzm4 -> %3.3f\tBzm5 -> %3.3f\tBzm6 -> %3.3f\tBzm7 -> %3.3f\tBzm8 -> %3.3f\n', currentToSet, 0, 0, 0, 0, 0, 0, 0, 0)
        end
    else
        idDevServ=[HU256Cell '/EI/m-HU256.2_BZP'];
        idCorrDevServ=[HU256Cell '/ei/m-hu256.2_shim.'];
    
        on_or_off = tango_command_inout2(idDevServ, 'State');
        on_or_off_corr1 = tango_command_inout2([idCorrDevServ '1'], 'State');
        on_or_off_corr2 = tango_command_inout2([idCorrDevServ '2'], 'State');
        on_or_off_corr3 = tango_command_inout2([idCorrDevServ '3'], 'State');
        if (strcmp(on_or_off, 'OFF') == 1)
            fprintf(['The Power Supply ', idDevServ, ' is OFF\n'])
        end
        if (strcmp(on_or_off_corr1, 'ON') == 0||strcmp(on_or_off_corr2, 'ON') == 0||strcmp(on_or_off_corr3, 'ON') == 0)
            fprintf('At least one Shim power supply is OFF\n')
        end
        attrCurrent = strcat(idDevServ, '/current');
        attrBzmCurrent1=strcat([idCorrDevServ '1' '/current5']);
        attrBzmCurrent2=strcat([idCorrDevServ '2' '/current5']);
        attrBzmCurrent3=strcat([idCorrDevServ '3' '/current1']);
        attrBzmCurrent4=strcat([idCorrDevServ '3' '/current2']);
        attrBzmCurrent5=strcat([idCorrDevServ '3' '/current3']);
        attrBzmCurrent6=strcat([idCorrDevServ '3' '/current4']);
        attrBzmCurrent7=strcat([idCorrDevServ '3' '/current5']);
        attrBzmCurrent8=strcat([idCorrDevServ '3' '/current6']);
    
%         if (TESTWITHOUTPS~=1)
        if (APERIODIC==1&&SENSEOFCURRENT==-1&&currentToSet>=0)
            writeattribute(attrCurrent, currentToSet);
            writeattribute(attrBzmCurrent1, HU256_GetBzmCurrentForAperiodic(currentToSet, 1));
            writeattribute(attrBzmCurrent2, HU256_GetBzmCurrentForAperiodic(currentToSet, 2));
            writeattribute(attrBzmCurrent3, HU256_GetBzmCurrentForAperiodic(currentToSet, 3));
            writeattribute(attrBzmCurrent4, HU256_GetBzmCurrentForAperiodic(currentToSet, 4));
            writeattribute(attrBzmCurrent5, HU256_GetBzmCurrentForAperiodic(currentToSet, 5));
            writeattribute(attrBzmCurrent6, HU256_GetBzmCurrentForAperiodic(currentToSet, 6));
            writeattribute(attrBzmCurrent7, HU256_GetBzmCurrentForAperiodic(currentToSet, 7));
            writeattribute(attrBzmCurrent8, HU256_GetBzmCurrentForAperiodic(currentToSet, 8));

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

        else    % Not Aperiodic or SenseOfCurrent>0
            writeattribute(attrCurrent, currentToSet);
            writeattribute(attrBzmCurrent1, 0);
            writeattribute(attrBzmCurrent2, 0);
            writeattribute(attrBzmCurrent3, 0);
            writeattribute(attrBzmCurrent4, 0);
            writeattribute(attrBzmCurrent5, 0);
            writeattribute(attrBzmCurrent6, 0);
            writeattribute(attrBzmCurrent7, 0);
            writeattribute(attrBzmCurrent8, 0);

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

        end     % Aperiodic
%         else % TESTWITHOUTPS==1
%             if (APERIODIC==1&&SENSEOFCURRENT==-1&&currentToSet>=0)
%                 fprintf('Consigne de %f envoyée à %s\n', CurrentToSet, attrCurrent)
%                 fprintf('Consigne de %f envoyée à %s\n', HU256_GetBzmCurrentForAperiodic(currentToSet, 1), attrBzmCurrent1)
%                 fprintf('Consigne de %f envoyée à %s\n', HU256_GetBzmCurrentForAperiodic(currentToSet, 2), attrBzmCurrent2)
%                 fprintf('Consigne de %f envoyée à %s\n', HU256_GetBzmCurrentForAperiodic(currentToSet, 3), attrBzmCurrent3)
%                 fprintf('Consigne de %f envoyée à %s\n', HU256_GetBzmCurrentForAperiodic(currentToSet, 4), attrBzmCurrent4)
%                 fprintf('Consigne de %f envoyée à %s\n', HU256_GetBzmCurrentForAperiodic(currentToSet, 5), attrBzmCurrent5)
%                 fprintf('Consigne de %f envoyée à %s\n', HU256_GetBzmCurrentForAperiodic(currentToSet, 6), attrBzmCurrent6)
%                 fprintf('Consigne de %f envoyée à %s\n', HU256_GetBzmCurrentForAperiodic(currentToSet, 7), attrBzmCurrent7)
%                 fprintf('Consigne de %f envoyée à %s\n', HU256_GetBzmCurrentForAperiodic(currentToSet, 8), attrBzmCurrent8)
                
%                 writeattribute(attrCurrent, currentToSet);
%                 writeattribute(attrBzmCurrent1, HU256_GetBzmCurrentForAperiodic(currentToSet, 1));
%                 writeattribute(attrBzmCurrent2, HU256_GetBzmCurrentForAperiodic(currentToSet, 2));
%                 writeattribute(attrBzmCurrent3, HU256_GetBzmCurrentForAperiodic(currentToSet, 3));
%                 writeattribute(attrBzmCurrent4, HU256_GetBzmCurrentForAperiodic(currentToSet, 4));
%                 writeattribute(attrBzmCurrent5, HU256_GetBzmCurrentForAperiodic(currentToSet, 5));
%                 writeattribute(attrBzmCurrent6, HU256_GetBzmCurrentForAperiodic(currentToSet, 6));
%                 writeattribute(attrBzmCurrent7, HU256_GetBzmCurrentForAperiodic(currentToSet, 7));
%                 writeattribute(attrBzmCurrent8, HU256_GetBzmCurrentForAperiodic(currentToSet, 8));

%                 actCur = 0;
%                 for i = 1:maxNumTests
%                     actCur = readattribute([idDevServ, '/current']);
%                     if(abs(currentToSet - actCur) <= currentAbsTol)
%                         res = 0;
%                         return;
%                     end
%                     pause(testTimePeriod_s);
%                 end
%                 if(abs(currentToSet - actCur) > currentAbsTol)
%                     res = -1;
%                     fprintf('Failed to set the requested current\n');
%                 end

%             else    % Not aperiodic or SenseOfCurrent>0
%                 fprintf('Consigne de %f envoyée à %s\n', CurrentToSet, attrCurrent)
%                 fprintf('Consigne de %f envoyée à %s\n', 0, attrBzmCurrent1)
%                 fprintf('Consigne de %f envoyée à %s\n', 0, attrBzmCurrent2)
%                 fprintf('Consigne de %f envoyée à %s\n', 0, attrBzmCurrent3)
%                 fprintf('Consigne de %f envoyée à %s\n', 0, attrBzmCurrent4)
%                 fprintf('Consigne de %f envoyée à %s\n', 0, attrBzmCurrent5)
%                 fprintf('Consigne de %f envoyée à %s\n', 0, attrBzmCurrent6)
%                 fprintf('Consigne de %f envoyée à %s\n', 0, attrBzmCurrent7)
%                 fprintf('Consigne de %f envoyée à %s\n', 0, attrBzmCurrent8)
                
%                 writeattribute(attrCurrent, currentToSet);
%                 writeattribute(attrBzmCurrent1, 0);
%                 writeattribute(attrBzmCurrent2, 0);
%                 writeattribute(attrBzmCurrent3, 0);
%                 writeattribute(attrBzmCurrent4, 0);
%                 writeattribute(attrBzmCurrent5, 0);
%                 writeattribute(attrBzmCurrent6, 0);
%                 writeattribute(attrBzmCurrent7, 0);
%                 writeattribute(attrBzmCurrent8, 0);
% 
%                 actCur = 0;
%                 for i = 1:maxNumTests
%                     actCur = readattribute([idDevServ, '/current']);
%                     if(abs(currentToSet - actCur) <= currentAbsTol)
%                         res = 0;
%                         return;
%                     end
%                     pause(testTimePeriod_s);
%                 end
%                 if(abs(currentToSet - actCur) > currentAbsTol)
%                     res = -1;
%                     fprintf('Failed to set the requested current\n');
%                 end

%             end     % Aperiodic
%         end     % TESTWITHOUTPS
    end     % TESTWITHOUTPS
else    % bx
    idDevServ=[HU256Cell '/EI/m-HU256.2_BX'];
    on_or_off1 = tango_command_inout2([idDevServ '1'], 'State');
    on_or_off2 = tango_command_inout2([idDevServ '2'], 'State');
    
    if(strcmp(on_or_off1, 'OFF') == 1||strcmp(on_or_off2, 'OFF')==1&&TESTWITHOUTPS==0)
        fprintf('One of the Power Supplies BX is OFF\n')
    end
    
    attrCurrent1 = strcat([idDevServ '1'], '/current');
    attrCurrent2 = strcat([idDevServ '2'], '/current');
    
    if (TESTWITHOUTPS==1)
        if (APERIODIC==0)
            fprintf('BX1 -> %3.3f\tBX2 -> %3.3f\n', currentToSet, currentToSet)
        else
            fprintf('BX1 -> %3.3f\tBX2 -> %3.3f\n', currentToSet, HU256_GetBX2CurrentForAperiodic(currentToSet))
        end
    else
        if (APERIODIC==0)
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
                    
        else
            writeattribute(attrCurrent1, currentToSet);
            writeattribute(attrCurrent2, HU256_GetBX2CurrentForAperiodic(currentToSet));
            actCur1 = 0;
            actCur2 = 0;
            for i = 1:maxNumTests
                actCur1 = readattribute([idDevServ '1' '/current']);
                actCur2 = readattribute([idDevServ '2' '/current']);
                if((abs(currentToSet - actCur1) <= currentAbsTol)&&(abs(HU256_GetBX2CurrentForAperiodic(currentToSet) - actCur2) <= currentAbsTol))
                    res = 0;
                    return;
                end
            pause(testTimePeriod_s);
            end
            if((abs(currentToSet - actCur1) > currentAbsTol)||(abs(HU256_GetBX2CurrentForAperiodic(currentToSet) - actCur2) > currentAbsTol))
                res = -1;
                fprintf('Failed to set the requested current\n\n');
            end 
        end
    end

end
