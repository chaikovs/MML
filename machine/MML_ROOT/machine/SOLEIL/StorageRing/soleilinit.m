function soleilinit(OperationalMode)
%SOLEILINIT - Initializes params for SOLEIL control in MATLAB
%
% Written by Laurent S. Nadolski, Synchrotron SOLEIL
%
%==========================
% Accelerator Family Fields
%==========================
% FamilyName            BPMx, HCOR, etc
% CommonNames           Shortcut name for each element
% DeviceList            [Sector, Number]
% ElementList           number in list
% Position              m, if thick, it is not the magnet center
%
% MONITOR FIELD
% Mode                  online/manual/special/simulator
% TangoNames            Device Tango Names
% Units                 Physics or HW
% HW2PhysicsFcn         function handle used to convert from hardware to physics units ==> inline will not compile, see below
% HW2PhysicsParams      params used for conversion function
% Physics2HWFcn         function handle used to convert from physics to hardware units
% Physics2HWParams      params used for conversion function
% HWUnits               units for Hardware 'A';
% PhysicsUnits          units for physics 'Rad';
% Handles               monitor handle
%
% SETPOINT FIELDS
% Mode                  online/manual/special/simulator
% TangoNames            Devices tango names
% Units                 hardware or physics
% HW2PhysicsFcn         function handle used to convert from hardware to physics units
% HW2PhysicsParams      params used for conversion function
% Physics2HWFcn         function handle used to convert from physics to hardware units
% Physics2HWParams      params used for conversion function
% HWUnits               units for Hardware 'A';
% PhysicsUnits          units for physics 'Rad';
% Range                 minsetpoint, maxsetpoint;
% Tolerance             setpoint-monitor
% Handles               setpoint handle
%
%=============================================
% Accelerator Toolbox Simulation Fields
%=============================================
% ATType                Quad, Sext, etc
% ATIndex               index in THERING
% ATParamGroup      param group
%
%============
% Family List
%============
%    BPMx
%    BPMz
%    HCOR
%    VCOR
%    BEND
%    Q1 to Q10
%    S1 to S10
%    RF
%    TUNE
%    DCCT
%    Machine Params
%
% NOTES
%   All sextupoles have H and V corrector and skew quadrupole windings
%
%  See Also setpathsoleil, setpathmml, aoinit, setoperationalmode, updateatindex

%
%
% TODO, Deltakick for BPM orbit response matrix  Warning optics dependent cf. Low alpha lattice
%       to be put into setoperationalmode

% DO NOT REMOVE LSN
%suppress optimization message
%#ok<*ASGLU>

% CONTROL ROOM
% Check for nanoscopium
% Check for attribute names
% Check for range value of sextupoles

% If controlromm user is operator and online mode

[statuss WHO] = system('whoami');
% system gives back an visible character: carriage return!
% so comparison on the number of caracters
if strncmp(WHO, 'operateur',9),
    ControlRoomFlag = 1;
    Mode = 'Online';
else
    ControlRoomFlag = 0;
    Mode = 'Simulator';
end

%% Default operation mode (see setoperationalmode)
if nargin < 1
    %OperationalMode = 9; % with S11 betax=10m
    %OperationalMode = 19; % without S11
    %OperationalMode = 16; % betax=5m 
    %OperationalMode = 30; % pseudo nanoscopium
    %OperationalMode = 29; % nanoscopium
    %OperationalMode = 46; % nanoscopium SDL01-09=11m
    OperationalMode = 48; % nanoscopium SDL01-09=11m+6cor
    
end

% Define some global variables

h = waitbar(0,'soleilinit initialization, please wait');

%==============================
%% load AcceleratorData structure
%==============================

setad([]);       %clear AcceleratorData memory
AD.SubMachine = 'StorageRing';   % Will already be defined if setpathmml was used
AD.Energy        = 2.7391; % Energy in GeV needed for magnet calibration. Do not remove!

setad(AD);

%%%%%%%%%%%%%%%%%%%%
% ACCELERATOR OBJECT
%%%%%%%%%%%%%%%%%%%%

if ~isempty(getappdata(0, 'AcceleratorObjects'))
    AO = getao;
    % Check if online and AO is from Storagering
    if ControlRoomFlag && isfield(AO, 'Q10') 
        local_tango_kill_allgroup(AO); % kill all TANGO group
    end
end
AO =[]; setao(AO);    %clear previous AcceleratorObjects
waitbar(0.05,h);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BPM
% status field designates if BPM in use
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BPMx Horizontal plane
ifam = 'BPMx';
AO.(ifam).FamilyName               = ifam;
AO.(ifam).FamilyType               = 'BPM';
AO.(ifam).MemberOf                 = {'BPM'; 'HBPM'; 'PlotFamily'; 'Archivable'};
AO.(ifam).Monitor.Mode             = Mode;
%AO.(ifam).Monitor.Mode             = 'Special';
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'mm';
AO.(ifam).Monitor.PhysicsUnits     = 'm';
AO.(ifam).Monitor.SpecialFunctionGet = 'gethbpmgroup';
AO.(ifam).Simulated.NoiseActivated = 0; %To activate Noise on BPM reading in simulation   
%AO.(ifam).Monitor.SpecialFunctionGet = 'gethbpmaverage';
%AO.(ifam).Monitor.SpecialFunctionGet = 'gethturdevnumberyturn';

% ElemList devlist tangoname status common
varlist = {
    1 [ 1  2] 'ANS-C01/DG/BPM.2'  1 'BPMx001'
    2 [ 1  3] 'ANS-C01/DG/BPM.3'  1 'BPMx002'
    3 [ 1  4] 'ANS-C01/DG/BPM.4'  1 'BPMx003'
    4 [ 1  5] 'ANS-C01/DG/BPM.5'  1 'BPMx004'
    5 [ 1  6] 'ANS-C01/DG/BPM.6'  1 'BPMx005'
    6 [ 1  7] 'ANS-C01/DG/BPM.7'  1 'BPMx006'
    7 [ 2  1] 'ANS-C02/DG/BPM.1'  1 'BPMx007'
    8 [ 2  2] 'ANS-C02/DG/BPM.2'  1 'BPMx008'
    9 [ 2  3] 'ANS-C02/DG/BPM.3'  1 'BPMx009'
    10 [ 2  4] 'ANS-C02/DG/BPM.4'  1 'BPMx010'
    11 [ 2  5] 'ANS-C02/DG/BPM.5'  1 'BPMx011'
    12 [ 2  6] 'ANS-C02/DG/BPM.6'  1 'BPMx012'
    13 [ 2  7] 'ANS-C02/DG/BPM.7'  1 'BPMx013'
    14 [ 2  8] 'ANS-C02/DG/BPM.8'  1 'BPMx014'
    15 [ 3  1] 'ANS-C03/DG/BPM.1'  1 'BPMx015'
    16 [ 3  2] 'ANS-C03/DG/BPM.2'  1 'BPMx016'
    17 [ 3  3] 'ANS-C03/DG/BPM.3'  1 'BPMx017'
    18 [ 3  4] 'ANS-C03/DG/BPM.4'  1 'BPMx018'
    19 [ 3  5] 'ANS-C03/DG/BPM.5'  1 'BPMx019'
    20 [ 3  6] 'ANS-C03/DG/BPM.6'  1 'BPMx020'
    21 [ 3  7] 'ANS-C03/DG/BPM.7'  1 'BPMx021'
    22 [ 3  8] 'ANS-C03/DG/BPM.8'  1 'BPMx022'
    23 [ 4  1] 'ANS-C04/DG/BPM.1'  1 'BPMx023'
    24 [ 4  2] 'ANS-C04/DG/BPM.2'  1 'BPMx024'
    25 [ 4  3] 'ANS-C04/DG/BPM.3'  1 'BPMx025'
    26 [ 4  4] 'ANS-C04/DG/BPM.4'  1 'BPMx026'
    27 [ 4  5] 'ANS-C04/DG/BPM.5'  1 'BPMx027'
    28 [ 4  6] 'ANS-C04/DG/BPM.6'  1 'BPMx028'
    29 [ 4  7] 'ANS-C04/DG/BPM.7'  1 'BPMx029'
    30 [ 5  1] 'ANS-C05/DG/BPM.1'  1 'BPMx030'
    31 [ 5  2] 'ANS-C05/DG/BPM.2'  1 'BPMx031'
    32 [ 5  3] 'ANS-C05/DG/BPM.3'  1 'BPMx032'
    33 [ 5  4] 'ANS-C05/DG/BPM.4'  1 'BPMx033'
    34 [ 5  5] 'ANS-C05/DG/BPM.5'  1 'BPMx034'
    35 [ 5  6] 'ANS-C05/DG/BPM.6'  1 'BPMx035'
    36 [ 5  7] 'ANS-C05/DG/BPM.7'  1 'BPMx036'
    37 [ 6  1] 'ANS-C06/DG/BPM.1'  1 'BPMx037'
    38 [ 6  2] 'ANS-C06/DG/BPM.2'  1 'BPMx038'
    39 [ 6  3] 'ANS-C06/DG/BPM.3'  1 'BPMx039'
    40 [ 6  4] 'ANS-C06/DG/BPM.4'  1 'BPMx040'
    41 [ 6  5] 'ANS-C06/DG/BPM.5'  1 'BPMx041'
    42 [ 6  6] 'ANS-C06/DG/BPM.6'  1 'BPMx042'
    43 [ 6  7] 'ANS-C06/DG/BPM.7'  1 'BPMx043'
    44 [ 6  8] 'ANS-C06/DG/BPM.8'  1 'BPMx044'
    45 [ 7  1] 'ANS-C07/DG/BPM.1'  1 'BPMx045'
    46 [ 7  2] 'ANS-C07/DG/BPM.2'  1 'BPMx046'
    47 [ 7  3] 'ANS-C07/DG/BPM.3'  1 'BPMx047'
    48 [ 7  4] 'ANS-C07/DG/BPM.4'  1 'BPMx048'
    49 [ 7  5] 'ANS-C07/DG/BPM.5'  1 'BPMx049'
    50 [ 7  6] 'ANS-C07/DG/BPM.6'  1 'BPMx050'
    51 [ 7  7] 'ANS-C07/DG/BPM.7'  1 'BPMx051'
    52 [ 7  8] 'ANS-C07/DG/BPM.8'  1 'BPMx052'
    53 [ 8  1] 'ANS-C08/DG/BPM.1'  1 'BPMx053'
    54 [ 8  2] 'ANS-C08/DG/BPM.2'  1 'BPMx054'
    55 [ 8  3] 'ANS-C08/DG/BPM.3'  1 'BPMx055'
    56 [ 8  4] 'ANS-C08/DG/BPM.4'  1 'BPMx056'
    57 [ 8  5] 'ANS-C08/DG/BPM.5'  1 'BPMx057'
    58 [ 8  6] 'ANS-C08/DG/BPM.6'  1 'BPMx058'
    59 [ 8  7] 'ANS-C08/DG/BPM.7'  1 'BPMx059'
    60 [ 9  1] 'ANS-C09/DG/BPM.1'  1 'BPMx060'
    61 [ 9  2] 'ANS-C09/DG/BPM.2'  1 'BPMx061'
    62 [ 9  3] 'ANS-C09/DG/BPM.3'  1 'BPMx062'
    63 [ 9  4] 'ANS-C09/DG/BPM.4'  1 'BPMx063'
    64 [ 9  5] 'ANS-C09/DG/BPM.5'  1 'BPMx064'
    65 [ 9  6] 'ANS-C09/DG/BPM.6'  1 'BPMx065'
    66 [ 9  7] 'ANS-C09/DG/BPM.7'  1 'BPMx066'
    67 [10  1] 'ANS-C10/DG/BPM.1'  1 'BPMx067'
    68 [10  2] 'ANS-C10/DG/BPM.2'  1 'BPMx068'
    69 [10  3] 'ANS-C10/DG/BPM.3'  1 'BPMx069'
    70 [10  4] 'ANS-C10/DG/BPM.4'  1 'BPMx070'
    71 [10  5] 'ANS-C10/DG/BPM.5'  1 'BPMx071'
    72 [10  6] 'ANS-C10/DG/BPM.6'  1 'BPMx072'
    73 [10  7] 'ANS-C10/DG/BPM.7'  1 'BPMx073'
    74 [10  8] 'ANS-C10/DG/BPM.8'  1 'BPMx074'
    75 [11  1] 'ANS-C11/DG/BPM.1'  1 'BPMx075'
    76 [11  2] 'ANS-C11/DG/BPM.2'  1 'BPMx076'
    77 [11  3] 'ANS-C11/DG/BPM.3'  1 'BPMx077'
    78 [11  4] 'ANS-C11/DG/BPM.4'  1 'BPMx078'
    79 [11  5] 'ANS-C11/DG/BPM.5'  1 'BPMx079'
    80 [11  6] 'ANS-C11/DG/BPM.6'  1 'BPMx080'
    81 [11  7] 'ANS-C11/DG/BPM.7'  1 'BPMx081'
    82 [11  8] 'ANS-C11/DG/BPM.8'  1 'BPMx082'
    83 [12  1] 'ANS-C12/DG/BPM.1'  1 'BPMx083'
    84 [12  2] 'ANS-C12/DG/BPM.2'  1 'BPMx084'
    85 [12  3] 'ANS-C12/DG/BPM.3'  1 'BPMx085'
    86 [12  4] 'ANS-C12/DG/BPM.4'  1 'BPMx086'
    87 [12  5] 'ANS-C12/DG/BPM.5'  1 'BPMx087'
    88 [12  6] 'ANS-C12/DG/BPM.6'  1 'BPMx088'
    89 [12  7] 'ANS-C12/DG/BPM.7'  1 'BPMx089'
    90 [13  1] 'ANS-C13/DG/BPM.1'  1 'BPMx090'
    91 [13  8] 'ANS-C13/DG/BPM.8'  1 'BPMx121'
    92 [13  9] 'ANS-C13/DG/BPM.9'  1 'BPMx122'
    93 [13  2] 'ANS-C13/DG/BPM.2'  1 'BPMx091'
    94 [13  3] 'ANS-C13/DG/BPM.3'  1 'BPMx092'
    95 [13  4] 'ANS-C13/DG/BPM.4'  1 'BPMx093'
    96 [13  5] 'ANS-C13/DG/BPM.5'  1 'BPMx094'
    97 [13  6] 'ANS-C13/DG/BPM.6'  1 'BPMx095'
    98 [13  7] 'ANS-C13/DG/BPM.7'  1 'BPMx096'
    99 [14  1] 'ANS-C14/DG/BPM.1'  1 'BPMx097'
   100 [14  2] 'ANS-C14/DG/BPM.2'  1 'BPMx098'
   101 [14  3] 'ANS-C14/DG/BPM.3'  1 'BPMx099'
   102 [14  4] 'ANS-C14/DG/BPM.4'  1 'BPMx100'
   103 [14  5] 'ANS-C14/DG/BPM.5'  1 'BPMx101'
   104 [14  6] 'ANS-C14/DG/BPM.6'  1 'BPMx102'
   105 [14  7] 'ANS-C14/DG/BPM.7'  1 'BPMx103'
   106 [14  8] 'ANS-C14/DG/BPM.8'  1 'BPMx104'
   107 [15  1] 'ANS-C15/DG/BPM.1'  1 'BPMx105'
   108 [15  2] 'ANS-C15/DG/BPM.2'  1 'BPMx106'
   109 [15  3] 'ANS-C15/DG/BPM.3'  1 'BPMx107'
   110 [15  4] 'ANS-C15/DG/BPM.4'  1 'BPMx108'
   111 [15  5] 'ANS-C15/DG/BPM.5'  1 'BPMx109'
   112 [15  6] 'ANS-C15/DG/BPM.6'  1 'BPMx110'
   113 [15  7] 'ANS-C15/DG/BPM.7'  1 'BPMx111'
   114 [15  8] 'ANS-C15/DG/BPM.8'  1 'BPMx112'
   115 [16  1] 'ANS-C16/DG/BPM.1'  1 'BPMx113'
   116 [16  2] 'ANS-C16/DG/BPM.2'  1 'BPMx114'
   117 [16  3] 'ANS-C16/DG/BPM.3'  1 'BPMx115'
   118 [16  4] 'ANS-C16/DG/BPM.4'  1 'BPMx116'
   119 [16  5] 'ANS-C16/DG/BPM.5'  1 'BPMx117'
   120 [16  6] 'ANS-C16/DG/BPM.6'  1 'BPMx118'
   121 [16  7] 'ANS-C16/DG/BPM.7'  1 'BPMx119'
   122 [ 1  1] 'ANS-C01/DG/BPM.1'  1 'BPMx120'
    };

devnumber = length(varlist);

% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).Gain        = ones(devnumber,1);
AO.(ifam).Roll        = zeros(devnumber,1);
AO.(ifam).Golden      = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
AO.(ifam).Monitor.HW2PhysicsParams(:,:) = 1e-3*ones(devnumber,1);
AO.(ifam).Monitor.Physics2HWParams(:,:) = 1e3*ones(devnumber,1);
AO.(ifam).Monitor.Handles(:,1)          = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType              = 'Scalar';

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,5));
    AO.(ifam).Monitor.TangoNames{k}  = strcat(AO.(ifam).DeviceName{k}, '/XPosSA');
end

% Group
if ControlRoomFlag
        AO.(ifam).GroupId = tango_group_create2('BPMx');
        tango_group_add(AO.(ifam).GroupId,AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = NaN;
end

AO.(ifam).History = AO.(ifam).Monitor;
AO.(ifam).History = rmfield(AO.(ifam).History,'SpecialFunctionGet');

dev = AO.(ifam).DeviceName;
AO.(ifam).History.TangoNames(:,:)       = strcat(dev, '/XPosSAHistory');
AO.(ifam).History.MemberOf = {'Plotfamily'};

AO.(ifam).Va = AO.(ifam).History;
AO.(ifam).Va.TangoNames(:,:)       = strcat(dev, '/VaSA');
AO.(ifam).Va.MemberOf = {'Plotfamily'};

AO.(ifam).Vb = AO.(ifam).History;
AO.(ifam).Vb.TangoNames(:,:)       = strcat(dev, '/VbSA');
AO.(ifam).Vb.MemberOf = {'Plotfamily'};

AO.(ifam).Vc = AO.(ifam).History;
AO.(ifam).Vc.TangoNames(:,:)       = strcat(dev, '/VcSA');
AO.(ifam).Vc.MemberOf = {'Plotfamily'};

AO.(ifam).Vd = AO.(ifam).History;
AO.(ifam).Vd.TangoNames(:,:)       = strcat(dev, '/VdSA');
AO.(ifam).Vd.MemberOf = {'Plotfamily'};

AO.(ifam).Sum = AO.(ifam).History;
AO.(ifam).Sum.TangoNames(:,:)       = strcat(dev, '/SumSA');
AO.(ifam).Sum.MemberOf = {'Plotfamily'};

AO.(ifam).Quad = AO.(ifam).History;
AO.(ifam).Quad.TangoNames(:,:)       = strcat(dev, '/QuadSA');
AO.(ifam).Quad.MemberOf = {'Plotfamily'};

AO.(ifam).Gaidevnumberpm = AO.(ifam).History;
AO.(ifam).Gaidevnumberpm.TangoNames(:,:)       = strcat(dev, '/Gain');
AO.(ifam).Gaidevnumberpm.MemberOf = {'Plotfamily'};

AO.(ifam).Switch = AO.(ifam).History;
AO.(ifam).Switch.TangoNames(:,:)       = strcat(dev, '/Switches');
AO.(ifam).Switch.MemberOf = {'Plotfamily'};

%% BPMz Vertical plane
ifam = 'BPMz';
AO.(ifam).FamilyName               = ifam;
AO.(ifam).FamilyType               = 'BPM';
AO.(ifam).MemberOf                 = {'BPM'; 'VBPM'; 'PlotFamily'; 'Archivable'};
AO.(ifam).Monitor.Mode             = Mode;
%AO.(ifam).Monitor.Mode             = 'Special';
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'mm';
AO.(ifam).Monitor.PhysicsUnits     = 'm';
AO.(ifam).Monitor.SpecialFunctionGet = 'getvbpmgroup';
AO.(ifam).Simulated.NoiseActivated = 0; % To activate Noise on BPM reading in simulation     
%AO.(ifam).Monitor.SpecialFunctionGet = 'getvbpmaverage';
%AO.(ifam).Monitor.SpecialFunctionGet = 'getvturdevnumberyturn';

% devliste tangoname status common
varlist = {
    1 [ 1  2] 'ANS-C01/DG/BPM.2'  1 'BPMz001'
    2 [ 1  3] 'ANS-C01/DG/BPM.3'  1 'BPMz002'
    3 [ 1  4] 'ANS-C01/DG/BPM.4'  1 'BPMz003'
    4 [ 1  5] 'ANS-C01/DG/BPM.5'  1 'BPMz004'
    5 [ 1  6] 'ANS-C01/DG/BPM.6'  1 'BPMz005'
    6 [ 1  7] 'ANS-C01/DG/BPM.7'  1 'BPMz006'
    7 [ 2  1] 'ANS-C02/DG/BPM.1'  1 'BPMz007'
    8 [ 2  2] 'ANS-C02/DG/BPM.2'  1 'BPMz008'
    9 [ 2  3] 'ANS-C02/DG/BPM.3'  1 'BPMz009'
    10 [ 2  4] 'ANS-C02/DG/BPM.4'  1 'BPMz010'
    11 [ 2  5] 'ANS-C02/DG/BPM.5'  1 'BPMz011'
    12 [ 2  6] 'ANS-C02/DG/BPM.6'  1 'BPMz012'
    13 [ 2  7] 'ANS-C02/DG/BPM.7'  1 'BPMz013'
    14 [ 2  8] 'ANS-C02/DG/BPM.8'  1 'BPMz014'
    15 [ 3  1] 'ANS-C03/DG/BPM.1'  1 'BPMz015'
    16 [ 3  2] 'ANS-C03/DG/BPM.2'  1 'BPMz016'
    17 [ 3  3] 'ANS-C03/DG/BPM.3'  1 'BPMz017'
    18 [ 3  4] 'ANS-C03/DG/BPM.4'  1 'BPMz018'
    19 [ 3  5] 'ANS-C03/DG/BPM.5'  1 'BPMz019'
    20 [ 3  6] 'ANS-C03/DG/BPM.6'  1 'BPMz020'
    21 [ 3  7] 'ANS-C03/DG/BPM.7'  1 'BPMz021'
    22 [ 3  8] 'ANS-C03/DG/BPM.8'  1 'BPMz022'
    23 [ 4  1] 'ANS-C04/DG/BPM.1'  1 'BPMz023'
    24 [ 4  2] 'ANS-C04/DG/BPM.2'  1 'BPMz024'
    25 [ 4  3] 'ANS-C04/DG/BPM.3'  1 'BPMz025'
    26 [ 4  4] 'ANS-C04/DG/BPM.4'  1 'BPMz026'
    27 [ 4  5] 'ANS-C04/DG/BPM.5'  1 'BPMz027'
    28 [ 4  6] 'ANS-C04/DG/BPM.6'  1 'BPMz028'
    29 [ 4  7] 'ANS-C04/DG/BPM.7'  1 'BPMz029'
    30 [ 5  1] 'ANS-C05/DG/BPM.1'  1 'BPMz030'
    31 [ 5  2] 'ANS-C05/DG/BPM.2'  1 'BPMz031'
    32 [ 5  3] 'ANS-C05/DG/BPM.3'  1 'BPMz032'
    33 [ 5  4] 'ANS-C05/DG/BPM.4'  1 'BPMz033'
    34 [ 5  5] 'ANS-C05/DG/BPM.5'  1 'BPMz034'
    35 [ 5  6] 'ANS-C05/DG/BPM.6'  1 'BPMz035'
    36 [ 5  7] 'ANS-C05/DG/BPM.7'  1 'BPMz036'
    37 [ 6  1] 'ANS-C06/DG/BPM.1'  1 'BPMz037'
    38 [ 6  2] 'ANS-C06/DG/BPM.2'  1 'BPMz038'
    39 [ 6  3] 'ANS-C06/DG/BPM.3'  1 'BPMz039'
    40 [ 6  4] 'ANS-C06/DG/BPM.4'  1 'BPMz040'
    41 [ 6  5] 'ANS-C06/DG/BPM.5'  1 'BPMz041'
    42 [ 6  6] 'ANS-C06/DG/BPM.6'  1 'BPMz042'
    43 [ 6  7] 'ANS-C06/DG/BPM.7'  1 'BPMz043'
    44 [ 6  8] 'ANS-C06/DG/BPM.8'  1 'BPMz044'
    45 [ 7  1] 'ANS-C07/DG/BPM.1'  1 'BPMz045'
    46 [ 7  2] 'ANS-C07/DG/BPM.2'  1 'BPMz046'
    47 [ 7  3] 'ANS-C07/DG/BPM.3'  1 'BPMz047'
    48 [ 7  4] 'ANS-C07/DG/BPM.4'  1 'BPMz048'
    49 [ 7  5] 'ANS-C07/DG/BPM.5'  1 'BPMz049'
    50 [ 7  6] 'ANS-C07/DG/BPM.6'  1 'BPMz050'
    51 [ 7  7] 'ANS-C07/DG/BPM.7'  1 'BPMz051'
    52 [ 7  8] 'ANS-C07/DG/BPM.8'  1 'BPMz052'
    53 [ 8  1] 'ANS-C08/DG/BPM.1'  1 'BPMz053'
    54 [ 8  2] 'ANS-C08/DG/BPM.2'  1 'BPMz054'
    55 [ 8  3] 'ANS-C08/DG/BPM.3'  1 'BPMz055'
    56 [ 8  4] 'ANS-C08/DG/BPM.4'  1 'BPMz056'
    57 [ 8  5] 'ANS-C08/DG/BPM.5'  1 'BPMz057'
    58 [ 8  6] 'ANS-C08/DG/BPM.6'  1 'BPMz058'
    59 [ 8  7] 'ANS-C08/DG/BPM.7'  1 'BPMz059'
    60 [ 9  1] 'ANS-C09/DG/BPM.1'  1 'BPMz060'
    61 [ 9  2] 'ANS-C09/DG/BPM.2'  1 'BPMz061'
    62 [ 9  3] 'ANS-C09/DG/BPM.3'  1 'BPMz062'
    63 [ 9  4] 'ANS-C09/DG/BPM.4'  1 'BPMz063'
    64 [ 9  5] 'ANS-C09/DG/BPM.5'  1 'BPMz064'
    65 [ 9  6] 'ANS-C09/DG/BPM.6'  1 'BPMz065'
    66 [ 9  7] 'ANS-C09/DG/BPM.7'  1 'BPMz066'
    67 [10  1] 'ANS-C10/DG/BPM.1'  1 'BPMz067'
    68 [10  2] 'ANS-C10/DG/BPM.2'  1 'BPMz068'
    69 [10  3] 'ANS-C10/DG/BPM.3'  1 'BPMz069'
    70 [10  4] 'ANS-C10/DG/BPM.4'  1 'BPMz070'
    71 [10  5] 'ANS-C10/DG/BPM.5'  1 'BPMz071'
    72 [10  6] 'ANS-C10/DG/BPM.6'  1 'BPMz072'
    73 [10  7] 'ANS-C10/DG/BPM.7'  1 'BPMz073'
    74 [10  8] 'ANS-C10/DG/BPM.8'  1 'BPMz074'
    75 [11  1] 'ANS-C11/DG/BPM.1'  1 'BPMz075'
    76 [11  2] 'ANS-C11/DG/BPM.2'  1 'BPMz076'
    77 [11  3] 'ANS-C11/DG/BPM.3'  1 'BPMz077'
    78 [11  4] 'ANS-C11/DG/BPM.4'  1 'BPMz078'
    79 [11  5] 'ANS-C11/DG/BPM.5'  1 'BPMz079'
    80 [11  6] 'ANS-C11/DG/BPM.6'  1 'BPMz080'
    81 [11  7] 'ANS-C11/DG/BPM.7'  1 'BPMz081'
    82 [11  8] 'ANS-C11/DG/BPM.8'  1 'BPMz082'
    83 [12  1] 'ANS-C12/DG/BPM.1'  1 'BPMz083'
    84 [12  2] 'ANS-C12/DG/BPM.2'  1 'BPMz084'
    85 [12  3] 'ANS-C12/DG/BPM.3'  1 'BPMz085'
    86 [12  4] 'ANS-C12/DG/BPM.4'  1 'BPMz086'
    87 [12  5] 'ANS-C12/DG/BPM.5'  1 'BPMz087'
    88 [12  6] 'ANS-C12/DG/BPM.6'  1 'BPMz088'
    89 [12  7] 'ANS-C12/DG/BPM.7'  1 'BPMz089'
    90 [13  1] 'ANS-C13/DG/BPM.1'  1 'BPMz090'
    91 [13  8] 'ANS-C13/DG/BPM.8'  1 'BPMz121'
    92 [13  9] 'ANS-C13/DG/BPM.9'  1 'BPMz122'
    93 [13  2] 'ANS-C13/DG/BPM.2'  1 'BPMz091'
    94 [13  3] 'ANS-C13/DG/BPM.3'  1 'BPMz092'
    95 [13  4] 'ANS-C13/DG/BPM.4'  1 'BPMz093'
    96 [13  5] 'ANS-C13/DG/BPM.5'  1 'BPMz094'
    97 [13  6] 'ANS-C13/DG/BPM.6'  1 'BPMz095'
    98 [13  7] 'ANS-C13/DG/BPM.7'  1 'BPMz096'
    99 [14  1] 'ANS-C14/DG/BPM.1'  1 'BPMz097'
   100 [14  2] 'ANS-C14/DG/BPM.2'  1 'BPMz098'
   101 [14  3] 'ANS-C14/DG/BPM.3'  1 'BPMz099'
   102 [14  4] 'ANS-C14/DG/BPM.4'  1 'BPMz100'
   103 [14  5] 'ANS-C14/DG/BPM.5'  1 'BPMz101'
   104 [14  6] 'ANS-C14/DG/BPM.6'  1 'BPMz102'
   105 [14  7] 'ANS-C14/DG/BPM.7'  1 'BPMz103'
   106 [14  8] 'ANS-C14/DG/BPM.8'  1 'BPMz104'
   107 [15  1] 'ANS-C15/DG/BPM.1'  1 'BPMz105'
   108 [15  2] 'ANS-C15/DG/BPM.2'  1 'BPMz106'
   109 [15  3] 'ANS-C15/DG/BPM.3'  1 'BPMz107'
   110 [15  4] 'ANS-C15/DG/BPM.4'  1 'BPMz108'
   111 [15  5] 'ANS-C15/DG/BPM.5'  1 'BPMz109'
   112 [15  6] 'ANS-C15/DG/BPM.6'  1 'BPMz110'
   113 [15  7] 'ANS-C15/DG/BPM.7'  1 'BPMz111'
   114 [15  8] 'ANS-C15/DG/BPM.8'  1 'BPMz112'
   115 [16  1] 'ANS-C16/DG/BPM.1'  1 'BPMz113'
   116 [16  2] 'ANS-C16/DG/BPM.2'  1 'BPMz114'
   117 [16  3] 'ANS-C16/DG/BPM.3'  1 'BPMz115'
   118 [16  4] 'ANS-C16/DG/BPM.4'  1 'BPMz116'
   119 [16  5] 'ANS-C16/DG/BPM.5'  1 'BPMz117'
   120 [16  6] 'ANS-C16/DG/BPM.6'  1 'BPMz118'
   121 [16  7] 'ANS-C16/DG/BPM.7'  1 'BPMz119'
   122 [ 1  1] 'ANS-C01/DG/BPM.1'  1 'BPMz120'
    };

devnumber = length(varlist);

% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).Gain        = ones(devnumber,1);
AO.(ifam).Roll        = zeros(devnumber,1);
AO.(ifam).Golden      = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
AO.(ifam).Monitor.HW2PhysicsParams(:,:) = 1e-3*ones(devnumber,1);
AO.(ifam).Monitor.Physics2HWParams(:,:) = 1e3*ones(devnumber,1);
AO.(ifam).Monitor.Handles(:,1)          = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType              = 'Scalar';

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,5));
    AO.(ifam).Monitor.TangoNames{k}  = strcat(AO.(ifam).DeviceName{k}, '/ZPosSA');
end

% Group
if ControlRoomFlag
        AO.(ifam).GroupId = tango_group_create2('BPMz');
        tango_group_add(AO.(ifam).GroupId,AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = NaN;
end

AO.(ifam).History = AO.(ifam).Monitor;
AO.(ifam).History = rmfield(AO.(ifam).History,'SpecialFunctionGet');

dev = AO.(ifam).DeviceName;
AO.(ifam).History.TangoNames(:,:)       = strcat(dev, '/ZPosSAHistory');
AO.(ifam).History.MemberOf = {'Plotfamily'};

AO.(ifam).Va = AO.(ifam).History;
AO.(ifam).Va.TangoNames(:,:)       = strcat(dev, '/VaSA');
AO.(ifam).Va.MemberOf = {'Plotfamily'};

AO.(ifam).Vb = AO.(ifam).History;
AO.(ifam).Vb.TangoNames(:,:)       = strcat(dev, '/VbSA');
AO.(ifam).Vb.MemberOf = {'Plotfamily'};

AO.(ifam).Vc = AO.(ifam).History;
AO.(ifam).Vc.TangoNames(:,:)       = strcat(dev, '/VcSA');
AO.(ifam).Vc.MemberOf = {'Plotfamily'};

AO.(ifam).Vd = AO.(ifam).History;
AO.(ifam).Vd.TangoNames(:,:)       = strcat(dev, '/VdSA');
AO.(ifam).Vd.MemberOf = {'Plotfamily'};

AO.(ifam).Sum = AO.(ifam).History;
AO.(ifam).Sum.TangoNames(:,:)       = strcat(dev, '/SumSA');
AO.(ifam).Sum.MemberOf = {'Plotfamily'};

AO.(ifam).Quad = AO.(ifam).History;
AO.(ifam).Quad.TangoNames(:,:)       = strcat(dev, '/QuadSA');
AO.(ifam).Quad.MemberOf = {'Plotfamily'};

AO.(ifam).Gaidevnumberpm = AO.(ifam).History;
AO.(ifam).Gaidevnumberpm.TangoNames(:,:)       = strcat(dev, '/Gain');
AO.(ifam).Gaidevnumberpm.MemberOf = {'Plotfamily'};

AO.(ifam).Switch = AO.(ifam).History;
AO.(ifam).Switch.TangoNames(:,:)       = strcat(dev, '/Switches');
AO.(ifam).Switch.MemberOf = {'Plotfamily'};

%% PBPMz Family BPMz + 4 XBPM
ifam = 'PBPMz';
AO.(ifam).FamilyName               = ifam;
AO.(ifam).FamilyType               = 'BPM';
AO.(ifam).MemberOf                 = {'BPM'; 'VBPM'; 'PlotFamily';};
AO.(ifam).Monitor.Mode             = Mode;
%AO.(ifam).Monitor.Mode             = 'Special';
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'mm';
AO.(ifam).Monitor.PhysicsUnits     = 'm';
AO.(ifam).Monitor.SpecialFunctionGet = 'getzwithXBPM';

% devliste tangoname status common
% last column is bpm type: 1 for bpm, 0 for xbpm

varlist = {
    1 [ 1  2] 'ANS-C01/DG/BPM.2'  1 'BPMz001' 1
    2 [ 1  3] 'ANS-C01/DG/BPM.3'  1 'BPMz002' 1
    3 [ 1  4] 'ANS-C01/DG/BPM.4'  1 'BPMz003' 1
    4 [ 1  5] 'ANS-C01/DG/BPM.5'  1 'BPMz004' 1
    5 [ 1  6] 'ANS-C01/DG/BPM.6'  1 'BPMz005' 1
  123 [ 1  8] 'TDL-D01-1/DG/XBPM_lib.1' 1 'BPMz123' 0
    6 [ 1  7] 'ANS-C01/DG/BPM.7'  1 'BPMz006' 1
    7 [ 2  1] 'ANS-C02/DG/BPM.1'  1 'BPMz007' 1
    8 [ 2  2] 'ANS-C02/DG/BPM.2'  1 'BPMz008' 1
    9 [ 2  3] 'ANS-C02/DG/BPM.3'  1 'BPMz009' 1
    10 [ 2  4] 'ANS-C02/DG/BPM.4'  1 'BPMz010' 1
    11 [ 2  5] 'ANS-C02/DG/BPM.5'  1 'BPMz011' 1
    12 [ 2  6] 'ANS-C02/DG/BPM.6'  1 'BPMz012' 1
    13 [ 2  7] 'ANS-C02/DG/BPM.7'  1 'BPMz013' 1
    14 [ 2  8] 'ANS-C02/DG/BPM.8'  1 'BPMz014' 1
    15 [ 3  1] 'ANS-C03/DG/BPM.1'  1 'BPMz015' 1
    16 [ 3  2] 'ANS-C03/DG/BPM.2'  1 'BPMz016' 1
    17 [ 3  3] 'ANS-C03/DG/BPM.3'  1 'BPMz017' 1
    18 [ 3  4] 'ANS-C03/DG/BPM.4'  1 'BPMz018' 1
    19 [ 3  5] 'ANS-C03/DG/BPM.5'  1 'BPMz019' 1
    20 [ 3  6] 'ANS-C03/DG/BPM.6'  1 'BPMz020' 1
    21 [ 3  7] 'ANS-C03/DG/BPM.7'  1 'BPMz021' 1
    22 [ 3  8] 'ANS-C03/DG/BPM.8'  1 'BPMz022' 1
    23 [ 4  1] 'ANS-C04/DG/BPM.1'  1 'BPMz023' 1
    24 [ 4  2] 'ANS-C04/DG/BPM.2'  1 'BPMz024' 1
    25 [ 4  3] 'ANS-C04/DG/BPM.3'  1 'BPMz025' 1
    26 [ 4  4] 'ANS-C04/DG/BPM.4'  1 'BPMz026' 1
    27 [ 4  5] 'ANS-C04/DG/BPM.5'  1 'BPMz027' 1
    28 [ 4  6] 'ANS-C04/DG/BPM.6'  1 'BPMz028' 1
    29 [ 4  7] 'ANS-C04/DG/BPM.7'  1 'BPMz029' 1 
    30 [ 5  1] 'ANS-C05/DG/BPM.1'  1 'BPMz030' 1
    31 [ 5  2] 'ANS-C05/DG/BPM.2'  1 'BPMz031' 1
    32 [ 5  3] 'ANS-C05/DG/BPM.3'  1 'BPMz032' 1
    33 [ 5  4] 'ANS-C05/DG/BPM.4'  1 'BPMz033' 1
    34 [ 5  5] 'ANS-C05/DG/BPM.5'  1 'BPMz034' 1
    35 [ 5  6] 'ANS-C05/DG/BPM.6'  1 'BPMz035' 1
   124 [ 5  8] 'TDL-D05-1/DG/XBPM_lib.1' 1 'BPMz124' 0
    36 [ 5  7] 'ANS-C05/DG/BPM.7'  1 'BPMz036' 1
    37 [ 6  1] 'ANS-C06/DG/BPM.1'  1 'BPMz037' 1
    38 [ 6  2] 'ANS-C06/DG/BPM.2'  1 'BPMz038' 1 
    39 [ 6  3] 'ANS-C06/DG/BPM.3'  1 'BPMz039' 1
    40 [ 6  4] 'ANS-C06/DG/BPM.4'  1 'BPMz040' 1
    41 [ 6  5] 'ANS-C06/DG/BPM.5'  1 'BPMz041' 1
    42 [ 6  6] 'ANS-C06/DG/BPM.6'  1 'BPMz042' 1
    43 [ 6  7] 'ANS-C06/DG/BPM.7'  1 'BPMz043' 1
    44 [ 6  8] 'ANS-C06/DG/BPM.8'  1 'BPMz044' 1
    45 [ 7  1] 'ANS-C07/DG/BPM.1'  1 'BPMz045' 1
    46 [ 7  2] 'ANS-C07/DG/BPM.2'  1 'BPMz046' 1
    47 [ 7  3] 'ANS-C07/DG/BPM.3'  1 'BPMz047' 1
    48 [ 7  4] 'ANS-C07/DG/BPM.4'  1 'BPMz048' 1 
    49 [ 7  5] 'ANS-C07/DG/BPM.5'  1 'BPMz049' 1
    50 [ 7  6] 'ANS-C07/DG/BPM.6'  1 'BPMz050' 1
    51 [ 7  7] 'ANS-C07/DG/BPM.7'  1 'BPMz051' 1
    52 [ 7  8] 'ANS-C07/DG/BPM.8'  1 'BPMz052' 1
    53 [ 8  1] 'ANS-C08/DG/BPM.1'  1 'BPMz053' 1
    54 [ 8  2] 'ANS-C08/DG/BPM.2'  1 'BPMz054' 1
    55 [ 8  3] 'ANS-C08/DG/BPM.3'  1 'BPMz055' 1 
    56 [ 8  4] 'ANS-C08/DG/BPM.4'  1 'BPMz056' 1 
    57 [ 8  5] 'ANS-C08/DG/BPM.5'  1 'BPMz057' 1
    58 [ 8  6] 'ANS-C08/DG/BPM.6'  1 'BPMz058' 1
    59 [ 8  7] 'ANS-C08/DG/BPM.7'  1 'BPMz059' 1
    60 [ 9  1] 'ANS-C09/DG/BPM.1'  1 'BPMz060' 1
    61 [ 9  2] 'ANS-C09/DG/BPM.2'  1 'BPMz061' 1
    62 [ 9  3] 'ANS-C09/DG/BPM.3'  1 'BPMz062' 1
    63 [ 9  4] 'ANS-C09/DG/BPM.4'  1 'BPMz063' 1
    64 [ 9  5] 'ANS-C09/DG/BPM.5'  1 'BPMz064' 1
    65 [ 9  6] 'ANS-C09/DG/BPM.6'  1 'BPMz065' 1
   125 [ 9  8] 'TDL-D09-1/DG/XBPM_lib.1' 1 'BPMz125' 0
    66 [ 9  7] 'ANS-C09/DG/BPM.7'  1 'BPMz066' 1
    67 [10  1] 'ANS-C10/DG/BPM.1'  1 'BPMz067' 1
    68 [10  2] 'ANS-C10/DG/BPM.2'  1 'BPMz068' 1
    69 [10  3] 'ANS-C10/DG/BPM.3'  1 'BPMz069' 1
    70 [10  4] 'ANS-C10/DG/BPM.4'  1 'BPMz070' 1
    71 [10  5] 'ANS-C10/DG/BPM.5'  1 'BPMz071' 1
    72 [10  6] 'ANS-C10/DG/BPM.6'  1 'BPMz072' 1
    73 [10  7] 'ANS-C10/DG/BPM.7'  1 'BPMz073' 1
    74 [10  8] 'ANS-C10/DG/BPM.8'  1 'BPMz074' 1
    75 [11  1] 'ANS-C11/DG/BPM.1'  1 'BPMz075' 1
    76 [11  2] 'ANS-C11/DG/BPM.2'  1 'BPMz076' 1
    77 [11  3] 'ANS-C11/DG/BPM.3'  1 'BPMz077' 1
    78 [11  4] 'ANS-C11/DG/BPM.4'  1 'BPMz078' 1
    79 [11  5] 'ANS-C11/DG/BPM.5'  1 'BPMz079' 1
    80 [11  6] 'ANS-C11/DG/BPM.6'  1 'BPMz080' 1
    81 [11  7] 'ANS-C11/DG/BPM.7'  1 'BPMz081' 1
    82 [11  8] 'ANS-C11/DG/BPM.8'  1 'BPMz082' 1
    83 [12  1] 'ANS-C12/DG/BPM.1'  1 'BPMz083' 1
    84 [12  2] 'ANS-C12/DG/BPM.2'  1 'BPMz084' 1
    85 [12  3] 'ANS-C12/DG/BPM.3'  1 'BPMz085' 1
    86 [12  4] 'ANS-C12/DG/BPM.4'  1 'BPMz086' 1
    87 [12  5] 'ANS-C12/DG/BPM.5'  1 'BPMz087' 1
    88 [12  6] 'ANS-C12/DG/BPM.6'  1 'BPMz088' 1
    89 [12  7] 'ANS-C12/DG/BPM.7'  1 'BPMz089' 1
    90 [13  1] 'ANS-C13/DG/BPM.1'  1 'BPMz090' 1
    91 [13  8] 'ANS-C13/DG/BPM.8'  1 'BPMz121' 1
    92 [13  9] 'ANS-C13/DG/BPM.9'  1 'BPMz122' 1
    93 [13  2] 'ANS-C13/DG/BPM.2'  1 'BPMz091' 1
    94 [13  3] 'ANS-C13/DG/BPM.3'  1 'BPMz092' 1
    95 [13  4] 'ANS-C13/DG/BPM.4'  1 'BPMz093' 1
    96 [13  5] 'ANS-C13/DG/BPM.5'  1 'BPMz094' 1
    97 [13  6] 'ANS-C13/DG/BPM.6'  1 'BPMz095' 1
   126 [13 10] 'TDL-D13-1/DG/XBPM_lib.1' 1 'BPMz126' 0
    98 [13  7] 'ANS-C13/DG/BPM.7'  1 'BPMz096' 1
    99 [14  1] 'ANS-C14/DG/BPM.1'  1 'BPMz097' 1
   100 [14  2] 'ANS-C14/DG/BPM.2'  1 'BPMz098' 1
   101 [14  3] 'ANS-C14/DG/BPM.3'  1 'BPMz099' 1
   102 [14  4] 'ANS-C14/DG/BPM.4'  1 'BPMz100' 1
   103 [14  5] 'ANS-C14/DG/BPM.5'  1 'BPMz101' 1
   104 [14  6] 'ANS-C14/DG/BPM.6'  1 'BPMz102' 1
   105 [14  7] 'ANS-C14/DG/BPM.7'  1 'BPMz103' 1
   106 [14  8] 'ANS-C14/DG/BPM.8'  1 'BPMz104' 1
   107 [15  1] 'ANS-C15/DG/BPM.1'  1 'BPMz105' 1
   108 [15  2] 'ANS-C15/DG/BPM.2'  1 'BPMz106' 1
   109 [15  3] 'ANS-C15/DG/BPM.3'  1 'BPMz107' 1
   110 [15  4] 'ANS-C15/DG/BPM.4'  1 'BPMz108' 1
   111 [15  5] 'ANS-C15/DG/BPM.5'  1 'BPMz109' 1
   112 [15  6] 'ANS-C15/DG/BPM.6'  1 'BPMz110' 1
   113 [15  7] 'ANS-C15/DG/BPM.7'  1 'BPMz111' 1
   114 [15  8] 'ANS-C15/DG/BPM.8'  1 'BPMz112' 1
   115 [16  1] 'ANS-C16/DG/BPM.1'  1 'BPMz113' 1
   116 [16  2] 'ANS-C16/DG/BPM.2'  1 'BPMz114' 1
   117 [16  3] 'ANS-C16/DG/BPM.3'  1 'BPMz115' 1
   118 [16  4] 'ANS-C16/DG/BPM.4'  1 'BPMz116' 1
   119 [16  5] 'ANS-C16/DG/BPM.5'  1 'BPMz117' 1
   120 [16  6] 'ANS-C16/DG/BPM.6'  1 'BPMz118' 1
   121 [16  7] 'ANS-C16/DG/BPM.7'  1 'BPMz119' 1
   122 [ 1  1] 'ANS-C01/DG/BPM.1'  1 'BPMz120' 1
    };

devnumber = length(varlist);

% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).Golden      = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
AO.(ifam).Monitor.HW2PhysicsParams(:,:) = 1e-3*ones(devnumber,1);
AO.(ifam).Monitor.Physics2HWParams(:,:) = 1e3*ones(devnumber,1);
AO.(ifam).Monitor.Handles(:,1)          = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType              = 'Scalar';
AO.(ifam).Type  = zeros(devnumber,1); 

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,5));
    AO.(ifam).Monitor.TangoNames{k}  = strcat(AO.(ifam).DeviceName{k}, '/ZPosSA');
    AO.(ifam).Type(k) = varlist{k,6}; 

end

%===========================================================
% Corrector data: status field designates if corrector in use
%===========================================================

%% BLx : Source points
ifam = 'BeamLine';

AO.(ifam).FamilyName  = ifam;
AO.(ifam).FamilyType  = 'Diagnostic';
AO.(ifam).MemberOf    = {'DG'; 'PlotFamily'; 'Archivable'};

% D2 en C08: ASTROPHYSICS
% AO.(ifam).CommonNames = {'INJECTION';'ODE'; 'CRYOMODULE2'; 'SMIS'; 'SEXTANTS'; ...
%     'CRYOMODULE1'; 'AILES'; 'PSICHE'; 'PLEIADES'; 'DISCO'; ...
%     'DESIRS'; 'METRO'; 'SDM06'; 'CRISTAL'; 'DEIMOS'; 'GALAXIES'; 'TEMPO'; ...
%     'SDL09'; 'SAMBA'; 'MICROXM'; 'PX1'; 'PX2'; 'SWING'; ...
%     'ANTARES'; 'SDL13'; 'DIFFABS'; 'MICROFOC'; 'SIXS'; 'CASSIOPEE'; 'SIRIUS'; 'LUCIA'}; % to be completed with new dipoles
% AO.(ifam).DeviceList  = [1 1; 1 2; 2 1; 2 2; 2 3; 3 1; 3 2; 3 3; 4 1; 4 2; ...
%     5 1; 5 2; 6 1; 6 2; 7 1; 7 2; 8 1; ...
%     9 1; 9 2; 10 1; 10 2; 11 1; 11 2; 12 1; ...
%     13 1; 13 2;14 1; 14 2; 15 1; 15 2; 16 1];

% AO.(ifam).DeviceName             = { ...
%     'ANS-C01/DG/CALC-SDL-POSITION-ANGLE'; ...
%     'ANS-C01/DG/CALC-D2-POSITION-ANGLE'; ...
%     'ANS-C02/DG/CALC-SDM-POSITION-ANGLE'; ...
%     'ANS-C02/DG/CALC-D1-POSITION-ANGLE'; ...
%     'ANS-C02/DG/CALC-SDC-POSITION-ANGLE'; ...
%     'ANS-C03/DG/CALC-SDM-POSITION-ANGLE'; ...
%     'ANS-C03/DG/CALC-D1-POSITION-ANGLE'; ...
%     'ANS-C03/DG/CALC-SDC-POSITION-ANGLE'; ...
%     'ANS-C04/DG/CALC-SDM-POSITION-ANGLE'; ...
%     'ANS-C04/DG/CALC-D2-POSITION-ANGLE'; ...
%     'ANS-C05/DG/CALC-SDL-POSITION-ANGLE'; ...
%     'ANS-C05/DG/CALC-D2-POSITION-ANGLE'; ...
%     'ANS-C06/DG/CALC-SDM-POSITION-ANGLE'; ...
%     'ANS-C06/DG/CALC-SDC-POSITION-ANGLE'; ...
%     'ANS-C07/DG/CALC-SDM-POSITION-ANGLE'; ...
%     'ANS-C07/DG/CALC-SDC-POSITION-ANGLE'; ...
%     'ANS-C08/DG/CALC-SDM-POSITION-ANGLE'; ...
%     'ANS-C09/DG/CALC-SDL-POSITION-ANGLE'; ...
%     'ANS-C09/DG/CALC-D2-POSITION-ANGLE'; ...
%     'ANS-C10/DG/CALC-SDM-POSITION-ANGLE'; ...
%     'ANS-C10/DG/CALC-SDC-POSITION-ANGLE'; ...
%     'ANS-C11/DG/CALC-SDM-POSITION-ANGLE'; ...
%     'ANS-C11/DG/CALC-SDC-POSITION-ANGLE'; ...
%     'ANS-C12/DG/CALC-SDM-POSITION-ANGLE'; ...
%     'ANS-C13/DG/CALC-SDL-POSITION-ANGLE'; ...
%     'ANS-C13/DG/CALC-D2-POSITION-ANGLE' ; ...
%     'ANS-C14/DG/CALC-SDM-POSITION-ANGLE'; ...
%     'ANS-C14/DG/CALC-SDC-POSITION-ANGLE'; ...
%     'ANS-C15/DG/CALC-SDM-POSITION-ANGLE'; ...
%     'ANS-C15/DG/CALC-SDC-POSITION-ANGLE'; ...
%     'ANS-C16/DG/CALC-SDM-POSITION-ANGLE'};

% AO.(ifam).ElementList = (1:size(AO.(ifam).DeviceList,1))';
% AO.(ifam).Status      = ones(size(AO.(ifam).DeviceList,1),1);


% ID based BLs
%spos = getspos('BPMx',getidbpmlist)
%spos2 = zeros(25,1);
%spos2(2:end) = (spos(3:2:end)+spos(2:2:end-1))/2;
% ODE, SAMBA, DIFFABS, AILES, SMIS, ROCK
% dippos = getspos('BEND',[1 1])
% Position = [spos2(1); dippos(2); spos2(2); dippos(3); spos2(3:4); dippos(5); spos2(5:6); dippos(8); spos2(7);  dippos(10); spos2(8:13); dippos(18); spos2(14:19); dippos(26); spos2(20:end)];
% AO.(ifam).Position = [
%     0
%     14.7752
%     22.0301
%     28.2320
%     33.1454
%     44.2619
%     50.4638
%     55.3772
%     66.4936
%     78.2007
%     88.5230
%     103.2981
%     110.5530
%     121.6689
%     132.7853
%     143.9012
%     155.0177
%     177.0476
%     191.8227
%     199.0776
%     210.1934
%     221.3099
%     232.4258
%     243.5422
%     265.5721
%     280.3473
%     287.6022
%     298.7180
%     309.8345
%     320.9503
%     332.0668];

% TODO take model based position (cf. chicane upgrade)
% <Number> <[Cells NumInCells]><positionDevices><FLAG?><Name><Position_RING><ANGLE>

varlist = {
  1 [ 1  1] 'ANS-C01/DG/CALC-SDL-POSITION-ANGLE '  1 'INJECTION       ' 0.000000e+00
  2 [ 1  2] 'ANS-C01/DG/CALC-D2-POSITION-ANGLE  '  1 'ODE             ' 1.477520e+01
  3 [ 2  1] 'ANS-C02/DG/CALC-SDM-POSITION-ANGLE '  1 'CRYOMODULE2     ' 2.203010e+01
  4 [ 2  2] 'ANS-C02/DG/CALC-D1-POSITION-ANGLE  '  1 'SMIS            ' 2.823200e+01
  5 [ 2  3] 'ANS-C02/DG/CALC-SDC-POSITION-ANGLE '  1 'ALPHA           ' 3.314540e+01
  6 [ 3  1] 'ANS-C03/DG/CALC-SDM-POSITION-ANGLE '  1 'CRYOMODULE1     ' 4.426190e+01
  7 [ 3  2] 'ANS-C03/DG/CALC-D1-POSITION-ANGLE  '  1 'AILES           ' 5.046380e+01
  8 [ 3  3] 'ANS-C03/DG/CALC-SDC-POSITION-ANGLE '  1 'PSICHE          ' 5.537720e+01
  9 [ 4  1] 'ANS-C04/DG/CALC-SDM-POSITION-ANGLE '  1 'PLEIADES        ' 6.649360e+01
 10 [ 4  2] 'ANS-C04/DG/CALC-D2-POSITION-ANGLE  '  1 'DISCO           ' 7.820070e+01
 11 [ 5  1] 'ANS-C05/DG/CALC-SDL-POSITION-ANGLE '  1 'DESIRS          ' 8.852300e+01
 12 [ 5  2] 'ANS-C05/DG/CALC-D2-POSITION-ANGLE  '  1 'METRO           ' 1.032981e+02
 13 [ 6  1] 'ANS-C06/DG/CALC-SDM-POSITION-ANGLE '  1 'PUMA            ' 1.105530e+02
 14 [ 6  2] 'ANS-C06/DG/CALC-SDC-POSITION-ANGLE '  1 'CRISTAL         ' 1.216689e+02
 15 [ 7  1] 'ANS-C07/DG/CALC-SDM-POSITION-ANGLE '  1 'DEIMOS          ' 1.327853e+02
 16 [ 7  2] 'ANS-C07/DG/CALC-SDC-POSITION-ANGLE '  1 'GALAXIES        ' 1.439012e+02
 17 [ 8  1] 'ANS-C08/DG/CALC-SDM-POSITION-ANGLE '  1 'TEMPO           ' 1.550177e+02
 18 [ 9  1] 'ANS-C09/DG/CALC-SDL-POSITION-ANGLE '  1 'FBT             ' 1.770476e+02
 19 [ 9  2] 'ANS-C09/DG/CALC-D2-POSITION-ANGLE  '  1 'SAMBA           ' 1.918227e+02
 20 [10  1] 'ANS-C10/DG/CALC-SDM-POSITION-ANGLE '  1 'HERMES          ' 1.990776e+02
 21 [10  2] 'ANS-C10/DG/CALC-SDC-POSITION-ANGLE '  1 'PX1             ' 2.101934e+02
 22 [11  1] 'ANS-C11/DG/CALC-SDM-POSITION-ANGLE '  1 'PX2             ' 2.213099e+02
 23 [11  2] 'ANS-C11/DG/CALC-SDC-POSITION-ANGLE '  1 'SWING           ' 2.324258e+02
 24 [12  1] 'ANS-C12/DG/CALC-SDM-POSITION-ANGLE '  1 'ANTARES         ' 2.435422e+02
 25 [12  2] 'ANS-C12/DG/CALC-D2-POSITION-ANGLE  '  1 'ROCK            ' 2.497447e+02
 26 [13  1] 'ANS-C13/DG/CALC-SDL.1-POSITION-ANGLE '  1 'ANATOMIX        ' 2.620469e+02
 27 [13  2] 'ANS-C13/DG/CALC-SDL.2-POSITION-ANGLE '  1 'NANOSCOPIUM     ' 2.690781e+02
 28 [13  3] 'ANS-C13/DG/CALC-D2-POSITION-ANGLE  '  1 'DIFFABS         ' 2.803473e+02
 29 [14  1] 'ANS-C14/DG/CALC-SDM-POSITION-ANGLE '  1 'SEXTANTS        ' 2.876022e+02
 30 [14  2] 'ANS-C14/DG/CALC-SDC-POSITION-ANGLE '  1 'SIXS            ' 2.987180e+02
 31 [15  1] 'ANS-C15/DG/CALC-SDM-POSITION-ANGLE '  1 'CASSIOPEE       ' 3.098345e+02
 32 [15  2] 'ANS-C15/DG/CALC-SDC-POSITION-ANGLE '  1 'SIRIUS          ' 3.209503e+02
 33 [16  1] 'ANS-C16/DG/CALC-SDM-POSITION-ANGLE '  1 'LUCIA           ' 3.320668e+02
};

devnumber = length(varlist);
% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,5));
    AO.(ifam).Position(k,:)      = varlist{k,6};
end

AO.(ifam).Monitor.Mode                   = Mode; %'Simulator';  % Mode;
AO.(ifam).Monitor.DataType               = 'Scalar';
AO.(ifam).Monitor.TangoNames(:,:)        = strcat(AO.(ifam).DeviceName, '/positionX');

AO.(ifam).Monitor.Units                  = 'Hardware';
AO.(ifam).Monitor.Handles                = NaN;
AO.(ifam).Monitor.HW2PhysicsParams       = 1e-6;
AO.(ifam).Monitor.Physics2HWParams       = 1e6;
AO.(ifam).Monitor.HWUnits                = 'um';
AO.(ifam).Monitor.PhysicsUnits           = 'm';


AO.(ifam).Positionx = AO.(ifam).Monitor;
AO.(ifam).Positionx.MemberOf            = {'PlotFamily'};

AO.(ifam).Anglex = AO.(ifam).Positionx;

AO.(ifam).Anglex.HWUnits                = 'urad';
AO.(ifam).Anglex.PhysicsUnits           = 'rad';
AO.(ifam).Anglex.TangoNames(:,:)        = strcat(AO.(ifam).DeviceName, '/angleX');

AO.(ifam).Positionz = AO.(ifam).Positionx;
AO.(ifam).Positionz.TangoNames(:,:)     = strcat(AO.(ifam).DeviceName, '/positionZ');

AO.(ifam).Anglez = AO.(ifam).Anglex;
AO.(ifam).Anglez.TangoNames(:,:)        = strcat(AO.(ifam).DeviceName, '/angleZ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SLOW HORIZONTAL CORRECTORS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ifam = 'HCOR';
AO.(ifam).FamilyName               = ifam;
AO.(ifam).FamilyType               = 'COR';
AO.(ifam).MemberOf                 = {'MachineConfig'; 'HCOR'; 'COR'; 'Magnet'; 'PlotFamily'; 'Archivable'};

AO.(ifam).Monitor.Mode             = Mode;
AO.(ifam).Monitor.DataType         = 'Scalar';
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'A';
AO.(ifam).Monitor.PhysicsUnits     = 'rad';
AO.(ifam).Monitor.HW2PhysicsFcn    = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn    = @k2amp;

AO.(ifam).Setpoint.Mode             = Mode;
AO.(ifam).Setpoint.DataType         = 'Scalar';
AO.(ifam).Setpoint.Units            = 'Hardware';
AO.(ifam).Setpoint.HWUnits          = 'A';
AO.(ifam).Setpoint.PhysicsUnits     = 'rad';
AO.(ifam).Setpoint.HW2PhysicsFcn    = @amp2k;
AO.(ifam).Setpoint.Physics2HWFcn    = @k2amp;

AO.(ifam).Voltage.Mode             = Mode;
AO.(ifam).Voltage.DataType         = 'Scalar';
AO.(ifam).Voltage.Units            = 'Hardware';
AO.(ifam).Voltage.HWUnits          = 'V';
AO.(ifam).Voltage.PhysicsUnits     = 'rad';
AO.(ifam).Voltage.HW2PhysicsFcn    = @amp2k;
AO.(ifam).Voltage.Physics2HWFcn    = @k2amp;

% % Get mapping from TANGO static database
AO.(ifam).Voltage.PhysicsUnits     = 'rad';
AO.(ifam).Voltage.HW2PhysicsFcn    = @amp2k;
AO.(ifam).Voltage.Physics2HWFcn    = @k2amp;

% elemlist devlist tangoname       status  common  attR           attW      range
varlist = {
     1  [ 1 1] 'ANS-C01/AE/S1-CH      ' 1 'HCOR001' 'current   ' 'currentPM ' [-11.0  11.0]
     2  [ 1 2] 'ANS-C01/AE/S2-CH      ' 0 'HCOR002' 'current   ' 'currentPM ' [-11.0  11.0]
     3  [ 1 3] 'ANS-C01/AE/S3.1-CH    ' 0 'HCOR003' 'current   ' 'currentPM ' [-11.0  11.0]
     4  [ 1 4] 'ANS-C01/AE/S4-CH      ' 1 'HCOR004' 'current   ' 'currentPM ' [-11.0  11.0]
     5  [ 1 5] 'ANS-C01/AE/S3.2-CH    ' 0 'HCOR005' 'current   ' 'currentPM ' [-11.0  11.0]
     6  [ 1 6] 'ANS-C01/AE/S5-CH      ' 0 'HCOR006' 'current   ' 'currentPM ' [-11.0  11.0]
     7  [ 1 7] 'ANS-C01/AE/S6-CH      ' 1 'HCOR007' 'current   ' 'currentPM ' [-11.0  11.0]
     8  [ 2 1] 'ANS-C02/AE/S8.1-CH    ' 1 'HCOR008' 'current   ' 'currentPM ' [-11.0  11.0]
     9  [ 2 2] 'ANS-C02/AE/S7.1-CH    ' 0 'HCOR009' 'current   ' 'currentPM ' [-11.0  11.0]
    10  [ 2 3] 'ANS-C02/AE/S9.1-CH    ' 0 'HCOR010' 'current   ' 'currentPM ' [-11.0  11.0]
    11  [ 2 4] 'ANS-C02/AE/S10.1-CH   ' 1 'HCOR011' 'current   ' 'currentPM ' [-11.0  11.0]
    12  [ 2 5] 'ANS-C02/AE/S10.2-CH   ' 1 'HCOR012' 'current   ' 'currentPM ' [-11.0  11.0]
    13  [ 2 6] 'ANS-C02/AE/S9.2-CH    ' 0 'HCOR013' 'current   ' 'currentPM ' [-11.0  11.0]
    14  [ 2 7] 'ANS-C02/AE/S7.2-CH    ' 0 'HCOR014' 'current   ' 'currentPM ' [-11.0  11.0]
    15  [ 2 8] 'ANS-C02/AE/S8.2-CH    ' 1 'HCOR015' 'current   ' 'currentPM ' [-11.0  11.0]
    16  [ 3 1] 'ANS-C03/AE/S8.1-CH    ' 1 'HCOR016' 'current   ' 'currentPM ' [-11.0  11.0]
    17  [ 3 2] 'ANS-C03/AE/S7.1-CH    ' 0 'HCOR017' 'current   ' 'currentPM ' [-11.0  11.0]
    18  [ 3 3] 'ANS-C03/AE/S9.1-CH    ' 0 'HCOR018' 'current   ' 'currentPM ' [-11.0  11.0]
    19  [ 3 4] 'ANS-C03/AE/S10.1-CH   ' 1 'HCOR019' 'current   ' 'currentPM ' [-11.0  11.0]
    20  [ 3 5] 'ANS-C03/AE/S10.2-CH   ' 1 'HCOR020' 'current   ' 'currentPM ' [-11.0  11.0]
    21  [ 3 6] 'ANS-C03/AE/S9.2-CH    ' 0 'HCOR021' 'current   ' 'currentPM ' [-11.0  11.0]
    22  [ 3 7] 'ANS-C03/AE/S7.2-CH    ' 0 'HCOR022' 'current   ' 'currentPM ' [-11.0  11.0]
    23  [ 3 8] 'ANS-C03/AE/S8.2-CH    ' 1 'HCOR023' 'current   ' 'currentPM ' [-11.0  11.0]
    24  [ 4 1] 'ANS-C04/AE/S6-CH      ' 1 'HCOR024' 'current   ' 'currentPM ' [-11.0  11.0]
    25  [ 4 2] 'ANS-C04/AE/S5-CH      ' 0 'HCOR025' 'current   ' 'currentPM ' [-11.0  11.0]
    26  [ 4 3] 'ANS-C04/AE/S3.1-CH    ' 0 'HCOR026' 'current   ' 'currentPM ' [-11.0  11.0]
    27  [ 4 4] 'ANS-C04/AE/S4-CH      ' 1 'HCOR027' 'current   ' 'currentPM ' [-11.0  11.0]
    28  [ 4 5] 'ANS-C04/AE/S3.2-CH    ' 0 'HCOR028' 'current   ' 'currentPM ' [-11.0  11.0]
    29  [ 4 6] 'ANS-C04/AE/S2-CH      ' 0 'HCOR029' 'current   ' 'currentPM ' [-11.0  11.0]
    30  [ 4 7] 'ANS-C04/AE/S1-CH      ' 1 'HCOR030' 'current   ' 'currentPM ' [-11.0  11.0]
    31  [ 5 8] 'ANS-C05/EI/L-HU640    ' 0 'HCOR121' 'currentCHE' 'currentCHE' [ -5   5]
    32  [ 5 9] 'ANS-C05/EI/L-HU640    ' 0 'HCOR122' 'currentCHS' 'currentCHS' [ -5   5]
    33  [ 5 1] 'ANS-C05/AE/S1-CH      ' 1 'HCOR031' 'current   ' 'currentPM ' [-11.0  11.0]
    34  [ 5 2] 'ANS-C05/AE/S2-CH      ' 0 'HCOR032' 'current   ' 'currentPM ' [-11.0  11.0]
    35  [ 5 3] 'ANS-C05/AE/S3.1-CH    ' 0 'HCOR033' 'current   ' 'currentPM ' [-11.0  11.0]
    36  [ 5 4] 'ANS-C05/AE/S4-CH      ' 1 'HCOR034' 'current   ' 'currentPM ' [-11.0  11.0]
    37  [ 5 5] 'ANS-C05/AE/S3.2-CH    ' 0 'HCOR035' 'current   ' 'currentPM ' [-11.0  11.0]
    38  [ 5 6] 'ANS-C05/AE/S5-CH      ' 0 'HCOR036' 'current   ' 'currentPM ' [-11.0  11.0]
    39  [ 5 7] 'ANS-C05/AE/S6-CH      ' 1 'HCOR037' 'current   ' 'currentPM ' [-11.0  11.0]
    40  [ 6 1] 'ANS-C06/AE/S8.1-CH    ' 1 'HCOR038' 'current   ' 'currentPM ' [-11.0  11.0]
    41  [ 6 2] 'ANS-C06/AE/S7.1-CH    ' 0 'HCOR039' 'current   ' 'currentPM ' [-11.0  11.0]
    42  [ 6 3] 'ANS-C06/AE/S9.1-CH    ' 0 'HCOR040' 'current   ' 'currentPM ' [-11.0  11.0]
    43  [ 6 4] 'ANS-C06/AE/S10.1-CH   ' 1 'HCOR041' 'current   ' 'currentPM ' [-11.0  11.0]
    44  [ 6 5] 'ANS-C06/AE/S10.2-CH   ' 1 'HCOR042' 'current   ' 'currentPM ' [-11.0  11.0]
    45  [ 6 6] 'ANS-C06/AE/S9.2-CH    ' 0 'HCOR043' 'current   ' 'currentPM ' [-11.0  11.0]
    46  [ 6 7] 'ANS-C06/AE/S7.2-CH    ' 0 'HCOR044' 'current   ' 'currentPM ' [-11.0  11.0]
    47  [ 6 8] 'ANS-C06/AE/S8.2-CH    ' 1 'HCOR045' 'current   ' 'currentPM ' [-11.0  11.0]
    48  [ 7 1] 'ANS-C07/AE/S8.1-CH    ' 1 'HCOR046' 'current   ' 'currentPM ' [-11.0  11.0]
    49  [ 7 2] 'ANS-C07/AE/S7.1-CH    ' 0 'HCOR047' 'current   ' 'currentPM ' [-11.0  11.0]
    50  [ 7 3] 'ANS-C07/AE/S9.1-CH    ' 0 'HCOR048' 'current   ' 'currentPM ' [-11.0  11.0]
    51  [ 7 4] 'ANS-C07/AE/S10.1-CH   ' 1 'HCOR049' 'current   ' 'currentPM ' [-11.0  11.0]
    52  [ 7 5] 'ANS-C07/AE/S10.2-CH   ' 1 'HCOR050' 'current   ' 'currentPM ' [-11.0  11.0]
    53  [ 7 6] 'ANS-C07/AE/S9.2-CH    ' 0 'HCOR051' 'current   ' 'currentPM ' [-11.0  11.0]
    54  [ 7 7] 'ANS-C07/AE/S7.2-CH    ' 0 'HCOR052' 'current   ' 'currentPM ' [-11.0  11.0]
    55  [ 7 8] 'ANS-C07/AE/S8.2-CH    ' 1 'HCOR053' 'current   ' 'currentPM ' [-11.0  11.0]
    56  [ 8 1] 'ANS-C08/AE/S6-CH      ' 1 'HCOR054' 'current   ' 'currentPM ' [-11.0  11.0]
    57  [ 8 2] 'ANS-C08/AE/S5-CH      ' 0 'HCOR055' 'current   ' 'currentPM ' [-11.0  11.0]
    58  [ 8 3] 'ANS-C08/AE/S3.1-CH    ' 0 'HCOR056' 'current   ' 'currentPM ' [-11.0  11.0]
    59  [ 8 4] 'ANS-C08/AE/S4-CH      ' 1 'HCOR057' 'current   ' 'currentPM ' [-11.0  11.0]
    60  [ 8 5] 'ANS-C08/AE/S3.2-CH    ' 0 'HCOR058' 'current   ' 'currentPM ' [-11.0  11.0]
    61  [ 8 6] 'ANS-C08/AE/S2-CH      ' 0 'HCOR059' 'current   ' 'currentPM ' [-11.0  11.0]
    62  [ 8 7] 'ANS-C08/AE/S1-CH      ' 1 'HCOR060' 'current   ' 'currentPM ' [-11.0  11.0]
    63  [ 9 1] 'ANS-C09/AE/S1-CH      ' 1 'HCOR061' 'current   ' 'currentPM ' [-11.0  11.0]
    64  [ 9 2] 'ANS-C09/AE/S2-CH      ' 0 'HCOR062' 'current   ' 'currentPM ' [-11.0  11.0]
    65  [ 9 3] 'ANS-C09/AE/S3.1-CH    ' 0 'HCOR063' 'current   ' 'currentPM ' [-11.0  11.0]
    66  [ 9 4] 'ANS-C09/AE/S4-CH      ' 1 'HCOR064' 'current   ' 'currentPM ' [-11.0  11.0]
    67  [ 9 5] 'ANS-C09/AE/S3.2-CH    ' 0 'HCOR065' 'current   ' 'currentPM ' [-11.0  11.0]
    68  [ 9 6] 'ANS-C09/AE/S5-CH      ' 0 'HCOR066' 'current   ' 'currentPM ' [-11.0  11.0]
    69  [ 9 7] 'ANS-C09/AE/S6-CH      ' 1 'HCOR067' 'current   ' 'currentPM ' [-11.0  11.0]
    70  [10 1] 'ANS-C10/AE/S8.1-CH    ' 1 'HCOR068' 'current   ' 'currentPM ' [-11.0  11.0]
    71  [10 2] 'ANS-C10/AE/S7.1-CH    ' 0 'HCOR069' 'current   ' 'currentPM ' [-11.0  11.0]
    72  [10 3] 'ANS-C10/AE/S9.1-CH    ' 0 'HCOR070' 'current   ' 'currentPM ' [-11.0  11.0]
    73  [10 4] 'ANS-C10/AE/S10.1-CH   ' 1 'HCOR071' 'current   ' 'currentPM ' [-11.0  11.0]
    74  [10 5] 'ANS-C10/AE/S10.2-CH   ' 1 'HCOR072' 'current   ' 'currentPM ' [-11.0  11.0]
    75  [10 6] 'ANS-C10/AE/S9.2-CH    ' 0 'HCOR073' 'current   ' 'currentPM ' [-11.0  11.0]
    76  [10 7] 'ANS-C10/AE/S7.2-CH    ' 0 'HCOR074' 'current   ' 'currentPM ' [-11.0  11.0]
    77  [10 8] 'ANS-C10/AE/S8.2-CH    ' 1 'HCOR075' 'current   ' 'currentPM ' [-11.0  11.0]
    78  [11 1] 'ANS-C11/AE/S8.1-CH    ' 1 'HCOR076' 'current   ' 'currentPM ' [-11.0  11.0]
    79  [11 2] 'ANS-C11/AE/S7.1-CH    ' 0 'HCOR077' 'current   ' 'currentPM ' [-11.0  11.0]
    80  [11 3] 'ANS-C11/AE/S9.1-CH    ' 0 'HCOR078' 'current   ' 'currentPM ' [-11.0  11.0]
    81  [11 4] 'ANS-C11/AE/S10.1-CH   ' 1 'HCOR079' 'current   ' 'currentPM ' [-11.0  11.0]
    82  [11 5] 'ANS-C11/AE/S10.2-CH   ' 1 'HCOR080' 'current   ' 'currentPM ' [-11.0  11.0]
    83  [11 6] 'ANS-C11/AE/S9.2-CH    ' 0 'HCOR081' 'current   ' 'currentPM ' [-11.0  11.0]
    84  [11 7] 'ANS-C11/AE/S7.2-CH    ' 0 'HCOR082' 'current   ' 'currentPM ' [-11.0  11.0]
    85  [11 8] 'ANS-C11/AE/S8.2-CH    ' 1 'HCOR083' 'current   ' 'currentPM ' [-11.0  11.0]
    86  [12 1] 'ANS-C12/AE/S6-CH      ' 1 'HCOR084' 'current   ' 'currentPM ' [-11.0  11.0]
    87  [12 2] 'ANS-C12/AE/S5-CH      ' 0 'HCOR085' 'current   ' 'currentPM ' [-11.0  11.0]
    88  [12 3] 'ANS-C12/AE/S3.1-CH    ' 0 'HCOR086' 'current   ' 'currentPM ' [-11.0  11.0]
    89  [12 4] 'ANS-C12/AE/S4-CH      ' 1 'HCOR087' 'current   ' 'currentPM ' [-11.0  11.0]
    90  [12 5] 'ANS-C12/AE/S3.2-CH    ' 0 'HCOR088' 'current   ' 'currentPM ' [-11.0  11.0]
    91  [12 6] 'ANS-C12/AE/S2-CH      ' 1 'HCOR089' 'current   ' 'currentPM ' [-11.0  11.0]
    92  [12 7] 'ANS-C12/AE/S1-CH      ' 1 'HCOR090' 'current   ' 'currentPM ' [-11.0  11.0]
    93  [13 8] 'ANS-C13/AE/S12.1-CH   ' 1 'HCOR123' 'current   ' 'currentPM ' [-11.0  11.0]
    94  [13 9] 'ANS-C13/AE/S12.2-CH   ' 1 'HCOR124' 'current   ' 'currentPM ' [-11.0  11.0]
    95  [13 1] 'ANS-C13/AE/S1-CH      ' 1 'HCOR091' 'current   ' 'currentPM ' [-11.0  11.0]
    96  [13 2] 'ANS-C13/AE/S2-CH      ' 1 'HCOR092' 'current   ' 'currentPM ' [-11.0  11.0]
    97  [13 3] 'ANS-C13/AE/S3.1-CH    ' 0 'HCOR093' 'current   ' 'currentPM ' [-11.0  11.0]
    98  [13 4] 'ANS-C13/AE/S4-CH      ' 1 'HCOR094' 'current   ' 'currentPM ' [-11.0  11.0]
    99  [13 5] 'ANS-C13/AE/S3.2-CH    ' 0 'HCOR095' 'current   ' 'currentPM ' [-11.0  11.0]
   100  [13 6] 'ANS-C13/AE/S5-CH      ' 0 'HCOR096' 'current   ' 'currentPM ' [-11.0  11.0]
   101  [13 7] 'ANS-C13/AE/S6-CH      ' 1 'HCOR097' 'current   ' 'currentPM ' [-11.0  11.0]
   102  [14 1] 'ANS-C14/AE/S8.1-CH    ' 1 'HCOR098' 'current   ' 'currentPM ' [-11.0  11.0]
   103  [14 2] 'ANS-C14/AE/S7.1-CH    ' 0 'HCOR099' 'current   ' 'currentPM ' [-11.0  11.0]
   104  [14 3] 'ANS-C14/AE/S9.1-CH    ' 0 'HCOR100' 'current   ' 'currentPM ' [-11.0  11.0]
   105  [14 4] 'ANS-C14/AE/S10.1-CH   ' 1 'HCOR101' 'current   ' 'currentPM ' [-11.0  11.0]
   106  [14 5] 'ANS-C14/AE/S10.2-CH   ' 1 'HCOR102' 'current   ' 'currentPM ' [-11.0  11.0]
   107  [14 6] 'ANS-C14/AE/S9.2-CH    ' 0 'HCOR103' 'current   ' 'currentPM ' [-11.0  11.0]
   108  [14 7] 'ANS-C14/AE/S7.2-CH    ' 0 'HCOR104' 'current   ' 'currentPM ' [-11.0  11.0]
   109  [14 8] 'ANS-C14/AE/S8.2-CH    ' 1 'HCOR105' 'current   ' 'currentPM ' [-11.0  11.0]
   110  [15 1] 'ANS-C15/AE/S8.1-CH    ' 1 'HCOR106' 'current   ' 'currentPM ' [-11.0  11.0]
   111  [15 2] 'ANS-C15/AE/S7.1-CH    ' 0 'HCOR107' 'current   ' 'currentPM ' [-11.0  11.0]
   112  [15 3] 'ANS-C15/AE/S9.1-CH    ' 0 'HCOR108' 'current   ' 'currentPM ' [-11.0  11.0]
   113  [15 4] 'ANS-C15/AE/S10.1-CH   ' 1 'HCOR109' 'current   ' 'currentPM ' [-11.0  11.0]
   114  [15 5] 'ANS-C15/AE/S10.2-CH   ' 1 'HCOR110' 'current   ' 'currentPM ' [-11.0  11.0]
   115  [15 6] 'ANS-C15/AE/S9.2-CH    ' 0 'HCOR111' 'current   ' 'currentPM ' [-11.0  11.0]
   116  [15 7] 'ANS-C15/AE/S7.2-CH    ' 0 'HCOR112' 'current   ' 'currentPM ' [-11.0  11.0]
   117  [15 8] 'ANS-C15/AE/S8.2-CH    ' 1 'HCOR113' 'current   ' 'currentPM ' [-11.0  11.0]
   118  [16 1] 'ANS-C16/AE/S6-CH      ' 1 'HCOR114' 'current   ' 'currentPM ' [-11.0  11.0]
   119  [16 2] 'ANS-C16/AE/S5-CH      ' 0 'HCOR115' 'current   ' 'currentPM ' [-11.0  11.0]
   120  [16 3] 'ANS-C16/AE/S3.1-CH    ' 1 'HCOR116' 'current   ' 'currentPM ' [-11.0  11.0]
   121  [16 4] 'ANS-C16/AE/S4-CH      ' 0 'HCOR117' 'current   ' 'currentPM ' [-11.0  11.0]
   122  [16 5] 'ANS-C16/AE/S3.2-CH    ' 0 'HCOR118' 'current   ' 'currentPM ' [-11.0  11.0]
   123  [16 6] 'ANS-C16/AE/S2-CH      ' 0 'HCOR119' 'current   ' 'currentPM ' [-11.0  11.0]
   124  [16 7] 'ANS-C16/AE/S1-CH      ' 1 'HCOR120' 'current   ' 'currentPM ' [-11.0  11.0]
    };

devnumber = length(varlist);
% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).Gain        = ones(devnumber,1);
AO.(ifam).Roll        = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
AO.(ifam).Setpoint.TangoNames = cell(devnumber,1);
AO.(ifam).Setpoint.Range = zeros(devnumber,2);

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,5));
    AO.(ifam).Monitor.TangoNames(k)  = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,6)));
    AO.(ifam).Setpoint.TangoNames(k) = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,7)));
    AO.(ifam).Setpoint.Range(k,:)      = varlist{k,8};
    % information for getrunflag
    AO.(ifam).Setpoint.RunFlagFcn = @corgetrunflag;
    AO.(ifam).Setpoint.RampRate = 1;
end

%Load fields from datablock
% AT use the "A-coefficients" for correctors plus an offset
setao(AO);
[C, Leff, MagnetType, coefficients] = magnetcoefficients(AO.(ifam).FamilyName);
for ii = 1:devnumber,
    AO.(ifam).Monitor.HW2PhysicsParams{1}(ii,:)   = coefficients;
    AO.(ifam).Monitor.Physics2HWParams{1}(ii,:)   = coefficients;
    AO.(ifam).Setpoint.HW2PhysicsParams{1}(ii,:)  = coefficients;
    AO.(ifam).Setpoint.Physics2HWParams{1}(ii,:)  = coefficients;
end


AO.(ifam).Monitor.HW2PhysicsParams{1}(31,:)   = [0 0 0 0 0 0  2.475e-4 0]; % T.m
AO.(ifam).Monitor.Physics2HWParams{1}(31,:)   = [0 0 0 0 0 0  2.475e-4 0]; % T.m
AO.(ifam).Setpoint.HW2PhysicsParams{1}(31,:)  = [0 0 0 0 0 0  2.475e-4 0]; % T.m
AO.(ifam).Setpoint.Physics2HWParams{1}(31,:)  = [0 0 0 0 0 0  2.475e-4 0]; % T.m
AO.(ifam).Monitor.HW2PhysicsParams{1}(32,:)   = [0 0 0 0 0 0 -2.443e-4 0]; % T.m
AO.(ifam).Monitor.Physics2HWParams{1}(32,:)   = [0 0 0 0 0 0 -2.443e-4 0]; % T.m
AO.(ifam).Setpoint.HW2PhysicsParams{1}(32,:)  = [0 0 0 0 0 0 -2.443e-4 0]; % T.m
AO.(ifam).Setpoint.Physics2HWParams{1}(32,:)  = [0 0 0 0 0 0 -2.443e-4 0]; % T.m

AO.(ifam).Setpoint.Tolerance(:,:)    = 1e-2*ones(devnumber,1);
% Warning optics dependent cf. Low alpha lattice
AO.(ifam).Setpoint.DeltaRespMat(:,:) = ones(devnumber,1)*5e-6*2; % 2*5 urad (half used for kicking)
%AO.(ifam).Setpoint.DeltaRespMat(:,:) = ones(devnumber,1)*0.5e-4*1; % 2*25 urad (half used for kicking)
AO.(ifam).Setpoint.DeltaRespMat(31)  = 10e-6; %rad
AO.(ifam).Setpoint.DeltaRespMat(32)  = 10e-6; %rad

dummy = strcat(AO.(ifam).DeviceName,'/voltage');
AO.(ifam).Voltage.TangoNames(:,:)     = {dummy{:},'ANS-C05/EI/L-HU640/currentCHE', 'ANS-C05/EI/L-HU640/currentCHS'}';

AO.(ifam).Monitor.MemberOf      = {'PlotFamily'};
AO.(ifam).Setpoint.MemberOf     = {'PlotFamily'};
AO.(ifam).Voltage.MemberOf      = {'PlotFamily'};

% Profibus configuration sync/unsync mecanism
AO.(ifam).Profibus.BoardNumber = int32(0);
AO.(ifam).Profibus.Group       = int32(1);
AO.(ifam).Profibus.DeviceName  = 'ANS/AE/DP.CH';

% Group
if ControlRoomFlag
        AO.(ifam).GroupId = tango_group_create2(ifam);
        tango_group_add(AO.(ifam).GroupId,AO.(ifam).DeviceName(find(AO.(ifam).Status),:)');
else
    AO.(ifam).GroupId = nan;
end

%convert response matrix kicks to HWUnits (after AO is loaded to AppData)
setao(AO);   %required to make physics2hw function
AO.(ifam).Setpoint.DeltaRespMat = physics2hw(AO.(ifam).FamilyName,'Setpoint', ...
    AO.(ifam).Setpoint.DeltaRespMat, AO.(ifam).DeviceList);

AO.(ifam).TangoSetpoint = AO.(ifam).Setpoint;
AO.(ifam).TangoSetpoint.TangoNames(:,:)    = strcat(AO.(ifam).DeviceName,'/currentTotal');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SLOW VERTICAL CORRECTORS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ifam = 'VCOR';
AO.(ifam).FamilyName               = ifam;
AO.(ifam).FamilyType               = 'COR';
AO.(ifam).MemberOf                 = {'MachineConfig'; 'VCOR'; 'COR'; 'Magnet'; 'PlotFamily'; 'Archivable'};

AO.(ifam).Monitor.Mode             = Mode;
AO.(ifam).Monitor.DataType         = 'Scalar';
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'A';
AO.(ifam).Monitor.PhysicsUnits     = 'meter^-2';
AO.(ifam).Monitor.HW2PhysicsFcn = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn = @k2amp;

AO.(ifam).Setpoint.Mode             = Mode;
AO.(ifam).Setpoint.DataType         = 'Scalar';
AO.(ifam).Setpoint.Units            = 'Hardware';
AO.(ifam).Setpoint.HWUnits          = 'A';
AO.(ifam).Setpoint.PhysicsUnits     = 'rad';
AO.(ifam).Setpoint.HW2PhysicsFcn    = @amp2k;
AO.(ifam).Setpoint.Physics2HWFcn    = @k2amp;

AO.(ifam).Voltage.Mode             = Mode;
AO.(ifam).Voltage.DataType         = 'Scalar';
AO.(ifam).Voltage.Units            = 'Hardware';
AO.(ifam).Voltage.HWUnits          = 'A';
AO.(ifam).Voltage.PhysicsUnits     = 'rad';
AO.(ifam).Voltage.HW2PhysicsFcn    = @amp2k;
AO.(ifam).Voltage.Physics2HWFcn    = @k2amp;

varlist = {
     1 [ 1 1] 'ANS-C01/AE/S1-CV         ' 0 'VCOR001' 'current   ' 'currentPM ' [-14.0  14.0]
     2 [ 1 2] 'ANS-C01/AE/S2-CV         ' 1 'VCOR002' 'current   ' 'currentPM ' [-14.0  14.0]
     3 [ 1 3] 'ANS-C01/AE/S3.1-CV       ' 0 'VCOR003' 'current   ' 'currentPM ' [-14.0  14.0]
     4 [ 1 4] 'ANS-C01/AE/S4-CV         ' 1 'VCOR004' 'current   ' 'currentPM ' [-14.0  14.0]
     5 [ 1 5] 'ANS-C01/AE/S3.2-CV       ' 0 'VCOR005' 'current   ' 'currentPM ' [-14.0  14.0]
     6 [ 1 6] 'ANS-C01/AE/S5-CV         ' 1 'VCOR006' 'current   ' 'currentPM ' [-14.0  14.0]
     7 [ 1 7] 'ANS-C01/AE/S6-CV         ' 0 'VCOR007' 'current   ' 'currentPM ' [-14.0  14.0]
     8 [ 2 1] 'ANS-C02/AE/S8.1-CV       ' 0 'VCOR008' 'current   ' 'currentPM ' [-14.0  14.0]
     9 [ 2 2] 'ANS-C02/AE/S7.1-CV       ' 1 'VCOR009' 'current   ' 'currentPM ' [-14.0  14.0]
    10 [ 2 3] 'ANS-C02/AE/S9.1-CV       ' 1 'VCOR010' 'current   ' 'currentPM ' [-14.0  14.0]
    11 [ 2 4] 'ANS-C02/AE/S10.1-CV      ' 0 'VCOR011' 'current   ' 'currentPM ' [-14.0  14.0]
    12 [ 2 5] 'ANS-C02/AE/S10.2-CV      ' 0 'VCOR012' 'current   ' 'currentPM ' [-14.0  14.0]
    13 [ 2 6] 'ANS-C02/AE/S9.2-CV       ' 1 'VCOR013' 'current   ' 'currentPM ' [-14.0  14.0]
    14 [ 2 7] 'ANS-C02/AE/S7.2-CV       ' 1 'VCOR014' 'current   ' 'currentPM ' [-14.0  14.0]
    15 [ 2 8] 'ANS-C02/AE/S8.2-CV       ' 0 'VCOR015' 'current   ' 'currentPM ' [-14.0  14.0]
    16 [ 3 1] 'ANS-C03/AE/S8.1-CV       ' 0 'VCOR016' 'current   ' 'currentPM ' [-14.0  14.0]
    17 [ 3 2] 'ANS-C03/AE/S7.1-CV       ' 1 'VCOR017' 'current   ' 'currentPM ' [-14.0  14.0]
    18 [ 3 3] 'ANS-C03/AE/S9.1-CV       ' 1 'VCOR018' 'current   ' 'currentPM ' [-14.0  14.0]
    19 [ 3 4] 'ANS-C03/AE/S10.1-CV      ' 0 'VCOR019' 'current   ' 'currentPM ' [-14.0  14.0]
    20 [ 3 5] 'ANS-C03/AE/S10.2-CV      ' 0 'VCOR020' 'current   ' 'currentPM ' [-14.0  14.0]
    21 [ 3 6] 'ANS-C03/AE/S9.2-CV       ' 1 'VCOR021' 'current   ' 'currentPM ' [-14.0  14.0]
    22 [ 3 7] 'ANS-C03/AE/S7.2-CV       ' 1 'VCOR022' 'current   ' 'currentPM ' [-14.0  14.0]
    23 [ 3 8] 'ANS-C03/AE/S8.2-CV       ' 0 'VCOR023' 'current   ' 'currentPM ' [-14.0  14.0]
    24 [ 4 1] 'ANS-C04/AE/S6-CV         ' 0 'VCOR024' 'current   ' 'currentPM ' [-14.0  14.0]
    25 [ 4 2] 'ANS-C04/AE/S5-CV         ' 1 'VCOR025' 'current   ' 'currentPM ' [-14.0  14.0]
    26 [ 4 3] 'ANS-C04/AE/S3.1-CV       ' 0 'VCOR026' 'current   ' 'currentPM ' [-14.0  14.0]
    27 [ 4 4] 'ANS-C04/AE/S4-CV         ' 1 'VCOR027' 'current   ' 'currentPM ' [-14.0  14.0]
    28 [ 4 5] 'ANS-C04/AE/S3.2-CV       ' 0 'VCOR028' 'current   ' 'currentPM ' [-14.0  14.0]
    29 [ 4 6] 'ANS-C04/AE/S2-CV         ' 1 'VCOR029' 'current   ' 'currentPM ' [-14.0  14.0]
    30 [ 4 7] 'ANS-C04/AE/S1-CV         ' 0 'VCOR030' 'current   ' 'currentPM ' [-14.0  14.0]
    31 [ 5 8] 'ANS-C05/EI/L-HU640       ' 0 'VCOR121' 'currentCVE' 'currentCVE' [ -5       5]
    32 [ 5 9] 'ANS-C05/EI/L-HU640       ' 0 'VCOR122' 'currentCVS' 'currentCVS' [ -5       5]
    33 [ 5 1] 'ANS-C05/AE/S1-CV         ' 0 'VCOR031' 'current   ' 'currentPM ' [-14.0  14.0]
    34 [ 5 2] 'ANS-C05/AE/S2-CV         ' 1 'VCOR032' 'current   ' 'currentPM ' [-14.0  14.0]
    35 [ 5 3] 'ANS-C05/AE/S3.1-CV       ' 0 'VCOR033' 'current   ' 'currentPM ' [-14.0  14.0]
    36 [ 5 4] 'ANS-C05/AE/S4-CV         ' 1 'VCOR034' 'current   ' 'currentPM ' [-14.0  14.0]
    37 [ 5 5] 'ANS-C05/AE/S3.2-CV       ' 0 'VCOR035' 'current   ' 'currentPM ' [-14.0  14.0]
    38 [ 5 6] 'ANS-C05/AE/S5-CV         ' 1 'VCOR036' 'current   ' 'currentPM ' [-14.0  14.0]
    39 [ 5 7] 'ANS-C05/AE/S6-CV         ' 0 'VCOR037' 'current   ' 'currentPM ' [-14.0  14.0]
    40 [ 6 1] 'ANS-C06/AE/S8.1-CV       ' 0 'VCOR038' 'current   ' 'currentPM ' [-14.0  14.0]
    41 [ 6 2] 'ANS-C06/AE/S7.1-CV       ' 1 'VCOR039' 'current   ' 'currentPM ' [-14.0  14.0]
    42 [ 6 3] 'ANS-C06/AE/S9.1-CV       ' 1 'VCOR040' 'current   ' 'currentPM ' [-14.0  14.0]
    43 [ 6 4] 'ANS-C06/AE/S10.1-CV      ' 0 'VCOR041' 'current   ' 'currentPM ' [-14.0  14.0]
    44 [ 6 5] 'ANS-C06/AE/S10.2-CV      ' 0 'VCOR042' 'current   ' 'currentPM ' [-14.0  14.0]
    45 [ 6 6] 'ANS-C06/AE/S9.2-CV       ' 1 'VCOR043' 'current   ' 'currentPM ' [-14.0  14.0]
    46 [ 6 7] 'ANS-C06/AE/S7.2-CV       ' 1 'VCOR044' 'current   ' 'currentPM ' [-14.0  14.0]
    47 [ 6 8] 'ANS-C06/AE/S8.2-CV       ' 0 'VCOR045' 'current   ' 'currentPM ' [-14.0  14.0]
    48 [ 7 1] 'ANS-C07/AE/S8.1-CV       ' 0 'VCOR046' 'current   ' 'currentPM ' [-14.0  14.0]
    49 [ 7 2] 'ANS-C07/AE/S7.1-CV       ' 1 'VCOR047' 'current   ' 'currentPM ' [-14.0  14.0]
    50 [ 7 3] 'ANS-C07/AE/S9.1-CV       ' 1 'VCOR048' 'current   ' 'currentPM ' [-14.0  14.0]
    51 [ 7 4] 'ANS-C07/AE/S10.1-CV      ' 0 'VCOR049' 'current   ' 'currentPM ' [-14.0  14.0]
    52 [ 7 5] 'ANS-C07/AE/S10.2-CV      ' 0 'VCOR050' 'current   ' 'currentPM ' [-14.0  14.0]
    53 [ 7 6] 'ANS-C07/AE/S9.2-CV       ' 1 'VCOR051' 'current   ' 'currentPM ' [-14.0  14.0]
    54 [ 7 7] 'ANS-C07/AE/S7.2-CV       ' 1 'VCOR052' 'current   ' 'currentPM ' [-14.0  14.0]
    55 [ 7 8] 'ANS-C07/AE/S8.2-CV       ' 0 'VCOR053' 'current   ' 'currentPM ' [-14.0  14.0]
    56 [ 8 1] 'ANS-C08/AE/S6-CV         ' 0 'VCOR054' 'current   ' 'currentPM ' [-14.0  14.0]
    57 [ 8 2] 'ANS-C08/AE/S5-CV         ' 1 'VCOR055' 'current   ' 'currentPM ' [-14.0  14.0]
    58 [ 8 3] 'ANS-C08/AE/S3.1-CV       ' 0 'VCOR056' 'current   ' 'currentPM ' [-14.0  14.0]
    59 [ 8 4] 'ANS-C08/AE/S4-CV         ' 1 'VCOR057' 'current   ' 'currentPM ' [-14.0  14.0]
    60 [ 8 5] 'ANS-C08/AE/S3.2-CV       ' 0 'VCOR058' 'current   ' 'currentPM ' [-14.0  14.0]
    61 [ 8 6] 'ANS-C08/AE/S2-CV         ' 1 'VCOR059' 'current   ' 'currentPM ' [-14.0  14.0]
    62 [ 8 7] 'ANS-C08/AE/S1-CV         ' 0 'VCOR060' 'current   ' 'currentPM ' [-14.0  14.0]
    63 [ 9 1] 'ANS-C09/AE/S1-CV         ' 0 'VCOR061' 'current   ' 'currentPM ' [-14.0  14.0]
    64 [ 9 2] 'ANS-C09/AE/S2-CV         ' 1 'VCOR062' 'current   ' 'currentPM ' [-14.0  14.0]
    65 [ 9 3] 'ANS-C09/AE/S3.1-CV       ' 0 'VCOR063' 'current   ' 'currentPM ' [-14.0  14.0]
    66 [ 9 4] 'ANS-C09/AE/S4-CV         ' 1 'VCOR064' 'current   ' 'currentPM ' [-14.0  14.0]
    67 [ 9 5] 'ANS-C09/AE/S3.2-CV       ' 0 'VCOR065' 'current   ' 'currentPM ' [-14.0  14.0]
    68 [ 9 6] 'ANS-C09/AE/S5-CV         ' 1 'VCOR066' 'current   ' 'currentPM ' [-14.0  14.0]
    69 [ 9 7] 'ANS-C09/AE/S6-CV         ' 0 'VCOR067' 'current   ' 'currentPM ' [-14.0  14.0]
    70 [10 1] 'ANS-C10/AE/S8.1-CV       ' 0 'VCOR068' 'current   ' 'currentPM ' [-14.0  14.0]
    71 [10 2] 'ANS-C10/AE/S7.1-CV       ' 1 'VCOR069' 'current   ' 'currentPM ' [-14.0  14.0]
    72 [10 3] 'ANS-C10/AE/S9.1-CV       ' 1 'VCOR070' 'current   ' 'currentPM ' [-14.0  14.0]
    73 [10 4] 'ANS-C10/AE/S10.1-CV      ' 0 'VCOR071' 'current   ' 'currentPM ' [-14.0  14.0]
    74 [10 5] 'ANS-C10/AE/S10.2-CV      ' 0 'VCOR072' 'current   ' 'currentPM ' [-14.0  14.0]
    75 [10 6] 'ANS-C10/AE/S9.2-CV       ' 1 'VCOR073' 'current   ' 'currentPM ' [-14.0  14.0]
    76 [10 7] 'ANS-C10/AE/S7.2-CV       ' 1 'VCOR074' 'current   ' 'currentPM ' [-14.0  14.0]
    77 [10 8] 'ANS-C10/AE/S8.2-CV       ' 0 'VCOR075' 'current   ' 'currentPM ' [-14.0  14.0]
    78 [11 1] 'ANS-C11/AE/S8.1-CV       ' 0 'VCOR076' 'current   ' 'currentPM ' [-14.0  14.0]
    79 [11 2] 'ANS-C11/AE/S7.1-CV       ' 1 'VCOR077' 'current   ' 'currentPM ' [-14.0  14.0]
    80 [11 3] 'ANS-C11/AE/S9.1-CV       ' 1 'VCOR078' 'current   ' 'currentPM ' [-14.0  14.0]
    81 [11 4] 'ANS-C11/AE/S10.1-CV      ' 0 'VCOR079' 'current   ' 'currentPM ' [-14.0  14.0]
    82 [11 5] 'ANS-C11/AE/S10.2-CV      ' 0 'VCOR080' 'current   ' 'currentPM ' [-14.0  14.0]
    83 [11 6] 'ANS-C11/AE/S9.2-CV       ' 1 'VCOR081' 'current   ' 'currentPM ' [-14.0  14.0]
    84 [11 7] 'ANS-C11/AE/S7.2-CV       ' 1 'VCOR082' 'current   ' 'currentPM ' [-14.0  14.0]
    85 [11 8] 'ANS-C11/AE/S8.2-CV       ' 0 'VCOR083' 'current   ' 'currentPM ' [-14.0  14.0]
    86 [12 1] 'ANS-C12/AE/S6-CV         ' 0 'VCOR084' 'current   ' 'currentPM ' [-14.0  14.0]
    87 [12 2] 'ANS-C12/AE/S5-CV         ' 1 'VCOR085' 'current   ' 'currentPM ' [-14.0  14.0]
    88 [12 3] 'ANS-C12/AE/S3.1-CV       ' 0 'VCOR086' 'current   ' 'currentPM ' [-14.0  14.0]
    89 [12 4] 'ANS-C12/AE/S4-CV         ' 1 'VCOR087' 'current   ' 'currentPM ' [-14.0  14.0]
    90 [12 5] 'ANS-C12/AE/S3.2-CV       ' 0 'VCOR088' 'current   ' 'currentPM ' [-14.0  14.0]
    91 [12 6] 'ANS-C12/AE/S2-CV         ' 1 'VCOR089' 'current   ' 'currentPM ' [-14.0  14.0]
    92 [12 7] 'ANS-C12/AE/S1-CV         ' 1 'VCOR090' 'current   ' 'currentPM ' [-14.0  14.0]
    93 [13 8] 'ANS-C13/AE/S12.1-CV      ' 1 'VCOR123' 'current   ' 'currentPM ' [-14.0  14.0]
    94 [13 9] 'ANS-C13/AE/S12.2-CV      ' 1 'VCOR124' 'current   ' 'currentPM ' [-14.0  14.0]
    95 [13 1] 'ANS-C13/AE/S1-CV         ' 1 'VCOR091' 'current   ' 'currentPM ' [-14.0  14.0]
    96 [13 2] 'ANS-C13/AE/S2-CV         ' 1 'VCOR092' 'current   ' 'currentPM ' [-14.0  14.0]
    97 [13 3] 'ANS-C13/AE/S3.1-CV       ' 0 'VCOR093' 'current   ' 'currentPM ' [-14.0  14.0]
    98 [13 4] 'ANS-C13/AE/S4-CV         ' 1 'VCOR094' 'current   ' 'currentPM ' [-14.0  14.0]
    99 [13 5] 'ANS-C13/AE/S3.2-CV       ' 0 'VCOR095' 'current   ' 'currentPM ' [-14.0  14.0]
   100 [13 6] 'ANS-C13/AE/S5-CV         ' 1 'VCOR096' 'current   ' 'currentPM ' [-14.0  14.0]
   101 [13 7] 'ANS-C13/AE/S6-CV         ' 0 'VCOR097' 'current   ' 'currentPM ' [-14.0  14.0]
   102 [14 1] 'ANS-C14/AE/S8.1-CV       ' 0 'VCOR098' 'current   ' 'currentPM ' [-14.0  14.0]
   103 [14 2] 'ANS-C14/AE/S7.1-CV       ' 1 'VCOR099' 'current   ' 'currentPM ' [-14.0  14.0]
   104 [14 3] 'ANS-C14/AE/S9.1-CV       ' 1 'VCOR100' 'current   ' 'currentPM ' [-14.0  14.0]
   105 [14 4] 'ANS-C14/AE/S10.1-CV      ' 0 'VCOR101' 'current   ' 'currentPM ' [-14.0  14.0]
   106 [14 5] 'ANS-C14/AE/S10.2-CV      ' 0 'VCOR102' 'current   ' 'currentPM ' [-14.0  14.0]
   107 [14 6] 'ANS-C14/AE/S9.2-CV       ' 1 'VCOR103' 'current   ' 'currentPM ' [-14.0  14.0]
   108 [14 7] 'ANS-C14/AE/S7.2-CV       ' 1 'VCOR104' 'current   ' 'currentPM ' [-14.0  14.0]
   109 [14 8] 'ANS-C14/AE/S8.2-CV       ' 0 'VCOR105' 'current   ' 'currentPM ' [-14.0  14.0]
   110 [15 1] 'ANS-C15/AE/S8.1-CV       ' 0 'VCOR106' 'current   ' 'currentPM ' [-14.0  14.0]
   111 [15 2] 'ANS-C15/AE/S7.1-CV       ' 1 'VCOR107' 'current   ' 'currentPM ' [-14.0  14.0]
   112 [15 3] 'ANS-C15/AE/S9.1-CV       ' 1 'VCOR108' 'current   ' 'currentPM ' [-14.0  14.0]
   113 [15 4] 'ANS-C15/AE/S10.1-CV      ' 0 'VCOR109' 'current   ' 'currentPM ' [-14.0  14.0]
   114 [15 5] 'ANS-C15/AE/S10.2-CV      ' 0 'VCOR110' 'current   ' 'currentPM ' [-14.0  14.0]
   115 [15 6] 'ANS-C15/AE/S9.2-CV       ' 1 'VCOR111' 'current   ' 'currentPM ' [-14.0  14.0]
   116 [15 7] 'ANS-C15/AE/S7.2-CV       ' 1 'VCOR112' 'current   ' 'currentPM ' [-14.0  14.0]
   117 [15 8] 'ANS-C15/AE/S8.2-CV       ' 0 'VCOR113' 'current   ' 'currentPM ' [-14.0  14.0]
   118 [16 1] 'ANS-C16/AE/S6-CV         ' 0 'VCOR114' 'current   ' 'currentPM ' [-14.0  14.0]
   119 [16 2] 'ANS-C16/AE/S5-CV         ' 1 'VCOR115' 'current   ' 'currentPM ' [-14.0  14.0]
   120 [16 3] 'ANS-C16/AE/S3.1-CV       ' 0 'VCOR116' 'current   ' 'currentPM ' [-14.0  14.0]
   121 [16 4] 'ANS-C16/AE/S4-CV         ' 1 'VCOR117' 'current   ' 'currentPM ' [-14.0  14.0]
   122 [16 5] 'ANS-C16/AE/S3.2-CV       ' 0 'VCOR118' 'current   ' 'currentPM ' [-14.0  14.0]
   123 [16 6] 'ANS-C16/AE/S2-CV         ' 1 'VCOR119' 'current   ' 'currentPM ' [-14.0  14.0]
   124 [16 7] 'ANS-C16/AE/S1-CV         ' 0 'VCOR120' 'current   ' 'currentPM ' [-14.0  14.0]
    };

devnumber = length(varlist);
% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).Gain        = ones(devnumber,1);
AO.(ifam).Roll        = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
AO.(ifam).Setpoint.TangoNames = cell(devnumber,1);
AO.(ifam).Setpoint.Range = zeros(devnumber,2);

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,5));
    AO.(ifam).Monitor.TangoNames(k)  = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,6)));
    AO.(ifam).Setpoint.TangoNames(k) = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,7)));
    AO.(ifam).Setpoint.Range(k,:)      = varlist{k,8};
    % information for getrunflag
    AO.(ifam).Setpoint.RunFlagFcn = @corgetrunflag;
    AO.(ifam).Setpoint.RampRate = 1;
end


%Load fields from datablock
% AT use the "A-coefficients" for correctors plus an offset
setao(AO);
[C, Leff, MagnetType, coefficients] = magnetcoefficients(AO.(ifam).FamilyName);

for ii = 1:devnumber,
    AO.(ifam).Monitor.HW2PhysicsParams{1}(ii,:)   = coefficients;
    AO.(ifam).Monitor.Physics2HWParams{1}(ii,:)   = coefficients;
    AO.(ifam).Setpoint.HW2PhysicsParams{1}(ii,:)  = coefficients;
    AO.(ifam).Setpoint.Physics2HWParams{1}(ii,:)  = coefficients;
end

AO.(ifam).Monitor.HW2PhysicsParams{1}(31,:)   = [0 0 0 0 0 0  2.138e-4 0]; % T.m/A
AO.(ifam).Monitor.Physics2HWParams{1}(31,:)   = [0 0 0 0 0 0  2.138e-4 0]; % T.m/A
AO.(ifam).Setpoint.HW2PhysicsParams{1}(31,:)  = [0 0 0 0 0 0  2.138e-4 0]; % T.m/A
AO.(ifam).Setpoint.Physics2HWParams{1}(31,:)  = [0 0 0 0 0 0  2.138e-4 0]; % T.m/A
AO.(ifam).Monitor.HW2PhysicsParams{1}(32,:)   = [0 0 0 0 0 0  2.135e-4 0]; % T.m/A
AO.(ifam).Monitor.Physics2HWParams{1}(32,:)   = [0 0 0 0 0 0  2.135e-4 0]; % T.m/A
AO.(ifam).Setpoint.HW2PhysicsParams{1}(32,:)  = [0 0 0 0 0 0  2.135e-4 0]; % T.m/A
AO.(ifam).Setpoint.Physics2HWParams{1}(32,:)  = [0 0 0 0 0 0  2.135e-4 0]; % T.m/A

AO.(ifam).Monitor.MemberOf  = {'PlotFamily'};
AO.(ifam).Voltage.MemberOf  = {'PlotFamily'};
AO.(ifam).Setpoint.MemberOf  = {'PlotFamily'};

AO.(ifam).Setpoint.Tolerance(:,:)    = 1e-2*ones(devnumber,1);
% Warning optics dependent cf. Low alpha lattice
AO.(ifam).Setpoint.DeltaRespMat(:,:) = ones(devnumber,1)*10e-6*2; % 2*10 urad (half used for kicking)
%AO.(ifam).Setpoint.DeltaRespMat(:,:) = ones(devnumber,1)*1e-4*2; % 2*25 urad (half used for kicking)
AO.(ifam).Setpoint.DeltaRespMat(31)  = 10e-6; %rad
AO.(ifam).Setpoint.DeltaRespMat(32)  = 10e-6; %rad

dummy = strcat(AO.(ifam).DeviceName,'/voltage');
AO.(ifam).Voltage.TangoNames(:,:)     = {dummy{:},'ANS-C05/EI/L-HU640/currentCVE', 'ANS-C05/EI/L-HU640/currentCVS'}';

% Profibus configuration sync/yn=unsync mecanism
AO.(ifam).Profibus.BoardNumber = int32(0);
AO.(ifam).Profibus.Group       = int32(1);
AO.(ifam).Profibus.DeviceName  = 'ANS/AE/DP.CV';

% Group
if ControlRoomFlag
        AO.(ifam).GroupId = tango_group_create2(ifam);
        tango_group_add(AO.(ifam).GroupId,AO.(ifam).DeviceName(find(AO.(ifam).Status),:)');
else
    AO.(ifam).GroupId = nan;
end

%convert response matrix kicks to HWUnits (after AO is loaded to AppData)
setao(AO);   %required to make physics2hw function
AO.(ifam).Setpoint.DeltaRespMat = physics2hw(AO.(ifam).FamilyName,'Setpoint', ...
    AO.(ifam).Setpoint.DeltaRespMat, AO.(ifam).DeviceList);
AO.(ifam).TangoSetpoint = AO.(ifam).Setpoint;
AO.(ifam).TangoSetpoint.TangoNames(:,:)    = strcat(AO.(ifam).DeviceName,'/currentTotal');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Skew Quadrupole data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ifam = 'QT';
AO.(ifam).FamilyName               = ifam;
AO.(ifam).FamilyType               = 'SkewQuad';
AO.(ifam).MemberOf                 = {'MachineConfig'; 'Magnet'; 'PlotFamily'; 'Archivable'};

AO.(ifam).Monitor.Mode             = Mode;
AO.(ifam).Monitor.DataType         = 'Scalar';
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'A';
AO.(ifam).Monitor.PhysicsUnits     = 'meter^-2';
AO.(ifam).Monitor.HW2PhysicsFcn = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn = @k2amp;

% elemlist devlist tangoname status  common   range
varlist = {
     1  [ 1 1] 'ANS-C01/AE/S1-QT         ' 1 'QT001'  [ -7.0   7.0]
     2  [ 1 2] 'ANS-C01/AE/S2-QT         ' 0 'QT002'  [ -7.0   7.0]
     3  [ 1 3] 'ANS-C01/AE/S3.1-QT       ' 0 'QT003'  [ -7.0   7.0]
     4  [ 1 4] 'ANS-C01/AE/S4-QT         ' 1 'QT004'  [ -7.0   7.0]
     5  [ 1 5] 'ANS-C01/AE/S3.2-QT       ' 0 'QT005'  [ -7.0   7.0]
     6  [ 1 6] 'ANS-C01/AE/S5-QT         ' 0 'QT006'  [ -7.0   7.0]
     7  [ 1 7] 'ANS-C01/AE/S6-QT         ' 0 'QT007'  [ -7.0   7.0]
     8  [ 2 1] 'ANS-C02/AE/S8.1-QT       ' 0 'QT008'  [ -7.0   7.0]
     9  [ 2 2] 'ANS-C02/AE/S7.1-QT       ' 0 'QT009'  [ -7.0   7.0]
    10  [ 2 3] 'ANS-C02/AE/S9.1-QT       ' 0 'QT010'  [ -7.0   7.0]
    11  [ 2 4] 'ANS-C02/AE/S10.1-QT      ' 1 'QT011'  [ -7.0   7.0]
    12  [ 2 5] 'ANS-C02/AE/S10.2-QT      ' 0 'QT012'  [ -7.0   7.0]
    13  [ 2 6] 'ANS-C02/AE/S9.2-QT       ' 0 'QT013'  [ -7.0   7.0]
    14  [ 2 7] 'ANS-C02/AE/S7.2-QT       ' 0 'QT014'  [ -7.0   7.0]
    15  [ 2 8] 'ANS-C02/AE/S8.2-QT       ' 1 'QT015'  [ -7.0   7.0]
    16  [ 3 1] 'ANS-C03/AE/S8.1-QT       ' 1 'QT016'  [ -7.0   7.0]
    17  [ 3 2] 'ANS-C03/AE/S7.1-QT       ' 0 'QT017'  [ -7.0   7.0]
    18  [ 3 3] 'ANS-C03/AE/S9.1-QT       ' 0 'QT018'  [ -7.0   7.0]
    19  [ 3 4] 'ANS-C03/AE/S10.1-QT      ' 0 'QT019'  [ -7.0   7.0]
    20  [ 3 5] 'ANS-C03/AE/S10.2-QT      ' 1 'QT020'  [ -7.0   7.0]
    21  [ 3 6] 'ANS-C03/AE/S9.2-QT       ' 0 'QT021'  [ -7.0   7.0]
    22  [ 3 7] 'ANS-C03/AE/S7.2-QT       ' 0 'QT022'  [ -7.0   7.0]
    23  [ 3 8] 'ANS-C03/AE/S8.2-QT       ' 0 'QT023'  [ -7.0   7.0]
    24  [ 4 1] 'ANS-C04/AE/S6-QT         ' 0 'QT024'  [ -7.0   7.0]
    25  [ 4 2] 'ANS-C04/AE/S5-QT         ' 0 'QT025'  [ -7.0   7.0]
    26  [ 4 3] 'ANS-C04/AE/S3.1-QT       ' 0 'QT026'  [ -7.0   7.0]
    27  [ 4 4] 'ANS-C04/AE/S4-QT         ' 1 'QT027'  [ -7.0   7.0]
    28  [ 4 5] 'ANS-C04/AE/S3.2-QT       ' 0 'QT028'  [ -7.0   7.0]
    29  [ 4 6] 'ANS-C04/AE/S2-QT         ' 0 'QT029'  [ -7.0   7.0]
    30  [ 4 7] 'ANS-C04/AE/S1-QT         ' 1 'QT030'  [ -7.0   7.0]
    31  [ 5 1] 'ANS-C05/AE/S1-QT         ' 1 'QT031'  [ -7.0   7.0]
    32  [ 5 2] 'ANS-C05/AE/S2-QT         ' 0 'QT032'  [ -7.0   7.0]
    33  [ 5 3] 'ANS-C05/AE/S3.1-QT       ' 0 'QT033'  [ -7.0   7.0]
    34  [ 5 4] 'ANS-C05/AE/S4-QT         ' 1 'QT034'  [ -7.0   7.0]
    35  [ 5 5] 'ANS-C05/AE/S3.2-QT       ' 0 'QT035'  [ -7.0   7.0]
    36  [ 5 6] 'ANS-C05/AE/S5-QT         ' 0 'QT036'  [ -7.0   7.0]
    37  [ 5 7] 'ANS-C05/AE/S6-QT         ' 0 'QT037'  [ -7.0   7.0]
    38  [ 6 1] 'ANS-C06/AE/S8.1-QT       ' 0 'QT038'  [ -7.0   7.0]
    39  [ 6 2] 'ANS-C06/AE/S7.1-QT       ' 0 'QT039'  [ -7.0   7.0]
    40  [ 6 3] 'ANS-C06/AE/S9.1-QT       ' 0 'QT040'  [ -7.0   7.0]
    41  [ 6 4] 'ANS-C06/AE/S10.1-QT      ' 1 'QT041'  [ -7.0   7.0]
    42  [ 6 5] 'ANS-C06/AE/S10.2-QT      ' 0 'QT042'  [ -7.0   7.0]
    43  [ 6 6] 'ANS-C06/AE/S9.2-QT       ' 0 'QT043'  [ -7.0   7.0]
    44  [ 6 7] 'ANS-C06/AE/S7.2-QT       ' 0 'QT044'  [ -7.0   7.0]
    45  [ 6 8] 'ANS-C06/AE/S8.2-QT       ' 1 'QT045'  [ -7.0   7.0]
    46  [ 7 1] 'ANS-C07/AE/S8.1-QT       ' 1 'QT046'  [ -7.0   7.0]
    47  [ 7 2] 'ANS-C07/AE/S7.1-QT       ' 0 'QT047'  [ -7.0   7.0]
    48  [ 7 3] 'ANS-C07/AE/S9.1-QT       ' 0 'QT048'  [ -7.0   7.0]
    49  [ 7 4] 'ANS-C07/AE/S10.1-QT      ' 0 'QT049'  [ -7.0   7.0]
    50  [ 7 5] 'ANS-C07/AE/S10.2-QT      ' 1 'QT050'  [ -7.0   7.0]
    51  [ 7 6] 'ANS-C07/AE/S9.2-QT       ' 0 'QT051'  [ -7.0   7.0]
    52  [ 7 7] 'ANS-C07/AE/S7.2-QT       ' 0 'QT052'  [ -7.0   7.0]
    53  [ 7 8] 'ANS-C07/AE/S8.2-QT       ' 0 'QT053'  [ -7.0   7.0]
    54  [ 8 1] 'ANS-C08/AE/S6-QT         ' 0 'QT054'  [ -7.0   7.0]
    55  [ 8 2] 'ANS-C08/AE/S5-QT         ' 0 'QT055'  [ -7.0   7.0]
    56  [ 8 3] 'ANS-C08/AE/S3.1-QT       ' 0 'QT056'  [ -7.0   7.0]
    57  [ 8 4] 'ANS-C08/AE/S4-QT         ' 1 'QT057'  [ -7.0   7.0]
    58  [ 8 5] 'ANS-C08/AE/S3.2-QT       ' 0 'QT058'  [ -7.0   7.0]
    59  [ 8 6] 'ANS-C08/AE/S2-QT         ' 0 'QT059'  [ -7.0   7.0]
    60  [ 8 7] 'ANS-C08/AE/S1-QT         ' 1 'QT060'  [ -7.0   7.0]
    61  [ 9 1] 'ANS-C09/AE/S1-QT         ' 1 'QT061'  [ -7.0   7.0]
    62  [ 9 2] 'ANS-C09/AE/S2-QT         ' 0 'QT062'  [ -7.0   7.0]
    63  [ 9 3] 'ANS-C09/AE/S3.1-QT       ' 0 'QT063'  [ -7.0   7.0]
    64  [ 9 4] 'ANS-C09/AE/S4-QT         ' 1 'QT064'  [ -7.0   7.0]
    65  [ 9 5] 'ANS-C09/AE/S3.2-QT       ' 0 'QT065'  [ -7.0   7.0]
    66  [ 9 6] 'ANS-C09/AE/S5-QT         ' 0 'QT066'  [ -7.0   7.0]
    67  [ 9 7] 'ANS-C09/AE/S6-QT         ' 0 'QT067'  [ -7.0   7.0]
    68  [10 1] 'ANS-C10/AE/S8.1-QT       ' 0 'QT068'  [ -7.0   7.0]
    69  [10 2] 'ANS-C10/AE/S7.1-QT       ' 0 'QT069'  [ -7.0   7.0]
    70  [10 3] 'ANS-C10/AE/S9.1-QT       ' 0 'QT070'  [ -7.0   7.0]
    71  [10 4] 'ANS-C10/AE/S10.1-QT      ' 1 'QT071'  [ -7.0   7.0]
    72  [10 5] 'ANS-C10/AE/S10.2-QT      ' 0 'QT072'  [ -7.0   7.0]
    73  [10 6] 'ANS-C10/AE/S9.2-QT       ' 0 'QT073'  [ -7.0   7.0]
    74  [10 7] 'ANS-C10/AE/S7.2-QT       ' 0 'QT074'  [ -7.0   7.0]
    75  [10 8] 'ANS-C10/AE/S8.2-QT       ' 1 'QT075'  [ -7.0   7.0]
    76  [11 1] 'ANS-C11/AE/S8.1-QT       ' 1 'QT076'  [ -7.0   7.0]
    77  [11 2] 'ANS-C11/AE/S7.1-QT       ' 0 'QT077'  [ -7.0   7.0]
    78  [11 3] 'ANS-C11/AE/S9.1-QT       ' 0 'QT078'  [ -7.0   7.0]
    79  [11 4] 'ANS-C11/AE/S10.1-QT      ' 0 'QT079'  [ -7.0   7.0]
    80  [11 5] 'ANS-C11/AE/S10.2-QT      ' 1 'QT080'  [ -7.0   7.0]
    81  [11 6] 'ANS-C11/AE/S9.2-QT       ' 0 'QT081'  [ -7.0   7.0]
    82  [11 7] 'ANS-C11/AE/S7.2-QT       ' 0 'QT082'  [ -7.0   7.0]
    83  [11 8] 'ANS-C11/AE/S8.2-QT       ' 0 'QT083'  [ -7.0   7.0]
    84  [12 1] 'ANS-C12/AE/S6-QT         ' 0 'QT084'  [ -7.0   7.0]
    85  [12 2] 'ANS-C12/AE/S5-QT         ' 0 'QT085'  [ -7.0   7.0]
    86  [12 3] 'ANS-C12/AE/S3.1-QT       ' 0 'QT086'  [ -7.0   7.0]
    87  [12 4] 'ANS-C12/AE/S4-QT         ' 1 'QT087'  [ -7.0   7.0]
    88  [12 5] 'ANS-C12/AE/S3.2-QT       ' 0 'QT088'  [ -7.0   7.0]
    89  [12 6] 'ANS-C12/AE/S2-QT         ' 0 'QT089'  [ -7.0   7.0]
    90  [12 7] 'ANS-C12/AE/S1-QT         ' 1 'QT090'  [ -7.0   7.0]
    91  [13 8] 'ANS-C13/AE/S12.1-QT      ' 0 'QT121'  [ -7.0   7.0]
    92  [13 9] 'ANS-C13/AE/S12.2-QT      ' 0 'QT122'  [ -7.0   7.0]
    93  [13 1] 'ANS-C13/AE/S1-QT         ' 1 'QT091'  [ -7.0   7.0]
    94  [13 2] 'ANS-C13/AE/S2-QT         ' 0 'QT092'  [ -7.0   7.0]
    95  [13 3] 'ANS-C13/AE/S3.1-QT       ' 0 'QT093'  [ -7.0   7.0]
    96  [13 4] 'ANS-C13/AE/S4-QT         ' 1 'QT094'  [ -7.0   7.0]
    97  [13 5] 'ANS-C13/AE/S3.2-QT       ' 0 'QT095'  [ -7.0   7.0]
    98  [13 6] 'ANS-C13/AE/S5-QT         ' 0 'QT096'  [ -7.0   7.0]
    99  [13 7] 'ANS-C13/AE/S6-QT         ' 0 'QT097'  [ -7.0   7.0]
   100  [14 1] 'ANS-C14/AE/S8.1-QT       ' 0 'QT098'  [ -7.0   7.0]
   101  [14 2] 'ANS-C14/AE/S7.1-QT       ' 0 'QT099'  [ -7.0   7.0]
   102  [14 3] 'ANS-C14/AE/S9.1-QT       ' 0 'QT100'  [ -7.0   7.0]
   103  [14 4] 'ANS-C14/AE/S10.1-QT      ' 1 'QT101'  [ -7.0   7.0]
   104  [14 5] 'ANS-C14/AE/S10.2-QT      ' 0 'QT102'  [ -7.0   7.0]
   105  [14 6] 'ANS-C14/AE/S9.2-QT       ' 0 'QT103'  [ -7.0   7.0]
   106  [14 7] 'ANS-C14/AE/S7.2-QT       ' 0 'QT104'  [ -7.0   7.0]
   107  [14 8] 'ANS-C14/AE/S8.2-QT       ' 1 'QT105'  [ -7.0   7.0]
   108  [15 1] 'ANS-C15/AE/S8.1-QT       ' 1 'QT106'  [ -7.0   7.0]
   109  [15 2] 'ANS-C15/AE/S7.1-QT       ' 0 'QT107'  [ -7.0   7.0]
   110  [15 3] 'ANS-C15/AE/S9.1-QT       ' 0 'QT108'  [ -7.0   7.0]
   111  [15 4] 'ANS-C15/AE/S10.1-QT      ' 0 'QT109'  [ -7.0   7.0]
   112  [15 5] 'ANS-C15/AE/S10.2-QT      ' 1 'QT110'  [ -7.0   7.0]
   113  [15 6] 'ANS-C15/AE/S9.2-QT       ' 0 'QT111'  [ -7.0   7.0]
   114  [15 7] 'ANS-C15/AE/S7.2-QT       ' 0 'QT112'  [ -7.0   7.0]
   115  [15 8] 'ANS-C15/AE/S8.2-QT       ' 0 'QT113'  [ -7.0   7.0]
   116  [16 1] 'ANS-C16/AE/S6-QT         ' 0 'QT114'  [ -7.0   7.0]
   117  [16 2] 'ANS-C16/AE/S5-QT         ' 0 'QT115'  [ -7.0   7.0]
   118  [16 3] 'ANS-C16/AE/S3.1-QT       ' 0 'QT116'  [ -7.0   7.0]
   119  [16 4] 'ANS-C16/AE/S4-QT         ' 1 'QT117'  [ -7.0   7.0]
   120  [16 5] 'ANS-C16/AE/S3.2-QT       ' 0 'QT118'  [ -7.0   7.0]
   121  [16 6] 'ANS-C16/AE/S2-QT         ' 0 'QT119'  [ -7.0   7.0]
   122  [16 7] 'ANS-C16/AE/S1-QT         ' 1 'QT120'  [ -7.0   7.0]
    };

devnumber = length(varlist);
% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).Gain        = ones(devnumber,1);
AO.(ifam).Roll        = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);
AO.(ifam).Setpoint = AO.(ifam).Monitor;
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
AO.(ifam).Setpoint.TangoNames = cell(devnumber,1);
AO.(ifam).Setpoint.Range = zeros(devnumber,2);
AO.(ifam).Monitor.Handles(:,1)    = NaN*ones(devnumber,1);

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,5));
    AO.(ifam).Monitor.TangoNames{k}  = strcat(AO.(ifam).DeviceName{k}, '/currentPM');
    AO.(ifam).Setpoint.TangoNames{k} = strcat(AO.(ifam).DeviceName{k}, '/currentPM');
    AO.(ifam).Setpoint.Range(k,:)      = varlist{k,6};
    % information for getrunflag
    AO.(ifam).Setpoint.RunFlagFcn = @tangogetrunflag;
    AO.(ifam).Setpoint.RampRate = 1;
end
% Load coeeficients fot thin element
coefficients = magnetcoefficients(AO.(ifam).FamilyName);

for ii=1:devnumber,
    AO.(ifam).Monitor.HW2PhysicsParams{1}(ii,:)  = coefficients;
    AO.(ifam).Monitor.Physics2HWParams{1}(ii,:)  = coefficients;
    AO.(ifam).Setpoint.HW2PhysicsParams{1}(ii,:)  = coefficients;
    AO.(ifam).Setpoint.Physics2HWParams{1}(ii,:)  = coefficients;
end

AO.(ifam).Desired = AO.(ifam).Monitor;
AO.(ifam).Setpoint.MemberOf  = {'PlotFamily'};
AO.(ifam).Setpoint.TangoNames(:,:)    = strcat(AO.(ifam).DeviceName,'/currentPM');

AO.(ifam).Setpoint.Tolerance(:,:) = 1000*ones(devnumber,1);
AO.(ifam).Setpoint.DeltaRespMat(:,:) = 3*ones(devnumber,1);
AO.(ifam).Setpoint.DeltaSkewK = 1; % for SkewQuad efficiency toward dispersion .
% information for getrunflag
AO.(ifam).Setpoint.RunFlagFcn = @tangogetrunflag;
AO.(ifam).Setpoint.RampRate = 1;

AO.(ifam).Offset1 = AO.(ifam).Monitor;
AO.(ifam).Offset1.MemberOf  = {'PlotFamily'};
AO.(ifam).Offset1.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentOffset1');

% Profibus configuration
AO.(ifam).Profibus.BoardNumber = int32(0);
AO.(ifam).Profibus.Group       = int32(1);
AO.(ifam).Profibus.DeviceName  = 'ANS/AE/DP.QT';

% Group
if ControlRoomFlag
        AO.(ifam).GroupId = tango_group_create2(ifam);
        tango_group_add(AO.(ifam).GroupId,AO.(ifam).DeviceName(find(AO.(ifam).Status),:)');
else
    AO.(ifam).GroupId = nan;
end

%convert response matrix kicks to HWUnits (after AO is loaded to AppData)
setao(AO);   %required to make physics2hw function
AO.(ifam).Setpoint.DeltaRespMat = physics2hw(AO.(ifam).FamilyName, 'Setpoint', ...
    AO.(ifam).Setpoint.DeltaRespMat, AO.(ifam).DeviceList);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Skew Quadrupole data (virtual QT)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ifam = 'SQ';
AO.(ifam).FamilyName               = ifam;
AO.(ifam).FamilyType               = 'SkewQuad';
AO.(ifam).MemberOf                 = {'Magnet'; 'PlotFamily'; 'Archivable'};
%AO.(ifam).MemberOf                 = {'MachineConfig'; 'Magnet'; 'PlotFamily'; 'Archivable'};

AO.(ifam).Monitor.Mode             = Mode;
AO.(ifam).Monitor.DataType         = 'Scalar';
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'A';
AO.(ifam).Monitor.PhysicsUnits     = 'meter^-2';
AO.(ifam).Monitor.HW2PhysicsFcn = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn = @k2amp;

AO.(ifam).Setpoint = AO.(ifam).Monitor;

skewquadrupoles = {
    
1, 'ANS-C1/AE/QTvirtuel/1', 1,    [1 1],  'VirtualSkewQuad_1'
2, 'ANS-C1/AE/QTvirtuel/2', 1,    [1 2],  'VirtualSkewQuad_2'
3, 'ANS-C1/AE/QTvirtuel/3', 1,    [1 3],  'VirtualSkewQuad_3'
4, 'ANS-C1/AE/QTvirtuel/4', 1,    [1 4],  'VirtualSkewQuad_4'
5, 'ANS-C1/AE/QTvirtuel/5', 1,    [1 5],  'VirtualSkewQuad_5'
6, 'ANS-C1/AE/QTvirtuel/6', 1,    [1 6],  'VirtualSkewQuad_6'
7, 'ANS-C1/AE/QTvirtuel/7', 1,    [1 7],  'VirtualSkewQuad_7'


8, 'ANS-C2/AE/QTvirtuel/1', 1,    [2 1],  'VirtualSkewQuad_8'
9, 'ANS-C2/AE/QTvirtuel/2', 1,    [2 2],  'VirtualSkewQuad_9'
10, 'ANS-C2/AE/QTvirtuel/3', 1,    [2 3],  'VirtualSkewQuad_10'
11, 'ANS-C2/AE/QTvirtuel/4', 1,    [2 4],  'VirtualSkewQuad_11'
12, 'ANS-C2/AE/QTvirtuel/5', 1,    [2 5],  'VirtualSkewQuad_12'
13, 'ANS-C2/AE/QTvirtuel/6', 1,    [2 6],  'VirtualSkewQuad_13'
14, 'ANS-C2/AE/QTvirtuel/7', 1,    [2 7],  'VirtualSkewQuad_14'
15, 'ANS-C2/AE/QTvirtuel/8', 1,    [2 8],  'VirtualSkewQuad_15'
16, 'ANS-C2/AE/QTvirtuel/9', 1,    [2 9],  'VirtualSkewQuad_16'
17, 'ANS-C2/AE/QTvirtuel/10', 1,    [2 10],  'VirtualSkewQuad_17'



18, 'ANS-C3/AE/QTvirtuel/1', 1,    [3 1],  'VirtualSkewQuad_18'
19, 'ANS-C3/AE/QTvirtuel/2', 1,    [3 2],  'VirtualSkewQuad_19'
20, 'ANS-C3/AE/QTvirtuel/3', 1,    [3 3],  'VirtualSkewQuad_20'
21, 'ANS-C3/AE/QTvirtuel/4', 1,    [3 4],  'VirtualSkewQuad_21'
22, 'ANS-C3/AE/QTvirtuel/5', 1,    [3 5],  'VirtualSkewQuad_22'
23, 'ANS-C3/AE/QTvirtuel/6', 1,    [3 6],  'VirtualSkewQuad_23'
24, 'ANS-C3/AE/QTvirtuel/7', 1,    [3 7],  'VirtualSkewQuad_24'
25, 'ANS-C3/AE/QTvirtuel/8', 1,    [3 8],  'VirtualSkewQuad_25'
26, 'ANS-C3/AE/QTvirtuel/9', 1,    [3 9],  'VirtualSkewQuad_26'
27, 'ANS-C3/AE/QTvirtuel/10', 1,    [3 10],  'VirtualSkewQuad_27'


28, 'ANS-C4/AE/QTvirtuel/1', 1,    [4 1],  'VirtualSkewQuad_28'
29, 'ANS-C4/AE/QTvirtuel/2', 1,    [4 2],  'VirtualSkewQuad_29'
30, 'ANS-C4/AE/QTvirtuel/3', 1,    [4 3],  'VirtualSkewQuad_30'
31, 'ANS-C4/AE/QTvirtuel/4', 1,    [4 4],  'VirtualSkewQuad_31'
32, 'ANS-C4/AE/QTvirtuel/5', 1,    [4 5],  'VirtualSkewQuad_32'
33, 'ANS-C4/AE/QTvirtuel/6', 1,    [4 6],  'VirtualSkewQuad_33'
34, 'ANS-C4/AE/QTvirtuel/7', 1,    [4 7],  'VirtualSkewQuad_34'
35, 'ANS-C4/AE/QTvirtuel/8', 1,    [4 8],  'VirtualSkewQuad_35'


36, 'ANS-C5/AE/QTvirtuel/1', 1,    [5 1],  'VirtualSkewQuad_36'
37, 'ANS-C5/AE/QTvirtuel/2', 1,    [5 2],  'VirtualSkewQuad_37'
38, 'ANS-C5/AE/QTvirtuel/3', 1,    [5 3],  'VirtualSkewQuad_38'
39, 'ANS-C5/AE/QTvirtuel/4', 1,    [5 4],  'VirtualSkewQuad_39'
40, 'ANS-C5/AE/QTvirtuel/5', 1,    [5 5],  'VirtualSkewQuad_40'
41, 'ANS-C5/AE/QTvirtuel/6', 1,    [5 6],  'VirtualSkewQuad_41'
42, 'ANS-C5/AE/QTvirtuel/7', 1,    [5 7],  'VirtualSkewQuad_42'
43, 'ANS-C5/AE/QTvirtuel/8', 1,    [5 8],  'VirtualSkewQuad_43'
44, 'ANS-C5/AE/QTvirtuel/9', 1,    [5 9],  'VirtualSkewQuad_44'
45, 'ANS-C5/AE/QTvirtuel/10', 1,    [5 10],  'VirtualSkewQuad_45'


46, 'ANS-C6/AE/QTvirtuel/1', 1,    [6 1],  'VirtualSkewQuad_46'
47, 'ANS-C6/AE/QTvirtuel/2', 1,    [6 2],  'VirtualSkewQuad_47'
48, 'ANS-C6/AE/QTvirtuel/3', 1,    [6 3],  'VirtualSkewQuad_48'
49, 'ANS-C6/AE/QTvirtuel/4', 1,    [6 4],  'VirtualSkewQuad_49'
50, 'ANS-C6/AE/QTvirtuel/5', 1,    [6 5],  'VirtualSkewQuad_50'
51, 'ANS-C6/AE/QTvirtuel/6', 1,    [6 6],  'VirtualSkewQuad_51'
52, 'ANS-C6/AE/QTvirtuel/7', 1,    [6 7],  'VirtualSkewQuad_52'
53, 'ANS-C6/AE/QTvirtuel/8', 1,    [6 8],  'VirtualSkewQuad_53'
54, 'ANS-C6/AE/QTvirtuel/9', 1,    [6 9],  'VirtualSkewQuad_54'
55, 'ANS-C6/AE/QTvirtuel/10', 1,    [6 10],  'VirtualSkewQuad_55'


56, 'ANS-C7/AE/QTvirtuel/1', 1,    [7 1],  'VirtualSkewQuad_56'
57, 'ANS-C7/AE/QTvirtuel/2', 1,    [7 2],  'VirtualSkewQuad_57'
58, 'ANS-C7/AE/QTvirtuel/3', 1,    [7 3],  'VirtualSkewQuad_58'
59, 'ANS-C7/AE/QTvirtuel/4', 1,    [7 4],  'VirtualSkewQuad_59'
60, 'ANS-C7/AE/QTvirtuel/5', 1,    [7 5],  'VirtualSkewQuad_60'
61, 'ANS-C7/AE/QTvirtuel/6', 1,    [7 6],  'VirtualSkewQuad_61'
62, 'ANS-C7/AE/QTvirtuel/7', 1,    [7 7],  'VirtualSkewQuad_62'
63, 'ANS-C7/AE/QTvirtuel/8', 1,    [7 8],  'VirtualSkewQuad_63'
64, 'ANS-C7/AE/QTvirtuel/9', 1,    [7 9],  'VirtualSkewQuad_64'
65, 'ANS-C7/AE/QTvirtuel/10', 1,    [7 10],  'VirtualSkewQuad_65'


66, 'ANS-C8/AE/QTvirtuel/1', 1,    [8 1],  'VirtualSkewQuad_66'
67, 'ANS-C8/AE/QTvirtuel/2', 1,    [8 2],  'VirtualSkewQuad_67'
68, 'ANS-C8/AE/QTvirtuel/3', 1,    [8 3],  'VirtualSkewQuad_68'
69, 'ANS-C8/AE/QTvirtuel/4', 1,    [8 4],  'VirtualSkewQuad_69'
70, 'ANS-C8/AE/QTvirtuel/5', 1,    [8 5],  'VirtualSkewQuad_70'
71, 'ANS-C8/AE/QTvirtuel/6', 1,    [8 6],  'VirtualSkewQuad_71'
72, 'ANS-C8/AE/QTvirtuel/7', 1,    [8 7],  'VirtualSkewQuad_72'
73, 'ANS-C8/AE/QTvirtuel/8', 1,    [8 8],  'VirtualSkewQuad_73'


74, 'ANS-C9/AE/QTvirtuel/1', 1,    [9 1],  'VirtualSkewQuad_74'
75, 'ANS-C9/AE/QTvirtuel/2', 1,    [9 2],  'VirtualSkewQuad_75'
76, 'ANS-C9/AE/QTvirtuel/3', 1,    [9 3],  'VirtualSkewQuad_76'
77, 'ANS-C9/AE/QTvirtuel/4', 1,    [9 4],  'VirtualSkewQuad_77'
78, 'ANS-C9/AE/QTvirtuel/5', 1,    [9 5],  'VirtualSkewQuad_78'
79, 'ANS-C9/AE/QTvirtuel/6', 1,    [9 6],  'VirtualSkewQuad_79'
80, 'ANS-C9/AE/QTvirtuel/7', 1,    [9 7],  'VirtualSkewQuad_80'



81, 'ANS-C10/AE/QTvirtuel/1', 1,    [10 1],  'VirtualSkewQuad_81'
82, 'ANS-C10/AE/QTvirtuel/2', 1,    [10 2],  'VirtualSkewQuad_82'
83, 'ANS-C10/AE/QTvirtuel/3', 1,    [10 3],  'VirtualSkewQuad_83'
84, 'ANS-C10/AE/QTvirtuel/4', 1,    [10 4],  'VirtualSkewQuad_84'
85, 'ANS-C10/AE/QTvirtuel/5', 1,    [10 5],  'VirtualSkewQuad_85'
86, 'ANS-C10/AE/QTvirtuel/6', 1,    [10 6],  'VirtualSkewQuad_86'
87, 'ANS-C10/AE/QTvirtuel/7', 1,    [10 7],  'VirtualSkewQuad_87'
88, 'ANS-C10/AE/QTvirtuel/8', 1,    [10 8],  'VirtualSkewQuad_88'
89, 'ANS-C10/AE/QTvirtuel/9', 1,    [10 9],  'VirtualSkewQuad_89'
90, 'ANS-C10/AE/QTvirtuel/10', 1,    [10 10],  'VirtualSkewQuad_90'


91, 'ANS-C11/AE/QTvirtuel/1', 1,    [11 1],  'VirtualSkewQuad_91'
92, 'ANS-C11/AE/QTvirtuel/2', 1,    [11 2],  'VirtualSkewQuad_92'
93, 'ANS-C11/AE/QTvirtuel/3', 1,    [11 3],  'VirtualSkewQuad_93'
94, 'ANS-C11/AE/QTvirtuel/4', 1,    [11 4],  'VirtualSkewQuad_94'
95, 'ANS-C11/AE/QTvirtuel/5', 1,    [11 5],  'VirtualSkewQuad_95'
96, 'ANS-C11/AE/QTvirtuel/6', 1,    [11 6],  'VirtualSkewQuad_96'
97, 'ANS-C11/AE/QTvirtuel/7', 1,    [11 7],  'VirtualSkewQuad_97'
98, 'ANS-C11/AE/QTvirtuel/8', 1,    [11 8],  'VirtualSkewQuad_98'
99, 'ANS-C11/AE/QTvirtuel/9', 1,    [11 9],  'VirtualSkewQuad_99'
100, 'ANS-C11/AE/QTvirtuel/10', 1,    [11 10],  'VirtualSkewQuad_100'


101, 'ANS-C12/AE/QTvirtuel/1', 1,    [12 1],  'VirtualSkewQuad_101'
102, 'ANS-C12/AE/QTvirtuel/2', 1,    [12 2],  'VirtualSkewQuad_102'
103, 'ANS-C12/AE/QTvirtuel/3', 1,    [12 3],  'VirtualSkewQuad_103'
104, 'ANS-C12/AE/QTvirtuel/4', 1,    [12 4],  'VirtualSkewQuad_104'
105, 'ANS-C12/AE/QTvirtuel/5', 1,    [12 5],  'VirtualSkewQuad_105'
106, 'ANS-C12/AE/QTvirtuel/6', 1,    [12 6],  'VirtualSkewQuad_106'
107, 'ANS-C12/AE/QTvirtuel/7', 1,    [12 7],  'VirtualSkewQuad_107'
108, 'ANS-C12/AE/QTvirtuel/8', 1,    [12 8],  'VirtualSkewQuad_108'

109, 'ANS-C13/AE/QTvirtuel/1', 1,    [13 1],  'VirtualSkewQuad_109'
110, 'ANS-C13/AE/QTvirtuel/2', 1,    [13 2],  'VirtualSkewQuad_110'
111, 'ANS-C13/AE/QTvirtuel/3', 1,    [13 3],  'VirtualSkewQuad_111'
112, 'ANS-C13/AE/QTvirtuel/4', 1,    [13 4],  'VirtualSkewQuad_112'
113, 'ANS-C13/AE/QTvirtuel/5', 1,    [13 5],  'VirtualSkewQuad_113'
114, 'ANS-C13/AE/QTvirtuel/6', 1,    [13 6],  'VirtualSkewQuad_114'
115, 'ANS-C13/AE/QTvirtuel/7', 1,    [13 7],  'VirtualSkewQuad_115'
116, 'ANS-C13/AE/QTvirtuel/8', 1,    [13 8],  'VirtualSkewQuad_116'
117, 'ANS-C13/AE/QTvirtuel/9', 1,    [13 9],  'VirtualSkewQuad_117'
118, 'ANS-C13/AE/QTvirtuel/10', 1,    [13 10],  'VirtualSkewQuad_118'
119, 'ANS-C13/AE/QTvirtuel/10', 1,    [13 11],  'VirtualSkewQuad_119'

120, 'ANS-C14/AE/QTvirtuel/1', 1,    [14 1],  'VirtualSkewQuad_120'
121, 'ANS-C14/AE/QTvirtuel/2', 1,    [14 2],  'VirtualSkewQuad_121'
122, 'ANS-C14/AE/QTvirtuel/3', 1,    [14 3],  'VirtualSkewQuad_122'
123, 'ANS-C14/AE/QTvirtuel/4', 1,    [14 4],  'VirtualSkewQuad_123'
124, 'ANS-C14/AE/QTvirtuel/5', 1,    [14 5],  'VirtualSkewQuad_124'
125, 'ANS-C14/AE/QTvirtuel/6', 1,    [14 6],  'VirtualSkewQuad_125'
126, 'ANS-C14/AE/QTvirtuel/7', 1,    [14 7],  'VirtualSkewQuad_126'
127, 'ANS-C14/AE/QTvirtuel/8', 1,    [14 8],  'VirtualSkewQuad_127'
128, 'ANS-C14/AE/QTvirtuel/9', 1,    [14 9],  'VirtualSkewQuad_128'
129, 'ANS-C14/AE/QTvirtuel/10', 1,    [14 10],  'VirtualSkewQuad_129'


130, 'ANS-C15/AE/QTvirtuel/1', 1,    [15 1],  'VirtualSkewQuad_130'
131, 'ANS-C15/AE/QTvirtuel/2', 1,    [15 2],  'VirtualSkewQuad_131'
132, 'ANS-C15/AE/QTvirtuel/3', 1,    [15 3],  'VirtualSkewQuad_132'
133, 'ANS-C15/AE/QTvirtuel/4', 1,    [15 4],  'VirtualSkewQuad_133'
134, 'ANS-C15/AE/QTvirtuel/5', 1,    [15 5],  'VirtualSkewQuad_134'
135, 'ANS-C15/AE/QTvirtuel/6', 1,    [15 6],  'VirtualSkewQuad_135'
136, 'ANS-C15/AE/QTvirtuel/7', 1,    [15 7],  'VirtualSkewQuad_136'
137, 'ANS-C15/AE/QTvirtuel/8', 1,    [15 8],  'VirtualSkewQuad_137'
138, 'ANS-C15/AE/QTvirtuel/9', 1,    [15 9],  'VirtualSkewQuad_138'
139, 'ANS-C15/AE/QTvirtuel/10', 1,    [15 10],  'VirtualSkewQuad_139'


140, 'ANS-C16/AE/QTvirtuel/1', 1,    [16 1],  'VirtualSkewQuad_140'
141, 'ANS-C16/AE/QTvirtuel/2', 1,    [16 2],  'VirtualSkewQuad_141'
142, 'ANS-C16/AE/QTvirtuel/3', 1,    [16 3],  'VirtualSkewQuad_142'
143, 'ANS-C16/AE/QTvirtuel/4', 1,    [16 4],  'VirtualSkewQuad_143'
144, 'ANS-C16/AE/QTvirtuel/5', 1,    [16 5],  'VirtualSkewQuad_144'
145, 'ANS-C16/AE/QTvirtuel/6', 1,    [16 6],  'VirtualSkewQuad_145'
146, 'ANS-C16/AE/QTvirtuel/7', 1,    [16 7],  'VirtualSkewQuad_146'
147, 'ANS-C16/AE/QTvirtuel/8', 1,    [16 8],  'VirtualSkewQuad_147'
};

% Load coeeficients fot thin element
coefficients = magnetcoefficients(AO.(ifam).FamilyName);
%[C, Leff, MagnetType, coefficients] = magnetcoefficients(AO.(ifam).FamilyName);
for ii = 1:size(skewquadrupoles,1)
    AO.(ifam).ElementList(ii,:)            = skewquadrupoles{ii,1};
    AO.(ifam).DeviceName(ii,:)            = skewquadrupoles(ii,2);
    AO.(ifam).Monitor.TangoNames(ii,:)    = strcat(skewquadrupoles(ii,2),'/current');
    AO.(ifam).Setpoint.TangoNames(ii,:)    = strcat(skewquadrupoles(ii,2),'/currentPM');
    AO.(ifam).Status(ii,:)            = skewquadrupoles{ii,3};
    AO.(ifam).DeviceList(ii,:)            = skewquadrupoles{ii,4};
    AO.(ifam).CommonName(ii,:)            = skewquadrupoles(ii,5);
    AO.(ifam).Monitor.HW2PhysicsParams{1}(ii,:)  = coefficients;
    AO.(ifam).Monitor.Physics2HWParams{1}(ii,:)  = coefficients;
    AO.(ifam).Setpoint.HW2PhysicsParams{1}(ii,:)  = coefficients;
    AO.(ifam).Setpoint.Physics2HWParams{1}(ii,:)  = coefficients;
    AO.(ifam).Setpoint.Range(ii,:) = repmat([-7 7],1,1); % 7 A for
    AO.(ifam).Monitor.Range(ii,:) = repmat([-7 7],1,1);
    AO.(ifam).Setpoint.Tolerance(ii,:) = 1000;
    AO.(ifam).Setpoint.DeltaRespMat(ii,:) = 3*ones(1,1);
    AO.(ifam).Monitor.Handles(ii,1)    = NaN*ones(1,1);
    AO.(ifam).Setpoint.Handles(ii,1)    = NaN*ones(1,1);
    
end
AO.(ifam).Status = AO.(ifam).Status(:);

%convert response matrix kicks to HWUnits (after AO is loaded to AppData)
setao(AO);   %required to make physics2hw function
AO.(ifam).Setpoint.DeltaRespMat = physics2hw(AO.(ifam).FamilyName, 'Setpoint', ...
    AO.(ifam).Setpoint.DeltaRespMat, AO.(ifam).DeviceList);
AO.(ifam).Setpoint.DeltaSkewK = 1; % for efficiency measurement.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FAST HORIZONTAL CORRECTORS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ifam = 'FHCOR';
AO.(ifam).FamilyName               = ifam;
AO.(ifam).FamilyType               = 'FCOR';
AO.(ifam).MemberOf                 = {'COR'; 'FCOR'; 'Magnet'; 'PlotFamily'; 'Archivable'};

AO.(ifam).Monitor.Mode              = Mode;
AO.(ifam).Monitor.DataType          = 'Scalar';
AO.(ifam).Monitor.Units             = 'Hardware';
AO.(ifam).Monitor.HWUnits           = 'A';
AO.(ifam).Monitor.PhysicsUnits      = 'rad';
AO.(ifam).Monitor.HW2PhysicsFcn     = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn     = @k2amp;

AO.(ifam).Setpoint.Mode             = Mode;
AO.(ifam).Setpoint.DataType         = 'Scalar';
AO.(ifam).Setpoint.Units            = 'Hardware';
AO.(ifam).Setpoint.HWUnits          = 'A';
AO.(ifam).Setpoint.PhysicsUnits     = 'rad';
AO.(ifam).Setpoint.HW2PhysicsFcn    = @amp2k;
AO.(ifam).Setpoint.Physics2HWFcn    = @k2amp;

AO.(ifam).SetpointMean.Mode         = Mode;
AO.(ifam).SetpointMean.DataType         = 'Scalar';
AO.(ifam).SetpointMean.Units            = 'Hardware';
AO.(ifam).SetpointMean.HWUnits          = 'A';
AO.(ifam).SetpointMean.PhysicsUnits     = 'rad';
AO.(ifam).SetpointMean.HW2PhysicsFcn    = @amp2k;
AO.(ifam).SetpointMean.Physics2HWFcn    = @k2amp;

varlist = {
     1  [ 1 2] 'ANS-C01/DG/CH.2          ' 1 'FHCOR02' 'current   ' 'current   ' [-10  10]
     2  [ 2 1] 'ANS-C02/DG/CH.1          ' 1 'FHCOR03' 'current   ' 'current   ' [-10  10]
     3  [ 2 2] 'ANS-C02/DG/CH.2          ' 1 'FHCOR04' 'current   ' 'current   ' [-10  10]
     4  [ 2 3] 'ANS-C02/DG/CH.3          ' 1 'FHCOR05' 'current   ' 'current   ' [-10  10]
     5  [ 2 4] 'ANS-C02/DG/CH.4          ' 1 'FHCOR06' 'current   ' 'current   ' [-10  10]
     6  [ 3 1] 'ANS-C03/DG/CH.1          ' 1 'FHCOR07' 'current   ' 'current   ' [-10  10]
     7  [ 3 2] 'ANS-C03/DG/CH.2          ' 1 'FHCOR08' 'current   ' 'current   ' [-10  10]
     8  [ 3 3] 'ANS-C03/DG/CH.3          ' 1 'FHCOR09' 'current   ' 'current   ' [-10  10]
     9  [ 3 4] 'ANS-C03/DG/CH.4          ' 1 'FHCOR10' 'current   ' 'current   ' [-10  10]
    10  [ 4 1] 'ANS-C04/DG/CH.1          ' 1 'FHCOR11' 'current   ' 'current   ' [-10  10]
    11  [ 4 2] 'ANS-C04/DG/CH.2          ' 1 'FHCOR12' 'current   ' 'current   ' [-10  10]
    12  [ 5 1] 'ANS-C05/DG/CH.1          ' 1 'FHCOR13' 'current   ' 'current   ' [-10  10]
    13  [ 5 2] 'ANS-C05/DG/CH.2          ' 1 'FHCOR14' 'current   ' 'current   ' [-10  10]
    14  [ 6 1] 'ANS-C06/DG/CH.1          ' 1 'FHCOR15' 'current   ' 'current   ' [-10  10]
    15  [ 6 2] 'ANS-C06/DG/CH.2          ' 1 'FHCOR16' 'current   ' 'current   ' [-10  10]
    16  [ 6 3] 'ANS-C06/DG/CH.3          ' 1 'FHCOR17' 'current   ' 'current   ' [-10  10]
    17  [ 6 4] 'ANS-C06/DG/CH.4          ' 1 'FHCOR18' 'current   ' 'current   ' [-10  10]
    18  [ 7 1] 'ANS-C07/DG/CH.1          ' 1 'FHCOR19' 'current   ' 'current   ' [-10  10]
    19  [ 7 2] 'ANS-C07/DG/CH.2          ' 1 'FHCOR20' 'current   ' 'current   ' [-10  10]
    20  [ 7 3] 'ANS-C07/DG/CH.3          ' 1 'FHCOR21' 'current   ' 'current   ' [-10  10]
    21  [ 7 4] 'ANS-C07/DG/CH.4          ' 1 'FHCOR22' 'current   ' 'current   ' [-10  10]
    22  [ 8 1] 'ANS-C08/DG/CH.1          ' 1 'FHCOR23' 'current   ' 'current   ' [-10  10]
    23  [ 8 2] 'ANS-C08/DG/CH.2          ' 1 'FHCOR24' 'current   ' 'current   ' [-10  10]
    24  [ 9 1] 'ANS-C09/DG/CH.1          ' 1 'FHCOR25' 'current   ' 'current   ' [-10  10]
    25  [ 9 2] 'ANS-C09/DG/CH.2          ' 1 'FHCOR26' 'current   ' 'current   ' [-10  10]
    26  [10 1] 'ANS-C10/DG/CH.1          ' 1 'FHCOR27' 'current   ' 'current   ' [-10  10]
    27  [10 2] 'ANS-C10/DG/CH.2          ' 1 'FHCOR28' 'current   ' 'current   ' [-10  10]
    28  [10 3] 'ANS-C10/DG/CH.3          ' 1 'FHCOR29' 'current   ' 'current   ' [-10  10]
    29  [10 4] 'ANS-C10/DG/CH.4          ' 1 'FHCOR30' 'current   ' 'current   ' [-10  10]
    30  [11 1] 'ANS-C11/DG/CH.1          ' 1 'FHCOR31' 'current   ' 'current   ' [-10  10]
    31  [11 2] 'ANS-C11/DG/CH.2          ' 1 'FHCOR32' 'current   ' 'current   ' [-10  10]
    32  [11 3] 'ANS-C11/DG/CH.3          ' 1 'FHCOR33' 'current   ' 'current   ' [-10  10]
    33  [11 4] 'ANS-C11/DG/CH.4          ' 1 'FHCOR34' 'current   ' 'current   ' [-10  10]
    34  [12 1] 'ANS-C12/DG/CH.1          ' 1 'FHCOR35' 'current   ' 'current   ' [-10  10]
    35  [12 2] 'ANS-C12/DG/CH.2          ' 1 'FHCOR36' 'current   ' 'current   ' [-10  10]
    36  [13 1] 'ANS-C13/DG/CH.1          ' 1 'FHCOR37' 'current   ' 'current   ' [-10  10]
    37  [13 3] 'ANS-C13/DG/CH.3          ' 1 'FHCOR49' 'current   ' 'current   ' [-10  10]
    38  [13 4] 'ANS-C13/DG/CH.4          ' 1 'FHCOR50' 'current   ' 'current   ' [-10  10]
    39  [13 2] 'ANS-C13/DG/CH.2          ' 1 'FHCOR38' 'current   ' 'current   ' [-10  10]
    40  [14 1] 'ANS-C14/DG/CH.1          ' 1 'FHCOR39' 'current   ' 'current   ' [-10  10]
    41  [14 2] 'ANS-C14/DG/CH.2          ' 1 'FHCOR40' 'current   ' 'current   ' [-10  10]
    42  [14 3] 'ANS-C14/DG/CH.3          ' 1 'FHCOR41' 'current   ' 'current   ' [-10  10]
    43  [14 4] 'ANS-C14/DG/CH.4          ' 1 'FHCOR42' 'current   ' 'current   ' [-10  10]
    44  [15 1] 'ANS-C15/DG/CH.1          ' 1 'FHCOR43' 'current   ' 'current   ' [-10  10]
    45  [15 2] 'ANS-C15/DG/CH.2          ' 1 'FHCOR44' 'current   ' 'current   ' [-10  10]
    46  [15 3] 'ANS-C15/DG/CH.3          ' 1 'FHCOR45' 'current   ' 'current   ' [-10  10]
    47  [15 4] 'ANS-C15/DG/CH.4          ' 1 'FHCOR46' 'current   ' 'current   ' [-10  10]
    48  [16 1] 'ANS-C16/DG/CH.1          ' 1 'FHCOR47' 'current   ' 'current   ' [-10  10]
    49  [16 2] 'ANS-C16/DG/CH.2          ' 1 'FHCOR48' 'current   ' 'current   ' [-10  10]
    50  [ 1 1] 'ANS-C01/DG/CH.1          ' 1 'FHCOR01' 'current   ' 'current   ' [-10  10]
    };

devnumber = length(varlist);
% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).Gain        = ones(devnumber,1);
AO.(ifam).Roll        = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
AO.(ifam).Setpoint.TangoNames = cell(devnumber,1);
AO.(ifam).Setpoint.Range = zeros(devnumber,2);
AO.(ifam).SetpointMean.TangoNames = cell(devnumber,1);
AO.(ifam).SetpointMean.Range = zeros(devnumber,2);

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,5));
    AO.(ifam).Monitor.TangoNames(k)  = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,6)));
    AO.(ifam).Setpoint.TangoNames(k) = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,7)));
    AO.(ifam).Setpoint.Range(k,:)      = varlist{k,8};
    AO.(ifam).SetpointMean.TangoNames(k) = strcat(AO.(ifam).DeviceName{k}, {'/spMean'});
    AO.(ifam).SetpointMean.Range(k,:)   = varlist{k,8};
end

%Load fields from datablock
% AT use the "A-coefficients" for correctors plus an offset
[C, Leff, MagnetType, coefficients] = magnetcoefficients(AO.(ifam).FamilyName);

for ii = 1:devnumber,
    AO.(ifam).Monitor.HW2PhysicsParams{1}(ii,:)   = coefficients;
    AO.(ifam).Monitor.Physics2HWParams{1}(ii,:)   = coefficients;
    AO.(ifam).Setpoint.HW2PhysicsParams{1}(ii,:)  = coefficients;
    AO.(ifam).Setpoint.Physics2HWParams{1}(ii,:)  = coefficients;
end


AO.(ifam).Monitor.MemberOf      = {'PlotFamily'};
AO.(ifam).Setpoint.MemberOf     = {'PlotFamily'};
AO.(ifam).Setpoint.Tolerance(:,:)    = 1e-1*ones(devnumber,1);
%AO.(ifam).Setpoint.DeltaRespMat(:,:) = 24e-6*ones(devnumber,1); % 2*12 �urad for 0.2 mm
AO.(ifam).Setpoint.DeltaRespMat(:,:) = 2*3e-6*ones(devnumber,1); % 2*3 urad for 0.05 mm

%convert response matrix kicks to HWUnits (after AO is loaded to AppData)
setao(AO);   %required to make physics2hw function
AO.(ifam).Setpoint.DeltaRespMat = physics2hw(AO.(ifam).FamilyName,'Setpoint', ...
    AO.(ifam).Setpoint.DeltaRespMat, AO.(ifam).DeviceList);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FAST VERTICAL CORRECTORS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ifam = 'FVCOR';
AO.(ifam).FamilyName               = ifam;
AO.(ifam).FamilyType               = 'FCOR';
AO.(ifam).MemberOf                 = {'COR'; 'FCOR'; 'Magnet'; 'PlotFamily'; 'Archivable'};

AO.(ifam).Monitor.Mode              = Mode;
AO.(ifam).Monitor.DataType          = 'Scalar';
AO.(ifam).Monitor.Units             = 'Hardware';
AO.(ifam).Monitor.HWUnits           = 'A';
AO.(ifam).Monitor.PhysicsUnits      = 'rad';
AO.(ifam).Monitor.HW2PhysicsFcn     = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn     = @k2amp;

AO.(ifam).Setpoint.Mode             = Mode;
AO.(ifam).Setpoint.DataType         = 'Scalar';
AO.(ifam).Setpoint.Units            = 'Hardware';
AO.(ifam).Setpoint.HWUnits          = 'A';
AO.(ifam).Setpoint.PhysicsUnits     = 'rad';
AO.(ifam).Setpoint.HW2PhysicsFcn    = @amp2k;
AO.(ifam).Setpoint.Physics2HWFcn    = @k2amp;

AO.(ifam).SetpointMean.Mode         = Mode;
AO.(ifam).SetpointMean.DataType         = 'Scalar';
AO.(ifam).SetpointMean.Units            = 'Hardware';
AO.(ifam).SetpointMean.HWUnits          = 'A';
AO.(ifam).SetpointMean.PhysicsUnits     = 'rad';
AO.(ifam).SetpointMean.HW2PhysicsFcn    = @amp2k;
AO.(ifam).SetpointMean.Physics2HWFcn    = @k2amp;


% devliste tangoname status common attR attW range
varlist = {
     1  [ 1 2] 'ANS-C01/DG/CV.2          ' 1 'FVCOR01' 'current   ' 'current   ' [-10  10]
     2  [ 2 1] 'ANS-C02/DG/CV.1          ' 1 'FVCOR02' 'current   ' 'current   ' [-10  10]
     3  [ 2 2] 'ANS-C02/DG/CV.2          ' 1 'FVCOR03' 'current   ' 'current   ' [-10  10]
     4  [ 2 3] 'ANS-C02/DG/CV.3          ' 1 'FVCOR04' 'current   ' 'current   ' [-10  10]
     5  [ 2 4] 'ANS-C02/DG/CV.4          ' 1 'FVCOR05' 'current   ' 'current   ' [-10  10]
     6  [ 3 1] 'ANS-C03/DG/CV.1          ' 1 'FVCOR06' 'current   ' 'current   ' [-10  10]
     7  [ 3 2] 'ANS-C03/DG/CV.2          ' 1 'FVCOR07' 'current   ' 'current   ' [-10  10]
     8  [ 3 3] 'ANS-C03/DG/CV.3          ' 1 'FVCOR08' 'current   ' 'current   ' [-10  10]
     9  [ 3 4] 'ANS-C03/DG/CV.4          ' 1 'FVCOR09' 'current   ' 'current   ' [-10  10]
    10  [ 4 1] 'ANS-C04/DG/CV.1          ' 1 'FVCOR10' 'current   ' 'current   ' [-10  10]
    11  [ 4 2] 'ANS-C04/DG/CV.2          ' 1 'FVCOR11' 'current   ' 'current   ' [-10  10]
    12  [ 5 1] 'ANS-C05/DG/CV.1          ' 1 'FVCOR12' 'current   ' 'current   ' [-10  10]
    13  [ 5 2] 'ANS-C05/DG/CV.2          ' 1 'FVCOR13' 'current   ' 'current   ' [-10  10]
    14  [ 6 1] 'ANS-C06/DG/CV.1          ' 1 'FVCOR14' 'current   ' 'current   ' [-10  10]
    15  [ 6 2] 'ANS-C06/DG/CV.2          ' 1 'FVCOR15' 'current   ' 'current   ' [-10  10]
    16  [ 6 3] 'ANS-C06/DG/CV.3          ' 1 'FVCOR16' 'current   ' 'current   ' [-10  10]
    17  [ 6 4] 'ANS-C06/DG/CV.4          ' 1 'FVCOR17' 'current   ' 'current   ' [-10  10]
    18  [ 7 1] 'ANS-C07/DG/CV.1          ' 1 'FVCOR18' 'current   ' 'current   ' [-10  10]
    19  [ 7 2] 'ANS-C07/DG/CV.2          ' 1 'FVCOR19' 'current   ' 'current   ' [-10  10]
    20  [ 7 3] 'ANS-C07/DG/CV.3          ' 1 'FVCOR20' 'current   ' 'current   ' [-10  10]
    21  [ 7 4] 'ANS-C07/DG/CV.4          ' 1 'FVCOR21' 'current   ' 'current   ' [-10  10]
    22  [ 8 1] 'ANS-C08/DG/CV.1          ' 1 'FVCOR22' 'current   ' 'current   ' [-10  10]
    23  [ 8 2] 'ANS-C08/DG/CV.2          ' 1 'FVCOR23' 'current   ' 'current   ' [-10  10]
    24  [ 9 1] 'ANS-C09/DG/CV.1          ' 1 'FVCOR24' 'current   ' 'current   ' [-10  10]
    25  [ 9 2] 'ANS-C09/DG/CV.2          ' 1 'FVCOR25' 'current   ' 'current   ' [-10  10]
    26  [10 1] 'ANS-C10/DG/CV.1          ' 1 'FVCOR26' 'current   ' 'current   ' [-10  10]
    27  [10 2] 'ANS-C10/DG/CV.2          ' 1 'FVCOR27' 'current   ' 'current   ' [-10  10]
    28  [10 3] 'ANS-C10/DG/CV.3          ' 1 'FVCOR28' 'current   ' 'current   ' [-10  10]
    29  [10 4] 'ANS-C10/DG/CV.4          ' 1 'FVCOR29' 'current   ' 'current   ' [-10  10]
    30  [11 1] 'ANS-C11/DG/CV.1          ' 1 'FVCOR30' 'current   ' 'current   ' [-10  10]
    31  [11 2] 'ANS-C11/DG/CV.2          ' 1 'FVCOR31' 'current   ' 'current   ' [-10  10]
    32  [11 3] 'ANS-C11/DG/CV.3          ' 1 'FVCOR32' 'current   ' 'current   ' [-10  10]
    33  [11 4] 'ANS-C11/DG/CV.4          ' 1 'FVCOR33' 'current   ' 'current   ' [-10  10]
    34  [12 1] 'ANS-C12/DG/CV.1          ' 1 'FVCOR34' 'current   ' 'current   ' [-10  10]
    35  [12 2] 'ANS-C12/DG/CV.2          ' 1 'FVCOR35' 'current   ' 'current   ' [-10  10]
    36  [13 1] 'ANS-C13/DG/CV.1          ' 1 'FVCOR36' 'current   ' 'current   ' [-10  10]
    37  [13 3] 'ANS-C13/DG/CV.3          ' 1 'FVCOR49' 'current   ' 'current   ' [-10  10]
    38  [13 4] 'ANS-C13/DG/CV.4          ' 1 'FVCOR50' 'current   ' 'current   ' [-10  10]
    39  [13 2] 'ANS-C13/DG/CV.2          ' 1 'FVCOR37' 'current   ' 'current   ' [-10  10]
    40  [14 1] 'ANS-C14/DG/CV.1          ' 1 'FVCOR38' 'current   ' 'current   ' [-10  10]
    41  [14 2] 'ANS-C14/DG/CV.2          ' 1 'FVCOR39' 'current   ' 'current   ' [-10  10]
    42  [14 3] 'ANS-C14/DG/CV.3          ' 1 'FVCOR40' 'current   ' 'current   ' [-10  10]
    43  [14 4] 'ANS-C14/DG/CV.4          ' 1 'FVCOR41' 'current   ' 'current   ' [-10  10]
    44  [15 1] 'ANS-C15/DG/CV.1          ' 1 'FVCOR42' 'current   ' 'current   ' [-10  10]
    45  [15 2] 'ANS-C15/DG/CV.2          ' 1 'FVCOR43' 'current   ' 'current   ' [-10  10]
    46  [15 3] 'ANS-C15/DG/CV.3          ' 1 'FVCOR44' 'current   ' 'current   ' [-10  10]
    47  [15 4] 'ANS-C15/DG/CV.4          ' 1 'FVCOR45' 'current   ' 'current   ' [-10  10]
    48  [16 1] 'ANS-C16/DG/CV.1          ' 1 'FVCOR46' 'current   ' 'current   ' [-10  10]
    49  [16 2] 'ANS-C16/DG/CV.2          ' 1 'FVCOR47' 'current   ' 'current   ' [-10  10]
    50  [ 1 1] 'ANS-C01/DG/CV.1          ' 1 'FVCOR48' 'current   ' 'current   ' [-10  10]
    };

devnumber = length(varlist);
% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).Gain        = ones(devnumber,1);
AO.(ifam).Roll        = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
AO.(ifam).Setpoint.TangoNames = cell(devnumber,1);
AO.(ifam).Setpoint.Range = zeros(devnumber,2);
AO.(ifam).SetpointMean.TangoNames = cell(devnumber,1);
AO.(ifam).SetpointMean.Range = zeros(devnumber,2);

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,5));
    AO.(ifam).Monitor.TangoNames(k)  = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,6)));
    AO.(ifam).Setpoint.TangoNames(k) = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,7)));
    AO.(ifam).Setpoint.Range(k,:)      = varlist{k,8};
    AO.(ifam).SetpointMean.TangoNames(k) = strcat(AO.(ifam).DeviceName{k}, {'/spMean'});
    AO.(ifam).SetpointMean.Range(k,:)   = varlist{k,8};
end

%Load fields from datablock
% AT use the "A-coefficients" for correctors plus an offset
[C, Leff, MagnetType, coefficients] = magnetcoefficients(AO.(ifam).FamilyName);

for ii = 1:devnumber,
    AO.(ifam).Monitor.HW2PhysicsParams{1}(ii,:)   = coefficients;
    AO.(ifam).Monitor.Physics2HWParams{1}(ii,:)   = coefficients;
    AO.(ifam).Setpoint.HW2PhysicsParams{1}(ii,:)  = coefficients;
    AO.(ifam).Setpoint.Physics2HWParams{1}(ii,:)  = coefficients;
end


AO.(ifam).Monitor.MemberOf      = {'PlotFamily'};
AO.(ifam).Setpoint.MemberOf     = {'PlotFamily'};
AO.(ifam).Setpoint.Tolerance(:,:)    = 1e-1*ones(devnumber,1);
%AO.(ifam).Setpoint.DeltaRespMat(:,:) = 24e-6*ones(devnumber,1); % 2*12 urad
AO.(ifam).Setpoint.DeltaRespMat(:,:) = 2*3e-6*ones(devnumber,1); % 2*3 urad

%convert response matrix kicks to HWUnits (after AO is loaded to AppData)
setao(AO);   %required to make physics2hw function
AO.(ifam).Setpoint.DeltaRespMat = physics2hw(AO.(ifam).FamilyName,'Setpoint', ...
    AO.(ifam).Setpoint.DeltaRespMat, AO.(ifam).DeviceList);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PX2 correctors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ifam = 'PX2C';
AO.(ifam).FamilyName               = ifam;
AO.(ifam).FamilyType               = 'COR';
AO.(ifam).MemberOf                 = {'COR'; 'FCOR'; 'Magnet'; 'PlotFamily'; 'Archivable'};

AO.(ifam).Monitor.Mode              = Mode;
AO.(ifam).Monitor.DataType          = 'Scalar';
AO.(ifam).Monitor.Units             = 'Hardware';
AO.(ifam).Monitor.HWUnits           = 'A';
AO.(ifam).Monitor.PhysicsUnits      = 'rad';
AO.(ifam).Monitor.HW2PhysicsParams(:,:) = [0.0218; 0.0225; 0.0216]*1e-3/getbrho(2.739);
AO.(ifam).Monitor.Physics2HWParams(:,:) = 1./AO.(ifam).Monitor.HW2PhysicsParams(:,:);

AO.(ifam).Setpoint.Mode             = Mode;
AO.(ifam).Setpoint.DataType         = 'Scalar';
AO.(ifam).Setpoint.Units            = 'Hardware';
AO.(ifam).Setpoint.HWUnits          = 'A';
AO.(ifam).Setpoint.PhysicsUnits     = 'rad';
AO.(ifam).Setpoint.HW2PhysicsParams(:,:) = AO.(ifam).Monitor.HW2PhysicsParams(:,:);
AO.(ifam).Setpoint.Physics2HWParams(:,:) = AO.(ifam).Monitor.Physics2HWParams(:,:);

% devliste tangoname status common attR attW range
varlist = {
    1  [ 11 1] 'ANS-C11/AE/PX2-D.1' 1 'PX2C01' 'current' 'current' [-10  10]
    2  [ 11 2] 'ANS-C11/AE/PX2-D.2' 1 'PX2C02' 'current' 'current' [-10  10]
    3  [ 11 3] 'ANS-C11/AE/PX2-D.3' 1 'PX2C03' 'current' 'current' [-10  10]
    };

devnumber = size(varlist,1);
% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
AO.(ifam).Setpoint.TangoNames = cell(devnumber,1);
AO.(ifam).Setpoint.Range = zeros(devnumber,2);

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,5));
    AO.(ifam).Monitor.TangoNames(k)  = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,6)));
    AO.(ifam).Setpoint.TangoNames(k) = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,7)));
    AO.(ifam).Setpoint.Range(k,:)      = varlist{k,8};
end

AO.(ifam).Monitor.MemberOf      = {'PlotFamily'};
AO.(ifam).Setpoint.MemberOf     = {'PlotFamily'};
AO.(ifam).Setpoint.Tolerance(:,:)    = 1e-1*ones(devnumber,1);
AO.(ifam).Setpoint.DeltaRespMat(:,:) = 8e-6*ones(devnumber,1); % 2*2 �urad

%convert response matrix kicks to HWUnits (after AO is loaded to AppData)
setao(AO);   %required to make physics2hw function
AO.(ifam).Setpoint.DeltaRespMat = physics2hw(AO.(ifam).FamilyName,'Setpoint', ...
    AO.(ifam).Setpoint.DeltaRespMat, AO.(ifam).DeviceList);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NANOSCOPIUM tuner correctors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ifam = 'NANOC';
AO.(ifam).FamilyName               = ifam;
AO.(ifam).FamilyType               = 'COR';
AO.(ifam).MemberOf                 = {'COR'; 'FCOR'; 'Magnet'; 'PlotFamily'; 'Archivable'};

AO.(ifam).Monitor.Mode              = Mode;
AO.(ifam).Monitor.DataType          = 'Scalar';
AO.(ifam).Monitor.Units             = 'Hardware';
AO.(ifam).Monitor.HWUnits           = 'A';
AO.(ifam).Monitor.PhysicsUnits      = 'rad';
AO.(ifam).Monitor.HW2PhysicsParams(:,:) = [0.234; 0.08; 0.151; 0.077]*getbrho(2.7391);
AO.(ifam).Monitor.Physics2HWParams(:,:) = 1./AO.(ifam).Monitor.HW2PhysicsParams(:,:);

AO.(ifam).Setpoint.Mode             = Mode;
AO.(ifam).Setpoint.DataType         = 'Scalar';
AO.(ifam).Setpoint.Units            = 'Hardware';
AO.(ifam).Setpoint.HWUnits          = 'A';
AO.(ifam).Setpoint.PhysicsUnits     = 'rad';
AO.(ifam).Setpoint.HW2PhysicsParams(:,:) = AO.(ifam).Monitor.HW2PhysicsParams(:,:);
AO.(ifam).Setpoint.Physics2HWParams(:,:) = AO.(ifam).Monitor.Physics2HWParams(:,:);

% devliste tangoname status common attR attW range
varlist = {
    1  [ 13 1] 'ANS-C13/AE/NANO-CHI.1' 1 'NANOC01' 'current' 'current' [-10  10]
    2  [ 13 2] 'ANS-C13/AE/NANO-CHI.2' 1 'NANOC02' 'current' 'current' [-10  10]
    3  [ 13 3] 'ANS-C13/AE/NANO-CHI.3' 1 'NANOC03' 'current' 'current' [-10  10]
    4  [ 13 4] 'ANS-C13/AE/NANO-CHI.4' 1 'NANOC04' 'current' 'current' [-10  10]
    };

devnumber = size(varlist,1);
% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
AO.(ifam).Setpoint.TangoNames = cell(devnumber,1);
AO.(ifam).Setpoint.Range = zeros(devnumber,2);

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,5));
    AO.(ifam).Monitor.TangoNames(k)  = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,6)));
    AO.(ifam).Setpoint.TangoNames(k) = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,7)));
    AO.(ifam).Setpoint.Range(k,:)      = varlist{k,8};
end

AO.(ifam).Monitor.MemberOf      = {'PlotFamily'};
AO.(ifam).Setpoint.MemberOf     = {'PlotFamily'};
AO.(ifam).Setpoint.Tolerance(:,:)    = 1e-1*ones(devnumber,1);
AO.(ifam).Setpoint.DeltaRespMat(:,:) = 8e-6*ones(devnumber,1); % 2*2 �urad

%convert response matrix kicks to HWUnits (after AO is loaded to AppData)
setao(AO);   %required to make physics2hw function
AO.(ifam).Setpoint.DeltaRespMat = physics2hw(AO.(ifam).FamilyName,'Setpoint', ...
    AO.(ifam).Setpoint.DeltaRespMat, AO.(ifam).DeviceList);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TEMPO chicane
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ifam = 'TEMPOC';
AO.(ifam).FamilyName               = ifam;
AO.(ifam).FamilyType               = 'COR';
AO.(ifam).MemberOf                 = {'Magnet'; 'PlotFamily'; 'Archivable'};

AO.(ifam).Monitor.Mode              = Mode;
AO.(ifam).Monitor.DataType          = 'Scalar';
AO.(ifam).Monitor.Units             = 'Hardware';
AO.(ifam).Monitor.HWUnits           = 'A';
AO.(ifam).Monitor.PhysicsUnits      = 'rad';
%AO.(ifam).Monitor.HW2PhysicsParams(:,:) = [2.0506; 2.0516; 2.0251]*1e-3/getbrho(2.7391); % Experimental Rmat
AO.(ifam).Monitor.HW2PhysicsParams(:,:) = [2.208; 2.2269; 2.2005]*1e-3/getbrho(2.7391); % magnetic measurements
AO.(ifam).Monitor.Physics2HWParams(:,:) = 1./AO.(ifam).Monitor.HW2PhysicsParams(:,:);

AO.(ifam).Setpoint.Mode             = Mode;
AO.(ifam).Setpoint.DataType         = 'Scalar';
AO.(ifam).Setpoint.Units            = 'Hardware';
AO.(ifam).Setpoint.HWUnits          = 'A';
AO.(ifam).Setpoint.PhysicsUnits     = 'rad';
AO.(ifam).Setpoint.HW2PhysicsParams(:,:) = AO.(ifam).Monitor.HW2PhysicsParams(:,:);
AO.(ifam).Setpoint.Physics2HWParams(:,:) = AO.(ifam).Monitor.Physics2HWParams(:,:);

% devliste tangoname status common attR attW range
varlist = {
    1  [ 8 1] 'ANS-C08/AE/TEMPO.CHI.1' 1 'TEMPOC01' 'current' 'currentSetpointPM' [-11  11]
    2  [ 8 2] 'ANS-C08/AE/TEMPO.CHI.2' 1 'TEMPOC02' 'current' 'currentSetpointPM' [-11  11]
    3  [ 8 3] 'ANS-C08/AE/TEMPO.CHI.3' 1 'TEMPOC03' 'current' 'currentSetpointPM' [-11  11]
    };

devnumber = size(varlist,1);
% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
AO.(ifam).Setpoint.TangoNames = cell(devnumber,1);
AO.(ifam).Setpoint.Range = zeros(devnumber,2);

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,5));
    AO.(ifam).Monitor.TangoNames(k)  = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,6)));
    AO.(ifam).Setpoint.TangoNames(k) = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,7)));
    AO.(ifam).Setpoint.Range(k,:)      = varlist{k,8};
end


AO.(ifam).Profibus.BoardNumber = int32(0);
AO.(ifam).Profibus.Group       = int32(1);
AO.(ifam).Profibus.DeviceName  = 'ANS-C08/AE/DP1.TEMPO.CHI';

AO.(ifam).Monitor.MemberOf      = {'PlotFamily'};
AO.(ifam).Setpoint.MemberOf     = {'PlotFamily'};
AO.(ifam).Setpoint.Tolerance(:,:)    = 1e-1*ones(devnumber,1);
AO.(ifam).Setpoint.DeltaRespMat(:,:) = 8e-6*ones(devnumber,1); % 2*2 �urad

%convert response matrix kicks to HWUnits (after AO is loaded to AppData)
setao(AO);   %required to make physics2hw function
%AO.(ifam).Setpoint.DeltaRespMat = physics2hw(AO.(ifam).FamilyName,'Setpoint', ...
%    AO.(ifam).Setpoint.DeltaRespMat, AO.(ifam).DeviceList);

%=============================
%        MAIN MAGNETS
%=============================

%==============
%% DIPOLES
%==============

varlist={
     1  [ 1  1] 'ANS/AE/Dipole' 1 'BEND.01' [+0 +560]
     2  [ 1  2] 'ANS/AE/Dipole' 1 'BEND.02' [+0 +560]
     3  [ 2  1] 'ANS/AE/Dipole' 1 'BEND.03' [+0 +560]
     4  [ 2  2] 'ANS/AE/Dipole' 1 'BEND.04' [+0 +560]
     5  [ 3  1] 'ANS/AE/Dipole' 1 'BEND.05' [+0 +560]
     6  [ 3  2] 'ANS/AE/Dipole' 1 'BEND.06' [+0 +560]
     7  [ 4  1] 'ANS/AE/Dipole' 1 'BEND.07' [+0 +560]
     8  [ 4  2] 'ANS/AE/Dipole' 1 'BEND.08' [+0 +560]
     9  [ 5  1] 'ANS/AE/Dipole' 1 'BEND.09' [+0 +560]
     10 [ 5  2] 'ANS/AE/Dipole' 1 'BEND.10' [+0 +560]
     11 [ 6  1] 'ANS/AE/Dipole' 1 'BEND.11' [+0 +560]
     12 [ 6  2] 'ANS/AE/Dipole' 1 'BEND.12' [+0 +560]
     13 [ 7  1] 'ANS/AE/Dipole' 1 'BEND.13' [+0 +560]
     14 [ 7  2] 'ANS/AE/Dipole' 1 'BEND.14' [+0 +560]
     15 [ 8  1] 'ANS/AE/Dipole' 1 'BEND.15' [+0 +560]
     16 [ 8  2] 'ANS/AE/Dipole' 1 'BEND.16' [+0 +560]
     17 [ 9  1] 'ANS/AE/Dipole' 1 'BEND.17' [+0 +560]
     18 [ 9  2] 'ANS/AE/Dipole' 1 'BEND.18' [+0 +560]
     19 [10  1] 'ANS/AE/Dipole' 1 'BEND.19' [+0 +560]
     20 [10  2] 'ANS/AE/Dipole' 1 'BEND.20' [+0 +560]
     21 [11  1] 'ANS/AE/Dipole' 1 'BEND.21' [+0 +560]
     22 [11  2] 'ANS/AE/Dipole' 1 'BEND.22' [+0 +560]
     23 [12  1] 'ANS/AE/Dipole' 1 'BEND.23' [+0 +560]
     24 [12  2] 'ANS/AE/Dipole' 1 'BEND.24' [+0 +560]
     25 [13  1] 'ANS/AE/Dipole' 1 'BEND.25' [+0 +560]
     26 [13  2] 'ANS/AE/Dipole' 1 'BEND.26' [+0 +560]
     27 [14  1] 'ANS/AE/Dipole' 1 'BEND.27' [+0 +560]
     28 [14  2] 'ANS/AE/Dipole' 1 'BEND.28' [+0 +560]
     29 [15  1] 'ANS/AE/Dipole' 1 'BEND.29' [+0 +560]
     30 [15  2] 'ANS/AE/Dipole' 1 'BEND.30' [+0 +560]
     31 [16  1] 'ANS/AE/Dipole' 1 'BEND.31' [+0 +560]
     32 [16  2] 'ANS/AE/Dipole' 1 'BEND.32' [+0 +560]
};

% *** BEND ***
ifam='BEND';
AO.(ifam).FamilyName                 = ifam;
AO.(ifam).FamilyType                 = 'BEND';
AO.(ifam).MemberOf                   = {'MachineConfig'; 'BEND'; 'Magnet'; 'PlotFamily'; 'Archivable'};
HW2PhysicsParams                    = magnetcoefficients('BEND');
Physics2HWParams                    = HW2PhysicsParams;

AO.(ifam).Monitor.Mode               = Mode;
AO.(ifam).Monitor.DataType           = 'Scalar';
AO.(ifam).Monitor.Units              = 'Hardware';
AO.(ifam).Monitor.HW2PhysicsFcn      = @bend2gev;
AO.(ifam).Monitor.Physics2HWFcn      = @gev2bend;
AO.(ifam).Monitor.HWUnits            = 'A';
AO.(ifam).Monitor.PhysicsUnits       = 'GeV';

devnumber = size(varlist,1);
% preallocation
AO.(ifam).ElementList         = zeros(devnumber,1);
AO.(ifam).Status              = zeros(devnumber,1);
AO.(ifam).DeviceName          = cell(devnumber,1);
AO.(ifam).DeviceName          = cell(devnumber,1);
AO.(ifam).CommonNames         = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
% make Setpoint structure than specific data
AO.(ifam).Setpoint            = AO.(ifam).Monitor;
AO.(ifam).Setpoint.Range      = zeros(devnumber,2);

for ik = 1: devnumber,   
    AO.(ifam).ElementList(ik)           = varlist{ik,1};
    AO.(ifam).DeviceList(ik,:)          = varlist{ik,2};
    AO.(ifam).DeviceName(ik)            = deblank(varlist(ik,3));
    AO.(ifam).Status(ik)                = varlist{ik,4};
    AO.(ifam).CommonNames(ik)           = deblank(varlist(ik,5));
    AO.(ifam).Monitor.TangoNames(ik)    = strcat(AO.(ifam).DeviceName{ik}, {'/current'});   
    AO.(ifam).Setpoint.TangoNames(ik)   = strcat(AO.(ifam).DeviceName{ik}, {'/currentPM'});
    AO.(ifam).Status(ik)                = varlist{ik,4};
    AO.(ifam).Setpoint.Range(ik,:)      = varlist{ik,6};
end

AO.(ifam).Monitor.Handles(:,1) = NaN*ones(devnumber,1);

HW2PhysicsParams = magnetcoefficients(AO.(ifam).FamilyName);
Physics2HWParams = magnetcoefficients(AO.(ifam).FamilyName);

val = 1;
for ii=1:devnumber,
    AO.(ifam).Monitor.HW2PhysicsParams{1}(ii,:)                 = HW2PhysicsParams;
    AO.(ifam).Monitor.HW2PhysicsParams{2}(ii,:)                 = val;
    AO.(ifam).Monitor.Physics2HWParams{1}(ii,:)                 = Physics2HWParams;
    AO.(ifam).Monitor.Physics2HWParams{2}(ii,:)                 = val;
end
% same configuration for Monitor and Setpoint value concerning hardware to physics units
AO.(ifam).Setpoint.HW2PhysicsParams = AO.(ifam).Monitor.HW2PhysicsParams;
AO.(ifam).Setpoint.Physics2HWParams = AO.(ifam).Monitor.Physics2HWParams;

AO.(ifam).Setpoint = AO.(ifam).Monitor;
AO.(ifam).Desired  = AO.(ifam).Monitor;
AO.(ifam).Setpoint.MemberOf  = {'PlotFamily'};
AO.(ifam).Setpoint.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentPM');

AO.(ifam).Setpoint.Tolerance(:,:) = 0.05;
AO.(ifam).Setpoint.DeltaRespMat(:,:) = 0.05;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% QUADRUPOLE MAGNETS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear varlist;
varlist.Q1={
    1 [ 1  1] 'ANS-C01/AE/Q1      ' 1 ' Q1.1' [-250 +0]
    2 [ 4  1] 'ANS-C04/AE/Q1      ' 1 ' Q1.2' [-250 +0]
    3 [ 5  1] 'ANS-C05/AE/Q1      ' 1 ' Q1.3' [-250 +0]
    4 [ 8  1] 'ANS-C08/AE/Q1      ' 1 ' Q1.4' [-250 +0]
    5 [ 9  1] 'ANS-C09/AE/Q1      ' 1 ' Q1.5' [-250 +0]
    6 [12  1] 'ANS-C12/AE/Q1      ' 1 ' Q1.6' [-250 +0]
    7 [13  1] 'ANS-C13/AE/Q1      ' 1 ' Q1.7' [-250 +0]
    8 [16  1] 'ANS-C16/AE/Q1      ' 1 ' Q1.8' [-250 +0]
    };
varlist.Q2={
    1 [ 1  1] 'ANS-C01/AE/Q2      ' 1 ' Q2.1' [+0 +250]
    2 [ 4  1] 'ANS-C04/AE/Q2      ' 1 ' Q2.2' [+0 +250]
    3 [ 5  1] 'ANS-C05/AE/Q2      ' 1 ' Q2.3' [+0 +250]
    4 [ 8  1] 'ANS-C08/AE/Q2      ' 1 ' Q2.4' [+0 +250]
    5 [ 9  1] 'ANS-C09/AE/Q2      ' 1 ' Q2.5' [+0 +250]
    6 [12  1] 'ANS-C12/AE/Q2      ' 1 ' Q2.6' [+0 +250]
    7 [13  1] 'ANS-C13/AE/Q2      ' 1 ' Q2.7' [+0 +250]
    8 [16  1] 'ANS-C16/AE/Q2      ' 1 ' Q2.8' [+0 +250]
    };
varlist.Q3={
    1 [ 1  1] 'ANS-C01/AE/Q3      ' 1 ' Q3.1' [-250 +0]
    2 [ 4  1] 'ANS-C04/AE/Q3      ' 1 ' Q3.2' [-250 +0]
    3 [ 5  1] 'ANS-C05/AE/Q3      ' 1 ' Q3.3' [-250 +0]
    4 [ 8  1] 'ANS-C08/AE/Q3      ' 1 ' Q3.4' [-250 +0]
    5 [ 9  1] 'ANS-C09/AE/Q3      ' 1 ' Q3.5' [-250 +0]
    6 [12  1] 'ANS-C12/AE/Q3      ' 1 ' Q3.6' [-250 +0]
    7 [13  1] 'ANS-C13/AE/Q3      ' 1 ' Q3.7' [-250 +0]
    8 [16  1] 'ANS-C16/AE/Q3      ' 1 ' Q3.8' [-250 +0]
    };
varlist.Q4={
     1 [ 1  1] 'ANS-C01/AE/Q4.1    ' 1 'Q4.01' [-250 +0]
     2 [ 1  2] 'ANS-C01/AE/Q4.2    ' 1 'Q4.02' [-250 +0]
     3 [ 4  1] 'ANS-C04/AE/Q4.1    ' 1 'Q4.03' [-250 +0]
     4 [ 4  2] 'ANS-C04/AE/Q4.2    ' 1 'Q4.04' [-250 +0]
     5 [ 5  1] 'ANS-C05/AE/Q4.1    ' 1 'Q4.05' [-250 +0]
     6 [ 5  2] 'ANS-C05/AE/Q4.2    ' 1 'Q4.06' [-250 +0]
     7 [ 8  1] 'ANS-C08/AE/Q4.1    ' 1 'Q4.07' [-250 +0]
     8 [ 8  2] 'ANS-C08/AE/Q4.2    ' 1 'Q4.08' [-250 +0]
     9 [ 9  1] 'ANS-C09/AE/Q4.1    ' 1 'Q4.09' [-250 +0]
    10 [ 9  2] 'ANS-C09/AE/Q4.2    ' 1 'Q4.10' [-250 +0]
    11 [12  1] 'ANS-C12/AE/Q4.1    ' 1 'Q4.11' [-250 +0]
    12 [12  2] 'ANS-C12/AE/Q4.2    ' 1 'Q4.12' [-250 +0]
    13 [13  1] 'ANS-C13/AE/Q4.1    ' 1 'Q4.13' [-250 +0]
    14 [13  2] 'ANS-C13/AE/Q4.2    ' 1 'Q4.14' [-250 +0]
    15 [16  1] 'ANS-C16/AE/Q4.1    ' 1 'Q4.15' [-250 +0]
    16 [16  2] 'ANS-C16/AE/Q4.2    ' 1 'Q4.16' [-250 +0]
    };
varlist.Q5={
     1 [ 1  1] 'ANS-C01/AE/Q5.1    ' 1 'Q5.01' [+0 +250]
     2 [ 1  2] 'ANS-C01/AE/Q5.2    ' 1 'Q5.02' [+0 +250]
     3 [ 4  1] 'ANS-C04/AE/Q5.1    ' 1 'Q5.03' [+0 +250]
     4 [ 4  2] 'ANS-C04/AE/Q5.2    ' 1 'Q5.04' [+0 +250]
     5 [ 5  1] 'ANS-C05/AE/Q5.1    ' 1 'Q5.05' [+0 +250]
     6 [ 5  2] 'ANS-C05/AE/Q5.2    ' 1 'Q5.06' [+0 +250]
     7 [ 8  1] 'ANS-C08/AE/Q5.1    ' 1 'Q5.07' [+0 +250]
     8 [ 8  2] 'ANS-C08/AE/Q5.2    ' 1 'Q5.08' [+0 +250]
     9 [ 9  1] 'ANS-C09/AE/Q5.1    ' 1 'Q5.09' [+0 +250]
    10 [ 9  2] 'ANS-C09/AE/Q5.2    ' 1 'Q5.10' [+0 +250]
    11 [12  1] 'ANS-C12/AE/Q5.1    ' 1 'Q5.11' [+0 +250]
    12 [12  2] 'ANS-C12/AE/Q5.2    ' 1 'Q5.12' [+0 +250]
    13 [13  1] 'ANS-C13/AE/Q5.1    ' 1 'Q5.13' [+0 +250]
    14 [13  2] 'ANS-C13/AE/Q5.2    ' 1 'Q5.14' [+0 +250]
    15 [16  1] 'ANS-C16/AE/Q5.1    ' 1 'Q5.15' [+0 +250]
    16 [16  2] 'ANS-C16/AE/Q5.2    ' 1 'Q5.16' [+0 +250]
    };
varlist.Q6={
     1 [ 1  1] 'ANS-C01/AE/Q6      ' 1 'Q6.01' [-250 +0]
     2 [ 2  1] 'ANS-C02/AE/Q6.1    ' 1 'Q6.02' [-250 +0]
     3 [ 2  2] 'ANS-C02/AE/Q6.2    ' 1 'Q6.03' [-250 +0]
     4 [ 3  1] 'ANS-C03/AE/Q6.1    ' 1 'Q6.04' [-250 +0]
     5 [ 3  2] 'ANS-C03/AE/Q6.2    ' 1 'Q6.05' [-250 +0]
     6 [ 4  1] 'ANS-C04/AE/Q6      ' 1 'Q6.06' [-250 +0]
     7 [ 5  1] 'ANS-C05/AE/Q6      ' 1 'Q6.07' [-250 +0]
     8 [ 6  1] 'ANS-C06/AE/Q6.1    ' 1 'Q6.08' [-250 +0]
     9 [ 6  2] 'ANS-C06/AE/Q6.2    ' 1 'Q6.09' [-250 +0]
    10 [ 7  1] 'ANS-C07/AE/Q6.1    ' 1 'Q6.10' [-250 +0]
    11 [ 7  2] 'ANS-C07/AE/Q6.2    ' 1 'Q6.11' [-250 +0]
    12 [ 8  1] 'ANS-C08/AE/Q6      ' 1 'Q6.12' [-250 +0]
    13 [ 9  1] 'ANS-C09/AE/Q6      ' 1 'Q6.13' [-250 +0]
    14 [10  1] 'ANS-C10/AE/Q6.1    ' 1 'Q6.14' [-250 +0]
    15 [10  2] 'ANS-C10/AE/Q6.2    ' 1 'Q6.15' [-250 +0]
    16 [11  1] 'ANS-C11/AE/Q6.1    ' 1 'Q6.16' [-250 +0]
    17 [11  2] 'ANS-C11/AE/Q6.2    ' 1 'Q6.17' [-250 +0]
    18 [12  1] 'ANS-C12/AE/Q6      ' 1 'Q6.18' [-250 +0]
    19 [13  1] 'ANS-C13/AE/Q6      ' 1 'Q6.19' [-250 +0]
    20 [14  1] 'ANS-C14/AE/Q6.1    ' 1 'Q6.20' [-250 +0]
    21 [14  2] 'ANS-C14/AE/Q6.2    ' 1 'Q6.21' [-250 +0]
    22 [15  1] 'ANS-C15/AE/Q6.1    ' 1 'Q6.22' [-250 +0]
    23 [15  2] 'ANS-C15/AE/Q6.2    ' 1 'Q6.23' [-250 +0]
    24 [16  1] 'ANS-C16/AE/Q6      ' 1 'Q6.24' [-250 +0]
    };
varlist.Q7={
     1 [ 1  1] 'ANS-C01/AE/Q7      ' 1 'Q7.01' [+0 +250]
     2 [ 2  1] 'ANS-C02/AE/Q7.1    ' 1 'Q7.02' [+0 +250]
     3 [ 2  2] 'ANS-C02/AE/Q7.2    ' 1 'Q7.03' [+0 +250]
     4 [ 3  1] 'ANS-C03/AE/Q7.1    ' 1 'Q7.04' [+0 +250]
     5 [ 3  2] 'ANS-C03/AE/Q7.2    ' 1 'Q7.05' [+0 +250]
     6 [ 4  1] 'ANS-C04/AE/Q7      ' 1 'Q7.06' [+0 +250]
     7 [ 5  1] 'ANS-C05/AE/Q7      ' 1 'Q7.07' [+0 +250]
     8 [ 6  1] 'ANS-C06/AE/Q7.1    ' 1 'Q7.08' [+0 +250]
     9 [ 6  2] 'ANS-C06/AE/Q7.2    ' 1 'Q7.09' [+0 +250]
    10 [ 7  1] 'ANS-C07/AE/Q7.1    ' 1 'Q7.10' [+0 +250]
    11 [ 7  2] 'ANS-C07/AE/Q7.2    ' 1 'Q7.11' [+0 +250]
    12 [ 8  1] 'ANS-C08/AE/Q7      ' 1 'Q7.12' [+0 +250]
    13 [ 9  1] 'ANS-C09/AE/Q7      ' 1 'Q7.13' [+0 +250]
    14 [10  1] 'ANS-C10/AE/Q7.1    ' 1 'Q7.14' [+0 +250]
    15 [10  2] 'ANS-C10/AE/Q7.2    ' 1 'Q7.15' [+0 +250]
    16 [11  1] 'ANS-C11/AE/Q7.1    ' 1 'Q7.16' [+0 +250]
    17 [11  2] 'ANS-C11/AE/Q7.2    ' 1 'Q7.17' [+0 +250]
    18 [12  1] 'ANS-C12/AE/Q7      ' 1 'Q7.18' [+0 +250]
    19 [13  1] 'ANS-C13/AE/Q7      ' 1 'Q7.19' [+0 +250]
    20 [14  1] 'ANS-C14/AE/Q7.1    ' 1 'Q7.20' [+0 +250]
    21 [14  2] 'ANS-C14/AE/Q7.2    ' 1 'Q7.21' [+0 +250]
    22 [15  1] 'ANS-C15/AE/Q7.1    ' 1 'Q7.22' [+0 +250]
    23 [15  2] 'ANS-C15/AE/Q7.2    ' 1 'Q7.23' [+0 +250]
    24 [16  1] 'ANS-C16/AE/Q7      ' 1 'Q7.24' [+0 +250]
    };
varlist.Q8={
     1 [ 1  1] 'ANS-C01/AE/Q8      ' 1 'Q8.01' [-250 +0]
     2 [ 2  1] 'ANS-C02/AE/Q8.1    ' 1 'Q8.02' [-250 +0]
     3 [ 2  2] 'ANS-C02/AE/Q8.2    ' 1 'Q8.03' [-250 +0]
     4 [ 3  1] 'ANS-C03/AE/Q8.1    ' 1 'Q8.04' [-250 +0]
     5 [ 3  2] 'ANS-C03/AE/Q8.2    ' 1 'Q8.05' [-250 +0]
     6 [ 4  1] 'ANS-C04/AE/Q8      ' 1 'Q8.06' [-250 +0]
     7 [ 5  1] 'ANS-C05/AE/Q8      ' 1 'Q8.07' [-250 +0]
     8 [ 6  1] 'ANS-C06/AE/Q8.1    ' 1 'Q8.08' [-250 +0]
     9 [ 6  2] 'ANS-C06/AE/Q8.2    ' 1 'Q8.09' [-250 +0]
    10 [ 7  1] 'ANS-C07/AE/Q8.1    ' 1 'Q8.10' [-250 +0]
    11 [ 7  2] 'ANS-C07/AE/Q8.2    ' 1 'Q8.11' [-250 +0]
    12 [ 8  1] 'ANS-C08/AE/Q8      ' 1 'Q8.12' [-250 +0]
    13 [ 9  1] 'ANS-C09/AE/Q8      ' 1 'Q8.13' [-250 +0]
    14 [10  1] 'ANS-C10/AE/Q8.1    ' 1 'Q8.14' [-250 +0]
    15 [10  2] 'ANS-C10/AE/Q8.2    ' 1 'Q8.15' [-250 +0]
    16 [11  1] 'ANS-C11/AE/Q8.1    ' 1 'Q8.16' [-250 +0]
    17 [11  2] 'ANS-C11/AE/Q8.2    ' 1 'Q8.17' [-250 +0]
    18 [12  1] 'ANS-C12/AE/Q8      ' 1 'Q8.18' [-250 +0]
    19 [13  1] 'ANS-C13/AE/Q8      ' 1 'Q8.19' [-250 +0]
    20 [14  1] 'ANS-C14/AE/Q8.1    ' 1 'Q8.20' [-250 +0]
    21 [14  2] 'ANS-C14/AE/Q8.2    ' 1 'Q8.21' [-250 +0]
    22 [15  1] 'ANS-C15/AE/Q8.1    ' 1 'Q8.22' [-250 +0]
    23 [15  2] 'ANS-C15/AE/Q8.2    ' 1 'Q8.23' [-250 +0]
    24 [16  1] 'ANS-C16/AE/Q8      ' 1 'Q8.24' [-250 +0]
    };
varlist.Q9={
     1 [ 2  1] 'ANS-C02/AE/Q9.1    ' 1 'Q9.01' [-250 +0]
     2 [ 2  2] 'ANS-C02/AE/Q9.2    ' 1 'Q9.02' [-250 +0]
     3 [ 3  1] 'ANS-C03/AE/Q9.1    ' 1 'Q9.03' [-250 +0]
     4 [ 3  2] 'ANS-C03/AE/Q9.2    ' 1 'Q9.04' [-250 +0]
     5 [ 6  1] 'ANS-C06/AE/Q9.1    ' 1 'Q9.05' [-250 +0]
     6 [ 6  2] 'ANS-C06/AE/Q9.2    ' 1 'Q9.06' [-250 +0]
     7 [ 7  1] 'ANS-C07/AE/Q9.1    ' 1 'Q9.07' [-250 +0]
     8 [ 7  2] 'ANS-C07/AE/Q9.2    ' 1 'Q9.08' [-250 +0]
     9 [10  1] 'ANS-C10/AE/Q9.1    ' 1 'Q9.09' [-250 +0]
    10 [10  2] 'ANS-C10/AE/Q9.2    ' 1 'Q9.10' [-250 +0]
    11 [11  1] 'ANS-C11/AE/Q9.1    ' 1 'Q9.11' [-250 +0]
    12 [11  2] 'ANS-C11/AE/Q9.2    ' 1 'Q9.12' [-250 +0]
    13 [14  1] 'ANS-C14/AE/Q9.1    ' 1 'Q9.13' [-250 +0]
    14 [14  2] 'ANS-C14/AE/Q9.2    ' 1 'Q9.14' [-250 +0]
    15 [15  1] 'ANS-C15/AE/Q9.1    ' 1 'Q9.15' [-250 +0]
    16 [15  2] 'ANS-C15/AE/Q9.2    ' 1 'Q9.16' [-250 +0]
    };
varlist.Q10={
     1 [ 2  1] 'ANS-C02/AE/Q10.1   ' 1 'Q10.01' [+0 +250]
     2 [ 2  2] 'ANS-C02/AE/Q10.2   ' 1 'Q10.02' [+0 +250]
     3 [ 3  1] 'ANS-C03/AE/Q10.1   ' 1 'Q10.03' [+0 +250]
     4 [ 3  2] 'ANS-C03/AE/Q10.2   ' 1 'Q10.04' [+0 +250]
     5 [ 6  1] 'ANS-C06/AE/Q10.1   ' 1 'Q10.05' [+0 +250]
     6 [ 6  2] 'ANS-C06/AE/Q10.2   ' 1 'Q10.06' [+0 +250]
     7 [ 7  1] 'ANS-C07/AE/Q10.1   ' 1 'Q10.07' [+0 +250]
     8 [ 7  2] 'ANS-C07/AE/Q10.2   ' 1 'Q10.08' [+0 +250]
     9 [10  1] 'ANS-C10/AE/Q10.1   ' 1 'Q10.09' [+0 +250]
    10 [10  2] 'ANS-C10/AE/Q10.2   ' 1 'Q10.10' [+0 +250]
    11 [11  1] 'ANS-C11/AE/Q10.1   ' 1 'Q10.11' [+0 +250]
    12 [11  2] 'ANS-C11/AE/Q10.2   ' 1 'Q10.12' [+0 +250]
    13 [14  1] 'ANS-C14/AE/Q10.1   ' 1 'Q10.13' [+0 +250]
    14 [14  2] 'ANS-C14/AE/Q10.2   ' 1 'Q10.14' [+0 +250]
    15 [15  1] 'ANS-C15/AE/Q10.1   ' 1 'Q10.15' [+0 +250]
    16 [15  2] 'ANS-C15/AE/Q10.2   ' 1 'Q10.16' [+0 +250]
    };
% for nanoscopium
varlist.Q11={
    1 [13  1] 'ANS-C13/AE/Q11.1   ' 1 'Q11.1' [-275 +0]
    2 [13  2] 'ANS-C13/AE/Q11.2   ' 1 'Q11.2' [-275 +0]
    };
varlist.Q12={   
    1 [13  1] 'ANS-C13/AE/Q12     ' 1 'Q12.1' [+0 +275]
    };

for k = 1:12,
    ifam = ['Q' num2str(k)];
    AO.(ifam).FamilyName                 = ifam;
    AO.(ifam).FamilyType                 = 'QUAD';
    AO.(ifam).MemberOf                   = {'MachineConfig'; 'QUAD'; 'Magnet'; 'PlotFamily'; 'Archivable'};
    AO.(ifam).Monitor.Mode               = Mode;
    AO.(ifam).Monitor.DataType           = 'Scalar';
    AO.(ifam).Monitor.Units              = 'Hardware';
    AO.(ifam).Monitor.HWUnits            = 'A';
    AO.(ifam).Monitor.PhysicsUnits       = 'meter^-2';
    AO.(ifam).Monitor.HW2PhysicsFcn      = @amp2kInterp;
    AO.(ifam).Monitor.Physics2HWFcn      = @k2ampInterp;
    
    ifam = sprintf('Q%s', num2str(k));
    devnumber = size(varlist.(ifam),1);
    % preallocation
    AO.(ifam).ElementList = zeros(devnumber,1);
    AO.(ifam).Status      = zeros(devnumber,1);
    AO.(ifam).DeviceName  = cell(devnumber,1);
    AO.(ifam).DeviceName  = cell(devnumber,1);
    AO.(ifam).CommonNames = cell(devnumber,1);
    AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
    % make Setpoint structure than specific data
    AO.(ifam).Setpoint = AO.(ifam).Monitor;
    AO.(ifam).Setpoint.Range = zeros(devnumber,2);
    
    for ik = 1: devnumber,
        AO.(ifam).ElementList(ik)  = varlist.(ifam){ik,1};
        AO.(ifam).DeviceList(ik,:) = varlist.(ifam){ik,2};
        AO.(ifam).DeviceName(ik)   = deblank(varlist.(ifam)(ik,3));
        AO.(ifam).Status(ik)       = varlist.(ifam){ik,4};
        AO.(ifam).CommonNames(ik)  = deblank(varlist.(ifam)(ik,5));
        AO.(ifam).Monitor.TangoNames(ik)  = strcat(AO.(ifam).DeviceName{ik}, {'/currentPM'});
        AO.(ifam).Setpoint.TangoNames(ik) = strcat(AO.(ifam).DeviceName{ik}, {'/currentPM'});
        AO.(ifam).Setpoint.Range(ik,:)      = varlist.(ifam){ik,6};
    end
    
    %AO.(ifam).Monitor.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,{'/currentPM'});
    AO.(ifam).Monitor.Handles(:,1) = NaN*ones(devnumber,1);
	
    [MagnetType, Leff, MagnetMeasurementsData, CorrectionFactor] = magnetinterp(AO.(ifam).FamilyName);
    HW2PhysicsParams = {MagnetType, Leff, MagnetMeasurementsData, CorrectionFactor};
    Physics2HWParams = {MagnetType, Leff, MagnetMeasurementsData, CorrectionFactor};
    
    val = 1.0;
    for ii=1:devnumber,
        AO.(ifam).Monitor.HW2PhysicsParams{1}(ii,:)                 = HW2PhysicsParams;
        AO.(ifam).Monitor.HW2PhysicsParams{2}(ii,:)                 = val;
        AO.(ifam).Monitor.Physics2HWParams{1}(ii,:)                 = Physics2HWParams;
        AO.(ifam).Monitor.Physics2HWParams{2}(ii,:)                 = val;
    end
    % same configuration for Monitor and Setpoint value concerning hardware to physics units
    AO.(ifam).Setpoint.HW2PhysicsParams = AO.(ifam).Monitor.HW2PhysicsParams;
    AO.(ifam).Setpoint.Physics2HWParams = AO.(ifam).Monitor.Physics2HWParams;
    
    % Group
    if ControlRoomFlag
            AO.(ifam).GroupId = tango_group_create2(ifam);
            tango_group_add(AO.(ifam).GroupId,AO.(ifam).DeviceName');
    else
        AO.(ifam).GroupId = nan;
    end
    
    % to be part of plotfamily
    AO.(ifam).Setpoint.MemberOf  = {'PlotFamily'};
    % set tolerance for setting values
    AO.(ifam).Setpoint.Tolerance(:,:) = 0.02*ones(devnumber,1);
    % information for getrunflag
    AO.(ifam).Setpoint.RunFlagFcn = @tangogetrunflag;
    AO.(ifam).Setpoint.RampRate = 1;
       
    AO.(ifam).Desired  = AO.(ifam).Monitor;
    
    AO.(ifam).Voltage = AO.(ifam).Monitor;
    AO.(ifam).Voltage.MemberOf  = {'PlotFamily'};
    AO.(ifam).Voltage.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/voltage');
    AO.(ifam).Voltage.HWUnits            = 'V';
    
    AO.(ifam).DCCT = AO.(ifam).Monitor;
    AO.(ifam).DCCT.MemberOf  = {'PlotFamily'};
    AO.(ifam).DCCT.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/current');
    
    AO.(ifam).CurrentTotal = AO.(ifam).Monitor;
    AO.(ifam).CurrentTotal.MemberOf  = {'PlotFamily'};
    AO.(ifam).CurrentTotal.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentTotal');
    
    AO.(ifam).CurrentSetpoint = AO.(ifam).Monitor;
    AO.(ifam).CurrentSetpoint.MemberOf  = {'PlotFamily'};
    AO.(ifam).CurrentSetpoint.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentSetpoint');
    
    AO.(ifam).SumOffset = AO.(ifam).Monitor;
    AO.(ifam).SumOffset.MemberOf  = {'PlotFamily'};
    AO.(ifam).SumOffset.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/ecart3');
    
    AO.(ifam).Offset1 = AO.(ifam).Monitor;
    AO.(ifam).Offset1.MemberOf  = {'PlotFamily'};
    AO.(ifam).Offset1.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentOffset1');
        
    % Profibus configuration
    if k < 6
        AO.(ifam).Profibus.BoardNumber = int32(1);
        AO.(ifam).Profibus.Group       = int32(k);
        AO.(ifam).Profibus.DeviceName  = 'ANS/AE/DP.QP';
    elseif k < 11
        AO.(ifam).Profibus.BoardNumber = int32(0);
        AO.(ifam).Profibus.Group       = int32(k-5);
        AO.(ifam).Profibus.DeviceName  = 'ANS/AE/DP.QP';
    else % NANOSCOPIUM
        AO.(ifam).Profibus.BoardNumber = int32(0);
        AO.(ifam).Profibus.Group       = int32(6);
        AO.(ifam).Profibus.DeviceName  = 'ANS-C13/AE/DP.NANOSCOPIUM';
    end
    %convert response matrix kicks to HWUnits (after AO is loaded to AppData)
    setao(AO);   %required to make physics2hw function
    AO.(ifam).Setpoint.DeltaKBeta = 1; % for betatron function measurement.
end

% TODO : this is lattice dependent !
% step for tuneshift of 1-e-2 in one of the planes
AO.Q1.Setpoint.DeltaRespMat = 0.4; %A
AO.Q2.Setpoint.DeltaRespMat = 0.15;%A
AO.Q3.Setpoint.DeltaRespMat = 0.5; %A
AO.Q4.Setpoint.DeltaRespMat = 0.2; %A
AO.Q5.Setpoint.DeltaRespMat = 0.2; %A
AO.Q6.Setpoint.DeltaRespMat = 0.2; %A
AO.Q7.Setpoint.DeltaRespMat = 0.2; %A
AO.Q8.Setpoint.DeltaRespMat = 0.2; %A
AO.Q9.Setpoint.DeltaRespMat = 0.2; %A
AO.Q10.Setpoint.DeltaRespMat = 0.2; %A
AO.Q11.Setpoint.DeltaRespMat = 0.2; %A to be modified
AO.Q12.Setpoint.DeltaRespMat = 0.2; %A to be modified



%% All quadrupoles
ifam = 'Qall';
AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'PlotFamily'};
AO.(ifam).FamilyType             = 'Qall';
AO.(ifam).Mode                   = Mode;

AO.(ifam).DeviceName= {};

for k = 1:12, % nanoscopium
    iquad = sprintf('Q%d',k);
    AO.(ifam).DeviceName = {AO.(ifam).DeviceName{:} AO.(iquad).DeviceName{:}};
end

AO.(ifam).DeviceName = AO.(ifam).DeviceName';

AO.(ifam).DeviceList = [];

devnumber = length(AO.(ifam).DeviceName);

% build fake device list in order to use plotfamily
for k =1:devnumber,
    AO.(ifam).DeviceList = [AO.(ifam).DeviceList; 1 k];
end

AO.(ifam).Monitor.HW2PhysicsParams(:,:) = 1e-3*ones(devnumber,1);
AO.(ifam).Monitor.Physics2HWParams(:,:) = 1e3*ones(devnumber,1);

AO.(ifam).ElementList            = (1:devnumber)';
AO.(ifam).Status                 = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'meter^-2';
AO.(ifam).Monitor.TangoNames     = strcat(AO.(ifam).DeviceName, '/current');
AO.(ifam).Setpoint               = AO.(ifam).Monitor;
AO.(ifam).Setpoint.MemberOf      = {'PlotFamily'};
AO.(ifam).Setpoint.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentPM');

AO.(ifam).Voltage = AO.(ifam).Monitor;
AO.(ifam).Voltage.MemberOf  = {'PlotFamily'};
AO.(ifam).Voltage.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/voltage');

AO.(ifam).DCCT = AO.(ifam).Monitor;
AO.(ifam).DCCT.MemberOf  = {'PlotFamily'};
AO.(ifam).DCCT.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/current');

AO.(ifam).CurrentTotal = AO.(ifam).Monitor;
AO.(ifam).CurrentTotal.MemberOf  = {'PlotFamily'};
AO.(ifam).CurrentTotal.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentTotal');

AO.(ifam).CurrentSetpoint = AO.(ifam).Monitor;
AO.(ifam).CurrentSetpoint.MemberOf  = {'PlotFamily'};
AO.(ifam).CurrentSetpoint.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentSetpoint');

AO.(ifam).SumOffset = AO.(ifam).Monitor;
AO.(ifam).SumOffset.MemberOf  = {'PlotFamily'};
AO.(ifam).SumOffset.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/ecart3');

AO.(ifam).Offset1 = AO.(ifam).Monitor;
AO.(ifam).Offset1.MemberOf  = {'PlotFamily'};
AO.(ifam).Offset1.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentOffset1');


%% QC13
ifam = 'QC13';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'PlotFamily'};
AO.(ifam).FamilyType             = 'QUADC13';
AO.(ifam).Mode                   = Mode;
AO.(ifam).DeviceName             = {'ANS-C13/AE/Q1'; 'ANS-C13/AE/Q2'; 'ANS-C13/AE/Q3';  'ANS-C13/AE/Q4.1';
                                    'ANS-C13/AE/Q5.1'; 'ANS-C13/AE/Q5.2'; 'ANS-C13/AE/Q4.2'; 'ANS-C13/AE/Q6';
                                    'ANS-C13/AE/Q7'; 'ANS-C13/AE/Q8' };
AO.(ifam).DeviceList             = [13 1; 13 2; 13 3; 13 4; 13 5; 13 6; 13 7; 13 8; 13 9; 13 10];
devnumber = length(AO.(ifam).DeviceList);
AO.(ifam).ElementList            = (1:devnumber)';
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'meter^-2';
AO.(ifam).Monitor.HW2PhysicsFcn  = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn  = @k2amp;
AO.(ifam).Monitor.TangoNames     = strcat(AO.(ifam).DeviceName, '/current');
AO.(ifam).Setpoint               = AO.(ifam).Monitor;
AO.(ifam).Desired                = AO.(ifam).Monitor;
AO.(ifam).Setpoint.MemberOf      = {'PlotFamily'};
AO.(ifam).Setpoint.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentPM');


clear tune

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SEXTUPOLE MAGNETS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 343 A for 320 Tm-2
% S11 et S12 use quadrupole power supplies (nanoscopium)
clear varlist;
% varlist.S1 ={
%   1 [ 1  1] 'ANS/AE/S1     ' 1 'S1 ' [+000 +349]
%   2 [ 4  1] 'ANS/AE/S1     ' 1 'S1 ' [+000 +349]
%   3 [ 5  1] 'ANS/AE/S1     ' 1 'S1 ' [+000 +349]
%   4 [ 7  1] 'ANS/AE/S1     ' 1 'S1 ' [+000 +349]
%   5 [ 8  1] 'ANS/AE/S1     ' 1 'S1 ' [+000 +349]
%   6 [16  1] 'ANS/AE/S1     ' 1 'S1 ' [+000 +349]
% };


varlist={
  1 [ 1  1] 'ANS/AE/S1     ' 1 'S1 ' [+000 +349]
  1 [ 1  1] 'ANS/AE/S2     ' 1 'S2 ' [-349 +000]
  1 [ 1  1] 'ANS/AE/S3     ' 1 'S3 ' [-349 +000]
  1 [ 1  1] 'ANS/AE/S4     ' 1 'S4 ' [+000 +349]
  1 [ 1  1] 'ANS/AE/S5     ' 1 'S5 ' [-349 +000]
  1 [ 1  1] 'ANS/AE/S6     ' 1 'S6 ' [+000 +349]
  1 [ 1  1] 'ANS/AE/S7     ' 1 'S7 ' [-349 +000]
  1 [ 1  1] 'ANS/AE/S8     ' 1 'S8 ' [+000 +349]
  1 [ 1  1] 'ANS/AE/S9     ' 1 'S9 ' [-349 +000]
  1 [ 1  1] 'ANS/AE/S10    ' 1 'S10' [+000 +349]
  1 [ 1  1] 'ANS/AE/S11    ' 1 'S11' [+000 +274]
  1 [13  1] 'ANS-C13/AE/S12' 1 'S12' [-274 +000]
};

for k = 1:length(varlist),
    %ifam = ['S' num2str(k)];
    ifam = cell2mat(deblank(varlist(k,5)));
    
    AO.(ifam).FamilyName                = ifam;
    AO.(ifam).FamilyType                = 'SEXT';
    AO.(ifam).MemberOf                  = {'MachineConfig'; 'SEXT'; 'Magnet'; 'Archivable'};
    
    AO.(ifam).Monitor.Mode              = Mode;
    AO.(ifam).Monitor.DataType          = 'Scalar';
    AO.(ifam).Monitor.Units             = 'Hardware';
    AO.(ifam).Monitor.HW2PhysicsFcn     = @amp2kInterp;
    AO.(ifam).Monitor.Physics2HWFcn     = @k2ampInterp;
    AO.(ifam).Monitor.HWUnits           = 'A';
    AO.(ifam).Monitor.PhysicsUnits      = 'meter^-3';
    AO.(ifam).Monitor.Handles           = NaN;
    AO.(ifam).Setpoint                  = AO.(ifam).Monitor;

    AO.(ifam).DeviceList                = varlist{k,2};
    AO.(ifam).ElementList               = varlist{k,1};    
    AO.(ifam).DeviceName                = deblank(varlist{k,3});
    AO.(ifam).Status                    = varlist{k,4};
    AO.(ifam).CommonNames               = deblank(varlist{k,5});
    AO.(ifam).Setpoint.Range(:,:)       = varlist{k,6};
    
    dev = AO.(ifam).DeviceName;
    AO.(ifam).Monitor.TangoNames  = strcat(dev,'/current');
   
    % Configuration of HW to Physics
	[MagnetType, Leff, MagnetMeasurementsData, CorrectionFactor] = magnetinterp(AO.(ifam).FamilyName);
    HW2PhysicsParams = {MagnetType, Leff, MagnetMeasurementsData, CorrectionFactor};
    Physics2HWParams = {MagnetType, Leff, MagnetMeasurementsData, CorrectionFactor};
    
	%HW2PhysicsParams = magnetcoefficients(AO.(ifam).FamilyName);    
    val = 1.0; % scaling factor
    AO.(ifam).Monitor.HW2PhysicsParams{1}(1,:) = HW2PhysicsParams;
    AO.(ifam).Monitor.HW2PhysicsParams{2}(1,:) = val;
    AO.(ifam).Monitor.Physics2HWParams{1}(1,:) = Physics2HWParams;
    AO.(ifam).Monitor.Physics2HWParams{2}(1,:) = val;
    AO.(ifam).Setpoint.HW2PhysicsParams = AO.(ifam).Monitor.HW2PhysicsParams;
    AO.(ifam).Setpoint.Physics2HWParams = AO.(ifam).Monitor.Physics2HWParams;
        
    AO.(ifam).Setpoint.MemberOf  = {'PlotFamily'};
    AO.(ifam).Desired  = AO.(ifam).Monitor;
    AO.(ifam).Setpoint.TangoNames   = strcat(dev,'/currentPM');
    
    AO.(ifam).Setpoint.Tolerance     = 0.05;
    AO.(ifam).Setpoint.DeltaRespMat  = 2e7; % Physics units for a thin sextupole
    
    % information for getrunflag
    AO.(ifam).Setpoint.RunFlagFcn = @tangogetrunflag;
    AO.(ifam).Setpoint.RampRate = 1;
    
    %convert response matrix kicks to HWUnits (after AO is loaded to AppData)
    setao(AO);   %required to make physics2hw function
    AO.(ifam).Setpoint.DeltaRespMat=physics2hw(AO.(ifam).FamilyName,'Setpoint',AO.(ifam).Setpoint.DeltaRespMat,AO.(ifam).DeviceList);
end

% Config profibus not used for sextupoles NANOSCOPIUM
%         AO.(ifam).Profibus.BoardNumber = int32(0);
%         AO.(ifam).Profibus.Group       = int32(1);
%         AO.(ifam).Profibus.DeviceName  = 'ANS-C13/AE/DP.NANOSCOPIUM';

%% All Sextupoles
ifam = 'Sall';
AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'PlotFamily';}; % 'SEXT' not compatible with configgui
AO.(ifam).FamilyType             = 'Sall';
AO.(ifam).Mode                   = Mode;

AO.(ifam).DeviceName= {};

for k = 1:12, % for nanoscopium
    isext = sprintf('S%d',k);
    AO.(ifam).DeviceName = {AO.(ifam).DeviceName{:} AO.(isext).DeviceName};
end

AO.(ifam).DeviceName = AO.(ifam).DeviceName';

AO.(ifam).DeviceList = [];

devnumber = length(AO.(ifam).DeviceName);

% build fake device list in order to use plotfamily
for k =1:devnumber,
    AO.(ifam).DeviceList = [AO.(ifam).DeviceList; 1 k];
end

AO.(ifam).ElementList            = (1:devnumber)';
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'meter^-3';
AO.(ifam).Monitor.HW2PhysicsFcn  = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn  = @k2amp;
AO.(ifam).Monitor.TangoNames     = strcat(AO.(ifam).DeviceName, '/current');

AO.(ifam).Setpoint               = AO.(ifam).Monitor;
AO.(ifam).Setpoint.MemberOf      = {'PlotFamily'};
AO.(ifam).Setpoint.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentPM');

AO.(ifam).Voltage = AO.(ifam).Monitor;
AO.(ifam).Voltage.MemberOf  = {'PlotFamily'};
AO.(ifam).Voltage.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/voltage');

AO.(ifam).DCCT = AO.(ifam).Monitor;
AO.(ifam).DCCT.MemberOf  = {'PlotFamily'};
AO.(ifam).DCCT.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/current');

AO.(ifam).CurrentTotal = AO.(ifam).Monitor;
AO.(ifam).CurrentTotal.MemberOf  = {'PlotFamily'};
AO.(ifam).CurrentTotal.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentTotal');

AO.(ifam).CurrentSetpoint = AO.(ifam).Monitor;
AO.(ifam).CurrentSetpoint.MemberOf  = {'PlotFamily'};
AO.(ifam).CurrentSetpoint.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentSetpoint');

AO.(ifam).SumOffset = AO.(ifam).Monitor;
AO.(ifam).SumOffset.MemberOf  = {'PlotFamily'};
AO.(ifam).SumOffset.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/ecart3');

AO.(ifam).Offset1 = AO.(ifam).Monitor;
AO.(ifam).Offset1.MemberOf  = {'PlotFamily'};
AO.(ifam).Offset1.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentOffset1');

% Build up fake poistion for plotfamily
AO.(ifam).Position = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);

%%%%%%%%%%%%%%%%%%
%% Pulsed Magnet
%%%%%%%%%%%%%%%%%%

%% All Injection kickers
ifam = 'K_INJ';
AO.(ifam).FamilyName           = ifam;
AO.(ifam).FamilyType           = ifam;
AO.(ifam).MemberOf             = {'Injection';'Archivable';'EP'};
AO.(ifam).Monitor.Mode         = Mode;
AO.(ifam).Monitor.DataType     = 'Scalar';

AO.(ifam).Status                   = ones(4,1);
AO.(ifam).DeviceName               = ['ANS-C01/EP/AL_K.1'; 'ANS-C01/EP/AL_K.2'; 'ANS-C01/EP/AL_K.3'; 'ANS-C01/EP/AL_K.4'];
AO.(ifam).CommonNames              = {'K1'; 'K2'; 'K3'; 'K4'};
AO.(ifam).ElementList              = [1 2 3 4]';
AO.(ifam).DeviceList(:,:)          = [1 1; 1 2; 1 3; 1 4];
AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(4,1);
AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/voltage');
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'V';
AO.(ifam).Monitor.PhysicsUnits     = 'mrad';
AO.(ifam).Monitor.HW2PhysicsFcn     = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn     = @k2amp;
HW2PhysicsParams                    = magnetcoefficients(ifam);
Physics2HWParams                    = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{1}(:,:) = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{2}(:,:) = 1;
AO.(ifam).Monitor.Physics2HWParams{1}(:,:) = Physics2HWParams;
AO.(ifam).Monitor.Physics2HWParams{2}(:,:) = 1;
AO.(ifam).Setpoint = AO.(ifam).Monitor;
AO.(ifam).Desired = AO.(ifam).Monitor;

%% K1 and K4 Injection kicker
ifam = 'K_INJ1';
AO.(ifam).FamilyName           = ifam;
AO.(ifam).FamilyType           = ifam;
AO.(ifam).MemberOf             = {'Injection';'Archivable';'EP'};
AO.(ifam).Monitor.Mode         = Mode;
AO.(ifam).Monitor.DataType     = 'Scalar';

AO.(ifam).Status                   = ones(2,1);
AO.(ifam).DeviceName               = ['ANS-C01/EP/AL_K.1'; 'ANS-C01/EP/AL_K.4'];
AO.(ifam).CommonNames              = ifam;
AO.(ifam).ElementList              = [1 2]';
AO.(ifam).DeviceList(:,:)          = [1 1;  1 4];
AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(2,1);
AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/voltage');
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'V';
AO.(ifam).Monitor.PhysicsUnits     = 'mrad';
AO.(ifam).Monitor.HW2PhysicsFcn     = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn     = @k2amp;
HW2PhysicsParams                    = magnetcoefficients(ifam);
Physics2HWParams                    = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{1}(:,:) = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{2}(:,:) = 1;
AO.(ifam).Monitor.Physics2HWParams{1}(:,:) = Physics2HWParams;
AO.(ifam).Monitor.Physics2HWParams{2}(:,:) = 1;
AO.(ifam).Setpoint = AO.(ifam).Monitor;
AO.(ifam).Desired = AO.(ifam).Monitor;

%% K2 and K3 Injection kicker
ifam = 'K_INJ2';
AO.(ifam).FamilyName           = ifam;
AO.(ifam).FamilyType           = ifam;
AO.(ifam).MemberOf             = {'Injection';'Archivable';'EP'};
AO.(ifam).Monitor.Mode         = Mode;
AO.(ifam).Monitor.DataType     = 'Scalar';

AO.(ifam).Status                   = ones(2,1);
AO.(ifam).DeviceName               = ['ANS-C01/EP/AL_K.2'; 'ANS-C01/EP/AL_K.3'];
AO.(ifam).CommonNames              = ifam;
AO.(ifam).ElementList              = [1 2]';
AO.(ifam).DeviceList(:,:)          = [1 2;  1 3];
AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(2,1);
AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/voltage');
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'V';
AO.(ifam).Monitor.PhysicsUnits     = 'mrad';
AO.(ifam).Monitor.HW2PhysicsFcn     = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn     = @k2amp;
HW2PhysicsParams                    = magnetcoefficients(ifam);
Physics2HWParams                    = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{1}(:,:) = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{2}(:,:) = 1;
AO.(ifam).Monitor.Physics2HWParams{1}(:,:) = Physics2HWParams;
AO.(ifam).Monitor.Physics2HWParams{2}(:,:) = 1;
AO.(ifam).Setpoint = AO.(ifam).Monitor;
AO.(ifam).Desired = AO.(ifam).Monitor;

%% Septum Passif
ifam = 'SEP_P';
AO.(ifam).FamilyName           =  ifam;
AO.(ifam).FamilyType           =  ifam;
AO.(ifam).MemberOf             =  {'Injection';'Archivable';'EP'};
AO.(ifam).Monitor.Mode         =   Mode;
AO.(ifam).Monitor.DataType     =  'Scalar';

AO.(ifam).Status                   = 1;
AO.(ifam).DeviceName               = cellstr('ANS-C01/EP/AL_SEP_P.1');
AO.(ifam).CommonNames              = ifam;
AO.(ifam).ElementList              = 1;
AO.(ifam).DeviceList(:,:)          = [1 1];
AO.(ifam).Monitor.Handles(:,1)     = NaN;
AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/serialVoltage');
AO.(ifam).Monitor.HW2PhysicsFcn    = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn    = @k2amp;
HW2PhysicsParams                   = magnetcoefficients(ifam);
Physics2HWParams                   = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{1}(:,:) = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{2}(:,:) = 1;
AO.(ifam).Monitor.Physics2HWParams{1}(:,:) = Physics2HWParams;
AO.(ifam).Monitor.Physics2HWParams{2}(:,:) = 1;
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'V';
AO.(ifam).Monitor.PhysicsUnits     = 'mrad';
AO.(ifam).Desired  = AO.(ifam).Monitor;
AO.(ifam).Setpoint = AO.(ifam).Monitor;


%% Septum Actif
ifam = 'SEP_A';
AO.(ifam).FamilyName           = ifam;
AO.(ifam).FamilyType           = ifam;
AO.(ifam).MemberOf             = {'Injection';'Archivable';'EP'};
AO.(ifam).Monitor.Mode         = Mode;
AO.(ifam).Monitor.DataType     = 'Scalar';

AO.(ifam).Status                   = 1;
AO.(ifam).DeviceName               = cellstr('ANS-C01/EP/AL_SEP_A');
AO.(ifam).CommonNames              = 'SEP_A_INJ';
AO.(ifam).ElementList              = 1;
AO.(ifam).DeviceList(:,:)           = [1 1];
AO.(ifam).Monitor.Handles(:,1)     = NaN;
AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/voltage');
AO.(ifam).Monitor.HW2PhysicsFcn     = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn     = @k2amp;
HW2PhysicsParams                    = magnetcoefficients(ifam);
Physics2HWParams                    = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{1}(:,:) = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{2}(:,:) = 1;
AO.(ifam).Monitor.Physics2HWParams{1}(:,:) = Physics2HWParams;
AO.(ifam).Monitor.Physics2HWParams{2}(:,:) = 1;
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'V';
AO.(ifam).Monitor.PhysicsUnits     = 'mrad';
AO.(ifam).Setpoint = AO.(ifam).Monitor;
AO.(ifam).Desired = AO.(ifam).Monitor;

%% KEMH
ifam = 'KEMH';
AO.(ifam).FamilyName           = ifam;
AO.(ifam).FamilyType           = ifam;
AO.(ifam).MemberOf             = {'KEM';'Archivable';'EP'};
AO.(ifam).Monitor.Mode         = Mode;
AO.(ifam).Monitor.DataType     = 'Scalar';

AO.(ifam).Status                   = 1;
AO.(ifam).DeviceName               = cellstr('ANS-C01/EP/AL_KEM_H');
AO.(ifam).CommonNames              = 'KEM_H';
AO.(ifam).ElementList              = 1;
AO.(ifam).DeviceList(:,:)           = [1 1];
AO.(ifam).Monitor.Handles(:,1)     = NaN;
AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/voltage');
AO.(ifam).Monitor.HW2PhysicsFcn     = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn     = @k2amp;
HW2PhysicsParams                    = magnetcoefficients(ifam);
Physics2HWParams                    = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{1}(:,:) = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{2}(:,:) = 1;
AO.(ifam).Monitor.Physics2HWParams{1}(:,:) = Physics2HWParams;
AO.(ifam).Monitor.Physics2HWParams{2}(:,:) = 1;
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'V';
AO.(ifam).Monitor.PhysicsUnits     = 'rad';
AO.(ifam).Setpoint = AO.(ifam).Monitor;
AO.(ifam).Desired  = AO.(ifam).Monitor;

%% KEMV
ifam = 'KEMV';
AO.(ifam).FamilyName           = ifam;
AO.(ifam).FamilyType           = ifam;
AO.(ifam).MemberOf             = {'KEM';'Archivable';'EP'};
AO.(ifam).Monitor.Mode         = Mode;
AO.(ifam).Monitor.DataType     = 'Scalar';

AO.(ifam).Status                    = 1;
AO.(ifam).DeviceName                = cellstr('ANS-C01/EP/AL_KEM_V');
AO.(ifam).CommonNames               = 'KEM_V';
AO.(ifam).ElementList               = 1;
AO.(ifam).DeviceList(:,:)           = [1 1];
AO.(ifam).Monitor.Handles(:,1)      = NaN;
AO.(ifam).Monitor.TangoNames        = strcat(AO.(ifam).DeviceName, '/voltage');
AO.(ifam).Monitor.HW2PhysicsFcn     = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn     = @k2amp;
HW2PhysicsParams                    = magnetcoefficients(ifam);
Physics2HWParams                    = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{1}(:,:) = HW2PhysicsParams;
AO.(ifam).Monitor.HW2PhysicsParams{2}(:,:) = 1;
AO.(ifam).Monitor.Physics2HWParams{1}(:,:) = Physics2HWParams;
AO.(ifam).Monitor.Physics2HWParams{2}(:,:) = 1;
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'V';
AO.(ifam).Monitor.PhysicsUnits     = 'rad';
AO.(ifam).Setpoint = AO.(ifam).Monitor;
AO.(ifam).Desired  = AO.(ifam).Monitor;

%% SCRAPERS
ifam = 'SCRAPER';
AO.(ifam).FamilyName           = ifam;
AO.(ifam).FamilyType           = ifam;
AO.(ifam).MemberOf             = {'DIAG';'Archivable'; 'MachineConfig'};
AO.(ifam).Monitor.Mode         = Mode;
AO.(ifam).Monitor.DataType     = 'scalar';

AO.(ifam).Status                   = ones(4,1);
AO.(ifam).DeviceName               = {
                                      'ANS-C01/DG/SCRA_V-MORS.HAUT'
                                      'ANS-C01/DG/SCRA_V-MORS.BAS'; 
                                      'ANS-C01/DG/SCRA_H-MORS.DROIT'; 
                                      'ANS-C16/DG/SCRA_H-MORS.GAUCHE';
                                      };
AO.(ifam).CommonNames              = {'SCRAPER_GAUCHE'; 'SCRAPER_DROIT'; ...
                                      'SCRAPER_BAS'; 'SCRAPER_HAUT'};
AO.(ifam).ElementList              = (1:4)';
AO.(ifam).DeviceList(:,:)          = [1 1; 1 2; 1 3; 16 1];
AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/position');
AO.(ifam).Monitor.HW2PhysicsFcn    = 1e-3*ones(4,1);
AO.(ifam).Monitor.Physics2HWFcn    = 1e3*ones(4,1);
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'mm';
AO.(ifam).Monitor.PhysicsUnits     = 'm';
AO.(ifam).Setpoint = AO.(ifam).Monitor;
AO.(ifam).Desired  = AO.(ifam).Monitor;

%% tune correctors
AO.Q7.MemberOf = {AO.Q7.MemberOf{:} 'Tune Corrector'}';
AO.Q9.MemberOf = {AO.Q9.MemberOf{:} 'Tune Corrector'}';

%% chromaticity correctors
AO.S9.MemberOf  = {AO.S9.MemberOf{:} 'Chromaticity Corrector'}';
AO.S10.MemberOf = {AO.S10.MemberOf{:} 'Chromaticity Corrector'}';

%%%%%%%%%%%%%%%%%%
%% CYCLAGE
%%%%%%%%%%%%%%%%%

disp('cycling configuration ...');

%% cycleramp For dipole magnet
ifam = 'CycleBEND';

AO.(ifam).FamilyName             = 'CycleBEND';
AO.(ifam).MemberOf               = {'CycleBEND'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;


AO.(ifam).DeviceName             = 'ANS/AE/cycleDipole';
AO.(ifam).DeviceList             = [1 1];
AO.(ifam).ElementList            = 1;
AO.(ifam).Inom = 541.789;
AO.(ifam).Imax = 579.9; %% to be modify by Pascale
%AO.(ifam).Imax = 547.0; %% to be modify by Pascale
AO.(ifam).Status = 1;

if ControlRoomFlag
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName);    
else
    AO.(ifam).GroupId = nan;
end

AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'A';
AO.(ifam).Monitor.PhysicsUnits   = 'GeV';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% cycleramp For H-corrector magnets
ifam  = 'CycleHCOR';
ifamQ = 'HCOR';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {'CycleCOR'; ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = AO.(ifamQ).DeviceList;
AO.(ifam).ElementList            = AO.(ifamQ).ElementList;

if ControlRoomFlag
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName(find(AO.(ifamQ).Status),:)')
else
    AO.(ifam).GroupId = nan;
end

devnumber = length(AO.(ifam).DeviceName);
AO.(ifam).Inom = 1.*ones(1,devnumber);
AO.(ifam).Imax = 10.99*ones(1,devnumber);
AO.(ifam).Status = AO.(ifamQ).Status;
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% cycleramp For V-corrector magnets
ifam = 'CycleVCOR';
ifamQ = 'VCOR';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {'CycleCOR'; ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = AO.(ifamQ).DeviceList;
AO.(ifam).ElementList            = AO.(ifamQ).ElementList;


if ControlRoomFlag
    AO.(ifam).GroupId                = tango_group_create(ifam);
    tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName(find(AO.(ifamQ).Status),:)')
else
    AO.(ifam).GroupId = nan;
end

devnumber = length(AO.(ifam).DeviceName);
AO.(ifam).Inom = 1.*ones(1,devnumber);
AO.(ifam).Imax = 13.99*ones(1,devnumber);
AO.(ifam).Status = AO.(ifamQ).Status;
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% cycleramp For QT-corrector magnets
ifam = 'CycleQT';
ifamQ = 'QT';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {'CycleCOR'; ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = AO.(ifamQ).DeviceList;
AO.(ifam).ElementList            = AO.(ifamQ).ElementList;


if ControlRoomFlag
    AO.(ifam).GroupId                = tango_group_create(ifam);
    tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName(find(AO.(ifamQ).Status),:)')
else
    AO.(ifam).GroupId = nan;
end

devnumber = length(AO.(ifam).DeviceName);
AO.(ifam).Inom = 1.*ones(1,devnumber);
AO.(ifam).Imax = 6.99*ones(1,devnumber);
AO.(ifam).Status = AO.(ifamQ).Status;
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');


% cycleramp For quadrupoles magnets
%% CYCLEQ1
ifam = 'CycleQ1';
ifamQ = 'Q1';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam; 'CycleQP'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/Q','/cycleQ');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);

if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end

devnumber = length(AO.(ifam).ElementList);
%AO.(ifam).Inom = 200.*ones(1,devnumber);
AO.(ifam).Imax = -249*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLEQ2
ifam = 'CycleQ2';
ifamQ = 'Q2';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'CycleQP'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/Q','/cycleQ');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);

if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end

devnumber = length(AO.(ifam).ElementList);
%AO.(ifam).Inom = 150*ones(1,devnumber);
AO.(ifam).Imax = 249*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLEQ3
ifam = 'CycleQ3';
ifamQ = 'Q3';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'CycleQP'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/Q','/cycleQ');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);

if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end

devnumber = length(AO.(ifam).ElementList);
%AO.(ifam).Inom = 150*ones(1,devnumber);
AO.(ifam).Imax = -249*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLEQ4
ifam = 'CycleQ4';
ifamQ = 'Q4';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'CycleQP'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/Q','/cycleQ');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
%AO.(ifam).Inom = 150*ones(1,devnumber);
AO.(ifam).Imax = -249*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLEQ5
ifam = 'CycleQ5';
ifamQ = 'Q5';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'CycleQP'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/Q','/cycleQ');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);

if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
%AO.(ifam).Inom = 150*ones(1,devnumber);
AO.(ifam).Imax = 249*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLEQ6
ifam = 'CycleQ6';
ifamQ = 'Q6';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'CycleQP'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/Q','/cycleQ');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
%AO.(ifam).Inom = 150*ones(1,devnumber);
AO.(ifam).Imax = -249*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLEQ7
ifam = 'CycleQ7';
ifamQ = 'Q7';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'CycleQP'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/Q','/cycleQ');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
%AO.(ifam).Inom = 150*ones(1,devnumber);
AO.(ifam).Imax = 249*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLEQ8
ifam = 'CycleQ8';
ifamQ = 'Q8';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'CycleQP'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/Q','/cycleQ');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);

if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end

devnumber = length(AO.(ifam).ElementList);
%AO.(ifam).Inom = 150*ones(1,devnumber);
AO.(ifam).Imax = -249*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLEQ9
ifam = 'CycleQ9';
ifamQ = 'Q9';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'CycleQP'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/Q','/cycleQ');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
%AO.(ifam).Inom = 150*ones(1,devnumber);
AO.(ifam).Imax = -249*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLEQ10
ifam = 'CycleQ10';
ifamQ = 'Q10';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'CycleQP'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/Q','/cycleQ');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = 249*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLEQ11
ifam = 'CycleQ11';
ifamQ = 'Q11';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'CycleQP'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/Q','/cycleQ');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = 2; %length(AO.(ifam).ElementList);
AO.(ifam).Imax = -274*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'K';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLEQ12
ifam = 'CycleQ12';
ifamQ = 'Q12';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'CycleQP'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/Q','/cycleQ');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = 1; % length(AO.(ifam).ElementList);
AO.(ifam).Imax = 274*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLEQC13
ifam = 'CycleQC13';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam;'CycleQP'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
%dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = {'ANS-C13/AE/cycleQ1'; 'ANS-C13/AE/cycleQ2'; 'ANS-C13/AE/cycleQ3';  'ANS-C13/AE/cycleQ4.1';
    'ANS-C13/AE/cycleQ5.1'; 'ANS-C13/AE/cycleQ5.2'; 'ANS-C13/AE/cycleQ4.2'; ...
    'ANS-C13/AE/cycleQ6'; 'ANS-C13/AE/cycleQ7'; 'ANS-C13/AE/cycleQ8' };
AO.(ifam).DeviceList             = [13 1; 13 2; 13 3; 13 4; 13 5; 13 6; 13 7; 13 8; 13 9; 13 10];
AO.(ifam).ElementList            = (1:10)';
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId                = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = 249*[-1 1 -1 -1 1 1 -1 -1 1 -1];
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% cycleramp for sextupole magnets
%% CYCLES1
ifam = 'CycleS1';
ifamQ = 'S1';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId        = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = 349*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLES2
ifam = 'CycleS2';
ifamQ = 'S2';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId        = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = -349*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLES3
ifam = 'CycleS3';
ifamQ = 'S3';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId        = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = -349*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLES4
ifam = 'CycleS4';
ifamQ = 'S4';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId        = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = 349*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLES5
ifam = 'CycleS5';
ifamQ = 'S5';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId        = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = -349*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLES6
ifam = 'CycleS6';
ifamQ = 'S6';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId        = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = 349*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLES7
ifam = 'CycleS7';
ifamQ = 'S7';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId        = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = -349*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLES8
ifam = 'CycleS8';
ifamQ = 'S8';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId        = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = 349*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLES9
ifam = 'CycleS9';
ifamQ = 'S9';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = family2dev(ifamQ);
AO.(ifam).ElementList            = family2elem(ifamQ);
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId        = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = -349*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% CYCLES10
ifam = 'CycleS10';
ifamQ = 'S10';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = AO.(ifamQ).DeviceList;
AO.(ifam).ElementList            = AO.(ifamQ).ElementList;
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId        = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = 349*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');


%% CYCLES11
ifam = 'CycleS11';
ifamQ = 'S11';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = AO.(ifamQ).DeviceList;
AO.(ifam).ElementList            = AO.(ifamQ).ElementList;
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId        = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = 274*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');


%% CYCLES12
ifam = 'CycleS12';
ifamQ = 'S12';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {ifam; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
dev = getfamilydata(ifamQ,'DeviceName');
AO.(ifam).DeviceName             = regexprep(dev,'/S','/cycleS');
AO.(ifam).DeviceList             = AO.(ifamQ).DeviceList;
AO.(ifam).ElementList            = AO.(ifamQ).ElementList;
if ControlRoomFlag
        %add devices to group
        AO.(ifam).GroupId        = tango_group_create(ifam);
        tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
else
    AO.(ifam).GroupId = nan;
end
devnumber = length(AO.(ifam).ElementList);
AO.(ifam).Imax = -274*ones(1,devnumber);
AO.(ifam).Status = ones(devnumber,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(devnumber,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'rad';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%============
%% RF System
%============
ifam = 'RF';
AO.(ifam).FamilyName                = ifam;
AO.(ifam).FamilyType                = 'RF';
AO.(ifam).MemberOf                  = {'RF','RFSystem'};
AO.(ifam).Status                    = 1;
AO.(ifam).CommonNames               = 'RF';
AO.(ifam).DeviceList                = [1 1];
AO.(ifam).ElementList               = 1;
AO.(ifam).DeviceName(:,:)           = {'ANS/RF/MasterClock/'};

%Frequency Readback
AO.(ifam).Monitor.Mode                = Mode;
% AO.(ifam).Monitor.Mode                = 'Special';
% AO.(ifam).Monitor.SpecialFunctionGet = 'getrf2';
AO.(ifam).Monitor.DataType            = 'Scalar';
AO.(ifam).Monitor.Units               = 'Hardware';
AO.(ifam).Monitor.HW2PhysicsParams    = 1e+6;       %no hw2physics function necessary
AO.(ifam).Monitor.Physics2HWParams    = 1e-6;
AO.(ifam).Monitor.HWUnits             = 'MHz';
AO.(ifam).Monitor.PhysicsUnits        = 'Hz';
AO.(ifam).Monitor.TangoNames          = {'ANS/RF/MasterClock/frequency'};
AO.(ifam).Monitor.Handles             = NaN;
AO.(ifam).Monitor.Range               = [351 353];

AO.(ifam).Setpoint = AO.(ifam).Monitor;
AO.(ifam).Desired  = AO.(ifam).Monitor;


%============
%% CM Cryomodules System
%=========
if ControlRoomFlag
    disp('CRYOmodule ...')
    ifam = 'CM';
    %Voltage control
    AO.(ifam).FamilyName                = ifam;
    AO.(ifam).FamilyType                = ifam;
    AO.(ifam).MemberOf                  = {ifam,'RFSystem'};
    AO.(ifam).Monitor.Mode               = Mode;
    AO.(ifam).Monitor.DataType           = 'Scalar';
    AO.(ifam).Monitor.Units              = 'Hardware';
    AO.(ifam).Monitor.HWUnits            = 'Volts';
    AO.(ifam).Monitor.PhysicsUnits       = 'Volts';
    
    varlist = {
        1  [ 2  1] 'ANS-C02/RF/LLE.3' 1 'CAV3' [0  2000]
        2  [ 2  2] 'ANS-C02/RF/LLE.4' 1 'CAV4' [0  2000]
        3  [ 3  1] 'ANS-C03/RF/LLE.1' 1 'CAV1' [0  2000]
        4  [ 3  2] 'ANS-C03/RF/LLE.2' 1 'CAV2' [0  2000]
        };
    
    devnumber = size(varlist,1);
    
    % preallocation
    AO.(ifam).ElementList = zeros(devnumber,1);
    AO.(ifam).Status      = zeros(devnumber,1);
    AO.(ifam).DeviceName  = cell(devnumber,1);
    AO.(ifam).CommonNames = cell(devnumber,1);
    AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
    AO.(ifam).Monitor.HW2PhysicsParams(:,:) = 1*ones(devnumber,1);
    AO.(ifam).Monitor.Physics2HWParams(:,:) = 1*ones(devnumber,1);
    AO.(ifam).Monitor.Handles(:,1)          = NaN*ones(devnumber,1);
    AO.(ifam).Monitor.DataType              = 'Scalar';
    

    for k = 1: devnumber,
        AO.(ifam).ElementList(k)  = varlist{k,1};
        AO.(ifam).DeviceList(k,:) = varlist{k,2};
        AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
        AO.(ifam).Status(k)       = varlist{k,4};
        AO.(ifam).CommonNames(k)  = deblank(varlist(k,5));
        AO.(ifam).Monitor.TangoNames{k}  = strcat(AO.(ifam).DeviceName{k}, '/voltageRF');
        AO.(ifam).Monitor.Range   = varlist{k,6};
    end

    AO.(ifam).Monitor.Tolerance          = inf*ones(devnumber,1);
    AO.(ifam).Monitor.Handles            = NaN*ones(devnumber,1);
    
    AO.(ifam).Setpoint = AO.(ifam).Monitor;
    AO.(ifam).Desired  = AO.(ifam).Monitor;
    
    AO.(ifam).Phase  = AO.(ifam).Monitor;
    AO.(ifam).Phase.TangoNames(:,:) = strcat(AO.(ifam).DeviceName,'/phaseCavityConsign');

    dummy = {...
        'ANS-C02/RF/CAV.3', 'ANS-C02/RF/CAV.4', ...
        'ANS-C03/RF/CAV.1', 'ANS-C03/RF/CAV.2',...
        };

    AO.(ifam).Pr = AO.(ifam).Monitor;
    AO.(ifam).Pr.TangoNames(:,:) = strcat(dummy,'/reflectedCavityPower');
    
    AO.(ifam).Pi = AO.(ifam).Monitor;
    AO.(ifam).Pi.TangoNames(:,:) = strcat(dummy,'/incidentCavityPower');

    AO.(ifam).Pressure = AO.(ifam).Monitor;
    AO.(ifam).Pressure.TangoNames(:,:) = strcat(dummy,'/vacuum');

    AO.(ifam).He = AO.(ifam).Monitor;
    AO.(ifam).He.TangoNames(:,:) = strcat(dummy,'/heliumLevel');

    % %Power Control
    % AO.(ifam).PowerCtrl.Mode               = Mode;
    % AO.(ifam).PowerCtrl.DataType           = 'Scalar';
    % AO.(ifam).PowerCtrl.Units              = 'Hardware';
    % AO.(ifam).PowerCtrl.HW2PhysicsParams   = 1;
    % AO.(ifam).PowerCtrl.Physics2HWParams   = 1;
    % AO.(ifam).PowerCtrl.HWUnits            = 'MWatts';
    % AO.(ifam).PowerCtrl.PhysicsUnits       = 'MWatts';
    % AO.(ifam).PowerCtrl.ChannelNames       = 'SRF1:KLYSDRIVFRWD:POWER:ON';
    % AO.(ifam).PowerCtrl.Range              = [-inf inf];
    % AO.(ifam).PowerCtrl.Tolerance          = inf;
    % AO.(ifam).PowerCtrl.Handles            = NaN;
    %
    % %Power Monitor
    % AO.(ifam).Power.Mode               = Mode;
    % AO.(ifam).Power.DataType           = 'Scalar';
    % AO.(ifam).Power.Units              = 'Hardware';
    % AO.(ifam).Power.HW2PhysicsParams   = 1;
    % AO.(ifam).Power.Physics2HWParams   = 1;
    % AO.(ifam).Power.HWUnits            = 'MWatts';
    % AO.(ifam).Power.PhysicsUnits       = 'MWatts';
    % AO.(ifam).Power.ChannelNames       = 'SRF1:KLYSDRIVFRWD:POWER';
    % AO.(ifam).Power.Range              = [-inf inf];
    % AO.(ifam).Power.Tolerance          = inf;
    % AO.(ifam).Power.Handles            = NaN;
    %
    % %Station Phase Control
    % AO.(ifam).PhaseCtrl.Mode               = Mode;
    % AO.(ifam).PhaseCtrl.DataType           = 'Scalar';
    % AO.(ifam).PhaseCtrl.Units              = 'Hardware';
    % AO.(ifam).PhaseCtrl.HW2PhysicsParams   = 1;
    % AO.(ifam).PhaseCtrl.Physics2HWParams   = 1;
    % AO.(ifam).PhaseCtrl.HWUnits            = 'Degrees';
    % AO.(ifam).PhaseCtrl.PhysicsUnits       = 'Degrees';
    % AO.(ifam).PhaseCtrl.ChannelNames       = 'SRF1:STN:PHASE';
    % AO.(ifam).PhaseCtrl.Range              = [-200 200];
    % AO.(ifam).PhaseCtrl.Tolerance          = inf;
    % AO.(ifam).PhaseCtrl.Handles            = NaN;
    %
    % %Station Phase Monitor
    % AO.(ifam).Phase.Mode               = Mode;
    % AO.(ifam).Phase.DataType           = 'Scalar';
    % AO.(ifam).Phase.Units              = 'Hardware';
    % AO.(ifam).Phase.HW2PhysicsParams   = 1;
    % AO.(ifam).Phase.Physics2HWParams   = 1;
    % AO.(ifam).Phase.HWUnits            = 'Degrees';
    % AO.(ifam).Phase.PhysicsUnits       = 'Degrees';
    % AO.(ifam).Phase.ChannelNames       = 'SRF1:STN:PHASE:CALC';
    % AO.(ifam).Phase.Range              = [-200 200];
    % AO.(ifam).Phase.Tolerance          = inf;
    % AO.(ifam).Phase.Handles            = NaN;
end

%=======
%% CHROMATICITIES: Soft Family
%=======
ifam = 'CHRO';
AO.(ifam).FamilyName  = ifam;
AO.(ifam).FamilyType  = 'Diagnostic';
AO.(ifam).MemberOf    = {'Diagnostics', 'CHRO'};
AO.(ifam).CommonNames = ['xix';'xiz'];
AO.(ifam).DeviceList  = [ 1 1; 1 2;];
AO.(ifam).ElementList = [1; 2];
AO.(ifam).Status      = [1; 1];

%======
%% Dipole B-FIELD from RMN probe
%======
ifam = 'RMN';
AO.(ifam).FamilyName                     = ifam;
AO.(ifam).FamilyType                     = 'EM';
AO.(ifam).MemberOf                       = {'EM',ifam};
AO.(ifam).CommonNames                    = ifam;
AO.(ifam).DeviceList                     = [1 1];
AO.(ifam).ElementList                    = 1;
AO.(ifam).Status                         = AO.(ifam).ElementList;

AO.(ifam).Monitor.Mode                   = Mode;
AO.(ifam).Monitor.DataType               = 'Scalar';
AO.(ifam).Monitor.TangoNames             = 'ANS-C13/EM/RMN/magneticField'; %afin de ne pas avoir de bug
AO.(ifam).Monitor.Units                  = 'Hardware';
AO.(ifam).Monitor.Handles                = NaN;
AO.(ifam).Monitor.HWUnits                = 'mGauss';
AO.(ifam).Monitor.PhysicsUnits           = 'T';
AO.(ifam).Monitor.HW2PhysicsParams       = 1;
AO.(ifam).Monitor.Physics2HWParams       = 1;

%=======
%% TUNE
%=======
ifam = 'TUNE';
AO.(ifam).FamilyName  = ifam;
AO.(ifam).FamilyType  = 'Diagnostic';
AO.(ifam).MemberOf    = {'Diagnostics', 'TUNE'};
AO.(ifam).CommonNames = ['nux';'nuz';'nus'];
AO.(ifam).DeviceList  = [1 1; 1 2; 1 3];
AO.(ifam).ElementList = [1 2 3]';
AO.(ifam).Status      = [1 1 1]';

AO.(ifam).Monitor.Mode                   = Mode; %'Simulator';  % Mode;
AO.(ifam).Monitor.DataType               = 'Scalar';
AO.(ifam).Monitor.DataTypeIndex          = [1 2];
AO.(ifam).Monitor.TangoNames             = ['ANS/DG/BPM-TUNEX/Nu';'ANS/DG/BPM-TUNEZ/Nu';'ANS/DG/BPM-TUNEZ/Nu'];
AO.(ifam).Monitor.Units                  = 'Hardware';
AO.(ifam).Monitor.Handles                = NaN;
AO.(ifam).Monitor.HW2PhysicsParams       = 1;
AO.(ifam).Monitor.Physics2HWParams       = 1;
AO.(ifam).Monitor.HWUnits                = 'fractional tune';
AO.(ifam).Monitor.PhysicsUnits           = 'fractional tune';


%=======
%% TUNEFBT
%=======
ifam = 'TUNEFBT';
AO.(ifam).FamilyName  = ifam;
AO.(ifam).FamilyType  = 'Diagnostic';
AO.(ifam).MemberOf    = {'Diagnostics'};
AO.(ifam).CommonNames = ['nux';'nuz'];
AO.(ifam).DeviceList  = [1 1; 1 2];
AO.(ifam).ElementList = [1 2]';
AO.(ifam).Status      = [1 1]';

AO.(ifam).Monitor.Mode                   = Mode; %'Simulator';  % Mode;
AO.(ifam).Monitor.DataType               = 'Scalar';
AO.(ifam).Monitor.DataTypeIndex          = [1 2];
AO.(ifam).Monitor.TangoNames             = ['ANS/RF/BBFDataViewer.1-TUNEX/Nu';'ANS/RF/BBFDataViewer.2-TUNEZ/Nu'];
AO.(ifam).Monitor.Units                  = 'Hardware';
AO.(ifam).Monitor.Handles                = NaN;
AO.(ifam).Monitor.HW2PhysicsParams       = 1;
AO.(ifam).Monitor.Physics2HWParams       = 1;
AO.(ifam).Monitor.HWUnits                = 'fractional tune';
AO.(ifam).Monitor.PhysicsUnits           = 'fractional tune';

%=======
%% Coupling
%=======
ifam = 'COUPLING';
AO.(ifam).FamilyName  = ifam;
AO.(ifam).FamilyType  = 'Diagnostic';
AO.(ifam).MemberOf    = {'Diagnostics'};
AO.(ifam).CommonNames = 'chi';
AO.(ifam).DeviceList  = [2 1];
AO.(ifam).ElementList = 1;
AO.(ifam).Status      = 1;

AO.(ifam).Monitor.Mode                   = Mode; %'Simulator';  % Mode;
AO.(ifam).Monitor.DataType               = 'Scalar';
%AO.(ifam).Monitor.DataTypeIndex          = [1 2];
AO.(ifam).Monitor.TangoNames             = 'ANS-C02/DG/PHC-EMIT/Coupling';
AO.(ifam).Monitor.Units                  = 'Hardware';
AO.(ifam).Monitor.Handles                = NaN;
AO.(ifam).Monitor.HW2PhysicsParams       = 0.01;
AO.(ifam).Monitor.Physics2HWParams       = 1;
AO.(ifam).Monitor.HWUnits                = '%';
AO.(ifam).Monitor.PhysicsUnits           = 'absolute';

%======
%% DCCT
%======
ifam = 'DCCT';
AO.(ifam).FamilyName                     = ifam;
AO.(ifam).FamilyType                     = 'Diagnostic';
AO.(ifam).MemberOf                       = {'Diagnostics','DCCT'};
AO.(ifam).CommonNames                    = 'DCCT';
AO.(ifam).DeviceList                     = [1 1];
AO.(ifam).ElementList                    = 1;
AO.(ifam).Status                         = AO.(ifam).ElementList;

AO.(ifam).Monitor.Mode                   = Mode;
AO.(ifam).FamilyName                     = 'DCCT';
AO.(ifam).Monitor.DataType               = 'Scalar';
AO.(ifam).Monitor.TangoNames             = 'ANS/DG/DCCT-CTRL/current'; %afin de ne pas avoir de bug
AO.(ifam).Monitor.Units                  = 'Hardware';
AO.(ifam).Monitor.Handles                = NaN;
AO.(ifam).Monitor.HWUnits                = 'mA';
AO.(ifam).Monitor.PhysicsUnits           = 'A';
AO.(ifam).Monitor.HW2PhysicsParams       = 1;
AO.(ifam).Monitor.Physics2HWParams       = 1;

% On une famille ???
ifam = 'DCCT1';
AO.(ifam).FamilyName                     = ifam;
AO.(ifam).FamilyType                     = 'Diagnostic';
AO.(ifam).MemberOf                       = {'Diagnostics','DCCT'};
AO.(ifam).CommonNames                    = 'DCCT1';
AO.(ifam).DeviceList                     = [1 1];
AO.(ifam).ElementList                    = 1;
AO.(ifam).Status                         = AO.(ifam).ElementList;

AO.(ifam).Monitor.Mode                   = Mode;
AO.(ifam).FamilyName                     = 'DCCT';
AO.(ifam).Monitor.DataType               = 'Scalar';
AO.(ifam).Monitor.TangoNames              = 'ANS-C03/DG/DCCT/current'; %afin de ne pas avoir de bug
AO.(ifam).Monitor.Units                  = 'Hardware';
AO.(ifam).Monitor.Handles                = NaN;
AO.(ifam).Monitor.HWUnits                = 'mA';
AO.(ifam).Monitor.PhysicsUnits           = 'A';
AO.(ifam).Monitor.HW2PhysicsParams       = 1;
AO.(ifam).Monitor.Physics2HWParams       = 1;

ifam = 'DCCT2';
AO.(ifam).FamilyName                     = ifam;
AO.(ifam).FamilyType                     = 'Diagnostic';
AO.(ifam).MemberOf                       = {'Diagnostics','DCCT'};
AO.(ifam).CommonNames                    = 'ANS-C14/DG/DCCT';
AO.(ifam).DeviceList                     = [1 1];
AO.(ifam).ElementList                    = 1;
AO.(ifam).Status                         = AO.(ifam).ElementList;

AO.(ifam).Monitor.Mode                   = Mode;
AO.(ifam).FamilyName                     = 'DCCT';
AO.(ifam).Monitor.DataType               = 'Scalar';
AO.(ifam).Monitor.TangoNames             = 'ANS-C03/DG/DCCT/current'; %afin de ne pas avoir de bug
AO.(ifam).Monitor.Units                  = 'Hardware';
AO.(ifam).Monitor.Handles                = NaN;
AO.(ifam).Monitor.HWUnits                = 'mA';
AO.(ifam).Monitor.PhysicsUnits           = 'A';
AO.(ifam).Monitor.HW2PhysicsParams       = 1;
AO.(ifam).Monitor.Physics2HWParams       = 1;

%======
%% Lifetime
%======

ifam = 'LifeTime';
AO.(ifam).FamilyName                     = ifam;
AO.(ifam).FamilyType                     = 'Diagnostic';
AO.(ifam).MemberOf                       = {'Diagnostics','DCCT'};
AO.(ifam).CommonNames                    = 'LifeTime';
AO.(ifam).DeviceList                     = [1 1];
AO.(ifam).ElementList                    = 1;
AO.(ifam).Status                         = AO.(ifam).ElementList;

AO.(ifam).Monitor.Mode                   = Mode;
AO.(ifam).FamilyName                     = 'LifeTime';
AO.(ifam).Monitor.DataType               = 'Scalar';
AO.(ifam).Monitor.TangoNames             = 'ANS/DG/DCCT-CTRL/lifeTime'; %afin de ne pas avoir de bug
AO.(ifam).Monitor.Units                  = 'Hardware';
AO.(ifam).Monitor.Handles                = NaN;
AO.(ifam).Monitor.HWUnits                = 'Hours';
AO.(ifam).Monitor.PhysicsUnits           = 'Hours';
AO.(ifam).Monitor.HW2PhysicsParams       = 1;
AO.(ifam).Monitor.Physics2HWParams       = 1;

if ControlRoomFlag
    
    %%%%%%%%%%%%%%%%%%
    %% Alignment
    %%%%%%%%%%%%%%%%%%
    
    disp('aligment configuration ...')
    
    %% HLS
    ifam = 'HLS';
    AO.(ifam).FamilyName           = ifam;
    AO.(ifam).FamilyType           = ifam;
    AO.(ifam).MemberOf             = {'PlotFamily'; 'Alignment'; 'HLS'; 'Archivable'};
    AO.(ifam).Monitor.Mode         = Mode;
    AO.(ifam).Monitor.DataType     = 'Scalar';
    
    map       = tango_get_db_property('anneau','HLS');
    cellindex = cell2mat(regexpi(map,'C[0-9]','once'))+1;
    %numindex  = cell2mat(regexpi(map,'\.[0-9]','once'))+1;
    
    % builds up devicelist
    devnumber = size(map,2);
    ik = 0; cellnum = 1;
    for k = 1:devnumber,
        if cellnum - str2double(map{k}(cellindex(k):cellindex(k)+1)) ~=0
            ik = 1;
        else
            ik = ik+1;
        end
        cellnum = str2double(map{k}(cellindex(k):cellindex(k)+1));
        AO.(ifam).DeviceList(k,:)  = [cellnum ik];
        AO.(ifam).CommonNames(k,:)      = map{k}(12:17);
    end
    
    AO.(ifam).ElementList = (1:devnumber)';
    
    AO.(ifam).Status                   = ones(devnumber,1);
    AO.(ifam).DeviceName               = map';
    AO.(ifam).ElementList              = (1:devnumber)';
    AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(devnumber,1);
    AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/height');
    AO.(ifam).Monitor.HW2PhysicsParams = 1;
    AO.(ifam).Monitor.Physics2HWParams = 1;
    AO.(ifam).Monitor.Units            = 'Hardware';
    AO.(ifam).Monitor.HWUnits          = 'mm';
    AO.(ifam).Monitor.PhysicsUnits     = 'm';
    %AO.(ifam).Position = (1:168)'/168*354;
    
    AO.(ifam).Position = [6.000 7.370 9.270 10.323 12.549 14.775 15.828 17.178 18.548 25.512 27.272 28.232 29.284 30.244 31.241 35.051 36.047 37.007 38.059 39.019 40.779 50.262 51.632 53.532 54.585 56.811 59.037 60.090 61.440 62.810 69.774 71.534 72.494 73.546 74.506 75.503 79.313 80.309 81.269 82.322 83.282 85.042 94.524 95.894 97.794 98.847 101.073 103.299 104.352 105.702 107.072 114.036 115.796 116.756 117.809 118.769 119.765 123.575 124.571 125.531 126.584 127.544 129.304 138.786 140.156 142.056 143.109 145.335 147.561 148.614 149.964 151.334 158.298 160.058 161.018 162.071 163.031 164.027 167.837 168.833 169.793 170.846 171.806 173.566 183.049 184.419 186.319 187.371 189.597 191.824 192.876 194.226 195.596 202.560 204.320 205.280 206.333 207.293 208.289 212.099 213.095 214.055 215.108 216.068 217.828 227.311 228.681 230.581 231.633 233.859 236.086 237.138 238.488 239.858 246.822 248.582 249.542 250.595 251.555 252.551 256.361 257.357 258.317 259.370 260.330 262.090 271.573 272.943 274.843 275.895 278.121 280.348 281.400 282.750 284.120 291.085 292.845 293.805 294.857 295.817 296.813 300.623 301.620 302.580 303.632 304.592 306.352 315.835 317.205 319.105 320.157 322.384 324.610 325.662 327.012 328.382 335.347 337.107 338.067 339.119 340.079 341.075 344.885 345.882 346.842 347.894 348.854 350.614];
    AO.(ifam).Position = AO.(ifam).Position(:);
    
    AO.(ifam).Mean = AO.(ifam).Monitor;
    AO.(ifam).Mean.TangoNames       = strcat(AO.(ifam).DeviceName, '/average');
    AO.(ifam).Mean.MemberOf = {'Plotfamily'};
    
    AO.(ifam).Std = AO.(ifam).Monitor;
    AO.(ifam).Std.TangoNames       = strcat(AO.(ifam).DeviceName, '/standardDeviation');
    AO.(ifam).Std.MemberOf = {'Plotfamily'};
    
    AO.(ifam).Voltage = AO.(ifam).Monitor;
    AO.(ifam).Voltage.TangoNames       = strcat(AO.(ifam).DeviceName, '/voltage');
    AO.(ifam).Voltage.MemberOf = {'Plotfamily'};
    
end
%%%%%%%%%%%%%%%%%%
%% AVLS GEOPHONES
%%%%%%%%%%%%%%%%%%

ifam = 'GEO'; % vibration
AO.(ifam).FamilyName           = ifam;
AO.(ifam).MemberOf             = {'PlotFamily'; 'VIB'; 'Archivable'};
AO.(ifam).Monitor.Mode         = Mode;
AO.(ifam).Monitor.DataType     = 'Scalar';

varlist = {
    1  [ 1  1] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_C09_Q5_X'
    2  [ 1  2] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_C09_Q5_Z'
    3  [ 1  3] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_C09_BPM4_X'
    4  [ 1  4] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_C09_BPM4_Z'
    5  [ 1  5] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_C10_BPM1_X'
    6  [ 1  6] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_C10_BPM1_Z'
    7  [ 1  7] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_TDL_D09-2_XBPM_Z'
    8  [ 1  8] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_TDL_I10_XBPM_Z'
    9  [ 1  9] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_HALL_I10C_X'
    10  [ 1 10] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_HALL_I10C_Z'
    11  [ 1 11] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_HALL_I02C_X'
    12  [ 1 12] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_HALL_I02C_Z'
    13  [ 1 13] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_EXT_D306_X'
    14  [ 1 14] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_EXT_D306_Z'
    15  [ 1 15] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_EXT_T3_X'
    16  [ 1 16] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_EXT_T3_Z'
    };

devnumber = length(varlist);

% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
AO.(ifam).RMS.TangoNames  = cell(devnumber,1);

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,6));
    AO.(ifam).Monitor.TangoNames(k)  = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,6)), '_PEAK');
    AO.(ifam).RMS.TangoNames(k)      = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,6)), '_RMS');
end

% peak values
AO.(ifam).Monitor.HW2PhysicsParams = 1;
AO.(ifam).Monitor.Physics2HWParams = 1;
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'm';
AO.(ifam).Monitor.PhysicsUnits     = 'm';
AO.(ifam).Monitor.MemberOf         = {'Plotfamily'};
AO.(ifam).Position                 = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);

%rms values
AO.(ifam).RMS.HW2PhysicsParams = 1;
AO.(ifam).RMS.Physics2HWParams = 1;
AO.(ifam).RMS.Units            = 'Hardware';
AO.(ifam).RMS.HWUnits          = 'm';
AO.(ifam).RMS.PhysicsUnits     = 'm';
AO.(ifam).RMS.MemberOf = {'Plotfamily'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AVLS GEOPHONES PEAK VALUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%

ifam = 'PEAKGEO'; % vibration
AO.(ifam).FamilyName           = ifam;
AO.(ifam).MemberOf             = {'PlotFamily'; 'VIB'; 'Archivable'};
AO.(ifam).Monitor.Mode         = Mode;
AO.(ifam).Monitor.DataType     = 'Scalar';

varlist = {
    1  [ 1  1] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_C09_Q5_X_PEAK'
    2  [ 1  2] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_C09_Q5_Z_PEAK'
    3  [ 1  3] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_C09_BPM4_X_PEAK'
    4  [ 1  4] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_C09_BPM4_Z_PEAK'
    5  [ 1  5] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_C10_BPM1_X_PEAK'
    6  [ 1  6] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_C10_BPM1_Z_PEAK'
    7  [ 1  7] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_TDL_D09-2_XBPM_Z_PEAK'
    8  [ 1  8] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_TDL_I10_XBPM_Z_PEAK'
    9  [ 1  9] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_HALL_I10C_X_PEAK'
    10  [ 1 10] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_HALL_I10C_Z_PEAK'
    11  [ 1 11] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_HALL_I02C_X_PEAK'
    12  [ 1 12] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_HALL_I02C_Z_PEAK'
    13  [ 1 13] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_EXT_D306_X_PEAK'
    14  [ 1 14] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_EXT_D306_Z_PEAK'
    15  [ 1 15] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_EXT_T3_X_PEAK'
    16  [ 1 16] 'ANS/DG/SURVIB_DATA.1' 1 'GEOPH01' 'GEOPHONE_EXT_T3_Z_PEAK'
    };

devnumber = length(varlist);

% preallocation
AO.(ifam).ElementList = zeros(devnumber,1);
AO.(ifam).Status      = zeros(devnumber,1);
AO.(ifam).DeviceName  = cell(devnumber,1);
AO.(ifam).CommonNames = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);

for k = 1: devnumber,
    AO.(ifam).ElementList(k)  = varlist{k,1};
    AO.(ifam).DeviceList(k,:) = varlist{k,2};
    AO.(ifam).DeviceName(k)   = deblank(varlist(k,3));
    AO.(ifam).Status(k)       = varlist{k,4};
    AO.(ifam).CommonNames(k)  = deblank(varlist(k,6));
    AO.(ifam).Monitor.TangoNames(k)  = strcat(AO.(ifam).DeviceName{k}, '/', deblank(varlist(k,6)));
end

AO.(ifam).Monitor.HW2PhysicsParams = 1;
AO.(ifam).Monitor.Physics2HWParams = 1;
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'm/sqrt(Hz)';
AO.(ifam).Monitor.PhysicsUnits     = 'm/sqrt(Hz)';
AO.(ifam).Position                 = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);



%%%%%%%%%%%%%%%%%%
%% VACUUM SYSTEM
%%%%%%%%%%%%%%%%%%
if ControlRoomFlag
    
    disp('vacuum configuration ...')
    
    %% IonPump
    ifam = 'PI';
    AO.(ifam).FamilyName           = 'PI';
    AO.(ifam).FamilyType           = 'PI';
    AO.(ifam).MemberOf             = {'PlotFamily'; 'IonPump'; 'Pressure'; 'Archivable';};
    AO.(ifam).Monitor.Mode         = Mode;
    AO.(ifam).Monitor.DataType     = 'Scalar';
    
    map       = tango_get_db_property('anneau','pompe_ionique');
    cellindex = cell2mat(regexpi(map,'C[0-9]','once'))+1;
    numindex  = cell2mat(regexpi(map,'\.[0-9]','once'))+1;
    
    
    devnumber = size(map,2);
    for k = 1:devnumber,
        AO.(ifam).DeviceList(k,:)  = [str2double(map{k}(cellindex(k):cellindex(k)+1)) str2double(map{k}(numindex(k):end))];
    end
    
    AO.(ifam).ElementList = (1:devnumber)';
    
    
    AO.(ifam).Status                   = ones(devnumber,1);
    AO.(ifam).DeviceName               = map';
    AO.(ifam).CommonNames              = [repmat('PI',devnumber,1) num2str((1:devnumber)','%02d')];
    AO.(ifam).ElementList              = (1:devnumber)';
    AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(devnumber,1);
    AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/pressure');
    AO.(ifam).Monitor.HW2PhysicsParams = 1;
    AO.(ifam).Monitor.Physics2HWParams = 1;
    AO.(ifam).Monitor.Units            = 'Hardware';
    AO.(ifam).Monitor.HWUnits          = 'mbar';
    AO.(ifam).Monitor.PhysicsUnits     = 'mbar';
    AO.(ifam).Position                 = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);
    
    %% Penning Gauges
    ifam = 'JPEN';
    AO.(ifam).FamilyName           = 'JPEN';
    AO.(ifam).MemberOf             = {'PlotFamily'; 'PenningGauge'; 'Pressure'; 'Archivable';'PlotFamily'};
    AO.(ifam).Monitor.Mode         = Mode;
    AO.(ifam).Monitor.DataType     = 'Scalar';
    
    map     = tango_get_db_property('anneau','jauge_penning');
    cellindex = cell2mat(regexpi(map,'C[0-9]','once'))+1;
    numindex  = cell2mat(regexpi(map,'\.[0-9]','once'))+1;
    
    devnumber = size(map,2);
    for k = 1:devnumber,
        AO.(ifam).DeviceList(k,:)  = [str2double(map{k}(cellindex(k):cellindex(k)+1)) str2double(map{k}(numindex(k):end))];
    end
    
    AO.(ifam).ElementList = (1:devnumber)';
    
    AO.(ifam).Status                   = ones(devnumber,1);
    AO.(ifam).DeviceName               = map';
    AO.(ifam).CommonNames              = [repmat('JPEN',devnumber,1) num2str((1:devnumber)','%02d')];
    AO.(ifam).ElementList              = (1:devnumber)';
    AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(devnumber,1);
    AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/pressure');
    AO.(ifam).Monitor.HW2PhysicsParams = 1;
    AO.(ifam).Monitor.Physics2HWParams = 1;
    AO.(ifam).Monitor.Units            = 'Hardware';
    AO.(ifam).Monitor.HWUnits          = 'mbar';
    AO.(ifam).Monitor.PhysicsUnits     = 'mbar';
    AO.(ifam).Position                 = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);
    
    %% Pirani Gauges
    ifam = 'JPIR';
    AO.(ifam).FamilyName           = 'JPIR';
    AO.(ifam).MemberOf             = {'PlotFamily'; 'PiraniGauge'; 'Pressure'; 'Archivable';'PlotFamily'};
    AO.(ifam).Monitor.Mode         = Mode;
    AO.(ifam).Monitor.DataType     = 'Scalar';
    
    map     = tango_get_db_property('anneau','jauge_piranni');
    cellindex = cell2mat(regexpi(map,'C[0-9]','once'))+1;
    numindex  = cell2mat(regexpi(map,'\.[0-9]','once'))+1;
    
    devnumber = size(map,2);
    for k = 1:devnumber,
        AO.(ifam).DeviceList(k,:)  = [str2double(map{k}(cellindex(k):cellindex(k)+1)) str2double(map{k}(numindex(k):end))];
    end
    
    AO.(ifam).Status                   = ones(devnumber,1);
    AO.(ifam).DeviceName               = map';
    AO.(ifam).CommonNames              = [repmat('JPIR',devnumber,1) num2str((1:devnumber)','%02d')];
    AO.(ifam).ElementList              = (1:devnumber)';
    AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(devnumber,1);
    AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/pressure');
    AO.(ifam).Monitor.HW2PhysicsParams = 1;
    AO.(ifam).Monitor.Physics2HWParams = 1;
    AO.(ifam).Monitor.Units            = 'Hardware';
    AO.(ifam).Monitor.HWUnits          = 'mbar';
    AO.(ifam).Monitor.PhysicsUnits     = 'mbar';
    
    %% Bayer Albert Gauges
    ifam = 'JBA';
    AO.(ifam).FamilyName           = ifam;
    AO.(ifam).MemberOf             = {'PlotFamily'; 'PiraniGauge'; 'Pressure'; 'Archivable';'PlotFamily'};
    AO.(ifam).Monitor.Mode         = Mode;
    AO.(ifam).Monitor.DataType     = 'Scalar';
    
    map     = tango_get_db_property('anneau','jauge_bayer_alpert');
    cellindex = cell2mat(regexpi(map,'C[0-9]','once'))+1;
    numindex  = cell2mat(regexpi(map,'\.[0-9]','once'))+1;
    
    devnumber = size(map,2);
    for k = 1:devnumber,
        AO.(ifam).DeviceList(k,:)  = [str2double(map{k}(cellindex(k):cellindex(k)+1)) str2double(map{k}(numindex(k):end))];
    end
    
    AO.(ifam).Status                   = ones(devnumber,1);
    AO.(ifam).DeviceName               = map';
    AO.(ifam).CommonNames              = [repmat(ifam,devnumber,1) num2str((1:devnumber)','%02d')];
    AO.(ifam).ElementList              = (1:devnumber)';
    AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(devnumber,1);
    AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/pressure');
    AO.(ifam).Monitor.HW2PhysicsParams = 1;
    AO.(ifam).Monitor.Physics2HWParams = 1;
    AO.(ifam).Monitor.Units            = 'Hardware';
    AO.(ifam).Monitor.HWUnits          = 'mbar';
    AO.(ifam).Monitor.PhysicsUnits     = 'mbar';
    AO.(ifam).Position                 = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);
    
    %% Thermocouples
    ifam = 'TC';
    AO.(ifam).FamilyName           = ifam;
    AO.(ifam).MemberOf             = {'PlotFamily'; 'TC'; 'Archivable';'PlotFamily'};
    AO.(ifam).Monitor.Mode         = Mode;
    AO.(ifam).Monitor.DataType     = 'Scalar';
    
    map     = tango_get_db_property('anneau','thermocouple');
    cellindex = cell2mat(regexpi(map,'C[0-9]','once'))+1;
    numindex  = cell2mat(regexpi(map,'\.[0-9]','once'))+1;
    
    devnumber = size(map,2);
    for k = 1:devnumber,
        AO.(ifam).DeviceList(k,:)  = [str2double(map{k}(cellindex(k):cellindex(k)+1)) str2double(map{k}(numindex(k):end))];
    end
    
    AO.(ifam).Status                   = ones(devnumber,1);
    AO.(ifam).DeviceName               = map';
    AO.(ifam).CommonNames              = [repmat(ifam,devnumber,1) num2str((1:devnumber)','%02d')];
    AO.(ifam).ElementList              = (1:devnumber)';
    AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(devnumber,1);
    AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/temperature');
    AO.(ifam).Monitor.HW2PhysicsParams = 1;
    AO.(ifam).Monitor.Physics2HWParams = 1;
    AO.(ifam).Monitor.Units            = 'Hardware';
    AO.(ifam).Monitor.HWUnits          = '°C';
    AO.(ifam).Monitor.PhysicsUnits     = '°C';
    AO.(ifam).Position                 = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);
    
    %% TDL-Thermocouples
    ifam = 'TDL_TC';
    AO.(ifam).FamilyName           = ifam;
    AO.(ifam).MemberOf             = {'PlotFamily'; 'TC'; 'Archivable';'PlotFamily'};
    AO.(ifam).Monitor.Mode         = Mode;
    AO.(ifam).Monitor.DataType     = 'Scalar';
    
    map     = tango_get_db_property('TDL','thermocouple');
    cellindex = cell2mat(regexpi(map,'[DI][0-9]','once'))+1;
    numindex  = cell2mat(regexpi(map,'\.[0-9]','once'))+1;
    
    devnumber = size(map,2);
    for k = 1:devnumber,
        AO.(ifam).DeviceList(k,:)  = [str2double(map{k}(cellindex(k):cellindex(k)+1)) str2double(map{k}(numindex(k):end))];
    end
    
    AO.(ifam).Status                   = ones(devnumber,1);
    AO.(ifam).DeviceName               = map';
    AO.(ifam).CommonNames              = [repmat(ifam,devnumber,1) num2str((1:devnumber)','%02d')];
    AO.(ifam).ElementList              = (1:devnumber)';
    AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(devnumber,1);
    AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/temperature');
    AO.(ifam).Monitor.HW2PhysicsParams = 1;
    AO.(ifam).Monitor.Physics2HWParams = 1;
    AO.(ifam).Monitor.Units            = 'Hardware';
    AO.(ifam).Monitor.HWUnits          = '�C';
    AO.(ifam).Monitor.PhysicsUnits     = '�C';
    AO.(ifam).Position                 = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);
    
    %% DEBIMETRES
    ifam = 'DEB';
    AO.(ifam).FamilyName           = ifam;
    AO.(ifam).MemberOf             = {'Vaccuum'};
    AO.(ifam).Monitor.Mode         = Mode;
    AO.(ifam).Monitor.DataType     = 'Scalar';
    
    map     = tango_get_db_property('anneau','debitmetre');
    cellindex = cell2mat(regexpi(map,'C[0-9]','once'))+1;
    numindex  = cell2mat(regexpi(map,'\.[0-9]','once'))+1;
    
    devnumber = size(map,2);
    for k = 1:devnumber,
        AO.(ifam).DeviceList(k,:)  = [str2double(map{k}(cellindex(k):cellindex(k)+1)) str2double(map{k}(numindex(k):end))];
    end
    
    AO.(ifam).Status                   = ones(devnumber,1);
    AO.(ifam).DeviceName               = map';
    AO.(ifam).CommonNames              = [repmat(ifam,devnumber,1) num2str((1:devnumber)','%02d')];
    AO.(ifam).ElementList              = (1:devnumber)';
    AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(devnumber,1);
    AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/temperature');
    AO.(ifam).Monitor.HW2PhysicsParams = 1;
    AO.(ifam).Monitor.Physics2HWParams = 1;
    AO.(ifam).Monitor.Units            = 'Hardware';
    AO.(ifam).Monitor.HWUnits          = 'au';
    AO.(ifam).Monitor.PhysicsUnits     = 'au';
    AO.(ifam).Position                 = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);
    
    %% VM
    ifam = 'VM';
    AO.(ifam).FamilyName           = ifam;
    AO.(ifam).MemberOf             = {'PlotFamily'; 'Vaccuum'; 'Archivable';'PlotFamily'};
    AO.(ifam).Monitor.Mode         = Mode;
    AO.(ifam).Monitor.DataType     = 'Scalar';
    
    map     = tango_get_db_property('anneau','vanne_manuelle');
    cellindex = cell2mat(regexpi(map,'C[0-9]','once'))+1;
    numindex  = cell2mat(regexpi(map,'\.[0-9]','once'))+1;
    
    devnumber = size(map,2);
    for k = 1:devnumber,
        AO.(ifam).DeviceList(k,:)  = [str2double(map{k}(cellindex(k):cellindex(k)+1)) str2double(map{k}(numindex(k):end))];
    end
    
    AO.(ifam).Status                   = ones(devnumber,1);
    AO.(ifam).DeviceName               = map';
    AO.(ifam).CommonNames              = [repmat(ifam,devnumber,1) num2str((1:devnumber)','%02d')];
    AO.(ifam).ElementList              = (1:devnumber)';
    AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(devnumber,1);
    AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/temperature');
    AO.(ifam).Monitor.HW2PhysicsParams = 1;
    AO.(ifam).Monitor.Physics2HWParams = 1;
    AO.(ifam).Monitor.Units            = 'Hardware';
    AO.(ifam).Monitor.HWUnits          = 'au';
    AO.(ifam).Monitor.PhysicsUnits     = 'au';
    
    %% VS
    ifam = 'VS';
    AO.(ifam).FamilyName           = ifam;
    AO.(ifam).MemberOf             = {'PlotFamily'; 'Vaccuum'; 'Archivable';'PlotFamily'};
    AO.(ifam).Monitor.Mode         = Mode;
    AO.(ifam).Monitor.DataType     = 'Scalar';
    
    map     = tango_get_db_property('anneau','vanne_secteur');
    cellindex = cell2mat(regexpi(map,'C[0-9]','once'))+1;
    numindex  = cell2mat(regexpi(map,'\.[0-9]','once'))+1;
    
    devnumber = size(map,2);
    for k = 1:devnumber,
        AO.(ifam).DeviceList(k,:)  = [str2double(map{k}(cellindex(k):cellindex(k)+1)) str2double(map{k}(numindex(k):end))];
    end
    
    AO.(ifam).Status                   = ones(devnumber,1);
    AO.(ifam).DeviceName               = map';
    AO.(ifam).CommonNames              = [repmat(ifam,devnumber,1) num2str((1:devnumber)','%02d')];
    AO.(ifam).ElementList              = (1:devnumber)';
    AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(devnumber,1);
    AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/temperature');
    AO.(ifam).Monitor.HW2PhysicsParams = 1;
    AO.(ifam).Monitor.Physics2HWParams = 1;
    AO.(ifam).Monitor.Units            = 'Hardware';
    AO.(ifam).Monitor.HWUnits          = 'au';
    AO.(ifam).Monitor.PhysicsUnits     = 'au';
    AO.(ifam).Position                 = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);
    
    %% Thermocouples GTC
    ifam = 'GTC_TC';
    AO.(ifam).FamilyName           = ifam;
    AO.(ifam).MemberOf             = {'PlotFamily'; 'GTC'; 'Temperature'; 'Archivable';'PlotFamily'};
    AO.(ifam).Monitor.Mode         = Mode;
    AO.(ifam).Monitor.DataType     = 'Scalar';
    
    map     = tango_get_db_property('anneau','GTC_Tunnel_TC');
    cellindex = cell2mat(regexpi(map,'C[0-9]','once'))+1;
    numindex  = cell2mat(regexpi(map,'MT[0-9]','once'))+2;
    
    devnumber = size(map,2);
    for k = 1:devnumber,
        AO.(ifam).DeviceList(k,:)  = [str2double(map{k}(cellindex(k):cellindex(k)+1)) str2double(map{k}(numindex(k):end))];
    end
    
    AO.(ifam).Status                   = ones(devnumber,1);
    AO.(ifam).DeviceName               = map';
    AO.(ifam).CommonNames              = [repmat(ifam,devnumber,1) num2str((1:devnumber)','%02d')];
    AO.(ifam).ElementList              = (1:devnumber)';
    AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(devnumber,1);
    AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/temperature');
    AO.(ifam).Monitor.HW2PhysicsParams = 1;
    AO.(ifam).Monitor.Physics2HWParams = 1;
    AO.(ifam).Monitor.Units            = 'Hardware';
    AO.(ifam).Monitor.HWUnits          = '°C';
    AO.(ifam).Monitor.PhysicsUnits     = '°C';
    AO.(ifam).Position                 = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);
    
    
    %=====================
    %% Gamma Monitors DOSE
    %====================
    ifam = 'CIGdose';
    AO.(ifam).FamilyName                     = 'CIGdose';
    AO.(ifam).FamilyType                     = 'Radioprotection';
    AO.(ifam).MemberOf                       = {'Radioprotection','Archivable','Plotfamily','PlotFamily'};
    AO.(ifam).CommonNames                    = 'CIG';
    
    map = tango_get_db_property('anneau','gammamonitor_mapping');
    AO.(ifam).DeviceName = map';
    
    AO.(ifam).Monitor.Mode                   = Mode;
    AO.(ifam).FamilyName                     = 'CIGdose';
    AO.(ifam).Monitor.DataType               = 'Scalar';
    
    devnumber = length(AO.(ifam).DeviceName);
    AO.(ifam).DeviceList                     = [ones(1,devnumber); (1:devnumber)]';
    AO.(ifam).ElementList                    = (1:devnumber)';
    AO.(ifam).Status                         = ones(devnumber,1);
    
    AO.(ifam).Monitor.TangoNames            = strcat(AO.(ifam).DeviceName,'/dose');
    
    %afin de ne pas avoir de bug
    AO.(ifam).Monitor.Units                  = 'Hardware';
    AO.(ifam).Monitor.Handles                = NaN;
    AO.(ifam).Monitor.HWUnits                = 'uGy';
    AO.(ifam).Monitor.PhysicsUnits           = 'uGy';
    AO.(ifam).Monitor.HW2PhysicsParams       = 1;
    AO.(ifam).Monitor.Physics2HWParams       = 1;
    AO.(ifam).Position                       = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);
    
    %=========================
    %% Gamma Monitors DOSErate
    %=========================
    
    ifam = 'CIGrate';
    AO.(ifam) = AO.CIGdose;
    AO.(ifam).FamilyName                     = ifam;
    AO.(ifam).CommonNames                    = ifam;
    
    devnumber = length(AO.(ifam).DeviceName);
    AO.(ifam).Status                         = ones(devnumber,1);
    AO.(ifam).DeviceList                     = [ones(1,devnumber); (1:devnumber)]';
    AO.(ifam).ElementList                    = (1:devnumber)';
    
    AO.(ifam).Monitor.TangoNames            = strcat(AO.(ifam).DeviceName,'/doseRate');
    
    %afin de ne pas avoir de bug
    AO.CIG.Monitor.HWUnits                = 'uGy/h';
    AO.CIG.Monitor.PhysicsUnits           = 'uGy/h';
    
    %=====================
    %% Neutron Monitors DOSE
    %====================
    ifam = 'MONdose';
    AO.(ifam).FamilyName                     = ifam;
    AO.(ifam).FamilyType                     = 'Radioprotection';
    AO.(ifam).MemberOf                       = {'Radioprotection','Archivable','Plotfamily','PlotFamily'};
    AO.(ifam).CommonNames                    = 'MON';
    
    map = tango_get_db_property('anneau','neutronmonitor_mapping');
    AO.(ifam).DeviceName = map';
    
    AO.(ifam).Monitor.Mode                   = Mode;
    AO.(ifam).FamilyName                     = ifam;
    AO.(ifam).Monitor.DataType               = 'Scalar';
    
    devnumber = length(AO.(ifam).DeviceName);
    AO.(ifam).DeviceList                     = [ones(1,devnumber); (1:devnumber)]';
    AO.(ifam).ElementList                    = (1:devnumber)';
    AO.(ifam).Status                         = ones(devnumber,1);
    
    AO.(ifam).Monitor.TangoNames            = strcat(AO.(ifam).DeviceName,'/dDoseSinceReset');
    
    %afin de ne pas avoir de bug
    AO.(ifam).Monitor.Units                  = 'Hardware';
    AO.(ifam).Monitor.Handles                = NaN;
    AO.(ifam).Monitor.HWUnits                = 'uGy';
    AO.(ifam).Monitor.PhysicsUnits           = 'uGy';
    AO.(ifam).Monitor.HW2PhysicsParams       = 1;
    AO.(ifam).Monitor.Physics2HWParams       = 1;
    AO.(ifam).Position                 = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);
    
    %============================
    %% Neutron Monitors DOSE RATE
    %============================
    ifam = 'MONrate';
    AO.(ifam).FamilyName                     = ifam;
    AO.(ifam).FamilyType                     = 'Radioprotection';
    AO.(ifam).MemberOf                       = {'Radioprotection','Archivable','Plotfamily','PlotFamily'};
    AO.(ifam).CommonNames                    = 'MON';
    
    map = tango_get_db_property('anneau','neutronmonitor_mapping');
    AO.(ifam).DeviceName = map';
    
    AO.(ifam).Monitor.Mode                   = Mode;
    AO.(ifam).FamilyName                     = ifam;
    AO.(ifam).Monitor.DataType               = 'Scalar';
    
    devnumber = length(AO.(ifam).DeviceName);
    AO.(ifam).DeviceList                     = [ones(1,devnumber); (1:devnumber)]';
    AO.(ifam).ElementList                    = (1:devnumber)';
    AO.(ifam).Status                         = ones(devnumber,1);
    
    AO.(ifam).Monitor.TangoNames            = strcat(AO.(ifam).DeviceName,'/dCountsSinceReset');
    
    %afin de ne pas avoir de bug
    AO.(ifam).Monitor.Units                  = 'Hardware';
    AO.(ifam).Monitor.Handles                = NaN;
    AO.(ifam).Monitor.HWUnits                = 'uradGy';
    AO.(ifam).Monitor.PhysicsUnits           = 'uradGy';
    AO.(ifam).Monitor.HW2PhysicsParams       = 1;
    AO.(ifam).Monitor.Physics2HWParams       = 1;
    AO.(ifam).Position                 = (1:length(AO.(ifam).DeviceName))'*354/length(AO.(ifam).DeviceName);
end

% %====================
% %% Machine Parameters
% %====================
% AO.MachineParameters.FamilyName                = 'MachineParameters';
% AO.MachineParameters.FamilyType                = 'Parameter';
% AO.MachineParameters.MemberOf                  = {'Diagnostics'};
% AO.MachineParameters.Status                    = [1 1 1 1]';
%
% AO.MachineParameters.Monitor.Mode              = Mode;
% AO.MachineParameters.Monitor.DataType          = 'Scalar';
% AO.MachineParameters.Monitor.Units             = 'Hardware';
%
% %use spear2 process variable names
% mp={
%     'mode    '    'SPEAR:BeamStatus  '          [1 1]  1; ...
%     'energy  '    'SPEAR:Energy      '          [1 2]  2; ...
%     'current '    'SPEAR:BeamCurrAvg '          [1 3]  3; ...
%     'lifetime'    'SPEAR:BeamLifetime'          [1 4]  4; ...
%     };
% AO.MachineParameters.Monitor.HWUnits          = ' ';
% AO.MachineParameters.Monitor.PhysicsUnits     = ' ';
%
% AO.MachineParameters.Setpoint.HWUnits         = ' ';
% AO.MachineParameters.Setpoint.PhysicsUnits    = ' ';
%
% for ii=1:size(mp,1),
%     name  =mp(ii,1);    AO.MachineParameters.CommonNames(ii,:)            = char(name{1});
%     %     name  =mp(ii,2);    AO.MachineParameters.Monitor.ChannelNames(ii,:)   = char(name{1});
%     %     name  =mp(ii,2);    AO.MachineParameters.Setpoint.ChannelNames(ii,:)  = char(name{1});
%     val   =mp(ii,3);    AO.MachineParameters.DeviceList(ii,:)             = val{1};
%     val   =mp(ii,4);    AO.MachineParameters.ElementList(ii,:)            = val{1};
%
%     AO.MachineParameters.Monitor.HW2PhysicsParams(ii,:)    = 1;
%     AO.MachineParameters.Monitor.Physics2HWParams(ii,:)    = 1;
%     AO.MachineParameters.Monitor.Handles(ii,1)  = NaN;
%     AO.MachineParameters.Setpoint.HW2PhysicsParams(ii,:)   = 1;
%     AO.MachineParameters.Setpoint.Physics2HWParams(ii,:)   = 1;
%     AO.MachineParameters.Setpoint.Handles(ii,1)  = NaN;
% end


%======
%% Septum
%======
% ifam=ifam+1;
% AO.Septum.FamilyName                  = 'Septum';
% AO.Septum.FamilyType                  = 'Septum';
% AO.Septum.MemberOf                    = {'Injection'};
% AO.Septum.Status                      = 1;
%
% AO.Septum.CommonNames                 = 'Septum  ';
% AO.Septum.DeviceList                  = [3 1];
% AO.Septum.ElementList                 = [1];
%
% AO.Septum.Monitor.Mode                = Mode;
% AO.Septum.Monitor.DataType            = 'Scalar';
% AO.Septum.Monitor.Units               = 'Hardware';
% AO.Septum.Monitor.HWUnits             = 'ampere';
% AO.Septum.Monitor.PhysicsUnits        = 'rad';
% AO.Septum.Monitor.ChannelNames        = 'BTS-B9V:Curr';
% AO.Septum.Monitor.Handles             = NaN;
%
% AO.Septum.Setpoint.Mode               = Mode;
% AO.Septum.Setpoint.DataType           = 'Scalar';
% AO.Septum.Setpoint.Units              = 'Hardware';
% AO.Septum.Setpoint.HWUnits            = 'ampere';
% AO.Septum.Setpoint.PhysicsUnits       = 'rad';
% AO.Septum.Setpoint.ChannelNames       = 'BTS-B9V:CurrSetpt';
% AO.Septum.Setpoint.Range              = [0, 249.90];
% AO.Septum.Setpoint.Tolerance          = 100.0;
% AO.Septum.Setpoint.Handles            = NaN;
%
% AO.Septum.Monitor.HW2PhysicsParams    = 1;
% AO.Septum.Monitor.Physics2HWParams    = 1;
% AO.Septum.Setpoint.HW2PhysicsParams   = 1;
% AO.Septum.Setpoint.Physics2HWParams   = 1;

% Save AO
setao(AO);


%%%%%%%%%%%%%                   BPM AO OFFSETS               %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AO=getao;
if strcmp(Mode,'Online')
    BPM_offset = get_bpm_offsets([]);
    AO.BPMx.BPM_offset = BPM_offset;
    AO.BPMz.BPM_offset = BPM_offset;
    setao(AO);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The operational mode sets the path, filenames, and other important params
% Run setoperationalmode after most of the AO is built so that the Units and Mode fields
% can be set in setoperationalmode

waitbar(0.4,h);

setoperationalmode(OperationalMode);
%run('/home/operateur/GrpPhysiqueMachine/Laurent/matlab/nano/setdevelopmentmode.m')
%run([getdvptdirectory '/setdevelopmentmode.m']);
%run('/home/operateur/temp/testMML/setdevelopmentmode.m');

waitbar(0.5,h);

%======================================================================
%======================================================================
%% Append Accelerator Toolbox information
%======================================================================
%======================================================================
disp('** Initializing Accelerator Toolbox information');

AO = getao;

%% Machine Params
ifam = ('MachineParams');
AO.(ifam).AT.ATType       = 'MachineParams';
AO.(ifam).AT.ATName(1,:)  = 'Energy  ';
AO.(ifam).AT.ATName(2,:)  = 'current ';
AO.(ifam).AT.ATName(3,:)  = 'Lifetime';

% Save AO
setao(AO);

disp('Setting min max configuration from TANGO static database ...');

waitbar(0.80,h);

disp('Setting gain offset configuration  ...');

setfamilydata([0.20; 0.30; NaN],'TUNE','Golden');
setfamilydata([0.0; 0.0],'CHRO','Golden');
setfamilydata_local('BPMx');
setfamilydata_local('BPMz');
setfamilydata_local('PBPMz');
setfamilydata_local('HCOR');
setfamilydata_local('VCOR');
setfamilydata_local('FHCOR');
setfamilydata_local('FVCOR');
setfamilydata_local('Q1');
setfamilydata_local('Q2');
setfamilydata_local('Q3');
setfamilydata_local('Q4');
setfamilydata_local('Q5');
setfamilydata_local('Q6');
setfamilydata_local('Q7');
setfamilydata_local('Q8');
setfamilydata_local('Q9');
setfamilydata_local('Q10');
setfamilydata_local('Q11');
setfamilydata_local('Q12');
setfamilydata_local('S1');
setfamilydata_local('S2');
setfamilydata_local('S3');
setfamilydata_local('S4');
setfamilydata_local('S5');
setfamilydata_local('S6');
setfamilydata_local('S7');
setfamilydata_local('S8');
setfamilydata_local('S9');
setfamilydata_local('S10');
% nanoscopium
setfamilydata_local('S11');
%setfamilydata_local('S12');
setfamilydata_local('BEND');

waitbar(0.95,h);

if iscontrolroom
    switch2online;
else
    switch2sim;
end

delete(h);
% set close orbit
% fprintf('%3d %3d  %10.6f  %10.6f\n', [family2dev('BPMx'), getgolden('BPMx'), getgolden('BPMz')]');
% fprintf('%3d %3d  %10.6f  %10.6f\n', [family2dev('BPMx'), getam('BPMx'), getam('BPMz')]');
% fprintf('%3d %3d  %10.6f  %10.6f\n', [family2dev('BPMx'), gethbpmaverage, getvbpmaverage]'); % With averaging


%% WARNING Golden orbit gestion is now in setoperationalmode (May 2015)


% update getgolden in TANGO BPMmanager
% tango_write_attribute2('ANS/DG/BPM-MANAGER', 'xRefOrbit',getgolden('BPMx')')
% tango_write_attribute2('ANS/DG/BPM-MANAGER', 'zRefOrbit',getgolden('BPMz')')

%  3   3    0.025271   -0.141561
%  3   4   -0.005622   -0.031273

%% 25 October, 2014 15 mA 1/4
% Golden = [
%   1   2    0.006979   -0.000726
%   1   3   -0.004977    0.026143
%   1   4   -0.019022   -0.003815
%   1   5   -0.112342   -0.006237
%   1   6    0.148780    0.017265
%   1   7   -0.008189    0.104515
%   2   1   -0.016452   -0.074937
%   2   2    0.041988   -0.028567
%   2   3   -0.026590    0.065486
%   2   4    0.015460    0.037270
%   2   5   -0.005279   -0.090811
%   2   6   -0.065644    0.074248
%   2   7    0.068785   -0.025719
%   2   8    0.040243   -0.138778
%   3   1   -0.063439    0.076639
%   3   2   -0.033743    0.091596
%   3   3    0.025271   -0.141561
%   3   4   -0.005622   -0.031273
%   3   5    0.004079    0.029056
%   3   6   -0.017465    0.030173
%   3   7    0.017179   -0.025743
%   3   8    0.001765   -0.083050
%   4   1   -0.011714    0.078946
%   4   2    0.019332   -0.044149
%   4   3    0.003214    0.008008
%   4   4   -0.117550    0.028767
%   4   5   -0.005340    0.001972
%   4   6    0.137023   -0.024449
%   4   7   -0.059205   -0.015024
%   5   1    0.052208    0.028348
%   5   2   -0.030835   -0.029086
%   5   3    0.011275    0.027546
%   5   4    0.058400   -0.010547
%   5   5    0.002695    0.017289
%   5   6   -0.052177   -0.011034
%   5   7    0.005686   -0.025542
%   6   1    0.002446    0.005848
%   6   2    0.021162    0.033594
%   6   3   -0.007043   -0.041153
%   6   4   -0.035283    0.015954
%   6   5    0.041487   -0.030620
%   6   6   -0.060659    0.019853
%   6   7    0.060106   -0.003852
%   6   8   -0.014125   -0.124212
%   7   1    0.009313    0.125733
%   7   2   -0.017723   -0.086748
%   7   3    0.009257    0.050651
%   7   4    0.027610   -0.023925
%   7   5   -0.015766   -0.000417
%   7   6   -0.152405    0.108773
%   7   7    0.159964   -0.058736
%   7   8   -0.020408   -0.027366
%   8   1    0.002003    0.046980
%   8   2    0.038201   -0.066360
%   8   3   -0.007590    0.061103
%   8   4   -0.082247   -0.003278
%   8   5   -0.041114   -0.010464
%   8   6    0.125314    0.006741
%   8   7   -0.045757    0.050452
%   9   1    0.044475   -0.052495
%   9   2    0.000996    0.016325
%   9   3    0.000745   -0.001051
%   9   4   -0.019296   -0.006420
%   9   5   -0.029304    0.001342
%   9   6    0.052256    0.005944
%   9   7   -0.031620    0.033279
%  10   1    0.037905    0.010222
%  10   2    0.024258   -0.081671
%  10   3   -0.014819    0.098944
%  10   4   -0.053819   -0.022655
%  10   5    0.048479    0.018711
%  10   6    0.025888    0.023393
%  10   7   -0.032620   -0.020117
%  10   8   -0.022772   -0.127396
%  11   1    0.028689    0.111932
%  11   2    0.061397   -0.045815
%  11   3   -0.043072    0.017860
%  11   4   -0.035957   -0.003248
%  11   5    0.042070   -0.019687
%  11   6   -0.020843    0.095630
%  11   7    0.018714   -0.055654
%  11   8    0.005562   -0.155812
%  12   1   -0.017228    0.170449
%  12   2    0.017161   -0.142279
%  12   3   -0.019087    0.102401
%  12   4    0.044363   -0.006772
%  12   5    0.012170   -0.005217
%  12   6   -0.043923    0.021863
%  12   7   -0.019374   -0.034649
%  13   1    0.0         0.0
%  13   8    0.0        -0.036
%  13   9   -0.015865   -0.021800
%  13   2   -0.008758   -0.183476
%  13   3    0.005359    0.162002
%  13   4    0.042994    0.059555
%  13   5    0.027941   -0.068950
%  13   6   -0.078345    0.023079
%  13   7   -0.013131    0.042677
%  14   1    0.030689   -0.001169
%  14   2    0.008777   -0.097203
%  14   3    0.000011    0.130168
%  14   4   -0.053929   -0.007189
%  14   5    0.051844   -0.008293
%  14   6   -0.020314    0.053669
%  14   7    0.007971   -0.037176
%  14   8    0.010494   -0.022324
%  15   1   -0.020362    0.054830
%  15   2    0.048454   -0.116164
%  15   3   -0.023677    0.118952
%  15   4   -0.043425    0.035353
%  15   5    0.046511   -0.032453
%  15   6   -0.028645   -0.041679
%  15   7    0.014893    0.037886
%  15   8    0.027953   -0.125440
%  16   1   -0.038572    0.131164
%  16   2    0.005962   -0.094114
%  16   3    0.001585    0.050242
%  16   4    0.001902    0.008105
%  16   5    0.026235   -0.023902
%  16   6   -0.035084    0.007441
%  16   7   -0.019894    0.079811
%   1   1    0.036295   -0.063020
% ];
% 
% 
% setfamilydata(Golden(:,3),'BPMx','Golden',Golden(:,1:2));
% setfamilydata(Golden(:,4),'BPMz','Golden',Golden(:,1:2));

%% XBPM GOLDEN

% XBPMGolden = [ % 430 mA 3/4 24/11/14
%  1    8   -0.008766    0.3328  % XBPM ODE
%  5    8   -0.038019    0.0189% XBPM METRO 
%  9    8   -0.031512    0.0449 % XBPM SAMBA
% 13   10    0.001385   -0.0645 %BPM DIFFABS
% ];

% XBPMGolden = [ % 430 mA 3/4 26/10/14
%  1    8   -0.008766    0.3281  % XBPM ODE
%  5    8   -0.038019    0.0189% XBPM METRO 
%  9    8   -0.031512    0.0462 % XBPM SAMBA
% 13   10    0.001385   -0.0377 %BPM DIFFABS
% ];

% XBPMGolden = [ % 430 mA 3/4 01/09/14
% 1   8   -0.008766    0.3234  % XBPM ODE
% 5   8   -0.038019    0.0157% XBPM METRO 
% 9   8   -0.031512    0.0141 % XBPM SAMBA
% 13   10   0.001385  -0.0209 %BPM DIFFABS
% ];

% XBPMGolden = [ % 430 mA 3/4 25/01/14
% 1   8   -0.008766    0.3442  % XBPM ODE
% 5   8   -0.038019    0.0466 % XBPM METRO 
% 9   8   -0.031512   -0.0220 % XBPM SAMBA
% 13   10   0.001385  -0.0545 %BPM DIFFABS
% ];
% 

% XBPMGolden = [ % 15 mA 1/4 09/04/13
% 1   8   -0.008766    0.340000  % XBPM ODE
% 5   8   -0.038019    0.006000 % XBPM METRO 
% 9   8   -0.031512   -0.027000 % XBPM SAMBA
% 13   10   0.001385   -0.053000 %BPM DIFFABS
% ];

% XBPMGolden = [ % 15 mA 1 bunch 03/06/13
% 1   8   -0.008766    0.2851  % XBPM ODE
% 5   8   -0.038019    0.0581 % XBPM METRO 
% 9   8   -0.031512   -0.0650 % XBPM SAMBA
% 13   10   0.001385  -0.1072 %BPM DIFFABS
% ];

% XBPMGolden = [ % 72-88 mA 8 bunch 03/06/13
% 1   8   -0.008766    0.2913  % XBPM ODE
% 5   8   -0.038019    0.0452 % XBPM METRO 
% 9   8   -0.031512   -0.0362 % XBPM SAMBA
% 13   10   0.001385  -0.0945 %BPM DIFFABS
% ];

% XBPMGolden = [ % 100 mA 8 bunch 13/04/15
% 1   8   -0.008766    0.3232  % XBPM ODE
% 5   8   -0.038019    0.0767 % XBPM METRO 
% 9   8   -0.031512   -0.0431 % XBPM SAMBA
% 13   10   0.001385  -0.0805 %BPM DIFFABS
% ];


% XBPMGolden = [ % 430 mA 3/4 05/05/13
% 1   8   -0.008766    0.3043  % XBPM ODE
% 5   8   -0.038019    0.0272 % XBPM METRO 
% 9   8   -0.031512   -0.0037 % XBPM SAMBA
% 13   10   0.001385  -0.0516 %BPM DIFFABS
% ];
% 
% XBPMGolden = [ % 430 mA 3/4 04/10/13
% 1   8   -0.008766    0.3226  % XBPM ODE
% 5   8   -0.038019    0.0207 % XBPM METRO 
% 9   8   -0.031512   -0.0182 % XBPM SAMBA
% 13   10   0.001385  -0.0636 %BPM DIFFABS
% ];

% XBPMGolden = [ % 430 mA 3/4 15/04/13
% 1   8   -0.008766    0.3578  % XBPM ODE
% 5   8   -0.038019    0.0042 % XBPM METRO 
% 9   8   -0.031512   -0.0153 % XBPM SAMBA
% 13   10   0.001385  -0.0594 %BPM DIFFABS
% ];

% XBPMGolden = [ % 500 mA 4/4 25/09/12
% 1   8   -0.008766    0.261000  % XBPM ODE
% 5   8   -0.038019    0.033000 % XBPM METRO 
% 9   8   -0.031512   -0.053000 % XBPM SAMBA
% 13   10   0.001385   -0.084000 %BPM DIFFABS
% ];

%create PBPMz golden 
% PBPMzGolden=Golden;
% 
% xbpm_index=find(AO.PBPMz.Type==0); % check for xbpm in the family
% for i=1:size(xbpm_index,1) % insert xbpm golden data in the BPM golden data
%     PBPMzGolden = [PBPMzGolden(1:xbpm_index(i)-1,:)' XBPMGolden(i,:)' PBPMzGolden(xbpm_index(i):size(PBPMzGolden,1),:)']';
% end
% 
% % set Golden orbit
% setfamilydata(0.0,'PBPMz','Golden')
% setfamilydata(PBPMzGolden(:,4),'PBPMz','Golden',PBPMzGolden(:,1:2));
% 
end

%% LOCAL FUNCTIONS
function local_tango_kill_allgroup(AO)
% kill all group if exist
FamilyList = getfamilylist('Cell');
for k=1:length(FamilyList)
    if isfield(AO.(FamilyList{k}), 'GroupId'),
        tango_group_kill(AO.(FamilyList{k}).GroupId);
    end
end
end

function setfamilydata_local(Family)
% set all data in one command

if ismemberof(Family,'QUAD') || ismemberof(Family,'SEXT') || ...
         ismemberof(Family,'BEND')
    setfamilydata(1,Family,'Gain');
    setfamilydata(0,Family,'Offset');
    setfamilydata(0,Family,'Coupling');
end

if ismemberof(Family,'BPM')
    setfamilydata(0.001,Family,'Sigma');
    %setfamilydata(0.0,Family,'Golden');   
    setfamilydata(0.0,Family,'Offset');   
    %setfamilydata(measdisp(Family,'struct','model'),Family,'Dispersion'); % needed for orbit correction w/ RF
end

% Order fields for all families
AO = getao;
Familylist = getfamilylist;
for k = 1:length(Familylist),
    FamilyName = deblank(Familylist(k,:));
    AO.(FamilyName) = orderfields(AO.(FamilyName));
    FieldNamelist = fieldnames(AO.(FamilyName));
    for k1 = 1:length(FieldNamelist);
        FieldName = FieldNamelist{k1};
        if isstruct((AO.(FamilyName).(FieldName)))
            AO.(FamilyName).(FieldName) = orderfields(AO.(FamilyName).(FieldName));
        end
    end
end
setao(AO)
end

