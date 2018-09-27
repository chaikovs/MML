function res=idGetParamForUndSoleil(Types)
% idGetParamForUndSoleil - Returns a (1xn) struct array containing : 
%
% INPUT
% Types can be :    - a string containing 'InVac' and/or 'Apple2' and/or 'EM'
%                   - 'all' => all IDs (even those unknown or empty Straight Sections)
%                   - ''    => usual types : 'InVac', 'Apple2' and 'EM'
%                   - or you can specify insertion Name ex: idGetParamForUndSOLEIL('U20_PROXIMA1')
%  OUTPUT
%  1. a structure
%       - undulator name
%       - Storage Ring cell number
%       - straight section type
%       - sectLenBwBPMs = 2.*3.14155; %[m] straight section length between BPMs
%       - idCenPos = 1.333; %[m] center longitudinal position of the ID with respect to the straight section center
%       - idLen = 1.8; %[m] ID length
%       - idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
%       - indUpstrBPM = dev2elem('BPMx', [8 1]); %absolute index of BPM at the upstream edge of the straight section where the ID is located
%       - indRelBPMs = [8 1;8 2]; %relative indexes of upstream and downstream BPMs of the straight section where the ID is located
%       - DServName     TangoName of Device
%       - StandByStr    String when undulator is ready for new setpoint 
%       - CorCurAttr    String Array for Corrector Attribute
%       - Period     Magnetic period
%       - NbPeriod   Number of period
%       - Bx0   Maximum Vertical MagneticField
%       - Bz0   Maximum Horizontal MagneticField
%       - MagLen   Magnetic length [m]
%       - XMainAttr {tangoAttribute , Minvalue , Maxvalue}
%       - ZMainAttr {tangoAttribute , Minvalue , Maxvalue}
%       - Bx function handle to provide Horizontal magnetfield
%       - Bz function handle to provide Vertical magnetfield
%       - P Function handle to  provide radiated power 
% See Also idGetListOfInsertionDevices ; idGetGeomParamForUndSOLEIL; idGetUndDServer;

%
%% Written by A.Bence 03/10/2015


%% List of undulators
    
    
    % ANS-C03
    
    Line=1;
    ListOfInsertionDevices(Line).name='WSV50_PSICHE';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=3;
    ListOfInsertionDevices(Line).straight='C';
    ListOfInsertionDevices(Line).type='InVac';
    %geo
    ListOfInsertionDevices(Line).indRelBPMs= [3 5;3 6];%relative indexes of upstream and downstream BPMs of the straight section where the ID is located
    ListOfInsertionDevices(Line).sectLenBwBPMs= diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM= dev2elem('BPMx',ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).idCenPos= 0; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).idLen= 2; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst= 0.1; %[m] offset from ID edge to effective position of a "kick"
    %tango
    ListOfInsertionDevices(Line).DServName= 'ANS-C03/EI/C-WSV50'; %DServName
    ListOfInsertionDevices(Line).StandByStr= 'ANS-C03/EI/C-WSV50_MOTORSCONTROL: 	STANDBY'; %StandByStr
	ListOfInsertionDevices(Line).CorCurAttr= {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'}; %to check %CorCurAttr
    %Mag
    ListOfInsertionDevices(Line).Period = 50;
    ListOfInsertionDevices(Line).NbPeriod = 38;
    ListOfInsertionDevices(Line).Bx0 = 0;
    ListOfInsertionDevices(Line).Bz0 = 2.1;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr={};
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',5.5 ,30}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = 0;
    ListOfInsertionDevices(Line).Bz = @() Bz_InVac(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    
    % ANS-C04
    
    Line=2;
    ListOfInsertionDevices(Line).name='HU80_PLEIADES';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=4;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='Apple2';
    ListOfInsertionDevices(Line).indRelBPMs= [4 1;4 2];%relative indexes of upstream and downstream BPMs of the straight section where the ID is located
    ListOfInsertionDevices(Line).sectLenBwBPMs= diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM= dev2elem('BPMx',ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).idCenPos=  -1.83; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).idLen= 1.8; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst= 0.2; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).DServName= 'ANS-C04/EI/M-HU80.1'; %Name of Level 2 DServer
    ListOfInsertionDevices(Line).StandByStr= 'current device state is: ON [power section enabled - ready for cmds]';%'ANS-C04/EI/M-HU80.1_MotorsControl : STANDBY'; 
	ListOfInsertionDevices(Line).CorCurAttr= {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'};
    ListOfInsertionDevices(Line).Period = 80;
    ListOfInsertionDevices(Line).NbPeriod = 19;
    ListOfInsertionDevices(Line).Bx0 = 0.7;
    ListOfInsertionDevices(Line).Bz0 = 0.92;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'phase',-ListOfInsertionDevices(Line).Period/2 ,ListOfInsertionDevices(Line).Period/2};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',15.5 ,240}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_Apple2(Line);;
    ListOfInsertionDevices(Line).Bz = @() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    Line=3;
    ListOfInsertionDevices(Line).name='HU256_PLEIADES';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=4;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='EM';
    ListOfInsertionDevices(Line).indRelBPMs = [4 1;4 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).idCenPos = 0.8945; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).idLen = 3.392; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).DServName = 'ANS-C04/EI/M-HU256.2';
    %ListOfInsertionDevices(Line).StandByStr= ''; 
	%ListOfInsertionDevices(Line).CorCurAttr= ;
    ListOfInsertionDevices(Line).Period = 256;
    ListOfInsertionDevices(Line).NbPeriod = 12;
    ListOfInsertionDevices(Line).Bx0 = 0.2764;
    ListOfInsertionDevices(Line).Bz0 = 0.3618;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'currentBX1',0,275;'currentBX2',0,275};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'currentBZP',-200 ,200}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_HU256(Line);
    ListOfInsertionDevices(Line).Bz = @() Bz_HU256(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    
    % ANS-C05
    
    Line=4;
    ListOfInsertionDevices(Line).name='HU640_DESIRS';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=5;
    ListOfInsertionDevices(Line).straight='L';
    ListOfInsertionDevices(Line).type='EM';
    ListOfInsertionDevices(Line).indRelBPMs = [5 1;5 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).idCenPos = 0; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).idLen = 10.4; %to check ! [m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.32; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).DServName = 'ANS-C05/EI/L-HU640';
    %StandByStr = '- ANS-C05/EI/L-HU640_PS1: 	ON\n- ANS-C05/EI/L-HU640_PS2: 	ON\n- ANS-C05/EI/L-HU640_PS3: 	ON'; 
    ListOfInsertionDevices(Line).StandByStr = '- ANS-C05/EI/L-HU640_PS1: 	ON'; %to correct later!!!
    ListOfInsertionDevices(Line).Period = 640;
    ListOfInsertionDevices(Line).NbPeriod = 14;
    ListOfInsertionDevices(Line).Bx0 = 0.09;
    ListOfInsertionDevices(Line).Bz0 = 0.11;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'currentPS2',-440,440;'currentPS3',-360,360};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'currentPS1',-600 ,600}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_HU640(Line); 
    ListOfInsertionDevices(Line).Bz = @() Bz_HU640(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    % ANS-C06
    
    Line=5;
    ListOfInsertionDevices(Line).name='W164_PUMA'; % Femto-Slicing / Puma (not defined yet)
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell= 6;
    ListOfInsertionDevices(Line).straight= 'M';
    ListOfInsertionDevices(Line).type= 'WIGGLER';
    ListOfInsertionDevices(Line).indRelBPMs = [6 1;6 2];
    ListOfInsertionDevices(Line).idCenPos = 0; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).idLen = 3.348; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.1; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C06/EI/M-W164';
    ListOfInsertionDevices(Line).StandByStr = 'ANS-C06/EI/M-W164_MOTORSCONTROL: 	STANDBY';
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'}; %to check 
    ListOfInsertionDevices(Line).Period = 164;
    ListOfInsertionDevices(Line).NbPeriod = 0;
    ListOfInsertionDevices(Line).Bx0 = 0; % warning('W164_PUMA B0 non renseigné');%!!!!!!!!!!!!!!!!!!!!!!
    ListOfInsertionDevices(Line).Bz0 = 0; % warning('W164_PUMA B0 non renseigné');%!!!!!!!!!!!!!!!!!!!!!!
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'phase',-ListOfInsertionDevices(Line).Period/2 ,ListOfInsertionDevices(Line).Period/2};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',14.7 ,235}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_Apple2(Line);;
    ListOfInsertionDevices(Line).Bz = @() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P = @() Puissance(Line);
    
    
    Line=6;
    ListOfInsertionDevices(Line).name='U20_CRISTAL';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=6;
    ListOfInsertionDevices(Line).straight='C';
    ListOfInsertionDevices(Line).type='InVac';
    ListOfInsertionDevices(Line).indRelBPMs = [6 5;6 6];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).idCenPos = 0; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).idLen = 2; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.1; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).DServName = 'ANS-C06/EI/C-U20';
    ListOfInsertionDevices(Line).StandByStr = 'ANS-C06/EI/C-U20_MOTORSCONTROL: 	STANDBY';
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'}; %to check    
    ListOfInsertionDevices(Line).Period = 20;
    ListOfInsertionDevices(Line).NbPeriod = 98;
    ListOfInsertionDevices(Line).Bx0 = 0;
    ListOfInsertionDevices(Line).Bz0 = 0.97;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr={};
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',5.5 ,30}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = 0;
    ListOfInsertionDevices(Line).Bz = @() Bz_InVac(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    % ANS-C07
    
    Line=7;
    ListOfInsertionDevices(Line).name='HU52_DEIMOS';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=7;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='Apple2';
    ListOfInsertionDevices(Line).idLen = 1.8; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).idCenPos = 0.0; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).indRelBPMs = [7 1;7 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C07/EI/M-HU52.1';
    ListOfInsertionDevices(Line).StandByStr = 'current device state is: ON [power section enabled - ready for cmds]';%'ANS-C07/EI/M-HU52.1_MotorsControl : STANDBY'; 
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'};
    ListOfInsertionDevices(Line).Period = 52;
    ListOfInsertionDevices(Line).NbPeriod = 30;
    ListOfInsertionDevices(Line).Bx0 = 0.5;
    ListOfInsertionDevices(Line).Bz0 = 0.74;
   ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'phase',-ListOfInsertionDevices(Line).Period/2 ,ListOfInsertionDevices(Line).Period/2};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',15.5 ,240}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_Apple2(Line);;
    ListOfInsertionDevices(Line).Bz = @() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    
    Line=8;
    ListOfInsertionDevices(Line).name='HU65_DEIMOS';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=7;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='EMPHU';
    ListOfInsertionDevices(Line).idCenPos = 1.626; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).indRelBPMs = [7 1;7 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).idLen = 1.8; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).DServName = 'ANS-C07/EI/M-HU65.2';
    %ListOfInsertionDevices(Line).StandByStr= ''; 
	%ListOfInsertionDevices(Line).CorCurAttr= ;
    ListOfInsertionDevices(Line).Period = 65;
    ListOfInsertionDevices(Line).NbPeriod = 26;
    ListOfInsertionDevices(Line).Bx0 = 0;%warning('HU65_PUMA B0 non renseigné');%!!!!!!!!!!!!!!!!!!!!!!
    ListOfInsertionDevices(Line).Bz0 = 0;%warning('HU65_PUMA B0 non renseigné');%!!!!!!!!!!!!!!!!!!!!!!
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {};
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',15.5 ,240}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = 0;%@() Bx_Apple2(Line);;
    ListOfInsertionDevices(Line).Bz = NaN;%@() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    
    Line=9;
    ListOfInsertionDevices(Line).name='U20_GALAXIES';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=7;
    ListOfInsertionDevices(Line).straight='C';
    ListOfInsertionDevices(Line).type='InVac';
    ListOfInsertionDevices(Line).idCenPos = 0; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).idLen = 2; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.1; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).indRelBPMs = [7 5;7 6];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C07/EI/C-U20';
    ListOfInsertionDevices(Line).StandByStr = 'ANS-C07/EI/C-U20_MOTORSCONTROL: 	STANDBY';
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'}; %to check 
    ListOfInsertionDevices(Line).Period = 20;
    ListOfInsertionDevices(Line).NbPeriod = 98;
    ListOfInsertionDevices(Line).Bx0 = 0;
    ListOfInsertionDevices(Line).Bz0 = 0.97;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr={};
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',5.5 ,30}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = 0;
    ListOfInsertionDevices(Line).Bz = @() Bz_InVac(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    % ANS-C08
    
    Line=10;
    ListOfInsertionDevices(Line).name='HU44_TEMPO';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=8;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='Apple2';
    ListOfInsertionDevices(Line).idLen = 1.8; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).idCenPos = -0.4165; % modified the 12/11/08 -0.4165; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).indRelBPMs = [8 1;8 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C08/EI/M-HU44.1';
    ListOfInsertionDevices(Line).StandByStr = 'current device state is: ON [power section enabled - ready for cmds]';%'ANS-C08/EI/M-HU44.1_MotorsControl : STANDBY'; 
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'};
    ListOfInsertionDevices(Line).Period = 44;
    ListOfInsertionDevices(Line).NbPeriod = 36;
    ListOfInsertionDevices(Line).Bx0 = 0.45;
    ListOfInsertionDevices(Line).Bz0 = 0.68;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'phase',-ListOfInsertionDevices(Line).Period/2 ,ListOfInsertionDevices(Line).Period/2};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',15.5 ,240}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_Apple2(Line);;
    ListOfInsertionDevices(Line).Bz = @() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    
    Line=11;
    ListOfInsertionDevices(Line).name='HU80_TEMPO';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=8;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='Apple2';
    ListOfInsertionDevices(Line).idLen = 1.8; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).idCenPos = 1.3325; % modified the 12/11/08 1.333; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).indRelBPMs = [8 1;8 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C08/EI/M-HU80.2'; %Name of Level 2 DServer
    ListOfInsertionDevices(Line).StandByStr = 'current device state is: ON [power section enabled - ready for cmds]';%'ANS-C08/EI/M-HU80.2_MotorsControl : STANDBY';
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'};
    ListOfInsertionDevices(Line).Period = 80;
    ListOfInsertionDevices(Line).NbPeriod = 19;
    ListOfInsertionDevices(Line).Bx0 = 0.7;
    ListOfInsertionDevices(Line).Bz0 = 0.92;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'phase',-ListOfInsertionDevices(Line).Period/2 ,ListOfInsertionDevices(Line).Period/2};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',15.5 ,240}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_Apple2(Line);;
    ListOfInsertionDevices(Line).Bz = @() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    % ANS-C09
    
%     Line=12;
%     ListOfInsertionDevices(Line).name='';    % Not defined yet
%     ListOfInsertionDevices(Line).cell=9;
%     ListOfInsertionDevices(Line).straight='L';
%     ListOfInsertionDevices(Line).type='';
    
    % ANS-C10
    
    Line=13;
    ListOfInsertionDevices(Line).name='HU42_HERMES';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=10;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='Apple2';
    ListOfInsertionDevices(Line).idLen = 1.8; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).idCenPos = 0.0; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).indRelBPMs = [10 1;10 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C10/EI/M-HU42.1';
    ListOfInsertionDevices(Line).StandByStr = 'current device state is: ON [power section enabled - ready for cmds]';%'ANS-C10/EI/M-HU42.1 : STANDBY'; 
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'};
    ListOfInsertionDevices(Line).Period = 42;
    ListOfInsertionDevices(Line).NbPeriod = 38;
    ListOfInsertionDevices(Line).Bx0 = 0.45;
    ListOfInsertionDevices(Line).Bz0 = 0.67;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'phase',-ListOfInsertionDevices(Line).Period/2 ,ListOfInsertionDevices(Line).Period/2};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',15.5 ,240}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_Apple2(Line);;
    ListOfInsertionDevices(Line).Bz = @() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    Line=14;
    ListOfInsertionDevices(Line).name='HU64_HERMES';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=10;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='Apple2';
    %warning('HU64 definition is not correct. Must be validated by GMI');
    ListOfInsertionDevices(Line).idCenPos = 1.626; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).indRelBPMs = [10 1;10 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).idLen = 1.8; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).DServName = 'ANS-C10/EI/M-HU64.2';
    ListOfInsertionDevices(Line).StandByStr = 'current device state is: ON [power section enabled - ready for cmds]';
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'};
    ListOfInsertionDevices(Line).Period = 64;
    ListOfInsertionDevices(Line).NbPeriod = 24;
    ListOfInsertionDevices(Line).Bx0 = 0.64;
    ListOfInsertionDevices(Line).Bz0 = 0.82;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'phase',-ListOfInsertionDevices(Line).Period/2 ,ListOfInsertionDevices(Line).Period/2};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',15.5 ,240}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_Apple2(Line);;
    ListOfInsertionDevices(Line).Bz = @() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    
    % ANS-C10
    
    Line=15;
    ListOfInsertionDevices(Line).name='U20_PROXIMA1';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=10;
    ListOfInsertionDevices(Line).straight='C';
    ListOfInsertionDevices(Line).type='InVac';
    ListOfInsertionDevices(Line).idCenPos = 0; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).idLen = 2; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.1; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).indRelBPMs = [10 5;10 6];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C10/EI/C-U20';
    ListOfInsertionDevices(Line).StandByStr = 'ANS-C10/EI/C-U20_MOTORSCONTROL: 	STANDBY';
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'}; %to check
    ListOfInsertionDevices(Line).Period = 20;
    ListOfInsertionDevices(Line).NbPeriod = 98;
    ListOfInsertionDevices(Line).Bx0 = 0;
    ListOfInsertionDevices(Line).Bz0 = 0.97;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr={};
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',5.5 ,30}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = 0;
    ListOfInsertionDevices(Line).Bz = @() Bz_InVac(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    % ANS-C11
    
    Line=16;
    ListOfInsertionDevices(Line).name='U24_PROXIMA2A';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=11;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='InVac';
    ListOfInsertionDevices(Line).indRelBPMs = [11 1;11 2];
    ListOfInsertionDevices(Line).idLen = 2; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.1; %[m] offset from ID edge to effective position of a "kick"
    % position de l'onduleur a determiner par Olivier
    ListOfInsertionDevices(Line).idCenPos = 1.52; % 1.8; modified the 12/11/08 %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C11/EI/M-U24';
    ListOfInsertionDevices(Line).StandByStr = 'ANS-C11/EI/M-U24_MOTORSCONTROL: 	STANDBY';
	ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'}; %to check     
    ListOfInsertionDevices(Line).Period = 24;
    ListOfInsertionDevices(Line).NbPeriod = 81;
    ListOfInsertionDevices(Line).Bx0 = 0;
    ListOfInsertionDevices(Line).Bz0 = 0.82;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr={};
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',7.8 ,30}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = 0;
    ListOfInsertionDevices(Line).Bz = @() Bz_InVac(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
%     Line=17;
%     ListOfInsertionDevices(Line).name='';    % PX2B (Not defined yet)
%     ListOfInsertionDevices(Line).cell=11;
%     ListOfInsertionDevices(Line).straight='M';
%     ListOfInsertionDevices(Line).type='InVac';
    
    Line=18;
    ListOfInsertionDevices(Line).name='U20_SWING';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=11;
    ListOfInsertionDevices(Line).straight='C';
    ListOfInsertionDevices(Line).type='InVac';
    ListOfInsertionDevices(Line).idCenPos = 0; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).idLen = 2; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.1; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).indRelBPMs = [11 5;11 6];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C11/EI/C-U20';
    ListOfInsertionDevices(Line).StandByStr = 'ANS-C11/EI/C-U20_MOTORSCONTROL: 	STANDBY';
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'}; %to check
    ListOfInsertionDevices(Line).Period = 20;
    ListOfInsertionDevices(Line).NbPeriod = 98;
    ListOfInsertionDevices(Line).Bx0 = 0;
    ListOfInsertionDevices(Line).Bz0 = 0.97;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr={};
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',5.5 ,30}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = 0;
    ListOfInsertionDevices(Line).Bz = @() Bz_InVac(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);

    % ANS-C12
    
    Line=19;
    ListOfInsertionDevices(Line).name='HU60_ANTARES';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=12;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='Apple2';
    ListOfInsertionDevices(Line).idLen = 1.8; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).idCenPos = -1.83; % modified the 12/11/08 -1.80; % a verifier lors de l'installation[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).indRelBPMs = [12 1;12 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C12/EI/M-HU60.1';
    ListOfInsertionDevices(Line).StandByStr = 'current device state is: ON [power section enabled - ready for cmds]';%'ANS-C12/EI/M-HU60.1_MotorsControl : STANDBY'; 
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'};
    ListOfInsertionDevices(Line).Period = 60;
    ListOfInsertionDevices(Line).NbPeriod = 26;
    ListOfInsertionDevices(Line).Bx0 = 0.83;
    ListOfInsertionDevices(Line).Bz0 = 0.57;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'phase',-ListOfInsertionDevices(Line).Period/2 ,ListOfInsertionDevices(Line).Period/2};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',15.5 ,240}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_Apple2(Line);
    ListOfInsertionDevices(Line).Bz = @() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    Line=20;
    ListOfInsertionDevices(Line).name='HU256_ANTARES';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=12;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='EM';
    ListOfInsertionDevices(Line).idCenPos = 0.8945; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).idLen = 3.392; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).indRelBPMs = [12 1;12 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C12/EI/M-HU256.2';
    %ListOfInsertionDevices(Line).StandByStr= ''; 
	%ListOfInsertionDevices(Line).CorCurAttr= ;
    ListOfInsertionDevices(Line).Period = 256;
    ListOfInsertionDevices(Line).NbPeriod = 12;
    ListOfInsertionDevices(Line).Bx0 = 0.2764;
    ListOfInsertionDevices(Line).Bz0 = 0.3618;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'currentBX1',0,275;'currentBX2',0,275};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'currentBZP',-200 ,200}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_HU256(Line);
    ListOfInsertionDevices(Line).Bz = @() Bz_HU256(Line); 
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    
    % ANS-C13
    
    Line=21;
    %Modif MV le 22/03/2016 pour mesure d'offset
    %ListOfInsertionDevices(Line).name='U20_ANATOMIX';
    ListOfInsertionDevices(Line).name='U20_ANATOMIX';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=13;
    ListOfInsertionDevices(Line).straight='L';
    ListOfInsertionDevices(Line).type='InVac';
    ListOfInsertionDevices(Line).idLen = 2; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.1; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).indRelBPMs = [13 1;13 8];
    ListOfInsertionDevices(Line).idCenPos = -3.373; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C13/EI/L-U20.2';
    ListOfInsertionDevices(Line).StandByStr = 'ANS-C13/EI/L-U20.2_MOTORSCONTROL: 	STANDBY';
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'}; %to check  
    ListOfInsertionDevices(Line).Period = 20;
    ListOfInsertionDevices(Line).NbPeriod = 98;
    ListOfInsertionDevices(Line).Bx0 = 0;
    ListOfInsertionDevices(Line).Bz0 = 1.08;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr={};
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',5.5 ,30}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = 0;
    ListOfInsertionDevices(Line).Bz = @() Bz_InVac(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    Line=22;
    ListOfInsertionDevices(Line).name='U18_NANOSCOPIUM';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=13;
    ListOfInsertionDevices(Line).straight='L';
    ListOfInsertionDevices(Line).type='InVac';
    ListOfInsertionDevices(Line).indRelBPMs = [13 9;13 2];
    ListOfInsertionDevices(Line).idCenPos = 3.3062; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).idLen = 2; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.1; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C13/EI/L-U18.1';
    ListOfInsertionDevices(Line).StandByStr = 'ANS-C13/EI/L-U18.1_MOTORSCONTROL: 	STANDBY';
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'}; %to check
    ListOfInsertionDevices(Line).Period = 18;
    ListOfInsertionDevices(Line).NbPeriod = 106;
    ListOfInsertionDevices(Line).Bx0 = 0;
    ListOfInsertionDevices(Line).Bz0 = 1.15;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr={};
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',5.5 ,30}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = 0;
    ListOfInsertionDevices(Line).Bz = @() Bz_InVac(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    % ANS-C14
    
    Line=23;
    ListOfInsertionDevices(Line).name='HU44_SEXTANTS';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=14;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='Apple2';
    ListOfInsertionDevices(Line).idLen = 1.8; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).idCenPos = 0; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).indRelBPMs = [14 1;14 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C14/EI/M-HU44.1';
    ListOfInsertionDevices(Line).StandByStr = 'current device state is: ON [power section enabled - ready for cmds]';%'ANS-C14/EI/M-HU44.1_MotorsControl : STANDBY'; 
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'};
    ListOfInsertionDevices(Line).Period = 44;
    ListOfInsertionDevices(Line).NbPeriod = 36;
    ListOfInsertionDevices(Line).Bx0 = 0.68;
    ListOfInsertionDevices(Line).Bz0 = 0.45;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'phase',-ListOfInsertionDevices(Line).Period/2 ,ListOfInsertionDevices(Line).Period/2};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',15.5 ,240}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_Apple2(Line);;
    ListOfInsertionDevices(Line).Bz = @() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    
    Line=24;
    ListOfInsertionDevices(Line).name='HU80_SEXTANTS';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=14;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='Apple2';
    ListOfInsertionDevices(Line).idLen = 1.8; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).idCenPos = -1.8; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).indRelBPMs = [14 1;14 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C14/EI/M-HU80.2';
    ListOfInsertionDevices(Line).StandByStr = 'current device state is: ON [power section enabled - ready for cmds]';%'ANS-C15/EI/M-HU60.1_MotorsControl : STANDBY'; 
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'};
    ListOfInsertionDevices(Line).Period = 80;
    ListOfInsertionDevices(Line).NbPeriod = 19;
    ListOfInsertionDevices(Line).Bx0 = 0.92;
    ListOfInsertionDevices(Line).Bz0 = 0.7;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'phase',-ListOfInsertionDevices(Line).Period/2 ,ListOfInsertionDevices(Line).Period/2};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',15.5 ,240}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_Apple2(Line);;
    ListOfInsertionDevices(Line).Bz = @() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    Line=25;
    ListOfInsertionDevices(Line).name='U20_SIXS';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=14;
    ListOfInsertionDevices(Line).straight='C';
    ListOfInsertionDevices(Line).type='InVac';
    ListOfInsertionDevices(Line).idCenPos = 0; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).idLen = 2; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.1; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).indRelBPMs = [14 5;14 6];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C14/EI/C-U20';
    ListOfInsertionDevices(Line).StandByStr = 'ANS-C14/EI/C-U20_MOTORSCONTROL: 	STANDBY';
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'}; %to check
    ListOfInsertionDevices(Line).Period = 20;
    ListOfInsertionDevices(Line).NbPeriod = 98;
    ListOfInsertionDevices(Line).Bx0 = 0;
    ListOfInsertionDevices(Line).Bz0 = 0.97;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr={};
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',5.5 ,30}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = 0;
    ListOfInsertionDevices(Line).Bz = @() Bz_InVac(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    % ANS-C15
    
    Line=26;
    ListOfInsertionDevices(Line).name='HU60_CASSIOPEE';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=15;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='Apple2';
    ListOfInsertionDevices(Line).idLen = 1.8; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).idCenPos = -1.80; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).indRelBPMs = [15 1;15 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C15/EI/M-HU60.1';
    ListOfInsertionDevices(Line).StandByStr = 'current device state is: ON [power section enabled - ready for cmds]';%'ANS-C15/EI/M-HU60.1_MotorsControl : STANDBY'; 
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'};
    ListOfInsertionDevices(Line).Period = 60;
    ListOfInsertionDevices(Line).NbPeriod = 26;
    ListOfInsertionDevices(Line).Bx0 = 0.83;
    ListOfInsertionDevices(Line).Bz0 = 0.57;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'phase',-ListOfInsertionDevices(Line).Period/2 ,ListOfInsertionDevices(Line).Period/2};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',15.5 ,240}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_Apple2(Line);;
    ListOfInsertionDevices(Line).Bz = @() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    
    Line=27;
    ListOfInsertionDevices(Line).name='HU256_CASSIOPEE';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=15;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='EM';
    ListOfInsertionDevices(Line).idCenPos = 0.8945; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).idLen = 3.392; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).indRelBPMs = [15 1;15 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C12/EI/M-HU256.2';
    %ListOfInsertionDevices(Line).StandByStr= ''; 
	%ListOfInsertionDevices(Line).CorCurAttr= ;
    ListOfInsertionDevices(Line).Period = 256;
    ListOfInsertionDevices(Line).NbPeriod = 12;
    ListOfInsertionDevices(Line).Bx0 = 0.2764;
    ListOfInsertionDevices(Line).Bz0 = 0.3618;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'currentBX1',0,275;'currentBX2',0,275};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'currentBZP',-200 ,200}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_HU256(Line);
    ListOfInsertionDevices(Line).Bz = @() Bz_HU256(Line); 
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
        
    Line=28;
    ListOfInsertionDevices(Line).name='HU36_SIRIUS';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=15;
    ListOfInsertionDevices(Line).straight='C';
    ListOfInsertionDevices(Line).type='Apple2';
    ListOfInsertionDevices(Line).idLen = 1.65; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).idCenPos = 0; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).indRelBPMs = [15 5;15 6];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C15/EI/C-HU36';
    ListOfInsertionDevices(Line).StandByStr = 'current device state is: ON [power section enabled - ready for cmds]';%'ANS-C15/EI/C-HU36 : STANDBY'; 
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'};
    ListOfInsertionDevices(Line).Period = 36;
    ListOfInsertionDevices(Line).NbPeriod = 44;
    ListOfInsertionDevices(Line).Bx0 = 0.74;
    ListOfInsertionDevices(Line).Bz0 = 0.51;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'phase',-ListOfInsertionDevices(Line).Period/2 ,ListOfInsertionDevices(Line).Period/2};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',11.5 ,240}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_Apple2(Line);
    ListOfInsertionDevices(Line).Bz = @() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P= @() Puissance(Line);
    
    % ANS-C16
    
    Line=29;
    ListOfInsertionDevices(Line).name='HU52_LUCIA';
    ListOfInsertionDevices(Line).Directory=ListOfInsertionDevices(Line).name;
    ListOfInsertionDevices(Line).cell=16;
    ListOfInsertionDevices(Line).straight='M';
    ListOfInsertionDevices(Line).type='Apple2';
    ListOfInsertionDevices(Line).idLen = 1.8; %[m] ID length
    ListOfInsertionDevices(Line).idKickOfst = 0.2; %[m] offset from ID edge to effective position of a "kick"
    ListOfInsertionDevices(Line).idCenPos = 0; %[m] center longitudinal position of the ID with respect to the straight section center
    ListOfInsertionDevices(Line).indRelBPMs = [16 1;16 2];
    ListOfInsertionDevices(Line).sectLenBwBPMs = diff(getspos('BPMx',ListOfInsertionDevices(Line).indRelBPMs)); %[m] straight section length between BPMs
    ListOfInsertionDevices(Line).indUpstrBPM = dev2elem('BPMx', ListOfInsertionDevices(Line).indRelBPMs(1,:)); % absolute index of BPM at the upstream edge of the straight section where the ID is located
    ListOfInsertionDevices(Line).DServName = 'ANS-C16/EI/M-HU52.1';
    ListOfInsertionDevices(Line).StandByStr = 'current device state is: ON [power section enabled - ready for cmds]';%'ANS-C16/EI/M-HU52.1_MotorsControl : STANDBY'; 
    ListOfInsertionDevices(Line).CorCurAttr = {'currentCHE', 'currentCHS', 'currentCVE', 'currentCVS'};
    ListOfInsertionDevices(Line).Period = 52;
    ListOfInsertionDevices(Line).NbPeriod = 30;
    ListOfInsertionDevices(Line).Bx0 = 0.74;
    ListOfInsertionDevices(Line).Bz0 = 0.5;
    ListOfInsertionDevices(Line).MagLen= 1e-3*ListOfInsertionDevices(Line).Period* ListOfInsertionDevices(Line).NbPeriod;
    ListOfInsertionDevices(Line).XMainAttr = {'phase',-ListOfInsertionDevices(Line).Period/2 ,ListOfInsertionDevices(Line).Period/2};%{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).ZMainAttr = {'gap',15.5 ,240}; %{tangoAttribute , Minvalue , Maxvalue}
    ListOfInsertionDevices(Line).Bx = @() Bx_Apple2(Line);
    ListOfInsertionDevices(Line).Bz = @() Bz_Apple2(Line);
    ListOfInsertionDevices(Line).P = @() Puissance(Line);
    
%% Special input 'all' or ''
    if (strcmpi(Types, 'all'))
        res = ListOfInsertionDevices;
        res2={res(:).name};
        %remove emptylines
        empties = find(cellfun(@isempty,res2(:)));
        %empties = find('',res(:).name);
        res(:,empties)=[];
        return
    end
    if (isempty(Types))
        Types='InVac Apple2 EM';
    end
    
%% Extracting from ListOfInsertionDevices elements verifying Types & putting them in res
    %res=cell(0,4);

% Added 13/05/2016 : string of elements spaced by blanks changed into a
% cell of strings --> there is no more confusion between 'EM' and 'EMPHU'.
    
    CleanedTypes=strtrim(Types);
    l=length(CleanedTypes);
    i=1;
    while(i<l)
        if strcmp(CleanedTypes(i), ' ')
            j=1;
            while (strcmp(CleanedTypes(i+j), ' '))
                j=j+1;
            end
            j=j-1;
                CleanedTypes=[CleanedTypes(1:i-1) ' ' CleanedTypes(i+j+1:length(CleanedTypes))];
                i=i+1;
            l=length(CleanedTypes);
        else
            i=i+1;
        end

    end
    vect=strfind(CleanedTypes, ' ');
    n=length(vect)+1;
    CellTypes=cell(n, 1);
    if n==1
        CellTypes{1}=CleanedTypes;
    else
        for i=1:n
            if i==1
                start=1;
                stop=vect(i)-1;
            elseif i==n
                start=vect(i-1)+1;
                stop=length(CleanedTypes);
            else
                start=vect(i-1)+1;
                stop=vect(i)-1;
            end
            CellTypes{i}=CleanedTypes(start:stop);
        end
    end
    
    % End of added part
    
    
    N=size(ListOfInsertionDevices, 2);
    res=[];
%     for Line=1:N   % id index
%         UndulatorName=ListOfInsertionDevices(Line).name;        
% 
%         UndulatorType=ListOfInsertionDevices(Line).type;
%      
%      
%      
%         if (~isempty(findstr(UndulatorType, Types))&&~isempty(UndulatorName))   % Verifies Types and UndulatorName is not empty
%             res=[res, ListOfInsertionDevices(Line)];
%         elseif strcmp(UndulatorName , Types) % if you have give the undulatorName
%             res= ListOfInsertionDevices(Line);
%             return
%         end
%     end
    
    for Line=1:N   % id index
        UndulatorName=ListOfInsertionDevices(Line).name;        

        UndulatorType=ListOfInsertionDevices(Line).type;
        Add=0;
        for j=1:length(CellTypes)
            if strcmp(UndulatorType, CellTypes{j}) && ~isempty(UndulatorName)   % Verifies Types and UndulatorName is not empty
                Add=Add+1;
            elseif strcmp(UndulatorName , Types) % if you have give the undulatorName
                res= ListOfInsertionDevices(Line);
                return
            end
        end
        if Add~=0
            res=[res, ListOfInsertionDevices(Line)];
        end
    end
    
    
%% nested Function 
    function P=Puissance(Line)
         %P=0.633*getenergy^2*getdcct*ListOfInsertionDevices(Line).MagLen*(ListOfInsertionDevices(Line).Bz()^2+sum(ListOfInsertionDevices(Line).Bx().^2));
         P=0.633*getenergy^2*getdcct*1e-3*ListOfInsertionDevices(Line).MagLen*(ListOfInsertionDevices(Line).Bz()^2+ListOfInsertionDevices(Line).Bx()^2);
    end
    function Bx=Bx_Apple2(Line)
        %Line
        Zattr=tango_read_attribute2( ListOfInsertionDevices(Line).DServName,ListOfInsertionDevices(Line).ZMainAttr{1});
        gap=Zattr.value(1);
        Xattr=tango_read_attributes2(ListOfInsertionDevices(Line).DServName,ListOfInsertionDevices(Line).XMainAttr(:,1)');
        phase=Xattr.value(1);
        Bx=ListOfInsertionDevices(Line).Bx0*sin(pi*phase/ListOfInsertionDevices(Line).Period)*exp(pi*(ListOfInsertionDevices(Line).ZMainAttr{2}-gap)/ListOfInsertionDevices(Line).Period);
    end
    function Bz=Bz_Apple2(Line)
        Zattr=tango_read_attribute2( ListOfInsertionDevices(Line).DServName,ListOfInsertionDevices(Line).ZMainAttr{1});
        gap=Zattr.value(1);
        Xattr=tango_read_attributes2(ListOfInsertionDevices(Line).DServName,ListOfInsertionDevices(Line).XMainAttr(:,1)');
        phase=Xattr.value(1);
        Bz=ListOfInsertionDevices(Line).Bz0*cos(pi*phase/ListOfInsertionDevices(Line).Period)*exp(pi*(ListOfInsertionDevices(Line).ZMainAttr{2}-gap)/ListOfInsertionDevices(Line).Period);
    end
    function Bz=Bz_InVac(Line)
        Zattr=tango_read_attribute2( ListOfInsertionDevices(Line).DServName,ListOfInsertionDevices(Line).ZMainAttr{1});
        gap=Zattr.value(1);
        Bz=ListOfInsertionDevices(Line).Bz0*exp(pi*(ListOfInsertionDevices(Line).ZMainAttr{2}-gap)/ListOfInsertionDevices(Line).Period);
    end
    function Bz=Bz_HU256(Line)
        Zattr=tango_read_attribute2( ListOfInsertionDevices(Line).DServName,ListOfInsertionDevices(Line).ZMainAttr{1});
        Bzp=Zattr.value(1);       
        switch ListOfInsertionDevices(Line).name
            case 'HU256_CASSIOPEE' 
                Bz=0.0018+0.0018*Bzp;
            case 'HU256_PLEIADES'
                Bz=0.0014+0.0018*Bzp;
            case 'HU256_ANTARES' 
                Bz=0.0007+0.0018*Bzp;
            otherwise
                Bz=NaN;
        end        
    end
    function Bx=Bx_HU256(Line)
        Xattr=tango_read_attributes2(ListOfInsertionDevices(Line).DServName,ListOfInsertionDevices(Line).XMainAttr(1,1)');
        Bx1=Xattr.value(1); 
        switch ListOfInsertionDevices(Line).name
            case 'HU256_CASSIOPEE' 
                Bx=0.0014+0.0010*Bx1;
            case 'HU256_PLEIADES'
                Bx=0.0033+0.0010*Bx1;
            case 'HU256_ANTARES' 
                Bx=0.0021+0.0010*Bx1;
            otherwise
                Bx=NaN;
        end        
    end
    function Bz=Bz_HU640(Line)
        Zattr=tango_read_attribute2( ListOfInsertionDevices(Line).DServName,ListOfInsertionDevices(Line).ZMainAttr{1});
        PS1=Zattr.value(1);       
        Bz=abs(1.6213e-4*PS1);
    end
    function Bx=Bx_HU640(Line)
        Xattr=tango_read_attributes2(ListOfInsertionDevices(Line).DServName,ListOfInsertionDevices(Line).XMainAttr(1,1)');
        PS2=Xattr.value(1);       
        Xattr=tango_read_attributes2(ListOfInsertionDevices(Line).DServName,ListOfInsertionDevices(Line).XMainAttr(2,1)');
        PS3=Xattr.value(1);  
        Bx=sqrt(abs(2.4106e-4*PS2)^2+abs(2.8719e-4*PS3)^2);
    end
end
    

%remove emptylines
%empties = find(cellfun(@isempty,res(:,1)))
%res(empties,:)=[]
