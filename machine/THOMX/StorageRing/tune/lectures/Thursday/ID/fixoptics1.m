
load latticeprepinitwig;   %the unperturbed lattice
%note: we "measure" response matrix for the clean lattice (no IDs)
%so, LOCO fitting will bring the perturbed lattice to this model lattice!

cavityon;
L0 =   findspos(THERING,length(THERING)+1);
C0 =   299792458; % speed of light [m/s]
RINGData.Lattice = THERING;
RINGData.CavityHarmNumber = 372;
RINGData.CavityFrequency = RINGData.CavityHarmNumber*C0/L0;

% Generate "measured" response matrix data
ATI = atindex(THERING);
BPMI = ATI.BPM;
CORI = ATI.COR;
kickx = 0.11*ones(length(CORI),1);
kicky = 0.11*ones(length(CORI),1);
THPLUS = findrespm(THERING, BPMI, CORI,  1e-3*kickx/2, 'KickAngle', 1, 1, 'findsyncorbit', 0);
THMINUS = findrespm(THERING, BPMI, CORI, -1e-3*kickx/2, 'KickAngle', 1, 1, 'findsyncorbit', 0);
TVPLUS = findrespm(THERING, BPMI, CORI,  1e-3*kicky/2, 'KickAngle', 1, 2, 'findsyncorbit', 0);
TVMINUS = findrespm(THERING, BPMI, CORI, -1e-3*kicky/2, 'KickAngle', 1, 2, 'findsyncorbit', 0);

MModel_mm = 1000*[THPLUS{1}-THMINUS{1},TVPLUS{1}-TVMINUS{1};THPLUS{3}-THMINUS{3},TVPLUS{3}-TVMINUS{3}];

LocoMeasData.DeltaRF = 2000.;
DeltaL = -L0*LocoMeasData.DeltaRF/RINGData.CavityFrequency;
orbdRFplus = findsyncorbit(THERING,DeltaL/2,BPMI);
orbdRFminus = findsyncorbit(THERING,-DeltaL/2,BPMI);
DispersionX = orbdRFplus(1,:)-orbdRFminus(1,:);
DispersionY = orbdRFplus(3,:)-orbdRFminus(3,:);
eta = [DispersionX' ; DispersionY'];
eta = 1000*eta;    %convert to mm.

LocoMeasData.M = MModel_mm;
LocoMeasData.RF = RINGData.CavityFrequency ;
LocoMeasData.Eta = eta;

BPMSTD = .0005 + .0005*rand(2*length(BPMI),1);
LocoMeasData.BPMSTD = BPMSTD;

% save LocoMeasData LocoMeasData

% clear all
%Set up parameters for LOCO fit
%load latticeprepinitwig;   %the unperturbed lattice
load latticeprepwig;   %the lattice with real IDs
cavityon;
L0 =   findspos(THERING,length(THERING)+1);
C0 =   299792458; % speed of light [m/s]
RINGData.Lattice = THERING;
RINGData.CavityHarmNumber = 372;
RINGData.CavityFrequency = RINGData.CavityHarmNumber*C0/L0;

ATI = atindex(THERING);
BPMI = ATI.BPM;
CORI = ATI.COR;
BPMData.FamName = 'BPM';
BPMData.BPMIndex = BPMI;
BPMData.HBPMIndex = 1:length(BPMI);
BPMData.VBPMIndex = 1:length(BPMI);
BPMData.HBPMGoodDataIndex = 1:length(BPMI);
BPMData.VBPMGoodDataIndex = 1:length(BPMI);
BPMData.FitCoupling = 'No';
CMData.FamName  = 'COR';
CMData.HCMIndex = CORI;  % Must match the response matrix
CMData.VCMIndex = CORI;
CMData.FitCoupling = 'No';
CMData.FitVCMEnergyShift = 'No';
CMData.FitHCMEnergyShift = 'No';
CMData.HCMKicks = 0.11*ones(length(CMData.HCMIndex),1);
CMData.VCMKicks = 0.11*ones(length(CMData.VCMIndex),1);
CMData.HCMGoodDataIndex = 1:length(CMData.HCMIndex);    % Referenced to HCMIndex
CMData.VCMGoodDataIndex = 1:length(CMData.VCMIndex);    % Referenced to VCMIndex
FitParameters = [];
QFI = findcells(THERING,'FamName','QF');
QDI = findcells(THERING,'FamName','QD');
numquads = length(QFI)+length(QDI);
QFValues = getcellstruct(THERING,'K',QFI(1:length(QFI)));
QDValues = getcellstruct(THERING,'K',QDI(1:length(QDI)));
FitParameters.Values =[QFValues; QDValues];
FitParameters.Params = cell(size(FitParameters.Values));
pos = 0;
for i = 1:length(QFI)
    FitParameters.Params{pos+i} = mkparamgroup(RINGData.Lattice,[QFI(i)],'K');
end
pos = pos + length(QFI);
for i = 1:length(QDI)
    FitParameters.Params{pos+i} = mkparamgroup(RINGData.Lattice,[QDI(i)],'K');
end
pos = pos + length(QDI);

FitParameters.Deltas = 0.0001*ones(size(FitParameters.Values));

FitParameters.DeltaRF = LocoMeasData.DeltaRF;

%Set up LocoFlags:

LocoFlags.Threshold = 1.000000000000000e-005;
LocoFlags.OutlierFactor = 10;
LocoFlags.SVmethod = 1.000000000000000e-005;
LocoFlags.HorizontalDispersionWeight = 1;
LocoFlags.VerticalDispersionWeight = 4;
LocoFlags.AutoCorrectDelta = 'Yes';
LocoFlags.Coupling = 'No';
LocoFlags.Normalize = 'Yes';
LocoFlags.Dispersion = 'No';
LocoFlags.ResponseMatrixCalculatorFlag1 = 'Linear';
LocoFlags.ResponseMatrixCalculatorFlag2 = 'FixedPathLength';

save('spearlocoinput', 'FitParameters', 'BPMData', 'CMData', 'RINGData', 'LocoMeasData', 'LocoFlags'); 