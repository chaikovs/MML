function updateatindex(THERING)
%UPDATEATINDEX - Updates the AT indices in the MiddleLayer with the present AT lattice (THERING)

%
% Adapted by Laurent S. Nadolski
% Modified 21 November Nanoscopium S11/S12 missing Atgroupparameter

if nargin == 0 
    global THERING
end

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
    AO.(ifam).AT.ATIndex = Indices.BPM(:); % findcells(THERING,'FamName','BPM')';
    AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex)';

    ifam = 'BPMz';
    AO.(ifam).AT.ATType = 'Z';
    AO.(ifam).AT.ATIndex = Indices.BPM(:); % findcells(THERING,'FamName','BPM')';
    AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex)';

    ifam = 'PBPMz'; % pseudo BPM family including XBPM for the vertical plane
    if isfield(AO, ifam) && isfield(Indices, 'PXBPM'),
        AO.(ifam).AT.ATType = 'PZ';
        AO.(ifam).AT.ATIndex = Indices.BPM(:); % findcells(THERING,'FamName','BPM')'; 
        index=find(AO.(ifam).Type==0); % check for xbpm in the family
        for i=1:size(index,1) % insert xbpm index in the list
            AO.(ifam).AT.ATIndex = ...
                [AO.(ifam).AT.ATIndex(1:index(i)-1)' ...
                 Indices.PXBPM(i) ...
                 AO.(ifam).AT.ATIndex(index(i):size(AO.(ifam).AT.ATIndex,1))']';
        end
   %old method to the same thing. To be suppressed if new method is validated     
   % UGLY TO BE changed      
%         AO.(ifam).AT.ATIndex = [Indices.BPM(1:5) Indices.PXBPM(1) ...
%             Indices.BPM(6:35) Indices.PXBPM(2) ...
%             Indices.BPM(36:65) Indices.PXBPM(3) ...
%             Indices.BPM(66:97) Indices.PXBPM(4) Indices.BPM(98:end)]';
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex)';
    end
catch err
    warning('MML:wrongfamily', '%s family not found in the model.', ifam);
    fprintf('Message: %s\n', err.message);
end


%% CORRECTORS
try
    ifam = 'HCOR';
    %% Horizontal correctors are at every AT corrector
    AO.(ifam).AT.ATType = ifam;
    %AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.COR);
    AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, [Indices.COR(1:30)'; Indices.HCMHU640(:); Indices.COR(31:end)']);
    AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';

    %% Vertical correctors are at every AT corrector
    ifam = 'VCOR';
    AO.(ifam).AT.ATType = ifam;
    %AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.COR);
    AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, [Indices.COR(1:30)'; Indices.VCMHU640(:); Indices.COR(31:end)']);
    AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';

    %% Fast Horizontal correctors are at every AT corrector
    ifam = 'FHCOR';
    AO.(ifam).AT.ATType = ifam;
    AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.FCOR);
    AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';

    %% Fast vertical correctors are at every AT corrector
    ifam = 'FVCOR';
    AO.(ifam).AT.ATType = ifam;
    AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.FCOR);
    AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    
    %% SKEW QUADS
    ifam = 'QT';
    AO.(ifam).AT.ATType  = 'SkewQuad';
    AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.SkewQuad);
    %AO.(ifam).AT.ATIndex = ATindx.SkewQuad(:);
    %AO.(ifam).AT.ATIndex = AO.(ifam).AT.ATIndex(AO.(ifam).ElementList);   %not all correctors used
    AO.(ifam).Position   = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    %% VIRTUAL SKEW QUADS
    if isfield(AO,'SQ') && isfield(Indices,'SQ')
        ifam = 'SQ';
        AO.(ifam).AT.ATType  = 'SkewQuad';
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.SQ);
        %AO.(ifam).AT.ATIndex = ATindx.SkewQuad(:);
        %AO.(ifam).AT.ATIndex = AO.(ifam).AT.ATIndex(AO.(ifam).ElementList);   %not all correctors used
        AO.(ifam).Position   = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    end
    
    %% PX2 tuner correctors
    if isfield(AO,'PX2C') && isfield(Indices,'PX2C')
        ifam = 'PX2C';
        AO.(ifam).AT.ATType = 'HCOR';
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.PX2C);
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    end
    
    %% NANO tuner correctors
    if isfield(AO,'NANOC') && isfield(Indices,'NANOC')
        ifam = 'NANOC';
        AO.(ifam).AT.ATType = 'HCOR';
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.NANOC);
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    end

    %% TEMPO correctors
    if isfield(AO,'TEMPOC') && isfield(Indices,'TEMPOC')
        ifam = 'TEMPOC';
        AO.(ifam).AT.ATType = 'HCOR';
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.TEMPOC);
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    end

    %% Machine study kickers KEMH
    if isfield(AO,'KEMH') && isfield(Indices,'KEMH')
        ifam = 'KEMH';
        AO.(ifam).AT.ATType = 'HCOR';
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.KEMH);
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    end
    
    %% Machine study kickers KEMH
    if isfield(AO,'KEMV') && isfield(Indices,'KEMV')
        ifam = 'KEMV';
        AO.(ifam).AT.ATType = 'VCOR';
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.KEMV);
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    end

        %% injection kickers 
    if isfield(AO,'K_INJ') 
        ifam = 'K_INJ';
        AO.(ifam).AT.ATType = 'HCOR';
        AO.(ifam).AT.ATIndex = ones(4,1);
        if ~isfield(Indices,'K1'),
            warning('Injection kicker K1 not defined in lattice');
        else
            AO.(ifam).AT.ATIndex(1) = Indices.K1;
        end
        if ~isfield(Indices,'K2'),
            warning('Injection kicker K2 not defined in lattice');
        else
            AO.(ifam).AT.ATIndex(2) = Indices.K2;
        end
        if ~isfield(Indices,'K3'),
            warning('Injection kicker K3 not defined in lattice');
        else
            AO.(ifam).AT.ATIndex(3) = Indices.K3;
        end
        if ~isfield(Indices,'K4'),
            warning('Injection kicker K4 not defined in lattice');
        else
            AO.(ifam).AT.ATIndex(4) = Indices.K4;
        end        
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    end

   %%  SCRAPER
    if isfield(AO,'SCRAPER') && isfield(Indices,'HSCRAP') && isfield(Indices,'VSCRAP')
        ifam = 'SCRAPER';
        AO.(ifam).AT.ATType = 'marker';
        if length(Indices.HSCRAP) < 2,
            warning('Wrong position of the H-scraper');
            AO.(ifam).AT.ATIndex = [Indices.VSCRAP(1:2) Indices.HSCRAP(1:2)]';
        else
            AO.(ifam).AT.ATIndex = [Indices.VSCRAP Indices.VSCRAP Indices.HSCRAP(1:2)]';
        end
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    end

catch err
    warning('MML:wrongfamily', 'Corrector family %s not found in the model.',ifam);
    fprintf('Message: %s\n', err.message);
end


%% QUADRUPOLES
try
    for k = 1:10,
        ifam = ['Q' num2str(k)];
        AO.(ifam).AT.ATType = 'QUAD';
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.(ifam));
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
    end
    ifam = 'Qall';
    AO.(ifam).AT.ATType = 'QUAD';
    AO.(ifam).AT.ATIndex = [AO.Q1.AT.ATIndex; AO.Q2.AT.ATIndex; AO.Q3.AT.ATIndex; AO.Q4.AT.ATIndex; AO.Q5.AT.ATIndex; ...
        AO.Q6.AT.ATIndex; AO.Q7.AT.ATIndex; AO.Q8.AT.ATIndex; AO.Q9.AT.ATIndex; AO.Q10.AT.ATIndex];
    AO.(ifam).Position = [AO.Q1.Position; AO.Q2.Position; AO.Q3.Position; AO.Q4.Position; AO.Q5.Position; ...
        AO.Q6.Position; AO.Q7.Position; AO.Q8.Position; AO.Q9.Position; AO.Q10.Position];
    
    %% quadrupole for nanoscopium
    if isfield(AO,'Q11') && isfield(Indices,'Q11')
        ifam = 'Q11';
        AO.(ifam).AT.ATType = 'QUAD';
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.(ifam));
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
        
        ifam = 'Q12';
        AO.(ifam).AT.ATType = 'QUAD';
        AO.(ifam).AT.ATIndex = buildatindex(AO.(ifam).FamilyName, Indices.(ifam));
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex(:,1))';
        
        ifam = 'Qall';
        AO.(ifam).Position = [AO.Q1.Position; AO.Q2.Position; AO.Q3.Position; AO.Q4.Position; AO.Q5.Position; ...
        AO.Q6.Position; AO.Q7.Position; AO.Q8.Position; AO.Q9.Position; AO.Q10.Position; AO.Q11.Position; AO.Q12.Position];
        AO.(ifam).AT.ATIndex = [AO.Q1.AT.ATIndex; AO.Q2.AT.ATIndex; AO.Q3.AT.ATIndex; AO.Q4.AT.ATIndex; AO.Q5.AT.ATIndex; ...
        AO.Q6.AT.ATIndex; AO.Q7.AT.ATIndex; AO.Q8.AT.ATIndex; AO.Q9.AT.ATIndex; AO.Q10.AT.ATIndex; AO.Q11.AT.ATIndex; AO.Q12.AT.ATIndex];
    else
      AO.Q11.AT.ATIndex =[];  
      AO.Q12.AT.ATIndex =[];  
    end
    
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

%% SEXTUPOLES
try
    for k = 1:10,
        ifam = ['S' num2str(k)];
        AO.(ifam).AT.ATType = 'SEXT';
        ATIndex = Indices.(ifam);
        AO.(ifam).AT.ATIndex = ATIndex(1);
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex)';
        AO.(ifam).AT.ATParameterGroup{1} = mkparamgroup(THERING, ATIndex(:) ,'K2');
    end
    ifam = 'Sall'; % take first element
    AO.(ifam).AT.ATType = 'SEXT';
    AO.(ifam).Position = [AO.S1.Position(1); AO.S2.Position(1); ...
        AO.S3.Position(1); AO.S4.Position(1); AO.S5.Position(1); ...
        AO.S6.Position(1); AO.S7.Position(1); AO.S8.Position(1); ...
        AO.S9.Position(1); AO.S10.Position(1); NaN; NaN];
    
    % for nanoscopium October 2010
    % add family S11 and S12
    if isfield(AO,'S11') && isfield(Indices,'S11')
        ifam = 'S11';
        AO.(ifam).AT.ATType = 'SEXT';
        ATIndex = Indices.(ifam);
        AO.(ifam).AT.ATIndex = ATIndex(1);
        AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex)';        
        AO.(ifam).AT.ATParameterGroup{1} = mkparamgroup(THERING, ATIndex(:),'K2');
        
        ifam = 'Sall'; % Take first element
        AO.(ifam).Position = [AO.S1.Position(1); AO.S2.Position(1); ...
            AO.S3.Position(1); AO.S4.Position(1); AO.S5.Position(1); ...
            AO.S6.Position(1); AO.S7.Position(1); AO.S8.Position(1); ...
            AO.S9.Position(1); AO.S10.Position(1); AO.S11.Position(1)];
        AO.(ifam).AT.ATIndex = [AO.S1.AT.ATIndex(1); AO.S2.AT.ATIndex(1); ...
            AO.S3.AT.ATIndex(1); AO.S4.AT.ATIndex(1); AO.S5.AT.ATIndex(1); ...
            AO.S6.AT.ATIndex(1); AO.S7.AT.ATIndex(1); AO.S8.AT.ATIndex(1); ...
            AO.S9.AT.ATIndex(1); AO.S10.AT.ATIndex(1); AO.S11.AT.ATIndex(1)];
        
        
        if isfield(AO,'S12') && isfield(Indices,'S12')
            ifam = 'S12';
            AO.(ifam).AT.ATType = 'SEXT';
              ATIndex = Indices.(ifam);
            AO.(ifam).AT.ATIndex = ATIndex(1);
            AO.(ifam).Position = findspos(THERING, AO.(ifam).AT.ATIndex)';
            AO.(ifam).AT.ATParameterGroup{1} = mkparamgroup(THERING,ATIndex(:),'K2');
            
            
            ifam = 'Sall'; % Take first element
            AO.(ifam).AT.ATIndex = [AO.(ifam).AT.ATIndex; AO.S12.AT.ATIndex;];
            
            AO.(ifam).Position = [AO.(ifam).Position; AO.S12.Position(1);];
        else
            AO.S12.AT.ATIndex =[];
        end
    else
        AO.S11.AT.ATIndex =[];
    end

    
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

    % BTS twiss parameters at the input
    TwissData.alpha = [0 0]';
    TwissData.beta  = [13.8467 2.2582]';
    TwissData.mu    = [0 0]';
    TwissData.ClosedOrbit = [0 0 0 0]';
    TwissData.dP = 0;
    TwissData.dL = 0;
    TwissData.Dispersion  = [.06 0 0 0]';

    setpvmodel('TwissData', '', TwissData);  % Same as, THERING{1}.TwissData = TwissData;

catch err
    warning('MML:wrongfamily','Setting the twiss data parameters in the MML failed.');
    fprintf('Message: %s\n', err.message);
end
