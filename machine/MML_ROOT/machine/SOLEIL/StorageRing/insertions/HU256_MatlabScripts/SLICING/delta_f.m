function [delta]=delta_f(X)
global Q0
global Q0f
global d_ToT
global d_S_L1
fL1=X(1);
d_L1_L2=X(2);
fL2=X(3);
feq=fL1*fL2/(fL1+fL2-d_L1_L2);
M=transport_f(X);
A=M(1,1);
B=M(1,2);
C=M(2,1);
D=M(2,2);
invq0=1/Q0(1);
invqf=1/Q0f(1);
invq=(C+D*invq0)/(A+B*invq0);
delta_T=invqf-invq;
delta_R=real(delta_T);
delta_I=imag(delta_T);
delta_p=feq-6.4;
delta=[delta_R;delta_I;delta_p];


  
  