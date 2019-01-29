function ElecBeamStructure = HU256_MeasElecBeam(inclPerturbMeas, dispData, fileNameCore)

global HU256CELL;
global TESTWITHOUTPS;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HU256CELL=12;
% TESTWITHOUTPS=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    idDevServ=['ans-c' num2str(HU256CELL, '%02.0f') '/ei/m-hu256.2_'];
    % Pause duration between eventual measurements of the dispersion functions and chromatisities:
    %if (TESTWITHOUTPS~=1)
        pauseTime_s = 2;
    %end
    
    ElecBeamStructure.CorrectlyFinished=-1;

    % H orbit
    try
        ElecBeamStructure.X = getx;
    catch
        disp('Warning H !!!!!!!!!!');
        pause(0.5);
        try
            ElecBeamStructure.X = getx;
        catch
            tango_error
            ElecBeamStructure.X = 0;
            disp('PROBLEM IMMER NOCH')
            pause
        end
    end
    
    % V orbit
    try
        ElecBeamStructure.Z = getz;
    catch
        disp('Warning V !!!!!!!!!!');
        pause(0.5);
        try
            ElecBeamStructure.Z = getz;
        catch            
            tango_error
            ElecBeamStructure.Z = 0;
            disp('PROBLEM IMMER NOCH')
            pause
        end
    end
    
    % Stored electron beam current
    ElecBeamStructure.current = getdcct;
    % Tunes
    ElecBeamStructure.tune = gettune;
    % Beam lifetime
    
%     2 Bottom lines taken out on 28/05/2007 : wrong attribute!
%     temp = tango_read_attribute2('ANS/DG/PUB-LifeTime','double_scalar')
%     ElecBeamStructure.tau = temp.value(1);

    if inclPerturbMeas ~= 0
        % Measure dispersion functions. ATTENTION, it perturbes e-beam !
        [dx dz] = measdisp('Physics');
        ElecBeamStructure.dx = dx;
        ElecBeamStructure.dz = dz;
        %ElecBeamStructure,
        pause(pauseTime_s);

        % Measure chromaticities. ATTENTION, it perturbes e-beam !
        ElecBeamStructure.ksi = measchro('Physics');
    else
        ElecBeamStructure.dx = 0;
        ElecBeamStructure.dz = 0;
        ElecBeamStructure.ksi = [0, 0];
    end

    ElecBeamStructure.date = datestr(now); % convert date to string
%     ElecBeamStructure = ElecBeamStructure;



    %temp = tango_read_attribute2('TDL-I08-M/VI/JBA.1','pressure');
    %ElecBeamStructure.pres = temp.value(1);
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
        fprintf('I = %6.2f mA\t\tnux = %7.5f\t\tnuz = %7.5f\n', ElecBeamStructure.current, ElecBeamStructure.tune(1), ElecBeamStructure.tune(2))
        %fprintf('ksix = %f\n', ElecBeamStructure.ksi(1))
        %fprintf('ksiz = %f\n', ElecBeamStructure.ksi(2))
        %Tau=  ElecBeamStructure.tau
        fprintf('BZP = %07.3f A (%s)\tBX1 = %07.3f A (%s)\tBX2 = %07.3f A (%s)\n', CurrentBZP, StateBZP, CurrentBX1, StateBX1, CurrentBX2, StateBX2)
        fprintf('CVE = %07.3f A (%s)\tCHE = %07.3f A (%s)\n', CurrentBxc1, StateBxc, CurrentBzc1, StateBzc)
        fprintf('CVS = %07.3f A (%s)\tCHS = %07.3f A (%s)\n', CurrentBxc28, StateBxc, CurrentBzc27, StateBzc)
    end

    % Save the structure into a file, if necessary
    %if saveRes ~= 0
    if strcmp(fileNameCore, '') == 0

        FileName = appendtimestamp(fileNameCore);
%         FileName=['FileName' '.mat'];
        %FileName = ['/home/matlabML/measdata/Ringdata/insertions/HU256_CASSIOPEE/SESSION_2006_10_13/', FileName];
        %FileName = ['/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2006_12_5/', FileName];
        %FileName = ['/home/operateur/GrpGMI/HU256_CASSIOPEE/SESSION_2006_12_08/', FileName];

        if (TESTWITHOUTPS~=1)
            ElecBeamStructure.name=FileName;
            save(FileName,'-struct', 'ElecBeamStructure');
            fprintf('Electron Beam Measurement Structure saved in :\n%s.mat\n\n', FileName)
        else
            fprintf('Acquisition would have been saved in : %s\n', FileName)
        end
    end
end

% ElecBeamStructure.CorrectlyFinished=-1;