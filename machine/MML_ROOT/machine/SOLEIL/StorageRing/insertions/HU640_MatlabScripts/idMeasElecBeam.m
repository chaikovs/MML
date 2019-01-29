function outStructElecBeam = idMeasElecBeam(inStructElecBeam, inclPerturbMeas, dispData) %, fileNameCore)

% Pause duration between eventual measurements of the dispersion functions and chromatisities:
%pauseTime_s = 5;

% H orbit
inStructElecBeam.X = getx;
% V orbit
inStructElecBeam.Z = getz;
% Stored electron beam current
inStructElecBeam.current = getdcct;
% Tunes
%inStructElecBeam.tune = gettune;
% Beam lifetime
%temp = tango_read_attribute2('ANS/DG/PUB-LifeTime','double_scalar');
%inStructElecBeam.tau = temp.value(1);

if inclPerturbMeas ~= 0
	% Measure dispersion functions. ATTENTION, it perturbes e-beam !
	%[dx dz] = measdisp('Physics');
    dx=ones(120,1)*0;dz=ones(120,1)*0;
	inStructElecBeam.dx = dx;
	inStructElecBeam.dz = dz;
    %inStructElecBeam,
    pause(pauseTime_s);

	% Measure chromaticities. ATTENTION, it perturbes e-beam !
	%inStructElecBeam.ksi = measchro('Physics');
else
	%inStructElecBeam.dx = 0;
	%inStructElecBeam.dz = 0;
    %inStructElecBeam.ksi = [0, 0];
end

%inStructElecBeam.date = datestr(now); % convert date to string
outStructElecBeam = inStructElecBeam;

%if dispData ~= 0
    %fprintf('%s\n','*****************************************')
	%fprintf('Courant Anneau = %f\n', outStructElecBeam.current);
    %fprintf('Durée de vie = %f\n', outStructElecBeam.tau);
    %fprintf('P=%d\n',pres)
    %fprintf('nux = %f\t', outStructElecBeam.tune(1))
    %fprintf('nuz = %f\n', outStructElecBeam.tune(2))
    %fprintf('ksix = %f\t', outStructElecBeam.ksi(1))
    %fprintf('ksiz = %f\n', outStructElecBeam.ksi(2))
    %fprintf('%s\n','*****************************************')
%end

%temp = tango_read_attribute2('TDL-I08-M/VI/JBA.1','pressure');
%inStructElecBeam.pres = temp.value(1);

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
%if strcmp(fileNameCore, '') == 0
%    %idSaveStruct(structNameToSave, fileNameCore, idName)
%    %idSaveStruct(structNameToSave, 'HU80_TEMPO', 'HU80')
%    
%	FileName = appendtimestamp(fileNameCore);
%	DirectoryName = getfamilydata('Directory','HU80_TEMPO');
%	DirStart = pwd;
%	[DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
%	save(FileName,'-struct', 'outStructElecBeam');
%    %save(FileName, inStructElecBeam);
%	cd(DirStart);
%end

%temp=tango_read_attribute2('ANS-C08/EI/M-HU80.2','gap');
%gap=temp.value(1)/1.e4;
