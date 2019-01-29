function [CM_DeviceList, CM_CurSP, ErrorFlag] = idGetCorCurForOrbitBump(BPM_Family, BPM_DeviceList, GoalOrbit, CM_Family, CM_IncrementList)
%Determines a vector of relative current values [A] in a given set of correctors,
%which are necessary to provide a given incremental bump in storage ring

[OCS, OCS0, V, S, ErrorFlag] = setorbitbump(BPM_Family, BPM_DeviceList, GoalOrbit, CM_Family, CM_IncrementList, 'NoSetSP');
if(ErrorFlag)
    return;
end
CM_DeviceList = OCS.CM.DeviceList;
CM_CurSP = OCS.CM.Delta;

%Get "normal" setpoints for corrector currents
%[CM_OrigCurSP, tout, DataTime, ErrorFlag] = getam(CM_Family, CM_DeviceList);
%if(ErrorFlag ~= 0)
%    return;
%end

%Do the bump ('incremental' by default ?)
%[OCS, OCS0, V, S, ErrorFlag] = setorbitbump(BPM_Family, BPM_DeviceList, GoalOrbit, CM_Family, CM_IncrementList);
%if(ErrorFlag)
%    return;
%end
%CM_DeviceList = OCS.CM.DeviceList;

%Get setpoints
%[CM_CurSP, tout, DataTime, ErrorFlag] = getam(CM_Family, CM_DeviceList);
%if(ErrorFlag)
%    return;
%end

%We need relative currents:
%CM_CurSP = CM_CurSP - CM_OrigCurSP;

%Removing the bump - do we need to do that?
%[OCS, OCS0, V, S, ErrorFlag] = setorbitbump(BPM_Family, BPM_DeviceList, -GoalOrbit, CM_Family, CM_IncrementList);
