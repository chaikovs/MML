function [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpaththomx(varargin)
%SETPATHTHOMX - Initializes the Matlab Middle Layer (MML) for THOMX
%               Set the search path of MML 
%
%  [MachineName, SubMachineName, OnlineLinkMethod, MMLROOT] = setpaththomx(SubMachineName)
%
% INPUTS
%  varargin(1):
%       SubMachineName - 'StorageRing', 'TL','EL'
%  varagin(2):  
%       hardware control system: LAbCA, MCA, Tango, 
%       etc; the default system is Tango.
%
%  Example:
%   to use Tango in the submachine Storage ring,
%   [MachineName, SubMachineName, LinkFlag, MMLROOT]
%   =setpaththomx('StorageRing','Tango')
%
%  See Also setoperationalmode, aoinit, thomxinit,
%            setpathsoleil, soleilinit.
%
%
%  Written by Gregory J. Portmann
%  Adapted by Laurent S. Nadolski @ SOLEIL
%  Modified by Jianfeng Zhang @ LAL for ThomX, 31/05/2013

Machine = 'THOMX';

%%%%%%%%%%%%%%%%%
% Input Parsing %
%%%%%%%%%%%%%%%%%

% First strip-out the link method (although it should not be there)
%  MML -> device control system
LinkFlag = '';
for i = length(varargin):-1:1
    if ~ischar(varargin{i})
        % Ignore input
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
    LinkFlag = 'Tango';
end


% Get the submachine name
if length(varargin) >= 1
    SubMachineName = varargin{1};
else
    SubMachineName = 'StorageRing';
end

% default SubMachine list
if isempty(SubMachineName)
    SubMachineNameCell = {'TL','Storage Ring','EL','TL_SL','TL_OC','TL_SST2'};
    [i, ok] = listdlg('PromptString', 'Select an accelerator:',...
        'SelectionMode', 'Single',...
        'Name', 'THOMX', ...
        'ListString', SubMachineNameCell,'ListSize', [160 60]);
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

% % Common path at THOMX machine
%   To be turned on in the future for some useful functions
    try
        MMLROOT = getmmlroot;
%        [status servername] = system('uname -n');
%        if strcmp(servername(1:5), 'metis'),
%            addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'CommunHyperion'));
%        end
        addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'common'));
%        addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'common', 'naff', 'naffutils'));
%        addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'common', 'naff', 'naffutils', 'touscheklifetime'));
%        addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'common', 'naff', 'nafflib'));
 %         need to be customized for THOMX
addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'common', 'archiving'));
%        addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'common', 'archiving'));
%        addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'common', 'database'));
%        addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'common', 'geophone'));
%        addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'common', 'synchro'));
     %   addpath(fullfile(MMLROOT, 'mml', 'plotfamily')); % greg version
    %         need to be customized for THOMX
     %    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'common', 'plotfamily'));
 addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'common', 'configurations'));
 addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'common', 'cycling'));
%        addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'common', 'diag', 'DserverBPM'));
 %       addpath(fullfile(MMLROOT, 'applications', 'mmlviewer'));
%        ToolboxPath = fullfile(MMLROOT, 'machine', 'SOLEIL', 'common', 'toolbox');
%        % "inverse" INTERP1
%        addpath(fullfile(ToolboxPath, 'findX'))
%        % nonlinear optimization toolbox
%        addpath(fullfile(ToolboxPath, 'optimize'))
%        % FMINSEARCH, but with bound constraints by transformation
%        addpath(fullfile(ToolboxPath, 'fminsearchbnd/fminsearchbnd'))
%        % FMINSEARCHCON extension of FMINSEARCH
%        addpath(fullfile(ToolboxPath, 'FMINSEARCHCON/FMINSEARCHCON'))
%        % Integration
%        addpath(fullfile(ToolboxPath,'quadgr'))
%        addpath(fullfile(ToolboxPath,'gaussquad'))
%        % 2 fitting toolbox
%        addpath(fullfile(ToolboxPath,'ezyfit/ezyfit'))
%        % requiredsymbolic toolbox
%        addpath(fullfile(ToolboxPath,'PolyfitnTools/PolyfitnTools'))
%        addpath(fullfile(ToolboxPath,'SymbolicPolynomials/SymbolicPolynomials'))
%        % chebychev
%        addpath(fullfile(ToolboxPath,'chebfun_v2_0501'));
%        % GUILayout
%        addpath(fullfile(ToolboxPath,'GUILayout'));
%        addpath(fullfile(ToolboxPath,'GUILayout/Patch'));
%        addpath(fullfile(ToolboxPath,'GUILayout/layoutHelp'));
    catch err
        disp('Path loading failed');
    end
   
   
if strcmpi(SubMachineName,'StorageRing')
    [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathmml(Machine, 'StorageRing', 'StorageRing', LinkFlag);
% elseif strcmpi(SubMachineName,'TL')
%     [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathmml(Machine, 'TL',         'Transport',   LinkFlag);
% elseif strcmpi(SubMachineName,'TL_SL')
%     [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathmml(Machine, 'TL_SL',         'Transport',   LinkFlag);
% elseif strcmpi(SubMachineName,'EL')
%     [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathmml(Machine, 'EL',         'Transport',   LinkFlag);
% elseif strcmpi(SubMachineName,'TL_OC')
%     [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathmml(Machine, 'TL_OC', 'Transport',   LinkFlag);
% elseif strcmpi(SubMachineName,'TL_SST2')
%     [MachineName, SubMachineName, LinkFlag, MMLROOT] = setpathmml(Machine, 'TL_SST2', 'Transport',   LinkFlag);
else
    error('SubMachineName %s unknown', SubMachineName);
end

try
  %% Proprietes par defauts
    %% Impression
    set(0,'DefaultFigurePaperType','a4');
    set(0,'DefaultFigurePaperUnits','centimeters');
    % commande type pour imprimer
    % print
    % l'imprimante Color
    % print -Pcolor
    % postcript level 2 en couleur
    % print -dps2c -Pcolor

    warning off MATLAB:dispatcher:InexactMatch

    % cycling over 15 different color
    set(0,'DefaultAxesColorOrder',(colordg(1:15)));

    % Global options
    set(0,'DefaultAxesXgrid', 'On');
    set(0,'DefaultAxesYgrid', 'On')

    %format long

    % Repertoire par defaut
%     if ispc
%         cd(getenv('HOME_OPERATION'));
%     else
%         % default starting directory
%         cd(getenv('HOME'));
%     end
    disp('Ready')
catch
    disp('Error')
end
