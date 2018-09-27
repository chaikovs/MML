function setoperationalmode(ModeNumber)
%SETOPERATIONALMODE - Switches between the various operational modes
%  setoperationalmode(ModeNumber)
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
%        23/ 2.7391 GeV, low alpha_nominal/10 MAHER 20.30 8.40 OD optimise (lin_1_auto) December 2010', ...
%        24/ 2.7391 GeV, betaz=1m et betax=15m dans les sections courtes Fevrier 2011', ...
%        25/ 2.7391 GeV, lowalpha MAHER, alpha negatif, OD optimisee',...
%        26/ 2.7391 GeV, lowalpha from nominal optics alpha/200 19.24 10.317 Juin 2011'...
%        27/ 2.7391 GeV, betax=15m SDC + idem Nanoscopium Juin 2011', ...
%        28/ 2.7391 GeV, 122 BPMs nominal RUN3 2011 18.2020 10.3170 w/ S11 betax=5m en SDL',...
%        29/ 2.7391 GeV, 122 BPMs nanoscopium',...
%        30/ 2.7391 GeV, 122 BPMs nominal RUN4 2011 pseudo-nano betax = 15m SDC + idem Nanoscopium Juin 2011', ...
%        31/ 2.7391 GeV, 122 BPMs betaz = 1m et betax = 15m dans les sections courtes Fevrier 2011', ...
%        32/ 2.7391 GeV, 122 BPMs low alpha_nominal/10  20.3 8.4 December 2008/January 2010', ...
%        33/ 2.7391 GeV, 122 BPMs low alpha_nominal/100  20.3 8.4 December 2008/January 2010', ...
%        34/ 2.7391 GeV, 122 BPMs low alpha_nominal/10 MAHER 20.30 8.40 OD optimise (lin_1_auto) December 2010', ...
%        35/ 2.7391 GeV, 122 BPMs lowalpha MAHER, alpha negatif, OD optimise',...
%        36/ 2.7391 GeV, 122 BPMs  alpha_nominal/25  20.3 8.4 Octobre 2011',...
%        37/ 2.7391 GeV, 122 BPMs 18.2020 10.3170  User mode - S11 betax=10m till November 2010 ',...
%        38/ 2.7391 GeV, 122 BPMs nanoscopium run machine .170 .250 ',.../home/data/matlab/data4mml/measdata/SOLEIL/StorageRingdata/Nanoscopium/Nanoscopium_mai_2016
%        39/ 2.7391 GeV, 122 BPMs low alpha_nominal/25  20.3 8.4 BETAZ = 2.6m CRISTAL' ,...       
%        40/ 2.7391 GeV, Mode 29 + 4 XBPM with nanoscopium from March 2012', ... 
%        41/ 2.7391 GeV, 122 BPMs alpha_nominal/100  20.3 8.4 Nov 2012',...
%        42/ 2.7391 GeV, 122 BPMs alpha_nom/home/data/matlab/data4mml/measdata/SOLEIL/StorageRingdata/Nanoscopium/Nanoscopium_mai_2016inal/150  20.3 8.4 Nov 2012',...  
%        43/ 2.7391 GeV, 122 BPMs nanoscopium from January 2012 + waist px2 test 08-04-2013',...
%        44/ 2.7391 GeV, 122 BPMs nanoscopium from January 2012 0.176 0.234+ bx_inj=11m', ...
%        45/ 2.7391 GeV, 122 BPMs nanoscopium from January 2012 + waist px2 + betaz = 1m',...
%        46/ 2.7391 GeV, 122 BPMs nanoscopium from January 2012 0.155 0.229 + bx=11m SDL01-09', ...
%        47/ 2.7391 GeV, Mode 46 + 4 XBPM', ...
%        48/ 2.7391 GeV, 122 BPMs nanoscopium from January 2012 0.155 0.229 + bx=11m SDL01-09 + 6 Correctors', ...
%        49/ 2.7391 GeV, Mode 46 + 4 XBPM + 6 Correctors', ...
%        50/ 2.7391 GeV, Mode 48 + bz=1m SDC03 (January 2015) 
%        54/ 2.7391 GeV, Mode 51 + lattice 3.4 nm.rad

%        100 'Laurent''s Mode'...
%
%  See also aoinit, updateatindex, soleilinit, setmmldirectories, lattice_prep
%  NOTES
% use local_set_config_mode for defining status of S11 et S12;


%
% Written by Laurent S. Nadolski
% FOR CVS
% $Header$
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
        ' 1/ 2.7391 GeV, 18.2020 10.3170', ...
        ' 2/ 2.7391 GeV, 18.20 10.30', ...
        ' 3/ 2.7391 GeV, Chasmann-Green', ...
        ' 4/ 2.7391 GeV, Low Alpha nominal alpha1/15 December 2007', ...
        ' 5/ 2.7391 GeV, alpha1/20 alpha1by20_maher',...
        ' 6/ 2.7391 GeV, HU640', ...
        ' 7/ 2.7391 GeV, low alpha_nominal/20  20.3 8.4 December 2008/January 2010', ...
        ' 8/ 2.7391 GeV, 18.2020 10.3170 with new steerer position', ...
        ' 9/ 2.7391 GeV, 18.2020 10.3170 with new steerer position and new quad model', ...
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
        '23/ 2.7391 GeV, low alpha_nominal/10 MAHER 20.30 8.40 OD optimis�e (lin_1_auto) December 2010', ...
        '24/ 2.7391 GeV, betaz=1m et betax=15m dans les sections courtes Fevrier 2011', ...
        '25/ 2.7391 GeV,lowalpha MAHER, alpha negatif, OD optimise',...
        '26/ 2.7391 GeV,lowalpha from nominal optics alpha/200 19.24 10.317 Juin 2011',...
        '27/ 2.7391 GeV, betax=15m SDC + idem Nanoscopium Juin 2011', ...
        '28/ 2.7391 GeV, 122 BPMs nominal RUN3 2011 18.2020 10.3170 w/ S11 betax=5m en SDL',...
        '29/ 2.7391 GeV, 122 BPMs nanoscopium from January 2012',...
        '30/ 2.7391 GeV, 122 BPMs nominal RUN4 2011 pseudo-nano betax = 15m SDC + idem Nanoscopium Juin 2011', ...
        '31/ 2.7391 GeV, 122 BPMs betaz = 1m et betax = 15m dans les sections courtes Fevrier 2011', ...
        '32/ 2.7391 GeV, 122 BPMs low alpha_nominal/10  20.3 8.4 December 2008/January 2010', ...
        '33/ 2.7391 GeV, 122 BPMs low alpha_nominal/100  20.3 8.4 December 2008/January 2010', ...
        '34/ 2.7391 GeV, 122 BPMs low alpha_nominal/10 MAHER 20.30 8.40 OD optimise (lin_1_auto) December 2010', ...
        '35/ 2.7391 GeV, 122 BPMs lowalpha MAHER, alpha negatif, OD optimise',...
        '36/ 2.7391 GeV, 122 BPMs  alpha_nominal/25  20.3 8.4 Octobre 2011',...
        '37/ 2.7391 GeV, 122 BPMs 18.2020 10.3170  User mode - S11 betax=10m till November 2010 ',...
        '38/ 2.7391 GeV, 122 BPMs nanoscopium run machine .170 .250 ',...
        '39/ 2.7391 GeV, 122 BPMs low alpha_nominal/25  20.3 8.4 BETAZ = 2.6m CRISTAL' ,...       
        '40/ 2.7391 GeV, 122 BPMs + 4 XBPM with nanoscopium from March 2012', ... 
        '41/ 2.7391 GeV, 122 BPMs alpha_nominal/100  20.3 8.4 Nov 2012',...
        '42/ 2.7391 GeV, 122 BPMs alpha_nominal/150  20.3 8.4 Nov 2012',...  
        '43/ 2.7391 GeV, 122 BPMs nanoscopium from January 2012 + waist px2 test 08-04-2013',...
        '44/ 2.7391 GeV, 122 BPMs nanoscopium from January 2012 0.176 0.234+ bx_inj=11m', ...
        '45/ 2.7391 GeV, 122 BPMs nanoscopium from January 2012 + waist px2 + betaz = 1m',...
        '46/ 2.7391 GeV, 122 BPMs nanoscopium from January 2012 0.155 0.229 + bx=11m SDL01-09', ...
        '47/ 2.7391 GeV, Mode 46 + 4 XBPM', ...
        '48/ 2.7391 GeV, 122 BPMs nanoscopium from January 2012 0.155 0.229 + bx=11m SDL01-09 + 6 Correctors', ...
        '49/ 2.7391 GeV, Mode 46 + 4 XBPM + 6 Correctors', ...
        '50/ 2.7391 GeV, Mode 48 + bz=1m SDC03 (January 2015)', ... 
        '51/ 2.7391 GeV, Mode 48 + bz=1m SDC03 + betax = 18 m au lieu de 10 m (October 2015)', ... 
        '52/ 2.7391 GeV, Mode 60 + bz=1m SDC + betax = 12 m SDL13 (mai 2016)', ... 
        '53/ 2.7391 GeV, Mode 70 + bz=1m SDC + betax = 12 m SDL13 + betax=18 INJ (juin 2017)', ...     
        '54/ 2.7391 GeV, lattice 3.4 nm.rad (July 2017)', ...     
        'Laurent''s Mode'...
        };
    [ModeNumber, OKFlag] = listdlg('Name','SOLEIL','PromptString','Select the Operational Mode:', ...
        'SelectionMode','single', 'ListString', ModeCell, 'ListSize', [450 200], 'InitialValue', 48);

    if OKFlag ~= 1
        fprintf('   Operational mode not changed\n');
        return
    elseif ModeNumber == length(ModeCell);
        ModeNumber = 100;  % Laurent
    end
end
%add ModeNumber and SpecialTag in AD structure
AD=getad;
AD.ModeNumber = ModeNumber;
%for specify mode Number in Prompt
AD.SpecialTag=''; 
setad(AD);
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
AD.DeltaRFChro = [-100 -50 0 50 100] * 2*1e-6;

% Tune processor delay: delay required to wait
% to have a fresh tune measurement after changing
% a variable like the RF frequency.  Setpv will wait
% 2.2 * TuneDelay to be guaranteed a fresh data point.
%AD.BPMDelay  = 0.25; % use [N, BPMDelay]=getbpmaverages (AD.BPMDelay will disappear)
AD.TuneDelay = 1;

% The offset and golden orbits are stored at the end of this file
% TODO
%BuildOffsetAndGoldenOrbits;  % Local function
FileName_GoldenOrbit='GoldenBPM.mat'; %Default GoldenOrbit File you can specify another File in each operationalmode
FileName_GoldenXBPM ='GoldenXBPM.mat'; %Default GoldenXBPM File you can specify another File in each operationalmode

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
    local_set_config_mode('normalconfig120');
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
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
    local_set_config_mode('S11config120');
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
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
    % 18.1990 / 10.3170 April 2011
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.1990
        0.3100
        0.00642];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    local_set_config_mode('S11config120');
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
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

    local_set_config_mode('normalconfig120');
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
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
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
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
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
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
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_juin2009);
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
    local_set_config_mode('normalconfig120');
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients);
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
    local_set_config_mode('normalconfig120');
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_juin2009);

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
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);
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
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);
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
    local_set_config_mode('normalconfig120');
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients);
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
    local_set_config_mode('normalconfig120');
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients);
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
    local_set_config_mode('S11config120');
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients);
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
    local_set_config_mode('normalconfig120');
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients);
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
    local_set_config_mode('normalconfig120');
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_lowalpha);
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
    local_set_config_mode('normalconfig120');
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_lowalpha);
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

    local_set_config_mode('normalconfig120');    
    % Commented for shift January 2010
    %%AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_cal_lowalphaMAHER_Linterm);
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_low_alpha_janv2010);
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
    addpath(fullfile(getfamilydata('Directory','Lattice'), 'lowalpha_dec08')); %#ok<*MCAP>
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

    local_set_config_mode('S11config120');    
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_low_alpha_janv2010);
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
    
    local_set_config_mode('S11config120');    
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_low_alpha_janv2010);
    setao(AO);


    %% ModeNumber == 22 alpha1/10 AMOR december 2010 new calibration 20.77 9.2
elseif ModeNumber == 22
    % February 2010
    % alpha1/10 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/10 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha_over_10_AMOR';
    OpsFileExtension = '_alpha_over_10_AMOR';

    % AT lattice
    AD.ATModel = 'alphaby10_AMOR_new_mod_nov10_lin_auto_0';
    addpath(fullfile(getfamilydata('Directory','Lattice'), 'lowalpha_AMOR'));
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

    local_set_config_mode('S11config120');    
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_mod_low_alpha_AMOR_oct10);
    setao(AO);

    %% ModeNumber == 23 low alpha_nominal/10 MAHER 20.30 8.40 OD optimised (lin_1_auto) December 2010
elseif ModeNumber == 23
    % February 2010
    % alpha1/10 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/10 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha_over_10_MAHER_auto';
    OpsFileExtension = '_alpha_over_10_MAHER_auto';

    % AT lattice
    AD.ATModel = 'alphaby10_maher_opt_lin_1_auto';
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
    AD.Chromaticity.Golden = [0; 0];

    local_set_config_mode('S11config120');    
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_modele_low_alpha_oct2010_auto1);
    setao(AO);
    

    %% ModeNumber == 24 betaz=1m et betax=15m dans les sections courtes
    %% Fevrier 2011
elseif ModeNumber == 24
    AD.OperationalMode = '2.7391 GeV, betaz=1m SDC';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'betaz_1m_SDC';
    OpsFileExtension = '_betaz_1m_SDC';

    % AT lattice
    AD.ATModel = 'lat_betaz_1m_sdc';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 18.202 / 10.317
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.202
        0.317
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    local_set_config_mode('S11config120');    
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_mod_betaz_1m_fevrier2011);
    setao(AO);  
    
    %% ModeNumber == 25 low alphaMAHER alpha negatif by 10 20.30 8.40
    %% OD optimise auto Juin 2011
elseif ModeNumber == 25
    % February 2010
    % alpha1/10 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/10 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'malpha_over_10_MAHER_auto';
    OpsFileExtension = '_malpha_over_10_MAHER_auto';

    % AT lattice 
    %AD.ATModel = 'malphaby10_from_nominal_optics_step7gbis';
    AD.ATModel = 'malphaby10_maher_auto';
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
    AD.Chromaticity.Golden = [0; 0];
    setao(AO);
    
    local_InvertScaleFactor({'Q8','S1','S11'});
    local_set_config_mode('S11config120');    
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_alphaby10_maher_negatif_juin2011_auto);
   
   
    %% ModeNumber == 26 low alpha_nominal/200 from nominal optics 19.24 10.317 Juin 2011
elseif ModeNumber == 26
    % February 2010
    % alpha1/10 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/10 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha_over_200_nom_optics';
    OpsFileExtension = '_alpha_over_200_nom_optics';

    % AT lattice
    AD.ATModel = 'alphaby200_from_nominal_optics';
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
    AD.Chromaticity.Golden = [0; 0];
    setao(AO);
    
    local_set_config_mode('S11config120');    
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_alphaby10_from_nomopt_positif_juin2011);

    % commentaire : ce magnet coefficient a bien et verifie 15 juin 2011

    %% ModeNumber == 27 betax=15m dans les sections courtes + idem Nanoscopium juin 2011
elseif ModeNumber == 27
    AD.OperationalMode = '2.7391 GeV, betax=15m SDC + idem Nanoscopium';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'like_nanoscopium';
    OpsFileExtension = '_like_nanoscopium';

    % AT lattice
    AD.ATModel = 'lat_like_nanoscopium_juin2011';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 18.202 / 10.317
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.202
        0.317
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    local_set_config_mode('S11config120');    
    %%AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_mod_betaz_1m_fevrier2011);
    %AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_like_nanoscopium_juin2011);
    setao(AO);  
    
    %% ModeNumber == 28 122 BPMs with nominal lattice RUN3 2011 betax=5m en SDL
elseif ModeNumber == 28
    % User mode - Laurent
    AD.OperationalMode = '2.7391 GeV, 18.2 10.3';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'lat_1990_3170_122BPM';
    OpsFileExtension = '_122BPMs';

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

    setao(AO);
    
    local_set_config_mode('S11config122');
    AO = getao;
    %setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    %setfamilydata(ones(length(AO.VCOR.ElementList),1)*5e-6*2, 'VCOR', 'Setpoint', 'DeltaRespMat');
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2009);

   
    %% ModeNumber == 29 122 BPMs with nanoscopium from January 2012 0.176 0.234 
elseif ModeNumber == 29
    % User mode - Laurent
    AD.OperationalMode = '2.7391 GeV, 18.176 10.234';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'Nanoscopium';
    OpsFileExtension = '_nano_122BPMs';

    % AT lattice
    AD.ATModel = 'lat_nano_176_234_122BPM';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.1777
        0.2340
        NaN];
    AO.COUPLING.Golden = 1;


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.8; 2.3];

    setao(AO);
    local_set_config_mode('nanoscopiumconfig122C'); % with correctors
    %setfamilydata(1, 'BPMx', 'Status');
    %setfamilydata(1, 'BPMz', 'Status');
    AO = getao;
    %setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    %setfamilydata(ones(length(AO.VCOR.ElementList),1)*5e-6*2, 'VCOR', 'Setpoint', 'DeltaRespMat');
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);
    
    %% ModeNumber == 38 122 BPMs with nanoscopium lattice run machine 2011 0.170 0.250 
elseif ModeNumber == 38
    % User mode - Laurent
    AD.OperationalMode = '2.7391 GeV, 18.2 10.3';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'nano';
    OpsFileExtension = '_nano_122BPMs';

    % AT lattice
    AD.ATModel = 'lat_nano_17_25_122BPM';
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

    setao(AO);
    local_set_config_mode('nanoscopiumconfig122C'); % with correctors
    %setfamilydata(1, 'BPMx', 'Status');
    %setfamilydata(1, 'BPMz', 'Status');
    AO = getao;
    %setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    %setfamilydata(ones(length(AO.VCOR.ElementList),1)*5e-6*2, 'VCOR', 'Setpoint', 'DeltaRespMat');
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);
    
%% ModeNumber == 30 122 betax=15m dans les sections courtes + idem Nanoscopium juin 2011 122 BPM
elseif ModeNumber == 30
    AD.OperationalMode = '2.7391 GeV, betax=15m SDC + idem Nanoscopium';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'pseudo_nanoscopium';
    OpsFileExtension = '_122BPMs';

    % AT lattice
    AD.ATModel = 'lat_pseudo_nanoscopium_juin2011_122BPM';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 18.202 / 10.317
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.2020
        0.3100
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2.5];
    setao(AO); 
    local_set_config_mode('S11config122');    
    %%AO =% local_setmagnetcoefficient(AO, @magnetcoefficients_new_calib_new_mod_betaz_1m_fevrier2011);
   % local_setmagnetcoefficient(@magnetcoefficients_like_nanoscopium_juin2011);

%% ModeNumber == 31 122 betaz=1m et betax=15m dans les sections courtes Fevrier 2011 
elseif ModeNumber == 31
    AD.OperationalMode = '2.7391 GeV, betaz=1m SDC';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'betaz_1m_SDC';
    OpsFileExtension = '_122BPMs';

    % AT lattice
    AD.ATModel = 'lat_betaz_1m_sdc_122BPM';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 18.202 / 10.317
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.202
        0.317
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    setao(AO);
    local_set_config_mode('S11config122'); 
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_mod_betaz_1m_fevrier2011);
    
%% ModeNumber == 32 122 BPMs alpha1/10 new calibration 20.3 8.4
elseif ModeNumber == 32
    % February 2010
    % alpha1/10 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/10 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha_over_10';
    OpsFileExtension = '_122BPMs';

    % AT lattice
    AD.ATModel = 'alphaby10_nouveau_modele_dec08_opt_lin_1_122BPM';
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

    setao(AO);
    local_set_config_mode('S11config122');    
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_low_alpha_janv2010);

    %% ModeNumber == 33 122 BPMs alpha1/1000 new calibration 20.3 8.4
elseif ModeNumber == 33
    % February 2010
    % alpha1/1000 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha_nominal/100 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha_over_100';
    OpsFileExtension = '_122BPMs';

    % AT lattice
    AD.ATModel = 'alphaby100_new_mod_janvier2010_opt_nonlin_ksi_2_2_122BPM';
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
    
    setao(AO);
    local_set_config_mode('S11config122');    
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_low_alpha_janv2010);
        
        %% ModeNumber == 34 122 BPMs low alpha_nominal/10 MAHER 20.30 8.40 OD optimise (lin_1_auto) December 2010
elseif ModeNumber == 34
    % February 2010
    % alpha1/10 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/10 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha_over_10_MAHER_auto';
    OpsFileExtension = '_122BPMs';

    % AT lattice
    AD.ATModel = 'alphaby10_maher_opt_lin_1_auto_122BPM';
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
    AD.Chromaticity.Golden = [0; 0];

    setao(AO);
    local_set_config_mode('S11config122');    
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_low_alpha_oct2010_auto1);

    %% ModeNumber == 35 122 BPMs low alphaMAHER alpha negatif by 10 20.30 8.40 
    % OD optimise auto Juin 2011 122 BPM
elseif ModeNumber == 35
    % February 2010
    % alpha1/10 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/10 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'malpha_over_10_MAHER_auto';
    OpsFileExtension = '_122BPM';

    % AT lattice 
    %AD.ATModel = 'malphaby10_from_nominal_optics_step7gbis';
    AD.ATModel = 'malphaby10_maher_auto_122BPM';
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
    AD.Chromaticity.Golden = [0; 0];
  
    setao(AO);
    local_set_config_mode('S11config122');    
   % local_setmagnetcoefficient(@magnetcoefficients_alphaby10_maher_negatif_juin2011_auto);

       %% ModeNumber == 36 pseudo alpha1/25 new calibration 20.3 8.4 122 BPMs/home/matlabML/machine/SOLEIL
elseif ModeNumber == 36
    % February 2010
    % alpha1/10 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/10 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha_over_25';
    AD.SpecialTag=ModeName;
    OpsFileExtension = '_122BPMs';

    % AT lattice
    AD.ATModel = 'alphaby25_stepalpha1_new_modele_dec08_opt_lin_1_122BPM';
    % alphaby100_stepalpha1_new_modele_opt_lin_122BPM.m
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
    AD.DeltaRFDisp = 4e-6;
    AD.DeltaRFChro = [-10 -5 0 5 10] * 1e-6;

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2];

    setao(AO);

    % Response matrix kick in radians HCOR VCOR FHCOR FVCOR
    local_setResponseMatrixKick(5e-6, 5e-6, 3e-6, 3e-6) 
    
    local_InvertScaleFactor({'Q8','S1','S11'});   
    local_set_config_mode('S11config122');    
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_low_alpha_janv2010); 
 
           %% ModeNumber == 41 pseudo alpha1/100 new calibration 20.3 8.4 122 BPMs
elseif ModeNumber == 41
    % February 2010
    % alpha1/10 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/10 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha_over_100_new';
    AD.SpecialTag=ModeName;
    OpsFileExtension = '_122BPMs';

    % AT lattice
    AD.ATModel = 'alphaby100_stepalpha1_new_modele_opt_lin_122BPM';
    % alphaby100_stepalpha1_new_modele_opt_lin_122BPM.m
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

    setao(AO);
    local_set_config_mode('S11config122');    
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_low_alpha_janv2010); 

               %% ModeNumber == 42 pseudo alpha1/150 new calibration 20.3 8.4 122 BPMs
elseif ModeNumber == 42
    % February 2010
    % alpha1/10 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/10 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha_over_150';
    AD.SpecialTag=ModeName;
    OpsFileExtension = '_122BPMs';

    % AT lattice
    AD.ATModel = 'alphaby150_stepalpha1_sept2012_opt_lin_122BPM';
    %alphaby100_stepalpha1_new_modele_opt_lin_122BPM';
    % alphaby100_stepalpha1_new_modele_opt_lin_122BPM.m
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
    AD.Chromaticity.Golden = [4; 2];

    setao(AO);
    local_set_config_mode('S11config122');    
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_low_alpha_janv2010);
    
%% ModeNumber == 39 122 BPMs alpha1/25 new calibration 20.3 8.4 betaz local CRISTAL augmente � 2.6m
elseif ModeNumber == 39
    % February 2010
    % alpha1/10 new calibration 20.3 8.4
    AD.OperationalMode = '2.7391 GeV, alpha1/10 new calibration';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'alpha_over_25_CRISTAL';
    AD.SpecialTag=ModeName;
    OpsFileExtension = '_122BPMs';

    % AT lattice
    AD.ATModel = 'alphaby25_nouveau_modele_opt_lin_122BPM_bz_2p6m_CRISTAL_auto';
    %AD.ATModel = 'alphaby25_nouveau_modele_opt_lin_122BPM_bz_2p6m_CRISTAL';
    %AD.ATModel = 'alphaby10_nouveau_modele_dec08_opt_lin_1_122BPM_bz_CRISTAL';
    addpath(fullfile(getfamilydata('Directory','Lattice'), 'lowalpha_dec08'));
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 20.30 / 8.40
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.30
        0.38
        NaN];

    % Defaults RF for dispersion and chromaticity measurements (must be in Hardware units)
    AD.DeltaRFDisp = 10e-6;
    AD.DeltaRFChro = [-10 -5 0 5 10] * 1e-6;

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [0; 0];

    % Response matrix
    devnumber = length(AO.HCOR.Status);
    AO.HCOR.Setpoint.DeltaRespMat(:,:) = ones(devnumber,1)*5e-6*2; % 2*2.5 urad (half used for kicking)
    AO.HCOR.Setpoint.DeltaRespMat = physics2hw(AO.HCOR.FamilyName,'Setpoint', ...
        AO.HCOR.Setpoint.DeltaRespMat, AO.HCOR.DeviceList);
    
    AO.VCOR.Setpoint.DeltaRespMat(:,:) = ones(devnumber,1)*5e-6*2; % 2*5 urad (half used for kicking)
    AO.VCOR.Setpoint.DeltaRespMat = physics2hw(AO.VCOR.FamilyName,'Setpoint', ...
        AO.VCOR.Setpoint.DeltaRespMat, AO.HCOR.DeviceList);

    
    setao(AO);
    local_set_config_mode('S11config122');    
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_mod_low_alpha_CRISTAL);

    % Quad before and after CRISTAL section 
    % Need to point to another family for magnetcoefficients (other range of current)
    % Q6 upstream  PROBLEME il n'existe pas de quad d�j� dans cette gamme
%     HW2PhysicsParams = magnetcoefficients_new_calib_new_mod_low_alpha_CRISTAL('Q6SDC');
%     AO.Q6.Monitor.HW2PhysicsParams{1}(8,:)  = HW2PhysicsParams;
%     AO.Q6.Monitor.Physics2HWParams{1}(8,:)  = HW2PhysicsParams;
%     AO.Q6.Setpoint.HW2PhysicsParams{1}(8,:) = HW2PhysicsParams;
%     AO.Q6.Setpoint.Physics2HWParams{1}(8,:)  = HW2PhysicsParams;
%     % Q6 downstream
%     AO.Q6.Monitor.HW2PhysicsParams{1}(9,:)  = HW2PhysicsParams;
%     AO.Q6.Monitor.Physics2HWParams{1}(9,:)  = HW2PhysicsParams;
%     AO.Q6.Setpoint.HW2PhysicsParams{1}(9,:) = HW2PhysicsParams;
%     AO.Q6.Setpoint.Physics2HWParams{1}(9,:) = HW2PhysicsParams;
%     % Q7 upstream
%     HW2PhysicsParams = magnetcoefficients_new_calib_new_mod_low_alpha_CRISTAL('Q2');
%     AO.Q7.Monitor.HW2PhysicsParams{1}(8,:)  = HW2PhysicsParams;
%     AO.Q7.Monitor.Physics2HWParams{1}(8,:)  = HW2PhysicsParams;
%     AO.Q7.Setpoint.HW2PhysicsParams{1}(8,:) = HW2PhysicsParams;
%     AO.Q7.Setpoint.Physics2HWParams{1}(8,:) = HW2PhysicsParams;
%     % Q7 downstream
%     AO.Q7.Monitor.HW2PhysicsParams{1}(9,:)  = HW2PhysicsParams;
%     AO.Q7.Monitor.Physics2HWParams{1}(9,:)  = HW2PhysicsParams;
%     AO.Q7.Setpoint.HW2PhysicsParams{1}(9,:) = HW2PhysicsParams;
%     AO.Q7.Setpoint.Physics2HWParams{1}(9,:) = HW2PhysicsParams;
%     % Q8 upstream
%     HW2PhysicsParams = magnetcoefficients_new_calib_new_mod_low_alpha_CRISTAL('Q8SDC');
%     AO.Q8.Monitor.HW2PhysicsParams{1}(8,:)  = HW2PhysicsParams;
%     AO.Q8.Monitor.Physics2HWParams{1}(8,:)  = HW2PhysicsParams;
%     AO.Q8.Setpoint.HW2PhysicsParams{1}(8,:) = HW2PhysicsParams;
%     AO.Q8.Setpoint.Physics2HWParams{1}(8,:) = HW2PhysicsParams;
%     % Q8 downstream
%     AO.Q8.Monitor.HW2PhysicsParams{1}(9,:)  = HW2PhysicsParams;
%     AO.Q8.Monitor.Physics2HWParams{1}(9,:)  = HW2PhysicsParams;
%     AO.Q8.Setpoint.HW2PhysicsParams{1}(9,:) = HW2PhysicsParams;
%     AO.Q8.Setpoint.Physics2HWParams{1}(9,:) = HW2PhysicsParams;
% 
%     % Q9 upstream
%     HW2PhysicsParams = magnetcoefficients_new_calib_new_mod_low_alpha_CRISTAL('Q9SDC');
%     AO.Q9.Monitor.HW2PhysicsParams{1}(5,:)  = HW2PhysicsParams;
%     AO.Q9.Monitor.Physics2HWParams{1}(5,:)  = HW2PhysicsParams;
%     AO.Q9.Setpoint.HW2PhysicsParams{1}(5,:) = HW2PhysicsParams;
%     AO.Q9.Setpoint.Physics2HWParams{1}(5,:) = HW2PhysicsParams;
%     % Q9 downstream
%     AO.Q9.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
%     AO.Q9.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
%     AO.Q9.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
%     AO.Q9.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;
%     
%     % Q10 upstream
%     HW2PhysicsParams = magnetcoefficients_new_calib_new_mod_low_alpha_CRISTAL('Q10');
%     AO.Q10.Monitor.HW2PhysicsParams{1}(5,:)  = HW2PhysicsParams;
%     AO.Q10.Monitor.Physics2HWParams{1}(5,:)  = HW2PhysicsParams;
%     AO.Q10.Setpoint.HW2PhysicsParams{1}(5,:) = HW2PhysicsParams;
%     AO.Q10.Setpoint.Physics2HWParams{1}(5,:) = HW2PhysicsParams;
%     % Q10 downstream
%     AO.Q10.Monitor.HW2PhysicsParams{1}(6,:)  = HW2PhysicsParams;
%     AO.Q10.Monitor.Physics2HWParams{1}(6,:)  = HW2PhysicsParams;
%     AO.Q10.Setpoint.HW2PhysicsParams{1}(6,:) = HW2PhysicsParams;
%     AO.Q10.Setpoint.Physics2HWParams{1}(6,:) = HW2PhysicsParams;

    setao(AO);    

    %% ModeNumber == 37 122 User mode - S11 betax=10m till November 2010   .202 .317  122 BPMs
elseif ModeNumber == 37
    AD.OperationalMode = '2.7391 GeV,18.202 10.317 S11';
    AD.Energy = 2.7391; % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'lat_2020_3170f';
    OpsFileExtension = '_122BPMs';
   
    % AT lattice
    AD.ATModel = 'lat_2020_3170f_122BPM';
    eval(AD.ATModel);  %run model for compiler;

    % Golden TUNE is with the TUNE family
    % 18.202 / 10.317
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.202
        0.317
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2; 2.6];

    setao(AO);

    % Response matrix kick in radians HCOR VCOR FHCOR FVCOR
    local_setResponseMatrixKick(5e-6, 10e-6, 3e-6, 3e-6) 

    local_set_config_mode('S11config122'); 
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_mod_betaz_1m_fevrier2011);

   %% ModeNumber == 40 122 BPMs + 4 XBPM with nanoscopium from March 2012 0.176 0.234 
elseif ModeNumber == 40
    % User mode - Laurent
    AD.OperationalMode = '2.7391 GeV, 18.176 10.234';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'Nanoscopium_XBPM';
    OpsFileExtension = '_nano_122BPMs';

    % AT lattice
    AD.ATModel = 'lat_nano_176_234_122BPM_XBPM';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.176
        0.234
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.8; 2.3];

    setao(AO);
    
    % Response matrix kick in radians HCOR VCOR FHCOR FVCOR
    local_setResponseMatrixKick(5e-6, 10e-6, 3e-6, 3e-6) 
    
    local_set_config_mode('nanoscopiumconfig122C'); % with correctors
    %setfamilydata(1, 'BPMx', 'Status');
    %setfamilydata(1, 'BPMz', 'Status');
    AO = getao;
    %setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    %setfamilydata(ones(length(AO.VCOR.ElementList),1)*5e-6*2, 'VCOR', 'Setpoint', 'DeltaRespMat');
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);
 
        %% ModeNumber == 43 122 BPMs with nanoscopium from January 2012 0.176 0.234 + waist PX2 test du 08 avril 2013 
elseif ModeNumber == 43
    % User mode - Laurent
    AD.OperationalMode = '2.7391 GeV, 18.176 10.234';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'Nanoscopium_waist_px2';
    OpsFileExtension = '_nano_122BPMs_waist_px2';

    % AT lattice
    AD.ATModel = 'lat_nano_176_234_122BPM_waist_px2';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.176
        0.234
        NaN];
    AO.COUPLING.Golden = 1;


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.8; 2.3];

    setao(AO);
    
    % Response matrix kick in radians HCOR VCOR FHCOR FVCOR
    local_setResponseMatrixKick(5e-6, 10e-6, 3e-6, 3e-6) 

    local_set_config_mode('nanoscopiumconfig122C'); % with correctors
    %setfamilydata(1, 'BPMx', 'Status');
    %setfamilydata(1, 'BPMz', 'Status');
    AO = getao;
    %setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    %setfamilydata(ones(length(AO.VCOR.ElementList),1)*5e-6*2, 'VCOR', 'Setpoint', 'DeltaRespMat');
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);

            %% ModeNumber == 44 122 BPMs with nanoscopium from January 2012 0.176 0.234 + bx_inj=11m test du 15 avril 2013 
elseif ModeNumber == 44
    % User mode - Laurent
    AD.OperationalMode = '2.7391 GeV, 18.176 10.234';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'Nanoscopium_bxinj11m';
    OpsFileExtension = '_nano_122BPMs_bxinj11m';

    % AT lattice
    AD.ATModel = 'lat_nano_176_234_122BPM_bxinj11m';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.172
        0.234
        NaN];
    AO.COUPLING.Golden = 1;


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [2.0 ; 2.3];

    setao(AO);
        
    % Response matrix kick in radians HCOR VCOR FHCOR FVCOR
    local_setResponseMatrixKick(5e-6, 10e-6, 3e-6, 3e-6) 

    local_set_config_mode('nanoscopiumconfig122C'); % with correctors
    %setfamilydata(1, 'BPMx', 'Status');
    %setfamilydata(1, 'BPMz', 'Status');
    AO = getao;
    %setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    %setfamilydata(ones(length(AO.VCOR.ElementList),1)*5e-6*2, 'VCOR',
    %'Setpoint', 'DeltaRespMat');
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);

            %% ModeNumber == 45 122 BPMs with nanoscopium from January 2012 0.176 0.234 + waist PX2 + betaz = 1m ajouté le 28-08-2013 
elseif ModeNumber == 45
    % User mode - Laurent
    AD.OperationalMode = '2.7391 GeV, 18.176 10.234';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'Nanoscopium_waist_px2_betaz_1m';
    OpsFileExtension = '_nano_122BPMs_waist_px2_betaz_1m';

    % AT lattice
    AD.ATModel = 'lat_nano_176_234_122BPM_waist_px2_betaz_1m';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.176
        0.234
        NaN];
    AO.COUPLING.Golden = 1;


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.8; 2.3];

    setao(AO);

    % Response matrix kick in radians HCOR VCOR FHCOR FVCOR
    local_setResponseMatrixKick(5e-6, 10e-6, 3e-6, 3e-6) 
    
    local_set_config_mode('nanoscopiumconfig122C'); % with correctors
    %setfamilydata(1, 'BPMx', 'Status');
    %setfamilydata(1, 'BPMz', 'Status');
    AO = getao;
    %setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    %setfamilydata(ones(length(AO.VCOR.ElementList),1)*5e-6*2, 'VCOR', 'Setpoint', 'DeltaRespMat');
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);

    
    %% ModeNumber == 46 122 BPMs with nanoscopium from January 2012 0.155 0.229 + bx=11m SDL01-09
elseif ModeNumber == 46
    AD.OperationalMode = '2.7391 GeV, 18.155 10.229';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'Nanoscopium_bx11m_SDL01_09';
    OpsFileExtension = '_nano_122BPMs_bx11m_SDL01_09';

    % AT lattice
    AD.ATModel = 'lat_nano_155_229_122BPM_bxSDL01_09_11m';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.155
        0.229
        NaN];
    AO.COUPLING.Golden = 1;


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.2 ; 2.4];
    
    setao(AO);

    % Response matrix kick in radians HCOR VCOR FHCOR FVCOR
    local_setResponseMatrixKick(5e-6, 10e-6, 3e-6, 3e-6) 

    local_set_config_mode('nanoscopiumconfig122C'); % with correctors
    %setfamilydata(1, 'BPMx', 'Status');
    %setfamilydata(1, 'BPMz', 'Status');
    AO = getao;
    %setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    %setfamilydata(ones(length(AO.VCOR.ElementList),1)*5e-6*2, 'VCOR',
    %'Setpoint', 'DeltaRespMat');
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);

    %% ModeNumber == 47 122 BPMs with nanoscopium from January 2012 0.155 0.229 + bx=11m SDL01-09
elseif ModeNumber == 47
    AD.OperationalMode = '2.7391 GeV, 18.155 10.229';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'Nanoscopium_bx11m_SDL01_09_XBPM';
    OpsFileExtension = '_nano_122BPMs_bx11m_SDL01_09';

    % AT lattice
    AD.ATModel = 'lat_nano_155_229_122BPM_bxSDL01_09_11m_XBPM';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.155
        0.229
        NaN];
    AO.COUPLING.Golden = 1;


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.2 ; 2.4];

    setao(AO);
    
    % Response matrix kick in radians HCOR VCOR FHCOR FVCOR
    local_setResponseMatrixKick(5e-6, 10e-6, 3e-6, 3e-6) 

    local_set_config_mode('nanoscopiumconfig122C'); % with correctors
    %setfamilydata(1, 'BPMx', 'Status');
    %setfamilydata(1, 'BPMz', 'Status');
    AO = getao;
    %setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    %setfamilydata(ones(length(AO.VCOR.ElementList),1)*5e-6*2, 'VCOR',
    %'Setpoint', 'DeltaRespMat');
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);
%% ModeNumber == 48 122 BPMs with nanoscopium from January 2012 0.155 0.229 + bx=11m SDL01-09+ 6New_Corrector
elseif ModeNumber == 48
    AD.OperationalMode = '2.7391 GeV, 18.155 10.229';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
   
    ModeName = 'Nanoscopium_bx11m_SDL01_09_6Corr';
    OpsFileExtension = '_nano_122BPMs_bx11m_SDL01_09+6cor';
    %AD.SpecialTag='Operation';
    % AT lattice
    AD.ATModel = 'lat_nano_155_229_122BPM_bxSDL01_09_11m';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.155
        0.229
        NaN];
    AO.COUPLING.Golden = 1;


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.2 ; 2.0];

    setao(AO);
      
    % Response matrix kick in radians HCOR VCOR FHCOR FVCOR
    local_setResponseMatrixKick(5e-6, 10e-6, 3e-6, 3e-6) 
        
    local_set_config_mode('nanoscopiumconfig122B_6C'); % with 6 new correctors in October 2014
    %setfamilydata(1, 'BPMx', 'Status');
    %setfamilydata(1, 'BPMz', 'Status');
    AO = getao;
    %setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    %setfamilydata(ones(length(AO.VCOR.ElementList),1)*5e-6*2, 'VCOR',
    %'Setpoint', 'DeltaRespMat');
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);    
%% ModeNumber == 49 122 BPMs with nanoscopium from January 2012 0.155 0.229 + bx=11m SDL01-09+4XBPM+6New_Corrector
elseif ModeNumber == 49
    AD.OperationalMode = '2.7391 GeV, 18.155 10.229';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'Nanoscopium_bx11m_SDL01_09_XBPM_6Corr';
    OpsFileExtension = '_nano_122BPMs_bx11m_SDL01_09+6cor';
    
    % AT lattice
    AD.ATModel = 'lat_nano_155_229_122BPM_bxSDL01_09_11m_XBPM';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.155
        0.229
        NaN];
    AO.COUPLING.Golden = 1;


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.2 ; 2.4];

    setao(AO);
  
    % Response matrix kick in radians HCOR VCOR FHCOR FVCOR
    local_setResponseMatrixKick(5e-6, 10e-6, 3e-6, 3e-6) 

    local_set_config_mode('nanoscopiumconfig122B_6C'); % with 6 new correctors in October 2014
    %setfamilydata(1, 'BPMx', 'Status');
    %setfamilydata(1, 'BPMz', 'Status');
    AO = getao;
    %setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    %setfamilydata(ones(length(AO.VCOR.ElementList),1)*5e-6*2, 'VCOR',
    %'Setpoint', 'DeltaRespMat');
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);

    %% ModeNumber == 50 122 BPMs with nanoscopium from January 2015 bz=1m
    %% SDC03+6New_Corrector Golden RUN5 2013
elseif ModeNumber == 50
    AD.OperationalMode = '2.7391 GeV, 18.155 10.229';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
   
    ModeName = 'Nanoscopium_bz1m_SDC03';
    OpsFileExtension = '_nano_122BPMs_bz1m_SDC03';
    %AD.SpecialTag='Operation';
    % AT lattice
    AD.ATModel = 'lat_betaz_1m_SDC03_Golden_RUN5_2013';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.155
        0.229
        NaN];
    AO.COUPLING.Golden = 1;


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.2 ; 2.4];

    setao(AO);

    % Response matrix kick in radians HCOR VCOR FHCOR FVCOR
    local_setResponseMatrixKick(5e-6, 10e-6, 3e-6, 3e-6) 

    
    local_set_config_mode('nanoscopiumconfig122B_6C'); % with 6 new correctors in October 2014
    AO = getao;
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);    

        %% ModeNumber == 51 122 BPMs with nanoscopium from January 2015
        %% bz=1m + betax augmente de 10 à 18 m + etax = 0.22 m
    %% SDC03+6New_Corrector Golden RUN5 2013
elseif ModeNumber == 51
    AD.OperationalMode = '2.7391 GeV, 18.155 10.229';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
   
    ModeName = 'Nanoscopium_bz1m_SDC03_2';
    OpsFileExtension = '_nano_122BPMs_bz1m_SDC03_2';
    %AD.SpecialTag='Operation';
    % AT lattice
    AD.ATModel = 'lat_betaz_1m_SDC03_2_Golden_RUN5_2013';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.155
        0.229
        NaN];
    AO.COUPLING.Golden = 1;


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.2 ; 2.4];

    setao(AO);

    % Response matrix kick in radians HCOR VCOR FHCOR FVCOR
    local_setResponseMatrixKick(5e-6, 10e-6, 3e-6, 3e-6) 

    
    local_set_config_mode('nanoscopiumconfig122B_6C'); % with 6 new correctors in October 2014
    AO = getao;
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m);    

    %% ModeNumber == 60 122 BPMs with nanoscopium and bz=1m in all SDC and bz=1.3m in all SDM
  elseif ModeNumber == 60
    % User mode 
    AD.OperationalMode = '2.7391 GeV, 18.160 11.220';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'nano_bz1m_SDC';
    OpsFileExtension = '_nano_122BPMs_bz1m_SDC';

    % AT lattice
    AD.ATModel = 'lat_nano_160_220_122BPM_bzSDC_1m_limQ11';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    % 18.20 / 10.30
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.160
        0.220
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.2 ; 2];

    setao(AO);
    local_set_config_mode('nanoscopiumconfig122B_6C'); % with correctors
    %setfamilydata(1, 'BPMx', 'Status');
    %setfamilydata(1, 'BPMz', 'Status');
    AO = getao;
    %setfamilydata(ones(length(AO.HCOR.ElementList),1)*5e-6*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    %setfamilydata(ones(length(AO.VCOR.ElementList),1)*5e-6*2, 'VCOR', 'Setpoint', 'DeltaRespMat');
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2016_nano_sdc1m);
   
      %% ModeNumber == 70 122 BPMs with nanoscopium and bz=1m in all SDC and
   %% bz=1.3m in all SDM  + bx=18m at injection (only quad around injection are modified)
  elseif ModeNumber == 70
    % User mode - Laurent
    AD.OperationalMode = '2.7391 GeV, 18.122 10.185';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
    ModeName = 'nano_bx18m_bz1m_SDC';
    OpsFileExtension = '_nano_122BPMs_bx18m_bz1m_SDC';

    % AT lattice
    AD.ATModel = 'lat_nano_122_185_122BPM_bxINJ_18m_bzSDC_1m_limQ11';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.122
        0.185
        NaN];

    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.2 ; 2];

    setao(AO);
    local_set_config_mode('nanoscopiumconfig122C'); % with correctors
    AO = getao;
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_juin2016_nano_sdc1m);

%% ModeNumber == 54 lattice low emittance 3.4 nm.rad
  elseif ModeNumber == 54
    AD.OperationalMode = '2.7391 GeV, 18.262 10.310';
    AD.Energy = 2.7391;     % Make sure this is the same as bend2gev at the production lattice!
   
    ModeName = 'lat_34nm';
    OpsFileExtension = '_lat_34nm';
    %AD.SpecialTag='Operation';
    % AT lattice
    AD.ATModel = 'lat_34nm_16_23';
    run(AD.ATModel);

    % Golden TUNE is with the TUNE family
    AO = getao;
    AO.TUNE.Monitor.Golden = [
        0.16
        0.23
        NaN];
    AO.COUPLING.Golden = 1;


    % Golden chromaticity is in the AD (Physics units)
    AD.Chromaticity.Golden = [1.2 ; 2.4];

    setao(AO);

    % Response matrix kick in radians HCOR VCOR FHCOR FVCOR
    local_setResponseMatrixKick(5e-6, 10e-6, 3e-6, 3e-6) 

    
    local_set_config_mode('nanoscopiumconfig122B_6C'); % with 6 new correctors in October 2014
    AO = getao;
   % local_setmagnetcoefficient(@magnetcoefficients_lowemit);    

    
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

    setao(AO);
    setfamilydata(ones(120,1)*1e-5, 'HCOR', 'Setpoint', 'DeltaRespMat');
    setfamilydata(ones(120,1)*1e-5, 'VCOR', 'Setpoint', 'DeltaRespMat');
    % AO.(ifam).Setpoint.DeltaRespMat(:,:) = ones(nb,1)*0.5e-4*1; % 2*25 urad (half used for kicking)
    local_set_config_mode('normalconfig120');    
   % local_setmagnetcoefficient(@magnetcoefficients_new_calib_new_modele_low_alpha_janv2010);

 else
    error('Operational mode unknown');
end


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
MMLROOT = setmmldirectories(AD.Machine, AD.SubMachine, ModeName, OpsFileExtension);
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
AD.Directory.ConfigData     = fullfile(getmmlconfigroot, 'machine', 'SOLEIL', 'StorageRing', 'MachineConfig', filesep);
AD.Directory.BumpData       = fullfile(AD.Directory.DataRoot, 'Bumps', filesep);
AD.Directory.Archiving      = fullfile(AD.Directory.DataRoot, 'ArchivingData', filesep);
AD.Directory.QUAD           = fullfile(AD.Directory.DataRoot, 'QUAD', filesep);
AD.Directory.BBA            = fullfile(AD.Directory.DataRoot, 'BBA', filesep);
AD.Directory.BBAcurrent     = fullfile(AD.Directory.BBA, 'dafault' ,filesep);
AD.Directory.PINHOLE        = fullfile(AD.Directory.DataRoot, 'PINHOLE', filesep);
AD.Directory.Synchro        = fullfile(MMLROOT, 'machine', 'SOLEIL', 'common', 'synchro', filesep);
AD.Directory.LOCOData       = fullfile(AD.Directory.DataRoot, 'LOCO', filesep);

AD.Directory.ConfigOpsData  = fullfile(getmmlconfigroot, 'machine', 'SOLEIL', 'StorageRingOpsData', filesep);
AD.Directory.BPMGolden      = fullfile(AD.Directory.ConfigOpsData, 'GoldenOrbit', filesep);
AD.Directory.LOCOGolden     = fullfile(AD.Directory.ConfigOpsData, 'GoldenLOCO', filesep);

% Insertion Devices
DATADIR = getdataroot;
res=idGetParamForUndSOLEIL('ALL');
for idx =1:numel(res)
    IDDirec=res(idx).Directory;
    ID_data_Path=fullfile(DATADIR, 'GMI', IDDirec, filesep);
    AD.Directory.(IDDirec) = ID_data_Path;
    if 7 ~= exist(ID_data_Path,'dir')
        mkdir(ID_data_Path);
    end    
    %AD.Directory.('field')=fullfile(DATADIR, 'GMI', IDDirec, filesep);
end    
% OLD way to set DataPath for undulator 
% AD.Directory.HU80_TEMPO     = fullfile(DATADIR, 'GMI', 'HU80_TEMPO', filesep);
% AD.Directory.HU80_PLEIADES  = fullfile(DATADIR, 'GMI', 'HU80_PLEIADES', filesep);
% AD.Directory.HU80_SEXTANTS  = fullfile(DATADIR, 'GMI', 'HU80_SEXTANTS', filesep);
% AD.Directory.HU60_CASSIOPEE = fullfile(DATADIR, 'GMI', 'HU60_CASSIOPEE', filesep);
% AD.Directory.HU60_ANTARES   = fullfile(DATADIR, 'GMI', 'HU60_ANTARES', filesep);
% AD.Directory.U20_PROXIMA1   = fullfile(DATADIR, 'GMI', 'U20_PROXIMA1', filesep);
% AD.Directory.U20_SWING      = fullfile(DATADIR, 'GMI', 'U20_SWING', filesep);
% AD.Directory.U20_CRISTAL    = fullfile(DATADIR, 'GMI', 'U20_CRISTAL', filesep);
% AD.Directory.U20_SIXS       = fullfile(DATADIR, 'GMI', 'U20_SIXS', filesep);
% AD.Directory.U20_GALAXIES   = fullfile(DATADIR, 'GMI', 'U20_GALAXIES2', filesep);
% AD.Directory.U24_PXIIA      = fullfile(DATADIR, 'GMI', 'U24_PXIIA ', filesep);
% AD.Directory.WSV50_PSICHE   = fullfile(DATADIR, 'GMI', 'WSV50_PSICHE ', filesep);
% AD.Directory.W164_PUMA_SLICING = fullfile(DATADIR, 'GMI', 'W164_PUMA_SLICING ', filesep);
% AD.Directory.HU640_DESIRS   = fullfile(DATADIR, 'GMI', 'HU640_DESIRS', filesep);
% AD.Directory.HU256_CASSIOPEE= fullfile(DATADIR, 'GMI', 'HU256_CASSIOPEE', filesep);
% AD.Directory.HU256_PLEIADES = fullfile(DATADIR, 'GMI', 'HU256_PLEIADES', filesep);
% AD.Directory.HU256_ANTARES  = fullfile(DATADIR, 'GMI', 'HU256_ANTARES', filesep);
% AD.Directory.HU42_HERMES    = fullfile(DATADIR, 'GMI', 'HU42_HERMES', filesep);
% AD.Directory.HU44_TEMPO     = fullfile(DATADIR, 'GMI', 'HU44_TEMPO', filesep);
% AD.Directory.HU44_SEXTANTS  = fullfile(DATADIR, 'GMI', 'HU44_SEXTANTS', filesep);
% AD.Directory.HU52_DEIMOS    = fullfile(DATADIR, 'GMI', 'HU52_DEIMOS', filesep);
% AD.Directory.HU65_DEIMOS    = fullfile(DATADIR, 'GMI', 'HU65_DEIMOS', filesep);
% AD.Directory.HU52_LUCIA     = fullfile(DATADIR, 'GMI', 'HU52_LUCIA', filesep);
% AD.Directory.HU36_SIRIUS    = fullfile(DATADIR, 'GMI', 'HU36_SIRIUS', filesep);
% AD.Directory.HU64_HERMES    = fullfile(DATADIR, 'GMI', 'HU64_HERMES', filesep);
% AD.Directory.U18_TOMO       = fullfile(DATADIR, 'GMI', 'U18_TOMO', filesep);
% AD.Directory.U20_NANO       = fullfile(DATADIR, 'GMI', 'U20_NANO', filesep);


% STANDALONE matlab applications
AD.Directory.Standalone     = fullfile(MMLROOT, '..', filesep, 'standalone_applications', filesep);

% FOFB matlab applications
AD.Directory.FOFBdata     = fullfile(AD.Directory.DataRoot, 'FOFB', filesep);
AD.Directory.DG = fullfile(DATADIR,filesep,'DG', filesep, 'matlab', filesep);

% For coupling correction. Used by coupling.m
AD.Directory.Coupling     = fullfile(AD.Directory.DataRoot, 'SkewQuad', 'solution_QT');

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

%% Config texttalker, devicelock
AD.TANGO.TEXTTALKERS = {'ans/ca/texttalker.1', 'ans/ca/texttalker.2'};
AD.TANGO.SERVICELOCK = 'ANS/CA/SERVICE-LOCKER';

% set LOCO gain and roll to zero
setlocodata('Nominal');

%%%%%%%%%%%%%%%%%%%%%%
% Final mode changes %
%%%%%%%%%%%%%%%%%%%%%%
if any(ModeNumber == 99)
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
    % BasicalGoldely, use 'SetGains' or 'SetModel' if the LOCO run was applied to the accelerator
    %            use 'LOCO2Model' if the LOCO run was made after the final setup

    % Store the LOCO file in the opsdata directory

    % MCF depends on optics !!!

    AD.OpsData.LOCOFile = [getfamilydata('Directory','OpsData'),'LOCO_163Quads_122BPMs'];
    
    try % TO BE DONE LATER IN 2012
        setlocodata('LOCO2Model', AD.OpsData.LOCOFile);
    catch errRecord
        fprintf('\n%s\n\n', errRecord.identifier);
        fprintf('   WARNING: there was a problem calibrating the model based on LOCO file %s.\n', AD.OpsData.LOCOFile);
    end

else
    setlocodata('Nominal');
end

fprintf('   lattice files have changed or if the AT lattice has changed.\n');
fprintf('   Middlelayer setup for operational mode: %s\n', AD.OperationalMode);

setad(AD);

%% GOLDEN Orbit

%FileName_GoldenOrbit='GoldenBPM.mat';
DirectoryName = getfamilydata('Directory','BPMGolden');
FileName_GoldenOrbit=fullfile(DirectoryName,FileName_GoldenOrbit);
FileStruct = load(FileName_GoldenOrbit); % setfamilydata(Golden(:,3),'BPMx','Golden',Golden(:,1:2));

setgolden(FileStruct.Data1.FamilyName ,FileStruct.Data1.Data, FileStruct.Data1.DeviceList);
setgolden(FileStruct.Data2.FamilyName ,FileStruct.Data2.Data, FileStruct.Data2.DeviceList);
%setgolden(FileName_GoldenOrbit); %Bug setgolden Ok but send an error.
setfamilydata(FileStruct.Data1.TimeStamp,'BPMx','GoldenTimeStamp');%set a TimeStamp for GoldenOrbit
setfamilydata(FileStruct.Data2.TimeStamp,'BPMz','GoldenTimeStamp');

% update getgolden in TANGO BPMmanager
if iscontrolroom % update GoldenOrbit BPM-MANAGER
    %warning('Update of BPMmanager is disable on purpose');
    tango_goldenxorbit = tango_read_attribute2('ANS/DG/BPM-MANAGER','xRefOrbit');
    tango_goldenzorbit = tango_read_attribute2('ANS/DG/BPM-MANAGER','zRefOrbit');     
    if any(tango_goldenxorbit.value' ~= getgolden('BPMx')) || any(tango_goldenzorbit.value' ~= getgolden('BPMz'))
        if strcmp(questdlg('Write Orbit in BPMmanager?', 'Write Orbit in BPMmanager','Yes', 'No', 'No'), 'Yes')
            tango_write_attribute2('ANS/DG/BPM-MANAGER','xRefOrbit',getgolden('BPMx')')
            tango_write_attribute2('ANS/DG/BPM-MANAGER','zRefOrbit',getgolden('BPMz')')
        end    
    end    
 
end

Golden=[FileStruct.Data1.DeviceList FileStruct.Data1.Data FileStruct.Data2.Data];
FileName_GoldenXBPM=fullfile(DirectoryName,FileName_GoldenXBPM);
FileStruct = load(FileName_GoldenXBPM);
XBPMGolden=[FileStruct.Data1.DeviceList FileStruct.Data1.Data FileStruct.Data2.Data];
%create PBPMz golden 
PBPMzGolden=Golden;

xbpm_index=find(AO.PBPMz.Type==0); % check for xbpm in the family
for i=1:size(xbpm_index,1) % insert xbpm golden data in the BPM golden data
    PBPMzGolden = [PBPMzGolden(1:xbpm_index(i)-1,:)' XBPMGolden(i,:)' PBPMzGolden(xbpm_index(i):size(PBPMzGolden,1),:)']';
end

% set Golden orbit
setfamilydata(0.0,'PBPMz','Golden')
setfamilydata(PBPMzGolden(:,4),'PBPMz','Golden',PBPMzGolden(:,1:2));
setfamilydata(FileStruct.Data2.TimeStamp,'PBPMz','GoldenTimeStamp');
%%

if exist('setPrompt', 'file') == 2
    switch getmode('BPMx')
    case 'Online'
        switch2online;
    case 'Simulator'
        switch2sim;
    end
        
end

end

function local_InvertScaleFactor(family)
    AO = getao;
    if iscell(family)
        for i=1:length(family)
                %Inverted Powersupply you need to put ScaleFactor =-1 
                AO.(family{i}).Monitor.HW2PhysicsParams{2}(:)  =-1;
                AO.(family{i}).Monitor.Physics2HWParams{2}(:)  =-1;
        end 
        setao(AO);
    else
        error('Works only whith CellArray for Family')
    end    
end


function local_setmagnetcoefficient(magnetcoeff_function) %#ok<DEFNU>
% quadrupole magnet coefficients
% number of status 1 quadrupole families

AO = getao;
    
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
setao(AO);

end

function  local_setResponseMatrixKick(hcorK, vcorK, fhcorK, fvcorK)
AO = getao;
% local_setResponseMatrixKick - set absolute kick for responsematrix in
% urad
    fac = physics2hw(AO.HCOR.FamilyName,'Setpoint', 1 , AO.HCOR.DeviceList);    
    setfamilydata(ones(length(AO.HCOR.ElementList),1).*fac*hcorK*2, 'HCOR', 'Setpoint', 'DeltaRespMat');
    fac = physics2hw(AO.VCOR.FamilyName,'Setpoint', 1 , AO.VCOR.DeviceList);    
    setfamilydata(ones(length(AO.VCOR.ElementList),1).*fac*vcorK*2, 'VCOR', 'Setpoint', 'DeltaRespMat');
     
    fac = physics2hw(AO.FHCOR.FamilyName,'Setpoint', 1 , AO.FHCOR.DeviceList);    
    setfamilydata(ones(length(AO.FHCOR.ElementList),1).*fac*fhcorK*2, 'FHCOR', 'Setpoint', 'DeltaRespMat');
    fac = physics2hw(AO.FVCOR.FamilyName,'Setpoint', 1 , AO.FVCOR.DeviceList);    
    setfamilydata(ones(length(AO.FVCOR.ElementList),1).*fac*fvcorK*2, 'FVCOR', 'Setpoint', 'DeltaRespMat');
end

function  local_set_config_mode(configmode)
% Function for activating new families of quadrupole and sextupoles
% magnets.

switch(configmode)
    case 'S11config120' % with S11 120 BPMs to be obsolete
        setfamilydata(1, 'S11', 'Status')
        setfamilydata(0, 'S12', 'Status')
        setfamilydata(0, 'Q11', 'Status')
        setfamilydata(0, 'Q12', 'Status')
        setfamilydata(0, 'HCOR', 'Status', [13 8; 12 6; 13 9; 13 2]);
        setfamilydata(0, 'VCOR', 'Status', [13 9; 12 7; 13 8; 13 1]);
        setfamilydata(0, 'CycleHCOR', 'Status', [13 8; 12 6; 13 9; 13 2]);
        setfamilydata(0, 'CycleVCOR', 'Status', [13 9; 12 7; 13 8; 13 1]);
        setfamilydata(0, 'BPMx', 'Status', [13 8; 13 9]);
        setfamilydata(0, 'BPMz', 'Status', [13 8; 13 9]);
    case 'S11config122' % with S11 122 BPMs
        setfamilydata(1, 'S11', 'Status')
        setfamilydata(0, 'S12', 'Status')
        setfamilydata(0, 'Q11', 'Status')
        setfamilydata(0, 'Q12', 'Status')
        setfamilydata(1, 'HCOR', 'Status', [13 8]);
        setfamilydata(1, 'VCOR', 'Status', [13 9]);
        setfamilydata(1, 'CycleHCOR', 'Status', [13 8]);
        setfamilydata(1, 'CycleVCOR', 'Status', [13 9]);
        setfamilydata(0, 'HCOR', 'Status', [12 6; 13 9; 13 2]);
        setfamilydata(0, 'VCOR', 'Status', [12 7; 13 8; 13 1]);
        setfamilydata(0, 'CycleHCOR', 'Status', [12 6; 13 9; 13 2]);
        setfamilydata(0, 'CycleVCOR', 'Status', [12 7; 13 8; 13 1]);
        setfamilydata(1, 'BPMx', 'Status', [13 8; 13 9]);
        setfamilydata(1, 'BPMz', 'Status', [13 8; 13 9]);
    case 'normalconfig' % without S11 120 BPMs to be obsolete
        setfamilydata(0, 'S11', 'Status')
        setfamilydata(0, 'S12', 'Status')
        setfamilydata(0, 'Q11', 'Status')
        setfamilydata(0, 'Q12', 'Status')
        setfamilydata(0, 'HCOR', 'Status', [13 8; 12 6; 13 9; 13 2]);
        setfamilydata(0, 'VCOR', 'Status', [13 9; 12 7; 13 8; 13 1]);
        setfamilydata(0, 'CycleHCOR', 'Status', [13 8; 12 6; 13 9; 13 2]);
        setfamilydata(0, 'CycleVCOR', 'Status', [13 9; 12 7; 13 8; 13 1]);
        setfamilydata(0, 'BPMx', 'Status', [13 8; 13 9]);
        setfamilydata(0, 'BPMz', 'Status', [13 8; 13 9]);
    case 'nanoscopiumconfig120' % 120 BPMs to be obsolete
        setfamilydata(1, 'S11', 'Status')
        setfamilydata(1, 'S12', 'Status')
        setfamilydata(1, 'Q11', 'Status')
        setfamilydata(1, 'Q12', 'Status')
        setfamilydata(0, 'HCOR', 'Status', [13 8; 12 6; 13 9; 13 2]);
        setfamilydata(0, 'VCOR', 'Status', [13 9; 12 7; 13 8; 13 1]);
        setfamilydata(0, 'CycleHCOR', 'Status', [13 8; 12 6; 13 9; 13 2]);
        setfamilydata(0, 'CycleVCOR', 'Status', [13 9; 12 7; 13 8; 13 1]);
        setfamilydata(0, 'BPMx', 'Status', [13 8; 13 9]);
        setfamilydata(0, 'BPMz', 'Status', [13 8; 13 9]);
    case 'nanoscopiumconfig122' % 122 BPMs 
        setfamilydata(1, 'S11', 'Status')
        setfamilydata(1, 'S12', 'Status')
        setfamilydata(1, 'Q11', 'Status')
        setfamilydata(1, 'Q12', 'Status')
        setfamilydata(0, 'HCOR', 'Status', [13 8; 12 6; 13 9; 13 2]);
        setfamilydata(0, 'VCOR', 'Status', [13 9; 12 7; 13 8; 13 1]);
        setfamilydata(0, 'CycleHCOR', 'Status', [13 8; 12 6; 13 9; 13 2]);
        setfamilydata(0, 'CycleVCOR', 'Status', [13 9; 12 7; 13 8; 13 1]);
        setfamilydata(1, 'BPMx', 'Status', [13 8; 13 9]);
        setfamilydata(1, 'BPMz', 'Status', [13 8; 13 9]);
    case 'nanoscopiumconfig122C'
        setfamilydata(1, 'S11', 'Status')
        setfamilydata(1, 'S12', 'Status')
        setfamilydata(1, 'Q11', 'Status')
        setfamilydata(1, 'Q12', 'Status')
        setfamilydata(1, 'HCOR', 'Status', [13 8]);
        setfamilydata(1, 'VCOR', 'Status', [13 9]);
        setfamilydata(1, 'CycleHCOR', 'Status', [13 8]);
        setfamilydata(1, 'CycleVCOR', 'Status', [13 9]);
        setfamilydata(0, 'HCOR', 'Status', [12 6; 13 9; 13 2]);
        setfamilydata(0, 'VCOR', 'Status', [12 7; 13 8; 13 1]);
        setfamilydata(0, 'CycleHCOR', 'Status', [12 6; 13 9; 13 2]);
        setfamilydata(0, 'CycleVCOR', 'Status', [12 7; 13 8; 13 1]);
        setfamilydata(1, 'BPMx', 'Status', [13 8; 13 9]);
        setfamilydata(1, 'BPMz', 'Status', [13 8; 13 9]);
     case 'nanoscopiumconfig122B_6C'
        setfamilydata(1, 'S11', 'Status')
        setfamilydata(1, 'S12', 'Status')
        setfamilydata(1, 'Q11', 'Status')
        setfamilydata(1, 'Q12', 'Status')
        setfamilydata(1, 'HCOR', 'Status', [13 8; 12 6; 13 9; 13 2]);
        setfamilydata(1, 'VCOR', 'Status', [13 9; 12 7; 13 8; 13 1]);
        setfamilydata(1, 'CycleHCOR', 'Status', [13 8; 12 6; 13 9; 13 2]);
        setfamilydata(1, 'CycleVCOR', 'Status', [13 9; 12 7; 13 8; 13 1]);
        setfamilydata(1, 'BPMx', 'Status', [13 8; 13 9]);
        setfamilydata(1, 'BPMz', 'Status', [13 8; 13 9]);   
    otherwise
        error('Wrong mode')
end

% switch addition corrector for HU640... TO BE REMOVED LATER
switchHU640Cor('OFF');

end

