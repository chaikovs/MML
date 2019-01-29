function [AM, tout, DataTime, ErrorFlag] = get_bpm_co_rebuilt( varargin )
%GET_BPM_CO_REBUILT - Get rebuilt position of closed orbit (SA data)
%WARNING : It can only be used Online because data are gathered by the
%online function getbpmrawdata
%
%  [AM, tout, DataTime, ErrorFlag] = get_bpm_co_rebuilt(DeviceList,'Struct','Display')
%
%  INPUTS
%  1. DeviceList (default = [], meaning all BPM)
%  2. 'Struct' will return a data structure
%     'Numeric' will return a vector output {default}
%  3. 'Display' plots a figure showing X Z (raw and rebuilt) and lattice synoptique
%  3. varargin -> can contain fields that will be transmitted to
%  bpm_rebuild_position, but DeviceList must be the 1st argument
%
%  OUTPUTS
%  1. AM = closed orbit vectors or data structure
%  2. tout  (see help getpv)
%  3. DataTime  (see help getpv)
%  4. ErrorFlag  (see help getpv)
%
%  NOTE
%  1. DeviceList must be the first argument
%  2. Each argument will be transmitted to bpm_rebuild_position (see help bpm_rebuild_position -> varargin)
%  3. All inputs are optional
%
% See also getbpmrawdata, bpm_rebuild_position, getx, getz,
% get_bpm_rebuilt_position_expert

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


% Check for the DeviceList
if isempty(varargin)
    DeviceList = [];
else
    if isnumeric(varargin{1})
        DeviceList = varargin{1};
        varargin{1} = [];
    else
        error('1st input must be DeviceList in case of using arguments that will be transmitted to bpm_rebuild_position')
    end
end


%% Check if Mode is 'Online'

% Get AcceleratorObjects to know if Mode is 'Online'
AO = getfamilydata('BPMx');
if ~strcmp(AO.Monitor.Mode,'Online')
    error('%s function can only be used Online',mfilename)
end


%% Get data on BPMs

raw_data = getbpmrawdata(DeviceList,'AllData','SA','Struct');
X_raw = raw_data.Data.X;
Z_raw = raw_data.Data.Z;


%% Rebuilt data

% Reorganization of potentials
V = cell(length(raw_data.Data.Va),1);
for k = 1:length(raw_data.Data.Va)
    V{k} = [raw_data.Data.Va(k) raw_data.Data.Vb(k) raw_data.Data.Vc(k) raw_data.Data.Vd(k)];
end

% Rebuild data
rebuilt_data = bpm_rebuild_position( V , X_raw , Z_raw , varargin{:} );


%% Add BPM offsets

% Add the offsets
rebuilt_position_with_offset = bpm_add_offsets(rebuilt_data.X_rebuilt,rebuilt_data.Z_rebuilt,raw_data.DeviceList,raw_data.Offset,'SA');

X_rebuilt = rebuilt_position_with_offset.X_with_offset;
Z_rebuilt = rebuilt_position_with_offset.Z_with_offset;


%% Output

DataTime = now;

if StructOutputFlag % Structure output
    
    AM = struct;
    
    AM.DataDescriptor = 'Online closed orbit reconstructed';
    AM.CreatedBy = mfilename;
    AM.TimeStamp = datestr(DataTime);
    
    AM.getrawbpmdata = raw_data;
    AM.rebuild_position = rebuilt_data;
    AM.bpm_add_offsets = rebuilt_position_with_offset;
    
    AM.X_rebuilt = X_rebuilt;
    AM.Z_rebuilt = Z_rebuilt;
    
    
else % Numeric output
    
    AM = [ X_rebuilt Z_rebuilt ];
    
end

ErrorFlag = 0;
tout = etime(clock, t0);


%% Display

if DisplayFlag
    
    LineWidth = 2;
    FontSize = 20;
    
    spos = getspos('BPMx');
    
    % Figure reprensenting SA data
    figure('Name',sprintf('Closed orbit data (''SA'')'),'NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
    hold all
    xlim([0 getcircumference])
    
    % X for SA data
    ax(1) = subplot(5,1,1:2);
    hold all
    grid on
    plot(spos,X_raw,'-black','LineWidth',LineWidth)
    plot(spos,X_rebuilt,'-red','LineWidth',LineWidth)
    ylabel('X [mm]','FontSize',FontSize)
    legend('Raw','Rebuilt')
    set(gca,'FontSize',FontSize)
    TI = get(gca,'TightInSet');
    OP = get(gca,'OuterPosition');
    Pos = OP + [ TI(1:2), -TI(1:2)-TI(3:4) ];
    set( gca,'Position',Pos);
    axis tight
    
    % Lattice
    ax(2) = subplot(5,1,3);
    drawlattice
    set(gca,'FontSize',FontSize)
    OP = get(gca,'OuterPosition');
    Pos = OP + [ TI(1:2), -TI(1:2)-TI(3:4) ];
    set( gca,'YTick',[],'XTick',[],'Position',Pos);
    axis tight
    
    % Z for SA data
    ax(3) = subplot(5,1,4:5);
    hold all
    grid on
    plot(spos,Z_raw,'-black','LineWidth',LineWidth)
    plot(spos,Z_rebuilt,'-red','LineWidth',LineWidth)
    xlabel('s (m)','FontSize',FontSize)
    ylabel('Z [mm]','FontSize',FontSize)
    legend('Raw','Rebuilt')
    set(gca,'FontSize',FontSize)
    TI = get(gca,'TightInSet');
    OP = get(gca,'OuterPosition');
    Pos = OP + [ TI(1:2), -TI(1:2)-TI(3:4) ];
    set( gca,'Position',Pos);
    axis tight
    
    linkaxes(ax,'x')
    
end


end
