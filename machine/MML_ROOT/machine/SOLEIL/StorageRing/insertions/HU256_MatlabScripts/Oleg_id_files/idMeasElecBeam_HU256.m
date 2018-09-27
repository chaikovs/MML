function outStructElecBeam = idMeasElecBeam_HU256(inclPerturbMeas, dispData, fileNameCore)

% Pause duration between eventual measurements of the dispersion functions and chromatisities:
pauseTime_s = 5;

% H orbit
inStructElecBeam.X = getx;
% V orbit
inStructElecBeam.Z = getz;
% Stored electron beam current
inStructElecBeam.current = getdcct;
% Tunes
inStructElecBeam.tune = gettune;
% Beam lifetime
temp = tango_read_attribute2('ANS/DG/PUB-LifeTime','double_scalar');
inStructElecBeam.tau = temp.value(1);

if inclPerturbMeas ~= 0
	% Measure dispersion functions. ATTENTION, it perturbes e-beam !
	[dx dz] = measdisp('Physics');
	inStructElecBeam.dx = dx;
	inStructElecBeam.dz = dz;
    %inStructElecBeam,
    pause(pauseTime_s);

	% Measure chromaticities. ATTENTION, it perturbes e-beam !
	inStructElecBeam.ksi = measchro('Physics');
else
	inStructElecBeam.dx = 0;
	inStructElecBeam.dz = 0;
    inStructElecBeam.ksi = [0, 0];
end

inStructElecBeam.date = datestr(now); % convert date to string
outStructElecBeam = inStructElecBeam;

if dispData ~= 0
	fprintf('I = %f\n', outStructElecBeam.current);
    fprintf('Tau = %f\n', outStructElecBeam.tau);
    %fprintf('P=%d\n',pres)
    fprintf('nux = %f\n', outStructElecBeam.tune(1))
    fprintf('nuz = %f\n', outStructElecBeam.tune(2))
    %fprintf('ksix = %f\n', outStructElecBeam.ksi(1))
    %fprintf('ksiz = %f\n', outStructElecBeam.ksi(2))
end

%temp = tango_read_attribute2('TDL-I08-M/VI/JBA.1','pressure');
%inStructElecBeam.pres = temp.value(1);
CurrentBZP=readattribute('ans-c15/ei/m-hu256.2-bzp/current');
CurrentBX1=readattribute('ans-c15/ei/m-hu256.2-bx1/current');
CurrentBX2=readattribute('ans-c15/ei/m-hu256.2-bx2/current');
StateBZP=tango_command_inout2('ans-c15/ei/m-hu256.2-bzp', 'State');
StateBX1=tango_command_inout2('ans-c15/ei/m-hu256.2-bx1', 'State');
StateBX2=tango_command_inout2('ans-c15/ei/m-hu256.2-bx2', 'State');

fprintf('BZP = %f A (%s)\n', CurrentBZP, StateBZP)
fprintf('BX1 = %f A (%s)\n', CurrentBX1, StateBX1)
fprintf('BX2 = %f A (%s)\n', CurrentBX2, StateBX2)
%fprintf('GAP=%f\n',gap)
%fprintf('PHASE=%f\n',Phase)
%fprintf('I=%f\n',inStructElecBeam.current)
%fprintf('Tau=%f\n',tau)
%fprintf('P=%d\n',pres)
%fprintf('nux= %f\n',inStructElecBeam.tune(1))
%fprintf('nuz= %f\n',inStructElecBeam.tune(2))
%fprintf('ksix= %f\n',inStructElecBeam.ksi(1))
%fprintf('ksiz= %f\n',inStructElecBeam.ksi(2))
%fprintf('Sauvegarde  %s\n',FileName)

% Save the structure into a file, if necessary
%if saveRes ~= 0
if strcmp(fileNameCore, '') == 0
   
	FileName = appendtimestamp(fileNameCore);
    FileName = ['/home/matlabML/measdata/Ringdata/insertions/HU256_CASSIOPEE/SESSION_2006_10_13/', FileName];
	save(FileName,'-struct', 'outStructElecBeam');
    fprintf('Sauvegarde dans %s\n',FileName)
end

%temp=tango_read_attribute2('ANS-C08/EI/M-HU80.2','gap');
%gap=temp.value(1)/1.e4;
