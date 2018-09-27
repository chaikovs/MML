function outStructElecBeam = HU256_MeasElecBeam(inclPerturbMeas, dispData, fileNameCore)

global HU256CELL;
%HU256CELL=15;

idDevServ=['ans-c' num2str(HU256CELL, '%02.0f') '/ei/m-hu256.2_'];
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
% temp = tango_read_attribute2('ANS/DG/PUB-LifeTime','double_scalar');
% inStructElecBeam.tau = temp.value(1);

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



%temp = tango_read_attribute2('TDL-I08-M/VI/JBA.1','pressure');
%inStructElecBeam.pres = temp.value(1);
CurrentBZP=readattribute([idDevServ 'bzp/current']);
CurrentBX1=readattribute([idDevServ 'bx1/current']);
CurrentBX2=readattribute([idDevServ 'bx2/current']);
StateBZP=tango_command_inout2([idDevServ 'bzp'], 'State');
StateBX1=tango_command_inout2([idDevServ 'bx1'], 'State');
StateBX2=tango_command_inout2([idDevServ 'bx2'], 'State');

CurrentBzc1=readattribute([idDevServ 'shim.1/current1']);
CurrentBzc27=readattribute([idDevServ 'shim.1/current4']);
CurrentBxc1=readattribute([idDevServ 'shim.2/current1']);
CurrentBxc28=readattribute([idDevServ 'shim.2/current4']);
StateBzc=tango_command_inout2([idDevServ 'shim.1'], 'State');
StateBxc=tango_command_inout2([idDevServ 'shim.2'], 'State');

fprintf('\n')
if dispData ~= 0
	
    fprintf('I = %6.2f mA\t\tnux = %7.5f\t\tnuz = %7.5f\n', outStructElecBeam.current, outStructElecBeam.tune(1), outStructElecBeam.tune(2))
    %fprintf('%07.3f\t%7.5f\t%7.5f\n', CurrentBZP, outStructElecBeam.tune(1), outStructElecBeam.tune(2))
    fprintf('ksix = %f\n', outStructElecBeam.ksi(1))
    fprintf('ksiz = %f\n', outStructElecBeam.ksi(2))
%     Tau=  outStructElecBeam.tau
    fprintf('BZP = %07.3f A (%s)\tBX1 = %07.3f A (%s)\tBX2 = %07.3f A (%s)\n', CurrentBZP, StateBZP, CurrentBX1, StateBX1, CurrentBX2, StateBX2)
    fprintf('CVE = %07.3f A (%s)\tCHE = %07.3f A (%s)\n', CurrentBxc1, StateBxc, CurrentBzc1, StateBzc)
    fprintf('CVS = %07.3f A (%s)\tCHS = %07.3f A (%s)\n', CurrentBxc28, StateBxc, CurrentBzc27, StateBzc)
end

% Save the structure into a file, if necessary
%if saveRes ~= 0
if strcmp(fileNameCore, '') == 0
   
	FileName = appendtimestamp(fileNameCore);
    %FileName = ['/home/matlabML/measdata/Ringdata/insertions/HU256_CASSIOPEE/SESSION_2006_10_13/', FileName];
	%FileName = ['/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2006_12_5/', FileName];
	%FileName = ['/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2006_12_08/', FileName];
%     FileName = ['/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2006_12_08/', FileName];
    %FileName = ['/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2007_05_27/Bumps_Ix_fct_x' filesep FileName];
    
    save(FileName,'-struct', 'outStructElecBeam');
    fprintf('Electron Beam Measurement Structure saved in :\n%s.mat\n\n', FileName)
    outStructElecBeam.name=FileName;
end
