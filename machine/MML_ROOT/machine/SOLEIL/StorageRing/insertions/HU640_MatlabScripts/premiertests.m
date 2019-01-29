soleilinit
getx
plot(getx)
family2dev('BPMx')
family2tango('BPMx')
help getx
help family2tango
doc tango
tango_command_inout('ANS-C08/EI/M-HU80.2_CHAN1', 'State')
tango_error
dev = 'ANS-C08/EI/M-HU80.2_CHAN1';
class(dev)
a=2
class(a)
tango_state(dev)
tango_status(dev)
devM='ans-c08/ei/m-hu80.2_motorscontrol'
tango_command_inout('ANS-C08/EI/M-HU80.2_CHAN1', 'State')
tango_command_inout(devM, 'State')
tango_command_inout2(devM, 'State')
tango_command_inout(devM, 'State4')
tango_command_inout2(devM, 'State4')
tango_command_inout2(devM, 'ON')
tango_command_inout2(devM, 'On')
tango_command_inout2(devM, 'Status')
tango_command_inout2(devM, 'State')
pp = tango_command_inout2(devM, 'State')
tango_command_inout2(devM, 'State')
print(ans)
printf('%s\n', ans)
fprintf('%s\n', ans)
ans
a=2
ans
2
ans
tango_read_attribute2(devM, 'encoder1Position')
a = tango_read_attribute2(devM, 'encoder1Position')
a
a.value
datestr(a.time)
readattribute([devM, 'encoder1Position'])
[devM, 'encoder1Position'])
[devM, 'encoder1Position']
[devM, '/encoder1Position']
readattribute([devM, '/encoder1Position'])
[a z ] = readattribute([devM, '/encoder1Position'])
help readattribute
[a z t] = readattribute([devM, '/encoder1Position'])
edit readattribute.m
datestr(t)
[a z t] = readattribute([devM, '/encoder2Position'])
[a z t] = readattribute([devM, '/encoder3Position'])
[a z t] = readattribute([devM, '/encoder4Position'])
[a z t] = readattribute([devM, '/encoder5Position'])
[a z t] = readattribute([devM, '/encoder6Position'])
tango_command_inout2(devM, 'GotoGap', 2400000)
tango_command_inout2(devM, 'GotoGap', int32(2400000))
[a z t] = readattribute([devM, '/encoder2Position'])
tango_command_inout2(devM, 'Init')
tango_command_inout2(devM, 'State')
tango_command_inout2(devM, 'On')
tango_command_inout2(devM, 'ResetError')
tango_command_inout2(devM, 'Reset')
tango_command_inout2(devM, 'GotoGap', int32(2100000))
tango_command_inout2(devM, 'GotoPhase', int32(50000), int32(50000))
tango_command_inout2(devM, 'GotoPhase', {int32(50000), int32(50000)})
tango_command_inout2(devM, 'GotoPhase', [int32(50000), int32(50000)])
tango_command_inout2(devM, 'Init')
tango_command_inout2(devM, 'GotoPhase', [int32(0), int32(0)])
tango_command_inout2(devM, 'GotoPhase', [int32(100000), int32(-100000)])
tango_command_inout2(devM, 'GotoPhase', [int32(0), int32(0)])
tango_command_inout2(devM, 'GotoGap', int32(2500000))

getx
getz
getam('BPMx')
getam('BPMx',[1 1])
getam('BPMx',[1 1; 1 2])
getam('BPMx',[5 1; 5 2])
family2tangodev('BPMx',[5 1; 5 2])
family2dev('BPMx')
family2status('BPMx')
modelbeta
solorbit
getx
X = getx
I=getdcct

/home/matlabML/mmlcontrol/Ringspecific/insertions

/home/matlabML/measdata/Ringdata/insertions/HU80_TEMPO/

% H orbit
EI.X = getx;
% V orbit
EI.Z = getz;
% encoder #2
EI.encoder2= readattribute([devM, '/encoder2Position']);
% stored current
EI.current = getdcct;
% tunes
EI.tune = gettune;

% measure dispersion functions
[dx dz] = measdisp('Physics');

EI.dx = dx;
EI.dz = dz;

EI.date = datestr(now); % convert date to string

pause(1); % 1 second pause

% measure chromaticities
EI.ksi = measchro('Physics');

%%%%%%%%%%%%%% ARchiving

% If the filename contains a directory then make sure it exists
Filename = 'exemple4Oleg';

FileName = appendtimestamp('G20_P0');
DirectoryName = getfamilydata('Directory','HU80_TEMPO');
DirStart = pwd;
[DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
save(FileName, 'EI_G20_P0');
cd(DirStart);


edit soleilinit
Filename = 'exemple4Oleg'
FileName = appendtimestamp(Filename)
getfamilydata('Directory','HU80_TEMPO')
ls
rm HU80_2006-09-12_17-24-36
remove HU80_2006-09-12_17-24-36
delete HU80_2006-09-12_17-24-36.mat
ls
dir
help save
doc save
getmcf
pwd
save 'toto' EI

%%%%%%%%%%%%%% Calculating theoretical Beta values at the positions of BPMs
modelbeta('BPMx')
[bx bz]=modelbeta('BPMx')
bx
[phx, phz] = modelphase('BPMx')
phx
modeltune
[nux nuz] = modeltune
nu = modeltune

tableCurInCor = [0 0 0 0; -10 0 0 0; -5 0 0 0; 0 0 0 0; 5 0 0 0; 10 0 0 0; 0 0 0 0; 0 -10 0 0; 0 -5 0 0; 0 0 0 0; 0 5 0 0; 0 10 0 0; 0 0 0 0; 0 0 -10 0; 0 0 -5 0; 0 0 0 0; 0 0 5 0; 0 0 10 0; 0 0 0 0; 0 0 0 -10; 0 0 0 -5; 0 0 0 0; 0 0 0 5; 0 0 0 10]

%To measure electron beam and read undulator state, and save the data
%structure to a file
stMeas = idMeasElecBeamUnd('U20_PROXIMA1', 0, 'test_for_chams', 1)

%to estimate effective field integrals of U20
st = idCalcFldIntFromElecBeamMeasForUndSOLEIL_1('U20_PROXIMA1', '/home/matlabML/measdata/Ringdata/insertions/U20_PROXIMA1', 'u20_g5_5_2006-09-29_12-29-58', 'u20_g30_2006-09-29_11-59-57', '', -1)

