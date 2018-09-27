function [CommonNames, ErrorFlag] = family2common(Family, DeviceList, varargin)
%FAMILY2COMMON - Convert a family name, device list to a common name list
%  [CommonNames, ErrorFlag] = family2common(Family, DeviceList)
%
%  INPUTS
%  1. Family - Family Name 
%              Data Structure
%              Accelerator Object
%              or Cell Array of Families
%  2. DeviceList ([Sector Device #] or [element #]) {Default: whole family}
%  3. StatusFlag - 0 return all devices
%                  1 return only devices with good status {Default}
%
%  OUTPUTS
%  1. CommonNames - Common name corresponding to the Family and DeviceList
%
% See Also common2family

%
% Written by Gregory J. Portmann

StatusFlag = 1;

if nargin == 0
    error('Must have at least one input.');
end

% StatusFlag
if length(varargin) >= 1
    StatusFlag = varargin{1};
else
    % This choice changes the default behavior for the entire middle layer !!!!
    StatusFlag = 1;  % Only return good status devices
end

if iscell(Family)
    for i = 1:length(Family)
        if nargin == 1
            [CommonNames{i}, ErrorFlag{i}] = family2common(Family{i});
        else
            if iscell(DeviceList)
                [CommonNames{i}, ErrorFlag{i}] = family2common(Family{i}, DeviceList{i});
            else
                [CommonNames{i}, ErrorFlag{i}] = family2common(Family{i}, DeviceList);
            end
        end
    end
    return
end


if nargin < 2
    DeviceList = family2dev(Family,StatusFlag);
end


[CommonNames, ErrorFlag] = getfamilydata(Family, 'CommonNames', DeviceList);


% For machines that don't have common names, replace them with Family(Sector, Dev)
if isempty(CommonNames)
    if nargin == 1
        DeviceList = family2dev(Family, StatusFlag);
    end
    for i = 1:size(DeviceList,1)
        CommonNames = strvcat(CommonNames,sprintf('%s(%d,%d)', Family, DeviceList(i,1), DeviceList(i,2)));
    end
end

