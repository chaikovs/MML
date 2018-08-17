function aoinit(SubMachineName)
%AOINIT - Initialization function for the Matlab Middle Layer (MML)
%         Set the MML path for the specific machine: THOMX storage ring.
%
%
%  See Also soleilinit, setpathsoleil, updateatindex, setoperationalmode


if exist('SubMachineName', 'var') && ~strcmpi(SubMachineName, 'StorageRing')
    error('Wrong SubMachine %s', SubMachineName)
end

[statuss WHO] = system('whoami');
% system gives back an visible character: carriage return!
% so comparison on the number of caracters

% The path should not be modified in standalone mode
if ~isdeployed_local

    MMLROOT = getmmlroot;
    %MMLDATAROOT = getmmldataroot;
    
    % Make sure mml is high on the path
    addpath(fullfile(MMLROOT, 'mml'),'-begin');

    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'StorageRing'));
    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'StorageRing', 'bpm'));
    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'StorageRing', 'quad'));
    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'StorageRing', 'tune'));
    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'StorageRing', 'loco'));
    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'StorageRing', 'orbit'));
    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'StorageRingOpsData'));
    
    
    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'StorageRing', 'Lattices'));

    addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'StorageRing','BBA'));
addpath(fullfile(MMLROOT, 'machine', 'THOMX', 'common'), '-begin');

    %addpath(fullfile(MMLROOT, 'mml', 'setorbitbumpgui'));        
    %addpath(fullfile(MMLROOT, 'mml', 'setorbitgui'));        
   
    
    disp('Startup file for Matlab Middle Layer read with success');

end

% Initialize the MML for machine

thomxinit;

function RunTimeFlag = isdeployed_local
% isdeployed is not in matlab 6.5
V = version;
if str2double(V(1,1)) < 7
    RunTimeFlag = 0;
else
    RunTimeFlag = isdeployed;
end

