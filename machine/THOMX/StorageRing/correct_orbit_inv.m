%%
r=measbpmresp('Model');
S=inv(r);
%%
setpv('HCOR',0)
setpv('VCOR',0)
%%
seterror(15E-6, 15E-6)
%%
x=getx;
y=gety;
orbit=[x',y']';
disp 'Orbit before correction'
fprintf (1,'Horizontal= %f um\n', std(getx)*1E6)
fprintf (1,'Vertical= %f um\n\n', std(gety)*1E6)
CorrectorShift=S*orbit;
cv=-CorrectorShift(13:24)+getpv('VCOR');
ch=-CorrectorShift(1:12)+getpv('HCOR');
setpv('VCOR', cv);
setpv('HCOR', ch);
disp 'Orbit after correction'
fprintf (1,'Horizontal= %f um\n', std(getx)*1E6)
fprintf (1,'Vertical= %f um\n\n', std(gety)*1E6)
disp 'rms values of the correctors'
fprintf (1,'Horizontal= %f urad\n', std(getpv('HCOR'))*1E6)
fprintf (1,'Vertical= %f urad\n\n', std(getpv('VCOR'))*1E6)
%%
rx=r(1:12,1:12);
ry=r(13:24, 13:24);
Sx=inv(rx);
Sy=inv(ry);
%%
disp 'Orbit before correction'
fprintf (1,'Horizontal= %f um\n', std(getx)*1E6)
fprintf (1,'Vertical= %f um\n\n', std(gety)*1E6)
for i=1:3,
    x=getx;
    y=gety;
    CorrectorShiftV=Sy*y;
    CorrectorShiftH=Sy*x;
    cv=-CorrectorShiftV(1:12)+getpv('VCOR');
    ch=-CorrectorShiftH(1:12)+getpv('HCOR');
    setpv('VCOR', cv);
    setpv('HCOR', ch);
    fprintf(1, 'Orbit after step %ld\n',i)
    fprintf (1,'Horizontal= %f um\n', std(getx)*1E6)
    fprintf (1,'Vertical= %f um\n\n', std(gety)*1E6)
    disp 'rms values of the correctors'
    fprintf (1,'Horizontal= %f urad\n', std(getpv('HCOR'))*1E6)
    fprintf (1,'Vertical= %f urad\n\n', std(getpv('VCOR'))*1E6)
end