function [Data, FileName] = getsigma(varargin)
%GETSIGMA - Return the standard deviation in the monitor for a family
%  [Data, FileName] = getsigma(Family, DeviceList, Navg, FileName)
%
%  INPUTS
%  1. Family - Family Name 
%              Data Structure
%              Accelerator Object
%  2. DeviceList ([Sector Device #] or [element #]) {Default: whole family}
%  3. Navg - Number of BPM averages {Default: return the sigma as in the data file}   
%  4. FileName - File of loop for data {Default: <OpsData>,<BPMSigmaFile>}
%  5. 'Physics'  - Use physics  units (optional override of units)
%     'Hardware' - Use hardware units (optional override of units)
%  6. 'Struct'  - Return a data structure
%     'Numeric' - Return numeric outputs  {Default}
%     'Object'  - Return a accelerator object (AccObj)
%
%  OUTPUTS
%  1. Offset - Offset value for the family
% 
%  NOTES
%  1. Family, DeviceList, and N can be cell arrays
%
%  Written by Greg Portmann


%%%%%%%%%%%%%%%%%
% Input Parsing %
%%%%%%%%%%%%%%%%%
UnitsFlag = {};
StructOutputFlag = 0;
ObjectOutputFlag = 0;
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
    elseif strcmpi(varargin{i},'Object')
        ObjectOutputFlag = 1;
        StructOutputFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'simulator') || strcmpi(varargin{i},'model') || strcmpi(varargin{i},'Online') || strcmpi(varargin{i},'Manual')
        % Remove and ignor
        varargin(i) = [];
    elseif strcmpi(varargin{i},'physics')
        UnitsFlag = {'Physics'};
        varargin(i) = [];
    elseif strcmpi(varargin{i},'hardware')
        UnitsFlag = {'Hardware'};
        varargin(i) = [];
    end
end

if isempty(varargin)
    error('Must have at least a family name input');
else
    Family = varargin{1};
    if length(varargin) >= 2
        DeviceList = varargin{2};
    end
    if length(varargin) >= 3
        N = varargin{3};
    end
    if length(varargin) >= 4
        FileName = varargin{4};
    end
end


%%%%%%%%%%%%%%%%%%%%%
% Cell Array Inputs %
%%%%%%%%%%%%%%%%%%%%%
if iscell(Family)
    for i = 1:length(Family)
        if length(varargin) < 2
            [Data{i}, FileName{i}] = getsigma(Family{i}, UnitsFlag{:});
        elseif length(varargin) < 3
            if iscell(DeviceList)
                [Data{i}, FileName{i}] = getsigma(Family{i}, DeviceList{i}, UnitsFlag{:});
            else
                [Data{i}, FileName{i}] = getsigma(Family{i}, DeviceList, UnitsFlag{:});
            end
        elseif length(varargin) < 4
            if iscell(DeviceList)
                if iscell(N)
                    [Data{i}, FileName{i}] = getsigma(Family{i}, DeviceList{i}, N{i}, UnitsFlag{:});
                else
                    [Data{i}, FileName{i}] = getsigma(Family{i}, DeviceList{i}, N, UnitsFlag{:});
                end
            else
                if iscell(N)
                    [Data{i}, FileName{i}] = getsigma(Family{i}, DeviceList, N{i}, UnitsFlag{:});
                else
                    [Data{i}, FileName{i}] = getsigma(Family{i}, DeviceList, N, UnitsFlag{:});
                end
            end
        else
            if iscell(DeviceList)
                if iscell(N)
                    [Data{i}, FileName{i}] = getsigma(Family{i}, DeviceList{i}, N{i}, FileName, UnitsFlag{:});
                else
                    [Data{i}, FileName{i}] = getsigma(Family{i}, DeviceList{i}, N, FileName, UnitsFlag{:});
                end
            else
                if iscell(N)
                    [Data{i}, FileName{i}] = getsigma(Family{i}, DeviceList, N{i}, FileName, UnitsFlag{:});
                else
                    [Data{i}, FileName{i}] = getsigma(Family{i}, DeviceList, N, FileName, UnitsFlag{:});
                end
            end
        end
    end
    return
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Family or data structure inputs beyond this point %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isstruct(Family)
    % Data structure inputs
    if length(varargin) < 2
        if isfield(Family,'DeviceList')
            DeviceList = Family.DeviceList;
        else
            DeviceList = [];
        end
    end
    if isempty(UnitsFlag)
        if isfield(Family,'Units')
            UnitsFlag{1} = Family.Units; 
        end
    end
    if isfield(Family,'FamilyName')
        Family = Family.FamilyName;
    else
        error('For data structure inputs FamilyName field must exist')
    end
else
    % Family string input
    if length(varargin) < 2
        DeviceList = [];
    end
end
if isempty(DeviceList)
    DeviceList = family2dev(Family);
end
if (size(DeviceList,2) == 1) 
    DeviceList = elem2dev(Family, DeviceList);
end

if length(varargin) < 3
    N = [];
end
if length(varargin) < 4
    FileName = getfamilydata('OpsData','BPMSigmaFile');
    DirectoryName = getfamilydata('Directory', 'OpsData'); 
    FileName = [DirectoryName FileName];
end

if isempty(UnitsFlag)
    UnitsFlag = '';
else
    UnitsFlag = UnitsFlag{1};    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Look in the BPMsigma file %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
    [Data, FileName] = getdata(Family, DeviceList, FileName, 'Struct');
catch
    Data = family2datastruct(Family, 'Monitor', DeviceList);
    [Units, UnitsString] = getunits(Family);
    
    if any(strcmpi(UnitsString, {'um', 'umeter', 'micron', 'micrometer', 'micro-meter'}))
        fprintf('   Could not find a BPM sigma file, so using .1 %s (%s).\n', UnitsString, Family);
        Data.Data = .1 * ones(size(DeviceList,1),1);
    else
        fprintf('   Could not find a BPM sigma file, so using .0001 %s (%s).\n', UnitsString, Family);
        Data.Data = .0001 * ones(size(DeviceList,1),1);
    end

    Data.CreatedBy = 'getsigma';
    FileName = '';
    Data.NumberOfAverages = N;
end

if strcmpi(Data.CreatedBy, 'monbpm') 
    Data.Data = Data.Sigma;
    Ndata = size(Data.Data,2);
elseif strcmpi(Data.CreatedBy, 'measbpmsigma')
    Ndata = size(Data.RawData,2);
elseif strcmpi(Data.CreatedBy, 'getsigma')
else
    error(sprintf('BPM sigma file was created by function %s.  Not good!', Data.CreatedBy));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sigma is scaled by the orbit reads %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(N)
    if isfield(Data, 'NumberOfAverages') 
        NumberOfAverages = Data.NumberOfAverages;
    else
        error('NumberOfAverages field must exist in the BPM monitor data');
    end
    Data.Data = (Data.Data .* sqrt(NumberOfAverages)) ./ sqrt(N);
end


if isstruct(Data)
    Data = Data.Data;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Change to physics units if requested %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmpi(UnitsFlag, 'Physics')
    Data = hw2physics(Family, Field, Data, DeviceList);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Return a data structure if requested %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if StructOutputFlag
    DataNumeric = Data;
    Data = family2datastruct(Family, DeviceList, UnitsFlag);
    %Data = family2datastruct(Family, Field, DeviceList, UnitsFlag);
    Data.Data = DataNumeric;
    Data.DataDescriptor = sprintf('%s Sigma', Family);
    Data.CreatedBy = 'getsigma';
    
    % Make the output an AccObj object
    if ObjectOutputFlag
        Data = AccObj(Data);
    end
end