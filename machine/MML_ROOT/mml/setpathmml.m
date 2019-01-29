function [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathmml(varargin)
%SETPATHMML -  Initialize the Matlab MiddleLayer (MML) path
%  [MachineName, SubMachineName, OnlineLinkMethod, MMLROOT]  = setpathmml(MachineName, SubMachineName, MachineType, OnlineLinkMethod, MMLROOT)
%
%  INPUTS
%  1. MachineName -
%  2. SubMachineName -
%  3. MachineType - 'StorageRing' {Default}, 'Booster', 'Linac', or 'Transport'
%  4. OnlineLinkMethod - 'MCA', 'LabCA', 'SCA', 'Tango', 'SLC', 'UCODE', ... {Default: 'LabCA' for unix, 'MCA' for PC}
%  5. MMLROOT - Directory path to the MML root directory

%
%  Written by Greg Portmann
%  Updated by Igor Pinayev


% Inputs:  MachineName, SubMachineName, MachineType, LinkFlag, MMLROOT


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
    elseif strcmpi(varargin{i},'OPC')
        LinkFlag = 'OPC';
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


% Get the machine name
if length(varargin) >= 1
    MachineName = varargin{1};
else
    MachineName = '';
end

if isempty(MachineName)
    [MachineListCell, SubMachineListCell] = getmachinelist;
    [i, iok] = listdlg('Name','SETPATHMML', 'ListString',MachineListCell, 'Name','MML Init', 'PromptString',{'Select a facility:'}, 'SelectionMode','Single');
    %[MachineNameCell, i] = editlist(MachineListCell,'',zeros(size(MachineListCell,1),1));
    if iok
        MachineName = MachineListCell{i};
    else
        fprintf('   No path change.\n');
        MachineName=''; SubMachineName=''; LinkFlag=''; MMLROOT='';
        return;
    end
else
    SubMachineListCell = {};
end


% Get the submachine name
if length(varargin) >= 2
    SubMachineName = varargin{2};
else
    SubMachineName = '';
end
if isempty(SubMachineName)
    if isempty(SubMachineListCell)
        [MachineListCell, SubMachineListCell] = getmachinelist;
    end
    i = strcmpi(MachineName, MachineListCell);
    SubMachineListCell = SubMachineListCell{i}(:);

    if length(SubMachineListCell) == 1
        SubMachineName = SubMachineListCell{1};
    else

        [i, iok] = listdlg('Name','SETPATHMML', 'ListString',SubMachineListCell, 'Name','MML Init', 'PromptString',{'Select an accelerator:'}, 'SelectionMode','Single');
        if iok
            SubMachineName = SubMachineListCell{i};
        else
            fprintf('   No path change.\n');
            MachineName=''; SubMachineName=''; LinkFlag=''; MMLROOT='';
            return;
        end
    end
end


% Find the machine type
if length(varargin) >= 3
    MachineType = varargin{3};
else
    MachineType = '';
end
if isempty(MachineType)
    switch upper(SubMachineName)
        case {'LTB', 'LB', 'BTS', 'BS', 'LT1', 'LT2'}
            MachineType = 'Transport';
        case {'BOOSTER', 'BOOSTER RING', 'BR'}
            MachineType = 'Booster';
        case {'SR', 'STORAGERING', 'STORAGE RING', 'HER', 'LER', '800MEV'}
            MachineType = 'StorageRing';
        otherwise
            MachineType = 'StorageRing';
    end
end


%if all(strcmpi(MachineType, {'StorageRing','Booster','Linac','Transport'}) == 0)
%    error('MachineType must be storagering, booster, linac, or transport.');
%end


% LinkFlag if empty
if isempty(LinkFlag)
    switch upper(MachineName)
        case 'ALS'
            if strncmp(computer,'PC',2)
                LinkFlag = 'MCA';
            elseif isunix
                if strfind(computer, 'GLNX') %#ok<*STRIFCND> % no compatible with Matlab R2009
                    LinkFlag = 'LABCA';
                    %LinkFlag = 'SCA';
                else
                    %LinkFlag = 'LABCA';
                    LinkFlag = 'SCA';
                end
            else
                LinkFlag = 'LABCA';
            end
        case {'ASP'}
            LinkFlag = 'LABCA';
        case {'NSRRC','PLS','SPEAR','SPEAR3','SSRF'}
            LinkFlag = 'MCA';
        case 'BFACTORY'
            LinkFlag = 'SLC';
        case 'LCLS'
            LinkFlag = 'LABCA';
        case {'NSRC','SPS'}
            LinkFlag = 'OPC';
        case {'VUV','XRAY'}
            LinkFlag = 'UCODE';
        case {'ALBA','SOLEIL'}
            LinkFlag = 'Tango';
        otherwise
            % Other
            if strncmp(computer,'PC',2)
                LinkFlag = 'MCA';
            elseif isunix
                LinkFlag = 'LABCA';
            else
                LinkFlag = 'MCA';
            end
    end
end


% Find the MML root directory
if length(varargin) >= 4
    MMLROOT = varargin{4};
else
    MMLROOT = '';
end
if isempty(MMLROOT)
    MMLROOT = getmmlroot;
end


% The path does not needs to be set in Standalone mode
if ~isdeployed_local

    % naff
    %addpath(fullfile(MMLROOT, 'applications', 'naff'), '-begin');

    % m2html generation program
    addpath(fullfile(MMLROOT, 'applications', 'm2html'), '-begin'); %#ok<*MCAP>

    % mysql
    addpath(fullfile(MMLROOT, 'applications', 'database', 'mym'), '-begin');

    % AT root
    if iscontrolroom
        answer = 'AT ESRF';
    else
        answer = questdlg('Select AT package', 'Choose', 'AT SOLEIL', 'AT ESRF', 'AT GIT', 'AT ESRF');
    end
    %%LSN ATESRF
    switch answer
        case 'AT SOLEIL'
            setpathat(fullfile(MMLROOT,'at'));
        case 'AT ESRF'
            switch computer
                case 'MACI64'
                    setpathatesrf('/Users/nadolski/Documents/MATLAB/atcollab2017_branch/atmat')
                    addpath('/Users/nadolski/Documents/MATLAB/atlocal') 
                case 'GLNXA64'
                    if strcmp(getenv('HOSTNAME'), 'metisnew')
                        setpathatesrf('/usr/Local/matlab/atcollab2017_branch/atmat');
                        if strcmp(version('-release'), '2009b')
                            addpath('/usr/Local/matlab/atcollab2017_branch/BackwardsCompatibility');
                        end
                    else
                        error('setpathmml: path not defined')
                    end
                case 'GLNX86'
                    setpathatesrf('/home/production/matlab/AT_ESRF/atcollab/atmat');
                otherwise
                    error('setpathmml: path not defined')
            end
        case 'AT GIT'
            switch computer
                case 'MACI64'
                    setpathatesrf('/Users/nadolski/Documents/MATLAB/at_git_master/atmat')
                    addpath('/Users/nadolski/Documents/MATLAB/atlocal') 
                case 'GLNXA64'
                    if strcmp(getenv('HOSTNAME'), 'metisnew')
                        setpathatesrf('/usr/Local/codes/at_git_master/at/atmat');
                        if strcmp(version('-release'), '2009b')
                            addpath('/usr/Local/matlab/atcollab2017_branch/BackwardsCompatibility');
                        end
                    else
                        error('setpathmml: path not defined')
                    end
                case 'GLNX86'
                    setpathatesrf('/home/production/matlab/AT_ESRF/atcollab/atmat');
                otherwise
                    error('setpathmml: path not defined')
            end
    end

    % LOCO
    addpath(fullfile(MMLROOT, 'applications', 'loco'),'-begin');
    ver = version('-release');
    switch ver
        case '2009b' % old figure handling as double and not as structure. Issue is the locogui.fig
            addpath(fullfile(MMLROOT, 'applications', 'loco','backcompatible'),'-begin');
    end

    % Link method
    switch upper(LinkFlag)
        case 'MCA'
            % R3.14.4 and Andrei's MCA
            %fprintf('   Appending MATLAB path control using MCA and EPICS R3.13.4\n');
            %addpath(fullfile(MMLROOT, 'links', 'mca', 'win32', 'R3.14.4'),'-begin');
            %addpath(fullfile(MMLROOT, 'mml', 'links', 'mca'),'-begin');

            % R3.14.4 and Australian MCA
            fprintf('   Appending MATLAB path control using MCA (Australian)\n');
            addpath(fullfile(MMLROOT, 'links', 'mca_asp'),'-begin');
            addpath(fullfile(MMLROOT, 'mml', 'links', 'mca_asp'),'-begin');

        case 'LABCA'
            fprintf('   Appending MATLAB path control using LabCA \n');
            if strncmp(computer,'PC',2)
                addpath(fullfile(MMLROOT,'links','labca', 'bin','win32-x86','labca'),'-begin');
            elseif strncmp(computer, 'SOL', 3)
                addpath(fullfile(MMLROOT,'links','labca', 'bin','solaris-sparc-gnu','labca'),'-begin');
            elseif strncmp(computer, 'GLNX', 4)
                addpath(fullfile(MMLROOT,'links','labca', 'bin','linux-x86','labca'),'-begin');
            else
                fprintf('Computer not recognized for LabCA path.\n');
            end

            addpath(fullfile(MMLROOT,'mml', 'links', 'labca'),'-begin');

        case 'SCA'
            fprintf('   Appending MATLAB path control using Simple-CA Version 3\n');
            if strncmp(computer,'PC',2)
                fprintf('\n   WARNING:  SCAIII is not working with PC''s yet\n\n');
                addpath(fullfile(MMLROOT,'links','sca', 'bin','win32-x86','sca'),'-begin');
            elseif strncmp(computer, 'SOL', 3)
                addpath(fullfile(MMLROOT,'links','sca', 'bin','solaris-sparc','sca'),'-begin');
            elseif strncmp(computer, 'GLNX', 4)
                addpath(fullfile(MMLROOT,'links','sca', 'bin','linux-x86','sca'),'-begin');
            else
                fprintf('Computer not recognized for LabCA path.\n');
            end

            addpath(fullfile(MMLROOT, 'mml', 'links', 'sca'),'-begin');
            
        case 'TANGO'
            fprintf('   Appending MATLAB path control using Tango\n');
            %addpath(fullfile(MMLROOT,'links','tango'),'-begin');
            versionName =  version('-release');
            TANGOROOT   = getenv('SOLEIL_ROOT');
            
            [~, WHO] = system('whoami');
            % system gives back an visible character: carriage return!
            % so comparison on the number of caracters
            if strncmp(WHO, 'operateur',9) % means controlroom
                try
                    switch computer
                        case 'MACI64'
                            %TODO        %
                        otherwise
                            if strcmpi(versionName,'14')
                                addpath(fullfile(TANGOROOT, 'bindings', 'matlab', 'R14', 'm-files'));
                                addpath(fullfile(TANGOROOT, 'bindings', 'matlab', 'R14', 'mex-file'));
                            else
                                %MOD BY NL-ICA TO POINT TO THE 2009b TANGO BINDING
                                addpath(fullfile(TANGOROOT, 'bindings', 'matlab', '2009b', 'm-files'));
                                addpath(fullfile(TANGOROOT, 'bindings', 'matlab', '2009b', 'mex-file'));
                            end
                    end                                        
                catch errRecord
                    fprintf('WARNING NO TANGO ACCESS!!! %s\n', errRecord.message);
                end
            end
            addpath(fullfile(MMLROOT, 'mml', 'links', 'tango'),'-begin');

        case 'UCODE'
            fprintf('   Appending MATLAB path control using UCODE \n');
            %addpath(fullfile(MMLROOT,'links','ucode'),'-begin');
            addpath(fullfile(MMLROOT,'mml','links','ucode'),'-begin');

        case 'SLC'
            fprintf('   Appending MATLAB path for SLC control \n');
            addpath(fullfile(MMLROOT,'links','slc'),'-begin');
            addpath(fullfile(MMLROOT,'mml', 'links', 'slc'),'-begin');

        case 'OPC'
            fprintf('   Appending MATLAB path for OPC control \n');
            addpath(fullfile(MMLROOT,'links','opc'),'-begin');
            addpath(fullfile(MMLROOT,'mml', 'links', 'opc'),'-begin');

        otherwise
            fprintf('   Unknown type for the Online connection method.  Only simulator mode will work.\n');
    end

    %%%%%%%%%%%%%%%
    % Middlelayer %
    %%%%%%%%%%%%%%%

    % Common files
    addpath(fullfile(MMLROOT, 'applications', 'common'),'-begin');

    % Connection MML to simulator
    addpath(fullfile(MMLROOT, 'mml', 'at'),'-begin');

    addpath(fullfile(MMLROOT, 'at' , 'simulator', 'element','user'),'-end');

    % MML path
    addpath(fullfile(MMLROOT, 'mml'),'-begin');

    % Machine directory
    if ~isempty(MachineName) && ~isempty(SubMachineName)
        % New MML path
        addpath(fullfile(MMLROOT, 'machine', MachineName, SubMachineName),'-begin');
    end
end


% Start the AD with machine and submachine
setad([]);
AD.Machine     = MachineName;
AD.SubMachine  = SubMachineName;
AD.MachineType = MachineType;
AD.OperationalMode = '';    % Gets filled in later
setad(AD);

% Initialize the AO & AD
aoinit(SubMachineName);

function RunTimeFlag = isdeployed_local
% isdeployed is not in matlab 6.5
V = version;
if str2double(V(1,1)) < 7
    RunTimeFlag = 0;
else
    RunTimeFlag = isdeployed;
end
