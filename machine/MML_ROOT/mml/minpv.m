function [Data, ErrorFlag] = minpv(varargin)
%MinPV - Maximum value of a process variable
%  [MinPV, ErrorFlag] = minpv(Family, Field, DeviceList)
%  [MinPV, ErrorFlag] = minpv(Family, DeviceList)      (Field will default to 'Setpoint')
%
%  INPUTS
%  1. Family - Family Name 
%              Data Structure
%              Accelerator Object
%  2. Field - Accelerator Object field name ('Monitor', 'Setpoint', etc) {'Monitor'}
%  3. DeviceList ([Sector Device #] or [element #]) {Default: whole family}
%  4. 'Physics'  - Use physics  units (optional override of units)
%     'Hardware' - Use hardware units (optional override of units)
%  5. 'Numeric' - Numeric output {Default}
%     'Struct'  - Data structure output
%
%  OUTPUTS
%  1. MinPV = Minimum value corresponding to the Family, Field, and DeviceList
% 
%  NOTES
%  1. If Family is a cell array, then DeviceList and Field can also be a cell arrays
%
%  Also see maxpv, getfamilydata(Family, Field, 'Range')
%
%  Written by Greg Portmann


% Input parsing
UnitsFlagCell = {};
StructOutputFlag = 0;
for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignor structures
    elseif iscell(varargin{i})
        % Ignor cells
    elseif strcmpi(varargin{i},'struct')
        StructOutputFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'numeric')
        StructOutputFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'simulator') || strcmpi(varargin{i},'model') || strcmpi(varargin{i},'Online') || strcmpi(varargin{i},'Manual')
        % Remove and ignor
        varargin(i) = [];
    elseif strcmpi(varargin{i},'physics')
        UnitsFlagCell = {'Physics'};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'hardware')
        UnitsFlagCell = {'Hardware'};
        varargin(i) = [];
    end
end

if isempty(varargin)
    error('Must have at least a family name input');
end


%%%%%%%%%%%%%%%%%%%%%
% Cell Array Inputs %
%%%%%%%%%%%%%%%%%%%%%
if iscell(varargin{1})
    for i = 1:length(varargin{1})
        if length(varargin) < 2
            [Data{i}, ErrorFlag{i}] = minpv(varargin{1}{i}, UnitsFlagCell{:});
        elseif length(varargin) < 3
            if iscell(varargin{2})
                [Data{i}, ErrorFlag{i}] = minpv(varargin{1}{i}, varargin{2}{i}, UnitsFlagCell{:});
            else
                [Data{i}, ErrorFlag{i}] = minpv(varargin{1}{i}, varargin{2}, UnitsFlagCell{:});
            end
        else
            if iscell(varargin{3})
                [Data{i}, ErrorFlag{i}] = minpv(varargin{1}{i}, varargin{2}{i}, varargin{3}{i}, UnitsFlagCell{:});
            else
                [Data{i}, ErrorFlag{i}] = minpv(varargin{1}{i}, varargin{2}{i}, varargin{3}, UnitsFlagCell{:});
            end
        end
    end
    return
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parse Family, Field, DeviceList %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Family, Field, DeviceList, UnitsFlag] = inputparsingffd(varargin{:});


% Units flag
if isempty(UnitsFlagCell)
    % For structure inputs, use the units in the structure (from inputparsingffd)
    % Else, get the default family value
    if isempty(UnitsFlag)
        UnitsFlag = getunits(Family);
    end
else
    % Input override has priority
    UnitsFlag = UnitsFlagCell{1};
end


% Default field is Setpoint
if isempty(Field)
    Field = 'Setpoint';
end


%%%%%%%%%%%%
% Get data %
%%%%%%%%%%%%
[Data, ErrorFlag] = getfamilydata(Family, Field, 'Range', DeviceList);
if isempty(Data)
    % Try the .Setpoint range (this maynot be such a good ideal)
    [Data, ErrorFlag] = getfamilydata(Family, 'Setpoint', 'Range', DeviceList);
    if isempty(Data)
        % Could check LOPR here if using EPICs
        error(sprintf('%s.%s minimum setpoint limit not known, .Range field missing.', Family, Field));
    end
end
Data = Data(:,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Change to physics units if requested %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmpi(UnitsFlag,'Physics')
    Data = hw2physics(Family, Field, Data, DeviceList);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Return a data structure if requested %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if StructOutputFlag
    DataNumeric = Data;
    Data = family2datastruct(Family, Field, DeviceList, UnitsFlag);
    Data.Data = DataNumeric;
    Data.DataDescriptor = sprintf('%s.%s Minimum', Family, Field);
    Data.CreatedBy = 'minpv';
end