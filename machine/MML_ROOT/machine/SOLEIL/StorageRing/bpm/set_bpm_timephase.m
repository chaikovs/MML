function  set_bpm_timephase(timeshift)
% set_bpm_time_phase -  Set bpm time phases from list bpm time phase
% All BPMs should then trig on the same turn
%
% See Also reset_bpm_timephase

%
% Modified by Laurent S. Nadolski, 6 December 2010

if nargin < 1
    timeshift = 0;
end

%% Open filename
%file = 'liste_bpm_timephase.txt';
file = 'liste_bpm_timephase122BPM.txt';
file = [getfamilydata('Directory','DataRoot'), 'KickerEM/',file];

fid  = fopen(file,'r');
entete=fscanf(fid, '%s',[5]); 
name=[];

nBPM = 122; % Total Number of BPM

% Intialization
timephase = zeros(1,nBPM);

for i=1:nBPM
    text = fscanf(fid, '%s', [3]) ;
    name = [name ; {text(1:16)}];
    timephase(i) = str2double(text(18:19));
end
fclose(fid);
timephase = int32(timephase);

%save list_bpm.mat name % To save data

% If need to shift data
% 128 means 1 ring turn
% time phase is defined modulo 128
 timephase = mod(timephase+int32(20),128);

% Write data
h = waitbar(0,'Time Phase loading, please wait');

for i=1:nBPM,
    waitbar(i/nBPM,h)
    tango_write_attribute2(name{i},'TimePhase',timephase(i)); pause(0.01)
    tango_command_inout2(name{i},'SetTimeOnNextTrigger'); pause(0.01)
end
close(h)
