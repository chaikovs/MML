function res = HU256_SetCurrentSyncCorr(currentToSet, currentAbsTol, CVECurrentToSet, CHECurrentToSet, CVSCurrentToSet, CHSCurrentToSet)
%Version Aperiodic & helicoidal

% If the global variable APERIODIC = 0 or 1 :
    % Drives either BZP power supply, either both BX1 and BX2 power supplies
    % (at the same time), depending on POWERSUPPLYNAME. Correctors and Bzm power supplies are driven too.
% If APERIODIC = 'hel'
    % Drives BZP, BX1 and BX2 power supplies at the same time, with Correctors and Bzm power supplies too.
% If POWERSUPPLYNAME='bz', we read the BZP current to check if the power supplies have reached the setpoints.
% If POWERSUPPLYNAME='bx', we read both BX1 and BX2 currents to check if the power supplies have reached the setpoints.
% No check on correction and modulation currents!!!
% No cycling in this function!!
% Returns   -1 if the currents were not asked (power supply off, setpoint out of range...)
%           0 if the currents were asked but did not reach the setpoints
%           1 if OK


global HU256CELL;
global TESTWITHOUTPS;
global APERIODIC;
global POWERSUPPLYNAME;
%global SENSEOFCURRENT;
global PRESENTCURRENT;
%global BXSENSEOFCURRENTFORHEL;
global BXPRESENTCURRENTFORHEL;
global MAXDELAY;
global DEBUG;

% HU256CELL=15;
% TESTWITHOUTPS=1;
% APERIODIC=1;
% POWERSUPPLYNAME='bx';
% PRESENTCURRENT=10;
% BXPRESENTCURRENTFORHEL=15;
% MAXDELAY=5;


testTimePeriod_s = 1; %to edit

HU256Cell=['ANS-C' num2str(HU256CELL, '%02.0f')];

res = -1;

maxNumTests = round(MAXDELAY/testTimePeriod_s);

if (strcmp(POWERSUPPLYNAME, 'bz')==0&&strcmp(POWERSUPPLYNAME, 'bx')==0)
    fprintf('%s', 'Problem in HU256_SetCurrentSyncCorr : The global variable POWERSUPPLYNAME is not right. Please initialise the cycle!\n')
    return
end

if (isa(APERIODIC, 'numeric')==1)   % classic mode
    if (strcmp(POWERSUPPLYNAME, 'bz')==1)
        if (APERIODIC==1)  % Aperiodic
            BZPCurrentToSet=currentToSet;
            BX1CurrentToSet=0;
            BX2CurrentToSet=0;
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
            BX1CurrentToSet=0;
            BX2CurrentToSet=0;
            Bzm1CurrentToSet=0;
            Bzm2CurrentToSet=0;
            Bzm3CurrentToSet=0;
            Bzm4CurrentToSet=0;
            Bzm5CurrentToSet=0;
            Bzm6CurrentToSet=0;
            Bzm7CurrentToSet=0;
            Bzm8CurrentToSet=0;
        end % Aperiodic or not
    else    % bx
        if (APERIODIC==0)
            BZPCurrentToSet=0;
            BX1CurrentToSet=currentToSet;
            BX2CurrentToSet=currentToSet;
            Bzm1CurrentToSet=0;
            Bzm2CurrentToSet=0;
            Bzm3CurrentToSet=0;
            Bzm4CurrentToSet=0;
            Bzm5CurrentToSet=0;
            Bzm6CurrentToSet=0;
            Bzm7CurrentToSet=0;
            Bzm8CurrentToSet=0;
        else
            BZPCurrentToSet=0;
            BX1CurrentToSet=currentToSet;
            BX2CurrentToSet=HU256_GetBX2CurrentForAperiodic(currentToSet);
            Bzm1CurrentToSet=0;
            Bzm2CurrentToSet=0;
            Bzm3CurrentToSet=0;
            Bzm4CurrentToSet=0;
            Bzm5CurrentToSet=0;
            Bzm6CurrentToSet=0;
            Bzm7CurrentToSet=0;
            Bzm8CurrentToSet=0;
        end
    end     % choice of power supply
    
else    % Helicoidal
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
end


if (BZPCurrentToSet>200||BZPCurrentToSet<-200)
    fprintf ('Problem with HU256_SetCurrentSyncCorr : The current asked for BZP is not correct.\n')
    return
end 
if (isnan(Bzm1CurrentToSet)||isnan(Bzm2CurrentToSet)||isnan(Bzm3CurrentToSet)||isnan(Bzm4CurrentToSet)||isnan(Bzm5CurrentToSet)||isnan(Bzm6CurrentToSet)||isnan(Bzm7CurrentToSet)||isnan(Bzm8CurrentToSet))
    fprintf ('Problem with HU256_SetCurrentSyncCorr : At least one of the Bzm currents was not calculated correctly.\n')
    return
end
if (isnan(CVECurrentToSet)||isnan(CHECurrentToSet)||isnan(CVSCurrentToSet)||isnan(CHSCurrentToSet))
    fprintf ('Problem with HU256_SetCurrentSyncCorr : At least one of the Corrector currents was not calculated correctly.\n')
    return
end
if (Bzm1CurrentToSet<-10||Bzm2CurrentToSet<-10||Bzm3CurrentToSet<-10||Bzm4CurrentToSet<-10||Bzm5CurrentToSet<-10||Bzm6CurrentToSet<-10||Bzm7CurrentToSet<-10||Bzm8CurrentToSet<-10||Bzm1CurrentToSet>10||Bzm2CurrentToSet>10||Bzm3CurrentToSet>10||Bzm4CurrentToSet>10||Bzm5CurrentToSet>10||Bzm6CurrentToSet>10||Bzm7CurrentToSet>10||Bzm8CurrentToSet>10)
    fprintf ('Problem with HU256_SetCurrentSyncCorr : At least one of the Bzm currents is out of range.\n')
    return
end
if (CVECurrentToSet<-10||CHECurrentToSet<-10||CVSCurrentToSet<-10||CHSCurrentToSet<-10||CVECurrentToSet>10||CHECurrentToSet>10||CVSCurrentToSet>10||CHSCurrentToSet>10)
    fprintf ('Problem with HU256_SetCurrentSyncCorr : At least one of the Corrector currents is out of range.\n')
    return
end
if (BX1CurrentToSet>275||BX1CurrentToSet<0)
    fprintf ('Problem with HU256_SetCurrentSyncCorr : The current asked for BX1 is not correct.\n')
    return
end 
if (BX2CurrentToSet>275||BX2CurrentToSet<0)
    fprintf ('Problem with HU256_SetCurrentSyncCorr : The current asked for BX2 is not correct.\n')
    return
end

idBZPDevServ=[HU256Cell '/EI/m-HU256.2_BZP'];
idBX1DevServ=[HU256Cell '/EI/m-HU256.2_BX1'];
idBX2DevServ=[HU256Cell '/EI/m-HU256.2_BX2'];
idCorrDevServ=[HU256Cell '/EI/M-HU256.2_SHIM.'];

on_or_off_BZP = tango_command_inout2(idBZPDevServ, 'State');
on_or_off_BX1 = tango_command_inout2(idBX1DevServ, 'State');
on_or_off_BX2 = tango_command_inout2(idBX2DevServ, 'State');
on_or_off_corr1 = tango_command_inout2([idCorrDevServ '1'], 'State');
on_or_off_corr2 = tango_command_inout2([idCorrDevServ '2'], 'State');
on_or_off_corr3 = tango_command_inout2([idCorrDevServ '3'], 'State');
if (TESTWITHOUTPS~=1)
    if (strcmp(on_or_off_BZP, 'OFF') == 1)
        fprintf(['Problem with HU256_SetCurrentSyncCorr : The Power Supply ', idBZPDevServ, ' is OFF\n'])
        return
    end
    if (strcmp(on_or_off_BX1, 'OFF') == 1)
        fprintf(['Problem with HU256_SetCurrentSyncCorr : The Power Supply ', idBX1DevServ, ' is OFF\n'])
        return
    end
    if (strcmp(on_or_off_BX2, 'OFF') == 1)
        fprintf(['Problem with HU256_SetCurrentSyncCorr : The Power Supply ', idBX2DevServ, ' is OFF\n'])
        return
    end
    if (strcmp(on_or_off_corr1, 'OFF') == 1||strcmp(on_or_off_corr2, 'OFF') == 1||strcmp(on_or_off_corr3, 'OFF') == 1)
        fprintf('Problem with HU256_SetCurrentSyncCorr : At least one Shim power supply is OFF\n')
        return
    end
end
attrBZPCurrent = [idBZPDevServ, '/current'];
attrBX1Current = [idBX1DevServ, '/current'];
attrBX2Current = [idBX2DevServ, '/current'];
attrCVECurrent = [idCorrDevServ '2' '/current1'];
attrCHECurrent = [idCorrDevServ '1' '/current1'];
attrCVSCurrent = [idCorrDevServ '2' '/current4'];
attrCHSCurrent = [idCorrDevServ '1' '/current4'];
attrBzmCurrent1 = [idCorrDevServ '1' '/current5'];
attrBzmCurrent2 = [idCorrDevServ '2' '/current5'];
attrBzmCurrent3 = [idCorrDevServ '3' '/current1'];
attrBzmCurrent4 = [idCorrDevServ '3' '/current2'];
attrBzmCurrent5 = [idCorrDevServ '3' '/current3'];
attrBzmCurrent6 = [idCorrDevServ '3' '/current4'];
attrBzmCurrent7 = [idCorrDevServ '3' '/current5'];
attrBzmCurrent8 = [idCorrDevServ '3' '/current6'];

% attrBZPCurrent = strcat(idBZPDevServ, '/current');
% attrBX1Current = strcat(idBX1DevServ, '/current');
% attrBX2Current = strcat(idBX2DevServ, '/current');
% attrCVECurrent = strcat([idCorrDevServ '2' '/current1']);
% attrCHECurrent = strcat([idCorrDevServ '1' '/current4']);
% attrCVSCurrent = strcat([idCorrDevServ '2' '/current1']);
% attrCHSCurrent = strcat([idCorrDevServ '1' '/current4']);
% attrBzmCurrent1 = strcat([idCorrDevServ '1' '/current5']);
% attrBzmCurrent2 = strcat([idCorrDevServ '2' '/current5']);
% attrBzmCurrent3 = strcat([idCorrDevServ '3' '/current1']);
% attrBzmCurrent4 = strcat([idCorrDevServ '3' '/current2']);
% attrBzmCurrent5 = strcat([idCorrDevServ '3' '/current3']);
% attrBzmCurrent6 = strcat([idCorrDevServ '3' '/current4']);
% attrBzmCurrent7 = strcat([idCorrDevServ '3' '/current5']);
% attrBzmCurrent8 = strcat([idCorrDevServ '3' '/current6']);


if (DEBUG==1)
    fprintf('Debug HU256_SetCurrentSyncCorr : Consignes -> BZP:%3.3f, BX1:%3.3f ,BX2:%3.3f, CVE:%3.3f, CHE:%3.3f, CVS:%3.3f, CHS:%3.3f, Bzm1:%3.3f,  Bzm2:%3.3f, Bzm3:%3.3f, Bzm4:%3.3f, Bzm5:%3.3f, Bzm6:%3.3f, Bzm7:%3.3f, Bzm8:%3.3f\n', BZPCurrentToSet, BX1CurrentToSet, BX2CurrentToSet, CVECurrentToSet, CHECurrentToSet, CVSCurrentToSet, CHSCurrentToSet, Bzm1CurrentToSet, Bzm2CurrentToSet, Bzm3CurrentToSet, Bzm4CurrentToSet, Bzm5CurrentToSet, Bzm6CurrentToSet, Bzm7CurrentToSet, Bzm8CurrentToSet)
end         
if (TESTWITHOUTPS==1)
    fprintf('#TESTWITHOUTPS : BZP -> %03.3f\tBX1 -> %03.3f\tBX2 -> %03.3f\tCVE -> %03.3f\tCHE -> %03.3f\tCVS -> %03.3f\tCHS -> %03.3f\nBzm1 -> %03.3f\tBzm2 -> %03.3f\tBzm3 -> %03.3f\tBzm4 -> %03.3f\tBzm5 -> %03.3f\tBzm6 -> %03.3f\tBzm7 -> %03.3f\tBzm8 -> %03.3f\n', BZPCurrentToSet, BX1CurrentToSet, BX2CurrentToSet, CVECurrentToSet, CHECurrentToSet, CVSCurrentToSet, CHSCurrentToSet, Bzm1CurrentToSet, Bzm2CurrentToSet, Bzm3CurrentToSet, Bzm4CurrentToSet, Bzm5CurrentToSet, Bzm6CurrentToSet, Bzm7CurrentToSet, Bzm8CurrentToSet)

else
    writeattribute(attrBZPCurrent, BZPCurrentToSet);
    if (DEBUG==1)
        fprintf('Debug HU256_SetCurrentSyncCorr : put %3.3fA in ''%s''\n', BZPCurrentToSet, attrBZPCurrent)
    end
    writeattribute(attrBX1Current, BX1CurrentToSet);
    if (DEBUG==1)
        fprintf('Debug HU256_SetCurrentSyncCorr : put %3.3fA in ''%s''\n', BX1CurrentToSet, attrBX1Current)
    end
    writeattribute(attrBX2Current, BX2CurrentToSet);
    if (DEBUG==1)
        fprintf('Debug HU256_SetCurrentSyncCorr : put %3.3fA in ''%s''\n', BX2CurrentToSet, attrBX2Current)
    end
    writeattribute(attrCVECurrent, CVECurrentToSet);
    if (DEBUG==1)
        fprintf('Debug HU256_SetCurrentSyncCorr : put %3.3fA in ''%s''\n', CVECurrentToSet, attrCVECurrent)
    end
    writeattribute(attrCHECurrent, CHECurrentToSet);
    if (DEBUG==1)
        fprintf('Debug HU256_SetCurrentSyncCorr : put %3.3fA in ''%s''\n', CHECurrentToSet, attrCHECurrent)
    end
    writeattribute(attrCVSCurrent, CVSCurrentToSet);
    if (DEBUG==1)
        fprintf('Debug HU256_SetCurrentSyncCorr : put %3.3fA in ''%s''\n', CVSCurrentToSet, attrCVSCurrent)
    end
    writeattribute(attrCHSCurrent, CHSCurrentToSet);
    if (DEBUG==1)
        fprintf('Debug HU256_SetCurrentSyncCorr : put %3.3fA in ''%s''\n', CHSCurrentToSet, attrCHSCurrent)
    end
    writeattribute(attrBzmCurrent1, Bzm1CurrentToSet);
    writeattribute(attrBzmCurrent2, Bzm2CurrentToSet);
    writeattribute(attrBzmCurrent3, Bzm3CurrentToSet);
    writeattribute(attrBzmCurrent4, Bzm4CurrentToSet);
    writeattribute(attrBzmCurrent5, Bzm5CurrentToSet);
    writeattribute(attrBzmCurrent6, Bzm6CurrentToSet);
    writeattribute(attrBzmCurrent7, Bzm7CurrentToSet);
    writeattribute(attrBzmCurrent8, Bzm8CurrentToSet);
    res=0;
    
    if (strcmp(POWERSUPPLYNAME, 'bz')==1)
        actCur = 0;
        for i = 1:maxNumTests
            actCur = readattribute([idBZPDevServ, '/current']);
            if(abs(BZPCurrentToSet - actCur) <= currentAbsTol)
                return;
            end
            pause(testTimePeriod_s);
        end
        if(abs(BZPCurrentToSet - actCur) > currentAbsTol)
            fprintf('Problem in HU256_SetCurrentSyncCorr : Failed to set the requested currents in time.\n');
        end
    else
        actCur1 = 0;
        actCur2 = 0;
        for i = 1:maxNumTests
            actCur1 = readattribute([idBX1DevServ '/current']);
            actCur2 = readattribute([idBX2DevServ '/current']);
            if((abs(BX1CurrentToSet - actCur1) <= currentAbsTol)&&(abs(BX2CurrentToSet - actCur2) <= currentAbsTol))
                return;
            end
            pause(testTimePeriod_s);
        end
        if((abs(BX1CurrentToSet - actCur1) > currentAbsTol)||(abs(BX2CurrentToSet - actCur2) > currentAbsTol))
            fprintf('Problem in HU256_SetCurrentSyncCorr : Failed to set the requested currents in time.\n');
        end
    end     % Choice of Power Supply
end     % TESTWITHOUTPS
res=1;






