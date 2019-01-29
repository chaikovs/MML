function [Tune, tout, DataTime, ErrorFlag] = gettuneFBT(varargin)
%GETTUNE - Returns the betatron tunes
%  | Higher Fractional Tune (X) |
%  |                            | = gettune(t, FreshDataFlag, TimeOutPeriod)
%  |  Lower Fractional Tune (Y) |
%
%  INPUTS
%  1. t, FreshDataFlag, TimeOutPeriod (see help getpv for details)
%  2. 'Struct'  - Output will be a response matrix structure
%     'Numeric' - Output will be a numeric matrix {default}
%  3. Optional override of the units:
%     'Physics'  - Use physics  units
%     'Hardware' - Use hardware units
%  4. Optional override of the mode:
%     'Online'    - Get data online  
%     'Simulator' - Get data on the simulated accelerator using AT
%     'Model'     - Same as 'Simulator'
%     'Manual'    - Get data manually
%
%  OUTPUTS
%  1. Fractional tune
%  2. tout     (see help getpv for details)
%  3. DataTime (see help getpv for details)
%  4. ErrorFlag =  0   -> no errors
%                 else -> error or warning occurred
%
%  NOTES
%  1. An easy way to measure N averaged tunes is mean(gettune(1:2:N)')' (2 seconds between measurements)
%
% See also steptune, settune

%
% Written by Gregory J. Portmann
% Modified by Laurent S. Nadolski

% [Tune, tout] = gettune(varargin);
% return;

DisplayFlag = 0;
for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignore structures
    elseif iscell(varargin{i})
        % Ignore cells
    elseif strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    end
end

% TO BE REMOVED when TANGO BUG corrected on tunemeasurement device
%devProxyDataX  = 'ANS/RF/BBFDATAVIEWER.1'; 
% Modification 17 February 2010 with. Rajesh
devProxyDataX  = 'ANS/RF/BBFDATAVIEWER.3';
devProxyDataZ  = 'ANS/RF/BBFDATAVIEWER.2';

if tango_ping(devProxyDataX) == -1 || tango_ping(devProxyDataZ) == -1
    ErrorFlag = -1;
    Tune = [NaN; NaN];
    tango_print_error_stack
else
    % get betatron tunes from FBT
    [Tune, tout, DataTime] = getpv('TUNEFBT', 'Monitor', [1 1; 1 2], varargin{:});
end

%% Complete structure
if isstruct(Tune)
    TuneUnitsString = getfamilydata('TUNEFBT','Monitor','HWUnits');
    if isempty(TuneUnitsString)
        Tune.UnitsString = 'Fractional Tune';
    else
        Tune.UnitsString = TuneUnitsString;
    end
    Tune.DataDescriptor = 'TUNEFBT';
    Tune.CreatedBy = 'gettune';
end

%% Display to the screen
if DisplayFlag
   fprintf('\n  Horizontal Tune = %f\n', Tune(1));
   fprintf('    Vertical Tune = %f\n\n', Tune(2));
end

