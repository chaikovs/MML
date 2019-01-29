function [filling_int]=filling_int_f(data,zR)
nstep_int=1000;
L=data(5);
dx=L/nstep_int;
for i=1:nstep_int
    x(i)=i*L/nstep_int;
    F(i)=filling_f(data,x(i),zR);
end
filling_int=0;
for i=1:nstep_int-1
    filling_int=filling_int+(F(i)+F(i+1))/2*dx;
end
