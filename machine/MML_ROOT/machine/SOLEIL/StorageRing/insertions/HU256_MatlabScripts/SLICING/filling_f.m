function [filling]=filling_f(data,z,zR)
  a=1+(w_f(data,z,zR)/(2*sigma_f(data,z,1)))^2;
  b=1+(w_f(data,z,zR)/(2*sigma_f(data,z,2)))^2;
  filling=1/(sqrt(a+b));
