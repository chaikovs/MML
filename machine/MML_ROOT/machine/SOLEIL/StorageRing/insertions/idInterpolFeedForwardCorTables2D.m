function [new_mCHE_with_arg, new_mCVE_with_arg, new_mCHS_with_arg, new_mCVS_with_arg] = idInterpolFeedForwardCorTables2D(mCHE_with_arg, mCVE_with_arg, mCHS_with_arg, mCVS_with_arg, vNewArg1, vNewArg2, interpMeth)
%   vNewArg1 = [15.5,16,17,18,19,20,22.5, ...], i.e. gap values
%   vNewArg2 = [-40,-37.5,-35,-32.5,-30, ...], i.e. phase values
%interpMeth:
% = 'nearest' %Nearest neighbor interpolation
% = 'linear' %Linear interpolation (default)
% = 'spline' %Cubic spline interpolation
% = 'cubic' %Cubic interpolation, as long as data is uniformly-spaced. Otherwise, this method is the same as 'spline'

new_mCHE_with_arg = idAuxInterpolTable2D(mCHE_with_arg, vNewArg1, vNewArg2, interpMeth);
new_mCVE_with_arg = idAuxInterpolTable2D(mCVE_with_arg, vNewArg1, vNewArg2, interpMeth);
new_mCHS_with_arg = idAuxInterpolTable2D(mCHS_with_arg, vNewArg1, vNewArg2, interpMeth);
new_mCVS_with_arg = idAuxInterpolTable2D(mCVS_with_arg, vNewArg1, vNewArg2, interpMeth);
