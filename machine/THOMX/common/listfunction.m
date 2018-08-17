
return;

%% Functions

setpaththomx % initialize the MML
getall  % show the curresnt settings

thomxorbit

%% AO manipulation
%Accelerator Object
showfamily('BPMx') % show the object
%getfamilytype
getao
setao
getad
setad

%% Load the model

switch2online
switch2sim
switch2physics
switch2hw

% Configuration
getmachineconfig
setmachineconfig
sim2machine
golden2sim

%tune
tune2sim
tune2online
tune2manual
gettune
settune

%RF
setrf
getrf
sweepenergy


physics2hw
hw2physics
amp2k
k2amp
gev2bend  % beam energy to bend current

%getbpmnames

getfamilylist
getlist  % Device List for a family

getphysdata
setphysdata

family2dev
getfamilydata

%measurements
measbpmresp
measbpmsigma
measdisp
measdispresp
measchro
measchroresp
measlifetime
measrate
measrespmat
meastuneresp

%%% BPM 
getx % get H bpms
getz % get V bpms
thomxbpms
getxthomx
getzthomx
getbpmthomx

checklimits

%% Ring

getenergy % get energy
getbrho %get brho
bend2gev



% transformation
tango2dev
tango2common
tango2family

magnetcoeeficients


makephysdata % modifier chro et tune

%% GUI ou IHM

srsetup
plotfamily
thomxrbit
configgui

%%% matlab function
xaxis
xaxiss
yaxis
yaxiss
sleep
popplot
appendtimestamp
gotodirectory
