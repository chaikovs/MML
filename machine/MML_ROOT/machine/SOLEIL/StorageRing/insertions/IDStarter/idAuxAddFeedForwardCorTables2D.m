function [res_mCHE_with_arg, res_mCVE_with_arg, res_mCHS_with_arg, res_mCVS_with_arg] = idAuxAddFeedForwardCorTables2D(mCHE_with_arg, mCVE_with_arg, mCHS_with_arg, mCVS_with_arg, mCHE_add_with_arg, mCVE_add_with_arg, mCHS_add_with_arg, mCVS_add_with_arg)

res_mCHE_with_arg = idAuxAddTable2D(mCHE_with_arg, mCHE_add_with_arg);
res_mCVE_with_arg = idAuxAddTable2D(mCVE_with_arg, mCVE_add_with_arg);
res_mCHS_with_arg = idAuxAddTable2D(mCHS_with_arg, mCHS_add_with_arg);
res_mCVS_with_arg = idAuxAddTable2D(mCVS_with_arg, mCVS_add_with_arg);
