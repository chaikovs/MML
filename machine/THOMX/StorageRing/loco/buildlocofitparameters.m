function [LocoMeasData, BPMData, CMData, RINGData, FitParameters, LocoFlags] = buildlocoinput(FileName)
%BUILDLOCOFITPARAMETERS - Spear3 LOCO fit parameters
%
%  [LocoMeasData, BPMData, CMData, RINGData, FitParameters, LocoFlags] = buildlocoinput(FileName)



%%%%%%%%%%%%%%
% Input file %
%%%%%%%%%%%%%%
if nargin == 0
    [FileName, DirectoryName, FilterIndex] = uigetfile('*.mat','Select a LOCO input file');
    if FilterIndex == 0 
        return;
    end
    FileName = [DirectoryName, FileName];
end

load(FileName);



%%%%%%%%%%%%%%%%%%%%%%
% Remove bad devices %
%%%%%%%%%%%%%%%%%%%%%%
RemoveHCMDeviceList = [];
RemoveVCMDeviceList = [];

RemoveHBPMDeviceList = [];
RemoveVBPMDeviceList = [];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is only works on the first iteration %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if exist('BPMData','var') && length(BPMData)>1
    BPMData = BPMData(1);
end
if exist('CMData','var') && length(CMData)>1
    CMData = CMData(1);
end
if exist('FitParameters','var') && length(FitParameters)>1
    FitParameters = FitParameters(1);
end
if exist('LocoFlags','var') && length(LocoFlags)>1
    LocoFlags = LocoFlags(1);
end
if exist('LocoModel','var') && length(LocoModel)>1
    LocoModel = LocoModel(1);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make sure the start point in loaded in the AT model %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~isempty(FitParameters)
    for i = 1:length(FitParameters.Params)
        RINGData = locosetlatticeparam(RINGData, FitParameters.Params{i}, FitParameters.Values(i));
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tune up a few parameters based on the MachineConfig %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
    if isfield(LocoMeasData, 'MachineConfig')
        % Sextupoles
        if all(MachineConfig.SX1.Setpoint.Data == 0)
            fprintf('   Turning SX1 family off in the LOCO model.\n');
            ATIndex = findcells(RINGData.Lattice,'FamName','SX1')';
            for i = 1:length(ATIndex)
                RINGData.Lattice{ATIndex(i)}.PolynomB(3) = 0;
            end
        end
        if all(MachineConfig.SX2.Setpoint.Data == 0)
            fprintf('   Turning SX2 family off in the LOCO model.\n');
            ATIndex = findcells(RINGData.Lattice,'FamName','SX2')';
            for i = 1:length(ATIndex)
                RINGData.Lattice{ATIndex(i)}.PolynomB(3) = 0;
            end
        end
        if all(MachineConfig.SX3.Setpoint.Data == 0)
            fprintf('   Turning SX3 family off in the LOCO model.\n');
            ATIndex = findcells(RINGData.Lattice,'FamName','SX3')';
            for i = 1:length(ATIndex)
                RINGData.Lattice{ATIndex(i)}.PolynomB(3) = 0;
            end
        end
%         if all(MachineConfig.SDM.Setpoint.Data == 0)
%             fprintf('   Turning SDM family off in the LOCO model.\n');
%             ATIndex = findcells(RINGData.Lattice,'FamName','SDM')';
%             for i = 1:length(ATIndex)
%                 RINGData.Lattice{ATIndex(i)}.PolynomB(3) = 0;
%             end
%         end
    end
catch
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LocoFlags to change from the default %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LocoFlags.Threshold = 3e-4;
% LocoFlags.OutlierFactor = 10;
% LocoFlags.SVmethod = 1e-2;
LocoFlags.HorizontalDispersionWeight = 1;
LocoFlags.VerticalDispersionWeight = 1;%4; <============= LOOK AT THIS
% LocoFlags.AutoCorrectDelta = 'Yes';
% LocoFlags.Coupling = 'No';
% LocoFlags.Dispersion = 'No';
% LocoFlags.Normalize = 'Yes';
% LocoFlags.ResponseMatrixCalculatorFlag1 = 'Linear';
% LocoFlags.ResponseMatrixCalculatorFlag2 = 'FixedPathLength';
% LocoFlags.CalculateSigma = 'No';
% LocoFlags.SinglePrecision = 'Yes';

% CMData.FitKicks    = 'Yes';
% CMData.FitCoupling = 'No';
% 
% BPMData.FitGains    = 'Yes';
% BPMData.FitCoupling = 'No';


% Corrector magnets to disable
j = findrowindex(RemoveHCMDeviceList, LocoMeasData.HCM.DeviceList);
if ~isempty(j)
    irm = findrowindex(j(:),CMData.HCMGoodDataIndex(:));
    CMData.HCMGoodDataIndex(irm) = [];
end

j = findrowindex(RemoveVCMDeviceList, LocoMeasData.VCM.DeviceList);
if ~isempty(j)
    irm = findrowindex(j(:),CMData.VCMGoodDataIndex(:));
    CMData.VCMGoodDataIndex(irm) = [];
end


% BPMs to disable
j = findrowindex(RemoveHBPMDeviceList, LocoMeasData.HBPM.DeviceList);
if ~isempty(j)
    irm = findrowindex(j(:),BPMData.HBPMGoodDataIndex(:));
    BPMData.HBPMGoodDataIndex(irm) = [];
end

j = findrowindex(RemoveVBPMDeviceList, LocoMeasData.VBPM.DeviceList);
if ~isempty(j)
    irm = findrowindex(j(:),BPMData.VBPMGoodDataIndex(:));
    BPMData.VBPMGoodDataIndex(irm) = [];
end



%%%%%%%%%%%%%%%%%
% FitParameters %
%%%%%%%%%%%%%%%%%

fprintf('   Using default fit parameters:\n');
THERING = RINGData.Lattice;
% isf  =  findcells(THERING,'FamName','QP1');
% isd  =  findcells(THERING,'FamName','QP2');
% isfi =  findcells(THERING,'FamName','QP3');
% isdi =  findcells(THERING,'FamName','QP4');
% isAT  = sort([isf isd isfi isdi]);
% isext = [3 4 7 8];    %indices of 14 skew sextupole (on basis of 1-72 in SPEAR 3)
% isATon = isAT(isext);  

% *********** Setup FitParameters for LOCO ********************
FitParameters = [];

QP1I = findcells(THERING,'FamName','QP1');
QP2I = findcells(THERING,'FamName','QP2');
QP3I = findcells(THERING,'FamName','QP3');
QP4I = findcells(THERING,'FamName','QP4');
QP31I = findcells(THERING,'FamName','QP31');
QP41I = findcells(THERING,'FamName','QP41');


QP1Values = getcellstruct(THERING,'K',[ QP1I(1:2) QP1I(3:4)] );
QP2Values = getcellstruct(THERING,'K',[ QP2I(1:2) QP2I(3:length(QP2I))] );
QP3Values = getcellstruct(THERING,'K', QP3I);
QP4Values = getcellstruct(THERING,'K', QP4I );
QP31Values = getcellstruct(THERING,'K',[ QP31I(1) QP31I(2) QP31I(3:4)] );
QP41Values = getcellstruct(THERING,'K',[ QP41I(1) QP41I(2) QP41I(3:4)] );


% BNDI = findcells(THERING,'FamName','BEND');
% BDMI = findcells(THERING,'FamName','BDM');
% KBND = THERING{BNDI(1)}.K;
% KBDM = THERING{BDMI(1)}.K;

% SQValues = getcellstruct(THERING, 'PolynomA', isATon, 2);

fprintf('   Using default fit parameters:\n');
fprintf('   1. Individual fit on all Quadrupole (QP1, QP2, QP3, QP4, QP31, QP41)\n');
%fprintf('   2. Fit skew quadrupoles\n');
FitParameters.Values = [QP1Values; QP2Values; QP3Values; QP4Values; QP31Values; QP41Values];
%FitParameters.Values = [QP2Values];


FitParameters.Params = cell(size(FitParameters.Values));
pos = 0;

for i = 1:4
    FitParameters.Params{pos+i} = mkparamgroup(RINGData.Lattice,QP1I(i),'K');
end
 pos = pos + 4;

for i = 1:4
    FitParameters.Params{pos+i} = mkparamgroup(RINGData.Lattice,QP2I(i),'K');
end
pos = pos + length(QP2I);

for i = 1:4
    FitParameters.Params{pos+i} = mkparamgroup(RINGData.Lattice,QP3I(i),'K');
end
pos = pos + length(QP2I);

for i = 1:4
    FitParameters.Params{pos+i} = mkparamgroup(RINGData.Lattice,QP4I(i),'K');
end
pos = pos + length(QP2I);

for i = 1:4
    FitParameters.Params{pos+i} = mkparamgroup(RINGData.Lattice,QP31I(i),'K');
end
pos = pos + length(QP2I);

for i = 1:4
    FitParameters.Params{pos+i} = mkparamgroup(RINGData.Lattice,QP41I(i),'K');
end



% % FitParameters.Params{pos+1}  = mkparamgroup(RINGData.Lattice, QP1I,'K');
% % FitParameters.Params{pos+2}  = mkparamgroup(RINGData.Lattice,QP2I(1:4),'K');
% % FitParameters.Params{pos+3}  = mkparamgroup(RINGData.Lattice,QP3I,'K');
% % FitParameters.Params{pos+4}  = mkparamgroup(RINGData.Lattice,QP4I,'K');
% % %FitParameters.Params{pos+5}  = mkparamgroup(RINGData.Lattice,[QFXI(1) QFXI(4)],'K');
% % FitParameters.Params{pos+5}  = mkparamgroup(RINGData.Lattice,QP31I,'K');
% % FitParameters.Params{pos+6}  = mkparamgroup(RINGData.Lattice,QP41I,'K');
% % 
% % pos = pos + 6;
% % for i = 1:length(isext)
% %     FitParameters.Params{pos+i} = mkparamgroup(RINGData.Lattice, isATon(i), 'K');
% % end
% %%pos = pos + length(isext);



%%%%%%%%%%%%%%%%%%%%%
% Parameter Weights %
%%%%%%%%%%%%%%%%%%%%%

% For each cell of FitParameters.Weight.Value, a rows is added to the A matrix
% Index of the row of A:  FitParameters.Weight.Index{i}
% Value of the weight:    FitParameters.Weight.Value{i} / mean(Mstd)

% %FlagAddConstr = 0;   % No Weights
% FlagAddConstr = 1;    % Constraint the norm of quads
% %FlagAddConstr = 2;   % Constraint the norm of quads and skew quads
% switch FlagAddConstr
%     case 0
%         % No Weights
%         if isfield(FitParameters, 'Weight')
%             FitParameters = rmfield(FitParameters, 'Weight');
%         end
%     case 1
%         quadindex  = [53, 54, 56, 57, 70, 71, 72];
%         quadweight = [1, 1, 1, 1, 1, 1, 1]*0.05;
%         for ii = 1:72
%             FitParameters.Weight.Index{ii,1} = ii;
%             FitParameters.Weight.Value{ii,1} = 0.01;
%         end
%         for ii = 1:length(quadindex)
%             FitParameters.Weight.Value{quadindex(ii)} = quadweight(ii);
%         end
%     case 2
%         NumFitPara = length(FitParameters.Values);
%         quadindex  = [53, 54, 56, 57, 70, 71, 72];
%         quadweight = [1, 1, 1, 1, 1, 1, 1]*0.05;
%         
%         for ii = 1:72
%             FitParameters.Weight.Index{ii,1} = ii;
%             FitParameters.Weight.Value{ii,1} = .01;
%         end
%         for ii = 73:NumFitPara
%             FitParameters.Weight.Index{ii,1} = ii;
%             FitParameters.Weight.Value{ii,1} = .02;
%         end
%         for ii = 1:length(quadindex)
%             FitParameters.Weight.Value{quadindex(ii)} = quadweight(ii);
%         end
% end

    

% Starting point for the deltas (automatic delta determination does not work if starting value is 0)
FitParameters.Deltas = 0.0001 * ones(size(FitParameters.Values));


% RF parameter fit setup (There is a flag to actually do the fit)
if isempty(LocoMeasData.DeltaRF)
    FitParameters.DeltaRF = 500;  % It's good to have something here so that LOCO will compute a model dispersion
else
    FitParameters.DeltaRF = LocoMeasData.DeltaRF;
end


% File check
[BPMData, CMData, LocoMeasData, LocoModel, FitParameters, LocoFlags, RINGData] = locofilecheck({BPMData, CMData, LocoMeasData, LocoModel, FitParameters, LocoFlags, RINGData});


% Save
save(FileName, 'LocoModel', 'FitParameters', 'BPMData', 'CMData', 'RINGData', 'LocoMeasData', 'LocoFlags');


