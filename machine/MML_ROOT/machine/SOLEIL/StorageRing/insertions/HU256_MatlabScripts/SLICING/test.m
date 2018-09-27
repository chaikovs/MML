


fL1=4;

d_L1_L2=0.7;

N=100;
for j=1:N
    fL2(j)=-5+0.1*j/N;
    feq(j)=fL1*fL2(j)/(fL1+fL2(j)-d_L1_L2);
end

figure(9);
plot(fL2,feq,'b');
