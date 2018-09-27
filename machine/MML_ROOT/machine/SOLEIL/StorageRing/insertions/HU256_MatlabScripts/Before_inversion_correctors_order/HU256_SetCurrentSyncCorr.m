function res = HU256_SetCurrentSyncCorr(MainCurrentToSet, MainCurrentAbsTol, Bzc1CurrentToSet, Bzc27CurrentToSet, Bxc1CurrentToSet, Bxc28CurrentToSet)
%Version Aperiodic

% Drives either BZP power supply, either both BX1 and BX2 power supplies
% (at the same time), depending on POWERSUPPLYNAME.
% No cycling in this function!!

global HU256CELL;
global TESTWITHOUTPS;
global APERIODIC;
global POWERSUPPLYNAME;
global MAXDELAY;
global RELATIVETOLERANCE;

testTimePeriod_s = 1; %to edit

HU256Cell=['ANS-C' num2str(HU256CELL, '%02.0f')];

res = -1;

maxNumTests = round(MAXDELAY/testTimePeriod_s);
if (strcmp(POWERSUPPLYNAME, 'bz')==0&&strcmp(POWERSUPPLYNAME, 'bx')==0)
    fprintf('%s', 'The global variable POWERSUPPLYNAME is not right. Please initialise the cycle!\n')
    return
end

if (strcmp(POWERSUPPLYNAME, 'bz')==1)
    idDevServ=[HU256Cell '/EI/m-HU256.2_BZP'];
    if (TESTWITHOUTPS==1)
        if (APERIODIC==1)
            fprintf('BZP -> %3.3f\tBzc1 -> %3.3f\tBzc4 -> %3.3f\tBxc1 -> %3.3f\tBxc4 -> %3.3f\n', MainCurrentToSet, Bzc1CurrentToSet, Bzc27CurrentToSet, Bxc1CurrentToSet, Bxc28CurrentToSet)
            fprintf('Bzm1 -> %3.3f\tBzm2 -> %3.3f\tBzm3 -> %3.3f\tBzm4 -> %3.3f\tBzm5 -> %3.3f\tBzm6 -> %3.3f\tBzm7 -> %3.3f\tBzm8 -> %3.3f\n\n', HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 1), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 2), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 3), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 4), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 5), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 6), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 7), HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 8))
        else
            fprintf('BZP -> %3.3f\tBzc1 -> %3.3f\tBzc4 -> %3.3f\tBxc1 -> %3.3f\tBxc4 -> %3.3f\n', MainCurrentToSet, Bzc1CurrentToSet, Bzc27CurrentToSet, Bxc1CurrentToSet, Bxc28CurrentToSet)
            fprintf('Bzm1 -> %3.3f\tBzm2 -> %3.3f\tBzm3 -> %3.3f\tBzm4 -> %3.3f\tBzm5 -> %3.3f\tBzm6 -> %3.3f\tBzm7 -> %3.3f\tBzm8 -> %3.3f\n\n', 0, 0, 0, 0, 0, 0, 0, 0)
        end
    
    else %TESTWITHOUTPS=0
        idCorrDevServ=[HU256Cell '/ei/m-hu256.2_shim.'];
        
        on_or_off = tango_command_inout2(idDevServ, 'State');
        on_or_off_corr1=tango_command_inout2([idCorrDevServ '1'], 'State');
        on_or_off_corr2=tango_command_inout2([idCorrDevServ '2'], 'State');
        on_or_off_corr3=tango_command_inout2([idCorrDevServ '3'], 'State');
            
        if(strcmp(on_or_off, 'ON') == 0)
            fprintf(['The Power Supply ', idDevServ, ' is OFF\n'])
        end
        if(strcmp(on_or_off_corr1, 'ON') == 0||strcmp(on_or_off_corr2, 'ON') == 0||strcmp(on_or_off_corr3, 'ON') == 0)
            fprintf('At least one of the Shim power supplies is OFF\n')
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
            writeattribute([idCorrDevServ '1' '/current1'], Bzc1CurrentToSet);
            writeattribute([idCorrDevServ '1' '/current4'] , Bzc27CurrentToSet);
            writeattribute([idCorrDevServ '2' '/current1'], Bxc1CurrentToSet);
            writeattribute([idCorrDevServ '2' '/current4'], Bxc28CurrentToSet);
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

        else    %APERIODIC=1
            attrCurrent = strcat(idDevServ, '/current');
            attrBzmCurrent1=strcat([idCorrDevServ '1' '/current5']);
            attrBzmCurrent2=strcat([idCorrDevServ '2' '/current5']);
            attrBzmCurrent3=strcat([idCorrDevServ '3' '/current1']);
            attrBzmCurrent4=strcat([idCorrDevServ '3' '/current2']);
            attrBzmCurrent5=strcat([idCorrDevServ '3' '/current3']);
            attrBzmCurrent6=strcat([idCorrDevServ '3' '/current4']);
            attrBzmCurrent7=strcat([idCorrDevServ '3' '/current5']);
            attrBzmCurrent8=strcat([idCorrDevServ '3' '/current6']);
            Bzm1CurrentToSet=HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 1);
            Bzm2CurrentToSet=HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 2);
            Bzm3CurrentToSet=HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 3);
            Bzm4CurrentToSet=HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 4);
            Bzm5CurrentToSet=HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 5);
            Bzm6CurrentToSet=HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 6);
            Bzm7CurrentToSet=HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 7);
            Bzm8CurrentToSet=HU256_GetBzmCurrentForAperiodic(MainCurrentToSet, 8);
            Bzm=[Bzm1CurrentToSet, Bzm2CurrentToSet, Bzm3CurrentToSet, Bzm4CurrentToSet, Bzm5CurrentToSet, Bzm6CurrentToSet, Bzm7CurrentToSet, Bzm8CurrentToSet];
            [BzmMaxCurrentToSet, BzmNumber]=max(abs(Bzm));
            BzmAbsTolerance=abs(BzmMaxCurrentToSet)*RELATIVETOLERANCE;
            if (BzmNumber==1)
                attrBzmCurrent=attrBzmCurrent1;
            elseif (BzmNumber==2)
                attrBzmCurrent=attrBzmCurrent2;
            elseif (BzmNumber==3)
                attrBzmCurrent=attrBzmCurrent3;
            elseif (BzmNumber==4)
                attrBzmCurrent=attrBzmCurrent4;
            elseif (BzmNumber==5)
                attrBzmCurrent=attrBzmCurrent5;
            elseif (BzmNumber==6)
                attrBzmCurrent=attrBzmCurrent6;
            elseif (BzmNumber==7)
                attrBzmCurrent=attrBzmCurrent7;
            elseif (BzmNumber==8)
                attrBzmCurrent=attrBzmCurrent8;
            end
            
            
            writeattribute(attrCurrent, MainCurrentToSet);
            writeattribute([idCorrDevServ '1' '/current1'], Bzc1CurrentToSet);
            writeattribute([idCorrDevServ '1' '/current4'], Bzc27CurrentToSet);
            writeattribute([idCorrDevServ '2' '/current1'], Bxc1CurrentToSet);
            writeattribute([idCorrDevServ '2' '/current4'], Bxc28CurrentToSet);
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
                BzmActCur=readattribute(attrBzmCurrent);
                if((abs(MainCurrentToSet - actCur) <= MainCurrentAbsTol) && (abs(BzmMaxCurrentToSet - BzmActCur) <= BzmAbsTolerance))
                    res = 0;
                    return;
                end
                pause(testTimePeriod_s);
            end
            if(abs(MainCurrentToSet - actCur) > MainCurrentAbsTol)
                res = -1;
                fprintf('Failed to set the requested current\n');
            end
        end %APERIODIC
    end %TESTWITHOUTPS
else % BX 
    idDevServ=[HU256Cell '/EI/m-HU256.2_BX'];
    idCorrDevServ=[HU256Cell '/ei/m-hu256.2_shim.'];
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
            fprintf('One of the Power Supplies BX is OFF\n')
        end
        attrCurrent1 = strcat([idDevServ '1'], '/current');
        attrCurrent2 = strcat([idDevServ '2'], '/current');
        writeattribute(attrCurrent1, MainCurrentToSet);
        if (APERIODIC==0)
            writeattribute(attrCurrent2, MainCurrentToSet);
        else
            writeattribute(attrCurrent2, HU256_GetBX2CurrentForAperiodic(MainCurrentToSet));
        end
        writeattribute([idCorrDevServ '1' '/current1'], Bzc1CurrentToSet);
        writeattribute([idCorrDevServ '1' '/current4'], Bzc27CurrentToSet);
        writeattribute([idCorrDevServ '2' '/current1'], Bxc1CurrentToSet);
        writeattribute([idCorrDevServ '2' '/current4'], Bxc28CurrentToSet);
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
