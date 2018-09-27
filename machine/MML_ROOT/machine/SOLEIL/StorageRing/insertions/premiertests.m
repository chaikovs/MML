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
tango_command_inout2(tangodevM, 'Reset')
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

/home/production/matlab/matlabML/mmlcontrol/Ringspecific/insertions

/home/production/matlab/matlabML/measdata/Ringdata/insertions/HU80_TEMPO/

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

%%%%%%%%%%%%%% Measuring COD vs Corrector Currents (to estimate corrector efficiency)
tableCurInCor = [0 0 0 0; -10 0 0 0; -5 0 0 0; 0 0 0 0; 5 0 0 0; 10 0 0 0; 0 0 0 0; 0 -10 0 0; 0 -5 0 0; 0 0 0 0; 0 5 0 0; 0 10 0 0; 0 0 0 0; 0 0 -10 0; 0 0 -5 0; 0 0 0 0; 0 0 5 0; 0 0 10 0; 0 0 0 0; 0 0 0 -10; 0 0 0 -5; 0 0 0 0; 0 0 0 5; 0 0 0 10]
[fileNames, res] = idMeasCorEffic('HU80_PLEIADES', tableCurInCor, 0, 'C1G200', 1)
[fileNames, res] = idMeasCorEffic('HU52_DEIMOS', tableCurInCor, 0, 'C1G15_5', 1)
%Formatting corrector efficiency data file names:
sResFormatted = idAuxFormatPartCorElecBeamMeasData(fileNames)

% Create a Bump with the vert. BPMz (14 1,14 2) of 0.1 mm using 5 VCOR apart from the SS
setorbitbump('BPMz',[14 1;14 2],0.1*[1;1],'VCOR',[-5 -4 -3 -2 -1 1 2 3 4 5 ])
%To measure electron beam and read undulator state, and save the data
%structure to a file
stMeas = idMeasElecBeamUnd('U20_PROXIMA1', 0, 'test_for_chams', 1)

%to estimate effective field integrals of U20
IDDirName= getfamilydata('Directory', 'insertions');
st = idCalcFldIntFromElecBeamMeasForUndSOLEIL_1('U20_PROXIMA1', [IDDirName,'U20_PROXIMA1'], 'u20_g5_5_2006-09-29_12-29-58', 'u20_g30_2006-09-29_11-59-57', '', -1)

% Write a table : attributename to be changed
A=[0 1 2 3;
      10 0.2 0.4 0.5;
      20 0.5 0.21 0.45];
  
tango_write_attribute2(dev,'correctionCHEParallelMode',A);  

% how to write at the same time all the correctors
dev= 'ANS-C08/EI/M-HU80.2';
attr_name_val_list(1).value = 0
attr_name_val_list(2).value = 0
attr_name_val_list(3).value = 0
attr_name_val_list(4).value = 0
attr_name_val_list(1).name='currentCHE'
attr_name_val_list(2).name='currentCVE'
attr_name_val_list(4).name='currentCVS'
attr_name_val_list(3).name='currentCHS'

tango_write_attributes(dev,attr_name_val_list);

% to calculate correction tables for feed-forward
%HU80:
stFileNamesMeasCOD = load('/home/data/GMI/HU80_TEMPO/cod_II_filelist_2006-12-10_13-11-12');
vPhase = [-40, -35, -30, -25, -20, -15, -10, -5, 0, 5, 10, 15, 20, 25, 30, 35, 40];
vGap = [15.5, 16, 18, 20, 22.5, 25, 27.5, 30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 130, 150];
fileNamesMeasBkg = idAuxPrepFileNameListMeasAndBkg(stFileNamesMeasCOD.filelist, length(vGap));
arBPM2Skip = [58];
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU80_TEMPO', {{'phase', vPhase}, {'gap', vGap}}, fileNamesMeasBkg, '', '', arBPM2Skip);
mCHE_with_Arg = idAuxMergeCorTableWithArg2D(vGap, vPhase, mCHE);
mCVE_with_Arg = idAuxMergeCorTableWithArg2D(vGap, vPhase, mCVE);
mCHS_with_Arg = idAuxMergeCorTableWithArg2D(vGap, vPhase, mCHS);
mCVS_with_Arg = idAuxMergeCorTableWithArg2D(vGap, vPhase, mCVS);

[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU80_PLEIADES', st_sum.params, st_sum.filenames_meas_bkg, '', '', -1)
[mCHE_with_arg, mCVE_with_arg, mCHS_with_arg, mCVS_with_arg] = idAuxMergeFeedForwardCorTablesWithArgForAppleII(mCHE, mCVE, mCHS, mCVS, st_sum.params)


%U20:
stFileNamesMeasCOD = load('/home/data/GMI/U20_PROXIMA1/test_cod_filelist_2007-01-24_13-17-20.mat');
vGap = [30, 27];
fileNamesMeasBkg = idAuxPrepFileNameListMeasAndBkg(stFileNamesMeasCOD.filename, length(vGap))
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('U20_PROXIMA1', {{'gap', vGap}}, fileNamesMeasBkg, '', '', -1)

%%
dev = 'ANS-C04/EI/M-HU80.1';

tango_write_attribute2(dev,'parallelModeCHE', mCHE_res_with_arg);
tango_write_attribute2(dev,'parallelModeCVE', mCVE_res_with_arg);
tango_write_attribute2(dev,'parallelModeCHS', mCHS_res_with_arg);
tango_write_attribute2(dev,'parallelModeCVS', mCVS_res_with_arg);

%To try changing ID parameters (gap, phase):
resUnd = idSetUndParamSync('HU44_TEMPO', 'gap', 239, 0.01);

%%To measure COD vs Undulator Param(s) automatically:
[resFileNames, resErrorFlag] = idMeasElecBeamVsUndParam('HU80_TEMPO', {{'phase', [-40, -35, -30, -25, -20, -15, -10, -5, 0, 5, 10, 15, 20, 25, 30, 35, 40], 0.01}, {'gap', [15.5], 0.01}}, {{'gap', 250, 0.01}, {'phase', 0, 0.01}}, 2, 0, 'test', 1)
[resFileNames, resErrorFlag] = idMeasElecBeamVsUndParam('HU80_TEMPO', {{'phase', [-40, -35, -30, -25, -20, -15, -10, -5, 0, 5, 10, 15, 20, 25, 30, 35, 40], 0.01}, {'gap', [15.5, 16, 18, 20, 22.5, 25, 27.5, 30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 130, 150], 0.01}}, {{'gap', 250, 0.01}, {'phase', 0, 0.01}}, 1, 0, 'cod_X_01_07', 1)
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_PLEIADES', {{'phase', [-40, -35, -30, -25, -20, -15, -10, -5, 0, 5, 10, 15, 20, 25, 30, 35, 40], 0.01}, {'gap', [15.5, 16, 18, 20], 0.01}}, {{'gap', 250, 0.01}, {'phase', 0, 0.01}}, 1, 0, 'cod_extra_II', 1)
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_PLEIADES', {{'phase', phVals, 0.01}, {'gap', [15.5], 0.01}}, {{'gap', 239.9, 0.01}, {'phase', 0, 0.01}}, 2, 0, 'cod_II_iter_test01', 1)

[resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_CASSIOPEE', {{'phase', [-40,-37.5, -35,-32.5, -30,-27.5, -25,-22.5, -20,-17.5, -15,-12.5, -10,-7.5, -5,-2.5, 0,2.5, 5,7.5, 10,12.5, 15,17.5, 20,22.5, 25,27.5, 30,32.5, 35, 37.5,40], 0.01}, {'gap', [15.5, 16, 18, 20, 22.5, 25, 27.5, 30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 130, 150, 175, 200, 225, 250], 0.01}}, {{'phase', 0, 0.01}, {'gap', 250, 0.01}}, 1, 0, 'cod_1st_test', 1)
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_CASSIOPEE', {{'phase', [-40,-37.5, -35,-32.5, -30,-27.5, -25,-22.5, -20,-17.5, -15,-12.5, -10,-7.5, -5,-2.5, 0,2.5, 5,7.5, 10,12.5, 15,17.5, 20,22.5, 25,27.5, 30,32.5, 35, 37.5,40], 0.01}, {'gap', [15.5, 16, 18, 20, 22.5, 25, 27.5, 30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 130, 150, 175, 200, 225, 250], 0.01}}, {{'phase', 0, 0.01}, {'gap', 250, 0.01}}, 1, 0, 'cod_gen_X', 1)
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_CASSIOPEE', {{'phase', [40], 0.01}, {'gap', [15.5, 16, 18, 20, 22.5, 25, 27.5, 30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 130, 150], 0.01}}, {{'phase', 0, 0.01}, {'gap', 250, 0.01}}, 1, 0, 'cod_1st_test', 1)
[resFileNames, resErrorFlag] = idMeasElecBeamVsUndParam('U20_PROXIMA1', {{'gap', [5.5, 6, 10], 0.01}}, {{'gap', 30, 0.01}}, 1, 0, 'test_cod', 1)
% commande pour lucia 21/07/08
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU52_LUCIA', {{'phase',[-26:3.25:26] , 0.01}, {'gap', [15.5, 16, 18, 20, 22.5, 25, 27.5, 30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 130, 150, 175, 200, 225, 239.5], 0.01}}, {{'phase', 0, 0.01}, {'gap', 240, 0.01}}, 1, 0, 'cod_1st_test', 1)

%U20 COD meas. and calc. of cor. tables:
[resFileNames, resErrorFlag] = idMeasElecBeamVsUndParam('U20_PROXIMA1', {{'gap', [5.5, 6, 10], 0.01}}, {{'gap', 30, 0.01}}, 1, 0, 'test_cod', 1)

[resFileNames, resErrorFlag] = idMeasElecBeamVsUndParam('U20_CRISTAL', {{'gap', [5.5,5.6,5.7,5.8,5.9,6,6.1,6.2,6.3,6.4,6.5,6.6,6.7,6.8,6.9,7,7.1,7.2,7.3,7.4,7.5,7.6,7.7,7.8,7.9,8,8.1,8.2,8.3,8.4,8.5,8.6,8.7,8.8,8.9,9,9.1,9.2,9.3,9.4,9.5,9.6,9.7,9.8,9.9,10,10.2,10.4,10.6,10.8,11,11.2,11.4,11.6,11.8,12,12.2,12.4,12.6,12.8,13,13.2,13.4,13.6,13.8,14,14.2,14.4,14.6,14.8,15,15.2,15.4,15.6,15.8,16,16.2,16.4,16.6,16.8,17,17.2,17.4,17.6,17.8,18,18.2,18.4,18.6,18.8,19,19.2,19.4,19.6,19.8,20,20.5,21,21.5,22,22.5,23,23.5,24,24.5,25,25.5,26,26.5,27,27.5,28,28.5,29,29.5], 0.01}}, {{'gap', 30, 0.01}}, 1, 0, 'test_cod', 1)
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('U20_CRISTAL', resFileNames.params, resFileNames.filenames_meas_bkg, '', '', -1)
stMeas = idMeasElecBeamUnd('U20_CRISTAL', 0, 'U20_CRISTAL_CVE_6', 1)
%st.filelist = resFileNames; idSavetangoStruct(st, 'test_cod_filelist', 'U20_PROXIMA1', 0)
    %do something else...
%ls /home/data/GMI/U20_PROXIMA1
%stFileNamesMeasCOD = load('/home/data/GMI/U20_PROXIMA1/test_cod_filelist_2007-01-24_14-20-54.mat');
%vGap = [5.5, 6, 10];
%fileNamesMeasBkg = idAuxPrepFileNameListMeasAndBkg(stFileNamesMeasCOD.filelist, length(vGap));
%[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('U20_PROXIMA1', {{'gap', vGap}}, fileNamesMeasBkg, '', '', -1);
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('U20_PROXIMA1', resFileNames.params, resFileNames.filenames_meas_bkg, '', '', -1)

%CHAMS, I've tested the COD meas. using idMeasElecBeamVsUndParam. It seems to work fine now. 03/02/2007 OC
[resFNames, resErrorFlag] = idMeasElecBeamVsUndParam('U20_PROXIMA1', {{'gap', [29.5, 29.7], 0.01}}, {{'gap', 30, 0.01}}, 1, 0, 'test_cod_to_delete', 1)


%Make Bump walking aroung eventual saturation of BPMs:
idSetOrbitBump('BPMx', [4 1;4 2], [4.5,4.5], 'HCOR', [-4,-3,-2,-1,1,2,3,4]);
%Measurement of COD vs Horizontal Bump:
[resBumpMeasPLEIADES, ErrorFlag] = idMeasElecBeamVsUndParamVsBump('HU80_PLEIADES', {{'phase', [-40,-20,0,20,40], 0.01}, {'gap', [15.5], 0.01}}, {{'gap', 250, 0.01}, {'phase', 0, 0.01}}, 2, 0, 'inj_problem', 1, 'H', {[1,1],[-4.5,-4,-3.5,-3,-2.5,-2,-1.5,-1,-0.5,0,0.5,1,1.5,2,2.5,3,3.5,4,4.5]}, [-4,-3,-2,-1,1,2,3,4]);
[resBumpMeasDEIMOS, ErrorFlag] = idMeasElecBeamVsUndParamVsBump('HU52_DEIMOS', {{'phase', [-25.99,-13,0,13,25.99], 0.01}, {'gap', [15.5], 0.01}}, {{'gap', 249, 0.01}, {'phase', 0, 0.01}}, 2, 0, 'bump_test', 1, 'H', {[1,1],[-4.5,-4,-3.5,-3,-2.5,-2,-1.5,-1,-0.5,0,0.5,1,1.5,2,2.5,3,3.5,4,4.5]}, [-4,-3,-2,-1,1,2,3,4]);

%Calculation of Field Integrals and other characteristics vs Horizontal Bump:
[vI1x, vI2x, vI1z, vI2z, vPosBump, vKickX1, vKickX2, vKickZ1, vKickZ2, dNuX, dNuZ] = idCalcFldIntVsBumpFromElecBeamMeasForUndSOLEIL('HU80_PLEIADES', '/home/data/GMI/GrpGMI/HU80_PLEIADES', resBumpMeasPLEIADES, {{'phase', -40}, {'gap', 15.5}}, '', {[3 3],[3 4],[3 5],[3 6],[3 7],[3 8],[4 1],[4 2],[4 3],[4 4],[4 5],[4 6],[4 7],    [5 3]});

[vI1xP0c, vI2xP0c, vI1zP0c, vI2zP0c, vPosBumpC, vKickX1P0c, vKickX2P0c, vKickZ1P0c, vKickZ2P0c, dNuXP0c, dNuZP0c] = idCalcFldIntVsBumpFromElecBeamMeasForUndSOLEIL('HU80_CASSIOPEE', '/home/data/GMI/HU80_CASSIOPEE', stBumpCAS.resBumpMeas, {{'phase', 0}, {'gap', 15.5}}, '', {[8 1],[8 2],[8 3],[8 4],[8 5],[8 6],[8 7],[9 1],[9 2],[9 3],[9 4],[9 5],[9 6],[9 7]})
[vI1xPm40_PL, vI2xPm40_PL, vI1zPm40_PL, vI2zPm40_PL, vPosBumpPm40_PL, vKickX1Pm40_PL, vKickX2Pm40_PL, vKickZ1Pm40_PL, vKickZ2Pm40_PL, dNuXPm40_PL, dNuZPm40_PL] = idCalcFldIntVsBumpFromElecBeamMeasForUndSOLEIL('HU80_PLEIADES', 'E:\MagnetsAndSR\InsertionDevices\HU80\Commissioning\from_control_room\july16_2007\HU80_PLEIADES', cod_bump_pleiades.resBumpMeas, {{'gap',15.5}, {'phase',-40}}, 'E:\MagnetsAndSR\InsertionDevices\HU80\Commissioning\IDStarter', {[3 3],[3 4],[3 5],[3 6],[3 7],[3 8],[4 1],[4 2],[4 3],[4 4],[4 5],[4 6],[4 7],[5,1],[5,2],[5 3]}, vKick2x_rad, vKick2z_rad)

[new_mCHE_with_arg, new_mCVE_with_arg, new_mCHS_with_arg, new_mCVS_with_arg] = idUpdateFeedForwardCorTables2D('HU80_PLEIADES', {'antiParallelModeCHE', mCHE_with_arg}, {'antiParallelModeCVE', mCVE_with_arg}, {'antiParallelModeCHS', mCHS_with_arg}, {'antiParallelModeCVS', mCVS_with_arg}, vArgVert, vArgHor, updateMode, interpMeth

%Partial COD measurement and update of FF cor. tables
vPhase = [-40, -35, -30, -25, -20, -15, -10, -5, 0, 5, 10, 15, 20, 25, 30, 35, 40];
vGap = [15.5];
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_TEMPO', {{'phase', vPhase, 0.01}, {'gap', vGap, 0.01}}, {{'phase', 0, 0.01}, {'gap', 239.5, 0.01}}, 2, 0, 'cod_it1_test', 1);
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU80_TEMPO', {{'phase', vPhase}, {'gap', vGap}}, resFiles.filenames_meas_bkg, '', '', -1);
[new_mCHE_wa, new_mCVE_wa, new_mCHS_wa, new_mCVS_wa] = idUpdateFeedForwardCorTables2D('HU80_TEMPO', {'parallelModeCHE', mCHE}, {'parallelModeCVE', mCVE}, {'parallelModeCHS', mCHS}, {'parallelModeCVS', mCVS}, vGap, vPhase, 2, 'linear')

[resFiles, resErr] = idMeasElecBeamVsUndParam('HU44_TEMPO', {{'phase', [0], 0.01}, {'gap', [15.5, 16, 18, 20, 22.5, 25, 27.5, 30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 130, 150, 175, 239.5], 0.01}}, {{'phase', 0, 0.01}, {'gap', 239.9, 0.01}}, 1, 0, 'codII_it01', 1)
[new_mCHE_wa, new_mCVE_wa, new_mCHS_wa, new_mCVS_wa] = idUpdateFeedForwardCorTables2D('HU44_TEMPO', {'parallelModeCHE', mCHE_it01}, {'parallelModeCVE', mCVE_it01}, {'parallelModeCHS', mCHS_it01}, {'parallelModeCVS', mCVS_it01}, resFiles.params{2}{2}, resFiles.params{1}{2}, 2, 'linear')

for i = 1:23 vPhasesR(i) = -22 + (i - 1)*2; end
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU44_TEMPO', {{'phase', vPhasesR, 0.01}, {'gap', [15.5], 0.01}}, {{'phase', 0, 0.01}, {'gap', 239.9, 0.01}}, 1, 0, 'codII_it02', 1)


%Calculating FF tables for HU52_DEIMOS (semi-manual method):====================================
%---reading summary structure of COD measurements for II mode:
st_sum_hu52IIclean = load('/home/data/GMI/HU52_DEIMOS/cod04_II_summary_2007-12-05_03-00-56.mat');
%---calculating FF tables for the mesh vs gap and phase, corresponding to the COD measurements:
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU52_DEIMOS', {{'phase', st_sum_hu52IIclean.params{1}{2}}, {'gap', st_sum_hu52IIclean.params{2}{2}}}, st_sum_hu52IIclean.filenames_meas_bkg, '', '', -1)
%---optional: removing lines from FF tables for the 175 < gap <= 250, where correctors 
%are not efficient for horizontal field; and padding zeros for gap = 250 mm:
mCHEr = idAuxMatrResizeExt(mCHE, 20, 17, 1, 1); mCHEr = idAuxMatrResizeExt(mCHEr, 21, 17, 1, 1);
mCHSr = idAuxMatrResizeExt(mCHS, 20, 17, 1, 1); mCHSr = idAuxMatrResizeExt(mCHSr, 21, 17, 1, 1);
mCVEr = idAuxMatrResizeExt(mCVE, 20, 17, 1, 1); mCVEr = idAuxMatrResizeExt(mCVEr, 21, 17, 1, 1);
mCVSr = idAuxMatrResizeExt(mCVS, 20, 17, 1, 1); mCVSr = idAuxMatrResizeExt(mCVSr, 21, 17, 1, 1);
%---merging calculated FF tables with arguments, to have exactly the same format as in DServers:
paramsR = st_sum_hu52IIclean.params;
paramsR{2}{2} = [15.5, 16.0, 18.0, 20.0, 22.5, 25.0, 27.5, 30.0, 35.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0,100.0,110.0,130.0,150.0,175.0,250];
[mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa] = idAuxMergeFeedForwardCorTablesWithArgForAppleII(mCHEr, mCVEr, mCHSr, mCVSr, paramsR)
%---defining new phase values for the interpolated tables:
for i = 1:33 vPhasesD(i) = -26 + (i - 1)*(52/32); end
vPhasesD(1) = -25.99; vPhasesD(33) = 25.99;
%---interpolating the FF tables on a more dense mesh:
[new_mCHE_wa, new_mCVE_wa, new_mCHS_wa, new_mCVS_wa] = idInterpolFeedForwardCorTables2D(mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa, paramsR{2}{2}, vPhasesD, 'linear')
%---updating the newly-created FF tables in DServer:
[new_mCHE_wa, new_mCVE_wa, new_mCHS_wa, new_mCVS_wa] = idUpdateFeedForwardCorTables2D('HU52_DEIMOS', {'parallelModeCHE', new_mCHE_wa}, {'parallelModeCVE', new_mCVE_wa}, {'parallelModeCHS', new_mCHS_wa}, {'parallelModeCVS', new_mCVS_wa}, -1, -1, 1, 'linear')
%%
%%----------------Calcul tableFFWD LUCIA mode antiparallele
%-----------------à executer avant du demi-run avec Charles
st_sum_hu52Xclean = load('/home/data/GMI/HU52_LUCIA/cod_test_1_summary_2008-07-21_02-45-31.mat');
%---calculating FF tables for the mesh vs gap and phase, corresponding to the COD measurements:
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU52_LUCIA', {{'phase', st_sum_hu52Xclean.params{1}{2}}, {'gap', st_sum_hu52Xclean.params{2}{2}}}, st_sum_hu52Xclean.filenames_meas_bkg, '', '', -1);
%---optional: removing lines from FF tables for the 175 < gap <= 250, where correctors 
%are not efficient for horizontal field; and padding zeros for gap = 250 mm:
mCHEr = idAuxMatrResizeExt(mCHE, 20, 17, 1, 1); mCHEr = idAuxMatrResizeExt(mCHEr, 21, 17, 1, 1);
mCHSr = idAuxMatrResizeExt(mCHS, 20, 17, 1, 1); mCHSr = idAuxMatrResizeExt(mCHSr, 21, 17, 1, 1);
mCVEr = idAuxMatrResizeExt(mCVE, 20, 17, 1, 1); mCVEr = idAuxMatrResizeExt(mCVEr, 21, 17, 1, 1);
mCVSr = idAuxMatrResizeExt(mCVS, 20, 17, 1, 1); mCVSr = idAuxMatrResizeExt(mCVSr, 21, 17, 1, 1);
%---merging calculated FF tables with arguments, to have exactly the same format as in DServers:

paramsR = st_sum_hu52Xclean.params;
paramsR{2}{2} = [15.5, 16.0, 18.0, 20.0, 22.5, 25.0, 27.5, 30.0, 35.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0,100.0,110.0,130.0,150.0,175.0,240];
% idAuxMergeFeedForward..... permet d'ajouter les phases(1ere ligne) et gaps(1ere colonne)
[mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa] = idAuxMergeFeedForwardCorTablesWithArgForAppleII(mCHE, mCVE, mCHS, mCVS, paramsR);
for i = 1:33 vPhasesD(i) = -26 + (i - 1)*(52/32); end
vPhasesD(1) = -26; vPhasesD(33) = 26;
%---interpolating the FF tables on a more dense mesh:
[new_mCHE_wa, new_mCVE_wa, new_mCHS_wa, new_mCVS_wa] = idInterpolFeedForwardCorTables2D(mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa, paramsR{2}{2}, vPhasesD, 'linear')
%---updating the newly-created FF tables in DServer:
[new_mCHE_wa, new_mCVE_wa, new_mCHS_wa, new_mCVS_wa] = idUpdateFeedForwardCorTables2D('HU52_LUCIA', {'antiParallelModeCHE', new_mCHE_wa}, {'antiParallelModeCVE', new_mCVE_wa}, {'antiParallelModeCHS', new_mCHS_wa}, {'antiParallelModeCVS', new_mCVS_wa}, -1, -1, 1, 'linear')

[resFiles, resErr] = idMeasElecBeamVsUndParam('HU44_MICROFOC', {{'phase',[-22:2.75:22] , 0.01}, {'gap', [15.5, 16, 18, 20, 22.5, 25, 27.5, 30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 130, 150, 175, 200, 225, 239], 0.01}}, {{'phase', 0, 0.01}, {'gap', 240, 0.01}}, 1, 0, 'cod_X', 1)
HU44_MICROFOC_Struct_X=resFiles;
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU44_MICROFOC', {{'phase', HU44_MICROFOC_Struct_X.params{1}{2}}, {'gap', HU44_MICROFOC_Struct_X.params{2}{2}}}, HU44_MICROFOC_Struct_X.filenames_meas_bkg, '', '', -1);
ParamR=HU44_MICROFOC_Struct_X.params;
ParamR{2}{2}=[15.5000   16.0000   18.0000   20.0000   22.5000   25.0000   27.5000   30.0000   35.0000   40.0000   50.0000   60.0000 70.0000   80.0000   90.0000  100.0000  110.0000  130.0000  150.0000  175.0000  239.0000] % On enlève les valeurs de gaps déconnantes
mCVEr = idAuxMatrResizeExt(mCVE, 20, 17, 1, 1); mCVEr = idAuxMatrResizeExt(mCVEr, 21, 17, 1, 1); % idem pour les 3 autres
[mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa] = idAuxMergeFeedForwardCorTablesWithArgForAppleII(mCHEr, mCVEr, mCHSr, mCVSr, ParamR)
vphaseD=-22:2:22;
[new_mCHE_wa, new_mCVE_wa, new_mCHS_wa, new_mCVS_wa] = idInterpolFeedForwardCorTables2D(mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa, ParamR{2}{2}, vPhasesD, 'linear')

vPhase = [-4:2:4]
vgap = [15.5,16,18,20,22.5,25,27.5,30]
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU44_MICROFOC', {{'phase', vPhase, 0.01}, {'gap', vgap, 0.01}}, {{'phase', 0, 0.01}, {'gap', 239.5, 0.01}}, 2, 0, 'cod_Xit1_test', 1);
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU44_MICROFOC', {{'phase', vPhase}, {'gap', vgap}}, resFiles.filenames_meas_bkg, '', '', -1)
Some "nan" appear in the tables. We load an orbit. The nan is the 2nd value of the vector. => We skipp BPM n°2
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU44_MICROFOC', {{'phase', vPhase}, {'gap', vgap}}, resFiles.filenames_meas_bkg, '', '', 2)
[mCHEit1, mCVEit1, mCHSit1, mCVSit1] = idAuxMergeFeedForwardCorTablesWithArgForAppleII(mCHE, mCVE, mCHS, mCVS, resFiles.params)
idUpdateFeedForwardCorTables2D('HU44_MICROFOC', {'antiParallelModeCHE', mCHEit1}, {'antiParallelModeCVE', mCVEit1}, {'antiParallelModeCHS', mCHSit1}, {'antiParallelModeCVS', mCVSit1}, -1, -1, 2, 'linear')    % False!!
[mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa]=idUpdateFeedForwardCorTables2D('HU44_MICROFOC', {'antiParallelModeCHE', mCHEit1}, {'antiParallelModeCVE', mCVEit1}, {'antiParallelModeCHS', mCHSit1}, {'antiParallelModeCVS', mCVSit1}, vgap, vPhase, 2, 'linear') % Doesn't work : we obtain currents up to 21 A!!!
% It seems to work to be chexked during the next run
[new_mCHE1_wa, new_mCVE1_wa, new_mCHS1_wa, new_mCVS1_wa] =idUpdateFeedForwardCorTables2D('HU44_MICROFOC', {'antiParallelModeCHE', mCHE1}, {'antiParallelModeCVE', mCVE1}, {'antiParallelModeCHS', mCHS1}, {'antiParallelModeCVS', mCVS1}, vgap, vPhase, 2, 'linear')% mCVE*, mCHE*, mCHS*, mCVS are not merged but we give as argument the phase and the gap
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Sauvergarde d'une structure
save ('/home/data/GMI/HU44_MICROFOC/cod_Xit1_test_phase-4_gap15_5_2008-10-21_00-17-07', '-struct',  'toto1')
tata=load('/home/data/GMI/HU44_MICROFOC/cod_Xit1_test_phase-4_gap15_5_2008-10-21_00-17-07')



%commissioning d'un onduleur sous vide

[resFileNames, resErrorFlag] = idMeasElecBeamVsUndParam('U20_CRISTAL', {{'gap', [5.5,5.6,5.7,5.8,5.9,6,6.1,6.2,6.3,6.4,6.5,6.6,6.7,6.8,6.9,7,7.1,7.2,7.3,7.4,7.5,7.6,7.7,7.8,7.9,8,8.1,8.2,8.3,8.4,8.5,8.6,8.7,8.8,8.9,9,9.1,9.2,9.3,9.4,9.5,9.6,9.7,9.8,9.9,10,10.2,10.4,10.6,10.8,11,11.2,11.4,11.6,11.8,12,12.2,12.4,12.6,12.8,13,13.2,13.4,13.6,13.8,14,14.2,14.4,14.6,14.8,15,15.2,15.4,15.6,15.8,16,16.2,16.4,16.6,16.8,17,17.2,17.4,17.6,17.8,18,18.2,18.4,18.6,18.8,19,19.2,19.4,19.6,19.8,20,20.5,21,21.5,22,22.5,23,23.5,24,24.5,25,25.5,26,26.5,27,27.5,28,28.5,29,29.5], 0.01}}, {{'gap', 30, 0.01}}, 1, 0, 'test_cod', 1)
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('U20_CRISTAL', resFileNames.params, resFileNames.filenames_meas_bkg, '', '', -1)
stMeas = idMeasElecBeamUnd('U20_CRISTAL', 0, 'U20_CRISTAL_CVE_6', 1)

%commissioning de HU60 antares
% 14/07/09 F.Marteau

[resFiles, resErr] = idMeasElecBeamVsUndParam('HU60_ANTARES', {{'phase',[-30:3.75:30] , 0.01}, {'gap', [15.5, 16, 18, 20, 22.5, 25, 27.5, 30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 130, 150, 175, 200, 225, 239], 0.01}}, {{'phase', 0, 0.01}, {'gap', 240, 0.01}}, 1, 0, 'cod_P', 1)
% commande pour calibration des correcteurs de HU60
tableCurInCor = [0 0 0 0; -10 0 0 0; -5 0 0 0; 0 0 0 0; 5 0 0 0; 10 0 0 0; 0 0 0 0; 0 -10 0 0; 0 -5 0 0; 0 0 0 0; 0 5 0 0; 0 10 0 0; 0 0 0 0; 0 0 -10 0; 0 0 -5 0; 0 0 0 0; 0 0 5 0; 0 0 10 0; 0 0 0 0; 0 0 0 -10; 0 0 0 -5; 0 0 0 0; 0 0 0 5; 0 0 0 10]
[fileNames, res] = idMeasCorEffic('HU60_ANTARES', tableCurInCor, 0, 'C1G15_5', 1) % pour gap 15.5

% test FM OTP 31/01/10 sur Hu80 Microfoc
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_MICROFOC', {{'phase',[-0.1,0,0.1] , 0.01}, {'gap', [239.5,239.6], 0.01}}, {{'phase', 0, 0.01}, {'gap', 240, 0.01}}, 1, 0, 'test', 1)
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_MICROFOC', {{'phase',[-40:4:40] , 0.01}, {'gap', [15.5, 16, 18, 20, 22.5, 25, 27.5, 30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 130, 150, 175, 200, 225, 239], 0.01}}, {{'phase', 0, 0.01}, {'gap', 240, 0.01}}, 1, 0, 'COD_P', 1)
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_MICROFOC', {{'phase',[4:4:40] , 0.01}, {'gap', [15.5, 16, 18, 20, 22.5, 25, 27.5, 30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 130, 150, 175, 200, 225, 239], 0.01}}, {{'phase', 0, 0.01}, {'gap', 240, 0.01}}, 1, 0, 'COD_X_2', 1)
 % Bump HU60 CASSIOPEE 
 vPhase = [-30:3:30]
 setorbitbump('BPMx',[15 1; 15 2], 1.0*[0.5 ; 0.5],'HCOR', [-4 -3 -2 -1 1 2 3 4],'FitRF')
 [resFiles, resErr] = idMeasElecBeamVsUndParam('HU60_CASSIOPEE', {{'gap', [15.5], 0.01},{'phase',vPhase, 0.01},}, {{'phase', 0, 0.01}, {'gap', 240, 0.01}}, 1, 0, 'codX_BP_0mm', 1)
 
  % Bump HU60 ANTARES
 vPhase = [-30:3:30]
 setorbitbump('BPMx',[12 1; 12 2], 1.0*[0.5 ; 0.5],'HCOR', [-4 -3 -2 -1 1 2 3 4],'FitRF')
 [resFiles, resErr] = idMeasElecBeamVsUndParam('HU60_ANTARES', {{'gap', [15.5], 0.01},{'phase',vPhase, 0.01},}, {{'phase', 0, 0.01}, {'gap', 240, 0.01}}, 1, 0, 'codX_BP_0mm', 1)
 
 %Mise à jour des tables de HU44 TEMPO FM et LC 27/06/10
 
 
 % MAJ HU80 PLEIADES 21/01/2011
 % Calibration des correcteurs le 06/12/2011
 % Acquisition des COD ANTI et PARA le 13/12/2011
 st = load('/home/data/GMI/HU80_PLEIADES/cod_HU80_PLEIADES_ANTI_summary_2010-12-14_02-35-52.mat')

[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU80_PLEIADES', {{'phase', st.params{1}{2},0.01}}, {{'gap', st.params{2}{2},0.01}}, st.filenames_meas_bkg, '', '', -1)


hu44_tempo=load('MAJ_2706_P_summary_2010-06-28_01-46-19.mat')
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU44_TEMPO', {{'phase', hu44_tempo.params{1}{2}}, {'gap', hu44_tempo.params{2}{2}}}, hu44_tempo.filenames_meas_bkg, '', '', -1)
mCHEr = idAuxMatrResizeExt(mCHE, 20, 17, 1, 1) % suppression des valeurs de correcteurs non significatifs entre 175 et 240 mm
mCHEr = idAuxMatrResizeExt(mCHEr, 21, 17, 1, 1)% ajout de la valeur 0 pour gap 240
mCHSr = idAuxMatrResizeExt(mCHS, 20, 17, 1, 1); mCHSr = idAuxMatrResizeExt(mCHSr, 21, 17, 1, 1);
mCVEr = idAuxMatrResizeExt(mCVE, 20, 17, 1, 1); mCVEr = idAuxMatrResizeExt(mCVEr, 21, 17, 1, 1);
mCVSr = idAuxMatrResizeExt(mCVS, 20, 17, 1, 1); mCVSr = idAuxMatrResizeExt(mCVSr, 21, 17, 1, 1);
paramsR = hu44_tempo.params;
paramsR{2}{2} = [15.5, 16.0, 18.0, 20.0, 22.5, 25.0, 27.5, 30.0, 35.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0,100.0,110.0,130.0,150.0,175.0,240];
%---------------------
% ajout de la ligne de phase et de la colonne de gap
%--------------------
[mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa] = idAuxMergeFeedForwardCorTablesWithArgForAppleII(mCHEr, mCVEr, mCHSr, mCVSr, paramsR);
%-----------------------------
for i = 1:45 vPhasesD(i) = -22 + (i - 1)*(44/44); end   % nouvelles valeurs de phases pour interpolation
[new_mCHE_wa, new_mCVE_wa, new_mCHS_wa, new_mCVS_wa] = idInterpolFeedForwardCorTables2D(mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa, paramsR{2}{2}, vPhasesD, 'linear')
save('maj_cve.txt','new_mCVE_wa','-ascii')  %sauvegarde au format texte des nouvelles tables
save('maj_cvs.txt','new_mCVS_wa','-ascii')  % comme les acquisitions des COD ont ete faite avec le FFWD, il faut
save('maj_chs.txt','new_mCHS_wa','-ascii')  % ajouter ces tables aux tables deja existantes
save('maj_che.txt','new_mCHE_wa','-ascii')  %--> utilisation de OpenOffice pour faire la somme "à la main"


RUN SEXTANTS 05 / 03 / 2011 : Mise à jour des tables !!!

old_mCHS_II=load('/usr/Local/configFiles/InsertionFFTables/ANS-C14-HU80/FF_PARALLEL_CHS_TABLE.txt');
[old_mCHE_II_int, old_mCVE_II_int, old_mCHS_II_int, old_mCVS_II_int] = idInterpolFeedForwardCorTables2D(old_mCHE_II, old_mCVE_II, old_mCHS_II, old_mCVS_II, [15.5:0.5:240], [-40:1:40], 'linear')
old_mCVE_II_int=old_mCVE_II_int(1:449, :);
old_mCHE_II_int=old_mCHE_II_int(1:449, :);
old_mCHS_II_int=old_mCHS_II_int(1:449, :);
old_mCVS_II_int=old_mCVS_II_int(1:449, :);

Structure=load('/home/data/GMI/HU80_SEXTANTS/cod_HU80_PLEIADES_PARA_summary_2011-01-24_03-18-39.mat')
idCalcFeedForwardCorTables('HU80_SEXTANTS', {{'phase', BKG.params{1}{2}}, {'gap', BKG.params{2}{2}}}, BKG.filenames_meas_bkg, '', '', -1);

[maj_mCHE, maj_mCVE, maj_mCHS, maj_mCVS] = idCalcFeedForwardCorTables('HU80_SEXTANTS', {{'phase', Structure.params{1}{2}}, {'gap', Structure.params{2}{2}}}, Structure.filenames_meas_bkg, '', '', -1);
[maj_mCHE_wa, maj_mCVE_wa, maj_mCHS_wa, maj_mCVS_wa] = idAuxMergeFeedForwardCorTablesWithArgForAppleII(maj_mCHE, maj_mCVE, maj_mCHS, maj_mCVS, Structure.params)
[maj_mCHE_wa_int, maj_mCVE_wa_int, maj_mCHS_wa_int, maj_mCVS_wa_int] = idInterpolFeedForwardCorTables2D(maj_mCHE_wa, maj_mCVE_wa, maj_mCHS_wa, maj_mCVS_wa, [15.5:0.5:240], [-40:1:40], 'linear')

maj_mCHE_wa_int_II=maj_mCHE_wa_int(1:449, :);
maj_mCVE_wa_int_II=maj_mCVE_wa_int(1:449, :);
maj_mCVS_wa_int_II=maj_mCVS_wa_int(1:449, :);
maj_mCHS_wa_int_II=maj_mCHS_wa_int(1:449, :);
new_mCHS_wa_II=old_mCHS_II_int;
new_mCVS_wa_II=old_mCVS_II_int;
new_mCVE_wa_II=old_mCVE_II_int;
new_mCVE_wa_II(2:449, 2:82)=old_mCVE_II_int(2:449, 2:82)+maj_mCVE_wa_int_II(2:449, 2:82);
new_mCVS_wa_II(2:449, 2:82)=old_mCVS_II_int(2:449, 2:82)+maj_mCVS_wa_int_II(2:449, 2:82);
new_mCVS_wa_II(2:449, 2:82)=old_mCVS_II_int(2:449, 2:82)+maj_mCVS_wa_int_II(2:449, 2:82);
new_mCHS_wa_II(2:449, 2:82)=old_mCHS_II_int(2:449, 2:82)+maj_mCHS_wa_int_II(2:449, 2:82);
save('/usr/Local/configFiles/InsertionFFTables/ANS-C14-HU80/FF_PARALLEL_CHE_TABLE.txt','new_mCHE_wa_II','-ascii')
save('/usr/Local/configFiles/InsertionFFTables/ANS-C14-HU80/FF_PARALLEL_CHS_TABLE.txt','new_mCHS_wa_II','-ascii')
save('/usr/Local/configFiles/InsertionFFTables/ANS-C14-HU80/FF_PARALLEL_CVS_TABLE.txt','new_mCVS_wa_II','-ascii')
save('/usr/Local/configFiles/InsertionFFTables/ANS-C14-HU80/FF_PARALLEL_CVE_TABLE.txt','new_mCVE_wa_II','-ascii')
%--------------------------------
% Acquisition des COD pour HU42
%------------------------------
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU42_HERMES', {{'phase',[-21:2.625:21] , 0.01}, {'gap', [15.5, 16, 18, 20, 22.5, 25, 27.5, 30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 130, 150, 175, 200, 225, 239], 0.01}}, {{'phase', 0, 0.01}, {'gap', 240, 0.01}}, 1, 0, 'cod_X', 1)
%--------------------------------
%------------------------------
[structureAllFileNames, res] = idMeasCorEfficForAllGaps('HU42_HERMES', '', 10, [15.5, 16, ...], 1)
%  [structureAllFileNames, res] = idMeasCorEfficForAllGaps(idName, fileNameCore, maxAbsCorCurrent, vectorOfGaps, dispData)
 idAuxFormatElecBeamMeasDataAfterEfficiency(structureAllFileNames, 0)
%  idAuxFormatElecBeamMeasDataAfterEfficiency(EfficiencyResutlStructure, displayOnScreen)
% calcul des tables de HU42
st_sum_hu42 = load('/home/data/GMI/HU42_HERMES/cod_P_summary_2011-01-24_10-35-01.mat');
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU42_HERMES', {{'phase', st_sum_hu42.params{1}{2}}, {'gap', st_sum_hu42.params{2}{2}}}, st_sum_hu42.filenames_meas_bkg, '', '', -1)
% j'ai supprimé les lignes a partir de gap 175 (j'ai gardé 150) à 240
% puis j'ai remplacé la ligne de 240 par des zeros
% voici donc la liste des gaps
paramsR{2}{2} = [15.5, 16.0, 18.0, 20.0, 22.5, 25.0, 27.5, 30.0, 35.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0,100.0,110.0,130.0,150.0,240]
% j'ai "redensifier" le mesh des phases
for i = 1:33 vPhasesD(i) = -21 + (i - 1)*(42/32); end
[new_mCHE_wa, new_mCVE_wa, new_mCHS_wa, new_mCVS_wa] = idInterpolFeedForwardCorTables2D(mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa, paramsR{2}{2}, vPhasesD, 'linear');
save('/usr/Local/configFiles/InsertionFFTables/ANS-C10-HU42/FF_PARALLEL_CHE_TABLE.txt','new_mCHE_wa','-ascii');
save('/usr/Local/configFiles/InsertionFFTables/ANS-C10-HU42/FF_PARALLEL_CVE_TABLE.txt','new_mCVE_wa','-ascii');
save('/usr/Local/configFiles/InsertionFFTables/ANS-C10-HU42/FF_PARALLEL_CHS_TABLE.txt','new_mCHS_wa','-ascii');
save('/usr/Local/configFiles/InsertionFFTables/ANS-C10-HU42/FF_PARALLEL_CVS_TABLE.txt','new_mCVS_wa','-ascii');
% apres l'iteration 2 : calcul des mise a jour de la table mode para:
st_sum_hu42 = load('/home/data/GMI/HU42_HERMES/it2_P_summary_2011-03-22_04-33-16.mat');
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU42_HERMES', {{'phase', st_sum_hu42.params{1}{2}}, {'gap', st_sum_hu42.params{2}{2}}}, st_sum_hu42.filenames_meas_bkg, '', '', -1)
% reste a mettre en place la nouvelle table... a suivre
%--------------------------------------------------------------------------
% 13/06/2011 Calibration des correcteurs de HU42
%--------------------------------------------------------------------------
gap_cal=[15.5 18 20 22.5 25 27.5 30 35 40 50 60 70 80 90 100 110 130 150 175 200 225 240];
[structureAllFileNames, res] = idMeasCorEfficForAllGaps('HU42_HERMES', '', 10, gap_cal, 1);
% script de Fabien pour generer la sequence à introduire dans 'idReadCorElecBeamMeasData' file
idAuxFormatElecBeamMeasDataAfterEfficiency(structureAllFileNames, 0)
st_sum_hu42 = load('/home/data/GMI/HU42_HERMES/cod_P_summary_2011-01-24_10-35-01.mat');
paramsR = st_sum_hu42.params;
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU42_HERMES', {{'phase', st_sum_hu42.params{1}{2}}, {'gap', st_sum_hu42.params{2}{2}}}, st_sum_hu42.filenames_meas_bkg, '', '', -1)
[mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa] = idAuxMergeFeedForwardCorTablesWithArgForAppleII(mCHE, mCVE, mCHS, mCVS, paramsR);
for i = 1:33 vPhasesD(i) = -21 + (i - 1)*(42/32); end
[new_mCHE_wa, new_mCVE_wa, new_mCHS_wa, new_mCVS_wa] = idInterpolFeedForwardCorTables2D(mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa, paramsR{2}{2}, vPhasesD, 'linear')
save('/usr/Local/configFiles/InsertionFFTables/ANS-C10-HU42/FF_PARALLEL_CHE_TABLE.txt','new_mCHE_wa','-ascii');
save('/usr/Local/configFiles/InsertionFFTables/ANS-C10-HU42/FF_PARALLEL_CVE_TABLE.txt','new_mCVE_wa','-ascii');
save('/usr/Local/configFiles/InsertionFFTables/ANS-C10-HU42/FF_PARALLEL_CVS_TABLE.txt','new_mCVS_wa','-ascii');
save('/usr/Local/configFiles/InsertionFFTables/ANS-C10-HU42/FF_PARALLEL_CHS_TABLE.txt','new_mCHS_wa','-ascii');
st_sum_hu42X = load('/home/data/GMI/HU42_HERMES/cod_X_summary_2011-01-24_14-23-32.mat');
paramsR = st_sum_hu42X.params;
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU42_HERMES', {{'phase', st_sum_hu42X.params{1}{2}}, {'gap', st_sum_hu42X.params{2}{2}}}, st_sum_hu42X.filenames_meas_bkg, '', '', -1)
[mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa] = idAuxMergeFeedForwardCorTablesWithArgForAppleII(mCHE, mCVE, mCHS, mCVS, paramsR);
for i = 1:33 vPhasesD(i) = -21 + (i - 1)*(42/32); end
[new_mCHE_wa, new_mCVE_wa, new_mCHS_wa, new_mCVS_wa] = idInterpolFeedForwardCorTables2D(mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa, paramsR{2}{2}, vPhasesD, 'linear')
save('/usr/Local/configFiles/InsertionFFTables/ANS-C10-HU42/FF_PARALLEL_CHE_TABLE.txt','new_mCHE_wa','-ascii');
save('/usr/Local/configFiles/InsertionFFTables/ANS-C10-HU42/FF_PARALLEL_CVE_TABLE.txt','new_mCVE_wa','-ascii');
save('/usr/Local/configFiles/InsertionFFTables/ANS-C10-HU42/FF_PARALLEL_CVS_TABLE.txt','new_mCVS_wa','-ascii');
save('/usr/Local/configFiles/InsertionFFTables/ANS-C10-HU42/FF_PARALLEL_CHS_TABLE.txt','new_mCHS_wa','-ascii');
% session hu44 sextant du 09/03/2014
[structureAllFileNames, res] = idMeasCorEfficForAllGaps('HU44_SEXTANTS', '', 10, gap_cal, 1);
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU44_SEXTANTS', {{'phase',[-22.:2.75:22.] , 0.01}, {'gap', [15.5, 16, 18, 20, 22.5, 25, 27.5, 30, 35, 40, 50, 60, 70, 80, 90, 100, 110, 130, 150, 175, 200, 225, 239], 0.01}}, {{'phase', 0, 0.01}, {'gap', 240, 0.01}}, 0, 'cod_P', 1);





