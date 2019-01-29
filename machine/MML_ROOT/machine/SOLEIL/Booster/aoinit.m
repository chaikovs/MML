function aoinit(SubMachineName)
%AOINIT - Initialization function for the Matlab Middle Layer (MML)
%
%
%  See Also boosterinit, setpathsoleil, setoperationalmode 

% Written by Laurent S. Nadolski

[statuss WHO] = system('whoami');
% system gives back an visible character: carriage return!
% so comparison on the number of caracters


if exist('SubMachineName', 'var') && ~strcmpi(SubMachineName, 'Booster')
    error('Wrong SubMachine %s', SubMachineName)
end

% The path should not be modified in standalone mode
if ~isdeployed_local

    MMLROOT = getmmlroot;
    MMLDATAROOT = getmmldataroot;
    
    addpath(fullfile(MMLDATAROOT, 'measdata', 'SOLEIL', 'Boosterdata'));
    addpath(fullfile(getmmlconfigroot, 'machine', 'SOLEIL', 'BoosterOpsData'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'Booster', 'applications'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'Booster',  'bpm'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'Booster', 'Lattices'));
    
    % APPLICATIONS
    addpath(fullfile(MMLROOT, 'mml', 'setorbitbumpgui'));        
    addpath(fullfile(MMLROOT, 'mml', 'setorbitgui'));        
         

    % Make sure mml is high on the path
    addpath(fullfile(MMLROOT, 'mml'),'-begin');

    if strncmp(WHO, 'operateur',9), % means controlroom
        disp(['TANGO/MATLAB binding version: ' tango_version])
    end
    disp('Startup file for Matlab Middle Layer read with success');

end

% Initialize the MML for machine

boosterinit;

function RunTimeFlag = isdeployed_local
% isdeployed is not in matlab 6.5
V = version;
if str2double(V(1,1)) < 7
    RunTimeFlag = 0;
else
    RunTimeFlag = isdeployed;
end

