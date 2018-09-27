function [AM, tout, DataTime, ErrorFlag] = get_bpm_tbt_rebuilt( DeviceList , varargin )
%GET_BPM_TBT_REBUILT - Get rebuilt position of turn-byturn data (DD data)
%WARNING : It can only be used Online because data are gathered by the
%online function getbpmrawdata
%
%  [AM, tout, DataTime, ErrorFlag] = get_bpm_tbt_rebuilt(DeviceList,'Struct')
%
%  INPUTS
%  1. DeviceList must be entered because computation time for all BPM takes a long time
%  2. 'Struct' will return a data structure
%     'Numeric' will return a vector output {default}
%  3. varargin -> can contain fields that will be transmitted to
%  bpm_rebuild_position
%
%  OUTPUTS
%  1. AM = TbT demixed and rebuilt bpm data or data structure
%  2. tout  (see help getpv)
%  3. DataTime  (see help getpv)
%  4. ErrorFlag  (see help getpv)
%
%  NOTE
%  1. AM = { X_demixed_rebuilt , Z_demixed_rebuilt } in case of numeric data
%  1. DeviceList is required and must be the first argument
%  2. Each argument will be transmited to bpm_rebuild_position (see help bpm_rebuild_position -> varargin)
%
% See also getbpmrawdata, bpm_tbt_demixing, bpm_rebuild_position, get_bpm_rebuilt_position_expert

% Written by  B. Beranger, Master 2013

%% Start time

t0 = clock; % starting time for getting data


%% Get input flags and variables

% Flags
StructOutputFlag = 0;
DisplayFlag = 0;

% Loop to check input arguments
for i = length(varargin):-1:1
    
    if ischar(varargin{i})
        if strcmpi(varargin{i},'Struct') || strcmpi(varargin{i},'Structure')
            StructOutputFlag = 1;
            varargin{i} = [];
            
        elseif strcmpi(varargin{i},'Numeric')
            StructOutputFlag = 0;
            varargin{i} = [];
            
        elseif strcmpi(varargin{i},'Display')
            DisplayFlag = 1;
            varargin{i} = [];
            
        elseif strcmpi(varargin{i},'NoDisplay')
            DisplayFlag = 0;
            varargin{i} = [];
            
        end
        
    end
end


%% Check if Mode is 'Online'

% Get AcceleratorObjects to know if Mode is 'Online'
AO = getfamilydata('BPMx');
if ~strcmp(AO.Monitor.Mode,'Online')
    error('%s function can only be used Online',mfilename)
end


%% Check for the DeviceList

if nargin < 1
    error('At least DeviceList is required as first input')
end

if isnumeric(DeviceList)
    if isempty(DeviceList)
        warning('Usually, all BPM available are not asked because it takes time to compute') %#ok<WNTAG>
    end
else
    error('DeviceList must be numeric')
end


%% Get data on BPMs

raw_data = getbpmrawdata(DeviceList,'AllData','DD','Struct');


%% Demix data

demixed_data = bpm_tbt_demixing('InputStructure',raw_data,'NoEcho');


%% Rebuilt data

SignalName = '_IQ_exp';

% Reorganization of potentials
V = cell(size(demixed_data.Data.Va));
for i = 1:size(demixed_data.Data.Va,1)
    for j = 1:size(demixed_data.Data.Va,2)
        V{i,j} = [demixed_data.Data.Va_IQ_exp(i,j) demixed_data.Data.Vb_IQ_exp(i,j) demixed_data.Data.Vc_IQ_exp(i,j) demixed_data.Data.Vd_IQ_exp(i,j)];
    end
end

% Rebuild data
demixed_rebuilt_data = bpm_rebuild_position(...
    V ,...
    demixed_data.Data.(['X' SignalName]) ,...
    demixed_data.Data.(['Z' SignalName]) ,...
    varargin{:} );


%% Add offsets

% Add the offsets
demixed_rebuilt_position_with_offset = bpm_add_offsets(...
    demixed_rebuilt_data.X_rebuilt,...
    demixed_rebuilt_data.Z_rebuilt,...
    raw_data.DeviceList,...
    demixed_data.Offset,'DD');

X_demixed_rebuilt = demixed_rebuilt_position_with_offset.X_with_offset;
Z_demixed_rebuilt = demixed_rebuilt_position_with_offset.Z_with_offset;


%% Output

DataTime = now;

if StructOutputFlag
    
    AM = struct;
    
    AM.DataDescriptor = 'Online TbT data demixed and rebuilt';
    AM.CreatedBy = mfilename;
    AM.TimeStamp = datestr(DataTime);
    
    AM.raw_data= raw_data;
    AM.demixed_data = demixed_data;
    AM.demixed_rebuild_position = demixed_rebuilt_data;
    AM.demixed_rebuilt_position_with_offset = demixed_rebuilt_position_with_offset;
    
    AM.DeciceList = raw_data.DeviceList;
    AM.X_demixed_rebuilt = X_demixed_rebuilt;
    AM.Z_demixed_rebuilt = Z_demixed_rebuilt;
    
    
else
    
    AM = { X_demixed_rebuilt , Z_demixed_rebuilt };
    
end

ErrorFlag = 0;
tout = etime(clock, t0);


%% Display

if DisplayFlag
    
    LineWidth = 2;
    FontSize = 20;
    
    % Loop for all the selected device number
    for k = 1:size(raw_data.DeviceList,1)
        
        % X for DD data
        figure('Name',sprintf('X%s for %s',SignalName,raw_data.DeviceName{k}),'NumberTitle','off',...
            'units','normalized','OuterPosition',[0 0.03 1 0.97])
        hold all
        plot(raw_data.Data.X(k,:),'-black','LineWidth',LineWidth)
        plot(demixed_data.Data.(['X' SignalName])(k,:),'-blue','LineWidth',LineWidth)
        plot(X_demixed_rebuilt(k,:),'-red','LineWidth',LineWidth)
        legend('Raw','Demixed','Demixed-Rebuilt')
        xlabel('Turn','FontSize',FontSize)
        ylabel('Horizontal position','FontSize',FontSize)
        set(gca,'FontSize',FontSize)
        removemarge
        axis tight
        
        % Z for DD data
        figure('Name',sprintf('Z%s for %s',SignalName,raw_data.DeviceName{k}),'NumberTitle','off',...
            'units','normalized','OuterPosition',[0 0.03 1 0.97])
        hold all
        plot(raw_data.Data.Z(k,:),'-black','LineWidth',LineWidth)
        plot(demixed_data.Data.(['Z' SignalName])(k,:),'-blue','LineWidth',LineWidth)
        plot(Z_demixed_rebuilt(k,:),'-red','LineWidth',LineWidth)
        legend('Raw','Demixed','Demixed-Rebuilt')
        xlabel('Turn','FontSize',FontSize)
        ylabel('Vertical position','FontSize',FontSize)
        set(gca,'FontSize',FontSize)
        removemarge
        axis tight
        
    end
    
end

end
