% Beam based measurement 
%STDR_good_017_064_r56_02_sx_Dff_BPM
global THERING
% rf0 = getrf
% cspeed=299792458;
% harm = 30;
% rf = harm*cspeed/findspos(THERING,1+length(THERING))/1e6
% steprf(rf-rf0);  %or setrf(rf)
%% BPM 1, 2

hcm = 1e-4;     
setsp('HCOR', hcm,[2 3]);

%% BPM 1,2 

vcm = -0.5e-4;     

stepsp('VCOR', vcm,[2 1]);


%%
BPMspos = getspos('BPMx',[1 1]);
QUADspos = getspos('QP1',[1 1]);
dist = abs(BPMspos-QUADspos)
getcircumference - dist


%% introduce the error
iqf7 = family2atindex('QP1',[1,1]);
dx = 100e-6;
dy = 50e-6;
setshift(iqf7, dx, dy)
 

%% correct the orbit
%setorbitdefault;
%update plotfamily

% Orbit correction
for k =1:3,
    setorbitH;
    setorbitV;
end

%% QMS
quadcenter('QP1',[1,1],0)
%quadcenter('QP2',[1,2],0)

%% check plot later
quadplot


%% introduce the error
iqf32 = family2atindex('QP4',[1,5]);
dx = 100e-6;
dy = 50e-6;
setshift(iqf32, dx, dy)

%% correct the orbit
%setorbitdefault;
%update plotfamily

% Orbit correction
for k =1:2,
    setorbitH;
    setorbitV;
end


%% QMS
quadcenter('QP4',[1,5],0)


%% introduce the error
iqf23 = family2atindex('QP41',[1,4]);
dx = 100e-6;
dy = 50e-6;
setshift(iqf23, dx, dy)

%% correct the orbit
%setorbitdefault;
%update plotfamily

% Orbit correction
for k =1:2,
    setorbitH;
    setorbitV;
end


%% QMS
%quadcenter('QP4',[1,5],0)
quadcenter('QP41',[1,4],0)


%% introduce the error
iqf34 = family2atindex('QP3',[1,6]);
dx = 100e-6;
dy = 50e-6;
setshift(iqf34, dx, dy)

%% correct the orbit
%setorbitdefault;
%update plotfamily

% Orbit correction
for k =1:3,
    setorbitH;
    setorbitV;
end



%% QMS
quadcenter('QP3',[1,6],0)
%quadcenter('QP41',[1,4],0)



%% introduce the error
iqf47 = family2atindex('QP3',[1,7]);
dx = 100e-6;
dy = 50e-6;
setshift(iqf47, dx, dy)

%% correct the orbit
%setorbitdefault;
%update plotfamily

% Orbit correction
for k =1:2,
    setorbitH;
    setorbitV;
end



%% QMS
quadcenter('QP3',[1,7],0)



%% QMS all together

quadcenter('QP1',[1,1],0)
quadcenter('QP2',[1,2],0)
quadcenter('QP4',[1,5],0)
quadcenter('QP41',[1,4],0)
quadcenter('QP3',[1,6],0)

%% Saving

figure(1010)
savefig('Figs/BPM3_QP3_1')

figure(1008)
savefig('Figs/BPM3_QP3_2')

figure(1011)
savefig('Figs/BPM3_QP3_3')

figure(1009)
savefig('Figs/BPM3_QP3_4')
