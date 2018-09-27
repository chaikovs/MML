function [ATIndexList, ErrorFlag] = family2atindex(Family, varargin)
%FAMILY2ATINDEX - Returns the AT index for a given family
%  ATIndexList = family2atindex(Family, DeviceList)
%
%  INPUTS
%  1. Family - Family Name 
%              Accelerator Object
%              Cell Array of Accelerator Objects or Family Names
%              AT FamName (or 'All' every AT index)
%  2. DeviceList - Device list {Default: the entire family (familydev('Family',0))}
% 
%  OUTPUTS
%  1. ATIndexList - List of AT indexes referenced to THERING
%                   If the family a split magnet, then muliply columns will be output
%
%  NOTES
%  1. If Family is a cell array, then DeviceList must also be a cell array
%  2. If using AT FamName, then DeviceList is index vector, ie,
%              Length = THERING{ATIndexList}.Length(DeviceList)
%  3. Works for ATgroup
%
%  Written by Greg Portmann
%  Modified by Laurent S. Nadolski for using ATgroup. It return the index
%  of all elements within a group

ErrorFlag = 0; %#ok<NASGU>

if nargin == 0
    error('Must have at least one input (Family or Channel Name).');
end


[ATIndexList, ErrorFlag] = getfamilydata(Family, 'AT', 'ATIndex', varargin{:});

if isfield(getfamilydata(Family,'AT'),'ATParameterGroup')
    group = getfamilydata(Family,'AT','ATParameterGroup');
    len = length(group{1});
    ATIndexList = zeros(len,1);
    for ii=1:len
        ATIndexList(ii) = group{1}(ii).ElemIndex;
    end
end

if isempty(ATIndexList)
    % Try an AT family
    global THERING %#ok<*TLEV>
    
    if strcmpi(Family, 'All')
        ATIndexList = (1:length(THERING))';
    else
        ATIndexList = findcells(THERING, 'FamName', Family);
        ATIndexList = ATIndexList(:);
    end
    
    if nargin >= 2
        if ~isempty(varargin{1})
            if size(varargin{1},2) == 2
                varargin{1} = varargin{1}(:,2);
            end
        end
        ATIndexList = ATIndexList(varargin{1});
    end
end

