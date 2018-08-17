function updateatindex
%UPDATEATINDEX - Updates the AT indices in the MiddleLayer with the
%present AT lattice (THERING), depends on the Lattice 
% element types which are defined in thomxinit.m
%
%
%  Modified for ThomX machine by Jianfeng Zhang @ LAL, 21/06/2013
%
%
% Adapted by Laurent S. Nadolski
% Modified 21 November Nanoscopium S11/S12 missing Atgroupparameter
%
%
%
% Needs to be modified when the ThomX machine & Tango is ready...
% Needs to be carefully tested...by Zhang @ LAL, 02/2014.
%
%
%
%24/02/2014 by Jianfeng Zhang @ LAL
%   Fix the bug to set/get value of the individual sextupole family member.
%

global THERING

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Append Accelerator Toolbox information %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Since changes in the AT model could change the AT indexes, etc,
% It's best to regenerate all the model indices whenever a model is loaded

% Sort by family first (findcells is linear and slow)
Indices = atindex(THERING);

AO = getao;

%% BPMS
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
    warning('MML:wrongfamily', '%s family not found in the model.', ifam);
    fprintf('Message: %s\n', err.message);
end


%% CORRECTORS
try
    ifam = 'HCOR';
    %% Horizontal correctors are at every AT corrector
    AO.(ifam).AT.ATType = ifam;
    AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.HCOR);
    AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    
    %% Vertical correctors are at every AT corrector
    ifam = 'VCOR';
    AO.(ifam).AT.ATType = ifam;
    AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.VCOR);
    AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    
    
    %% Horizontal correctors are at every AT corrector
    if isfield(AO,'HCORT')
        ifam = 'HCORT';
        AO.(ifam).AT.ATType = ifam;
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.HCORT);
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    end
    %% Vertical correctors are at every AT corrector
    if isfield(AO,'VCORT')
        ifam = 'VCORT';
        AO.(ifam).AT.ATType = ifam;
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.VCORT);
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    end
   
catch err
    warning('MML:wrongfamily', 'Corrector family %s not found in the model.',ifam);
    fprintf('Message: %s\n', err.message);
end


%% QUADRUPOLES
try
    for k = 1:6,
        ifam = ['QP' num2str(k)];
        if(k==5), ifam = 'QP31'; end;
        if(k==6), ifam = 'QP41'; end;
        AO.(ifam).AT.ATType = 'QUAD';
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.(ifam));
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    end
    ifam = 'Qall';
    AO.(ifam).AT.ATType = 'QUAD';
    AO.(ifam).AT.ATIndex = [AO.QP1.AT.ATIndex; AO.QP2.AT.ATIndex; AO.QP3.AT.ATIndex; AO.QP31.AT.ATIndex; AO.QP41.AT.ATIndex;AO.QP4.AT.ATIndex];
    AO.(ifam).Position = [AO.QP1.Position; AO.QP2.Position; AO.QP3.Position; AO.QP31.Position; AO.QP41.Position;AO.QP4.Position];
    
    ifam = 'Qall';
    %sort all s-position, mandatory for plotfamily
    [t idx] = sort(AO.(ifam).Position);
    AO.(ifam).Position = AO.(ifam).Position(idx);
    AO.(ifam).Setpoint.TangoNames = AO.(ifam).Setpoint.TangoNames(idx);
    AO.(ifam).Monitor.TangoNames = AO.(ifam).Monitor.TangoNames(idx);
    AO.(ifam).DeviceName = AO.(ifam).DeviceName(idx);
    AO.(ifam).Status = AO.(ifam).Status(idx);
catch err
    warning('MML:wrongfamily', '%s family not found in the model.',ifam);
    fprintf('Message: %s\n', err.message);
end

%% SKEW QUADS
if isfield(AO,'QT')
    ifam = 'QT';
    AO.(ifam).AT.ATType  = 'SkewQuad';
    AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.SkewQuad);
    %AO.(ifam).AT.ATIndex = ATindx.SkewQuad(:);
    %AO.(ifam).AT.ATIndex = AO.(ifam).AT.ATIndex(AO.(ifam).ElementList);   %not all correctors used
    AO.(ifam).Position   = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
end
%% SEXTUPOLES
try
    for k = 1:3,
        ifam = ['SX' num2str(k)];
        AO.(ifam).AT.ATType = 'SEXT';
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.(ifam));
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    %    AO.(ifam).AT.ATParameterGroup{1} = mkparamgroup(THERING,AO.(ifam).AT.ATIndex,'K2');
    end
    ifam = 'Sall'; % take first element
    AO.(ifam).Position = [AO.SX1.Position(1); AO.SX2.Position(1); ...
        AO.SX3.Position(1)];
    
%     ifam = 'Sall';
    %sort all s-position, mandatory for plotfamily
    % Does not work for indivual sextupoles
%     [t idx] = sort(AO.(ifam).Position);
%     AO.(ifam).Position = AO.(ifam).Position(idx);
%     AO.(ifam).Setpoint.TangoNames = AO.(ifam).Setpoint.TangoNames(idx);
%     AO.(ifam).Monitor.TangoNames = AO.(ifam).Monitor.TangoNames(idx);
%     AO.(ifam).DeviceName = AO.(ifam).DeviceName(idx);
%     AO.(ifam).Status = AO.(ifam).Status(idx);
catch err
    warning('MML:wrongfamily', 'Sextupole %s families not found in the model.', ifam);
    fprintf('Message: %s\n', err.message);
end


%% BEND

try
    % Combined BEND    
    AO.BEND.AT.ATType = 'BEND';
    ATIndex = Indices.BEND(:);
    AO.BEND.AT.ATIndex = buildatindex(AO.BEND.FamilyName, sort(ATIndex));
    AO.BEND.Position = findspos(THERING, AO.BEND.AT.ATIndex(:,1))';
catch err
    warning('MML:wrongfamily', 'BEND family not found in the model.');
    fprintf('Message: %s\n', err.message);
end

%% RF CAVITY
try
    AO.RF.AT.ATType = 'RF Cavity';
    AO.RF.AT.ATIndex = findcells(THERING,'Frequency')';
    AO.RF.Position = findspos(THERING, AO.RF.AT.ATIndex(:,1))';
catch err
    warning('MML:wrongfamily', 'RF cavity not found in the model.');
    fprintf('Message: %s\n', err.message);
end

setao(AO);

%% Set TwissData at the start of the storage ring
try

    % BTS twiss parameters at the input for transfer line
    TwissData.alpha = [0 0]';
    TwissData.beta  = [3.668 1.837]';
    TwissData.mu    = [0 0]';
    TwissData.ClosedOrbit = [0 0 0 0]';
    TwissData.dP = 0;
    TwissData.dL = 0;
    TwissData.Dispersion  = [.01 0 0 0]';

    setpvmodel('TwissData', '', TwissData);  % Same as, THERING{1}.TwissData = TwissData;

catch err
    warning('MML:wrongfamily','Setting the twiss data parameters in the MML failed.');
    fprintf('Message: %s\n', err.message);
end
