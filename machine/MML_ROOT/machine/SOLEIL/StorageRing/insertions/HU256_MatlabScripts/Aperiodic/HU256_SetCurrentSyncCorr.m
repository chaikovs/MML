function res = HU256_SetCurrentSyncCorr(MainCurrentToSet, MainCurrentAbsTol, Bzc1CurrentToSet, Bzc27CurrentToSet, Bxc1CurrentToSet, Bxc28CurrentToSet)
%Version Aperiodic

% Drives either BZP power supply, either both BX1 and BX2 power supplies
% (at the same time), depending on POWERSUPPLYNAME.
% No cycling in this function!!

maxDelay_s = 20; %to edit
testTimePeriod_s = 1; %to edit
res = -1;
maxNumTests = round(maxDelay_s/testTimePeriod_s);

global TESTWITHOUTPS;
global APERIODIC;
global POWERSUPPLYNAME;

if (strcmp(POWERSUPPLYNAME, 'bz')==0&&strcmp(POWERSUPPLYNAME, 'bx')==0)
    fprintf('%s', 'The global variable POWERSUPPLYNAME is not right. Please initialise the cycle!\n')
    return
end

if (strcmp(POWERSUPPLYNAME, 'bz')==1)
    idDevServ='ANS-C15/EI/m-HU256.2-BZP';
    if (TESTWITHOUTPS==1)
        if (APERIODIC==0)
            fprintf('BZP -> %3.3f\tBzc1 -> %3.3f\tBzc4 -> %3.3f\tBxc1 -> %3.3f\tBxc4 -> %3.3f\n', MainCurrentToSet, Bzc1CurrentToSet, Bzc27CurrentToSet, Bxc1CurrentToSet, Bxc28CurrentToSet)
            fprintf('Bzm1 -> %3.3f\tBzm2 -> %3.3f\tBzm3 -> %3.3f\tBzm4 -> %3.3f\tBzm5 -> %3.3f\tBzm6 -> %3.3f\tBzm7 -> %3.3f\tBzm8 -> %3.3f\n\n', HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 1), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 2), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 3), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 4), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 5), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 6), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 7), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 8))
        else
            fprintf('BZP -> %3.3f\tBzc1 -> %3.3f\tBzc4 -> %3.3f\tBxc1 -> %3.3f\tBxc4 -> %3.3f\n', MainCurrentToSet, Bzc1CurrentToSet, Bzc27CurrentToSet, Bxc1CurrentToSet, Bxc28CurrentToSet)
            fprintf('Bzm1 -> %3.3f\tBzm2 -> %3.3f\tBzm3 -> %3.3f\tBzm4 -> %3.3f\tBzm5 -> %3.3f\tBzm6 -> %3.3f\tBzm7 -> %3.3f\tBzm8 -> %3.3f\n\n', 0, 0, 0, 0, 0, 0, 0, 0)
        end
           
    else
    idCorrDevServ='ans-c15/ei/m-hu256.2-shim.';
        
    on_or_off = tango_command_inout2(idDevServ, 'State');
    on_or_off_corr1=tango_command_inout2([idCorrDevServ '1'], 'State');
    on_or_off_corr2=tango_command_inout2([idCorrDevServ '2'], 'State');
    on_or_off_corr3=tango_command_inout2([idCorrDevServ '3'], 'State');
            
    if(strcmp(on_or_off, 'ON') == 0)
        fprintf(['The Power Supply ', idDevServ, ' is OFF\n'])
    end
    if(strcmp(on_or_off_corr1, 'ON') == 0||strcmp(on_or_off_corr2, 'ON') == 0||strcmp(on_or_off_corr3, 'ON') == 0)
        fprintf(['At least one of the Shim power supplies is OFF\n'])
    end
            
    if (APERIODIC==0)
        attrCurrent = strcat(idDevServ, '/current');
        attrBzmCurrent1=strcat([idCorrDevServ '1' '/current5']);
        attrBzmCurrent2=strcat([idCorrDevServ '2' '/current5']);
        attrBzmCurrent3=strcat([idCorrDevServ '3' '/current1']);
        attrBzmCurrent4=strcat([idCorrDevServ '3' '/current2']);
        attrBzmCurrent5=strcat([idCorrDevServ '3' '/current3']);
        attrBzmCurrent6=strcat([idCorrDevServ '3' '/current4']);
        attrBzmCurrent7=strcat([idCorrDevServ '3' '/current5']);
        attrBzmCurrent8=strcat([idCorrDevServ '3' '/current6']);
        writeattribute(attrCurrent, MainCurrentToSet);
        writeattribute('ANS-C15/EI/m-HU256.2-shim.1/current1', Bzc1CurrentToSet);
        writeattribute('ANS-C15/EI/m-HU256.2-shim.1/current4', Bzc27CurrentToSet);
        writeattribute('ANS-C15/EI/m-HU256.2-shim.2/current1', Bxc1CurrentToSet);
        writeattribute('ANS-C15/EI/m-HU256.2-shim.2/current4', Bxc28CurrentToSet);
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

    else
        attrCurrent = strcat(idDevServ, '/current');
        attrBzmCurrent1=strcat([idCorrDevServ '1' '/current5']);
        attrBzmCurrent2=strcat([idCorrDevServ '2' '/current5']);
        attrBzmCurrent3=strcat([idCorrDevServ '3' '/current1']);
        attrBzmCurrent4=strcat([idCorrDevServ '3' '/current2']);
        attrBzmCurrent5=strcat([idCorrDevServ '3' '/current3']);
        attrBzmCurrent6=strcat([idCorrDevServ '3' '/current4']);
        attrBzmCurrent7=strcat([idCorrDevServ '3' '/current5']);
        attrBzmCurrent8=strcat([idCorrDevServ '3' '/current6']);
        writeattribute(attrCurrent, MainCurrentToSet);
        writeattribute('ANS-C15/EI/m-HU256.2-shim.1/current1', Bzc1CurrentToSet);
        writeattribute('ANS-C15/EI/m-HU256.2-shim.1/current4', Bzc27CurrentToSet);
        writeattribute('ANS-C15/EI/m-HU256.2-shim.2/current1', Bxc1CurrentToSet);
        writeattribute('ANS-C15/EI/m-HU256.2-shim.2/current4', Bxc28CurrentToSet);
        writeattribute(attrBzmCurrent1, HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 1));
        writeattribute(attrBzmCurrent2, HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 2));
        writeattribute(attrBzmCurrent3, HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 3));
        writeattribute(attrBzmCurrent4, HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 4));
        writeattribute(attrBzmCurrent5, HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 5));
        writeattribute(attrBzmCurrent6, HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 6));
        writeattribute(attrBzmCurrent7, HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 7));
        writeattribute(attrBzmCurrent8, HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 8));
            
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
    end
    
else
    idDevServ='ANS-C15/EI/m-HU256.2-BX';
    if (TESTWITHOUTPS==1)
        if (APERIODIC==0)
            fprintf('BX1 -> %3.3f\tBX2 -> %3.3f\tBzc1 -> %3.3f\tBzc4 -> %3.3f\tBxc1 -> %3.3f\tBxc4 -> %3.3f\n', MainCurrentToSet, MainCurrentToSet, Bzc1CurrentToSet, Bzc27CurrentToSet, Bxc1CurrentToSet, Bxc28CurrentToSet)
        else
            fprintf('BX1 -> %3.3f\tBX2 -> %3.3f\tBzc1 -> %3.3f\tBzc4 -> %3.3f\tBxc1 -> %3.3f\tBxc4 -> %3.3f\n', MainCurrentToSet, HU256_GetBX2CurrentForAperiodic(MainCurrentToSet), Bzc1CurrentToSet, Bzc27CurrentToSet, Bxc1CurrentToSet, Bxc28CurrentToSet)
        end    
    else
        on_or_off1 = tango_command_inout2([idDevServ '1'], 'State');
        on_or_off2 = tango_command_inout2([idDevServ '2'], 'State');
        if(strcmp(on_or_off1, 'ON') == 0||strcmp(on_or_off2, 'ON')==0)
            fprintf(['One of the Power Supplies BX is OFF\n'])
        end
        attrCurrent1 = strcat([idDevServ '1'], '/current');
        attrCurrent2 = strcat([idDevServ '2'], '/current');
        writeattribute(attrCurrent1, MainCurrentToSet);
        if (APERIODIC==0)
            writeattribute(attrCurrent2, MainCurrentToSet);
        else
            writeattribute(attrCurrent2, HU256_GetBX2CurrentForAperiodic(MainCurrentToSet));
        end
        writeattribute('ANS-C15/EI/m-HU256.2-shim.1/current1', Bzc1CurrentToSet);
        writeattribute('ANS-C15/EI/m-HU256.2-shim.1/current4', Bzc27CurrentToSet);
        writeattribute('ANS-C15/EI/m-HU256.2-shim.2/current1', Bxc1CurrentToSet);
        writeattribute('ANS-C15/EI/m-HU256.2-shim.2/current4', Bxc28CurrentToSet);
        actCur1 = 0;
        actCur2 = 0;
        for i = 1:maxNumTests
            actCur1 = readattribute([idDevServ '1' '/current']);
            actCur2 = readattribute([idDevServ '2' '/current']);
            if((abs(MainCurrentToSet - actCur1) <= MainCurrentAbsTol)&&(abs(MainCurrentToSet - actCur2) <= MainCurrentAbsTol))
                res = 0;
                return;
            end
            pause(testTimePeriod_s);
        end
        if((abs(MainCurrentToSet - actCur1) > MainCurrentAbsTol)||(abs(MainCurrentToSet - actCur2) > MainCurrentAbsTol))
            res = -1;
            fprintf('Failed to set the requested current\n\n');
        end
    end
end
