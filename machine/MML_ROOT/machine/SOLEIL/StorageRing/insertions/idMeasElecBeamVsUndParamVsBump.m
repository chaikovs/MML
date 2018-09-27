function [resFileNamesBumpInf, ErrorFlag] = idMeasElecBeamVsUndParamVsBump(idName, undParams, undParamsBkg, freqBkgMeas, inclPerturbMeas, fileNameCore, dispData, bumpPlane, bumpValues, CM_IncrementList)
%Measure e-beam COD at different undulator parameters (gap, phase or currents in main coils)
%at different orbit bumps in the straight section where the ID is located,
%assuming that there is no bump in the beginning
%bumpPlane: 'H' or 'V'
%bumpValues: {[x1 x2],[k1,k2,k3,...}}
%   [x1 x2] indicates direction/quanta of e-beam displacement (should be small enaugh to ensure correct bump directly from setorbitbump); 
%   the actual bumps will be then k1*[x1 x2], k2*[x1 x2], k3*[x1 x2], ...
%CM_IncrementList: e.g. [-2 -1 1 2] - will go directly to setorbitbump

sleepTimeAfterBump_s = 20; %To steer
resFileNamesBumpInf = {};
BPM_Family = 'BPMx';
CM_Family = 'HCOR';
if(strcmp(bumpPlane, 'V') || strcmp(bumpPlane, 'Z') || strcmp(bumpPlane, 'Y'))
    BPM_Family = 'BPMz';
    CM_Family = 'VCOR';
end

undParStruct = idGetGeomParamForUndSOLEIL(idName);
BPM_DeviceList = undParStruct.indRelBPMs;

[CM_DeviceList, CM_QuantaSP, ErrorFlag] = idGetCorCurForOrbitBump(BPM_Family, BPM_DeviceList, bumpValues{1}, CM_Family, CM_IncrementList);
if(ErrorFlag)
    return;
end

arMultSP = bumpValues{2};
numSP = length(arMultSP);

%[CM_OrigSP, tout, DataTime, ErrorFlag] = getam(CM_Family, CM_DeviceList);
%if(ErrorFlag)
%    return;
%end

%Save correctors at the beginning (print to )
CM_OrigSP = getsp(CM_Family, CM_DeviceList);
CM_OrigSP_abs = getsp(CM_Family);

CM_PrevSP = CM_OrigSP;
CM_PrevSP = CM_PrevSP - CM_OrigSP; %To make "0"

for i = 1:numSP
    CM_NextSP = CM_QuantaSP*arMultSP(i);
    %Relative bump:
    if(stepsp(CM_Family, CM_NextSP - CM_PrevSP, CM_DeviceList))
    	return;
    end
    pause(sleepTimeAfterBump_s);
    CM_PrevSP = CM_NextSP;

    %Decorating filename core with bump information
    fileNameCoreBump = strcat(fileNameCore, '_bump');
    fileNameCoreBump = strcat(fileNameCoreBump, bumpPlane);
	fileNameCoreBump = strcat(fileNameCoreBump, '_');
    pairPos = arMultSP(i)*bumpValues{1};
	fileNameCoreBump = strcat(fileNameCoreBump, idAuxNum2FileNameStr(pairPos(1)));
    if(pairPos(2) ~= pairPos(1))
        fileNameCoreBump = strcat(fileNameCoreBump, '_');
        fileNameCoreBump = strcat(fileNameCoreBump, idAuxNum2FileNameStr(pairPos(2)));
    end

	[curFileNameStruct, ErrorFlag] = idMeasElecBeamVsUndParam(idName, undParams, undParamsBkg, freqBkgMeas, inclPerturbMeas, fileNameCoreBump, dispData);
    if(ErrorFlag)
        return;
    end
    resFileNamesBumpInf{i} = {pairPos, curFileNameStruct};
end

%Returning to the original state
%stepsp(CM_Family, CM_OrigSP - CM_PrevSP, CM_DeviceList);
setsp(CM_Family, CM_OrigSP_abs);
