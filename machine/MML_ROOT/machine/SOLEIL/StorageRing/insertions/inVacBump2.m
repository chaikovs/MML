function InVacBump(IdName,BLName,SESSION,CellName,SSType,BPMEntrance,BPMExit, IdGap, IdGapBckg,Xmin,Xmax,XStep)

% The function generates bumps in the ID at Open gap and afterward at nominal gap
% specified by the users.

% IdName: name of the ID: ex: 'WSV50'
% SESSION: Name of the folder wher the bumps will be stored
% CellName: Name of the cell: 'ANS-C03'
% SSType: Type of straight section: 'L', 'M' or 'C'
% BPMEntrance: Number of the Entrance BPM:  5
% BPMExit: Number of the Exit BPM: 6
% IdGap: gap of the ID
% IdGapBckg: Background gap
% Xmin, Xmax: min value and max value of the horizontal bump
% XStep: Step between X values
% Example: InVacBump('WSV50','PSICHE','SESSION_test','ANS-C03','C',5,6,5.5, 70,-22,10,1)

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
fprintf('%s\t %s\t %s\t %s\n','Gap [mm]','Bump [mm]','NuX','NuZ')
for X=0:-XStep:Xmin+XStep
    setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],-XStep*[1;1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    pause(2)
end
for X=Xmin:XStep:Xmax-XStep
    Orbit=idMeasElecBeamUnd(IdName, 0, [Path '/BUMP_' Num2Str(X) 'mm_G' Num2Str(10*IdGapBckg)], 0, 0);
    pause(2)
    TuneBckgGap=gettune;
    pause(2)
    fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\n',IdGapBckg,X,TuneBckgGap(1),TuneBckgGap(2));
    setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],XStep*[1;1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
end
writeattribute(idDevServGap,IdGap);
pause(120)
for X=Xmax:-XStep:Xmin+XStep
    setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],-XStep*[1;1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    pause(2)
end
for X=Xmin:XStep:Xmax-XStep
    Orbit=idMeasElecBeamUnd(IdName, 0, [Path '/BUMP_' Num2Str(X) 'mm_G' Num2Str(10*IdGap)], 0, 0);
    pause(2)
    TuneGap=gettune;
    pause(2)
    fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\n',IdGap,X,TuneGap(1),TuneGap(2));
    pause(2)
    setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],XStep*[1;1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
end
for X=Xmax:-XStep:XStep
    setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],-XStep*[1;1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    pause(2)
end
writeattribute(idDevServGap,IdGapBckg);
pause(120)
end