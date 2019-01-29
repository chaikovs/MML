function [vI1x, vI2x, vI1z, vI2z, vKickX1, vKickX2, vKickZ1, vKickZ2] = idCalcFldIntFromElecBeamMeasForUndSOLEIL(idName, dirMeasData, fileNamesMeasMain, fileNamesMeasBkgr, dirModel, arIndsBPMsToSkip)

%Calculates effective first and second horizontal and vertical field
%integrals of SOLEIL undulators from COD

GeomParUnd = idGetGeomParamForUndSOLEIL(idName);

ElecBeamModelData = idReadElecBeamModel(dirModel);
mCODx = idCreateModelOrbDistMatr('x', ElecBeamModelData, GeomParUnd);
mCODz = idCreateModelOrbDistMatr('z', ElecBeamModelData, GeomParUnd);

numMeas = length(fileNamesMeasMain);
numMeasBkgr = length(fileNamesMeasBkgr);
if(numMeas ~= numMeasBkgr)
    sprintf('Inconsistent numbers of the main and background measurements\n');
    return;
end

vI1x = zeros(numMeas, 1);
vI2x = zeros(numMeas, 1);
vI1z = zeros(numMeas, 1);
vI2z = zeros(numMeas, 1);
vKickX1 = zeros(numMeas, 1);
vKickX2 = zeros(numMeas, 1);
vKickZ1 = zeros(numMeas, 1);
vKickZ2 = zeros(numMeas, 1);

if strcmp(dirMeasData, '')
    dirMeasData = getfamilydata('Directory',idName);
end

for i = 1:numMeas
    dirStart = pwd;
        
    %if strcmp(dirMeasData, '') == 0
	cd(dirMeasData);
    %end
    
	%ElecBeamMeasMain = load(char(fileNamesMeasMain(i)));
	%ElecBeamMeasBkgr = load(char(fileNamesMeasBkgr(i)));
	ElecBeamMeasMain = load(fileNamesMeasMain{i});
	ElecBeamMeasBkgr = load(fileNamesMeasBkgr{i});

	cd(dirStart);
    
    [vI1x(i), vI2x(i), vI1z(i), vI2z(i)] = idCalcFldIntFromElecBeamMeas(ElecBeamMeasMain, ElecBeamMeasBkgr, mCODx, mCODz, arIndsBPMsToSkip, GeomParUnd.idLen, GeomParUnd.idKickOfst, ElecBeamModelData.E);

	DX_Meas = ElecBeamMeasMain.X - ElecBeamMeasBkgr.X;
	DZ_Meas = ElecBeamMeasMain.Z - ElecBeamMeasBkgr.Z;
	KicksX = idLeastSqLinFit(mCODx, DX_Meas, arIndsBPMsToSkip);
	KicksZ = idLeastSqLinFit(mCODz, DZ_Meas, arIndsBPMsToSkip);
    vKickX1(i) = KicksX(1);
    vKickX2(i) = KicksX(2);
    vKickZ1(i) = KicksZ(1);
    vKickZ2(i) = KicksZ(2);
end


