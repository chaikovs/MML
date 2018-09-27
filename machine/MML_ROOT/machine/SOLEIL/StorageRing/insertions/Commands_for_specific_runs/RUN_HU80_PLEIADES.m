vphase=[-40:4:40];
vgap=[15.5,16,18,20,22,24,26,28,30,35,40,50,60,80,90,100,110,130,150,175,200,225,239];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PETIT FAISCEAU INFERIEUR À 20 mA
% DESACTIVER LE SOFB ET FOFB
% SELECTIONNER LE MODE: ANTIPARALLELE OU PARALLELE 
% METTRE TOUS LES CORRECTEURS DE L'INSERTION À 0 A
% TAPER 'GETX' POUR ACTIVER LES LIBERA
% DESACTIVER LE FFWD DANS LE DEVICE SERVEUR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODE PARALLELE: MODE 0
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_PLEIADES', {{'phase', [-40:4:40], 0.01}, {'gap', [15.5,16,18,20,22,24,26,28,30,35,40,50,60,70,80,90,100,110,130,150,175,200,225,239], 0.01}}, {{'gap', 240, 0.01}, {'phase', 0, 0.01}}, 1, 0, 'cod_HU80_PLEIADES_PARA', 1)
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU80_PLEIADES', {{'phase', [-40:4:40]}, {'gap', [15.5,16,18,20,22,24,26,28,30,35,40,50,60,70,80,90,100,110,130,150,175,200,225,239]}}, resFiles.filenames_meas_bkg, '', '', -1)

% MODE ANTIPARALLELE: MODE 1
[resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_PLEIADES', {{'phase', [-40:4:40], 0.01}, {'gap', [15.5,16,18,20,22,24,26,28,30,35,40,50,60,70,80,90,100,110,130,150,175,200,225,239], 0.01}}, {{'gap', 240, 0.01}, {'phase', 0, 0.01}}, 1, 0, 'cod_HU80_PLEIADES_ANTI', 1)
[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU80_PLEIADES', {{'phase', [-40:4:40]}, {'gap', [15.5,16,18,20,22,24,26,28,30,35,40,50,60,70,80,90,100,110,130,150,175,200,225,239]}}, resFiles.filenames_meas_bkg, '', '', -1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ON NE CONSERVE QUE LES VALEURS COHERENTES (LES 20 PREMIÈRES COLONNES DE
% GAP ET LES 17 PREMIÈRES DE PHASE) ET ON AJOUTE UNE LIGNE DE ZEROS
mCHEr = idAuxMatrResizeExt(mCHE, 20, 17, 1, 1); mCHEr = idAuxMatrResizeExt(mCHEr, 21, 17, 1, 1);
mCHSr = idAuxMatrResizeExt(mCHS, 20, 17, 1, 1); mCHSr = idAuxMatrResizeExt(mCHSr, 21, 17, 1, 1);
mCVEr = idAuxMatrResizeExt(mCVE, 20, 17, 1, 1); mCVEr = idAuxMatrResizeExt(mCVEr, 21, 17, 1, 1);
mCVSr = idAuxMatrResizeExt(mCVS, 20, 17, 1, 1); mCVSr = idAuxMatrResizeExt(mCVSr, 21, 17, 1, 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AJOUTE LA LIGNE DES PHASES ET LA COLONNE DES ENTREFER
[mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa] = idAuxMergeFeedForwardCorTablesWithArgForAppleII(mCHE, mCVE, mCHS, mCVS, resFiles.params)
% FAIRE UN COPIER/COLLER DE CHACUNE DES 4 MATRICES DANS LE FIHIER DES 4
% TABLES UTILISÉES PAR LE DEVICE SERVEUR DANS:
% /usr/Local/configFiles/InsertionFFTables/ANS-C04-HU80
% FF_ANTIPARALLELE_CHE_TABLE, ...
