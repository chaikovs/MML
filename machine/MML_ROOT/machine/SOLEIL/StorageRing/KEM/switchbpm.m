function switchbpm(varargin)
% switchsynchro - Switch timing for using the Machine study kickers (KEM) or Normal injection mode
%
%  INPUTS
%  Injection - Mode for standard injection into the storage ring
%  KEM       - Mode for kicking the beam with a soft event  
%
%  See Also KEMgui

%
%  Written by Laurent S. Nadolski
%  21/07/08 Modification. Use of group

BPMFlag = 'Injection';
normalBufferSize = 1026; % Buffer size for normal mode
KEMBufferSize = 2000; % Buffer for turn by turn data
waitTime = 1; 
manualSwitch = 3; % no switching (turn by turn measurement)
autoSwitch = 255; % automatic switching (normal mode)
%GroupId = tango_group_id('BPM'); % gives one since 2 Mai 2010
GroupId = getfamilydata('BPMx','GroupId');

DeviceListFull = family2dev('BPMx',0);
devList = family2dev('BPMx'); % to put as argin 
tango_group_disable_device2(GroupId, dev2tangodev('BPMx',DeviceListFull));
tango_group_enable_device2(GroupId, dev2tangodev('BPMx',devList));

% Input parser
for i = length(varargin):-1:1,
    if strcmpi(varargin{i},'Injection') || strcmpi(varargin{i},'Inj')
        BPMFlag = 'Injection';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'KEM')
        BPMFlag = 'KEM';
    end
end

%devList = getBPMlist4FMA;
% take all BPMs
devList = family2dev('BPMx'); % ALL BPMs
devName = family2tangodev('BPMx', devList);

% switchyard for injection
switch BPMFlag
    case 'KEM' % BPM setup for Machine studies        
        tango_group_write_attribute2(GroupId, 'Switches',int16(manualSwitch));
        pause(waitTime); % important to wait a while
        MeanVal = mean(tango_group_read_attribute2(GroupId, 'Switches'));
        if MeanVal ~= double(manualSwitch);
            fprintf('At least one BPM has gain different from %d \n', manualSwitch)
        end

        tango_group_write_attribute2(GroupId, 'DDBufferSize', int32(KEMBufferSize));
        MeanVal = mean(tango_group_read_attribute2(GroupId, 'DDBufferSize'));
        if MeanVal ~= double(KEMBufferSize);
            fprintf('At least one BPM has gain different from %d \n', KEMBufferSize)
        end
    case 'Injection'  % BPM setup for normal injection
        tango_group_write_attribute2(GroupId, 'Switches', int16(autoSwitch));
        MeanVal = mean(tango_group_read_attribute2(GroupId, 'Switches'));
        if MeanVal ~= double(autoSwitch);
            fprintf('At least one BPM has gain different from %d \n', autoSwitch)
        end
        pause(waitTime); % important to wait a while
        tango_group_write_attribute2(GroupId, 'DDBufferSize', int32(normalBufferSize));
        MeanVal = mean(tango_group_read_attribute2(GroupId, 'DDBufferSize'));
        if MeanVal ~= double(normalBufferSize);
            fprintf('At least one BPM has gain different from %d \n', normalBufferSize)
        end
end
