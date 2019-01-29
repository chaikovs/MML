function [M]=transport1_f(X)
global d_ToT
fL1=X;

d_L2_C=fL1;
d_S_L1=d_ToT-d_L2_C;
M=drift_f(d_L2_C)*lens_f(fL1)*drift_f(d_S_L1);
end