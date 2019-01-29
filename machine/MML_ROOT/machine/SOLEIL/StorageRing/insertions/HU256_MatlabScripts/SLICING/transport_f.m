function [M]=transport_f(X)
global d_ToT
global d_S_L1
fL1=X(1);
d_L1_L2=X(2);
fL2=X(3);
%d_S_L1=X(4);
feq=fL1*fL2/(fL1+fL2-d_L1_L2);

d_L2_C=d_ToT-d_L1_L2-d_S_L1;


M=drift_f(d_L2_C)*lens_f(fL2)*drift_f(d_L1_L2)*lens_f(fL1)*drift_f(d_S_L1);
%M=drift_f(d_L2_C)*lens_f(fL1)*drift_f(d_S_L1);
end