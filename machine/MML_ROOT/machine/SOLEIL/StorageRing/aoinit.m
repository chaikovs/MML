function aoinit(SubMachineName)
%AOINIT - Initialization function for the Matlab Middle Layer (MML)
%
%  See Also soleilinit, setpathsoleil, updateatindex, setoperationalmode

% Written by Laurent S. Nadolski

if exist('SubMachineName', 'var') && ~strcmpi(SubMachineName, 'StorageRing')
    error('Wrong SubMachine %s', SubMachineName)
end

[~, WHO] = system('whoami');
% system gives back an visible character: carriage return!
% so comparison on the number of caracters

% The path should not be modified in standalone mode
if ~isdeployed_local

    MMLROOT = getmmlroot;
    %MMLDATAROOT = getmmldataroot;
    
    % Make sure mml is high on the path
    % why is it important?
    % August Test at this place in order not to shadow new BBA
    addpath(fullfile(MMLROOT, 'mml'),'-begin');

    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'bpm'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'quad'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'tune'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'feedforward'));
    
    if strncmp(WHO, 'operateur',9) % means controlroom
        addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'fonction_test'));
        addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'fonction_test','couplage'));
        addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'fonction_test','photon'));
    end
    
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'insertions'));
    %addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'insertions','proc_emphu'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'loco'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'FOFB'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'KEM'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'Kicker_bump_rapide'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'orbit'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'PSB'));
    addpath(fullfile(getmmlconfigroot, 'machine', 'SOLEIL', 'StorageRingOpsData'));
    
    % APPLICATIONS
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'Lattices'));
    % A. Madur BBA Applicaiton
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing','BBA'));
    % MML tune BBA application
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing','bba_mml'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing','steerette'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing','energytunette'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing','RFPostmortem'));
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing','diagnostics'));
    addpath(fullfile(MMLROOT, 'mml', 'setorbitbumpgui'));        
    addpath(fullfile(MMLROOT, 'mml', 'setorbitgui'));        
    addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'couplage')); % coupling related functions

    %addpath(fullfile(MMLROOT, 'applications', 'orbit')); % Greg appli
    %addpath(fullfile(MMLROOT, 'applications', 'orbit', 'lib')); % Greg appli
    
   
    if strncmp(WHO, 'operateur',9) % means controlroom    
        %addpath(fullfile('/home/operateur/GrpDiagnostics/matlab/FOFB', 'GUI'));
        %addpath(fullfile('/home/operateur/GrpPhysiqueMachine/Laurent/matlab', 'FOFB'));
        disp(['TANGO/MATLAB binding version: ' tango_version])
    else
       % Dedicated directory for development (not operation) modes on Hyperion 
       if exist(fullfile(getdvptdirectory, 'StorageRingDvptData'),'dir')
           addpath(fullfile(getdvptdirectory, 'StorageRingDvptData'));
       end
       addpath(fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'RadiaMapGui'));
    end
    
    disp('Startup file for Matlab Middle Layer read with success');

end

% Initialize the MML for machine

soleilinit;

function RunTimeFlag = isdeployed_local
% isdeployed is not in matlab 6.5
V = version;
if str2double(V(1,1)) < 7
    RunTimeFlag = 0;
else
    RunTimeFlag = isdeployed;
end

