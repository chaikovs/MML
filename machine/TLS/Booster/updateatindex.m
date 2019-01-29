function updateatindex
%UPDATEATINDEX - Updates the AT indices in the MiddleLayer with the present AT lattice (THERING)


global THERING


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Append Accelerator Toolbox information %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Since changes in the AT model could change the AT indexes, etc,
% It's best to regenerate all the model indices whenever a model is loaded

% Sort by family first (findcells is linear and slow)
Indices = atindex(THERING);


AO = getao;

try
    AO.BPMx.AT.ATType = 'X';
    AO.BPMx.AT.ATIndex = Indices.BPM(:); % findcells(THERING,'FamName','BPM')';
    AO.BPMx.Position = findspos(THERING, AO.BPMx.AT.ATIndex)';

    AO.BPMy.AT.ATType = 'Y';
    AO.BPMy.AT.ATIndex = Indices.BPM(:); % findcells(THERING,'FamName','BPM')';
    AO.BPMy.Position = findspos(THERING, AO.BPMy.AT.ATIndex)';
catch
    warning('BPM family not found in the model.');
end

try
    % Horizontal correctors are at every AT corrector
    AO.HCM.AT.ATType = 'HCM';
    AO.HCM.AT.ATIndex = buildatindex(AO.HCM.FamilyName, Indices.HCOR);
    AO.HCM.Position = findspos(THERING, AO.HCM.AT.ATIndex(:,1))';

    % Not all correctors are vertical correctors
    AO.VCM.AT.ATType = 'VCM';
    AO.VCM.AT.ATIndex = buildatindex(AO.VCM.FamilyName, Indices.VCOR);
    AO.VCM.Position = findspos(THERING, AO.VCM.AT.ATIndex(:,1))';
catch
    warning('Corrector family not found in the model.');
end

try
    AO.QF.AT.ATType = 'QUAD';
    AO.QF.AT.ATIndex = buildatindex(AO.QF.FamilyName, Indices.QF);
    AO.QF.Position = findspos(THERING, AO.QF.AT.ATIndex(:,1))';

    AO.QD.AT.ATType = 'QUAD';
    AO.QD.AT.ATIndex = buildatindex(AO.QD.FamilyName, Indices.QD);
    AO.QD.Position = findspos(THERING, AO.QD.AT.ATIndex(:,1))';

    AO.SFQ.AT.ATType = 'QUAD';
    AO.SFQ.AT.ATIndex = buildatindex(AO.SFQ.FamilyName, Indices.SFQ);
    AO.SFQ.Position = findspos(THERING, AO.SFQ.AT.ATIndex(:,1))';

    AO.SDQ.AT.ATType = 'QUAD';
    AO.SDQ.AT.ATIndex = buildatindex(AO.SDQ.FamilyName, Indices.SDQ);
    AO.SDQ.Position = findspos(THERING, AO.SDQ.AT.ATIndex(:,1))';

catch
    warning('QUAD family not found in the model.');
end


% try
%     AO.S1.AT.ATType = 'SEXT';
%     AO.S1.AT.ATIndex = buildatindex(AO.S1.FamilyName, Indices.S1);
%     AO.S1.Position = findspos(THERING, AO.S1.AT.ATIndex(:,1))';
% 
%     AO.S2.AT.ATType = 'SEXT';
%     AO.S2.AT.ATIndex = buildatindex(AO.S2.FamilyName, Indices.S2);
%     AO.S2.Position = findspos(THERING, AO.S2.AT.ATIndex(:,1))';
%     
% catch
%     warning('Sextupole families not found in the model.');
% end



% try
%     % HDM
%     AO.HDM.AT.ATType = 'BEND';
% %     AO.BEND.AT.ATIndex = buildatindex(AO.BEND.FamilyName, sort([Indices.BEND]));
%     AO.HDM.AT.ATIndex = buildatindex(AO.HDM.FamilyName, Indices.HDM(:));
%     AO.HDM.Position = findspos(THERING, AO.HDM.AT.ATIndex(:,1))';
% catch
%     warning('HDM family not found in the model.');
% end

try
    % BEND
    AO.BD.AT.ATType = 'BD';
    AO.BD.AT.ATIndex = buildatindex(AO.BD.FamilyName, sort([Indices.BD]));
%     ATIndex = [Indices.BD(:); Indices.HDM(:)];
%     AO.BD.AT.ATIndex = buildatindex(AO.BD.FamilyName, sort(ATIndex));
    AO.BD.Position = findspos(THERING, AO.BD.AT.ATIndex(:,1))';
    
%     AO.BH.AT.ATType = 'BH';
%     AO.BH.AT.ATIndex = buildatindex(AO.BH.FamilyName, sort([Indices.BH]));
% %     ATIndex = [Indices.BH(:); Indices.HDM(:)];
% %     AO.BH.AT.ATIndex = buildatindex(AO.BH.FamilyName, sort(ATIndex));
%     AO.BH.Position = findspos(THERING, AO.BH.AT.ATIndex(:,1))';
catch
    warning('BEND family not found in the model.');
end

% try
%     % SWLS
%     AO.SWLS.AT.ATType = 'SWLS';
%     AO.SWLS.AT.ATIndex = buildatindex(AO.SWLS.FamilyName, sort([Indices.SWLS]));
%     AO.SWLS.Position = findspos(THERING, AO.SWLS.AT.ATIndex(:,1))';
% catch
%     warning('SWLS family not found in the model.');
% end
% 
% try
%     % IASW6
%     AO.IASW6.AT.ATType = 'IASW6';
%     AO.IASW6.AT.ATIndex = buildatindex(AO.IASW6.FamilyName, sort([Indices.IASW6]));
%     AO.IASW6.Position = findspos(THERING, AO.IASW6.AT.ATIndex(:,1))';
% catch
%     warning('IASW6 family not found in the model.');
% end
% 
% try
%     % W20
%     AO.W20.AT.ATType = 'W20';
%     AO.W20.AT.ATIndex = buildatindex(AO.W20.FamilyName, sort([Indices.W20]));
%     AO.W20.Position = findspos(THERING, AO.W20.AT.ATIndex(:,1))';
% catch
%     warning('W20 family not found in the model.');
% end
% 
% try
%     % SW6
%     AO.SW6.AT.ATType = 'SW6';
%     AO.SW6.AT.ATIndex = buildatindex(AO.SW6.FamilyName, sort([Indices.SW6]));
%     AO.SW6.Position = findspos(THERING, AO.SW6.AT.ATIndex(:,1))';
% catch
%     warning('SW6 family not found in the model.');
% end
% 
% try
%     % U9
%     AO.U9.AT.ATType = 'U9';
%     AO.U9.AT.ATIndex = buildatindex(AO.U9.FamilyName, sort([Indices.U9]));
%     AO.U9.Position = findspos(THERING, AO.U9.AT.ATIndex(:,1))';
% catch
%     warning('U9 family not found in the model.');
% end
% 
% try
%     % U5
%     AO.U5.AT.ATType = 'U5';
%     AO.U5.AT.ATIndex = buildatindex(AO.U5.FamilyName, sort([Indices.U5]));
%     AO.U5.Position = findspos(THERING, AO.U5.AT.ATIndex(:,1))';
% catch
%     warning('U5 family not found in the model.');
% end
% 
% try
%     % EPU56
%     AO.EPU56.AT.ATType = 'EPU56';
%     AO.EPU56.AT.ATIndex = buildatindex(AO.EPU56.FamilyName, sort([Indices.EPU56]));
%     AO.EPU56.Position = findspos(THERING, AO.EPU56.AT.ATIndex(:,1))';
% catch
%     warning('EPU56 family not found in the model.');
% end

% RF Cavity
try
    AO.RF.AT.ATType = 'RF Cavity';
    AO.RF.AT.ATIndex = findcells(THERING,'Frequency')';
    AO.RF.Position = findspos(THERING, AO.RF.AT.ATIndex(:,1))';
catch
    warning('RF cavity not found in the model.');
end


setao(AO);



% Set TwissData at the start of the storage ring
% try   
%     % BTS twiss parameters at the input 
%     TwissData.alpha = [0 0]';
%     TwissData.beta  = [14.380 9.302]';
%     TwissData.mu    = [0 0]';
%     TwissData.ClosedOrbit = [0 0 0 0]';
%     TwissData.dP = 0;
%     TwissData.dL = 0;
%     TwissData.Dispersion  = [0.098389015850282 0 0 0]';
%     
%     setpvmodel('TwissData', '', TwissData);  % Same as, THERING{1}.TwissData = TwissData;
% catch
%      warning('Setting the twiss data parameters in the MML failed.');
% end
