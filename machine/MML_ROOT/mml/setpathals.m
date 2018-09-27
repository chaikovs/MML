function [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathals(varargin)
%SETPATHALS - Initializes the Matlab Middle Layer (MML) for ALS
%  [MachineName, SubMachineName, OnlineLinkMethod, MMLROOT] = setpathals(SubMachineName, OnlineLinkMethod)
%
%  INPUTS
%  1. SubMachineName - 'StorageRing', 'Booster', 'BTS', 'LTB'
%  2. OnlineLinkMethod - 'MCA', 'LabCA', 'SCA'
%
%  Written by Greg Portmann


Machine = 'ALS';


%%%%%%%%%%%%%%%%%
% Input Parsing %
%%%%%%%%%%%%%%%%%

% First strip-out the link method
LinkFlag = '';
for i = length(varargin):-1:1
    if ~ischar(varargin{i})
        % Ignor input
    elseif strcmpi(varargin{i},'LabCA')
        LinkFlag = 'LabCA';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'MCA')
        LinkFlag = 'MCA';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'SCA')
        LinkFlag = 'SCA';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'SLC')
        LinkFlag = 'SLC';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Tango')
        LinkFlag = 'Tango';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'UCODE')
        LinkFlag = 'UCODE';
        varargin(i) = [];
    end
end

if isempty(LinkFlag)
    if strncmp(computer,'PC',2)
        LinkFlag = 'MCA';
    elseif isunix
        if findstr(computer, 'GLNX')
            LinkFlag = 'LABCA';
        else
            LinkFlag = 'SCA';
            %LinkFlag = 'LABCA';
        end
    else
        LinkFlag = 'LABCA';
    end
end


% Get the submachine name
if length(varargin) >= 1
    SubMachineName = varargin{1};
else
    SubMachineName = 'StorageRing';
end

if isempty(SubMachineName)
    SubMachineNameCell = {'Storage Ring', 'Booster', 'LTB', 'BTS'};
    [i, ok] = listdlg('PromptString', 'Select an accelerator:',...
        'SelectionMode', 'Single',...
        'Name', 'ALS', ...
        'ListString', SubMachineNameCell);
    if ok
        SubMachineName = SubMachineNameCell{i};
    else
        fprintf('Initialization cancelled (no path change).\n');
        return;
    end
end

if any(strcmpi(SubMachineName, {'Storage Ring','Ring'}))
    SubMachineName = 'StorageRing';
end


if strcmpi(SubMachineName,'StorageRing')
    [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathmml(Machine, 'StorageRing', 'StorageRing', LinkFlag);
elseif strcmpi(SubMachineName,'Booster')
    [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathmml(Machine, 'Booster',     'Booster',     LinkFlag);
elseif strcmpi(SubMachineName,'LTB')
    [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathmml(Machine, 'LTB',         'Transport',   LinkFlag);
elseif strcmpi(SubMachineName,'BTS')
    [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathmml(Machine, 'BTS',         'Transport',   LinkFlag);
end

