function Test_RF()
f0=getrf();
IPS2=440; 
IPS3=360; 
N=40;
AlphaPS2=2.4841e-4;
AlphaPS3=2.9748e-4;
fprintf('%s\t %14.8f\n','Fréquence',f0);
fprintf('%s\t %s\t %s\t %s\n','Courant PS2','Courant PS2','RF','DeltaRF');
for i=0:1:N 
NewRF=f0-275.95e-6*((AlphaPS2*i*IPS2/N)^2+(AlphaPS3*i*IPS3/N)^2);
DeltaRF=-275.95e-6*((AlphaPS2*IPS2/N)^2+(AlphaPS3*IPS3/N)^2)*(2*i-1);
if i==0
    DeltaRF=0;
end
fprintf('%8.4f\t %8.4f\t %15.9f\t %15.9f\n',i*IPS2/N, i*IPS3/N, NewRF,DeltaRF);
end
for i=N:-1:0 
NewRF=f0-275.95e-6*((AlphaPS2*i*IPS2/N)^2+(AlphaPS3*i*IPS3/N)^2);
DeltaRF=-275.95e-6*((AlphaPS2*IPS2/N)^2+(AlphaPS3*IPS3/N)^2)*(-2*i-1);
fprintf('%8.4f\t %8.4f\t %15.9f\t %15.9f\n',i*IPS2/N, i*IPS3/N, NewRF,DeltaRF);
end