function [new_mCHE_with_arg, new_mCVE_with_arg, new_mCHS_with_arg, new_mCVS_with_arg] = idInterpolFeedForwardCorTables2D(mCHE_with_arg, mCVE_with_arg, mCHS_with_arg, mCVS_with_arg, vNewArg1, vNewArg2, interpMeth)

new_mCHE_with_arg = idAuxInterpolTable2D(mCHE_with_arg, vNewArg1, vNewArg2, interpMeth);
new_mCVE_with_arg = idAuxInterpolTable2D(mCVE_with_arg, vNewArg1, vNewArg2, interpMeth);
new_mCHS_with_arg = idAuxInterpolTable2D(mCHS_with_arg, vNewArg1, vNewArg2, interpMeth);
new_mCVS_with_arg = idAuxInterpolTable2D(mCVS_with_arg, vNewArg1, vNewArg2, interpMeth);
