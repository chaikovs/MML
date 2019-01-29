function IdCorCalibInVac(UndName,DeviceServerName,CurMin,CurMax,CurStep)
% UndName: Full name of the undulator: for example 'U24_PROXIMA2'
% DeviceServerName: Full path of the DeviceServer name: for example 'ANS-C11/EI/M-U24'
% CurMin, CurMax, CurStep: Minimum, maximum Current and current step of each Corrector
% Example: IdCorCalibInVac('U24_PROXIMA2','ANS-C11/EI/M-U24',-6,6,2)
%          IdCorCalibInVac('U20_GALAXIES','ANS-C07/EI/C-U20',-6,6,2)
%          IdCorCalibInVac('WSV50_PSICHE','ANS-C03/EI/C-WSV50',-6,6,2)
%          IdCorCalibInVac('U20_NANO','ANS-C13/EI/L-U20.2',-6,6,2)
%          IdCorCalibInVac('U18_TOMO','ANS-C13/EI/L-U18.1',-6,6,2)
%          IdCorCalibInVac('W164_PUMA_SLICING','ANS-C06/EI/M-W164',-6,6,2)

t0=15;
CellName=DeviceServerName(1:7)
SSType=DeviceServerName(11:11)
Position_SourceX=[CellName '/DG/CALC-SD' SSType '-POSITION-ANGLE/positionX'];
Position_SourceZ=[CellName '/DG/CALC-SD' SSType '-POSITION-ANGLE/positionZ'];
Date=datestr(clock,'mmm-dd-yyyy HH:MM:SS')
CalibrationFolder=['/home/data/GMI/' UndName '/CALIBRATION-' Date]
mkdir(CalibrationFolder)
idDevServCHEAttr=[DeviceServerName '_CHAN1']
idDevServCVEAttr=[DeviceServerName '_CHAN2']
idDevServCHSAttr=[DeviceServerName '_CHAN3']
idDevServCVSAttr=[DeviceServerName '_CHAN4']
i=1;
for Cur=CurMin:CurStep:CurMax
    idSetCurrentSync(idDevServCHEAttr, Cur, 0.01);
    pause(t0)
    stMeas=idMeasElecBeamUnd(UndName,0,['/home/data/GMI/' UndName '/' UndName '_CHE_' num2str(Cur)],0,0)
    copyfile(['/home/data/GMI/' UndName '/' UndName '_CHE_' num2str(Cur) '.mat'],[CalibrationFolder '/' UndName '_CHE_' num2str(Cur) '.mat'])
    fprintf ('%8.4f\n',Cur)
end
idSetCurrentSync(idDevServCHEAttr, 0, 0.01);
pause(t0)
for Cur=CurMin:CurStep:CurMax
    idSetCurrentSync(idDevServCHSAttr, Cur, 0.01);
    pause(t0)
    stMeas=idMeasElecBeamUnd(UndName,0,['/home/data/GMI/' UndName '/' UndName '_CHS_' num2str(Cur)],0,0)
    copyfile(['/home/data/GMI/' UndName '/' UndName '_CHS_' num2str(Cur) '.mat'],[CalibrationFolder '/' UndName '_CHS_' num2str(Cur) '.mat'])
    fprintf ('%8.4f\n',Cur)
end
idSetCurrentSync(idDevServCHSAttr, 0, 0.01);
pause(t0)
for Cur=CurMin:CurStep:CurMax
    idSetCurrentSync(idDevServCVEAttr, Cur, 0.01);
    pause(t0)
    stMeas=idMeasElecBeamUnd(UndName,0,['/home/data/GMI/' UndName '/' UndName '_CVE_' num2str(Cur)],0,0)
    copyfile(['/home/data/GMI/' UndName '/' UndName '_CVE_' num2str(Cur) '.mat'],[CalibrationFolder '/' UndName '_CVE_' num2str(Cur) '.mat'])
    fprintf ('%8.4f\n',Cur)
end
idSetCurrentSync(idDevServCVEAttr, 0, 0.01);
pause(t0)
for Cur=CurMin:CurStep:CurMax
    idSetCurrentSync(idDevServCVSAttr, Cur, 0.01);
    pause(t0)
    stMeas=idMeasElecBeamUnd(UndName,0,['/home/data/GMI/' UndName '/' UndName '_CVS_' num2str(Cur)],0,0)
    copyfile(['/home/data/GMI/' UndName '/' UndName '_CVS_' num2str(Cur) '.mat'],[CalibrationFolder '/' UndName '_CVS_' num2str(Cur) '.mat'])    
    fprintf ('%8.4f\n',Cur)
end
idSetCurrentSync(idDevServCVSAttr, 0, 0.01);
pause(t0)
end