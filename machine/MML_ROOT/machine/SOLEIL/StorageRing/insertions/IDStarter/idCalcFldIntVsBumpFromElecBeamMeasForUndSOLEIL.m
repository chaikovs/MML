function [vI1x, vI2x, vI1z, vI2z, vPosBump, vKickX1, vKickX2, vKickZ1, vKickZ2, dNuX, dNuZ] = idCalcFldIntVsBumpFromElecBeamMeasForUndSOLEIL(idName, dirMeasData, fileNamesBumpInf, undParam, dirModel, arIndsBPMsToSkip)
%Calculates dependences I1x vs x (position bump), I1z vs x, etc., for given
%undulator parameters, e.g. undParam = {{'gap', 15.5}, {'phase', 40}}
%fileNamesBumpInf is the result of idMeasElecBeamVsUndParamVsBump
%arIndsBPMsToSkip can be either [1, 2, 3, 7,...] or {[1 1],[1 2],[1 3],[1 7],...}

%Convert list of BPMs to skip to absolute format
if(iscell(arIndsBPMsToSkip))
    numBPMsToSkip = length(arIndsBPMsToSkip);
	if(numBPMsToSkip > 0)
        arAbsIndsBPMsToSkip = zeros(numBPMsToSkip, 1);
        for i = 1:numBPMsToSkip
            arAbsIndsBPMsToSkip = idBPMIndConvForSOLEIL(i);
        end
    else
        arAbsIndsBPMsToSkip = -1;
	end
else
	arAbsIndsBPMsToSkip = arIndsBPMsToSkip;
end

%Extract necessary data from fileNamesBumpInf
numBumps = length(fileNamesBumpInf);
if(numBumps <= 0)
	fprintf('No position bump data was found\n');
	return;
end

GeomParUnd = idGetGeomParamForUndSOLEIL(idName);
ElecBeamModelData = idReadElecBeamModel(dirModel);
mCODx = idCreateModelOrbDistMatr('x', ElecBeamModelData, GeomParUnd);
mCODz = idCreateModelOrbDistMatr('z', ElecBeamModelData, GeomParUnd);

vPosBump = zeros(numBumps, 1);
vI1x = zeros(numBumps, 1);
vI2x = zeros(numBumps, 1);
vI1z = zeros(numBumps, 1);
vI2z = zeros(numBumps, 1);
vKickX1 = zeros(numBumps, 1);
vKickX2 = zeros(numBumps, 1);
vKickZ1 = zeros(numBumps, 1);
vKickZ2 = zeros(numBumps, 1);
dNuX = zeros(numBumps, 1);
dNuZ = zeros(numBumps, 1);

if strcmp(dirMeasData, '')
    dirMeasData = getfamilydata('Directory',idName);
end

absIndMeas = -1;
for i = 1:numBumps
    curFileNamesBumpInf = fileNamesBumpInf{i};
    curBumpInf = curFileNamesBumpInf{1};
    curFileNamesStruct = curFileNamesBumpInf{2};
    vPosBump(i) = 0.5*(curBumpInf(1) + curBumpInf(2));
    
    curUndParamsMeas = curFileNamesStruct.params;
    if(absIndMeas < 0)
        absIndMeas = idAuxCalcIndMeasAtGivenUndParams(curUndParamsMeas, undParam);
    end
    curFileNamesMeasBkg = curFileNamesStruct.filenames_meas_bkg{absIndMeas};
    curFileNameMeas = curFileNamesMeasBkg{1};
    curFileNameBkg = curFileNamesMeasBkg{2};
    
    dirStart = pwd;
    cd(dirMeasData);
	ElecBeamMeasMain = load(curFileNameMeas);
	ElecBeamMeasBkgr = load(curFileNameBkg);
	cd(dirStart);
    
    [vI1x(i), vI2x(i), vI1z(i), vI2z(i)] = idCalcFldIntFromElecBeamMeas(ElecBeamMeasMain, ElecBeamMeasBkgr, mCODx, mCODz, arAbsIndsBPMsToSkip, GeomParUnd.idLen, GeomParUnd.idKickOfst, ElecBeamModelData.E);

	DX_Meas = ElecBeamMeasMain.X - ElecBeamMeasBkgr.X;
	DZ_Meas = ElecBeamMeasMain.Z - ElecBeamMeasBkgr.Z;
	KicksX = idLeastSqLinFit(mCODx, DX_Meas, arAbsIndsBPMsToSkip);
	KicksZ = idLeastSqLinFit(mCODz, DZ_Meas, arAbsIndsBPMsToSkip);
    vKickX1(i) = KicksX(1);
    vKickX2(i) = KicksX(2);
    vKickZ1(i) = KicksZ(1);
    vKickZ2(i) = KicksZ(2);
	dNuX(i) = ElecBeamMeasMain.tune(1) - ElecBeamMeasBkgr.tune(1);
	dNuZ(i) = ElecBeamMeasMain.tune(2) - ElecBeamMeasBkgr.tune(2);
end