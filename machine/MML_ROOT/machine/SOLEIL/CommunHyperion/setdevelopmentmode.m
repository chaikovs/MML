function setdevelopmentmode(ModeNumber)
%SETDEVELOPsMENT - Switches between the various operational modes
%  setoperationalmode(ModeNumber) - Dedeciated for development on Hyperion
%  without mixing with operationmode (Controlroom) 
%
%  INPUTS
%  1. ModeNumber = number
%        1 '2.7391 GeV, 18.2020 10.3170', ...
%        2 '2.7391 GeV, 18.20 10.30', ...
%        3 '2.7391 GeV, Chasmann-Green', ...
%        4 '2.7391 GeV, Low Alpha nominal alpha1/15 December 2007', ...
%        5 '2.7391 GeV, alpha1/20 alpha1by20_maher',...
%        6 '2.7391 GeV, HU640', ...
%        7 '2.7391 GeV, low alpha1/20  20.3 8.4 December 2008', ...
%        8 '2.7391 GeV, 18.2020 10.3170 w/ new steerer position', ...
%        9 '2.7391 GeV, 18.2020 10.3170 w/ new steerer position and new quad model', ...
%        10 '2.7391 GeV, 18.2020 10.3170 w/ PX2 w/ new steerer position and new quad model', ...
%        11 '2.7391 GeV, 18.217 10.312 w/ PX2 w/ new steerer position and new quad model, with Nanoscopium', ...
%        12/ 2.7391 GeV, low alpha_nominal/10  20.3 8.4 December 2008/January 2010', ...
%        13/ 2.7391 GeV, low alpha1_nominal/100  20.3 8.4 December 2008/January 2010', ...
%        14/ 2.7391 GeV, 17.80 10.70 Nanoscopium w/ PX2 with new steerer position and new quad model', ...
%        15/ 2.7391 GeV, 18.20 10.70 Nanoscopium w/ PX2 with new steerer position and new quad model', ...
%        16/ 2.7391 GeV, 18.2020 10.3170 w/ betax=5 m new steerer position and new quad model', ...
%        17/ 2.7391 GeV, 18.2000 10.6400  Nanoscopium', ...
%        18/ 2.7391 GeV, 18.2000 10.3000 w/ betax=5 m Nanoscopium', ...
%        19/ 2.7391 GeV, 18.2020 10.3170 w/ S11 new steerer position and new quad model', ...
%        20/ 2.7391 GeV, 18.2020 10.3170 w/ S11 betax=5 m new steerer position and new quad model', ...
%        21/ 2.7391 GeV, 18.1700 10.2500 S11 betax=5 m Nanoscopium', ...
%        22/ 2.7391 GeV, low alpha_nominal/10 AMOR 20.77 9.20 December 2010', ...
%        23/ 2.7391 GeV, 18.2020 10.3170 w/ S11 new nominal 122 BPMs'...
%        24/ 2.7391 GeV, nanoscopium 122 BPMs'...
%        100 'Laurent''s Mode'...
%
%  See also aoinit, updateatindex, soleilinit, setmmldirectories, lattice_prep

%  NOTES
% use local_set_config_mode for defineing statatus of S11 et S12;


%
% Written by Laurent S. Nadolski

global THERING

% Check if the AO exists
checkforao;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Accelerator Dependent Modes %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin < 1
    ModeNumber = [];
end
if isempty(ModeNumber)
    ModeCell = {...
        '1/ 2.7391 GeV, 18.2020 10.3170', ...
        '2/ 2.7391 GeV, 18.20 10.30', ...
        '3/ 2.7391 GeV, Chasmann-Green', ...
        '4/ 2.7391 GeV, Low Alpha nominal alpha1/15 December 2007', ...
        '5/ 2.7391 GeV, alpha1/20 alpha1by20_maher',...
        '6/ 2.7391 GeV, HU640', ...
        '7/ 2.7391 GeV, low alpha_nominal/20  20.3 8.4 December 2008/January 2010', ...
        '8/ 2.7391 GeV, 18.2020 10.3170 with new steerer position', ...
        '9/ 2.7391 GeV, 18.2020 10.3170 with new steerer position and new quad model', ...
        '10/ 2.7391 GeV, 18.2020 10.3170 w/ PX2 with new steerer position and new quad model', ...
        '11/ 2.7391 GeV, 18.217 10.312 Nanoscopium w/ PX2 with new steerer position and new quad model', ...
        '12/ 2.7391 GeV, low alpha_nominal/10  20.3 8.4 December 2008/January 2010', ...
        '13/ 2.7391 GeV, low alpha1_nominal/100  20.3 8.4 December 2008/January 2010', ...
        '14/ 2.7391 GeV, 17.80 10.70 Nanoscopium w/ PX2 with new steerer position and new quad model', ...
        '15/ 2.7391 GeV, 18.20 10.70 Nanoscopium w/ PX2 with new steerer position and new quad model', ...
        '16/ 2.7391 GeV, 18.2020 10.3170 with betax=5m with new steerer position and new quad model', ...
        '17/ 2.7391 GeV, 18.2000 10.6400  Nanoscopium', ...
        '18/ 2.7391 GeV, 18.2000 10.3000 betax=5 m Nanoscopium', ...
        '19/ 2.7391 GeV, 18.2020 10.3170 w/ S11 new steerer position and new quad model', ...
        '20/ 2.7391 GeV, TO DO 18.2020 10.3170 w/ S11 betax=5 m new steerer position and new quad model', ...
        '21/ 2.7391 GeV, 18.1700 10.2500 S11 betax=5 m Nanoscopium', ...
        '22/ 2.7391 GeV, low alpha_nominal/10 AMOR 20.77 9.20 December 2010', ...
        '23/ 2.7391 GeV, 18.2020 10.3170 w/ S11 new nominal 122 BPMs'...
        '24/ 2.7391 GeV, nanoscopium 122 BPMs'...
        'Laurent''s Mode'...
        };
    [ModeNumber, OKFlag] = listdlg('Name','SOLEIL','PromptString','Select the Development Mode: (LOCAL DEVELOPMENT)', ...
        'SelectionMode','single', 'ListString', ModeCell, 'ListSize', [450 200], 'InitialValue', 16);
    if OKFlag ~= 1
        fprintf('   Operational mode not changed\n');
        return
    elseif ModeNumber == length(ModeCell);
        ModeNumber = 100;  % Laurent
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Accelerator Data Structure %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AD = getad;
AD.Machine = 'SOLEIL';            % Will already be defined if setpathmml was used
AD.MachineType = 'StorageRing';   % Will already be defined if setpathmml was used
AD.SubMachine  = 'StorageRing';   % Will already be defined if setpathmml was used
AD.OperationalMode = '';          % Gets filled in later
AD.HarmonicNumber = 416;

% Defaults RF for dispersion and chromaticity measurements (must be in Hardware units)
AD.DeltaRFDisp = 100e-6;
AD.DeltaRFChro = [-100 -50 0 50 100] * 1e-6;

% Tune processor delay: delay required to wait
% to have a fresh tune measurement after changing
% a variable like the RF frequency.  Setpv will wait
% 2.2 * TuneDelay to be guaranteed a fresh data point.
%AD.BPMDelay  = 0.25; % use [N, BPMDelay]=getbpmaverages (AD.BPMDelay will disappear)
AD.TuneDelay = 1;

% The offset and golden orbits are stored at the end of this file
% TODO
%BuildOffsetAndGoldenOrbits;  % Local function


% SP-AM Error level
% AD.ErrorWarningLevel = 0 -> SP-AM errors are Matlab errors {Default}
%                       -1 -> SP-AM errors are Matlab warnings
%                       -2 -> SP-AM errors prompt a dialog box
%                       -3 -> SP-AM errors are ignored (ErrorFlag=-1 is returned)
AD.ErrorWarningLevel = 0;

%%%%%%%%%%%%%%%%%%%%%
% Operational Modes %
%%%%%%%%%%%%%%%%%%%%%

% Mode setup variables (mostly path and file names)
% AD.OperationalMode - String used in titles
% ModeName - String used for mode directory name off DataRoot/MachineName
% OpsFileExtension - string add to default file names

%% ModeNumber == 9 bx=10m nominal lattice 2010 until installation of S11 and S12
if ModeNumber == 9
    % User mode - nominal lattice 2010 until installation of S11 and S12
    AD.OperationalMode = '2.7391 GeV, 18.2 10.3';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'lat_2020_3170b';
    OpsFileExtension = '_lat_2020_3170b';

    % AT lattice
    AD.ATModel = 'lat_2020_3170b';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 18.2020 / 10.3170
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.2020
        0.3170
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    % Status factory
    local_set_config_mode('normalconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
    setao(AO);

    %% ModeNumber == 19 User mode - S11 betax=10m till November 2010
elseif ModeNumber == 19 
    % User mode - S11 betax=10m 2010
    AD.OperationalMode = '2.7391 GeV, 18.202 10.317 S11';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'lat_2020_3170f';
    OpsFileExtension = '_lat_2020_3170f';

    % AT lattice
    AD.ATModel = 'lat_2020_3170f';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 18.2020 / 10.3170
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.2020
        0.3170
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2.6];

    % Status factory
    local_set_config_mode('S11config');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
    setao(AO);
   
    %% ModeNumber == 16 User mode - betax = 5m
elseif ModeNumber == 16
    % User mode - betax = 5m
    AD.OperationalMode = '2.7391 GeV, 18.2 10.3';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'lat_2020_3170e';
    OpsFileExtension = '_lat_2020_3170e';

    % AT lattice
    AD.ATModel = 'lat_2020_3170e';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 18.2020 / 10.3170
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.2020
        0.3100
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    local_set_config_mode('S11config');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
    setao(AO);

    %% ModeNumber == 10 User mode - with PX2 corrector   
elseif ModeNumber == 10
    % User mode - with PX2 corrector
    AD.OperationalMode = '2.7391 GeV, 18.2 10.3';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'lat_2020_3170bPX2';
    OpsFileExtension = '_lat_2020_3170bPX2';

    % AT lattice
    AD.ATModel = 'lat_2020_3170bPX2';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 18.2020 / 10.3170
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.2020
        0.3170
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    local_set_config_mode('normalconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
    setao(AO);

    %% ModeNumber == 11  User mode - Nanoscopium
elseif ModeNumber == 11 % User mode - Nanoscopium
    AD.OperationalMode = '2.7391 GeV, 18.2175 10.3120';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'nano_2175_3120a';
    OpsFileExtension = '_nano_2175_3120a';

    % AT lattice
    AD.ATModel = 'nano_2175_3120'; % new lattice version from Alex
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.2175
        0.3120
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    local_set_config_mode('nanoscopiumconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
    setao(AO);

  
    % triplet upstreams and downstreams of SDL13 for nanoscopium
    % Need to point to another family for magnetcoefficients (other range of current)
    % Q1 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009('Q1');
    AO.Q1.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q1.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q1.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q1.Setpoint.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    % Q1 downstream
    AO.Q1.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q1.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q1.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q1.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;
    % Q2 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009('Q2');
    AO.Q2.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q2.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q2.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q2.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;
    % Q2 downstream
    AO.Q2.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q2.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q2.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q2.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;
    % Q3 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009('Q1');
    AO.Q3.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q3.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q3.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q3.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;
    % Q3 downstream
    AO.Q3.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q3.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q3.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q3.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;
    
    setao(AO);

    %% ModeNumber == 14 % User mode - Nanoscopium
elseif ModeNumber == 14 % User mode - Nanoscopium
    AD.OperationalMode = '2.7391 GeV, 18.2175 10.3120';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'nano_8000_7000a';
    OpsFileExtension = '_nano_8000_7000a';

    % AT lattice
    AD.ATModel = 'nano_8000_7000'; % new lattice version from Alex
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.2175
        0.3120
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];


    local_set_config_mode('nanoscopiumconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
    setao(AO);

    % triplet upstreams and downstreams of SDL13 for nanoscopium
    % Need to point to another family for magnetcoefficients (other range of current)
    % Q1 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_80_70('Q1');
    AO.Q1.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q1.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q1.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q1.Setpoint.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    % Q1 downstream
    AO.Q1.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q1.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q1.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q1.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;
    % Q2 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_80_70('Q2');
    AO.Q2.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q2.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q2.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q2.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;
    % Q2 downstream
    AO.Q2.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q2.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q2.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q2.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;
    % Q3 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_80_70('Q1');
    AO.Q3.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q3.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q3.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q3.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;
    % Q3 downstream
    AO.Q3.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q3.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q3.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q3.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;

    % triplet nanoscopium
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_80_70('Q11');
    AO.Q11.Monitor.HW2PhysicsParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.HW2PhysicsParams{1}(1,:) = HW2PhysicsParams;
    AO.Q11.Monitor.Physics2HWParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.Physics2HWParams{1}(1,:) = HW2PhysicsParams;
    AO.Q11.Monitor.HW2PhysicsParams{1}(2,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.HW2PhysicsParams{1}(2,:) = HW2PhysicsParams;
    AO.Q11.Monitor.Physics2HWParams{1}(2,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.Physics2HWParams{1}(2,:) = HW2PhysicsParams;

    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_80_70('Q2');
    AO.Q12.Monitor.HW2PhysicsParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q12.Setpoint.HW2PhysicsParams{1}(1,:) = HW2PhysicsParams;
    AO.Q12.Monitor.Physics2HWParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q12.Setpoint.Physics2HWParams{1}(1,:) = HW2PhysicsParams;


    AO.Q11.Status = [1; 1];
    AO.Q12.Status = 1;

    setao(AO);
    
    %% ModeNumber == 15 User mode - Nanoscopium
elseif ModeNumber == 15 % User mode - Nanoscopium
    AD.OperationalMode = '2.7391 GeV, 18.2000 10.7000';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'nano_2000_7000a';
    OpsFileExtension = '_nano_2000_7000a';

    % AT lattice
    AD.ATModel = 'nano_2000_7000'; % new lattice version from Alex
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.2175
        0.3120
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    local_set_config_mode('nanoscopiumconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
    setao(AO);

    % triplet upstreams and downstreams of SDL13 for nanoscopium
    % Need to point to another family for magnetcoefficients (other range of current)
    % Q1 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano2_20_70('Q1');
    AO.Q1.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q1.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q1.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q1.Setpoint.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    % Q1 downstream
    AO.Q1.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q1.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q1.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q1.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;
    % Q2 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano2_20_70('Q2');
    AO.Q2.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q2.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q2.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q2.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;
    % Q2 downstream
    AO.Q2.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q2.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q2.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q2.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;
    % Q3 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano2_20_70('Q1');
    AO.Q3.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q3.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q3.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q3.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;
    % Q3 downstream
    AO.Q3.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q3.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q3.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q3.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;

    % triplet nanoscopium
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano2_20_70('Q11');
    AO.Q11.Monitor.HW2PhysicsParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.HW2PhysicsParams{1}(1,:) = HW2PhysicsParams;
    AO.Q11.Monitor.Physics2HWParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.Physics2HWParams{1}(1,:) = HW2PhysicsParams;
    AO.Q11.Monitor.HW2PhysicsParams{1}(2,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.HW2PhysicsParams{1}(2,:) = HW2PhysicsParams;
    AO.Q11.Monitor.Physics2HWParams{1}(2,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.Physics2HWParams{1}(2,:) = HW2PhysicsParams;

    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano2_20_70('Q7');
    AO.Q12.Monitor.HW2PhysicsParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q12.Setpoint.HW2PhysicsParams{1}(1,:) = HW2PhysicsParams;
    AO.Q12.Monitor.Physics2HWParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q12.Setpoint.Physics2HWParams{1}(1,:) = HW2PhysicsParams;

    setao(AO);

    %% ModeNumber == 8          
elseif ModeNumber == 8
    % User mode 
    AD.OperationalMode = '2.7391 GeV, 18.2 10.3';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'lat_2020_3170a';
    OpsFileExtension = '_lat_2020_3170a';

    % AT lattice
    AD.ATModel = 'lat_2020_3170a';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 18.2020 / 10.3170
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.2020
        0.3170
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    % Status factory
    local_set_config_mode('normalconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients);
    setao(AO);

    %% ModeNumber == 17  Nanoscopium : new tune (to be tested)  16 June 2010
elseif ModeNumber == 17 % Nanoscopium : new tune (to be tested)  16 June 2010
    % ATTENTION LE MAGNET COEFFICIENT EST CELUI DE LA MAILLE nano_2000_7000
    % à voir s'il faut le modifier
    AD.OperationalMode = '2.7391 GeV, 18.20 10.64';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'nano_2000_6400';
    OpsFileExtension = '_nano_2000_6400';

    % AT lattice
    AD.ATModel = 'nano_2000_6400'; % new lattice version from Alex
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.2175
        0.3120
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    % Status factory
    local_set_config_mode('normalconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_juin2009);

    % triplet upstreams and downstreams of SDL13 for nanoscopium
    % Need to point to another family for magnetcoefficients (other range of current)
    % Q1 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009('Q1');
    AO.Q1.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q1.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q1.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q1.Setpoint.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    % Q1 downstream
    AO.Q1.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q1.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q1.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q1.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;
    % Q2 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009('Q2');
    AO.Q2.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q2.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q2.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q2.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;
    % Q2 downstream
    AO.Q2.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q2.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q2.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q2.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;
    % Q3 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009('Q1');
    AO.Q3.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q3.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q3.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q3.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;
    % Q3 downstream
    AO.Q3.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q3.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q3.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q3.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;

    % triplet nanoscopium
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009('Q11');
    AO.Q11.Monitor.HW2PhysicsParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.HW2PhysicsParams{1}(1,:) = HW2PhysicsParams;
    AO.Q11.Monitor.Physics2HWParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.Physics2HWParams{1}(1,:) = HW2PhysicsParams;
    AO.Q11.Monitor.HW2PhysicsParams{1}(2,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.HW2PhysicsParams{1}(2,:) = HW2PhysicsParams;
    AO.Q11.Monitor.Physics2HWParams{1}(2,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.Physics2HWParams{1}(2,:) = HW2PhysicsParams;

    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009('Q7');
    AO.Q12.Monitor.HW2PhysicsParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q12.Setpoint.HW2PhysicsParams{1}(1,:) = HW2PhysicsParams;
    AO.Q12.Monitor.Physics2HWParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q12.Setpoint.Physics2HWParams{1}(1,:) = HW2PhysicsParams;
    setao(AO);
    
    
    %% ModeNumber == 18
elseif ModeNumber == 18 % User mode - Nanoscopium
        
    AD.OperationalMode = '2.7391 GeV, 18.200 10.300  Bx SDL =5m Nanoscopium';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'nano_5m_2000_3000a';
    OpsFileExtension = '_nano_5m_2000_3000a';

    % AT lattice
    AD.ATModel = 'nano_5m_20_30'; % new lattice version from Alex
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.20
        0.30
        NaN];
   
    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    local_set_config_mode('nanoscopiumconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);
    setao(AO);
 
    % triplet upstreams and downstreams of SDL13 for nanoscopium
    % Need to point to another family for magnetcoefficients (other range of current)
    % Q1 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m('Q1');
    AO.Q1.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q1.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q1.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q1.Setpoint.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    % Q1 downstream
    AO.Q1.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q1.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q1.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q1.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;
    % Q2 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m('Q2');
    AO.Q2.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q2.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q2.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q2.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;
    % Q2 downstream
    AO.Q2.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q2.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q2.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q2.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;
    % Q3 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m('Q1');
    AO.Q3.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q3.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q3.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q3.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;
    % Q3 downstream
    AO.Q3.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q3.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q3.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q3.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;

    % triplet nanoscopium
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m('Q11');
    AO.Q11.Monitor.HW2PhysicsParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.HW2PhysicsParams{1}(1,:) = HW2PhysicsParams;
    AO.Q11.Monitor.Physics2HWParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.Physics2HWParams{1}(1,:) = HW2PhysicsParams;
    AO.Q11.Monitor.HW2PhysicsParams{1}(2,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.HW2PhysicsParams{1}(2,:) = HW2PhysicsParams;
    AO.Q11.Monitor.Physics2HWParams{1}(2,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.Physics2HWParams{1}(2,:) = HW2PhysicsParams;

    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m('Q2');
    AO.Q12.Monitor.HW2PhysicsParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q12.Setpoint.HW2PhysicsParams{1}(1,:) = HW2PhysicsParams;
    AO.Q12.Monitor.Physics2HWParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q12.Setpoint.Physics2HWParams{1}(1,:) = HW2PhysicsParams;

    setao(AO);
         
    
    %% ModeNumber == 21  % User mode - Nanoscopium betax=5m
elseif ModeNumber == 21 % User mode - Nanoscopium
        
    AD.OperationalMode = '2.7391 GeV, 18.1700 10.2500  S11  Bx SDL =5m Nanoscopium';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'nano_5m_1700_2500a';
    OpsFileExtension = '_nano_5m_1700_2500a';

    % AT lattice
    AD.ATModel = 'nano_5m_17_25_S11'; % new lattice version from Alex
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.20
        0.30
        NaN];
   
    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2.6];

    local_set_config_mode('nanoscopiumconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);
    setao(AO);
 
    % triplet upstreams and downstreams of SDL13 for nanoscopium
    % Need to point to another family for magnetcoefficients (other range of current)
    % Q1 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m('Q1');
    AO.Q1.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q1.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q1.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q1.Setpoint.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    % Q1 downstream
    AO.Q1.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q1.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q1.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q1.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;
    % Q2 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m('Q2');
    AO.Q2.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q2.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q2.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q2.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;
    % Q2 downstream
    AO.Q2.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q2.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q2.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q2.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;
    % Q3 upstream
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m('Q1');
    AO.Q3.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q3.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
    AO.Q3.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
    AO.Q3.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;
    % Q3 downstream
    AO.Q3.Monitor.HW2PhysicsParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q3.Monitor.Physics2HWParams{1}(7,:)  = HW2PhysicsParams;
    AO.Q3.Setpoint.HW2PhysicsParams{1}(7,:) = HW2PhysicsParams;
    AO.Q3.Setpoint.Physics2HWParams{1}(7,:) = HW2PhysicsParams;

    % triplet nanoscopium
    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m('Q11');
    AO.Q11.Monitor.HW2PhysicsParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.HW2PhysicsParams{1}(1,:) = HW2PhysicsParams;
    AO.Q11.Monitor.Physics2HWParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.Physics2HWParams{1}(1,:) = HW2PhysicsParams;
    AO.Q11.Monitor.HW2PhysicsParams{1}(2,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.HW2PhysicsParams{1}(2,:) = HW2PhysicsParams;
    AO.Q11.Monitor.Physics2HWParams{1}(2,:)  = HW2PhysicsParams;
    AO.Q11.Setpoint.Physics2HWParams{1}(2,:) = HW2PhysicsParams;

    HW2PhysicsParams = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m('Q2');
    AO.Q12.Monitor.HW2PhysicsParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q12.Setpoint.HW2PhysicsParams{1}(1,:) = HW2PhysicsParams;
    AO.Q12.Monitor.Physics2HWParams{1}(1,:)  = HW2PhysicsParams;
    AO.Q12.Setpoint.Physics2HWParams{1}(1,:) = HW2PhysicsParams;

    setao(AO);
    
    %% ModeNumber == 1
elseif ModeNumber == 1
    % User mode - 
    AD.OperationalMode = '2.7391 GeV, 18.2 10.3';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'solamor2c';
    OpsFileExtension = '_solamor2c';

    % AT lattice
    AD.ATModel = 'solamor2linc';
    eval(AD.ATModel);  %run model for compilersolamor2linb;

    % Golden TUNE is with the TUNE family
    % 18.2020 / 10.3170
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.2020
        0.3170
        NaN];
    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    % Status factory
    local_set_config_mode('normalconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients);
    setao(AO);

    %% ModeNumber == 2
elseif ModeNumber == 2
    % User mode - 
    AD.OperationalMode = '2.7391 GeV, 18.2 10.3';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'solamor2';
    OpsFileExtension = '_solamor2';

    % AT lattice
    AD.ATModel = 'solamor2linb';
    eval(AD.ATModel);  %run model for compilersolamor2linb;

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.2000
        0.3000
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    % Status factory
    local_set_config_mode('normalconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients);
    setao(AO);

    %% ModeNumber == 3 Chasmann_green
elseif ModeNumber == 3
    % Chasmann_green
    AD.OperationalMode = '2.7391 GeV, 18.2 10.3';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'chasmann_green';
    OpsFileExtension = '_chasmann_green';

    % AT lattice
    AD.ATModel = 'chasman_green';
    eval(AD.ATModel);  %run model for compilersolamor2linb;

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.20
        0.30
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    % Status factory
    local_set_config_mode('S11config');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients);
    setao(AO);

    %% ModeNumber == 4 Low Alpha alpha_nominal/15
elseif ModeNumber == 4
    % Low Alpha alpha_nominal/15
    AD.OperationalMode = '2.7391 GeV, 20.72 9.2, lowalpha1/15';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'lowalpha1by15';
    OpsFileExtension = '_lowalpha1by15';

    % AT lattice
    AD.ATModel = 'lowalpha1by15';
    eval(AD.ATModel);  %run model for compilersolamor2linb;

    % Defaults RF for dispersion and chromaticity measurements (must be in Hardware units)
    AD.DeltaRFDisp = 100e-6/15*3;
    AD.DeltaRFChro = [-100 -50 0 50 150] * 1e-6/15*3;

    % Golden TUNE is with the TUNE family
    % 20.72 / 9.20
    AO = getao;

    AO.TUNE.Monitor.Golden = [
        0.72
        0.20
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    % Status factory
    local_set_config_mode('normalconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients);
    setao(AO);

    %% ModeNumber == 5 Low Alpha alpha1by20_maher
elseif ModeNumber == 5
    % Low Alpha alpha1by20_maher
    AD.OperationalMode = '2.7391 GeV, 20.3 8.4, lowalpha1/20';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha1by20';
    OpsFileExtension = '_alpha1by20';

    % AT lattice
    AD.ATModel = 'alpha1by20_maher';
    eval(AD.ATModel);  %run model for compilersolamor2linb;

    % Defaults RF for dispersion and chromaticity measurements (must be in Hardware units)
    AD.DeltaRFDisp = 100e-6/20*3;
    AD.DeltaRFChro = [-100 -50 0 50 150] * 1e-6/20*3;

    % Golden TUNE is with the TUNE family
    % 20.40 / 8.40
    AO = getao;

    AO.TUNE.Monitor.Golden = [
        0.30
        0.40
        NaN];
    
    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    % Status factory
    local_set_config_mode('normalconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_lowalpha);
    setao(AO);

    %% ModeNumber == 6 User mode - HU640
elseif ModeNumber == 6
    % User mode - HU640
    AD.OperationalMode = '2.7391 GeV HU640, 18.2 10.3';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'solamor2_HU640';
    OpsFileExtension = '_solamor2_HU640';

    % AT lattice
    AD.ATModel = 'solamor2linb_HU640';
    eval(AD.ATModel);  %run model for compilersolamor2linb;

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.20
        0.30
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    % Status factory
    local_set_config_mode('normalconfig');
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_lowalpha);
    setao(AO);

    %% ModeNumber == 7 alpha1/20 new callibration 20.3 8.4
elseif ModeNumber == 7
    % December 2008
    % alpha1/20 new callibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/20 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'lowalpha_dec08';
    OpsFileExtension = '_lowalpha_dec08';

    % AT lattice
    AD.ATModel = 'alphaby20_nouveau_modele_dec08_opt_nonlin';
    addpath(fullfile(getfamilydata('Directory','Lattice'), 'lowalpha_dec08'));
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 20.30 / 8.40
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.30
        0.40
        NaN];

    % Defaults RF for dispersion and chromaticity measurements (must be in Hardware units)
    AD.DeltaRFDisp = 10e-6;
    AD.DeltaRFChro = [-10 -5 0 5 10] * 1e-6;


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    local_set_config_mode('normalconfig');    
    % Commented for shift January 2010
    %AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_cal_lowalphaMAHER_Linterm);
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_low_alpha_janv2010);
    setao(AO);
  

    %% ModeNumber == 12 alpha1/10 new calibration 20.3 8.4
elseif ModeNumber == 12
    % February 2010
    % alpha1/10 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/10 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha_over_10';
    OpsFileExtension = '_alpha_over_10';

    % AT lattice
    AD.ATModel = 'alphaby10_nouveau_modele_dec08_opt_lin_1';
    addpath(fullfile(getfamilydata('Directory','Lattice'), 'lowalpha_dec08'));
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 20.30 / 8.40
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.30
        0.40
        NaN];

    % Defaults RF for dispersion and chromaticity measurements (must be in Hardware units)
    AD.DeltaRFDisp = 10e-6;
    AD.DeltaRFChro = [-10 -5 0 5 10] * 1e-6;

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    local_set_config_mode('S11config');    
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_low_alpha_janv2010);
    setao(AO);

    %% ModeNumber == 13 alpha1/1000 new calibration 20.3 8.4
elseif ModeNumber == 13
    % February 2010
    % alpha1/1000 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha_nominal/100 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha_over_100';
    OpsFileExtension = '_alpha_over_100';

    % AT lattice
    AD.ATModel = 'alphaby100_nouveau_modele_janvier2010_opt_nonlin_ksi_2_2';
    addpath(fullfile(getfamilydata('Directory','Lattice'), 'lowalpha_dec08'));
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 20.30 / 8.40
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.30
        0.40
        NaN];

    % Defaults RF for dispersion and chromaticity measurements (must be in Hardware units)
    AD.DeltaRFDisp = 1e-6;
    AD.DeltaRFChro = [-1 -0.5 0 0.5 1] * 1e-6;

    % Response matrix
    devnumber = length(AO.HCOR.Status);
    AO.HCOR.Setpoint.DeltaRespMat(:,:) = ones(devnumber,1)*5e-6; % 2*2.5 urad (half used for kicking)
    AO.HCOR.Setpoint.DeltaRespMat = physics2hw(AO.HCOR.FamilyName,'Setpoint', ...
        AO.HCOR.Setpoint.DeltaRespMat, AO.HCOR.DeviceList);

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];
    
    local_set_config_mode('S11config');    
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_low_alpha_janv2010);
    setao(AO);


    %% ModeNumber == 22 alpha1/10 AMOR december 2010 new calibration 20.77 9.2
elseif ModeNumber == 22
    % February 2010
    % alpha1/10 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/10 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha_over_10';
    OpsFileExtension = '_alpha_over_10';

    % AT lattice
    AD.ATModel = 'alphaby10_AMOR_new_mod_nov10_lin_auto_0';
    addpath(fullfile(getfamilydata('Directory','Lattice'), 'lowalpha_dec08'));
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 20.77 / 9.20
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.77
        0.20
        NaN];

    % Defaults RF for dispersion and chromaticity measurements (must be in Hardware units)
    AD.DeltaRFDisp = 10e-6;
    AD.DeltaRFChro = [-10 -5 0 5 10] * 1e-6;

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [0; 0];

    local_set_config_mode('S11config');    
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_mod_low_alpha_AMOR_oct10);
    setao(AO);


    %% ModeNumber == 23 122 BPMs with nominal lattice RUN3 2011
elseif ModeNumber == 23
    % User mode - Laurent
    AD.OperationalMode = '2.7391 GeV, 18.2 10.3';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'nano';
    OpsFileExtension = '_nano_test';

    % AT lattice
    AD.ATModel = 'lat_1990_3170_122BPM';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.1990
        0.3170
        NaN];


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    local_set_config_mode('nanoscopiumconfig');
    AO = getao;
    setfamilydata(1, 'BPMx', 'Status');
    setfamilydata(1, 'BPMz', 'Status');
    setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'VCOR', 'Setpoint', 'DeltaRespMat');
    setao(AO);
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
    setao(AO);

 %% ModeNumber == 24 122 BPMs with nanoscopium lattice RUN3 2011
elseif ModeNumber == 24
    % User mode - Laurent
    AD.OperationalMode = '2.7391 GeV, 18.2 10.3';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'nano';
    OpsFileExtension = '_nano_122BPM';

    % AT lattice
    AD.ATModel = 'lat_nano_122BPM';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.2016
        0.2998
        NaN];


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    local_set_config_mode('nanoscopiumconfigC'); % with correctors
    AO = getao;
    setfamilydata(1, 'BPMx', 'Status');
    setfamilydata(1, 'BPMz', 'Status');
    setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'VCOR', 'Setpoint', 'DeltaRespMat');
    setao(AO);
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);
    setao(AO);

    %% ModeNumber == 100 Laurent
elseif ModeNumber == 100
    % User mode - Laurent
    AD.OperationalMode = '2.7391 GeV, 18.2 10.3';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'chasmann_green';
    OpsFileExtension = '_chasmann_green';

    % AT lattice
    AD.ATModel = 'chasman_green';
    chasman_green;

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.20
        0.30
        NaN];


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    setfamilydata(ones(120,1)*1e-5, 'HCOR', 'Setpoint', 'DeltaRespMat');
    setfamilydata(ones(120,1)*1e-5, 'VCOR', 'Setpoint', 'DeltaRespMat');
    % AO.(ifam).Setpoint.DeltaRespMat(:,:) = ones(nb,1)*0.5e-4*1; % 2*25 urad (half used for kicking)
    local_set_config_mode('normalconfig');    
    AO = local_setmagnetcoefficent(AO, @magnetcoefficients_new_calib_new_modele_low_alpha_janv2010);
    setao(AO);

else
    error('Operational mode unknown');
end



%%%%%%

% Force units to hardware
switch2hw;

% Activation of correctors of HU640
if ModeNumber == 6
    switchHU640Cor('ON');
else
    switchHU640Cor('OFF');
end

% Set the AD directory path
setad(AD);

MMLROOT = setmmldirectories(AD.Machine, AD.SubMachine, ModeName, OpsFileExtension, 'DVPT');
AD = getad;

% SOLEIL specific path changes

% Top Level Directories

%AD.Directory.DataRoot       = fullfile(MMLROOT, 'measdata', 'SOLEIL', 'StorageRingdata', filesep);
% RUCHE
MMLDATAROOT = getmmldataroot;
AD.Directory.DataRoot       = fullfile(MMLDATAROOT, 'measdata', 'SOLEIL', 'StorageRingdata', filesep);
AD.Directory.Lattice        = fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'Lattices', filesep);
AD.Directory.Orbit          = fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing',  'orbit', filesep);

% Data Archive Directories DO NOT REMOVE LINES
AD.Directory.BeamUser       = fullfile(AD.Directory.DataRoot, 'BPM', 'BeamUser', filesep); %store saved orbit for operation (every new beam)
AD.Directory.BPMData        = fullfile(AD.Directory.DataRoot, 'BPM', filesep);
AD.Directory.TuneData       = fullfile(AD.Directory.DataRoot, 'Tune', filesep);
AD.Directory.ChroData       = fullfile(AD.Directory.DataRoot, 'Chromaticity', filesep);
AD.Directory.DispData       = fullfile(AD.Directory.DataRoot, 'Dispersion', filesep);
AD.Directory.ConfigData     = fullfile(MMLROOT, 'machine', 'SOLEIL', 'StorageRing', 'MachineConfig', filesep);
AD.Directory.BumpData       = fullfile(AD.Directory.DataRoot, 'Bumps', filesep);
AD.Directory.Archiving      = fullfile(AD.Directory.DataRoot, 'ArchivingData', filesep);
AD.Directory.QUAD           = fullfile(AD.Directory.DataRoot, 'QUAD', filesep);
AD.Directory.BBA            = fullfile(AD.Directory.DataRoot, 'BBA', filesep);
AD.Directory.BBAcurrent     = fullfile(AD.Directory.BBA, 'dafault' ,filesep);
AD.Directory.PINHOLE        = fullfile(AD.Directory.DataRoot, 'PINHOLE', filesep);
AD.Directory.Synchro        = fullfile(MMLROOT, 'machine', 'SOLEIL', 'common', 'synchro', filesep);
AD.Directory.LOCOData       = fullfile(AD.Directory.DataRoot, 'LOCO', filesep);

% Insertion Devices
HOMEDIR = getenv('HOME');
AD.Directory.HU80_TEMPO     = fullfile(HOMEDIR, 'GrpGMI', 'HU80_TEMPO', filesep);
AD.Directory.HU80_PLEIADES  = fullfile(HOMEDIR, 'GrpGMI', 'HU80_PLEIADES', filesep);
AD.Directory.HU80_MICROFOC  = fullfile(HOMEDIR, 'GrpGMI', 'HU80_MICROFOC', filesep);
AD.Directory.HU60_CASSIOPEE = fullfile(HOMEDIR, 'GrpGMI', 'HU60_CASSIOPEE', filesep);
AD.Directory.HU60_ANTARES   = fullfile(HOMEDIR, 'GrpGMI', 'HU60_ANTARES', filesep);
AD.Directory.U20_PROXIMA1   = fullfile(HOMEDIR, 'GrpGMI', 'U20_PROXIMA1', filesep);
AD.Directory.U20_SWING      = fullfile(HOMEDIR, 'GrpGMI', 'U20_SWING', filesep);
AD.Directory.U20_CRISTAL    = fullfile(HOMEDIR, 'GrpGMI', 'U20_CRISTAL', filesep);
AD.Directory.U20_SIXS       = fullfile(HOMEDIR, 'GrpGMI', 'U20_SIXS', filesep);
AD.Directory.U20_GALAXIES   = fullfile(HOMEDIR, 'GrpGMI', 'U20_GALAXIES', filesep);
AD.Directory.U24_PXIIA      = fullfile(HOMEDIR, 'GrpGMI', 'U24_PXIIA ', filesep);
AD.Directory.WSV50_PSICHE   = fullfile(HOMEDIR, 'GrpGMI', 'WSV50_PSICHE ', filesep);
AD.Directory.HU640_DESIRS   = fullfile(HOMEDIR, 'GrpGMI', 'HU640_DESIRS', filesep);
AD.Directory.HU44_TEMPO     = fullfile(HOMEDIR, 'GrpGMI', 'HU44_TEMPO', filesep);
AD.Directory.HU44_MICROFOC  = fullfile(HOMEDIR, 'GrpGMI', 'HU44_MICROFOC', filesep);
AD.Directory.HU52_DEIMOS    = fullfile(HOMEDIR, 'GrpGMI', 'HU52_DEIMOS', filesep);
AD.Directory.HU52_LUCIA     = fullfile(HOMEDIR, 'GrpGMI', 'HU52_LUCIA', filesep);
AD.Directory.HU36_SIRIUS    = fullfile(HOMEDIR, 'GrpGMI', 'HU36_SIRIUS', filesep);

% For develpment on Hyperions

% STANDALONE matlab applications
AD.Directory.Standalone     = fullfile(MMLROOT, 'machine', 'SOLEIL', 'standalone_applications', filesep);

% FOFB matlab applications
AD.Directory.FOFBdata     = fullfile(AD.Directory.DataRoot, 'FOFB');

% AD.Directory.InterlockData  = fullfile(AD.Directory.DataRoot, 'Interlock/'];

%Response Matrix Directories
AD.Directory.BPMResponse    = fullfile(AD.Directory.DataRoot, 'Response', 'BPM', filesep);
AD.Directory.TuneResponse   = fullfile(AD.Directory.DataRoot, 'Response', 'Tune', filesep);
AD.Directory.ChroResponse   = fullfile(AD.Directory.DataRoot, 'Response', 'Chrom', filesep);
AD.Directory.DispResponse   = fullfile(AD.Directory.DataRoot, 'Response', 'Disp', filesep);
AD.Directory.SkewResponse   = fullfile(AD.Directory.DataRoot, 'Response', 'Skew', filesep);

% used by energytunette
AD.Directory.BPMTransport   = fullfile(AD.Directory.DataRoot, 'Transport', 'BPM', filesep);
% used by MAT's Steerette application
AD.Directory.Steerette     = fullfile(AD.Directory.DataRoot, 'Transport', 'Steerette', filesep);

% Postmortem DATA
AD.Directory.BPMPostmortem    = fullfile(AD.Directory.DataRoot, 'Postmortem', 'BPMPostmortem', filesep);
AD.Directory.RFPostmortem     = fullfile(AD.Directory.DataRoot, 'Postmortem', 'RFPostmortem', filesep);

%Default Data File Prefix
AD.Default.BPMArchiveFile      = 'BPM';                %file in AD.Directory.BPM               orbit data
AD.Default.TuneArchiveFile     = 'Tune';               %file in AD.Directory.Tune              tune data
AD.Default.ChroArchiveFile     = 'Chro';               %file in AD.Directory.Chromaticity       chromaticity data
AD.Default.DispArchiveFile     = 'Disp';               %file in AD.Directory.Dispersion       dispersion data
AD.Default.CNFArchiveFile      = 'CNF';                %file in AD.Directory.CNF               configuration data
AD.Default.QUADArchiveFile     = 'QuadBeta';           %file in AD.Directory.QUAD             betafunction for quadrupoles
AD.Default.PINHOLEArchiveFile  = 'Pinhole';            %file in AD.Directory.PINHOLE             pinhole data
AD.Default.SkewArchiveFile     = 'SkewQuad';           %file in AD.Directory.SkewQuad             SkewQuad data
AD.Default.BBAArchiveFile      = 'BBA_DKmode';         %file in AD.Directory.BBA             BBA DK mode data

%Default Response Matrix File Prefix
AD.Default.BPMRespFile      = 'BPMRespMat';         %file in AD.Directory.BPMResponse       BPM response matrices
AD.Default.TuneRespFile     = 'TuneRespMat';        %file in AD.Directory.TuneResponse      tune response matrices
AD.Default.ChroRespFile     = 'ChroRespMat';        %file in AD.Directory.ChroResponse      chromaticity response matrices
AD.Default.DispRespFile     = 'DispRespMat';        %file in AD.Directory.DispResponse      dispersion response matrices
AD.Default.SkewRespFile     = 'SkewRespMat';        %file in AD.Directory.SkewResponse      skew quadrupole response matrices

%Orbit Control and Feedback Files
AD.Restore.GlobalFeedback   = 'Restore.m';

% Circumference
AD.Circumference = findspos(THERING,length(THERING)+1);
setad(AD);

% Updates the AT indices in the MiddleLayer with the present AT lattice
updateatindex;

% Set the model energy
setenergymodel(AD.Energy);


% Momentum compaction factor
MCF = getmcf('Model');
if isnan(MCF)
    AD.MCF = 4.498325442923014e-04;
    fprintf('   Model alpha calculation failed, middlelayer alpha set to  %f\n', AD.MCF);
else
    AD.MCF = MCF;
    fprintf('   Middlelayer alpha set to %f (AT model).\n', AD.MCF);
end
setad(AD);


% Add Gain & Offsets for magnet family
fprintf('   Setting magnet monitor gains based on the production lattice.\n');
%setgainsandoffsets;

%% Config texttalker (right location ?)
AD.TANGO.TEXTTALKER='ans/ca/texttalker.2';

%%%%%%%%%%%%%%%%%%%%%%
% Final mode changes %
%%%%%%%%%%%%%%%%%%%%%%
if any(ModeNumber == [1 2 3 4])
    % User mode - 2.75 GeV, Nominal lattice

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Add LOCO Parameters to AO and AT-Model %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     'Nominal'    - Sets nominal gains (1) / rolls (0) to the model.
    %     'SetGains'   - Set gains/coupling from a LOCO file.
    %     'SetModel'   - Set the model from a LOCO file.  But it only changes
    %                    the part of the model that does not get corrected
    %                    in 'Symmetrize' (also does a SetGains).
    %     'LOCO2Model' - Set the model from a LOCO file (also does a SetGains).
    %                    This sets all lattice machines fit in the LOCO run to the model.
    %
    % Basically, use 'SetGains' or 'SetModel' if the LOCO run was applied to the accelerator
    %            use 'LOCO2Model' if the LOCO run was made after the final setup

    % Store the LOCO file in the opsdata directory
    %AD.OpsData.LOCOFile = [getfamilydata('Directory','OpsData'),'LOCO_72SkewQuads_122BPMs'];

    %AD.OpsData.LOCOFile = [getfamilydata('Directory','OpsData'),'LOCO_AllQuads_1Bend_72SkewQuads'];
    %setad(AD);

    % MCF depends on optics !!!

    %try
    %    setlocodata('LOCO2Model', AD.OpsData.LOCOFile);
    %catch
    %    fprintf('\n%s\n\n', lasterr);
    %    fprintf('   WARNING: there was a problem calibrating the model based on LOCO file %s.\n', AD.OpsData.LOCOFile);
    %end

else
    %setlocodata('Nominal');
end

fprintf('   lattice files have changed or if the AT lattice has changed.\n');
fprintf('   Middlelayer setup for operational mode: %s\n', AD.OperationalMode);

setad(orderfields(AD));

end

function AO = local_setmagnetcoefficent(AO, magnetcoeff_function)
    % quadrupole magnet coefficients
    % number of status 1 quadrupole families
    
    quadFamList = {'Q1', 'Q2', 'Q3', 'Q4', 'Q5', 'Q6', ...
         'Q7', 'Q8', 'Q9', 'Q10'};
    
    if family2status('Q11',1),
        quadFamList = [quadFamList, {'Q11'}];
    end
    
    if family2status('Q12',1),
        quadFamList = [quadFamList, {'Q12'}];
    end
        
    
    for k = 1:length(quadFamList),
        ifam = quadFamList{k};

        HW2PhysicsParams = feval(magnetcoeff_function, AO.(ifam).FamilyName);
        Physics2HWParams = HW2PhysicsParams;

        nb = size(AO.(ifam).DeviceName,1);

        for ii=1:nb,
            val = 1.0;
            AO.(ifam).Monitor.HW2PhysicsParams{1}(ii,:)                 = HW2PhysicsParams;
            AO.(ifam).Monitor.HW2PhysicsParams{2}(ii,:)                 = val;
            AO.(ifam).Monitor.Physics2HWParams{1}(ii,:)                 = Physics2HWParams;
            AO.(ifam).Monitor.Physics2HWParams{2}(ii,:)                 = val;
            AO.(ifam).Setpoint.HW2PhysicsParams{1}(ii,:)                = HW2PhysicsParams;
            AO.(ifam).Setpoint.HW2PhysicsParams{2}(ii,:)                = val;
            AO.(ifam).Setpoint.Physics2HWParams{1}(ii,:)                = Physics2HWParams;
            AO.(ifam).Setpoint.Physics2HWParams{2}(ii,:)                = val;
        end
    end

    % sextupole magnet coefficients
    % number of status 1 sextupole families
     sextuFamList = {'S1', 'S2', 'S3', 'S4', 'S5', 'S6', ...
         'S7', 'S8', 'S9', 'S10'};
    
    if family2status('S11',1),
        sextuFamList = [sextuFamList, {'S11'}];
    end
    
    if family2status('S12',1),
        sextuFamList = [sextuFamList, {'S12'}];
    end

    for k = 1:length(sextuFamList),
        ifam = sextuFamList{k};
        
        HW2PhysicsParams = feval(magnetcoeff_function, AO.(ifam).FamilyName);
        Physics2HWParams = HW2PhysicsParams;
        
        val = 1.0;
        AO.(ifam).Monitor.HW2PhysicsParams{1}(1,:)                 = HW2PhysicsParams;
        AO.(ifam).Monitor.HW2PhysicsParams{2}(1,:)                 = val;
        AO.(ifam).Monitor.Physics2HWParams{1}(1,:)                 = Physics2HWParams;
        AO.(ifam).Monitor.Physics2HWParams{2}(1,:)                 = val;
        AO.(ifam).Setpoint.HW2PhysicsParams{1}(1,:)                 = HW2PhysicsParams;
        AO.(ifam).Setpoint.HW2PhysicsParams{2}(1,:)                 = val;
        AO.(ifam).Setpoint.Physics2HWParams{1}(1,:)                 = Physics2HWParams;
        AO.(ifam).Setpoint.Physics2HWParams{2}(1,:)                 = val;
    end
end


function  local_set_config_mode(configmode)
% Function for activating new families of quadrupole and sextupoles
% magnets.
switch(configmode)
    case 'S11config' % with S11
        setfamilydata(1, 'S11', 'Status')
        setfamilydata(0, 'S12', 'Status')
        setfamilydata(0, 'Q11', 'Status')
        setfamilydata(0, 'Q12', 'Status')
        setfamilydata(0, 'HCOR', 'Status', [13 8]);
        setfamilydata(0, 'VCOR', 'Status', [13 9]);
    case 'normalconfig' % without S11
        setfamilydata(0, 'S11', 'Status')
        setfamilydata(0, 'S12', 'Status')
        setfamilydata(0, 'Q11', 'Status')
        setfamilydata(0, 'Q12', 'Status')
        setfamilydata(0, 'HCOR', 'Status', [13 8]);
        setfamilydata(0, 'VCOR', 'Status', [13 9]);
    case 'nanoscopiumconfig'
        setfamilydata(1, 'S11', 'Status')
        setfamilydata(1, 'S12', 'Status')
        setfamilydata(1, 'Q11', 'Status')
        setfamilydata(1, 'Q12', 'Status')
        setfamilydata(0, 'HCOR', 'Status', [13 8]);
        setfamilydata(0, 'VCOR', 'Status', [13 9]);
    case 'nanoscopiumconfigC'
        setfamilydata(1, 'S11', 'Status')
        setfamilydata(1, 'S12', 'Status')
        setfamilydata(1, 'Q11', 'Status')
        setfamilydata(1, 'Q12', 'Status')
        setfamilydata(1, 'HCOR', 'Status', [13 8]);
        setfamilydata(1, 'VCOR', 'Status', [13 9]);
    otherwise
        error('Wrong mode')
end

% switch addition corrector for HU640... TO BE REMOVED LATER
switchHU640Cor('OFF');
end