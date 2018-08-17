function [LocoMeasData, BPMData, CMData, RINGData, FitParameters, LocoFlags] = buildlocofitparametersSKEWquad_thomx(FileName)
%BUILDLOCOFITPARAMETERS - SOLEIL LOCO fit parameters
%
%  [LocoMeasData, BPMData, CMData, RINGData, FitParameters, LocoFlags] = buildlocoinput(FileName)

%
%% Written By Laurent S. Nadolski

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function only works on the first iteration %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LocoFlags to change from the default %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LocoFlags.Threshold = 1e-5;
% LocoFlags.OutlierFactor = 10;
% LocoFlags.SVmethod = 1e-2;
%LocoFlags.SVmethod = 1:895;  <============= LOOK AT THIS
% LocoFlags.HorizontalDispersionWeight = 12.5;
% LocoFlags.VerticalDispersionWeight = 12.5;
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

% Individual magnets
% For each parameter which is fit in the model a numerical response matrix
% gradient needs to be determined.  The FitParameters data structure determines what
% parameter in the model get varied and how are they grouped.  For no parameter fits, set
% FitParameters.Params to an empty vector.
%     FitParameters.Params = parameter group definition (cell array for AT)
%     FitParameters.Values = Starting value for the parameter fit
%     FitParameters.Deltas = change in parameter value used to compute the gradient (NaN forces loco to choose, see auto-correct delta flag below)
%     FitParameters.FitRFFrequency = ('Yes'/'No') Fit the RF frequency?
%     FitParameters.DeltaRF = Change in RF frequency when measuring "dispersion".
%                             If the RF frequency is being fit the output is stored here.
%
% The FitParameters structure also contains the standard deviations of the fits:
%     LocoValuesSTD
%     FitParameters.DeltaRFSTD
%
% Note: FitParameters.DeltaRF is used when including dispersion in the response matrix.
%       LocoMeasData.DeltaRF is not used directly in loco.  Usually one would set
%       FitParameters.DeltaRF = LocoMeasData.DeltaRF as a starting point for the RF frequency.


ModeCell = {'Fit by family', 'Fit magnets by power supply', 'Fit selected quads', 'Do Not Fit Quadrupoles'};
[ButtonName, OKFlag] = listdlg('Name','BUILDLOCOINPUT','PromptString',{'Fit Parameter Selection:',''}, 'SelectionMode','single', 'ListString', ModeCell, 'ListSize', [350 125], 'InitialValue', 2);
if OKFlag ~= 1
    ButtonName = 1;
end
drawnow;
FitParameters = [];
n = 0;
switch ButtonName
    case 1  % By family
        global THERING; % TODO remove not clean at all
        
        n = 0;
        FitParameters.Deltas = [];
        FitParameters.Values = [];
        
        for k=1:6,
            n = n+1;            
            % set up for QP1, QP2, QP3, QP4
            ifam = ['QP' num2str(k)];
            %set up for QP31, QP41
            if (k==5)    ifam = 'QP31'; end;
            if (k==6)    ifam = 'QP41'; end;
            
            QI = findcells(THERING,'FamName', ifam);
            
            FitParameters.Params{n} = mkparamgroup(THERING, QI, 'K');
            FitParameters.Values = [FitParameters.Values; getcellstruct(THERING, 'K', QI(1))];
            FitParameters.Deltas = [FitParameters.Deltas; NaN];
        end
        
        
    case 2  % Fit by power supply
        
        n = 0;
        FitParameters.Deltas = [];
        FitParameters.Values = [];

        global THERING; % TODO remove not clean at all
        % K-values
        for k=1:6,
            % set up for QP1, QP2, QP3, QP4
            ifam = ['QP' num2str(k)];
            %set up for QP31, QP41
            if (k==5)    ifam = 'QP31'; end;
            if (k==6)    ifam = 'QP41'; end;
            QI = findcells(THERING,'FamName', ifam);
            for loop=1:length(QI)
                n = n + 1;
                FitParameters.Params{n} = mkparamgroup(THERING, QI(loop), 'K');
            end
            FitParameters.Values = [FitParameters.Values; getcellstruct(THERING, 'K', QI)];
            FitParameters.Deltas = [FitParameters.Deltas; NaN * ones(length(QI),1)];
        end

    case 3  % Fit by power supply for the certain families 

        n = 0;
        FitParameters.Deltas = [];
        FitParameters.Values = [];
    global THERING; % TODO remove not clean at all
        % K-values
        for k= [2 4],
            QI = findcells(THERING,'FamName',['QP' num2str(k)]);
            for loop=1:length(QI)
                n = n + 1;
                FitParameters.Params{n} = mkparamgroup(THERING, QI(loop), 'K');
            end
            FitParameters.Values = [FitParameters.Values; getcellstruct(THERING, 'K', QI)];
            FitParameters.Deltas = [FitParameters.Deltas; NaN * ones(length(QI),1)];
        end
case 4 %'Don't Fit'
        fprintf('   Quadrupole not fit.\n\n');
    otherwise
        fprintf('   Quadrupole not fit.\n\n');
end

%%%%%%%%%%%%%%%%%%%%%%%
% Skew quadrupole fits
%%%%%%%%%%%%%%%%%%%%%%%

ModeCell = {'Fit at Sextupoles', 'Fit By Power Supply', 'Do Not Fit Skew Quadrupoles'};
[ButtonName, OKFlag] = listdlg('Name','BUILDLOCOINPUT','PromptString','Skew Quadrupole Fits?', 'SelectionMode','single', 'ListString', ModeCell, 'ListSize', [350 125], 'InitialValue', 2);
if OKFlag ~= 1
    ButtonName = length(ModeCell);  % Default
end

switch ButtonName
    case 1
        fprintf('   Skew fit at Sextupoles needs work.\n\n');
        %     case 1
        %         % Fit skew quadrupoles in the sextupoles
        %         SFI = findcells(RINGData.Lattice,'FamName','SF');
        %         SFn = size(family2dev('SF'),1);
        %
        %         for loop = 1:length(SFI)
        %             if length(SFI) == SFn
        %                 n = n + 1;
        %                 FitParameters.Params{n} = mkparamgroup(RINGData.Lattice,SFI(loop),'s');
        %             elseif length(SFI) == 2*SFn
        %                 % Split sextupoles
        %                 N1 = 2*loop-1;
        %                 N2 = 2*loop;
        %                 n = n + 1;
        %                 FitParameters.Params{n} = mkparamgroup(RINGData.Lattice,SFI([N1 N2]),'s');
        %             else
        %                 error('   Error setting the SF parameter group.');
        %             end
        %         end
        %
        %         FitParameters.Values = [FitParameters.Values; zeros(SFn,1)];
        %         FitParameters.Deltas = [FitParameters.Deltas; 0.5e-2 * ones(SFn,1)];  % automatic delta determination does not work if starting value is 0
        %
        %
        %         % Fit skew quadrupoles in the sextupoles
        %         SDI = findcells(RINGData.Lattice,'FamName','SD');
        %         SDn = size(family2dev('SD'),1);
        %
        %         for loop = 1:length(SDI)
        %             if length(SDI) == SDn
        %                 n = n + 1;
        %                 FitParameters.Params{n} = mkparamgroup(RINGData.Lattice,SDI(loop),'s');
        %             elseif length(SDI) == 2*SDn
        %                 % Split sextupoles
        %                 N1 = 2*loop-1;
        %                 N2 = 2*loop;
        %                 n = n + 1;
        %                 FitParameters.Params{n} = mkparamgroup(RINGData.Lattice,SDI([N1 N2]),'s');
        %             else
        %                 error('   Error setting the SD parameter group.');
        %             end
        %         end
        %
        %         FitParameters.Values = [FitParameters.Values; zeros(SDn,1)];
        %         FitParameters.Deltas = [FitParameters.Deltas; 0.5e-2 * ones(SDn,1)];  % automatic delta determination does not work if starting value is 0
        %
    case 2 % 'Fit by Power Supply'
        % skew quad
%         global THERING; % TODO remove not clean at all
%         n = 0;
%         FitParameters.Deltas = [];
%         FitParameters.Values = [];
        
        QTI = family2atindex('QT',family2dev('QT'));
        for loop=1:length(QTI),
            n = n + 1;
            FitParameters.Params{n} = mkparamgroup(THERING, QTI(loop), 'KS1');
        end
        FitParameters.Values = [FitParameters.Values; zeros(length(QTI),1)];
        FitParameters.Deltas = [FitParameters.Deltas; 1 * ones(length(QTI),1)];

    case 3 %'Don't Fit'
        fprintf('   Skew quadrupole not fit.\n\n');

    otherwise
        fprintf('   Skew quadrupole not fit.\n\n');
end

fprintf('\n');


% 
% %%%%%%%%%%%%%%%%%%%%%
% % Parameter Weights %
% %%%%%%%%%%%%%%%%%%%%%
% 
% % For each cell of FitParameters.Weight.Value, a rows is added to the A matrix
% % Index of the row of A:  FitParameters.Weight.Index{i}
% % Value of the weight:    FitParameters.Weight.Value{i} / mean(Mstd)
% 
% ModeCell = {'No Parameter Weigths', 'Add Parameter Weights'};
% [ButtonName, OKFlag] = listdlg('Name','BUILDLOCOINPUT','PromptString','Weights?', 'SelectionMode','single', 'ListString', ModeCell, 'ListSize', [200 75], 'InitialValue', 2);
% if OKFlag ~= 1
%     ButtonName = 1;  % Default
% end
% 
% switch ButtonName
%     case 1
%         % No Weights
%         if isfield(FitParameters, 'Weight')
%             FitParameters = rmfield(FitParameters, 'Weight');
%         end
%     case 2
%         %for ii = 1:length(FitParameters.Values)
%         for ii = 1:160, % specific weight for K-values
%             FitParameters.Weight.Index{ii,1} = ii;
%             %FitParameters.Weight.Value{ii,1} = 0.1; % for old BPM noise
%             FitParameters.Weight.Value{ii,1} = 0.001; % for new BPM noise (sept 07)
%         end
% end



% RF parameter fit setup (There is a flag to actually do the fit)
if isempty(LocoMeasData.DeltaRF)
    FitParameters.DeltaRF = 100;  % It's good to have something here so that LOCO will compute a model dispersion
else
    FitParameters.DeltaRF = LocoMeasData.DeltaRF;
end


% File check
[BPMData, CMData, LocoMeasData, LocoModel, FitParameters, LocoFlags, RINGData] = locofilecheck({BPMData, CMData, LocoMeasData, LocoModel, FitParameters, LocoFlags, RINGData});


% Save
save(FileName, 'LocoModel', 'FitParameters', 'BPMData', 'CMData', 'RINGData', 'LocoMeasData', 'LocoFlags');
