function TLinit(OperationalMode)
% LT2INIT - Contructs an accelerator Object describing LT2
%
% Written by Laurent S. Nadolski, Synchrotron SOLEIL
%
% Modified by Jianfeng Zhang @ LAL, 09/2013
%==========================
% Accelerator Family Fields
%==========================
% FamilyName            CH, CV, QP, Bend
% CommonNames           Shortcut name for each element
% DeviceList            [Sector, Number]
% ElementList           number in list
% Position              m, magnet center
%
% MONITOR FIELD
% Mode                  online/manual/special/simulator
% TangoNames            Tango device name for monitor
% Units                 Physics or HW
% HW2PhysicsFcn         function handle used to convert from hardware to physics units ==> inline will not compile, see below
% HW2PhysicsParams      parameters used for conversion function
% Physics2HWFcn         function handle used to convert from physics to hardware units
% Physics2HWParams      parameters used for conversion function
% HWUnits               units for Hardware 'ampere';
% PhysicsUnits          units for physics 'Rad';
% Handles               monitor handle
%
% SETPOINT FIELDS
% Mode                  online/manual/special/simulator
% TangoNames            PV for monitor
% Units                 hardware or physics
% HW2PhysicsFcn         function handle used to convert from hardware to physics units
% HW2PhysicsParams      parameters used for conversion function
% Physics2HWFcn         function handle used to convert from physics to hardware units
% Physics2HWParams      parameters used for conversion function
% HWUnits               units for Hardware 'ampere';
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
% ATParameterGroup      parameter group
%
%============
% Family List
%============
%    CH
%    CV
%    BEND
%    QP
%    BPM
%    Machine Parameters
%
%  See Also aoinit, setoperationalmode, updateatindex, setpathsoleil

%==============================
%load AcceleratorData structure
%==============================

%operation lattice
if nargin < 1
    OperationalMode = 1;
end

% choose the operation mode "online" or "simulator"
%%%%%%% This is a very important command!!!!
% Need to modify it in the future... by Jianfeng Zhang @ LAL, 09/04/2014
%
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

global GLOBVAL THERING


% AD already been defined in setpathmml.m. Modified by Jianfeng Zhang @ LAL,
% 17/12/2013
%Mode             = 'online';
%setad([]);       %clear AcceleratorData memory
%AD.SubMachine    = 'TL'; % Machine Name
%AD.Energy        = 0.05 ; % Energy in GeV


%setad(AD);   %load AcceleratorData

%%%%%%%%%%%%%%%%%%%%
% ACCELERATOR OBJECT
%%%%%%%%%%%%%%%%%%%%

setao([]);   %clear previous AcceleratorObjects


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BPM data
% status field designates if BPM in use
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ifam = 'BPMx';
AO.(ifam).FamilyName               = ifam;
AO.(ifam).FamilyType               = 'BPM';
AO.(ifam).MemberOf                 = {'BPM'; 'HBPM'; 'PlotFamily'; 'Archivable'};
AO.(ifam).Monitor.Mode             = Mode;
AO.(ifam).Monitor.Units            = 'Hardware';
AO.(ifam).Monitor.HWUnits          = 'mm';
AO.(ifam).Monitor.PhysicsUnits     = 'meter';

nb = 4;
AO.(ifam).DeviceList =[1 1; 1 2; 1 3; 1 4]; 
AO.(ifam).ElementList = (1:nb)';
AO.(ifam).DeviceName(:,:)               = {'TL/DG-A/BPM.010'; 'TL/DG-E/BPM.020'; 'TL/DG-H/BPM.030'; 'TL/DG-I/BPM.040'};
AO.(ifam).Monitor.TangoNames(:,:)       = strcat(AO.(ifam).DeviceName, '/XPosSA');
AO.(ifam).CommonNames(:,:)              = [repmat('BPMx',nb,1) num2str((1:nb)','%03d')];

AO.(ifam).Status                        = ones(nb,1);
AO.(ifam).Monitor.HW2PhysicsParams(:,:) = 1e-3*ones(nb,1);
AO.(ifam).Monitor.Physics2HWParams(:,:) = 1e3*ones(nb,1);

% 2 lignes ajoutes pour test debug bpm versus le reste du monde
AO.(ifam).Monitor.Handles(:,1)       = NaN*ones(nb,1);
AO.(ifam).Monitor.DataType         = 'Scalar';


% Vertical plane
ifam = 'BPMz'; 
AO.(ifam) = AO.BPMx; % the same as BPMx 
% except those fields
AO.(ifam).MemberOf                 = {'BPM'; 'VBPM'; 'PlotFamily'; 'Archivable'};
AO.(ifam).FamilyName              = ifam;
AO.(ifam).Monitor.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/ZPosSA');
AO.(ifam).CommonNames(:,:) = [repmat('BPMz',nb,1) num2str((1:nb)','%03d')];

% 2 lignes ajoutes pour test debug bpm versus le reste du monde
AO.(ifam).Monitor.DataType         = 'Scalar';
AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(nb,1);

AO.(ifam).Status = AO.(ifam).Status(:);
AO.(ifam).Status = AO.(ifam).Status(:);

setao(AO); % mandatory to avoid empty AO message with magnetcoefficients

%% Dipole

%==============
% bending dipoles
varlist.BEND1={
    1  [ 1  1] 'TL/PS-B/DP.010-DC' 1 'BEND1.01' [+0 +580]
    2  [ 1  2] 'TL/PS-B/DP.020-CTL' 1 'BEND1.02' [+0 +580]
    3  [ 1  3] 'TL/PS/DP.030-DC' 1 'BEND1.03' [+0 +580]
    4  [ 1  4] 'TL/PS/DP.040-DC' 1 'BEND1.04' [+0 +580]
             };

% bend to kick the beam to the septum....
varlist.BEND2={
     1  [ 1  1] 'TL/ME/DP.050-DC' 1 'BEND2.01' [+0 +580]
};


for k = 1:2,
    
    ifam = ['BEND' num2str(k)];

AO.(ifam).FamilyName             = ifam;
AO.(ifam).FamilyType             = 'BEND';
AO.(ifam).MemberOf               = {'MachineConfig'; 'Magnet'; 'BEND'; 'Archivable'};
AO.(ifam).Mode                   = Mode;

AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'radian'; % GeV
AO.(ifam).Monitor.HW2PhysicsFcn  = @bend2gev;
AO.(ifam).Monitor.Physics2HWFcn  = @gev2bend;

 devnumber = size(varlist.(ifam),1);
% preallocation
AO.(ifam).ElementList         = zeros(devnumber,1);
AO.(ifam).Status              = zeros(devnumber,1);
AO.(ifam).DeviceName          = cell(devnumber,1);
AO.(ifam).CommonNames         = cell(devnumber,1);
AO.(ifam).Monitor.TangoNames  = cell(devnumber,1);
% make Setpoint structure than specific data
AO.(ifam).Setpoint            = AO.(ifam).Monitor;
AO.(ifam).Setpoint.Range      = zeros(devnumber,2);

for ik = 1: devnumber,   
    AO.(ifam).ElementList(ik)           = varlist.(ifam){ik,1};
    AO.(ifam).DeviceList(ik,:)          = varlist.(ifam){ik,2};
    AO.(ifam).DeviceName(ik)            = deblank(varlist.(ifam)(ik,3));
    AO.(ifam).Status(ik)                = varlist.(ifam){ik,4};
    AO.(ifam).CommonNames(ik)           = deblank(varlist.(ifam)(ik,5));
    AO.(ifam).Monitor.TangoNames(ik)    = strcat(AO.(ifam).DeviceName{ik}, {'/current'});   
    AO.(ifam).Setpoint.TangoNames(ik)   = strcat(AO.(ifam).DeviceName{ik}, {'/currentPM'});
    AO.(ifam).Setpoint.Range(ik,:)      = varlist.(ifam){ik,6};
end

AO.(ifam).Monitor.Handles(:,1) = NaN*ones(devnumber,1);

setao(AO); % mandatory to avoid empty AO message with magnetcoefficients

HW2PhysicsParams = magnetcoefficients(AO.(ifam).FamilyName);
Physics2HWParams = magnetcoefficients(AO.(ifam).FamilyName);

% need to check this part in the future (07/2013@Zhang)
val = 1;
for ii=1:devnumber,
    AO.(ifam).Monitor.HW2PhysicsParams{1}(ii,:)                 = HW2PhysicsParams;
    AO.(ifam).Monitor.HW2PhysicsParams{2}(ii,:)                 = val;
    AO.(ifam).Monitor.Physics2HWParams{1}(ii,:)                 = Physics2HWParams;
    AO.(ifam).Monitor.Physics2HWParams{2}(ii,:)                 = val;
end
% same configuration for Monitor and Setpoint value concerning hardware to physics units
AO.(ifam).Setpoint.HW2PhysicsParams = AO.(ifam).Monitor.HW2PhysicsParams;
AO.(ifam).Setpoint.Physics2HWParams = AO.(ifam).Monitor.Physics2HWParams;%

setao(AO);

%[C Leff Type coefficients] = magnetcoefficients(AO.(ifam).FamilyName );
%AO.(ifam).Monitor.HW2PhysicsParams{1}(1,:) = coefficients;
%AO.(ifam).Monitor.Physics2HWParams = AO.(ifam).Monitor.HW2PhysicsParams;

AO.(ifam).Setpoint = AO.(ifam).Monitor;
AO.(ifam).Desired  = AO.(ifam).Monitor;

end

%% Quadrupoles QP

clear varlist;

varlist.QP1L={1 [ 1  1 ] 'TL/ME/QP.010   ' 1 'QP1L' [0 270]};

varlist.QP2L={1 [ 1  1 ] 'TL/ME/QP.020   ' 1 'QP2L' [0 270]};

varlist.QP3L={1 [ 1  1 ] 'TL/ME/QP.030   ' 1 'QP3L' [-270 +0]};

varlist.QP4L={1 [ 1  1 ] 'TL/ME/QP.040   ' 1 'QP4L' [0 270]};

varlist.QP5L={1 [ 1  1 ] 'TL/ME/QP.050   ' 1 'QP5L' [0 270]};

varlist.QP6L={1 [ 1  1 ] 'TL/ME/QP.060   ' 1 'QP6L' [-270 +0]};

varlist.QP7L={1 [ 1  1 ] 'TL/ME/QP.070   ' 1 'QP7L' [0 270]};

for k = 1:7
    ifam = ['QP', num2str(k), 'L'];
    
    AO.(ifam).FamilyName                 = ifam;
    AO.(ifam).FamilyType                 = 'QUAD';
    AO.(ifam).MemberOf                   = {'MachineConfig'; 'QUAD'; 'Magnet'; 'Archivable'};
    AO.(ifam).Monitor.Mode               = Mode;
    AO.(ifam).Monitor.DataType           = 'Scalar';
    AO.(ifam).Monitor.Units              = 'Hardware';
    AO.(ifam).Monitor.HWUnits            = 'A';
    AO.(ifam).Monitor.PhysicsUnits       = 'meter^-2';
    AO.(ifam).Monitor.HW2PhysicsFcn      = @amp2k;
    AO.(ifam).Monitor.Physics2HWFcn      = @k2amp;

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
    
    AO.(ifam).Monitor.Handles(:,1) = NaN*ones(devnumber,1);
    
    HW2PhysicsParams = magnetcoefficients(AO.(ifam).FamilyName);
    Physics2HWParams = magnetcoefficients(AO.(ifam).FamilyName);
    
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
    
    setao(AO);   
end



% ifam = 'QP';
% 
% AO.(ifam).FamilyName             = ifam;
% AO.(ifam).MemberOf               = {'MachineConfig'; 'Magnet'; 'QUAD'; 'Archivable'};
% AO.(ifam).Mode                   = Mode;
% 
% for ik = 1:7    
%     AO.(ifam).DeviceName{ik}  = ['TL/ME/QP.0' num2str(ik) '0'];
%     AO.(ifam).CommonNames{ik} = [ifam '.' num2str(ik)];
%     AO.(ifam).DeviceList(ik,:) = [1 ik];
% end
% AO.(ifam).DeviceName             = AO.(ifam).DeviceName';
% AO.(ifam).CommonNames            = AO.(ifam).CommonNames';
% AO.(ifam).Monitor.Range(:,:)     = [0 270;0 270;-270 0;0 270;0 270;-270 0;0 270]; %
% nb                               = length(AO.(ifam).DeviceName);
% AO.(ifam).Monitor.TangoNames     = strcat(AO.(ifam).DeviceName, '/current');
% 
% AO.(ifam).Status                 = ones(nb,1);
% AO.(ifam).Monitor.ModelVal       = zeros(1,nb);
% AO.(ifam).Monitor.TangoVal       = AO.(ifam).Monitor.ModelVal;
% AO.(ifam).ElementList            = 1:nb;
% 
% AO.(ifam).Monitor.Mode           = Mode;
% AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(nb,1);
% AO.(ifam).Monitor.DataType       = 'Scalar';
% AO.(ifam).Monitor.Units          = 'Hardware';
% AO.(ifam).Monitor.HWUnits        = 'ampere';
% AO.(ifam).Monitor.PhysicsUnits   = 'radian';
% AO.(ifam).Monitor.HW2PhysicsFcn = @amp2k;
% AO.(ifam).Monitor.Physics2HWFcn = @k2amp;
% 
% C = magnetcoefficients(AO.(ifam).FamilyName);
% 
% for ii=1:nb,
%     if ii == 3 || ii == 6
%         % Defocusing quads
%         AO.(ifam).Monitor.HW2PhysicsParams{1}(ii,:)  = C.*[1 -1 1 -1 1 -1 1 -1];
%         AO.(ifam).Monitor.Physics2HWParams{1}(ii,:)  = C.*[1 -1 1 -1 1 -1 1 -1];
%     else
%         % Focusing quad
%         AO.(ifam).Monitor.HW2PhysicsParams{1}(ii,:)  = C;
%         AO.(ifam).Monitor.Physics2HWParams{1}(ii,:)  = C;
%     end
% end
% 
% %AO.(ifam).Monitor.Range(:,:) = repmat([-5 5],nb,1); % 10 A for 0.8 mrad
% AO.(ifam).Setpoint = AO.(ifam).Monitor;
% AO.(ifam).Desired = AO.(ifam).Monitor;
% AO.(ifam).Setpoint.TangoNames(:,:)  = strcat(AO.(ifam).DeviceName,'/currentPM');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Horizontal Correctors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ifam = 'HCOR';
AO.(ifam).FamilyName           = ifam;
AO.(ifam).FamilyType           = 'COR';
AO.(ifam).MemberOf             = {'MachineConfig'; 'Magnet'; 'COR'; 'HCOR'; 'Archivable'};

for ik = 1:4    
    AO.(ifam).DeviceName{ik}  = ['TL/ME/STR.0' num2str(ik) '0'];
    AO.(ifam).CommonNames{ik} = [ifam num2str(ik)];
    AO.(ifam).DeviceList(ik,:) = [1 ik];
end
AO.(ifam).DeviceName             = AO.(ifam).DeviceName';
AO.(ifam).CommonNames            = AO.(ifam).CommonNames';


nb                         = length(AO.(ifam).DeviceName);
AO.(ifam).Monitor.Range(:,:)     = repmat([-8 8],nb,1);
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/current');
AO.(ifam).Status               = ones(nb,1);
AO.(ifam).Monitor.ModelVal     = zeros(1,nb);
AO.(ifam).Monitor.TangoVal     = AO.(ifam).Monitor.ModelVal;
AO.(ifam).ElementList           = 1:nb;

AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(nb,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'radian';
AO.(ifam).Monitor.HW2PhysicsFcn  = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn  = @k2amp;
[C Leff Type coefficients] = magnetcoefficients(AO.(ifam).FamilyName );
AO.(ifam).Monitor.HW2PhysicsParams{1}(1,:) = coefficients/Leff;
AO.(ifam).Monitor.Physics2HWParams = AO.(ifam).Monitor.HW2PhysicsParams;

AO.(ifam).Setpoint = AO.(ifam).Monitor;
%AO.(ifam).Monitor.TangoNames     = strcat(AO.(ifam).DeviceName,
%'/currentPM');

%need to modify when ThomX is ready
AO.(ifam).Setpoint.Tolerance(:,:)    = 1e-2*ones(devnumber,1);
AO.(ifam).Setpoint.DeltaRespMat(:,:) = ones(devnumber,1)*5e-6*2; % 2*5 urad (half used for kicking)

setao(AO);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Vertical Correctors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ifam = 'VCOR';

AO.(ifam).FamilyName           = ifam;
AO.(ifam).FamilyType           = 'COR';
AO.(ifam).MemberOf             = {'MachineConfig'; 'Magnet'; 'COR'; 'VCOR'; 'Archivable'};
AO.(ifam).Mode                 = Mode;

for ik = 1:4,
    AO.(ifam).DeviceName{ik}  = ['TL/ME/STR.0' num2str(ik) '0'];
    AO.(ifam).CommonNames{ik} = [ifam num2str(ik)];
    AO.(ifam).DeviceList(ik,:) = [1 ik];
end
AO.(ifam).DeviceName             = AO.(ifam).DeviceName';
AO.(ifam).CommonNames            = AO.(ifam).CommonNames';

nb                             = length(AO.(ifam).DeviceName);
AO.(ifam).Monitor.Range(:,:)     = repmat([-8 8
    ],nb,1);
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/current');
AO.(ifam).Status               = ones(nb,1);
AO.(ifam).Monitor.ModelVal     = zeros(1,nb);
AO.(ifam).Monitor.TangoVal     = AO.(ifam).Monitor.ModelVal;
AO.(ifam).ElementList          = 1:nb;

AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(nb,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'radian';
AO.(ifam).Monitor.HW2PhysicsFcn  = @amp2k;
AO.(ifam).Monitor.Physics2HWFcn  = @k2amp;
[C Leff Type coefficients] = magnetcoefficients(AO.(ifam).FamilyName );
AO.(ifam).Monitor.HW2PhysicsParams{1}(1,:) = coefficients/Leff;
AO.(ifam).Monitor.Physics2HWParams = AO.(ifam).Monitor.HW2PhysicsParams;

AO.(ifam).Setpoint = AO.(ifam).Monitor;
%AO.(ifam).Monitor.TangoNames     = strcat(AO.(ifam).DeviceName, '/currentPM');

%need to modify when ThomX is ready
AO.(ifam).Setpoint.Tolerance(:,:)    = 1e-2*ones(devnumber,1);
AO.(ifam).Setpoint.DeltaRespMat(:,:) = ones(devnumber,1)*5e-6*2; % 2*5 urad (half used for kicking)

setao(AO);

%%%%%%%%%%%%%%%%%%
%% CYCLAGE
%%%%%%%%%%%%%%%%%

%% cycleramp For dipole magnet

ifam = 'CycleBEND1';

AO.(ifam).FamilyName             = 'CycleBEND1';
AO.(ifam).MemberOf               = {'CycleBEND'; 'CycleBEND1';'Cyclage'};
AO.(ifam).Mode                   = Mode;
%AO.(ifam).GroupId                = tango_group_create('Dipole'); 
AO.(ifam).DeviceName             = 'LT1/AE/cycleD.1';
%add devices to group
%tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName);
AO.(ifam).Inom = 180;
AO.(ifam).Imax = 250;
AO.(ifam).Status = 1;

ifam = 'CycleBEND2';

AO.(ifam).FamilyName             = 'CycleBEND2';
AO.(ifam).MemberOf               = {'CycleBEND';'CycleBEND1'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
%AO.(ifam).GroupId                = tango_group_create('Dipole'); 
AO.(ifam).DeviceName             = 'LT1/AE/cycleD.1';
%add devices to group
%tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName);
AO.(ifam).Inom = 180;
AO.(ifam).Imax = 250;
AO.(ifam).Status = 1;
%% cycleramp For H-corrector magnets
ifam = 'CycleHCOR';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {'CycleCOR';'CycleHCOR'; 'CycleCH'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
%AO.(ifam).GroupId                = tango_group_create('HCOR'); 
AO.(ifam).DeviceName             = {'TL/AE/cycleHCOR.1'; 'LT1/AE/cycleHCR.2'; 'LT1/AE/cycleHCOR.3';'LT1/AE/cycleHCOR.4'};
AO.(ifam).DeviceList             = [1 1; 1 2; 1 3; 1 4];
AO.(ifam).ElementList            = (1:4)';
%tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
AO.(ifam).Inom = [1 2 3 4];
AO.(ifam).Imax = 1.5*ones(1,4);
AO.(ifam).Status = ones(4,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(4,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'radian';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

%% cycleramp For V-corrector magnets
ifam = 'CycleVCOR';

AO.(ifam).FamilyName             = ifam;
AO.(ifam).MemberOf               = {'CycleCOR';'CycleVCOR'; 'CycleCV'; 'Cyclage'};
AO.(ifam).Mode                   = Mode;
%AO.(ifam).GroupId                = tango_group_create('VCOR'); 
AO.(ifam).DeviceName             = {'TL/AE/cycleVCOR.1'; 'LT1/AE/cycleVCOR.2'; 'LT1/AE/cycleVCOR.3';'LT1/AE/cycleVCOR.4'};
AO.(ifam).DeviceList             = [1 1; 1 2; 1 3; 1 4];
AO.(ifam).ElementList            = (1:4)';
%tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
AO.(ifam).Inom = [1 2 3 4];
AO.(ifam).Imax = 1.5*ones(1,4);
AO.(ifam).Status = ones(4,1);
AO.(ifam).Monitor.Mode           = Mode;
AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(4,1);
AO.(ifam).Monitor.DataType       = 'Scalar';
AO.(ifam).Monitor.Units          = 'Hardware';
AO.(ifam).Monitor.HWUnits        = 'ampere';
AO.(ifam).Monitor.PhysicsUnits   = 'radian';
AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');


%% cycleramp For quadrupoles magnets
for i=1:7
    ifam = ['CycleQP', num2str(i),'L'];

    AO.(ifam).FamilyName             = ifam;
    AO.(ifam).MemberOf               = {'CycleQP'; 'Cyclage'};
    AO.(ifam).Mode                   = Mode;
%    AO.(ifam).GroupId                = tango_group_create('Quadrupole'); 
    AO.(ifam).DeviceList             = [1 1;];
    AO.(ifam).ElementList            = (1:1)';
    AO.(ifam).DeviceName             = {'LT1/AE/cycleQ.1'};
    %add devices to group
  %  tango_group_add(AO.(ifam).GroupId, AO.(ifam).DeviceName');
    %AO.(ifam).Imax = 8*ones(1,7);
    % modification mars 2006
    AO.(ifam).Imax = [8];
    AO.(ifam).Status = ones(1,1);
    AO.(ifam).Monitor.Mode           = Mode;
    AO.(ifam).Monitor.Handles(:,1)   = NaN*ones(1,1);
    AO.(ifam).Monitor.DataType       = 'Scalar';
    AO.(ifam).Monitor.Units          = 'Hardware';
    AO.(ifam).Monitor.HWUnits        = 'ampere';
    AO.(ifam).Monitor.PhysicsUnits   = 'radian';
    AO.(ifam).Monitor.TangoNames   = strcat(AO.(ifam).DeviceName, '/totalProgression');

end

% %%%%%%%%%%%%%%%%%%
% %%% Diagnostics
% %%%%%%%%%%%%%%%%%%
% 
% For ThomX, ICT?
% %% Charge Monitor - Moniteur de charge
% ifam = 'MC';
% 
% AO.(ifam).FamilyName             = 'MC';
% AO.(ifam).MemberOf               = {'Diag'; 'MC'; 'Archivable'};
% AO.(ifam).Mode                   = Mode;
% AO.(ifam).DeviceName             = {'LT2/DG/MC'; 'LT2/DG/MC'};
% AO.(ifam).CommonNames            = ['mc1';'mc2';];
% AO.(ifam).DeviceList(:,:)        = [1 1; 1 2];
% AO.(ifam).ElementList            = [1 2]';
% AO.(ifam).Status                 = [1 1]';
% AO.(ifam).Monitor.TangoNames     = [strcat(AO.(ifam).DeviceName(1,:), '/qIct1'); ...
%                                     strcat(AO.(ifam).DeviceName(2,:), '/qIct2')];
% AO.(ifam).Monitor.Mode           = Mode;
% AO.(ifam).Monitor.Handles(:,1)   = [NaN; NaN]';
% AO.(ifam).Monitor.DataType       = 'Vector';
% AO.(ifam).Monitor.Units          = 'Hardware';
% AO.(ifam).Monitor.HWUnits        = 'nC';
% AO.(ifam).Monitor.PhysicsUnits   = 'nC';
% AO.(ifam).Monitor.HW2PhysicsParams = 1.0;
% AO.(ifam).Monitor.Physics2HWParams = 1.0;

%%%%%%%%%%%%%%%%%%
%% Vacuum system
%%%%%%%%%%%%%%%%%%

%% IonPump
% ifam = 'PI';
% AO.(ifam).FamilyName           = 'PI';
% AO.(ifam).MemberOf             = {'PlotFamily'; 'IonPump'; 'Pressure'; 'Archivable'};
% AO.(ifam).Monitor.Mode         = Mode;
% AO.(ifam).Monitor.DataType     = 'Scalar';
% 
% for ik = 1:3   
%    
%         AO.(ifam).DeviceName{ik}  = ['TL/VA/PP.0' num2str(ik) '0'];
%    
%     AO.(ifam).CommonNames{ik} = ['PP.0' num2str(ik) '0'];
%     AO.(ifam).DeviceList(ik,:) = [1 ik];
% end
% 
% nb = size(AO.(ifam).DeviceList,1);
% AO.(ifam).Status                   = ones(nb,1);
% AO.(ifam).DeviceName               = AO.(ifam).DeviceName';
% AO.(ifam).CommonNames              = AO.(ifam).CommonNames';
% AO.(ifam).ElementList              = (1:nb)';
% AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(nb,1);
% AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/pressure');
% AO.(ifam).Monitor.HW2PhysicsParams = 1;
% AO.(ifam).Monitor.Physics2HWParams = 1;
% AO.(ifam).Monitor.Units            = 'Hardware';   
% AO.(ifam).Monitor.HWUnits          = 'mBar';
% AO.(ifam).Monitor.PhysicsUnits     = 'mBar';
% 
% %% PenningGauge
% ifam = 'PEG';
% AO.(ifam).FamilyName           = 'PEG';
% AO.(ifam).MemberOf             = {'PlotFamily'; 'PenningGauge'; 'Pressure'; 'Archivable'};
% AO.(ifam).Monitor.Mode         = Mode;
% AO.(ifam).Monitor.DataType     = 'Scalar';
% 
% for ik = 1:3 
%     AO.(ifam).DeviceName{ik}  = ['TL/VA/PEG.0' num2str(ik) '0'];
%     AO.(ifam).CommonNames{ik} = ['PEG.0' num2str(ik) '0'];
%     AO.(ifam).DeviceList(ik,:) = [1 ik];
% end
% 
% nb = size(AO.(ifam).DeviceList,1);
% AO.(ifam).Status                   = ones(nb,1);
% AO.(ifam).DeviceName               = AO.(ifam).DeviceName';
% AO.(ifam).CommonNames              = AO.(ifam).CommonNames';
% AO.(ifam).ElementList              = (1:nb)';
% AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(nb,1);
% AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/pressure');
% AO.(ifam).Monitor.HW2PhysicsParams = 1;
% AO.(ifam).Monitor.Physics2HWParams = 1;
% AO.(ifam).Monitor.Units            = 'Hardware';   
% AO.(ifam).Monitor.HWUnits          = 'mBar';
% AO.(ifam).Monitor.PhysicsUnits     = 'mBar';
% 
% %% PiraniGauge
% ifam = 'PIG';
% AO.(ifam).FamilyName           = 'PIG';
% AO.(ifam).MemberOf             = {'PlotFamily'; 'PiraniGauge'; 'Pressure'; 'Archivable'};
% AO.(ifam).Monitor.Mode         = Mode;
% AO.(ifam).Monitor.DataType     = 'Scalar';
% 
% for ik = 1:3    
%     AO.(ifam).DeviceName{ik}  = ['TL/VA/PIG.0' num2str(ik) '0'];
%     AO.(ifam).CommonNames{ik} = ['PIG.0' num2str(ik) '0'];
%     AO.(ifam).DeviceList(ik,:) = [1 ik];
% end
% 
% nb = size(AO.(ifam).DeviceList,1);
% AO.(ifam).Status                   = ones(nb,1);
% AO.(ifam).DeviceName               = AO.(ifam).DeviceName';
% AO.(ifam).CommonNames              = AO.(ifam).CommonNames';
% AO.(ifam).ElementList              = (1:nb)';
% AO.(ifam).Monitor.Handles(:,1)     = NaN*ones(nb,1);
% AO.(ifam).Monitor.TangoNames       = strcat(AO.(ifam).DeviceName, '/pressure');
% AO.(ifam).Monitor.HW2PhysicsParams = 1;
% AO.(ifam).Monitor.Physics2HWParams = 1;
% AO.(ifam).Monitor.Units            = 'Hardware';   
% AO.(ifam).Monitor.HWUnits          = 'mBar';
% AO.(ifam).Monitor.PhysicsUnits     = 'mBar';

%% Synchronisation
% ifam = 'SYNC'
% AO.(ifam).FamilyName           = 'SYNC';
% AO.(ifam).MemberOf             = {'Timing'};
% AO.(ifam).Monitor.Mode         = Mode;
% AO.(ifam).Monitor.DataType     = 'Scalar';
% 
% AO.(ifam).DeviceName{ik}  = ['LT2/VI/JPIR.' num2str(ik)];
% 
% AO.(ifam).Monitor.HWUnits      = 's';

setao(AO);

% The operational mode sets the path, filenames, and other important params
% Run setoperationalmode after most of the AO is built so that the Units and Mode fields
% can be set in setoperationalmode

setoperationalmode(OperationalMode);

%return;
%======================================================================
%======================================================================
%% Append Accelerator Toolbox information
%======================================================================
%======================================================================
disp('** Initializing Accelerator Toolbox information');

AO = getao;

ATindx = atindex(THERING);  %structure with fields containing indices

s = findspos(THERING,1:length(THERING)+1)';

%% HORIZONTAL CORRECTORS
ifam = ('HCOR');
AO.(ifam).AT.ATType  = ifam;
AO.(ifam).AT.ATIndex = ATindx.(ifam)(:);
AO.(ifam).AT.ATIndex = AO.(ifam).AT.ATIndex(AO.(ifam).ElementList);   %not all correctors used
AO.(ifam).Position   = s(AO.(ifam).AT.ATIndex);

%% VERTICAL CORRECTORS
ifam = ('VCOR');
AO.(ifam).AT.ATType  = ifam;
AO.(ifam).AT.ATIndex = ATindx.(ifam)(:);
AO.(ifam).AT.ATIndex = AO.(ifam).AT.ATIndex(AO.(ifam).ElementList);   %not all correctors used
AO.(ifam).Position   = s(AO.(ifam).AT.ATIndex);  

%% BENDING magnets
ifam = ('BEND1');
AO.(ifam).AT.ATType  = 'BEND';
AO.(ifam).AT.ATIndex = ATindx.(ifam)(:);
AO.(ifam).Position   = reshape(s(AO.(ifam).AT.ATIndex),1,4);

ifam = ('BEND2');
AO.(ifam).AT.ATType  = 'BEND';
AO.(ifam).AT.ATIndex = ATindx.(ifam)(:);
AO.(ifam).Position   = reshape(s(AO.(ifam).AT.ATIndex),1,1);


%% QUADRUPOLES
for k = 1:7
    ifam = ['QP' num2str(k) 'L'];
    
AO.(ifam).AT.ATType  = 'QUAD';
AO.(ifam).AT.ATIndex = eval(['ATindx.' ifam '(:)']);
AO.(ifam).AT.ATIndex = reshape(AO.(ifam).AT.ATIndex,1,1)';
AO.(ifam).Position   = s(AO.(ifam).AT.ATIndex);
end

% Save AO
setao(AO);

if iscontrolroom
    switch2online;
else
    switch2sim;
end
