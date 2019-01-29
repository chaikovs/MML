%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PETIT FAISCEAU INFERIEUR À 20 mA
% DESACTIVER LE SOFB ET FOFB
% CORRECTION D'ORBITE
% SOLEILINIT
% ONDULEUR SUR ON
% SELECTIONNER LE MODE: PARALLELE (pas automatique)
% METTRE TOUS LES CORRECTEURS DE L'INSERTION À 0 A
% DESACTIVER LE FFWD DANS LE DEVICE SERVEUR
% FIXER LA VITESSE DE GAP A 4mm/s ET DE PHASE A 1mm/s
% TAPER 'GETX' POUR ACTIVER LES LIBERA (2 fois)
% LANCER LE TREND SAUVEGARDE DANS GMI/HU80_SEXTANTS/SESSION_18_04_2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 20 VALEURS DE PHASES : 
    vphase=[-40:4:40];
% 21 VALEURS DE GAP : 
    vgap=[15.5,16,18,20,22,24,26,28,30,35,40,50,60,80,100,125,150,175,200,239]; 
% MODE PARALLELE: MODE 0
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_SEXTANTS',{{'phase',vphase, 0.01}, {'gap',vgap, 0.01}}, {{'gap', 240, 0.01}, {'phase', 0, 0.01}}, 1, 0, 'cod_PARA_SsCor', 1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REDIGER ELOG
