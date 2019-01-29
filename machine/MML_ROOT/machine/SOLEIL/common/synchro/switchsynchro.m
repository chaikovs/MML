function switchsynchro(varargin)
% switchsynchro - Switch timing for using the Machine study kickers (KEM) or 
% Normal injection mode or 3 Hz for BPMs
%
%  INPUTS
%  Injection - Mode for standard injection into the storage ring
%  KEM       - Mode for kicking the beam with a soft event 
%  3Hz       - Mode for conitnuous trigging BPM at 3 Hz

%
%  Written by Laurent S. Nadolski
%  22 July 2008: Display and group added 
%  9 december 2010: Add 3 Hz for pseudo single bunch

SynchroFlag = 'Injection';
DisplayFlag = 1;

% Input parser
for i = length(varargin):-1:1,
    if strcmpi(varargin{i},'Injection') || strcmpi(varargin{i},'Inj')
        SynchroFlag = 'Injection';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'KEM')
        SynchroFlag = 'KEM';
    elseif strcmpi(varargin{i},'3Hz')
        SynchroFlag = '3Hz';
    elseif strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    end
end

% switchyard for injection
switch SynchroFlag
    case 'KEM' % Switch Timing system for using KEMs
        event = 16;
        tango_write_attribute2('ANS/SY/CENTRAL','softEventAdress',int32(event));
        tango_write_attribute2('ANS-C01/SY/LOCAL.DG.2','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C02/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C03/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C04/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C05/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C06/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C07/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C08/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C09/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C10/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C11/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C12/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C13/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C14/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C15/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C16/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1','k-h.trigEvent',int32(event));
        tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1','k-v.trigEvent',int32(event));
        pause(1)
        checktimingconfig(event, 'KEM');
        
    case 'Injection'  % Switch back for injection anly for BPMs
        eventInj = 3;
        tango_write_attribute2('ANS/SY/CENTRAL','softEventAdress',int32(5));
        tango_write_attribute2('ANS-C01/SY/LOCAL.DG.2','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C02/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C03/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C04/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C05/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C06/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C07/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C08/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C09/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C10/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C11/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C12/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C13/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C14/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C15/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        tango_write_attribute2('ANS-C16/SY/LOCAL.DG.1','bpm.trigEvent',int32(eventInj));
        pause(1)
        checktimingconfig(eventInj);        
    case '3Hz'  % Switch back for injection anly for BPMs
        event = 4;
        tango_write_attribute2('ANS/SY/CENTRAL','softEventAdress',int32(5));
        tango_write_attribute2('ANS-C01/SY/LOCAL.DG.2','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C02/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C03/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C04/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C05/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C06/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C07/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C08/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C09/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C10/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C11/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C12/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C13/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C14/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C15/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        tango_write_attribute2('ANS-C16/SY/LOCAL.DG.1','bpm.trigEvent',int32(event));
        pause(1)
        checktimingconfig(event);        
    otherwise
        error('Wrong mode');
end

% Diagnostics for checking evering thing is OK

devName={'ANS-C01/SY/LOCAL.DG.2'
         'ANS-C02/SY/LOCAL.DG.1'
         'ANS-C03/SY/LOCAL.DG.1'
         'ANS-C04/SY/LOCAL.DG.1'
         'ANS-C05/SY/LOCAL.DG.1'
         'ANS-C06/SY/LOCAL.DG.1'
         'ANS-C07/SY/LOCAL.DG.1'
         'ANS-C08/SY/LOCAL.DG.1'
         'ANS-C09/SY/LOCAL.DG.1'
         'ANS-C10/SY/LOCAL.DG.1'
         'ANS-C11/SY/LOCAL.DG.1'
         'ANS-C12/SY/LOCAL.DG.1'
         'ANS-C13/SY/LOCAL.DG.1'
         'ANS-C14/SY/LOCAL.DG.1'
         'ANS-C15/SY/LOCAL.DG.1'
         'ANS-C16/SY/LOCAL.DG.1'
    };

if DisplayFlag
    val =[];
    for k=1:length(devName)
        val(k) = readattribute([devName{k} '/bpm.trigEvent']);
    end

    figure
    bar(val)
    title('Trigger Event Value for BPM timing board')
    xlabel('Cell number')
    ylabel('Event value')
end

% subfunction
function checktimingconfig(value, varargin)

% Default flag
KEMFlag = 0;

for i = length(varargin):-1:1
    if strcmpi(varargin{i},'NoKEM')
        KEMFlag = 0;
        varargin(i) = [];
    else strcmpi(varargin{i},'KEM')
        KEMFlag = 1;
        varargin(i) = [];
    end
end


if KEMFlag
    val = ones(1,19)*NaN;
else
    val = ones(1,17)*NaN;
end

val(1) = readattribute(['ANS/SY/CENTRAL','/softEventAdress']);
val(2) = readattribute(['ANS-C01/SY/LOCAL.DG.2','/bpm.trigEvent']);
val(3) = readattribute(['ANS-C02/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(4) = readattribute(['ANS-C03/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(5) = readattribute(['ANS-C04/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(6) = readattribute(['ANS-C05/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(7) = readattribute(['ANS-C06/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(8) = readattribute(['ANS-C07/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(9) = readattribute(['ANS-C08/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(10) = readattribute(['ANS-C09/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(11) = readattribute(['ANS-C10/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(12) = readattribute(['ANS-C11/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(13) = readattribute(['ANS-C12/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(14) = readattribute(['ANS-C13/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(15) = readattribute(['ANS-C14/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(16) = readattribute(['ANS-C15/SY/LOCAL.DG.1','/bpm.trigEvent']);
val(17) = readattribute(['ANS-C16/SY/LOCAL.DG.1','/bpm.trigEvent']);

if KEMFlag
    val(18) = readattribute(['ANS-C01/SY/LOCAL.EP.1','/k-h.trigEvent']);
    val(19) = readattribute(['ANS-C01/SY/LOCAL.EP.1','/k-v.trigEvent']);
end

if mean(val(2:end)) ~= value
    fprintf('At least one timing board is not set properly to %d soft address \n', value);
end

%% KEM settings
if KEMFlag
    kemh_target = 31932.64;
    kemv_target = 31932.64;
    kemh = readattribute(['ANS-C01/SY/LOCAL.EP.1','/k-h.trigTimeDelay']);
    kemv = readattribute(['ANS-C01/SY/LOCAL.EP.1','/k-v.trigTimeDelay']);
    if kemh ~= kemh_target || kemv ~= kemv_target        
        warndlg(sprintf([
            'KEM timing not properly set \n' ...
            'kemh is %.2f us (%.2f)\n'...
            'kemv is %.2f us (%.2f)\n'], kemh, kemh_target, kemv, kemv_target));
            
        writeattribute(['ANS-C01/SY/LOCAL.EP.1','/k-h.trigTimeDelay'], kemh_target);
        writeattribute(['ANS-C01/SY/LOCAL.EP.1','/k-v.trigTimeDelay'], kemv_target);
    end
end
