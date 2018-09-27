function [AM, tout, DataTime, ErrorFlag] = bpm_observe_sa_levels( varargin )
%BPM_OBSERVE_SA_LEVELS Get SA levels on BPM (depends on the current in the Machine)
%
%  [AM, tout, DataTime, ErrorFlag] = bpm_observe_sa_levels( DataStructure , 'Display' )
%
%  INPUTS
%  1. DataStructure is the output of getbpmrawdata([],'AllData','SA','struct')
%  2. 'Display' / 'NoDisplay'
%
%  OUTPUTS
%  1. AM = AM = [Level_X Level_Z];
%  2. tout  (see help getpv)
%  3. DataTime  (see help getpv)
%  4. ErrorFlag  (see help getpv)
%
%  NOTE
%  1. If no structure as 1st parameter, try to get online data
%
% See also getbpmrawdata, bpm_add_offsets

% Written by  B. Beranger, Master 2013


%% Start time

t0 = clock; % starting time for getting data


%% Input control

% Flags
DisplayFlag = 1;
StructureFlag = 1;

% --- Flag factory ---
for i = length(varargin):-1:1
    
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
        
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
        
    elseif strcmpi(varargin{i},'Struct') || strcmpi(varargin{i},'Structure')
        StructureFlag = 1;
        varargin(i) = [];
        
    elseif strcmpi(varargin{i},'Numeric')
        StructureFlag = 0;
        varargin(i) = [];
        
    end
    
end


if isempty(varargin) % If no input argument, check if can get online data
    
    AO = getfamilydata('BPMx');
    if strcmp(AO.Monitor.Mode,'Online')
        if isfield(AO,'BPM_offset')
            DataStructure = getbpmrawdata([],'AllData','Struct','SA');
        else
            error('No offset detected in AcceleratorObject')
        end
    else
        error('No input detected and unable to get Online data')
    end
    
else
    
    if isstruct(varargin{1}) % Check for input structure
        DataStructure = varargin{1};
    else
        error('First variable must be the input structure or a valid field such as ''Display''')
    end
    
end


%% Shortcuts

Fieldnames = fieldnames(DataStructure.Data);
for k = 1:length(Fieldnames)
    eval([Fieldnames{k} ' = DataStructure.Data.(Fieldnames{k});'])
end


%% X and Z without levels

Kx = 11.4; % mm ( calibration coefficent @SOLEIL )
Kz = 11.4; % mm ( calibration coefficent @SOLEIL )

X_ = Kx *(Va + Vd - Vb - Vc)./(Va + Vb + Vc + Vd);
Z_ = Kz *(Va + Vb - Vc - Vd)./(Va + Vb + Vc + Vd);

bpm_add_offsets_OutputStructure = bpm_add_offsets( X_ , Z_ , DataStructure.DeviceList , DataStructure.Offset , 'SA' );

X_ = bpm_add_offsets_OutputStructure.X_with_offset;
Z_ = bpm_add_offsets_OutputStructure.Z_with_offset;

% Levels
Level_X = X-X_;
Level_Z = Z-Z_;


%% Output

DataTime = now;

if StructureFlag
    
    AM = struct;
    AM.DataDescriptor = 'SA levels on BPM';
    AM.CreatedBy = mfilename;
    AM.TimeStampe = datestr(DataTime);
    
    AM.DataStructure = DataStructure;
    
    AM.Level_X = Level_X;
    AM.Level_Z = Level_Z;
    
else
    
    AM = [Level_X Level_Z];
    
end

ErrorFlag = 0;
tout = etime(clock, t0);


%% Plot

if DisplayFlag
    
    LineWidth = 2;
    FontSize = 20;
    
    spos = getspos('BPMx');
    
    str = sprintf('Offset current dependency for SA data @ %8.3f mA  ( %s )',DataStructure.Dcct,DataStructure.TimeStamp);
    
    figure('Name',str,'NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
    
    ax(1) = subplot(2,1,1);
    hold all
    title(str,'FontSize',FontSize)
    plot(spos,Level_X,'LineWidth',LineWidth)
    ylabel('BPMx SA levels [mm]','FontSize',FontSize)
    set(gca,'FontSize',FontSize)
    removemarge
    
    ax(2) = subplot(2,1,2);
    hold all
    plot(spos,Level_Z,'LineWidth',LineWidth)
    ylabel('BPMz SA levels [mm]','FontSize',FontSize)
    set(gca,'FontSize',FontSize)
    removemarge
    
    xlabel('s [m]','FontSize',FontSize)
    linkaxes(ax,'x')
    
end


end