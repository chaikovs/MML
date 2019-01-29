function [new_mCHE_with_arg, new_mCVE_with_arg, new_mCHS_with_arg, new_mCVS_with_arg] = idUpdateInterpFeedForwardCorTables2D(idName, tabNameCHE, tabNameCVE, tabNameCHS, tabNameCVS, vArgVert, vArgHor, interpMeth)
%tabNameCHE = 'parallelModeCHE'
%tabNameCVE = 'parallelModeCVE'
%vArgVert = [15.5,16,18,...] - gap values
%vArgHor = [-40,-35,-30,...] - phase values
%interpMeth:
% = 'nearest' %Nearest neighbor interpolation
% = 'linear' %Linear interpolation (default)
% = 'spline' %Cubic spline interpolation
% = 'cubic' %Cubic interpolation, as long as data is uniformly-spaced. Otherwise, this method is the same as 'spline'

[DServName] = idGetUndDServer(idName);

%Reading previous cor. tables
rep = tango_read_attribute2(DServName, tabNameCHE);
stOldTablesFF.mCHE_with_arg = rep.value;
rep = tango_read_attribute2(DServName, tabNameCVE);
stOldTablesFF.mCVE_with_arg = rep.value;
rep = tango_read_attribute2(DServName, tabNameCHS);
stOldTablesFF.mCHS_with_arg = rep.value;
rep = tango_read_attribute2(DServName, tabNameCVS);
stOldTablesFF.mCVS_with_arg = rep.value;

[new_mCHE_with_arg, new_mCVE_with_arg, new_mCHS_with_arg, new_mCVS_with_arg] = idInterpolFeedForwardCorTables2D(stOldTablesFF.mCHE_with_arg, stOldTablesFF.mCVE_with_arg, stOldTablesFF.mCHS_with_arg, stOldTablesFF.mCVS_with_arg, vArgVert, vArgHor, interpMeth);

%Saving previous ff tables
fileNameCoreOldFF = 'old_ff_tab';
idSaveStruct(stOldTablesFF, fileNameCoreOldFF, idName, 1, 0);

    %return;
    
%Writing new ff tables
tango_write_attribute2(DServName, tabNameCHE, new_mCHE_with_arg);
tango_write_attribute2(DServName, tabNameCVE, new_mCVE_with_arg);
tango_write_attribute2(DServName, tabNameCHS, new_mCHS_with_arg);
tango_write_attribute2(DServName, tabNameCVS, new_mCVS_with_arg);
