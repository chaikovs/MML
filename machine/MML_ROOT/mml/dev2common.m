function [Output, Err] = dev2common(Family, DeviceList)
%DEV2COMMON - Converts Device lists to common names
% [ElementList, Error] = dev2common('Family', [Sector Device#]);
%
%  This function converts DeviceList to CommonNames
%  The "Device" method is a two column
%  matrix with the first being sector number and the seconds being
%  the device number in the sector.  The "Element" method is a one column
%  matrix with each entry being the element number starting at sector 1.
%
%  NOTES
%  1. If Element list is empty, the entire family list will be returned.
%  2. If the device is not found it will be removed from the list.
%
% See Also common2dev

%
% Written by J. Corbett/adapted from Gregory J. Portmann

Err = 0;
Output = [];

if nargin == 0
	error('Dev2Common:  one input required.');
end



if nargin == 1
	[DeviceList, Err] = getlist(Family);
	if Err
		return
	end
end  %end nargin==1

if nargin == 2
if (size(DeviceList,2) == 1) 
    DeviceList = elem2dev(Family, DeviceList);
end

DeviceListTotal = getlist(Family);
[iDevice, iNotFound] = findrowindex(DeviceList, DeviceListTotal);
if ~isempty(iNotFound)
    ErrorFlag = 1;
    for i = 1:length(iNotFound)
        warning(sprintf('Device [%d,%d] not found in Family %s',DeviceList(iNotFound(i),1),DeviceList(iNotFound(i),2),Family));
    end
end
if isempty(iDevice)
    ErrorFlag = 1;
    warning(sprintf('No devices to get for Family %s', Family));
    return;
end
end  %end nargin==2


Err = 0;
Output = [];
Output=getfamilydata(Family, 'CommonNames', DeviceList);
