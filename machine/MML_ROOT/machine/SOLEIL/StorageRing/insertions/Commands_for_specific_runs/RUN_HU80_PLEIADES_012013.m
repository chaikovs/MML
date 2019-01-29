%RUN HU80 PLEIADES :

%REGLAGES :
    %18 mA en ¾.
    %Désactiver SOFB, FOFB et TOP-UP.
    %Apple II à gap 240mm, sous-vide à gap 30mm et électro éteints.
    %Mettre l onduleur sur ON, vitesse 4mm/s en gap et 1mm/s en phase.
    %Mettre le FFWD sur OFF et passer tous les correcteurs à 0A.
     SOLEIL_Init();
     UpdateOptics(0);
     getx();getx();

%CALIBRATION DES CORRECTEURS (8 minutes par gap)
     UndName='HU80_PLEIADES';%;                          Nom de l'onduleur
     Prefix='';%;                                        Préfixe à ajouter aux orbites (facultatif)
     maxAbsCorCur=10%;                                  Courant  max des correcteurs virtuels  
     vGaps=[15.5,16:2:26,30,35,40:10:100,120,150,240]%; Vecteur de gaps (19 gaps => 2h30)
     %vGaps=[15.5,240]%; Vecteur de gaps (19 gaps => 2h30)
     [resFiles, resErr]=idMeasCorEfficForAllGaps(UndName, Prefix, maxAbsCorCur, vGaps, 1);  
     CalibFileNames = strcat('/home/operateur/GrpGMI/',UndName,'/','Efficiency_HU80_PLEIADES_FileNames_2013-01-25_10-00-59','.mat');
     SumFiles = load(CalibFileNames);
     idAuxFormatElecBeamMeasDataAfterEfficiency(SumFiles, 1);
    %Le morceau de script est directement mis dans le presse-papier.
    %faire un backup de la fonction idReadCorElecBeamMeasData.
    %coller le morceau de script dans la fonction idReadCorElecBeamMeasData.

%TABLES DE FFWD EN MODE II
    %Passer en mode 0 dans le DS.
    %Mettre à gap 240mm et phase 0mm
    %vPhases=[-40.2,-36:2:-22,-20.1,-18:2:18,20.1,22:2:36,40.2];%        Vecteur de phases
    %vPhases=[-40.2,-24,0,24,40.2];
    %vPhases=[-40.2,-38:2:-22,-20.1,-18:2:18,20.1,22:2:38,40.2]
    %vPhases=[-40.2,-36:4:-24,-20.1,-16:4:16,20.1,24:4:36,40.2]
    phaseBkg=0;%                                                        Phase pour le background
    gapBkg=240;%                                                        Gap pour le background
    Prefix='COD_II';%                                                   Préfixe à ajouter aux orbites
    Par={{'phase', vPhases, 0.01}, {'gap', vGaps, 0.01}};%            Paramètres des mesures
    ParBkg={{'phase', phaseBkg, 0.01}, {'gap', gapBkg, 0.01}};%         Paramètres du background
    %Si tables corrigent bien
    UpdateOfCOD=1;%                                                     Mettre 1 si MAJ, 0 sinon
    %Si tables corrigent mal
    UpdateOfCOD=0;%                                                     Mettre 1 si MAJ, 0 sinon
    [resFiles, resErr]=idMeasElecBeamVsUndParam(UndName, Par, ParBkg, UpdateOfCOD, Prefix, 1);

    
    %Und_ModeName = 'II'
    %Und_MeasName = strcat('CODs_',Und_ModeName);        % 5 minutes par phase
    %Und_FileName = strcat('/home/operateur/GrpGMI/',UndName);
    %[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables(Und_Name, {{'phase', Und_phase}, {'gap', Und_gap}}, resFiles.filenames_meas_bkg, '', '', -1)
    %Prendre le nom du fichier summary
    %CalcFFWDTables(Und_Name,Und_FileName,'CODs_II1_summary_2012-11-02_21-23-50',Und_MeasName,1)
    
    
    MeasDirectory = strcat('/home/operateur/GrpGMI/',UndName);%        Répertoire des mesures
    SumCODsFiles = strcat('COD_II_summary_2013-01-25_11-36-02','.mat');
    %SumStruct= strcat(Prefix ,' _summary_2013-01-25_hh-mm-ss.mat');%	Structure des défauts
    Suffix='II_1';%                              						Suffixe à ajouter
    CalcFFWDTables(UndName, MeasDirectory, SumCODsFiles, Suffix, 1);

%TABLES DE FFWD EN MODE X
    %Passer en mode 1 dans le DS.
    Prefix='COD_X';%						Préfixe à ajouter aux orbites
     %Si tables corrigent bien
    UpdateOfCOD=1;%                                                     Mettre 1 si MAJ, 0 sinon
    %Si tables corrigent mal
    UpdateOfCOD=0;%                                                     Mettre 1 si MAJ, 0 sinon
    [resFiles, resErr]=idMeasElecBeamVsUndParam(UndName, Par, ParBkg, UpdateOfCOD, Prefix, 1);

    SumStruct= strcat(Prefix ,' _summary_2013-01-25_hh-mm-ss.mat');%	Structure des défauts
    Suffix='X_1';%                               						Suffixe à ajouter
    CalcFFWDTables(UndName, MeasDirectory, SumStruct, Suffix, 1);


%BUMPS
GapMeas = 15.5
PhaseMeas = 0
Mode = 0
ResultFileName = 'G155_P0_II'
idCalcIntegralsVsBumpForApple2_WithLastUpdate(UndName, -16, 1, 14, GapMeas, gapBkg, PhaseMeas, Mode, 1, 7, 0, 1, ResultFileName)



Table_1 = load('/home/operateur/GrpGMI/HU80_PLEIADES/FFWD_CVE_X_1.txt');
newCVE = idAuxInterpolTable2D(CVE, [15.5,16:2:26,30,35,40:10:100,120,150,240], [-40.2,-38:2:-22,-20.1,-18:2:18,20.1,22:2:38,40.2], 'spline');
Table_2 = load('/usr/Local/configFiles/InsertionFFTables/ANS-C04-HU80/Tables_T4/FF_ANTIPARALLEL_CVE_TABLE.txt');



% vphase=[-40:4:40];
% vgap=[15.5,16,18,20,22,24,26,28,30,35,40,50,60,80,90,100,110,130,150,175,200,225,239];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % PETIT FAISCEAU INFERIEUR À 20 mA
% % DESACTIVER LE SOFB ET FOFB
% % SELECTIONNER LE MODE: ANTIPARALLELE OU PARALLELE 
% % METTRE TOUS LES CORRECTEURS DE L'INSERTION À 0 A
% % TAPER 'GETX' POUR ACTIVER LES LIBERA
% % DESACTIVER LE FFWD DANS LE DEVICE SERVEUR
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % MODE PARALLELE: MODE 0
% [resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_PLEIADES', {{'phase', [-40:4:40], 0.01}, {'gap', [15.5,16,18,20,22,24,26,28,30,35,40,50,60,70,80,90,100,110,130,150,175,200,225,239], 0.01}}, {{'gap', 240, 0.01}, {'phase', 0, 0.01}}, 1, 0, 'cod_HU80_PLEIADES_PARA', 1)
% [mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU80_PLEIADES', {{'phase', [-40:4:40]}, {'gap', [15.5,16,18,20,22,24,26,28,30,35,40,50,60,70,80,90,100,110,130,150,175,200,225,239]}}, resFiles.filenames_meas_bkg, '', '', -1)
% 
% % MODE ANTIPARALLELE: MODE 1
% [resFiles, resErr] = idMeasElecBeamVsUndParam('HU80_PLEIADES', {{'phase', [-40:4:40], 0.01}, {'gap', [15.5,16,18,20,22,24,26,28,30,35,40,50,60,70,80,90,100,110,130,150,175,200,225,239], 0.01}}, {{'gap', 240, 0.01}, {'phase', 0, 0.01}}, 1, 0, 'cod_HU80_PLEIADES_ANTI', 1)
% [mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU80_PLEIADES', {{'phase', [-40:4:40]}, {'gap', [15.5,16,18,20,22,24,26,28,30,35,40,50,60,70,80,90,100,110,130,150,175,200,225,239]}}, resFiles.filenames_meas_bkg, '', '', -1)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ON NE CONSERVE QUE LES VALEURS COHERENTES (LES 20 PREMIÈRES COLONNES DE
% % GAP ET LES 17 PREMIÈRES DE PHASE) ET ON AJOUTE UNE LIGNE DE ZEROS
% mCHEr = idAuxMatrResizeExt(mCHE, 20, 17, 1, 1); mCHEr = idAuxMatrResizeExt(mCHEr, 21, 17, 1, 1);
% mCHSr = idAuxMatrResizeExt(mCHS, 20, 17, 1, 1); mCHSr = idAuxMatrResizeExt(mCHSr, 21, 17, 1, 1);
% mCVEr = idAuxMatrResizeExt(mCVE, 20, 17, 1, 1); mCVEr = idAuxMatrResizeExt(mCVEr, 21, 17, 1, 1);
% mCVSr = idAuxMatrResizeExt(mCVS, 20, 17, 1, 1); mCVSr = idAuxMatrResizeExt(mCVSr, 21, 17, 1, 1);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % AJOUTE LA LIGNE DES PHASES ET LA COLONNE DES ENTREFER
% [mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa] = idAuxMergeFeedForwardCorTablesWithArgForAppleII(mCHE, mCVE, mCHS, mCVS, resFiles.params)
% % FAIRE UN COPIER/COLLER DE CHACUNE DES 4 MATRICES DANS LE FIHIER DES 4
% % TABLES UTILISÉES PAR LE DEVICE SERVEUR DANS:
% % /usr/Local/configFiles/InsertionFFTables/ANS-C04-HU80
% % FF_ANTIPARALLELE_CHE_TABLE, ...
