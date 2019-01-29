function [RunFlag, Delta, Tol] = getrunflag(varargin)
%GETRUNFLAG - Returns position if the device is in the process of changing a setpoint
%  If using family name, field, device list method,
%  [RunFlag, Delta, Tol] = getrunflag(Family, Field, DeviceList)
%  [RunFlag, Delta, Tol] = getrunflag(Family, DeviceList)  
%
%  If using channel name method,
%  [RunFlag, Delta] = getrunflag(ChannelNames)
%
%  INPUTS
%  1. Family - Family Name 
%              Accelerator Object
%     ChannelName - Channel/TANGO access channel name
%                   Matrix of channel/TANGO names
%  2. Field - Field name  {Default: 'Setpoint')
%  3. DeviceList - [Sector Device #] or [element #] list {Default or empty list: whole family}
%
%  OUTPUTS
%  1. RunFlag - 1 if monitor has not reached the setpoint (Column vector)
%               0 if the monitor and the setpoint are within tolerance (Column vector)
%               [] runflag not found
%  2. Delta - Diffence between where it is and where is should be.
%  3. Tol - Allowed tolerance between the setpoint and the monitor
%
%  Note: If inputs are cell arrays, then outputs are cell arrays.

%
%  Written by Gregory J. Portmann
%  Modified by Laurent S. Nadolski

if nargin == 0,
    error('Must have at least one input (Family or Channel/Tango Name).');
end


%%%%%%%%%%%%%%%%%%%%%
% Cell Array Inputs %
%%%%%%%%%%%%%%%%%%%%%
if iscell(varargin{1})
    % Cell arrays 
    for i = 1:length(varargin{1})
        if nargin < 2
            [RunFlag{i}, Delta{i}, Tol{i}] = getrunflag(varargin{1}{i});
        elseif nargin < 3
            if iscell(varargin{2})
                [RunFlag{i}, Delta{i}, Tol{i}] = getrunflag(varargin{1}{i}, varargin{2}{i});
            else
                [RunFlag{i}, Delta{i}, Tol{i}] = getrunflag(varargin{1}{i}, varargin{2});
            end
        else
            if iscell(varargin{3})
                [RunFlag{i}, Delta{i}, Tol{i}] = getrunflag(varargin{1}{i}, varargin{2}{i}, varargin{3}{i});
            else
                [RunFlag{i}, Delta{i}, Tol{i}] = getrunflag(varargin{1}{i}, varargin{2}{i}, varargin{3});
            end
        end
    end
    return
end


%%%%%%%%%%%%%%%%%%%%%%
% Common Name Inputs %
%%%%%%%%%%%%%%%%%%%%%%
if isempty(varargin{1})
    % Common names with no family name
    if nargin < 2
        error('If Family=[], 2 inputs are required.');
    end
    CommonNames = varargin{3};
    for i = 1:size(CommonNames,1)
        Family = common2family(CommonNames(i,:));
        [FamilyIndex, ACCELERATOR_OBJECT] = isfamily(Family);
        DeviceList = common2dev(CommonNames(i,:), ACCELERATOR_OBJECT);
        if isempty(DeviceList) | isempty(DeviceList)
            error('Common name could not be converted to a Family and DeviceList.');
        end
        [RunFlag(i,:), Delta(i,:), Tol(i,:)] = getrunflag(Family, DeviceList);
    end
    return
end


%%%%%%%%%%%%%%%%%%%%%%%
% Channel Name Inputs %
%%%%%%%%%%%%%%%%%%%%%%%
if ~isfamily(varargin{1}(1,:))
    % Channel name method
    % Try to convert to a family and device
    ChannelNames = varargin{1};
    for i = 1:size(ChannelNames,1)
        Family = tango2family(ChannelNames(i,:));
        [FamilyIndex, ACCELERATOR_OBJECT] = isfamily(Family);
        DeviceList = tango2dev(ChannelNames(i,:), ACCELERATOR_OBJECT);
        if isempty(DeviceList) | isempty(DeviceList)
            error('Tango name could not be converted to a Family and DeviceList.');
        end
        [RunFlag(i,:), Delta(i,:), Tol(i,:)] = getrunflag(Family, DeviceList);
    end
    return
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parse Family, Field, DeviceList %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Family, Field, DeviceList, UnitsFlag] = inputparsingffd(varargin{:});

% Default field is Setpoint
if isempty(Field)
    Field = 'Setpoint';
end


%%%%%%%%%%%%
% Get data %
%%%%%%%%%%%%
RunFlag = [];
Delta = [];
Tol = [];

% 1. Look for a .RunFlagFcn function
RunFlagFcn = getfamilydata(Family, Field, 'RunFlagFcn');
if ~isempty(RunFlagFcn)
    [RunFlag, Delta, Tol] = feval(RunFlagFcn, Family, Field, DeviceList);
    return
end


% 2. If Field = 'Setpoint', base on SP-AM tolerance
if strcmp(Field, 'Setpoint')
    % Base runflag on abs(Setpoint-Monitor) > Tol
    Tol = family2tol(Family, Field, DeviceList, 'Hardware');
    if isempty(Tol)
        return;
    end

    % Use the "real" Setpoint value 
    SP  = getpv(Family, 'Setpoint', DeviceList, 'Hardware');
    if isempty(SP)
        return;
    end
    %SP = raw2real(Family, 'Monitor', SP, DeviceList); % Laurent

    % Use the "real" Monitor value 
    AM  = getpv(Family, 'Monitor', DeviceList, 'Hardware');
    if isempty(AM)
        return;
    end
    %AM = raw2real(Family, 'Monitor', AM, DeviceList); % Laurent
    
    RunFlag = abs(SP-AM) > Tol;
    %fprintf('SP=%f AM=%f\n', SP,AM)
    Delta = SP-AM;
end
    

