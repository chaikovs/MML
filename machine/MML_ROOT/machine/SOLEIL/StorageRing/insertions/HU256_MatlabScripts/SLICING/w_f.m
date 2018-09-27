function [w]=w_f(data,z,zR)
Lambda_L=data(1);
L=data(5);
w0=sqrt(Lambda_L*zR/pi);
  w=w0*sqrt(1+((z-L/2)/zR)^2);