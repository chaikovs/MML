function Output = elem2dev(Family, ElementList, StatusFlag)
%ELEM2DEV - Converts a device list to an element list
%  [Sector Device#] = elem2dev(Family, Element#)
%
%  This function converts between the two methods of representing
%  the same device in the ring.  The "Device" method is a two column
%  matrix with the first being sector number and the seconds being
%  the device number in the sector.  The "Element" method is a one column
%  matrix with each entry being the element number starting at sector 1.
%
%  The following are equivalent devices for VCMs at the ALS:
%                     | 1  2 |                    |  2 |
%                     | 1  3 |                    |  3 |
%  [Sector Device#] = | 2  1 |    [ElementList] = |  9 |
%                     | 2  2 |                    | 10 |
%                     | 3  4 |                    | 20 |
%
%  NOTES
%  1. If ElementList is empty, the entire family list will be returned.
%  2. If the device is not found, then an error will occur.
%  3. If the Family is not found, then empty, [], is returned.

%
%  Written by Greg Portmann
%  Add a status flag to sort with status 1 devices

if nargin == 0
    error('One input required.');
end
if nargin == 1
    Output = getlist(Family);
    return
end

if nargin < 3
    StatusFlag = 0; % value per default in MML Do not modify this line (LSN)
end

if isempty(ElementList)
    Output = getlist(Family);
    return
end

if size(ElementList,2) == 2
    % Assume that the input was already a device list
    Output = ElementList;
    return
end

%Output = getfamilydata(Family, 'DeviceList', DevList);

[FamilyIndex, ACCELERATOR_OBJECT] = isfamily(Family);
if FamilyIndex    
    DeviceListTotal  = ACCELERATOR_OBJECT.DeviceList;
    if StatusFlag
        DeviceListTotal = ACCELERATOR_OBJECT.DeviceList(find(ACCELERATOR_OBJECT.Status),:);
    end
    ElementListTotal = ACCELERATOR_OBJECT.ElementList;
    Err = 0;
    
    % Intersect removes duplicate devices so first store index of how to unsort in j_unique 
    ElementListOld = ElementList;
    [ElementList, i_unique, j_unique] = unique(ElementList);        
    
    % Find the indexes in the full device list (reorder and remove duplicates)
    [ElementList, ii, DeviceIndex] = intersect(ElementList, ElementListTotal);
    if size(ElementList,1) ~= size(ElementListOld,1)
        % All devices must exist (duplicate devices ok)
        [ElementListNotFound, iNotFound] = setdiff(ElementListOld, ElementListTotal);
        if ~isempty(iNotFound)
            % Device not found
            for i = 1:length(iNotFound)
                fprintf('   No devices to get for Family %s(%d)\n', ACCELERATOR_OBJECT.FamilyName, ElementListNotFound(i));
            end
            error('%d Devices not found', length(iNotFound));
        end
    end
    Output = DeviceListTotal(DeviceIndex,:);   % Only data referenced to DeviceList
    Output = Output(j_unique,:);               % Reorder and add multiple elements back
else
    error('%s family not found', Family);
end

