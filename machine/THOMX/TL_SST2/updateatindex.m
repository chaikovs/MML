function updateatindex
%UPDATEATINDEX - Updates the AT indices in the MiddleLayer with the present AT lattice (THERING)

%
% Adapted by Laurent S. Nadolski


global THERING

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Append Accelerator Toolbox information %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Since changes in the AT model could change the AT indexes, etc,
% It's best to regenerate all the model indices whenever a model is loaded

% Sort by family first (findcells is linear and slow)
Indices = atindex(THERING);

AO = getao;

% BPMS
try
    ifam = 'BPMx';
    AO.(ifam).AT.ATType = 'X';
    AO.(ifam).AT.ATIndex = Indices.BPMx(:); % findcells(THERING,'FamName','BPM')';
    AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex)';

    ifam = 'BPMz';
    AO.(ifam).AT.ATType = 'Z';
    AO.(ifam).AT.ATIndex = Indices.BPMz(:); % findcells(THERING,'FamName','BPM')';
    AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex)';
catch err
    warning('BPM family not found in the model.');
end

% CORRECTORS
try
    %% HORIZONTAL CORRECTORS
    ifam = ('HCOR');
    AO.(ifam).AT.ATType  = ifam;
    AO.(ifam).AT.ATIndex = Indices.(ifam)(:);
    AO.(ifam).AT.ATIndex = AO.(ifam).AT.ATIndex(AO.(ifam).ElementList);   %not all correctors used
    AO.(ifam).Position   = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';

    %% VERTICAL CORRECTORS
    ifam = ('VCOR');
    AO.(ifam).AT.ATType  = ifam;
    AO.(ifam).AT.ATIndex = Indices.(ifam)(:);
    AO.(ifam).AT.ATIndex = AO.(ifam).AT.ATIndex(AO.(ifam).ElementList);   %not all correctors used
    AO.(ifam).Position   = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
catch
    warning('Corrector family not found in the model.');
end


% QUADRUPOLES
try

for k = 1:7,
        ifam = ['QP' num2str(k) 'L'];
        AO.(ifam).AT.ATType = 'QUAD';
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.(ifam));
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
end

catch err
     warning('%s family not found in the model.', ifam);
end




% BEND

try
    
    for k = 1:1,
        ifam = ['BEND' num2str(k)];
        AO.(ifam).AT.ATType = 'BEND';
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.(ifam));
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    end

catch err
    warning('BEND family not found in the model.');
end

setao(AO);

% Set TwissData at the start of TL
try
    % BTS twiss parameters at the input; need to modify in the
    % future for the new version of transfer line lattice. By
    % Jianfeng Zhang @ 09/2013
    TwissData.alpha = [-4.24,-4.34]';
    TwissData.beta  = [34.46,33.94]';
    TwissData.mu    = [0 0]';
    TwissData.ClosedOrbit = [0 0 0 0]'; %initial 4-D COD
    TwissData.dP = 0;             %initial dP
    TwissData.dL = 0;             % initial dL
    TwissData.Dispersion  = [0 0 0 0]';

    setpvmodel('TwissData', '', TwissData);  % Same as, THERING{1}.TwissData = TwissData;

catch
    warning('Setting the twiss data parameters in the MML failed.');
end
