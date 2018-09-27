function S = getspos(Family, DeviceList)
%GETSPOS - Returns the longitudinal position in meters
%
%  If using family name, device list method,
%  S = getspos(Family, DeviceList)
%
%  If using AT family name
%  S = getspos(FamName, IndexVector)
%
%  If using tango name method,
%  S = getspos(TangoNames)
%
%  If using common name method,
%  S = getspos(Family, CommonName)
%
%  INPUTS
%  1. Family = MiddleLayer or AT Family Name
%             Accelerator Object
%             Cell Array of Accelerator Objects or Family Names
%             For CommonNames, Family=[] searches all families
%     TangoName = Tango access Tango name
%                Matrix of tango names
%                Cell array of tango names
%     CommonName = Common name
%                 Matrix of common names
%                 Cell array of common names
%     DeviceList = [Sector Device #] or [element #] list {default or empty list: whole family}
%                 Cell Array of DeviceList
%
%  OUTPUTS
%  1. S = the position of the device along the ring (S) [meters]
%        Empty if Family or CommonName is found not found
%
%  See also getphysdata

%
%  Written by Gregory J. Portmann
%  Modified by Laurent S. Nadolski

if nargin == 0
    error('At least one input required');
end


%%%%%%%%%%%%%%%%%%%%%
% Cell Array Inputs %
%%%%%%%%%%%%%%%%%%%%%
if iscell(Family)
    for i = 1:length(Family)
        if nargin < 2
            S{i} = getspos(Family{i});
        else
            if iscell(DeviceList)
                S{i} = getspos(Family{i}, DeviceList{i});
            else
                S{i} = getspos(Family{i}, DeviceList);
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
    if nargin < 2
        if isfield(Family,'DeviceList')
            DeviceList = Family.DeviceList;
        else
            DeviceList = [];
        end
    end
    if isfield(Family,'FamilyName')
        Family = Family.FamilyName;
    else
        error('For data structure inputs FamilyName field must exist')
    end
else
    % Family string input
    if nargin < 2
        DeviceList = [];
    end
end


if isfamily(Family(1,:))
    %%%%%%%%%%%%%%%%%%%%%%
    % Family name method %
    %%%%%%%%%%%%%%%%%%%%%%

    if isempty(DeviceList)
        DeviceList = family2dev(Family);
    end
    % if (size(DeviceList,2) == 1)
    %     DeviceList = elem2dev(Family, DeviceList);
    % end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % CommonName Input:  Convert common names to a DeviceList %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if isstr(DeviceList)
        DeviceList = common2dev(DeviceList, Family);
        if isempty(DeviceList)
            error('DeviceList was a string but common names could not be found.');
        end
    end

    % Get data
    S = getfamilydata(Family, 'Position', DeviceList);

else

    %%%%%%%%%%%%%%%%%%%%%%%
    % Tango name method %
    %%%%%%%%%%%%%%%%%%%%%%%
    ATIndex = family2atindex(Family(1,:), DeviceList);

    global THERING
    if ~isempty(ATIndex)
        S = findspos(THERING, ATIndex);
        S = S(:);

    else

        %%%%%%%%%%%%%%%%%%%%%%%
        % Tango name method   %
        %%%%%%%%%%%%%%%%%%%%%%%
        % Try to convert to a family and device

        TangoNames = Family;
        for i = 1:size(TangoNames,1)
            Family = tango2family(TangoNames(i,:));
            if isempty(Family)
                error('Tango name could not be converted to a Family.');
            end
            [FamilyIndex, ACCELERATOR_OBJECT] = isfamily(Family);
            DeviceList = tango2dev(TangoNames(i,:), ACCELERATOR_OBJECT);
            if isempty(DeviceList) | isempty(DeviceList)
                error('Tango name could not be converted to a Family and DeviceList.');
            end
            S(i,:) = getspos(Family, DeviceList);
        end
    end
end

