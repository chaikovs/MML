function HU640_Bump(SESSION,PS1MinCur,PS1MaxCur,PS1StepCur,Xmin,Xmax,XStep)
% PS1MinCur,PS1MaxCur,PS1StepCur: minimum curent of PS1, maximum current of PS1, step of current PS1
% Xmin: minimum bump
% Xmax: maximum bump
% XStep: step of bump 
% Example: HU640_Bump('SESSION_04_04_11',-600,600,200,-15,15,1)
getx
idDevServPS1=['ANS-C05/EI/L-HU640/currentPS1'];
Path=['/home/data/GrpGMI/HU640/' SESSION];
CellName='ANS-C05';
CellNumber=str2num(CellName(6:7));
BPMEntrance=1;
BPMExit=2;
Xin=readattribute([CellName '/DG/BPM.' Num2Str(BPMEntrance) '/XPosSA']);
Zin=readattribute([CellName '/DG/BPM.' Num2Str(BPMEntrance) '/ZPosSA']);
Xout=readattribute([CellName '/DG/BPM.' Num2Str(BPMExit) '/XPosSA']);
Zout=readattribute([CellName '/DG/BPM.' Num2Str(BPMExit) '/ZPosSA']);
% CANCEL THE ORBIT IN THE STRAIGHT SECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('%s\n', 'AVANT ANNULATION D''ORBITE')
fprintf('%s\t %s\t %s\t %s\n', 'X entrée','Z entrée','X sortie','Z sortie')
fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\n',Xin,Zin,Xout,Zout)

%setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],-1*[Xin;Xout],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');

pause(2);
Xin=readattribute([CellName '/DG/BPM.' Num2Str(BPMEntrance) '/XPosSA']);
Zin=readattribute([CellName '/DG/BPM.' Num2Str(BPMEntrance) '/ZPosSA']);
Xout=readattribute([CellName '/DG/BPM.' Num2Str(BPMExit) '/XPosSA']);
Zout=readattribute([CellName '/DG/BPM.' Num2Str(BPMExit) '/ZPosSA']);
fprintf('%s\n', 'APRES ANNULATION D''ORBITE')
fprintf('%s\t %s\t %s\t %s\n', 'X entrée','Z entrée','X sortie','Z sortie')
fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\n',Xin,Zin,Xout,Zout)
for X=0:-XStep:Xmin+XStep
    
    setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],-XStep*[1;1],'HCOR',[-7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7],'FitRF');
    
    pause(10)
end
% pause(40);
fprintf('%s\t %s\t %s\t %s\n','X [mm]  ','PS1 [A]  ','NuX    ','NuZ    ')
for X=Xmin:XStep:Xmax
    fprintf('%s\n','********************************************************************************************************')
    for PS1=PS1MaxCur:-PS1StepCur:PS1MinCur
        
        writeattribute(idDevServPS1,PS1);

        pause(20);
        Tune=gettune;
        fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\n',X,PS1,Tune(1),Tune(2))
        saveBumpOrbit(SESSION,X,PS1)
        pause(2)
    end   
    fprintf('%s\n','********************************************************************************************************')

        writeattribute(idDevServPS1,PS1MaxCur);
    
    pause(30);

    setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],-XStep*[1;1],'HCOR',[-7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7],'FitRF');

    pause(2)
end

writeattribute(idDevServPS1,0);

for X=Xmax:-XStep:0

    setorbitbump('BPMx',[CellNumber BPMEntrance;CellNumber BPMExit],-XStep*[1;1],'HCOR',[-7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7],'FitRF');
    
    pause(10)
end
