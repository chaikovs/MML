function res = HU256_SetCurrentSync(currentToSet, currentAbsTol)
%Version Aperiodic & helicoidal

% Drives either BZP power supply, either both BX1 and BX2 power supplies
% (at the same time), depending on POWERSUPPLYNAME.
% No cycling in this function!!

global HU256CELL;
global TESTWITHOUTPS;
global APERIODIC;
global POWERSUPPLYNAME;
global SENSEOFCURRENT;
global PRESENTCURRENT;
global BXSENSEOFCURRENTFORHEL;
global BXPRESENTCURRENTFORHEL;
global MAXDELAY;

testTimePeriod_s = 1; %to edit

HU256Cell=['ANS-C' num2str(HU256CELL, '%02.0f')];

res = -1;

maxNumTests = round(MAXDELAY/testTimePeriod_s);

if (strcmp(POWERSUPPLYNAME, 'bz')==0&&strcmp(POWERSUPPLYNAME, 'bx')==0&&isa(APERIODIC, 'numeric')==1)
    fprintf('%s', 'Problem in HU256_SetCurrentSync : The global variable POWERSUPPLYNAME is not right. Please initialise the cycle!\n')
    return
end

if (isa(APERIODIC, 'numeric')==1)   % classic mode
    if (strcmp(POWERSUPPLYNAME, 'bz')==1)
        if (APERIODIC==1&&SENSEOFCURRENT==-1&&currentToSet>=0)  % Aperiodic
                BZPCurrentToSet=currentToSet;
                Bzm1CurrentToSet=HU256_GetBzmCurrentForAperiodic(currentToSet, 1);
                Bzm2CurrentToSet=HU256_GetBzmCurrentForAperiodic(currentToSet, 2);
                Bzm3CurrentToSet=HU256_GetBzmCurrentForAperiodic(currentToSet, 3);
                Bzm4CurrentToSet=HU256_GetBzmCurrentForAperiodic(currentToSet, 4);
                Bzm5CurrentToSet=HU256_GetBzmCurrentForAperiodic(currentToSet, 5);
                Bzm6CurrentToSet=HU256_GetBzmCurrentForAperiodic(currentToSet, 6);
                Bzm7CurrentToSet=HU256_GetBzmCurrentForAperiodic(currentToSet, 7);
                Bzm8CurrentToSet=HU256_GetBzmCurrentForAperiodic(currentToSet, 8);
                
            else    % Not Aperiodic or SenseOfCurrent>0
                BZPCurrentToSet=currentToSet;
                Bzm1CurrentToSet=0;
                Bzm2CurrentToSet=0;
                Bzm3CurrentToSet=0;
                Bzm4CurrentToSet=0;
                Bzm5CurrentToSet=0;
                Bzm6CurrentToSet=0;
                Bzm7CurrentToSet=0;
                Bzm8CurrentToSet=0;
        end % Aperiodic or not
        
        if (TESTWITHOUTPS==1)
            fprintf('TESTWITHOUTPS : BZP -> %03.3f\tNo Corrs\tBzm1 -> %03.3f\tBzm2 -> %03.3f\tBzm3 -> %03.3f\tBzm4 -> %03.3f\tBzm5 -> %03.3f\tBzm6 -> %03.3f\tBzm7 -> %03.3f\tBzm8 -> %03.3f\n', BZPCurrentToSet, Bzm1CurrentToSet, Bzm2CurrentToSet, Bzm3CurrentToSet, Bzm4CurrentToSet, Bzm5CurrentToSet, Bzm6CurrentToSet, Bzm7CurrentToSet, Bzm8CurrentToSet)
        else
            idDevServ=[HU256Cell '/EI/m-HU256.2_BZP'];
            idCorrDevServ=[HU256Cell '/ei/m-hu256.2_shim.'];

            on_or_off = tango_command_inout2(idDevServ, 'State');
            on_or_off_corr1 = tango_command_inout2([idCorrDevServ '1'], 'State');
            on_or_off_corr2 = tango_command_inout2([idCorrDevServ '2'], 'State');
            on_or_off_corr3 = tango_command_inout2([idCorrDevServ '3'], 'State');
            if (strcmp(on_or_off, 'OFF') == 1)
                fprintf(['Problem in HU256_SetCurrentSync :The Power Supply ', idDevServ, ' is OFF\n'])
            end
            if (strcmp(on_or_off_corr1, 'OFF') == 1||strcmp(on_or_off_corr2, 'OFF') == 1||strcmp(on_or_off_corr3, 'OFF') == 1)
                fprintf('Problem in HU256_SetCurrentSync : At least one Shim power supply is OFF\n')
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

            writeattribute(attrCurrent, currentToSet);
            writeattribute(attrBzmCurrent1, Bzm1CurrentToSet);
            writeattribute(attrBzmCurrent2, Bzm2CurrentToSet);
            writeattribute(attrBzmCurrent3, Bzm3CurrentToSet);
            writeattribute(attrBzmCurrent4, Bzm4CurrentToSet);
            writeattribute(attrBzmCurrent5, Bzm5CurrentToSet);
            writeattribute(attrBzmCurrent6, Bzm6CurrentToSet);
            writeattribute(attrBzmCurrent7, Bzm7CurrentToSet);
            writeattribute(attrBzmCurrent8, Bzm8CurrentToSet);

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
                fprintf('Problem in HU256_SetCurrentSync : Failed to set the requested current in time.\n');
            end

        end     % TESTWITHOUTPS
    else    % bx
        idDevServ=[HU256Cell '/EI/m-HU256.2_BX'];
        on_or_off1 = tango_command_inout2([idDevServ '1'], 'State');
        on_or_off2 = tango_command_inout2([idDevServ '2'], 'State');

        if((strcmp(on_or_off1, 'OFF') == 1||strcmp(on_or_off2, 'OFF')==1)&&TESTWITHOUTPS==0)
            fprintf('Problem with HU256_SetCurrentSync : One of the Power Supplies BX is OFF\n')
        end

        attrCurrent1 = strcat([idDevServ '1'], '/current');
        attrCurrent2 = strcat([idDevServ '2'], '/current');

        if (APERIODIC==0)
            BX1CurrentToSet=currentToSet;
            BX2CurrentToSet=currentToSet;
        else
            BX1CurrentToSet=currentToSet;
            BX2CurrentToSet=HU256_GetBX2CurrentForAperiodic(currentToSet);
        end
        
        if (TESTWITHOUTPS==1)
            fprintf('TESTWITHOUTPS : BX1 -> %03.3f\tBX2 -> %03.3f\tNo Corrs\n', BX1CurrentToSet, BX2CurrentToSet)
        else
            writeattribute(attrCurrent1, BX1currentToSet);
            writeattribute(attrCurrent2, BX2currentToSet);
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
        end     % TestWithoutPS
    end     % Choice of Power Supply

else    % helicoidal mode
    BZPCurrentToSet=PRESENTCURRENT;
    BX1CurrentToSet=BXPRESENTCURRENTFORHEL;
    BX2CurrentToSet=BXPRESENTCURRENTFORHEL;
    Bzm1CurrentToSet=0;
    Bzm2CurrentToSet=0;
    Bzm3CurrentToSet=0;
    Bzm4CurrentToSet=0;
    Bzm5CurrentToSet=0;
    Bzm6CurrentToSet=0;
    Bzm7CurrentToSet=0;
    Bzm8CurrentToSet=0;

    if (TESTWITHOUTPS==1)
        fprintf('TESTWITHOUTPS : BZP -> %03.3f A\tBX -> %03.3f A\No Corrs\n', PRESENTCURRENT, BXPRESENTCURRENTFORHEL)
    else
        idBZPDevServ=[HU256Cell '/EI/m-HU256.2_BZP'];
        idBX1DevServ=[HU256Cell '/EI/m-HU256.2_BX1'];
        idBX2DevServ=[HU256Cell '/EI/m-HU256.2_BX2'];
        idCorrDevServ=[HU256Cell '/ei/m-hu256.2_shim.'];

        on_or_off_BZP = tango_command_inout2(idBZPDevServ, 'State');
        on_or_off_BX1 = tango_command_inout2(idBX1DevServ, 'State');
        on_or_off_BX2 = tango_command_inout2(idBX2DevServ, 'State');
        on_or_off_corr1 = tango_command_inout2([idCorrDevServ '1'], 'State');
        on_or_off_corr2 = tango_command_inout2([idCorrDevServ '2'], 'State');
        on_or_off_corr3 = tango_command_inout2([idCorrDevServ '3'], 'State');
        if (strcmp(on_or_off_BZP, 'OFF') == 1)
            fprintf(['The Power Supply ', idBZPDevServ, ' is OFF\n'])
        end
        if (strcmp(on_or_off_BX1, 'OFF') == 1)
            fprintf(['The Power Supply ', idBX1DevServ, ' is OFF\n'])
        end
        if (strcmp(on_or_off_BX2, 'OFF') == 1)
            fprintf(['The Power Supply ', idBX2DevServ, ' is OFF\n'])
        end
        if (strcmp(on_or_off_corr1, 'OFF') == 1||strcmp(on_or_off_corr2, 'OFF') == 1||strcmp(on_or_off_corr3, 'OFF') == 1)
            fprintf('At least one Shim power supply is OFF\n')
        end
        attrBZPCurrent = strcat(idBZPDevServ, '/current');
        attrBX1Current = strcat(idBX1DevServ, '/current');
        attrBX2Current = strcat(idBX2DevServ, '/current');
        attrBzmCurrent1=strcat([idCorrDevServ '1' '/current5']);
        attrBzmCurrent2=strcat([idCorrDevServ '2' '/current5']);
        attrBzmCurrent3=strcat([idCorrDevServ '3' '/current1']);
        attrBzmCurrent4=strcat([idCorrDevServ '3' '/current2']);
        attrBzmCurrent5=strcat([idCorrDevServ '3' '/current3']);
        attrBzmCurrent6=strcat([idCorrDevServ '3' '/current4']);
        attrBzmCurrent7=strcat([idCorrDevServ '3' '/current5']);
        attrBzmCurrent8=strcat([idCorrDevServ '3' '/current6']);

        writeattribute(attrBZPCurrent, BZPCurrentToSet);
        writeattribute(attrBX1Current, BX1CurrentToSet);
        writeattribute(attrBX2Current, BX2CurrentToSet);
        writeattribute(attrBzmCurrent1, Bzm1CurrentToSet);
        writeattribute(attrBzmCurrent2, Bzm2CurrentToSet);
        writeattribute(attrBzmCurrent3, Bzm3CurrentToSet);
        writeattribute(attrBzmCurrent4, Bzm4CurrentToSet);
        writeattribute(attrBzmCurrent5, Bzm5CurrentToSet);
        writeattribute(attrBzmCurrent6, Bzm6CurrentToSet);
        writeattribute(attrBzmCurrent7, Bzm7CurrentToSet);
        writeattribute(attrBzmCurrent8, Bzm8CurrentToSet);

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
    end     % TESTWITHOUTPS
    
    
    
    else    % bx
        idDevServ=[HU256Cell '/EI/m-HU256.2_BX'];
        on_or_off1 = tango_command_inout2([idDevServ '1'], 'State');
        on_or_off2 = tango_command_inout2([idDevServ '2'], 'State');

        if((strcmp(on_or_off1, 'OFF') == 1||strcmp(on_or_off2, 'OFF')==1)&&TESTWITHOUTPS==0)
            fprintf('Problem with HU256_SetCurrentSync : One of the Power Supplies BX is OFF\n')
        end

        attrCurrent1 = strcat([idDevServ '1'], '/current');
        attrCurrent2 = strcat([idDevServ '2'], '/current');

        if (TESTWITHOUTPS==1)
            fprintf('TESTWITHOUTPS : BZP -> %03.3f A\tBX -> %03.3f A\n', PRESENTCURRENT, BXPRESENTCURRENTFORHEL)
        else
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
    end     % PowerSupplyName
end
    
    
