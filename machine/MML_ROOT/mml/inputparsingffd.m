function [Family, Field, DeviceList, UnitsFlag, ModelFlag] = inputparsingffd(varargin)
%INPUTPARSINGFFD - Parses the typical input line of Family, Field, DeviceList
%  [Family, Field, DeviceList, UnitsFlag, ModeFlag] = inputparsingffd(varargin);
%
%  OUTPUTS
%  1. Family
%  2. Field
%  3. DeviceList {Default: Entire family}
%                If DeviceList is a string, then a common name conversion is tried.
%  4. UnitsFlag - Units if the input was a data structure
%  5. ModeFlag - Mode if the input was a data structure
%
%  Written by Greg Portmann


UnitsFlag = '';
ModelFlag = '';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Family, Data Structure, or AO Structure %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isstruct(varargin{1})
    if isfield(varargin{1},'FamilyName') && isfield(varargin{1},'Field')
        % Data structure inputs
        Family = varargin{1}.FamilyName;

        Field = varargin{1}.Field;
        if length(varargin) >= 2
            if ischar(varargin{2})
                Field = varargin{2};
                varargin(2) = [];
            end
        end
        if length(varargin) >= 2
            DeviceList = varargin{2};
        else
            DeviceList = varargin{1}.DeviceList;
        end

        if isfield(varargin{1},'Units')
            UnitsFlag = varargin{1}.Units;
        end
        if isfield(varargin{1},'Mode')
            ModeFlag = varargin{1}.Mode;
        end

    else

        % AO Input
        Family = varargin{1}.FamilyName;

        Field = '';
        if length(varargin) >= 2
            if ischar(varargin{2})
                Field = varargin{2};
                varargin(2) = [];
            end
        end
        if length(varargin) >= 2
            DeviceList = varargin{2};
        else
            DeviceList = varargin{1}.DeviceList;
        end
        if isempty(DeviceList)
            DeviceList = varargin{1}.DeviceList;
        end
    end

else

    % Family input
    Family = varargin{1};

    Field = '';
    if length(varargin) >= 2
        if ischar(varargin{2})
            Field = varargin{2};
            varargin(2) = [];
        end
    end
    if length(varargin) >= 2
        DeviceList = varargin{2};
    else
        DeviceList = [];
    end

end


% Default field
% if isempty(Field)
%     Field = 'Monitor';
% end


% Default device list
if isempty(DeviceList)
    try
        DeviceList = family2dev(Family);
    catch
    end
end

% Convert element list to a device list
if (size(DeviceList,2) == 1)
    DeviceList = elem2dev(Family, DeviceList);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CommonName Input:  Convert common names to a varargin{3} %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check if the device list is a common name list
if ischar(DeviceList)
    DeviceList = common2dev(DeviceList, Family);
    if isempty(DeviceList)
        error('DeviceList was a string but common names could not be found.');
    end
end


% Check if the family is a common name list
% Just check the first name so it's a faster test, then convert them all if it passes
[DeviceListTest, FamilyTest] = common2dev(Family(1,:));
if ~isempty(FamilyTest)
    % Common names where the family was the common name
    [DeviceList, Family, ErrorFlag] = common2dev(Family(1,:));
end

