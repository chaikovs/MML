
BPMListx=getlist('BPMx');
BPMListy=getlist('BPMz');
%% Save orbit to the file

[BPMx, BPMy, FileName] = getbpm('x', BPMListx, BPMListy, 'Archive')



%% Current orbit 


figure(20)
set(gca,'FontSize',16)
plot(getspos('BPMx'),getx, 'b.-')
hold on
plot(getspos('BPMz'),gety, 'r.-') %getz
hold off
xlabel('s (m)'); ylabel('x (mm)')
u = legend('BPMx','BPMz');


%% Offset orbit

ox = getphysdata('BPMx','Offset');
oz = getphysdata('BPMz','Offset');

figure(11)
set(gca,'FontSize',16)
plot(getspos('BPMx'),ox, 'b.-')
hold on
plot(getspos('BPMz'),oz, 'r.-')
hold off
xlabel('s (m)'); ylabel('x (mm)')
u = legend('BPMx Offset','BPMz Offset');


%% Golden orbit

gx = getphysdata('BPMx','Golden');
gz = getphysdata('BPMz','Golden');

figure(12)
set(gca,'FontSize',16)
plot(getspos('BPMx'),gx, 'b.-')
hold on
plot(getspos('BPMz'),gz, 'r.-')
hold off
xlabel('s (m)'); ylabel('x (mm)')
u = legend('BPMx Golden','BPMz Golden');

%% Set the offset orbit

setfamilydata(gety, 'BPMz', 'Offset' )%getz
setfamilydata(getx, 'BPMx', 'Offset')

%% Set the offset orbit

setphysdata('BPMx','Offset',getx('Struct'));
setphysdata('BPMz','Offset',gety('Struct')); %getz

%% Set the golden orbit

setphysdata('BPMx','Golden',getx('Struct'));
setphysdata('BPMz','Golden',gety('Struct')); %getz


%% Set the golden orbit

setfamilydata(gety, 'BPMz', 'Golden') %getz
setfamilydata(getx, 'BPMx', 'Golden')

%%

getfamilydata('VCOR')
%%

getfamilydata('VCORT','Monitor','Units')

%%

k = amp2k('HCORT', 'Setpoint', Amps, DeviceList, Energy, C, K2AmpScaleFactor)
%%
ao = getao;
ao.VCOR.Voltage

% vc = ao.VCOR.Units
% vc.Units
%%
%setsp('VCM',0.00001, [5 1]);
getfamilydata('HCOR','Status')
%% Quad missalignment


%%
 getlist('QP3')

 QP1INDEX = findcells(THERING,'FamName','QP1')
 QP2INDEX = findcells(THERING,'FamName','QP2')
 QP4INDEX = findcells(THERING,'FamName','QP4')
 
 %%
 
%quadalign(10e-6,20e-6);

setshift(QP1INDEX(3), 20e-6, 10e-6)
%setshift(QP1INDEX(4), 5e-6, 10e-6)
setshift(QP2INDEX(1), 50e-6, 10e-6)
%setshift(QP2INDEX(3), 20e-6, 25e-6)
setshift(QP4INDEX(1), 10e-6, 20e-6)
%setshift(QP4INDEX(2), 10e-6, 15e-6)


THERING{158}
% addxrot
% addyrot
% addsrot

%%

setshift(QP1INDEX(4), 5e-6, 10e-6)
setshift(QP2INDEX(3), 20e-6, 25e-6)
setshift(QP4INDEX(2), 10e-6, 15e-6)



%%   Put in a vertical orbit distortion 
 
% Create an Orbit Error
vcm = .00005 * randn(12,1);  % 
setsp('VCOR', vcm);

%% remove vertical distortion
% vcmzero = zeros(12,1);
% setsp('VCOR', vcm);

%% remove vertical distortion

setsp('VCOR', -vcm); 
%stepsp('VCOR', -DeltaAmps);


%% correct the rf frequency

cspeed = 2.99792458e8;
harm = 28;
rf0 = getrf

rf = harm*cspeed/findspos(THERING,1+length(THERING))/1e6

%%
steprf(rf-rf0);  %or setrf(rf)
%%
steprf(0.03, 'MHz');  %or setrf(rf)



%%