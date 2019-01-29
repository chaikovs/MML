function outStructElecBeam = HU640_MeasElecBeam(inclPerturbMeas, dispData, fileNameCore)

% fileNameCore includes the path!!!

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



%temp = tango_read_attribute2('TDL-I08-M/VI/JBA.1','pressure');
%inStructElecBeam.pres = temp.value(1);
CurrentPS1=readattribute('ans-c05/ei/l-hu640_ps1/current');
CurrentPS2=readattribute('ans-c05/ei/l-hu640_ps2/current');
CurrentPS3=readattribute('ans-c05/ei/l-hu640_ps3/current');
StatePS1=tango_command_inout2('ans-c05/ei/l-hu640_ps1', 'State');
StatePS2=tango_command_inout2('ans-c05/ei/l-hu640_ps2', 'State');
StatePS3=tango_command_inout2('ans-c05/ei/l-hu640_ps3', 'State');

CurrentCVE=readattribute('ans-c05/ei/l-hu640_Corr4/current');
CurrentCVS=readattribute('ans-c05/ei/l-hu640_Corr3/current');
CurrentCHE=readattribute('ans-c05/ei/l-hu640_Corr2/current');
CurrentCHS=readattribute('ans-c05/ei/l-hu640_Corr1/current');

StateCVE=tango_command_inout2('ans-c05/ei/l-hu640_Corr4', 'State');
StateCVS=tango_command_inout2('ans-c05/ei/l-hu640_Corr3', 'State');
StateCHE=tango_command_inout2('ans-c05/ei/l-hu640_Corr2', 'State');
StateCHS=tango_command_inout2('ans-c05/ei/l-hu640_Corr1', 'State');

fprintf('\n')
if dispData ~= 0
	fprintf('I = %6.2f mA\t\tnux = %7.5f\t\tnuz = %7.5f\n', outStructElecBeam.current, outStructElecBeam.tune(1), outStructElecBeam.tune(2))
    %fprintf('ksix = %f\n', outStructElecBeam.ksi(1))
    %fprintf('ksiz = %f\n', outStructElecBeam.ksi(2))
    %Tau=  outStructElecBeam.tau
    fprintf('PS1 = %07.3f A (%s)\tPS2 = %07.3f A (%s)\tPS3 = %07.3f A (%s)\n', CurrentPS1, StatePS1, CurrentPS2, StatePS2, CurrentPS3, StatePS3)
    fprintf('CHE = %07.3f A (%s)\tCVE = %07.3f A (%s)\n', CurrentCHE, StateCHE, CurrentCVE, StateCVE)
    fprintf('CHS = %07.3f A (%s)\tCVS = %07.3f A (%s)\n', CurrentCHS, StateCHS, CurrentCVS, StateCVS)
end

% Save the structure into a file, if necessary
%if saveRes ~= 0
if strcmp(fileNameCore, '') == 0
   
	FileName = fileNameCore;
    %FileName = appendtimestamp(fileNameCore);
    
    save(FileName,'-struct', 'outStructElecBeam');
    fprintf('Electron Beam Measurement Structure saved in :\n%s.mat\n\n', FileName)
    outStructElecBeam.name=FileName;
end
