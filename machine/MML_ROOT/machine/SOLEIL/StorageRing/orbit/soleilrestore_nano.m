%function [sys,bpmx,bpmz,bpm,corx,corz,cor,rsp,bly]=soleilrestore
%system parameter save file
%timestamp: done by hand
%comment: Save System

%
% Modified by Laurent S. Nadolski

% This file is part of the definition of the interface
% Do not edit without mastering the contents.
% TODO LAURENT : WARNING QUICK FIX just for a try !!!!!

AD = getad;
filetype         = 'Restore';      %check to see if correct file type
sys.machine      = 'Ring';         %machine for control
% sys.bpmode       = 'slowacquisition'; %BPM system mode
sys.bpmslp       = 0.1;            %BPM sleep time in sec
sys.globalperiod = 2.0;            %BPM sleep time in sec
% sys.silverperiod = 2.0;            %BPM sleep time in sec
sys.plane        = 1;              %plane (1=horizontal 2=vertical)
sys.algo         = 'SVD';          %fitting algorithm
sys.filepath     = AD.Directory.Orbit;       %file path in MATLAB
% sys.reffile      = [sys.filepath 'soleilsilver.dat']; %reference orbit file
sys.respfiledir  = AD.Directory.OpsData;             %response matrix directory
sys.respfilename = AD.OpsData.BPMRespFile;           %response matrix file
sys.etafile      = AD.Directory.DispData;            %dispersion file
sys.relative     = 1;              %relative or absolute BPM plot 1=absolute, 2=relative
% sys.fdbk         = 0;              %no feedback
% sys.abort        = 0;              %reset abort flag
sys.maxs          = AD.Circumference; %maximum ring circumference
sys.xlimax       = sys.maxs;        %abcissa plot limit
sys.maxphi(1)     = 10;             %maximum horizontal phase ADvance
sys.maxphi(2)     = 8;              %maximum vertical phase ADvance
sys.xscale       = 'meter';        %abcissa plotting mode (meter or phase)
sys.drf          = 0;              %RF in HW units correction if required 
%*=== HORIZONTAL DATA ===*
% bpm(1).dev      = 10;              %maximum orbit deviation
bpm(1).id       = 1;               %BPM selection
bpm(1).scalemode= 1;               %BPM scale mode 0=manual mode, 1=autoscale
bpm(1).ylim     = 5;               %BPM vertical axis scale
bpm(1).units    = '1000xHardware'; %Display Units
bpm(1).scale    = 1000;            %Scaling factor
cor(1).fract    = 1.0;             %fraction of correctors
cor(1).id       = 1;               %COR selection
cor(1).scalemode= 0;               %COR scale mode 0=manual mode, 1=autoscale
cor(1).ylim     = maxn(getfamilydata(cor(1).AOFamily,'Setpoint','Range'));  %COR horizontal axis scale (amp)
cor(1).units    = 'Hardware';      %Display Units
cor(1).hw2physics = hw2physics(cor(1).AOFamily,'Setpoint',1,1)*1e3; % mrAD
rsp(1).disp     = 'off';           %mode for matrix column display
rsp(1).eig      = 'off';           %mode for eigenvector display
rsp(1).fit      = 0;               %valid fit flag
rsp(1).rfflag   = 0;               %rf fitting flag
rsp(1).etaflag  = 1;               %dispersion fitting flag
rsp(1).savflag  = 0;               %save solution flag
rsp(1).nsvd     = 57;              %number of singular values
rsp(1).svdtol   = 0;               %svd tolerance (0 uses number of singular values)
rsp(1).nsvdmax  = 1;               %default maximum number of singular values
 
%Note: only fit and weight for fitting will be used in orbit program from this array
%      Name and index are loaded from middleware
%     name       index  fit (0/1) weight etaweight
% bpmx={
% {    '1BPM1    '     1      1      1.000   0.000     }

%%% TO DO ERASE for automatic way if no previous file exist

% family = 'BPMx';
% good   = getfamilydata(family,'Status');
% nb = length(good);
% A1 = family2common(family);
% A2 = (1:nb)';
% A3 = ones(nb,1);
% A4 = ones(nb,1);
% A5 = zeros(nb,1);
% 
% for k = 1:nb,
%     bpmx{k} = {A1(k,:),A2(k),A3(k),A4(k),A5(k)};
%     fprintf('{  ''%7s''   %3d   %3d      %1.3f    %1.3f }\n', ...
%         A1{k,:},A2(k),A3(k),A4(k),A5(k));
% end
% bpmx = bpmx';

%% BPMx
%BPM data: name, index, fit,  weight
family = bpm(2).AOFamily;
good   = getfamilydata(family,'Status');
nb = length(good);
A1 = family2common(family);
A2 = (1:nb)';
A3 = ones(nb,1).*good
A4 = ones(nb,1);
A5 = zeros(nb,1);

for k = 1:nb,
    bpmx{k} = {A1(k,:),A2(k),A3(k),A4(k),A5(k)};
    fprintf('{  ''%7s''   %3d   %3d      %1.3f    %1.3f }\n', ...
        A1{k,:},A2(k),A3(k),A4(k),A5(k));
end

% bpmx={
% {   'BPMx001'     1     1      1.000    0.000 }
% {   'BPMx002'     2     1      1.000    0.000 }
% {   'BPMx003'     3     1      1.000    0.000 }
% {   'BPMx004'     4     1      1.000    0.000 }
% {   'BPMx005'     5     1      1.000    0.000 }
% {   'BPMx006'     6     1      1.000    0.000 }
% {   'BPMx007'     7     1      1.000    0.000 }
% {   'BPMx008'     8     1      1.000    0.000 }
% {   'BPMx009'     9     1      1.000    0.000 }
% {   'BPMx010'    10     1      1.000    0.000 }
% {   'BPMx011'    11     1      1.000    0.000 }
% {   'BPMx012'    12     1      1.000    0.000 }
% {   'BPMx013'    13     1      1.000    0.000 }
% {   'BPMx014'    14     1      1.000    0.000 }
% {   'BPMx015'    15     1      1.000    0.000 }
% {   'BPMx016'    16     1      1.000    0.000 }
% {   'BPMx017'    17     1      1.000    0.000 }
% {   'BPMx018'    18     1      1.000    0.000 }
% {   'BPMx019'    19     1      1.000    0.000 }
% {   'BPMx020'    20     1      1.000    0.000 }
% {   'BPMx021'    21     1      1.000    0.000 }
% {   'BPMx022'    22     1      1.000    0.000 }
% {   'BPMx023'    23     1      1.000    0.000 }
% {   'BPMx024'    24     1      1.000    0.000 }
% {   'BPMx025'    25     1      1.000    0.000 }
% {   'BPMx026'    26     1      1.000    0.000 }
% {   'BPMx027'    27     1      1.000    0.000 }
% {   'BPMx028'    28     1      1.000    0.000 }
% {   'BPMx029'    29     1      1.000    0.000 }
% {   'BPMx030'    30     1      1.000    0.000 }
% {   'BPMx031'    31     1      1.000    0.000 }
% {   'BPMx032'    32     1      1.000    0.000 }
% {   'BPMx033'    33     1      1.000    0.000 }
% {   'BPMx034'    34     1      1.000    0.000 }
% {   'BPMx035'    35     1      1.000    0.000 }
% {   'BPMx036'    36     1      1.000    0.000 }
% {   'BPMx037'    37     1      1.000    0.000 }
% {   'BPMx038'    38     1      1.000    0.000 }
% {   'BPMx039'    39     1      1.000    0.000 }
% {   'BPMx040'    40     1      1.000    0.000 }
% {   'BPMx041'    41     1      1.000    0.000 }
% {   'BPMx042'    42     1      1.000    0.000 }
% {   'BPMx043'    43     1      1.000    0.000 }
% {   'BPMx044'    44     1      1.000    0.000 }
% {   'BPMx045'    45     1      1.000    0.000 }
% {   'BPMx046'    46     1      1.000    0.000 }
% {   'BPMx047'    47     1      1.000    0.000 }
% {   'BPMx048'    48     1      1.000    0.000 }
% {   'BPMx049'    49     1      1.000    0.000 }
% {   'BPMx050'    50     1      1.000    0.000 }
% {   'BPMx051'    51     1      1.000    0.000 }
% {   'BPMx052'    52     1      1.000    0.000 }
% {   'BPMx053'    53     1      1.000    0.000 }
% {   'BPMx054'    54     1      1.000    0.000 }
% {   'BPMx055'    55     1      1.000    0.000 }
% {   'BPMx056'    56     1      1.000    0.000 }
% {   'BPMx057'    57     1      1.000    0.000 }
% {   'BPMx058'    58     1      1.000    0.000 }
% {   'BPMx059'    59     1      1.000    0.000 }
% {   'BPMx060'    60     1      1.000    0.000 }
% {   'BPMx061'    61     1      1.000    0.000 }
% {   'BPMx062'    62     1      1.000    0.000 }
% {   'BPMx063'    63     1      1.000    0.000 }
% {   'BPMx064'    64     1      1.000    0.000 }
% {   'BPMx065'    65     1      1.000    0.000 }
% {   'BPMx066'    66     1      1.000    0.000 }
% {   'BPMx067'    67     1      1.000    0.000 }
% {   'BPMx068'    68     1      1.000    0.000 }
% {   'BPMx069'    69     1      1.000    0.000 }
% {   'BPMx070'    70     1      1.000    0.000 }
% {   'BPMx071'    71     1      1.000    0.000 }
% {   'BPMx072'    72     1      1.000    0.000 }
% {   'BPMx073'    73     1      1.000    0.000 }
% {   'BPMx074'    74     1      1.000    0.000 }
% {   'BPMx075'    75     1      1.000    0.000 }
% {   'BPMx076'    76     1      1.000    0.000 }
% {   'BPMx077'    77     1      1.000    0.000 }
% {   'BPMx078'    78     1      1.000    0.000 }
% {   'BPMx079'    79     1      1.000    0.000 }
% {   'BPMx080'    80     1      1.000    0.000 }
% {   'BPMx081'    81     1      1.000    0.000 }
% {   'BPMx082'    82     1      1.000    0.000 }
% {   'BPMx083'    83     1      1.000    0.000 }
% {   'BPMx084'    84     1      1.000    0.000 }
% {   'BPMx085'    85     1      1.000    0.000 }
% {   'BPMx086'    86     1      1.000    0.000 }
% {   'BPMx087'    87     1      1.000    0.000 }
% {   'BPMx088'    88     1      1.000    0.000 }
% {   'BPMx089'    89     1      1.000    0.000 }
% {   'BPMx090'    90     1      1.000    0.000 }
% {   'BPMx121'    91     1      1.000    0.000 }
% {   'BPMx122'    92     1      1.000    0.000 }
% {   'BPMx091'    93     1      1.000    0.000 }
% {   'BPMx092'    94     1      1.000    0.000 }
% {   'BPMx093'    95     1      1.000    0.000 }
% {   'BPMx094'    96     1      1.000    0.000 }
% {   'BPMx095'    97     1      1.000    0.000 }
% {   'BPMx096'    98     1      1.000    0.000 }
% {   'BPMx097'    99     1      1.000    0.000 }
% {   'BPMx098'   100     1      1.000    0.000 }
% {   'BPMx099'   101     1      1.000    0.000 }
% {   'BPMx100'   102     1      1.000    0.000 }
% {   'BPMx101'   103     1      1.000    0.000 }
% {   'BPMx102'   104     1      1.000    0.000 }
% {   'BPMx103'   105     1      1.000    0.000 }
% {   'BPMx104'   106     1      1.000    0.000 }
% {   'BPMx105'   107     1      1.000    0.000 }
% {   'BPMx106'   108     1      1.000    0.000 }
% {   'BPMx107'   109     1      1.000    0.000 }
% {   'BPMx108'   110     1      1.000    0.000 }
% {   'BPMx109'   111     1      1.000    0.000 }
% {   'BPMx110'   112     1      1.000    0.000 }
% {   'BPMx111'   113     1      1.000    0.000 }
% {   'BPMx112'   114     1      1.000    0.000 }
% {   'BPMx113'   115     1      1.000    0.000 }
% {   'BPMx114'   116     1      1.000    0.000 }
% {   'BPMx115'   117     1      1.000    0.000 }
% {   'BPMx116'   118     1      1.000    0.000 }
% {   'BPMx117'   119     1      1.000    0.000 }
% {   'BPMx118'   120     1      1.000    0.000 }
% {   'BPMx119'   121     1      1.000    0.000 }
% {   'BPMx120'   122     1      1.000    0.000 }
% };
%Note: only fit, weight for fitting will be used in orbit program from this array
%      Name and index are loADed from middleware
% name    index fit (0/1)  weight
% corx={
% {'1CX1    '  1   1   1.0    }

%% HCOR
%%% TO DO ERASE for automatic way if no previous file exist
clear A1 A2 A3 A4 A5
family = 'HCOR';
good   = getfamilydata(family,'Status');
DeviceList = family2dev(family,0);
A1 = family2common(family,DeviceList);
nb = length(good);
A2 = (1:nb)';
A2 = getfamilydata(family,'ElementList');
A3 = ones(nb,1).*good;
A4 = ones(nb,1);
A5 = getmaxsp(family,DeviceList); % get RangeSetpoint

for k = 1:nb,
    corx{k} = {A1(k,:),A2(k),A3(k),A4(k),A5(k)};
    fprintf('{  ''%7s''   %3d   %3d      %1.3f    %1.3f    0.250}\n', ...
        A1{k,:},A2(k),A3(k),A4(k), A5(k));
end
%corx = corx';

%COR data: name, index, fit,  weight,   limit,      ebpm,      pbpm
% corx={
% {  'HCOR001'     1     1      1.000     10.000      0.250  }

% HU640 disable
% corx={
% {  'HCOR001'     1     1      1.000    11.000    0.250}
% {  'HCOR002'     2     0      1.000    11.000    0.250}
% {  'HCOR003'     3     0      1.000    11.000    0.250}
% {  'HCOR004'     4     1      1.000    11.000    0.250}
% {  'HCOR005'     5     0      1.000    11.000    0.250}
% {  'HCOR006'     6     0      1.000    11.000    0.250}
% {  'HCOR007'     7     1      1.000    11.000    0.250}
% {  'HCOR008'     8     1      1.000    11.000    0.250}
% {  'HCOR009'     9     0      1.000    11.000    0.250}
% {  'HCOR010'    10     0      1.000    11.000    0.250}
% {  'HCOR011'    11     1      1.000    11.000    0.250}
% {  'HCOR012'    12     1      1.000    11.000    0.250}
% {  'HCOR013'    13     0      1.000    11.000    0.250}
% {  'HCOR014'    14     0      1.000    11.000    0.250}
% {  'HCOR015'    15     1      1.000    11.000    0.250}
% {  'HCOR016'    16     1      1.000    11.000    0.250}
% {  'HCOR017'    17     0      1.000    11.000    0.250}
% {  'HCOR018'    18     0      1.000    11.000    0.250}
% {  'HCOR019'    19     1      1.000    11.000    0.250}
% {  'HCOR020'    20     1      1.000    11.000    0.250}
% {  'HCOR021'    21     0      1.000    11.000    0.250}
% {  'HCOR022'    22     0      1.000    11.000    0.250}
% {  'HCOR023'    23     1      1.000    11.000    0.250}
% {  'HCOR024'    24     1      1.000    11.000    0.250}
% {  'HCOR025'    25     0      1.000    11.000    0.250}
% {  'HCOR026'    26     0      1.000    11.000    0.250}
% {  'HCOR027'    27     1      1.000    11.000    0.250}
% {  'HCOR028'    28     0      1.000    11.000    0.250}
% {  'HCOR029'    29     0      1.000    11.000    0.250}
% {  'HCOR030'    30     1      1.000    11.000    0.250}
% {  'HCOR121'    31     0      1.000    5.000    0.250}
% {  'HCOR122'    32     0      1.000    5.000    0.250}
% {  'HCOR031'    33     1      1.000    11.000    0.250}
% {  'HCOR032'    34     0      1.000    11.000    0.250}
% {  'HCOR033'    35     0      1.000    11.000    0.250}
% {  'HCOR034'    36     1      1.000    11.000    0.250}
% {  'HCOR035'    37     0      1.000    11.000    0.250}
% {  'HCOR036'    38     0      1.000    11.000    0.250}
% {  'HCOR037'    39     1      1.000    11.000    0.250}
% {  'HCOR038'    40     1      1.000    11.000    0.250}
% {  'HCOR039'    41     0      1.000    11.000    0.250}
% {  'HCOR040'    42     0      1.000    11.000    0.250}
% {  'HCOR041'    43     1      1.000    11.000    0.250}
% {  'HCOR042'    44     1      1.000    11.000    0.250}
% {  'HCOR043'    45     0      1.000    11.000    0.250}
% {  'HCOR044'    46     0      1.000    11.000    0.250}
% {  'HCOR045'    47     1      1.000    11.000    0.250}
% {  'HCOR046'    48     1      1.000    11.000    0.250}
% {  'HCOR047'    49     0      1.000    11.000    0.250}
% {  'HCOR048'    50     0      1.000    11.000    0.250}
% {  'HCOR049'    51     1      1.000    11.000    0.250}
% {  'HCOR050'    52     1      1.000    11.000    0.250}
% {  'HCOR051'    53     0      1.000    11.000    0.250}
% {  'HCOR052'    54     0      1.000    11.000    0.250}
% {  'HCOR053'    55     1      1.000    11.000    0.250}
% {  'HCOR054'    56     1      1.000    11.000    0.250}
% {  'HCOR055'    57     0      1.000    11.000    0.250}
% {  'HCOR056'    58     0      1.000    11.000    0.250}
% {  'HCOR057'    59     1      1.000    11.000    0.250}
% {  'HCOR058'    60     0      1.000    11.000    0.250}
% {  'HCOR059'    61     0      1.000    11.000    0.250}
% {  'HCOR060'    62     1      1.000    11.000    0.250}
% {  'HCOR061'    63     1      1.000    11.000    0.250}
% {  'HCOR062'    64     0      1.000    11.000    0.250}
% {  'HCOR063'    65     0      1.000    11.000    0.250}
% {  'HCOR064'    66     1      1.000    11.000    0.250}
% {  'HCOR065'    67     0      1.000    11.000    0.250}
% {  'HCOR066'    68     0      1.000    11.000    0.250}
% {  'HCOR067'    69     1      1.000    11.000    0.250}
% {  'HCOR068'    70     1      1.000    11.000    0.250}
% {  'HCOR069'    71     0      1.000    11.000    0.250}
% {  'HCOR070'    72     0      1.000    11.000    0.250}
% {  'HCOR071'    73     1      1.000    11.000    0.250}
% {  'HCOR072'    74     1      1.000    11.000    0.250}
% {  'HCOR073'    75     0      1.000    11.000    0.250}
% {  'HCOR074'    76     0      1.000    11.000    0.250}
% {  'HCOR075'    77     1      1.000    11.000    0.250}
% {  'HCOR076'    78     1      1.000    11.000    0.250}
% {  'HCOR077'    79     0      1.000    11.000    0.250}
% {  'HCOR078'    80     0      1.000    11.000    0.250}
% {  'HCOR079'    81     1      1.000    11.000    0.250}
% {  'HCOR080'    82     1      1.000    11.000    0.250}
% {  'HCOR081'    83     0      1.000    11.000    0.250}
% {  'HCOR082'    84     0      1.000    11.000    0.250}
% {  'HCOR083'    85     1      1.000    11.000    0.250}
% {  'HCOR084'    86     1      1.000    11.000    0.250}
% {  'HCOR085'    87     0      1.000    11.000    0.250}
% {  'HCOR086'    88     0      1.000    11.000    0.250}
% {  'HCOR087'    89     1      1.000    11.000    0.250}
% {  'HCOR088'    90     0      1.000    11.000    0.250}
% {  'HCOR089'    91     0      1.000    11.000    0.250}
% {  'HCOR090'    92     1      1.000    11.000    0.250}
% {  'HCOR123'    93     1      1.000    11.000    0.250}
% {  'HCOR124'    94     0      1.000    11.000    0.250}
% {  'HCOR091'    95     1      1.000    11.000    0.250}
% {  'HCOR092'    96     0      1.000    11.000    0.250}
% {  'HCOR093'    97     0      1.000    11.000    0.250}
% {  'HCOR094'    98     1      1.000    11.000    0.250}
% {  'HCOR095'    99     0      1.000    11.000    0.250}
% {  'HCOR096'   100     0      1.000    11.000    0.250}
% {  'HCOR097'   101     1      1.000    11.000    0.250}
% {  'HCOR098'   102     1      1.000    11.000    0.250}
% {  'HCOR099'   103     0      1.000    11.000    0.250}
% {  'HCOR100'   104     0      1.000    11.000    0.250}
% {  'HCOR101'   105     1      1.000    11.000    0.250}
% {  'HCOR102'   106     1      1.000    11.000    0.250}
% {  'HCOR103'   107     0      1.000    11.000    0.250}
% {  'HCOR104'   108     0      1.000    11.000    0.250}
% {  'HCOR105'   109     1      1.000    11.000    0.250}
% {  'HCOR106'   110     1      1.000    11.000    0.250}
% {  'HCOR107'   111     0      1.000    11.000    0.250}
% {  'HCOR108'   112     0      1.000    11.000    0.250}
% {  'HCOR109'   113     1      1.000    11.000    0.250}
% {  'HCOR110'   114     1      1.000    11.000    0.250}
% {  'HCOR111'   115     0      1.000    11.000    0.250}
% {  'HCOR112'   116     0      1.000    11.000    0.250}
% {  'HCOR113'   117     1      1.000    11.000    0.250}
% {  'HCOR114'   118     1      1.000    11.000    0.250}
% {  'HCOR115'   119     0      1.000    11.000    0.250}
% {  'HCOR116'   120     0      1.000    11.000    0.250}
% {  'HCOR117'   121     1      1.000    11.000    0.250}
% {  'HCOR118'   122     0      1.000    11.000    0.250}
% {  'HCOR119'   123     0      1.000    11.000    0.250}
% {  'HCOR120'   124     1      1.000    11.000    0.250}
% };

%*===   VERTICAL DATA ===*
% bpm(2).dev      = 10;              %maximum orbit deviation
bpm(2).id       = 1;               %BPM selection
bpm(2).scalemode= 1;               %BPM scale mode 0=manual mode, 1=autoscale
bpm(2).ylim     = 5;               %BPM vertical axis scale
bpm(2).units    = '1000xHardware'; %Display units
bpm(1).scale    = 1000;            %Scaling factor
cor(2).fract    = 1.0;             %fraction of correctors
cor(2).id       = 1;               %COR selection
cor(2).scalemode= 0;               %COR scale mode 0=manual mode, 1=autoscale
cor(2).ylim     = maxn(getfamilydata(cor(2).AOFamily,'Setpoint','Range'));  %COR horizontal axis scale (amp)
cor(2).units    = 'Hardware';      %Display Units
cor(2).hw2physics = hw2physics(cor(2).AOFamily,'Setpoint',1,1)*1e3; % mrAD
rsp(2).disp     = 'off';           %mode for matrix column display
rsp(2).eig      = 'off';           %mode for eigenvector display
rsp(2).fit      = 0;               %valid fit flag
rsp(2).rfflag   = 0;               %rf fitting flag
rsp(2).etaflag  = 0;               %dispersion fitting flag
rsp(2).savflag  = 0;               %save solution flag
rsp(2).nsvd     = 57;              %number of singular values
rsp(2).svdtol   = 0;               %svd tolerance (0 uses number of singular values)
rsp(2).nsvdmax  = 1;               %default maximum number of singular values

%% BPMZ
% TO DO ERASE for automatic way if no previous file exist
% 
% %     name       index  fit (0/1) weight   etaweight
% % bpmz={
% % {    '1BPM1    '     1      1      1.000     0.000     }
% bpmz = bpmx;

family = bpm(2).AOFamily;
good   = getfamilydata(family,'Status');
nb = length(good);
A1 = family2common(family);
A2 = (1:nb)';
A3 = ones(nb,1).*good
A4 = ones(nb,1);
A5 = zeros(nb,1);

for k = 1:nb,
    bpmz{k} = {A1(k,:),A2(k),A3(k),A4(k),A5(k)};
    fprintf('{  ''%7s''   %3d   %3d      %1.3f    %1.3f }\n', ...
        A1{k,:},A2(k),A3(k),A4(k),A5(k));
end
% bpmz = bpmz';

%%BPMx
%BPM data: name, index, fit,  weight etaweight
% bpmz={
% {  'BPMz001'     1     1      1.000    0.000 }
% {  'BPMz002'     2     1      1.000    0.000 }
% {  'BPMz003'     3     1      1.000    0.000 }
% {  'BPMz004'     4     1      1.000    0.000 }
% {  'BPMz005'     5     1      1.000    0.000 }
% {  'BPMz006'     6     1      1.000    0.000 }
% {  'BPMz007'     7     1      1.000    0.000 }
% {  'BPMz008'     8     1      1.000    0.000 }
% {  'BPMz009'     9     1      1.000    0.000 }
% {  'BPMz010'    10     1      1.000    0.000 }
% {  'BPMz011'    11     1      1.000    0.000 }
% {  'BPMz012'    12     1      1.000    0.000 }
% {  'BPMz013'    13     1      1.000    0.000 }
% {  'BPMz014'    14     1      1.000    0.000 }
% {  'BPMz015'    15     1      1.000    0.000 }
% {  'BPMz016'    16     1      1.000    0.000 }
% {  'BPMz017'    17     1      1.000    0.000 }
% {  'BPMz018'    18     1      1.000    0.000 }
% {  'BPMz019'    19     1      1.000    0.000 }
% {  'BPMz020'    20     1      1.000    0.000 }
% {  'BPMz021'    21     1      1.000    0.000 }
% {  'BPMz022'    22     1      1.000    0.000 }
% {  'BPMz023'    23     1      1.000    0.000 }
% {  'BPMz024'    24     1      1.000    0.000 }
% {  'BPMz025'    25     1      1.000    0.000 }
% {  'BPMz026'    26     1      1.000    0.000 }
% {  'BPMz027'    27     1      1.000    0.000 }
% {  'BPMz028'    28     1      1.000    0.000 }
% {  'BPMz029'    29     1      1.000    0.000 }
% {  'BPMz030'    30     1      1.000    0.000 }
% {  'BPMz031'    31     1      1.000    0.000 }
% {  'BPMz032'    32     1      1.000    0.000 }
% {  'BPMz033'    33     1      1.000    0.000 }
% {  'BPMz034'    34     1      1.000    0.000 }
% {  'BPMz035'    35     1      1.000    0.000 }
% {  'BPMz036'    36     1      1.000    0.000 }
% {  'BPMz037'    37     1      1.000    0.000 }
% {  'BPMz038'    38     1      1.000    0.000 }
% {  'BPMz039'    39     1      1.000    0.000 }
% {  'BPMz040'    40     1      1.000    0.000 }
% {  'BPMz041'    41     1      1.000    0.000 }
% {  'BPMz042'    42     1      1.000    0.000 }
% {  'BPMz043'    43     1      1.000    0.000 }
% {  'BPMz044'    44     1      1.000    0.000 }
% {  'BPMz045'    45     1      1.000    0.000 }
% {  'BPMz046'    46     1      1.000    0.000 }
% {  'BPMz047'    47     1      1.000    0.000 }
% {  'BPMz048'    48     1      1.000    0.000 }
% {  'BPMz049'    49     1      1.000    0.000 }
% {  'BPMz050'    50     1      1.000    0.000 }
% {  'BPMz051'    51     1      1.000    0.000 }
% {  'BPMz052'    52     1      1.000    0.000 }
% {  'BPMz053'    53     1      1.000    0.000 }
% {  'BPMz054'    54     1      1.000    0.000 }
% {  'BPMz055'    55     1      1.000    0.000 }
% {  'BPMz056'    56     1      1.000    0.000 }
% {  'BPMz057'    57     1      1.000    0.000 }
% {  'BPMz058'    58     1      1.000    0.000 }
% {  'BPMz059'    59     1      1.000    0.000 }
% {  'BPMz060'    60     1      1.000    0.000 }
% {  'BPMz061'    61     1      1.000    0.000 }
% {  'BPMz062'    62     1      1.000    0.000 }
% {  'BPMz063'    63     1      1.000    0.000 }
% {  'BPMz064'    64     1      1.000    0.000 }
% {  'BPMz065'    65     1      1.000    0.000 }
% {  'BPMz066'    66     1      1.000    0.000 }
% {  'BPMz067'    67     1      1.000    0.000 }
% {  'BPMz068'    68     1      1.000    0.000 }
% {  'BPMz069'    69     1      1.000    0.000 }
% {  'BPMz070'    70     1      1.000    0.000 }
% {  'BPMz071'    71     1      1.000    0.000 }
% {  'BPMz072'    72     1      1.000    0.000 }
% {  'BPMz073'    73     1      1.000    0.000 }
% {  'BPMz074'    74     1      1.000    0.000 }
% {  'BPMz075'    75     1      1.000    0.000 }
% {  'BPMz076'    76     1      1.000    0.000 }
% {  'BPMz077'    77     1      1.000    0.000 }
% {  'BPMz078'    78     1      1.000    0.000 }
% {  'BPMz079'    79     1      1.000    0.000 }
% {  'BPMz080'    80     1      1.000    0.000 }
% {  'BPMz081'    81     1      1.000    0.000 }
% {  'BPMz082'    82     1      1.000    0.000 }
% {  'BPMz083'    83     1      1.000    0.000 }
% {  'BPMz084'    84     1      1.000    0.000 }
% {  'BPMz085'    85     1      1.000    0.000 }
% {  'BPMz086'    86     1      1.000    0.000 }
% {  'BPMz087'    87     1      1.000    0.000 }
% {  'BPMz088'    88     1      1.000    0.000 }
% {  'BPMz089'    89     1      1.000    0.000 }
% {  'BPMz090'    90     1      1.000    0.000 }
% {  'BPMz121'    91     1      1.000    0.000 }
% {  'BPMz122'    92     1      1.000    0.000 }
% {  'BPMz091'    93     1      1.000    0.000 }
% {  'BPMz092'    94     1      1.000    0.000 }
% {  'BPMz093'    95     1      1.000    0.000 }
% {  'BPMz094'    96     1      1.000    0.000 }
% {  'BPMz095'    97     1      1.000    0.000 }
% {  'BPMz096'    98     1      1.000    0.000 }
% {  'BPMz097'    99     1      1.000    0.000 }
% {  'BPMz098'   100     1      1.000    0.000 }
% {  'BPMz099'   101     1      1.000    0.000 }
% {  'BPMz100'   102     1      1.000    0.000 }
% {  'BPMz101'   103     1      1.000    0.000 }
% {  'BPMz102'   104     1      1.000    0.000 }
% {  'BPMz103'   105     1      1.000    0.000 }
% {  'BPMz104'   106     1      1.000    0.000 }
% {  'BPMz105'   107     1      1.000    0.000 }
% {  'BPMz106'   108     1      1.000    0.000 }
% {  'BPMz107'   109     1      1.000    0.000 }
% {  'BPMz108'   110     1      1.000    0.000 }
% {  'BPMz109'   111     1      1.000    0.000 }
% {  'BPMz110'   112     1      1.000    0.000 }
% {  'BPMz111'   113     1      1.000    0.000 }
% {  'BPMz112'   114     1      1.000    0.000 }
% {  'BPMz113'   115     1      1.000    0.000 }
% {  'BPMz114'   116     1      1.000    0.000 }
% {  'BPMz115'   117     1      1.000    0.000 }
% {  'BPMz116'   118     1      1.000    0.000 }
% {  'BPMz117'   119     1      1.000    0.000 }
% {  'BPMz118'   120     1      1.000    0.000 }
% {  'BPMz119'   121     1      1.000    0.000 }
% {  'BPMz120'   122     1      1.000    0.000 }
% };

%% VCOR
% TO DO ERASE for automatic way if no previous file exist

% name    index fit (0/1)  weight
% corz={
% {'1CY1    '  1   1   1.0    }

%COR data: name, index, fit,  weight,   limit,      ebpm,      pbpm
% corz={
clear A1 A2 A3 A4 A5
family = 'VCOR';
good   = getfamilydata(family,'Status');
DeviceList = family2dev(family,0);
A1 = family2common(family,DeviceList);
nb = length(good);
A2 = (1:nb)';
A2 = getfamilydata(family,'ElementList');
A3 = ones(nb,1).*good;
A4 = ones(nb,1);
A5 = getmaxsp(family,DeviceList); % get RangeSetpoint

for k = 1:nb,
    corz{k} = {A1(k,:),A2(k),A3(k),A4(k),A5(k)};
    fprintf('{  ''%7s''   %3d   %3d      %1.3f    %1.3f    0.250}\n', ...
        A1{k,:},A2(k),A3(k),A4(k), A5(k));
end
% corz={
% {  'VCOR001'     1     0      1.000    14.000    0.250}
% {  'VCOR002'     2     1      1.000    14.000    0.250}
% {  'VCOR003'     3     0      1.000    14.000    0.250}
% {  'VCOR004'     4     1      1.000    14.000    0.250}
% {  'VCOR005'     5     0      1.000    14.000    0.250}
% {  'VCOR006'     6     1      1.000    14.000    0.250}
% {  'VCOR007'     7     0      1.000    14.000    0.250}
% {  'VCOR008'     8     0      1.000    14.000    0.250}
% {  'VCOR009'     9     1      1.000    14.000    0.250}
% {  'VCOR010'    10     1      1.000    14.000    0.250}
% {  'VCOR011'    11     0      1.000    14.000    0.250}
% {  'VCOR012'    12     0      1.000    14.000    0.250}
% {  'VCOR013'    13     1      1.000    14.000    0.250}
% {  'VCOR014'    14     1      1.000    14.000    0.250}
% {  'VCOR015'    15     0      1.000    14.000    0.250}
% {  'VCOR016'    16     0      1.000    14.000    0.250}
% {  'VCOR017'    17     1      1.000    14.000    0.250}
% {  'VCOR018'    18     1      1.000    14.000    0.250}
% {  'VCOR019'    19     0      1.000    14.000    0.250}
% {  'VCOR020'    20     0      1.000    14.000    0.250}
% {  'VCOR021'    21     1      1.000    14.000    0.250}
% {  'VCOR022'    22     1      1.000    14.000    0.250}
% {  'VCOR023'    23     0      1.000    14.000    0.250}
% {  'VCOR024'    24     0      1.000    14.000    0.250}
% {  'VCOR025'    25     1      1.000    14.000    0.250}
% {  'VCOR026'    26     0      1.000    14.000    0.250}
% {  'VCOR027'    27     1      1.000    14.000    0.250}
% {  'VCOR028'    28     0      1.000    14.000    0.250}
% {  'VCOR029'    29     1      1.000    14.000    0.250}
% {  'VCOR030'    30     0      1.000    14.000    0.250}
% {  'VCOR121'    31     0      1.000    5.000    0.250}
% {  'VCOR122'    32     0      1.000    5.000    0.250}
% {  'VCOR031'    33     0      1.000    14.000    0.250}
% {  'VCOR032'    34     1      1.000    14.000    0.250}
% {  'VCOR033'    35     0      1.000    14.000    0.250}
% {  'VCOR034'    36     1      1.000    14.000    0.250}
% {  'VCOR035'    37     0      1.000    14.000    0.250}
% {  'VCOR036'    38     1      1.000    14.000    0.250}
% {  'VCOR037'    39     0      1.000    14.000    0.250}
% {  'VCOR038'    40     0      1.000    14.000    0.250}
% {  'VCOR039'    41     1      1.000    14.000    0.250}
% {  'VCOR040'    42     1      1.000    14.000    0.250}
% {  'VCOR041'    43     0      1.000    14.000    0.250}
% {  'VCOR042'    44     0      1.000    14.000    0.250}
% {  'VCOR043'    45     1      1.000    14.000    0.250}
% {  'VCOR044'    46     1      1.000    14.000    0.250}
% {  'VCOR045'    47     0      1.000    14.000    0.250}
% {  'VCOR046'    48     0      1.000    14.000    0.250}
% {  'VCOR047'    49     1      1.000    14.000    0.250}
% {  'VCOR048'    50     1      1.000    14.000    0.250}
% {  'VCOR049'    51     0      1.000    14.000    0.250}
% {  'VCOR050'    52     0      1.000    14.000    0.250}
% {  'VCOR051'    53     1      1.000    14.000    0.250}
% {  'VCOR052'    54     1      1.000    14.000    0.250}
% {  'VCOR053'    55     0      1.000    14.000    0.250}
% {  'VCOR054'    56     0      1.000    14.000    0.250}
% {  'VCOR055'    57     1      1.000    14.000    0.250}
% {  'VCOR056'    58     0      1.000    14.000    0.250}
% {  'VCOR057'    59     1      1.000    14.000    0.250}
% {  'VCOR058'    60     0      1.000    14.000    0.250}
% {  'VCOR059'    61     1      1.000    14.000    0.250}
% {  'VCOR060'    62     0      1.000    14.000    0.250}
% {  'VCOR061'    63     0      1.000    14.000    0.250}
% {  'VCOR062'    64     1      1.000    14.000    0.250}
% {  'VCOR063'    65     0      1.000    14.000    0.250}
% {  'VCOR064'    66     1      1.000    14.000    0.250}
% {  'VCOR065'    67     0      1.000    14.000    0.250}
% {  'VCOR066'    68     1      1.000    14.000    0.250}
% {  'VCOR067'    69     0      1.000    14.000    0.250}
% {  'VCOR068'    70     0      1.000    14.000    0.250}
% {  'VCOR069'    71     1      1.000    14.000    0.250}
% {  'VCOR070'    72     1      1.000    14.000    0.250}
% {  'VCOR071'    73     0      1.000    14.000    0.250}
% {  'VCOR072'    74     0      1.000    14.000    0.250}
% {  'VCOR073'    75     1      1.000    14.000    0.250}
% {  'VCOR074'    76     1      1.000    14.000    0.250}
% {  'VCOR075'    77     0      1.000    14.000    0.250}
% {  'VCOR076'    78     0      1.000    14.000    0.250}
% {  'VCOR077'    79     1      1.000    14.000    0.250}
% {  'VCOR078'    80     1      1.000    14.000    0.250}
% {  'VCOR079'    81     0      1.000    14.000    0.250}
% {  'VCOR080'    82     0      1.000    14.000    0.250}
% {  'VCOR081'    83     1      1.000    14.000    0.250}
% {  'VCOR082'    84     1      1.000    14.000    0.250}
% {  'VCOR083'    85     0      1.000    14.000    0.250}
% {  'VCOR084'    86     0      1.000    14.000    0.250}
% {  'VCOR085'    87     1      1.000    14.000    0.250}
% {  'VCOR086'    88     0      1.000    14.000    0.250}
% {  'VCOR087'    89     1      1.000    14.000    0.250}
% {  'VCOR088'    90     0      1.000    14.000    0.250}
% {  'VCOR089'    91     1      1.000    14.000    0.250}
% {  'VCOR090'    92     0      1.000    14.000    0.250}
% {  'VCOR123'    93     0      1.000    14.000    0.250}
% {  'VCOR124'    94     1      1.000    14.000    0.250}
% {  'VCOR091'    95     0      1.000    14.000    0.250}
% {  'VCOR092'    96     1      1.000    14.000    0.250}
% {  'VCOR093'    97     0      1.000    14.000    0.250}
% {  'VCOR094'    98     1      1.000    14.000    0.250}
% {  'VCOR095'    99     0      1.000    14.000    0.250}
% {  'VCOR096'   100     1      1.000    14.000    0.250}
% {  'VCOR097'   101     0      1.000    14.000    0.250}
% {  'VCOR098'   102     0      1.000    14.000    0.250}
% {  'VCOR099'   103     1      1.000    14.000    0.250}
% {  'VCOR100'   104     1      1.000    14.000    0.250}
% {  'VCOR101'   105     0      1.000    14.000    0.250}
% {  'VCOR102'   106     0      1.000    14.000    0.250}
% {  'VCOR103'   107     1      1.000    14.000    0.250}
% {  'VCOR104'   108     1      1.000    14.000    0.250}
% {  'VCOR105'   109     0      1.000    14.000    0.250}
% {  'VCOR106'   110     0      1.000    14.000    0.250}
% {  'VCOR107'   111     1      1.000    14.000    0.250}
% {  'VCOR108'   112     1      1.000    14.000    0.250}
% {  'VCOR109'   113     0      1.000    14.000    0.250}
% {  'VCOR110'   114     0      1.000    14.000    0.250}
% {  'VCOR111'   115     1      1.000    14.000    0.250}
% {  'VCOR112'   116     1      1.000    14.000    0.250}
% {  'VCOR113'   117     0      1.000    14.000    0.250}
% {  'VCOR114'   118     0      1.000    14.000    0.250}
% {  'VCOR115'   119     1      1.000    14.000    0.250}
% {  'VCOR116'   120     0      1.000    14.000    0.250}
% {  'VCOR117'   121     1      1.000    14.000    0.250}
% {  'VCOR118'   122     0      1.000    14.000    0.250}
% {  'VCOR119'   123     1      1.000    14.000    0.250}
% {  'VCOR120'   124     0      1.000    14.000    0.250}
% };
