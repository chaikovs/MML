% Beam based measurement of quadrupole centers

global THERING
rf0 = getrf
cspeed=299792458;
harm = 372;
rf = harm*cspeed/findspos(THERING,1+length(THERING))/1e6
steprf(rf-rf0);  %or setrf(rf)
%% plant in the error
iqf71 = family2atindex('QF',[7,1]);
dx = 0.00012;
dy = -0.00008;
THERING = setcellstruct(THERING,'T1',iqf71,dx,1,1);
THERING = setcellstruct(THERING,'T2',iqf71,-dx,1,1);
THERING = setcellstruct(THERING,'T1',iqf71,dy,1,3);
THERING = setcellstruct(THERING,'T2',iqf71,-dy,1,3);
%update plotfamily to see how the orbit has been changed

%% correct the orbit
setorbitdefault;
%update plotfamily

%% QMS
quadcenter('QF',[7,1],0)

%% check plot later
quadplot
%data saved to C:\USPAS\BBDaig\Release\machine\SPEAR3\StorageRingData\User\QMS


%% plant in the error
iqfc121 = family2atindex('QFC',[12,1]);
dx = -0.0001;
dy = -0.00006;
THERING = setcellstruct(THERING,'T1',iqfc121,dx,1,1);
THERING = setcellstruct(THERING,'T2',iqfc121,-dx,1,1);
THERING = setcellstruct(THERING,'T1',iqfc121,dy,1,3);
THERING = setcellstruct(THERING,'T2',iqfc121,-dy,1,3);
setorbitdefault;
setorbitdefault;

%% QMS
quadcenter('QFC',[12,1],0)
