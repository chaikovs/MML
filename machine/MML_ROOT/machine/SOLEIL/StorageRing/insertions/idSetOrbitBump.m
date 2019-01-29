function ErrorFlag = idSetOrbitBump(BPM_Family, BPM_DeviceList, GoalOrbit, CM_Family, CM_IncrementList)
%Makes an accurate incremental bump, by walking around the problem of eventual
%saturation of BPMs

BPM_LinearLimitPos = 1; %[mm] max. abs. value of position after which the BMPs start to saturate

numPos = length(GoalOrbit);
maxAbsPos = 0;
for i = 1:numPos
    curAbsPos = abs(GoalOrbit(i));
    if(maxAbsPos < curAbsPos)
        maxAbsPos = curAbsPos;
    end
end

if(maxAbsPos <= BPM_LinearLimitPos)
    setorbitbump(BPM_Family, BPM_DeviceList, GoalOrbit, CM_Family, CM_IncrementList);
	return;
end

[OCS, OCS0, V, S, ErrorFlag] = setorbitbump(BPM_Family, BPM_DeviceList, GoalOrbit*(BPM_LinearLimitPos/maxAbsPos), CM_Family, CM_IncrementList, 'NoSetSP');
if(ErrorFlag)
    return;
end
CM_DeviceList = OCS.CM.DeviceList;
CM_DeltaSP = OCS.CM.Delta;

stepsp(CM_Family, CM_DeltaSP*(maxAbsPos/BPM_LinearLimitPos), CM_DeviceList);
