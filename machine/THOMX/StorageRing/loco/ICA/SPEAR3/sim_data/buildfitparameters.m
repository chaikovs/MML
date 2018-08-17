function [FitParameters] = buildfitparameters(THERING,varargin)

%%%%%%%%%%%%%%%%%
% FitParameters %
%%%%%%%%%%%%%%%%%

isf  =  findcells(THERING,'FamName','SF');
isd  =  findcells(THERING,'FamName','SD');
isfi =  findcells(THERING,'FamName','SFM');
isdi =  findcells(THERING,'FamName','SDM');
isAT  = sort([isf isd isfi isdi]);

isext = [4 7 19 26 30 33 40 43 47 54 62 66 69];    %indices of 13 skew sextupole (on basis of 1-72 in SPEAR 3)
isATon = isAT(isext);  

% *********** Setup FitParameters for LOCO ********************
FitParameters = [];

QFI = findcells(THERING,'FamName','QF');
QDI = findcells(THERING,'FamName','QD');
QFCI = findcells(THERING,'FamName','QFC');
QDXI = findcells(THERING,'FamName','QDX');
QFXI = findcells(THERING,'FamName','QFX');
QDYI = findcells(THERING,'FamName','QDY');
QFYI = findcells(THERING,'FamName','QFY');
QDZI = findcells(THERING,'FamName','QDZ');
QFZI = findcells(THERING,'FamName','QFZ');
Q9SI = findcells(THERING,'FamName','Q9S');

QFValues = getcellstruct(THERING,'K',[ QFI(1:2) QFI(3) QFI(7:length(QFI))] );
QDValues = getcellstruct(THERING,'K',[ QDI(1:2) QDI(3) QDI(7:length(QDI))] );
QFCValues = getcellstruct(THERING,'K',QFCI(1));
QDXValues = getcellstruct(THERING,'K',[ QDXI(1) QDXI(2) QDXI(3)] );
QFXValues = getcellstruct(THERING,'K',[ QFXI(1) QFXI(2) QFXI(3)] );
QDYValues = getcellstruct(THERING,'K',[ QDYI(1) QDYI(2) QDYI(3)] );
QFYValues = getcellstruct(THERING,'K',[ QFYI(1) QFYI(2) QFYI(3)] );
QDZValues = getcellstruct(THERING,'K',[ QDZI(1) QDZI(2) QDZI(3)] );
QFZValues = getcellstruct(THERING,'K',[ QFZI(1) QFZI(2) QFZI(3)] );
Q9SValues = getcellstruct(THERING,'K',[ Q9SI(1) Q9SI(3) Q9SI(4)] );


% BNDI = findcells(THERING,'FamName','BEND');
% BDMI = findcells(THERING,'FamName','BDM');
% KBND = THERING{BNDI(1)}.K;
% KBDM = THERING{BDMI(1)}.K;

SQValues = getcellstruct(THERING, 'PolynomA', isATon, 2);

% fprintf('   Using default fit parameters:\n');
fprintf('   1. Individual fit on all Quadrupole (QF, QD, QFC, QFX, QDX, QFY, QDY, QFZ, QDZ, Q9S)\n');
fprintf('   2. Fit skew quadrupoles\n');
FitParameters.Values = [QFValues; QDValues; QFCValues; QDXValues; QFXValues; QDYValues; QFYValues; QDZValues; QFZValues; Q9SValues; SQValues];
% FitParameters.Values =[QFValues; QDValues; QFCValues; QDXValues; QFXValues; QDYValues; QFYValues; QDZValues; QFZValues; KBND; KBDM; SQValues];

FitParameters.Params = cell(size(FitParameters.Values));
pos = 0;
for i = 1:2
    FitParameters.Params{pos+i} = mkparamgroup(THERING,QFI(i),'K');
end
pos = pos + 2;

FitParameters.Params{pos+1} = mkparamgroup(THERING,QFI(3:6),'K');
pos = pos + 1;
for i = 7:length(QFI)
    FitParameters.Params{pos+i-6} = mkparamgroup(THERING,QFI(i),'K');
end
pos = pos + length(QFI)-6;

for i = 1:2
    FitParameters.Params{pos+i} = mkparamgroup(THERING,QDI(i),'K');
end
pos = pos + 2;

FitParameters.Params{pos+1} = mkparamgroup(THERING,QDI(3:6),'K');
pos = pos + 1;

for i = 7:length(QDI)
    FitParameters.Params{pos+i-6} = mkparamgroup(THERING,QDI(i),'K');
end
pos = pos + length(QDI)-6;

FitParameters.Params{pos+1}  = mkparamgroup(THERING, QFCI,'K');
FitParameters.Params{pos+2}  = mkparamgroup(THERING,[QDXI(1) QDXI(4)],'K');
FitParameters.Params{pos+3}  = mkparamgroup(THERING,QDXI(2),'K');
FitParameters.Params{pos+4}  = mkparamgroup(THERING,QDXI(3),'K');
FitParameters.Params{pos+5}  = mkparamgroup(THERING,[QFXI(1) QFXI(4)],'K');
FitParameters.Params{pos+6}  = mkparamgroup(THERING,QFXI(2),'K');
FitParameters.Params{pos+7}  = mkparamgroup(THERING,QFXI(3),'K');
FitParameters.Params{pos+8}  = mkparamgroup(THERING,[QDYI(1) QDYI(4)],'K');
FitParameters.Params{pos+9}  = mkparamgroup(THERING,QDYI(2),'K');
FitParameters.Params{pos+10}  = mkparamgroup(THERING,QDYI(3),'K');
FitParameters.Params{pos+11}  = mkparamgroup(THERING,[QFYI(1) QFYI(4)],'K');
FitParameters.Params{pos+12}  = mkparamgroup(THERING,QFYI(2),'K');
FitParameters.Params{pos+13}  = mkparamgroup(THERING,QFYI(3),'K');
FitParameters.Params{pos+14} = mkparamgroup(THERING,[QDZI(1) QDZI(4)],'K');
FitParameters.Params{pos+15} = mkparamgroup(THERING,QDZI(2),'K');
FitParameters.Params{pos+16} = mkparamgroup(THERING,QDZI(3),'K');
FitParameters.Params{pos+17} = mkparamgroup(THERING,[QFZI(1) QFZI(4)],'K');
FitParameters.Params{pos+18} = mkparamgroup(THERING,QFZI(2),'K');
FitParameters.Params{pos+19} = mkparamgroup(THERING,QFZI(3),'K');
FitParameters.Params{pos+20} = mkparamgroup(THERING,[Q9SI(1) Q9SI(2)],'K');  %split quadrupole
FitParameters.Params{pos+21} = mkparamgroup(THERING,Q9SI(3),'K');
FitParameters.Params{pos+22} = mkparamgroup(THERING,[Q9SI(4) Q9SI(5)],'K');  %split quadrupole
pos = pos + 22;
% FitParameters.Params{pos+1} = mkparamgroup(THERING,BNDI,'K');
% FitParameters.Params{pos+2} = mkparamgroup(THERING,BDMI,'K');
% pos = pos + 2;
for i = 1:length(isext)
    FitParameters.Params{pos+i} = mkparamgroup(THERING, isATon(i), 's');
end
pos = pos + length(isext);



%%%%%%%%%%%%%%%%%%%%%
% Parameter Weights %
%%%%%%%%%%%%%%%%%%%%%

% For each cell of FitParameters.Weight.Value, a rows is added to the A matrix
% Index of the row of A:  FitParameters.Weight.Index{i}
% Value of the weight:    FitParameters.Weight.Value{i} / mean(Mstd)

%FlagAddConstr = 0;   % No Weights
FlagAddConstr = 1;    % Constraint the norm of quads
%FlagAddConstr = 2;   % Constraint the norm of quads and skew quads
switch FlagAddConstr
    case 0
        % No Weights
        if isfield(FitParameters, 'Weight')
            FitParameters = rmfield(FitParameters, 'Weight');
        end
    case 1
%        quadindex  = [53, 54, 56, 57, 70, 71, 72]; %achromatic
%        quadweight = [1, 1, 1, 1, 1, 1, 1]*0.05;
        quadindex  = [16,53,56, 72]; %low emittance lattice
        quadweight = [2, 1, 1, 1 ]*0.05;
        %quadweight = ones(size(quadindex))*0.05;

        for ii = 1:72
            FitParameters.Weight.Index{ii,1} = ii;
            FitParameters.Weight.Value{ii,1} = 0.01;
        end
        for ii = 1:length(quadindex)
            FitParameters.Weight.Value{quadindex(ii)} = quadweight(ii);
        end
       
    case 2
        NumFitPara = length(FitParameters.Values);
%         quadindex  = [53, 54, 56, 57, 70, 71, 72];
%         quadweight = [1, 1, 1, 1, 1, 1, 1]*0.05;
        quadindex  = [16,53,56, 72]; %low emittance lattice
        quadweight = [2, 1, 1, 1 ]*0.05;
        
        for ii = 1:72
            FitParameters.Weight.Index{ii,1} = ii;
            FitParameters.Weight.Value{ii,1} = .01;
        end
        for ii = 73:NumFitPara
            FitParameters.Weight.Index{ii,1} = ii;
            FitParameters.Weight.Value{ii,1} = .02;
        end
        for ii = 1:length(quadindex)
            FitParameters.Weight.Value{quadindex(ii)} = quadweight(ii);
        end
        
end

% Starting point for the deltas (automatic delta determination does not work if starting value is 0)
FitParameters.Deltas = 0.0001 * ones(size(FitParameters.Values));

% RF parameter fit setup (There is a flag to actually do the fit)

FitParameters.DeltaRF = 500;  % It's good to have something here so that LOCO will compute a model dispersion

