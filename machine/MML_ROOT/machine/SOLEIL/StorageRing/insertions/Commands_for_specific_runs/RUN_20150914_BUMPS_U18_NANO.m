function RUN_HU80_MICROFOC_BUMP()
% AFFICHAGE DE LA FREQUENCE RF
format long
getrf
% ENREGISTREMENT DE LA VALEUR DES CORRECTEURS DE LA MACHINE
hcor=getam('HCOR')
% VALEURS DES CORRECTEURS MACINE À LEUR ANCIENNE VALEUR
setsp('HCOR',hcor)
% AFFICHAGE DES NOMBRES D'ONDE
gettune

% Correction d'orbite
% GENERATION DU BUMP DE POSITION EN X
ID_RegisterBumpParmeters_MV(0,'/home/operateur/GrpGMI/U18_NANO/SESSION_20150914',13,9,2,1,1,'H',0,0,8,'Orbit','OrigH')
setsp('HCOR',hcor)
% Correction d'orbite
% BUMPS POSITION X DE -0.5 mm
ID_RegisterBumpParmeters_MV(1,'/home/operateur/GrpGMI/U18_NANO/SESSION_20150914',13,9,2,1,1,'H',-0.5,-0.5,8,'Hpos','m05mm')
setsp('HCOR',hcor)
% Correction d'orbite

vcor=getam('VCOR')
% Correction d'orbite
% GENERATION DU BUMP DE POSITION EN Z
ID_RegisterBumpParmeters_MV(0,'/home/operateur/GrpGMI/U18_NANO/SESSION_20151019',13,9,2,1,1,'V',0.025,0.025,8,'Vpos','OrigV')
ID_RegisterBumpParmeters_MV(1,'/home/operateur/GrpGMI/U18_NANO/SESSION_20151019',13,9,2,1,1,'V',0,0,8,'Vpos','OrigV')

ID_RegisterBumpParmeters_MV(1,'/home/operateur/GrpGMI/U18_NANO/SESSION_20150914',13,9,2,1,1,'V',0,0,8,'Vpos','OrigV')
setsp('HCOR',hcor)
% Correction d'orbite
% BUMPS POSITION X DE -0.5 mm
ID_RegisterBumpParmeters_MV(1,'/home/operateur/GrpGMI/U18_NANO/SESSION_20150914',13,9,2,1,1,'V',-0.1,-0.1,8,'Vpos','m01mm')
setsp('HCOR',hcor)
% Correction d'orbite

end
