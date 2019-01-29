function InVacBump(IdName,BLName,SESSION,CellName,SSType,BPMEntrance,BPMExit, IdGap, IdGapBckg,Xmin,Xmax,XStep)
% IdName: name of the ID: ex: 'WSV50'
% SESSION: Name of the folder wher the bumps will be stored
% CellName: Name of the cell: 'ANS-C03'
% SSType: Tyep of straight section: 'L', 'M' or 'C'
% BPMEntrance: Number of the Entrance BPM:  5
% BPMExit: Number of the Exit BPM: 6
% IdGap: gap of the ID
% IdGapBckg: Background gap
% Xmin, Xmax: min value and max value of the horizontal bump
% XStep: Step between X values
% Example: InVacBump('WSV50','PSICHE','SESSION_test','ANS-C03','C',5,6, 5.5, 70,-22,10,1)
getx
CellNumber=str2num(CellName(6:7));
idDevServGap=[CellName '/ei/' SSType '-' IdName '/gap'];
Path=['/home/data/GMI/' IdName '_' BLName '/' SESSION];
fid= fopen([Path '/BUMP_TUNES_NomGap' Num2Str(10*IdGap) '_BckgGap' Num2Str(10*IdGapBckg) '.txt'], 'w');
Xin=readattribute([CellName '/DG/BPM.' Num2Str(BPMEntrance) '/XPosSA']);
Zin=readattribute([CellName '/DG/BPM.' Num2Str(BPMEntrance) '/ZPosSA']);
Xout=readattribute([CellName '/DG/BPM.' Num2Str(BPMExit) '/XPosSA']);
Zout=readattribute([CellName '/DG/BPM.' Num2Str(BPMExit) '/ZPosSA']);
% CANCEL THE ORBIT IN THE STRAIGHT SECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],-1*[Xin;Xout],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
%setorbitbump('BPMz',[CellNumber BPMEntrance;CellNumber BPMExit],-1*[Zin;Zout],'VCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8]);
% GO TO THE MINIMUM BUMP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for X=0:-1:Xmin+1
setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],-1*[1;1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
pause(2)
end

fprintf ('%s\n','----------------------------------------------')
fprintf ('%s\n','Bump[mm]         NuX at Nom. gap         NuZ at Nom. gap        NuX at Bckg gap         NuZ at Bckg. gap')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for X=Xmin:2*XStep:Xmax
Orbit=idMeasElecBeamUnd(IdName, 0, [Path '/BUMP_' Num2Str(X) 'mm_G' Num2Str(10*IdGapBckg)], 0, 0);
pause(2)
TuneBckgGap=gettune;
pause(2)
writeattribute(idDevServGap,IdGap);
pause(120)
Orbit=idMeasElecBeamUnd(IdName, 0, [Path '/BUMP_' Num2Str(X) 'mm_G' Num2Str(10*IdGap)], 0, 0);
pause(2)
TuneGap=gettune;
pause(2)
fprintf (fid,'%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n',X,TuneGap(1),TuneGap(2),TuneBckgGap(1),TuneBckgGap(2));
fprintf ('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n',X,TuneGap(1),TuneGap(2),TuneBckgGap(1),TuneBckgGap(2));
setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],XStep*[1;1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
pause(2)
Orbit=idMeasElecBeamUnd(IdName, 0, [Path '/BUMP_' Num2Str(X+XStep) 'mm_G' Num2Str(10*IdGap)], 0, 0);
pause(2)
TuneGap=gettune;
pause(2)
writeattribute(idDevServGap,IdGapBckg);
pause(120)
Orbit=idMeasElecBeamUnd(IdName, 0, [Path '/BUMP_' Num2Str(X+XStep) 'mm_G' Num2Str(10*IdGapBckg)], 0, 0);
pause(2)
TuneBckgGap=gettune;
pause(2)
fprintf (fid,'%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n',X+XStep,TuneGap(1),TuneGap(2),TuneBckgGap(1),TuneBckgGap(2));
fprintf ('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n',X+XStep,TuneGap(1),TuneGap(2),TuneBckgGap(1),TuneBckgGap(2));
setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],XStep*[1;1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
pause(2)
end

for X=Xmax:-XStep:0
setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],-1*[1;1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');

pause(2)
end    