%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TABLES DE FF DE PS1 APRES INTERVENTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PowerSupplyCycleAndBuildTables_3('SESSION_14_03_10','PS1',600,0,5,2)
PowerSupplyCycleAndBuildTables_3('SESSION_14_03_10','PS1',600,0,5,2)
PowerSupplyCycleAndBuildTables_3('SESSION_14_03_10','PS1',600,0,20,2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Annulation des valeurs sur les BPM adjacents HU640: [5 1] et [5 2] 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calibration des Déplacements BPMs par A de correcteur HCOR de [5 2;5 1]
setorbitbump('BPMx',[5 1;5 2],-1*[1;1],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF')
% Relevé de la valeur exacte sur BPMx [5 1] et [5 2]
setorbitbump('BPMx',[5 1;5 2],-1*[1;1],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF')
setorbitbump('BPMx',[5 1;5 2],-1*[1;1],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF')
setorbitbump('BPMx',[5 1;5 2],-1*[1;1],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BUMP A -3 mm
setorbitbump('BPMx',[5 1;5 2],1*[1;1],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF')
% Aller à +600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-3,600)
% Aller à +300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-3,300)
% Aller à 0 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-3,0)
% Aller à -300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-3,-300)
% Aller à -600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-3,-600)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BUMP A -2 mm
setorbitbump('BPMx',[5 1;5 2],1*[1;1],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF')
% Aller à +600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-2,600)
% Aller à +300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-2,300)
% Aller à 0 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-2,0)
% Aller à -300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-2,-300)
% Aller à -600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-2,-600)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BUMP A -1 mm
setorbitbump('BPMx',[5 1;5 2],1*[1;1],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF')
% Aller à +600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-1,600)
% Aller à +300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-1,300)
% Aller à 0 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-1,0)
% Aller à -300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-1,-300)
% Aller à -600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',-1,-600)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BUMP A 0 mm
setorbitbump('BPMx',[5 1;5 2],1*[1;1],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF')
% Aller à +600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',0,600)
% Aller à +300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',0,300)
% Aller à 0 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',0,0)
% Aller à -300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',0,-300)
% Aller à -600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',0,-600)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BUMP A 1 mm
setorbitbump('BPMx',[5 1;5 2],1*[1;1],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF')
% Aller à +600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',1,600)
% Aller à +300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',1,300)
% Aller à 0 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',1,0)
% Aller à -300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',1,-300)
% Aller à -600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',1,-600)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BUMP A 2 mm
setorbitbump('BPMx',[5 1;5 2],1*[1;1],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF')
% Aller à +600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',2,600)
% Aller à +300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',2,300)
% Aller à 0 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',2,0)
% Aller à -300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',2,-300)
% Aller à -600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',2,-600)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BUMP A 3 mm
setorbitbump('BPMx',[5 1;5 2],1*[1;1],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF')
% Aller à +600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',3,600)
% Aller à +300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',3,300)
% Aller à 0 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',3,-300)
% Aller à -300 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',3,-300)
% Aller à -600 A avec le DS2
saveBumpOrbit('SESSION_14_03_10',3,-600)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PS1_Toutes_Integrales('SESSION_14_03_10',-3,3,1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PowerSupplyCycleAndBuildTables_3('SESSION_14_03_10','PS2',440,0,5,2)
PowerSupplyCycleAndBuildTables_3('SESSION_14_03_10','PS2',440,0,5,2)
PowerSupplyCycleAndBuildTables_3('SESSION_14_03_10','PS2',440,0,20,3)

PowerSupplyCycleAndBuildTables_3('SESSION_14_03_10','PS3',360,0,5,2)
PowerSupplyCycleAndBuildTables_3('SESSION_14_03_10','PS3',360,0,5,2)
PowerSupplyCycleAndBuildTables_3('SESSION_14_03_10','PS3',360,0,20,2)
