function [Ff]=Ff_f(zR)
global L
global nstep
  x=zeros(nstep,1);
  y=zeros(nstep,1);
for i=1:nstep
  x(i)=x(i)+L/nstep;
  y(i)=filling_f(x(i),zR);
end
Ff=y;