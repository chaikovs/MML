%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%PARAMETRES
    % PETIT FAISCEAU INFERIEUR À 20 mA en 1/4
    % DESACTIVER LE SOFB ET FOFB ET TOP UP
    % ONDULEURS OUVERTS OU ETEINTS

    % SOLEIL
        SOLEIL_Init();
        UpdateOptics(0);
        getx();getx();% TAPER 'GETX' POUR ACTIVER LES LIBERA (2 fois)
    
    % ONDULEUR SUR ON
    % DESACTIVER LE FFWD DANS LE DEVICE SERVEUR
    % METTRE TOUS LES CORRECTEURS DE L'INSERTION À 0 A
    % REGLER LA VITESSE DE GAP A 4mm/s ET PHASE A 1mm/s 
        Und_Name = 'HU80_SEXTANTS';
        Und_FileName = strcat('/home/operateur/GrpGMI/',Und_Name);
        Und_phase = [-40.2,-36:4:36,40.2];                                                  % 21 phases
        %Und_gap = [15.5,16:2:20,22.5:2.5:27.5,30:5:40,50:10:100,125:25:225,239];
        Und_gap = [15.5,16:2:20,22.5:2.5:27.5,30:5:40,50:10:100,125,140,240];               % 19 gaps
    % REDIGER ELOG
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%CALIBRATION DES CORRECTEURS
     [structureAllFileNames, res] = idMeasCorEfficForAllGaps(UndName, '', 10, Und_gap, 1);  % 8 minutes par gap
     
%% HU80_SEXTANTS
	if strcmp(idName, 'HU80_SEXTANTS')
		vCurVals = [-10, -5, 0, 5, 10];

		if(gap < 0.5*(15.5+ 16))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G155_he-10_ve0_hs0_vs0_2012-11-02_17-17-35.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he-5_ve0_hs0_vs0_2012-11-02_17-17-52.mat ';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-18-08.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G155_he5_ve0_hs0_vs0_2012-11-02_17-18-24.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G155_he10_ve0_hs0_vs0_2012-11-02_17-18-40.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-17-19.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-17-19.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-18-08.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-18-08.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-18-08.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve-10_hs0_vs0_2012-11-02_17-19-12.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve-5_hs0_vs0_2012-11-02_17-19-28.mat ';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-19-45.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve5_hs0_vs0_2012-11-02_17-20-01.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve10_hs0_vs0_2012-11-02_17-20-17.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-18-56.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-18-56.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-19-45.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-19-45.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-19-45.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs-10_vs0_2012-11-02_17-20-49.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs-5_vs0_2012-11-02_17-21-05.mat ';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-21-21.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs5_vs0_2012-11-02_17-21-37.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs10_vs0_2012-11-02_17-21-54.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-20-33.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-20-33.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-21-21.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-21-21.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-21-21.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs-10_2012-11-02_17-22-26.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs-5_2012-11-02_17-22-42.mat ';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-22-58.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs5_2012-11-02_17-23-14.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs10_2012-11-02_17-23-30.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-22-10.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-22-10.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-22-58.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-22-58.mat';
                                      'Efficiency_HU80_SEXTANTS_G155_he0_ve0_hs0_vs0_2012-11-02_17-22-58.mat']);
            end
		elseif(gap < 0.5*(16+ 18))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G160_he-10_ve0_hs0_vs0_2012-11-02_17-24-15.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he-5_ve0_hs0_vs0_2012-11-02_17-24-31.mat ';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-24-47.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G160_he5_ve0_hs0_vs0_2012-11-02_17-25-04.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G160_he10_ve0_hs0_vs0_2012-11-02_17-25-20.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-23-59.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-23-59.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-24-47.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-24-47.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-24-47.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve-10_hs0_vs0_2012-11-02_17-25-52.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve-5_hs0_vs0_2012-11-02_17-26-08.mat ';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-26-25.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve5_hs0_vs0_2012-11-02_17-26-41.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve10_hs0_vs0_2012-11-02_17-26-57.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-25-36.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-25-36.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-26-25.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-26-25.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-26-25.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs-10_vs0_2012-11-02_17-27-30.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs-5_vs0_2012-11-02_17-27-46.mat ';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-28-02.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs5_vs0_2012-11-02_17-28-18.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs10_vs0_2012-11-02_17-28-34.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-27-13.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-27-13.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-28-02.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-28-02.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-28-02.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs-10_2012-11-02_17-29-07.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs-5_2012-11-02_17-29-23.mat ';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-29-39.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs5_2012-11-02_17-29-55.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs10_2012-11-02_17-30-11.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-28-50.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-28-50.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-29-39.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-29-39.mat';
                                      'Efficiency_HU80_SEXTANTS_G160_he0_ve0_hs0_vs0_2012-11-02_17-29-39.mat']);
            end
		elseif(gap < 0.5*(18+ 20))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G180_he-10_ve0_hs0_vs0_2012-11-02_17-30-56.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he-5_ve0_hs0_vs0_2012-11-02_17-31-12.mat ';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-31-28.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G180_he5_ve0_hs0_vs0_2012-11-02_17-31-44.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G180_he10_ve0_hs0_vs0_2012-11-02_17-32-00.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-30-40.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-30-40.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-31-28.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-31-28.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-31-28.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve-10_hs0_vs0_2012-11-02_17-32-33.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve-5_hs0_vs0_2012-11-02_17-32-49.mat ';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-33-06.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve5_hs0_vs0_2012-11-02_17-33-22.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve10_hs0_vs0_2012-11-02_17-33-38.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-32-16.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-32-16.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-33-06.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-33-06.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-33-06.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs-10_vs0_2012-11-02_17-34-10.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs-5_vs0_2012-11-02_17-34-26.mat ';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-34-42.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs5_vs0_2012-11-02_17-34-59.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs10_vs0_2012-11-02_17-35-15.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-33-54.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-33-54.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-34-42.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-34-42.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-34-42.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs-10_2012-11-02_17-35-47.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs-5_2012-11-02_17-36-03.mat ';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-36-19.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs5_2012-11-02_17-36-36.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs10_2012-11-02_17-36-52.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-35-31.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-35-31.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-36-19.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-36-19.mat';
                                      'Efficiency_HU80_SEXTANTS_G180_he0_ve0_hs0_vs0_2012-11-02_17-36-19.mat']);
            end
		elseif(gap < 0.5*(20+ 22.5))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G200_he-10_ve0_hs0_vs0_2012-11-02_17-37-36.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he-5_ve0_hs0_vs0_2012-11-02_17-37-52.mat ';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-38-08.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G200_he5_ve0_hs0_vs0_2012-11-02_17-38-25.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G200_he10_ve0_hs0_vs0_2012-11-02_17-38-41.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-37-20.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-37-20.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-38-08.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-38-08.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-38-08.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve-10_hs0_vs0_2012-11-02_17-39-13.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve-5_hs0_vs0_2012-11-02_17-39-29.mat ';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-39-45.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve5_hs0_vs0_2012-11-02_17-40-02.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve10_hs0_vs0_2012-11-02_17-40-18.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-38-57.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-38-57.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-39-45.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-39-45.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-39-45.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs-10_vs0_2012-11-02_17-40-50.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs-5_vs0_2012-11-02_17-41-06.mat ';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-41-23.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs5_vs0_2012-11-02_17-41-39.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs10_vs0_2012-11-02_17-41-55.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-40-34.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-40-34.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-41-23.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-41-23.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-41-23.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs-10_2012-11-02_17-42-27.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs-5_2012-11-02_17-42-43.mat ';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-42-59.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs5_2012-11-02_17-43-16.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs10_2012-11-02_17-43-32.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-42-11.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-42-11.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-42-59.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-42-59.mat';
                                      'Efficiency_HU80_SEXTANTS_G200_he0_ve0_hs0_vs0_2012-11-02_17-42-59.mat']);
            end
		elseif(gap < 0.5*(22.5+ 25))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G225_he-10_ve0_hs0_vs0_2012-11-02_17-44-16.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he-5_ve0_hs0_vs0_2012-11-02_17-44-32.mat ';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-44-48.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G225_he5_ve0_hs0_vs0_2012-11-02_17-45-05.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G225_he10_ve0_hs0_vs0_2012-11-02_17-45-21.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-44-00.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-44-00.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-44-48.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-44-48.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-44-48.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve-10_hs0_vs0_2012-11-02_17-45-53.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve-5_hs0_vs0_2012-11-02_17-46-09.mat ';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-46-25.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve5_hs0_vs0_2012-11-02_17-46-42.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve10_hs0_vs0_2012-11-02_17-46-58.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-45-37.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-45-37.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-46-25.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-46-25.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-46-25.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs-10_vs0_2012-11-02_17-47-30.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs-5_vs0_2012-11-02_17-47-46.mat ';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-48-03.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs5_vs0_2012-11-02_17-48-19.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs10_vs0_2012-11-02_17-48-35.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-47-14.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-47-14.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-48-03.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-48-03.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-48-03.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs-10_2012-11-02_17-49-08.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs-5_2012-11-02_17-49-24.mat ';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-49-40.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs5_2012-11-02_17-49-56.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs10_2012-11-02_17-50-12.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-48-52.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-48-52.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-49-40.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-49-40.mat';
                                      'Efficiency_HU80_SEXTANTS_G225_he0_ve0_hs0_vs0_2012-11-02_17-49-40.mat']);
            end
		elseif(gap < 0.5*(25+ 27.5))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G250_he-10_ve0_hs0_vs0_2012-11-02_17-50-57.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he-5_ve0_hs0_vs0_2012-11-02_17-51-13.mat ';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-51-29.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G250_he5_ve0_hs0_vs0_2012-11-02_17-51-45.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G250_he10_ve0_hs0_vs0_2012-11-02_17-52-01.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-50-41.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-50-41.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-51-29.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-51-29.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-51-29.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve-10_hs0_vs0_2012-11-02_17-52-34.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve-5_hs0_vs0_2012-11-02_17-52-50.mat ';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-53-06.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve5_hs0_vs0_2012-11-02_17-53-22.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve10_hs0_vs0_2012-11-02_17-53-38.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-52-18.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-52-18.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-53-06.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-53-06.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-53-06.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs-10_vs0_2012-11-02_17-54-11.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs-5_vs0_2012-11-02_17-54-27.mat ';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-54-43.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs5_vs0_2012-11-02_17-54-59.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs10_vs0_2012-11-02_17-55-16.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-53-55.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-53-55.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-54-43.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-54-43.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-54-43.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs-10_2012-11-02_17-55-48.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs-5_2012-11-02_17-56-04.mat ';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-56-20.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs5_2012-11-02_17-56-36.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs10_2012-11-02_17-56-52.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-55-32.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-55-32.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-56-20.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-56-20.mat';
                                      'Efficiency_HU80_SEXTANTS_G250_he0_ve0_hs0_vs0_2012-11-02_17-56-20.mat']);
            end
		elseif(gap < 0.5*(27.5+ 30))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G275_he-10_ve0_hs0_vs0_2012-11-02_17-57-37.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he-5_ve0_hs0_vs0_2012-11-02_17-57-53.mat ';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-58-09.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G275_he5_ve0_hs0_vs0_2012-11-02_17-58-26.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G275_he10_ve0_hs0_vs0_2012-11-02_17-58-42.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-57-21.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-57-21.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-58-09.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-58-09.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-58-09.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve-10_hs0_vs0_2012-11-02_17-59-14.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve-5_hs0_vs0_2012-11-02_17-59-30.mat ';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-59-47.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve5_hs0_vs0_2012-11-02_18-00-03.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve10_hs0_vs0_2012-11-02_18-00-19.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-58-58.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-58-58.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-59-47.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-59-47.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_17-59-47.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs-10_vs0_2012-11-02_18-00-51.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs-5_vs0_2012-11-02_18-01-07.mat ';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-01-24.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs5_vs0_2012-11-02_18-01-40.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs10_vs0_2012-11-02_18-01-56.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-00-35.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-00-35.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-01-24.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-01-24.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-01-24.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs-10_2012-11-02_18-02-29.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs-5_2012-11-02_18-02-45.mat ';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-03-01.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs5_2012-11-02_18-03-17.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs10_2012-11-02_18-03-34.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-02-13.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-02-13.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-03-01.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-03-01.mat';
                                      'Efficiency_HU80_SEXTANTS_G275_he0_ve0_hs0_vs0_2012-11-02_18-03-01.mat']);
            end
		elseif(gap < 0.5*(30+ 35))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G300_he-10_ve0_hs0_vs0_2012-11-02_18-04-20.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he-5_ve0_hs0_vs0_2012-11-02_18-04-36.mat ';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-04-52.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G300_he5_ve0_hs0_vs0_2012-11-02_18-05-08.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G300_he10_ve0_hs0_vs0_2012-11-02_18-05-24.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-04-03.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-04-03.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-04-52.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-04-52.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-04-52.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve-10_hs0_vs0_2012-11-02_18-05-56.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve-5_hs0_vs0_2012-11-02_18-06-12.mat ';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-06-29.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve5_hs0_vs0_2012-11-02_18-06-45.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve10_hs0_vs0_2012-11-02_18-07-01.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-05-40.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-05-40.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-06-29.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-06-29.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-06-29.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs-10_vs0_2012-11-02_18-07-33.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs-5_vs0_2012-11-02_18-07-49.mat ';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-08-06.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs5_vs0_2012-11-02_18-08-22.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs10_vs0_2012-11-02_18-08-38.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-07-17.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-07-17.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-08-06.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-08-06.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-08-06.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs-10_2012-11-02_18-09-10.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs-5_2012-11-02_18-09-27.mat ';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-09-43.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs5_2012-11-02_18-09-59.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs10_2012-11-02_18-10-16.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-08-54.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-08-54.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-09-43.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-09-43.mat';
                                      'Efficiency_HU80_SEXTANTS_G300_he0_ve0_hs0_vs0_2012-11-02_18-09-43.mat']);
            end
		elseif(gap < 0.5*(35+ 40))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G350_he-10_ve0_hs0_vs0_2012-11-02_18-11-00.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he-5_ve0_hs0_vs0_2012-11-02_18-11-16.mat ';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-11-32.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G350_he5_ve0_hs0_vs0_2012-11-02_18-11-49.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G350_he10_ve0_hs0_vs0_2012-11-02_18-12-05.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-10-44.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-10-44.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-11-32.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-11-32.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-11-32.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve-10_hs0_vs0_2012-11-02_18-12-37.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve-5_hs0_vs0_2012-11-02_18-12-53.mat ';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-13-09.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve5_hs0_vs0_2012-11-02_18-13-25.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve10_hs0_vs0_2012-11-02_18-13-42.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-12-21.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-12-21.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-13-09.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-13-09.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-13-09.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs-10_vs0_2012-11-02_18-14-14.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs-5_vs0_2012-11-02_18-14-30.mat ';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-14-46.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs5_vs0_2012-11-02_18-15-03.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs10_vs0_2012-11-02_18-15-19.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-13-58.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-13-58.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-14-46.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-14-46.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-14-46.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs-10_2012-11-02_18-15-51.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs-5_2012-11-02_18-16-07.mat ';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-16-23.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs5_2012-11-02_18-16-40.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs10_2012-11-02_18-16-56.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-15-35.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-15-35.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-16-23.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-16-23.mat';
                                      'Efficiency_HU80_SEXTANTS_G350_he0_ve0_hs0_vs0_2012-11-02_18-16-23.mat']);
            end
		elseif(gap < 0.5*(40+ 50))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G400_he-10_ve0_hs0_vs0_2012-11-02_18-17-40.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he-5_ve0_hs0_vs0_2012-11-02_18-17-57.mat ';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-18-13.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G400_he5_ve0_hs0_vs0_2012-11-02_18-18-29.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G400_he10_ve0_hs0_vs0_2012-11-02_18-18-45.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-17-24.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-17-24.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-18-13.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-18-13.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-18-13.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve-10_hs0_vs0_2012-11-02_18-19-18.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve-5_hs0_vs0_2012-11-02_18-19-34.mat ';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-19-50.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve5_hs0_vs0_2012-11-02_18-20-06.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve10_hs0_vs0_2012-11-02_18-20-22.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-19-01.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-19-01.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-19-50.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-19-50.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-19-50.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs-10_vs0_2012-11-02_18-20-54.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs-5_vs0_2012-11-02_18-21-11.mat ';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-21-27.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs5_vs0_2012-11-02_18-21-43.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs10_vs0_2012-11-02_18-21-59.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-20-38.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-20-38.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-21-27.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-21-27.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-21-27.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs-10_2012-11-02_18-22-33.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs-5_2012-11-02_18-22-49.mat ';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-23-05.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs5_2012-11-02_18-23-21.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs10_2012-11-02_18-23-37.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-22-15.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-22-15.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-23-05.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-23-05.mat';
                                      'Efficiency_HU80_SEXTANTS_G400_he0_ve0_hs0_vs0_2012-11-02_18-23-05.mat']);
            end
		elseif(gap < 0.5*(50+ 60))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G500_he-10_ve0_hs0_vs0_2012-11-02_18-24-25.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he-5_ve0_hs0_vs0_2012-11-02_18-24-41.mat ';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-24-57.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G500_he5_ve0_hs0_vs0_2012-11-02_18-25-14.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G500_he10_ve0_hs0_vs0_2012-11-02_18-25-30.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-24-09.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-24-09.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-24-57.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-24-57.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-24-57.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve-10_hs0_vs0_2012-11-02_18-26-02.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve-5_hs0_vs0_2012-11-02_18-26-18.mat ';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-26-34.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve5_hs0_vs0_2012-11-02_18-26-50.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve10_hs0_vs0_2012-11-02_18-27-07.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-25-46.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-25-46.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-26-34.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-26-34.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-26-34.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs-10_vs0_2012-11-02_18-27-39.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs-5_vs0_2012-11-02_18-27-55.mat ';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-28-11.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs5_vs0_2012-11-02_18-28-27.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs10_vs0_2012-11-02_18-28-43.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-27-23.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-27-23.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-28-11.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-28-11.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-28-11.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs-10_2012-11-02_18-29-16.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs-5_2012-11-02_18-29-32.mat ';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-29-48.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs5_2012-11-02_18-30-04.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs10_2012-11-02_18-30-20.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-29-00.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-29-00.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-29-48.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-29-48.mat';
                                      'Efficiency_HU80_SEXTANTS_G500_he0_ve0_hs0_vs0_2012-11-02_18-29-48.mat']);
            end
		elseif(gap < 0.5*(60+ 70))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G600_he-10_ve0_hs0_vs0_2012-11-02_18-31-08.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he-5_ve0_hs0_vs0_2012-11-02_18-31-24.mat ';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-31-40.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G600_he5_ve0_hs0_vs0_2012-11-02_18-31-56.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G600_he10_ve0_hs0_vs0_2012-11-02_18-32-12.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-30-52.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-30-52.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-31-40.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-31-40.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-31-40.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve-10_hs0_vs0_2012-11-02_18-32-45.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve-5_hs0_vs0_2012-11-02_18-33-01.mat ';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-33-17.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve5_hs0_vs0_2012-11-02_18-33-33.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve10_hs0_vs0_2012-11-02_18-33-49.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-32-28.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-32-28.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-33-17.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-33-17.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-33-17.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs-10_vs0_2012-11-02_18-34-21.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs-5_vs0_2012-11-02_18-34-38.mat ';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-34-54.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs5_vs0_2012-11-02_18-35-10.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs10_vs0_2012-11-02_18-35-26.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-34-05.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-34-05.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-34-54.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-34-54.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-34-54.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs-10_2012-11-02_18-35-58.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs-5_2012-11-02_18-36-15.mat ';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-36-31.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs5_2012-11-02_18-36-47.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs10_2012-11-02_18-37-03.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-35-42.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-35-42.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-36-31.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-36-31.mat';
                                      'Efficiency_HU80_SEXTANTS_G600_he0_ve0_hs0_vs0_2012-11-02_18-36-31.mat']);
            end
		elseif(gap < 0.5*(70+ 80))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G700_he-10_ve0_hs0_vs0_2012-11-02_18-37-50.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he-5_ve0_hs0_vs0_2012-11-02_18-38-07.mat ';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-38-23.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G700_he5_ve0_hs0_vs0_2012-11-02_18-38-39.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G700_he10_ve0_hs0_vs0_2012-11-02_18-38-55.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-37-34.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-37-34.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-38-23.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-38-23.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-38-23.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve-10_hs0_vs0_2012-11-02_18-39-27.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve-5_hs0_vs0_2012-11-02_18-39-44.mat ';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-40-00.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve5_hs0_vs0_2012-11-02_18-40-16.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve10_hs0_vs0_2012-11-02_18-40-32.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-39-11.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-39-11.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-40-00.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-40-00.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-40-00.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs-10_vs0_2012-11-02_18-41-04.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs-5_vs0_2012-11-02_18-41-21.mat ';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-41-37.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs5_vs0_2012-11-02_18-41-53.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs10_vs0_2012-11-02_18-42-09.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-40-48.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-40-48.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-41-37.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-41-37.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-41-37.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs-10_2012-11-02_18-42-42.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs-5_2012-11-02_18-42-58.mat ';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-43-14.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs5_2012-11-02_18-43-30.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs10_2012-11-02_18-43-46.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-42-25.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-42-25.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-43-14.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-43-14.mat';
                                      'Efficiency_HU80_SEXTANTS_G700_he0_ve0_hs0_vs0_2012-11-02_18-43-14.mat']);
            end
		elseif(gap < 0.5*(80+ 90))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G800_he-10_ve0_hs0_vs0_2012-11-02_18-44-34.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he-5_ve0_hs0_vs0_2012-11-02_18-44-50.mat ';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-45-06.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G800_he5_ve0_hs0_vs0_2012-11-02_18-45-22.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G800_he10_ve0_hs0_vs0_2012-11-02_18-45-39.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-44-18.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-44-18.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-45-06.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-45-06.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-45-06.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve-10_hs0_vs0_2012-11-02_18-46-11.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve-5_hs0_vs0_2012-11-02_18-46-27.mat ';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-46-43.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve5_hs0_vs0_2012-11-02_18-47-00.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve10_hs0_vs0_2012-11-02_18-47-16.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-45-55.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-45-55.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-46-43.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-46-43.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-46-43.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs-10_vs0_2012-11-02_18-47-48.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs-5_vs0_2012-11-02_18-48-04.mat ';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-48-20.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs5_vs0_2012-11-02_18-48-36.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs10_vs0_2012-11-02_18-48-53.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-47-32.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-47-32.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-48-20.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-48-20.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-48-20.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs-10_2012-11-02_18-49-25.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs-5_2012-11-02_18-49-41.mat ';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-49-57.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs5_2012-11-02_18-50-13.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs10_2012-11-02_18-50-29.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-49-09.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-49-09.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-49-57.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-49-57.mat';
                                      'Efficiency_HU80_SEXTANTS_G800_he0_ve0_hs0_vs0_2012-11-02_18-49-57.mat']);
            end
		elseif(gap < 0.5*(90+ 100))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G900_he-10_ve0_hs0_vs0_2012-11-02_18-51-17.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he-5_ve0_hs0_vs0_2012-11-02_18-51-33.mat ';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-51-49.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G900_he5_ve0_hs0_vs0_2012-11-02_18-52-06.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G900_he10_ve0_hs0_vs0_2012-11-02_18-52-22.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-51-01.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-51-01.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-51-49.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-51-49.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-51-49.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve-10_hs0_vs0_2012-11-02_18-52-54.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve-5_hs0_vs0_2012-11-02_18-53-10.mat ';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-53-26.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve5_hs0_vs0_2012-11-02_18-53-42.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve10_hs0_vs0_2012-11-02_18-53-58.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-52-38.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-52-38.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-53-26.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-53-26.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-53-26.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs-10_vs0_2012-11-02_18-54-31.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs-5_vs0_2012-11-02_18-54-47.mat ';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-55-03.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs5_vs0_2012-11-02_18-55-19.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs10_vs0_2012-11-02_18-55-35.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-54-15.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-54-15.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-55-03.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-55-03.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-55-03.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs-10_2012-11-02_18-56-08.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs-5_2012-11-02_18-56-24.mat ';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-56-40.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs5_2012-11-02_18-56-56.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs10_2012-11-02_18-57-12.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-55-51.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-55-51.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-56-40.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-56-40.mat';
                                      'Efficiency_HU80_SEXTANTS_G900_he0_ve0_hs0_vs0_2012-11-02_18-56-40.mat']);
            end
		elseif(gap < 0.5*(100+ 125))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he-10_ve0_hs0_vs0_2012-11-02_18-58-00.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he-5_ve0_hs0_vs0_2012-11-02_18-58-16.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-58-32.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1000_he5_ve0_hs0_vs0_2012-11-02_18-58-48.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1000_he10_ve0_hs0_vs0_2012-11-02_18-59-05.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-57-44.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-57-44.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-58-32.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-58-32.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-58-32.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve-10_hs0_vs0_2012-11-02_18-59-37.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve-5_hs0_vs0_2012-11-02_18-59-53.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-00-09.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve5_hs0_vs0_2012-11-02_19-00-25.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve10_hs0_vs0_2012-11-02_19-00-41.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-59-21.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_18-59-21.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-00-09.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-00-09.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-00-09.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs-10_vs0_2012-11-02_19-01-14.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs-5_vs0_2012-11-02_19-01-30.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-01-46.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs5_vs0_2012-11-02_19-02-02.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs10_vs0_2012-11-02_19-02-18.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-00-58.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-00-58.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-01-46.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-01-46.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-01-46.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs-10_2012-11-02_19-02-51.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs-5_2012-11-02_19-03-07.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-03-23.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs5_2012-11-02_19-03-39.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs10_2012-11-02_19-03-55.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-02-34.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-02-34.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-03-23.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-03-23.mat';
                                      'Efficiency_HU80_SEXTANTS_G1000_he0_ve0_hs0_vs0_2012-11-02_19-03-23.mat']);
            end
		elseif(gap < 0.5*(125+ 150))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he-10_ve0_hs0_vs0_2012-11-02_19-04-46.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he-5_ve0_hs0_vs0_2012-11-02_19-05-02.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-05-18.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1250_he5_ve0_hs0_vs0_2012-11-02_19-05-34.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1250_he10_ve0_hs0_vs0_2012-11-02_19-05-50.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-04-29.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-04-29.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-05-18.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-05-18.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-05-18.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve-10_hs0_vs0_2012-11-02_19-06-23.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve-5_hs0_vs0_2012-11-02_19-06-39.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-06-55.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve5_hs0_vs0_2012-11-02_19-07-11.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve10_hs0_vs0_2012-11-02_19-07-27.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-06-06.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-06-06.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-06-55.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-06-55.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-06-55.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs-10_vs0_2012-11-02_19-08-00.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs-5_vs0_2012-11-02_19-08-16.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-08-32.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs5_vs0_2012-11-02_19-08-48.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs10_vs0_2012-11-02_19-09-04.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-07-43.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-07-43.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-08-32.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-08-32.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-08-32.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs-10_2012-11-02_19-09-37.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs-5_2012-11-02_19-09-53.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-10-09.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs5_2012-11-02_19-10-25.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs10_2012-11-02_19-10-41.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-09-20.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-09-20.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-10-09.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-10-09.mat';
                                      'Efficiency_HU80_SEXTANTS_G1250_he0_ve0_hs0_vs0_2012-11-02_19-10-09.mat']);
            end
		elseif(gap < 0.5*(150+ 175))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he-10_ve0_hs0_vs0_2012-11-02_19-11-32.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he-5_ve0_hs0_vs0_2012-11-02_19-11-49.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-12-05.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1500_he5_ve0_hs0_vs0_2012-11-02_19-12-21.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1500_he10_ve0_hs0_vs0_2012-11-02_19-12-37.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-11-15.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-11-15.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-12-05.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-12-05.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-12-05.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve-10_hs0_vs0_2012-11-02_19-13-10.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve-5_hs0_vs0_2012-11-02_19-13-26.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-13-42.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve5_hs0_vs0_2012-11-02_19-13-58.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve10_hs0_vs0_2012-11-02_19-14-14.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-12-53.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-12-53.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-13-42.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-13-42.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-13-42.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs-10_vs0_2012-11-02_19-14-47.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs-5_vs0_2012-11-02_19-15-03.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-15-19.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs5_vs0_2012-11-02_19-15-35.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs10_vs0_2012-11-02_19-15-52.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-14-31.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-14-31.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-15-19.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-15-19.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-15-19.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs-10_2012-11-02_19-16-24.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs-5_2012-11-02_19-16-40.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-16-56.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs5_2012-11-02_19-17-12.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs10_2012-11-02_19-17-29.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-16-08.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-16-08.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-16-56.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-16-56.mat';
                                      'Efficiency_HU80_SEXTANTS_G1500_he0_ve0_hs0_vs0_2012-11-02_19-16-56.mat']);
            end
		elseif(gap < 0.5*(175+ 200))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he-10_ve0_hs0_vs0_2012-11-02_19-18-19.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he-5_ve0_hs0_vs0_2012-11-02_19-18-35.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-18-51.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1750_he5_ve0_hs0_vs0_2012-11-02_19-19-08.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1750_he10_ve0_hs0_vs0_2012-11-02_19-19-24.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-18-03.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-18-03.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-18-51.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-18-51.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-18-51.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve-10_hs0_vs0_2012-11-02_19-19-56.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve-5_hs0_vs0_2012-11-02_19-20-12.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-20-29.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve5_hs0_vs0_2012-11-02_19-20-45.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve10_hs0_vs0_2012-11-02_19-21-01.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-19-40.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-19-40.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-20-29.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-20-29.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-20-29.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs-10_vs0_2012-11-02_19-21-34.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs-5_vs0_2012-11-02_19-21-50.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-22-06.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs5_vs0_2012-11-02_19-22-23.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs10_vs0_2012-11-02_19-22-39.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-21-17.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-21-17.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-22-06.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-22-06.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-22-06.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs-10_2012-11-02_19-23-11.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs-5_2012-11-02_19-23-27.mat ';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-23-43.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs5_2012-11-02_19-24-00.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs10_2012-11-02_19-24-16.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-22-55.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-22-55.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-23-43.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-23-43.mat';
                                      'Efficiency_HU80_SEXTANTS_G1750_he0_ve0_hs0_vs0_2012-11-02_19-23-43.mat']);
            end
		elseif(gap < 0.5*(200+ 225))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he-10_ve0_hs0_vs0_2012-11-02_19-25-07.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he-5_ve0_hs0_vs0_2012-11-02_19-25-23.mat ';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-25-39.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2000_he5_ve0_hs0_vs0_2012-11-02_19-25-55.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2000_he10_ve0_hs0_vs0_2012-11-02_19-26-11.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-24-50.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-24-50.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-25-39.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-25-39.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-25-39.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve-10_hs0_vs0_2012-11-02_19-26-44.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve-5_hs0_vs0_2012-11-02_19-27-00.mat ';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-27-16.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve5_hs0_vs0_2012-11-02_19-27-33.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve10_hs0_vs0_2012-11-02_19-27-49.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-26-27.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-26-27.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-27-16.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-27-16.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-27-16.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs-10_vs0_2012-11-02_19-28-21.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs-5_vs0_2012-11-02_19-28-38.mat ';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-28-54.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs5_vs0_2012-11-02_19-29-10.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs10_vs0_2012-11-02_19-29-26.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-28-05.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-28-05.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-28-54.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-28-54.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-28-54.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs-10_2012-11-02_19-29-58.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs-5_2012-11-02_19-30-15.mat ';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-30-31.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs5_2012-11-02_19-30-47.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs10_2012-11-02_19-31-03.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-29-42.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-29-42.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-30-31.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-30-31.mat';
                                      'Efficiency_HU80_SEXTANTS_G2000_he0_ve0_hs0_vs0_2012-11-02_19-30-31.mat']);
            end
		elseif(gap < 0.5*(225+ 239))

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he-10_ve0_hs0_vs0_2012-11-02_19-31-54.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he-5_ve0_hs0_vs0_2012-11-02_19-32-10.mat ';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-32-26.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2250_he5_ve0_hs0_vs0_2012-11-02_19-32-42.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2250_he10_ve0_hs0_vs0_2012-11-02_19-32-58.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-31-38.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-31-38.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-32-26.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-32-26.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-32-26.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve-10_hs0_vs0_2012-11-02_19-33-31.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve-5_hs0_vs0_2012-11-02_19-33-47.mat ';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-34-03.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve5_hs0_vs0_2012-11-02_19-34-20.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve10_hs0_vs0_2012-11-02_19-34-36.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-33-15.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-33-15.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-34-03.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-34-03.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-34-03.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs-10_vs0_2012-11-02_19-35-08.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs-5_vs0_2012-11-02_19-35-25.mat ';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-35-41.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs5_vs0_2012-11-02_19-35-57.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs10_vs0_2012-11-02_19-36-13.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-34-52.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-34-52.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-35-41.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-35-41.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-35-41.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs-10_2012-11-02_19-36-46.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs-5_2012-11-02_19-37-02.mat ';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-37-18.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs5_2012-11-02_19-37-34.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs10_2012-11-02_19-37-50.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-36-29.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-36-29.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-37-18.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-37-18.mat';
                                      'Efficiency_HU80_SEXTANTS_G2250_he0_ve0_hs0_vs0_2012-11-02_19-37-18.mat']);
            end
		else	% Gap > 239

            if strcmp(corName, 'CHE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he-10_ve0_hs0_vs0_2012-11-02_19-38-38.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he-5_ve0_hs0_vs0_2012-11-02_19-38-54.mat ';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-39-10.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2390_he5_ve0_hs0_vs0_2012-11-02_19-39-26.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2390_he10_ve0_hs0_vs0_2012-11-02_19-39-42.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-38-22.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-38-22.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-39-10.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-39-10.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-39-10.mat']);
            elseif strcmp(corName, 'CVE')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve-10_hs0_vs0_2012-11-02_19-40-15.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve-5_hs0_vs0_2012-11-02_19-40-31.mat ';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-40-47.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve5_hs0_vs0_2012-11-02_19-41-03.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve10_hs0_vs0_2012-11-02_19-41-19.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-39-59.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-39-59.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-40-47.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-40-47.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-40-47.mat']);
            elseif strcmp(corName, 'CHS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs-10_vs0_2012-11-02_19-41-52.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs-5_vs0_2012-11-02_19-42-08.mat ';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-42-24.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs5_vs0_2012-11-02_19-42-40.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs10_vs0_2012-11-02_19-42-56.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-41-36.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-41-36.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-42-24.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-42-24.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-42-24.mat']);
            elseif strcmp(corName, 'CVS')
                fnMeasMain = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs-10_2012-11-02_19-43-29.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs-5_2012-11-02_19-43-45.mat ';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-44-01.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs5_2012-11-02_19-44-17.mat  ';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs10_2012-11-02_19-44-33.mat ']);
                fnMeasBkgr = cellstr(['Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-43-13.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-43-13.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-44-01.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-44-01.mat';
                                      'Efficiency_HU80_SEXTANTS_G2390_he0_ve0_hs0_vs0_2012-11-02_19-44-01.mat']);
            end

	end	% End of HU80_SEXTANTS

     %Copier les valeurs du clipboard dans 'idReadCorElecBeamMeasData'
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%CODs
        % LANCER LE MODE PARALLELE: MODE 0
            % LANCER LE TREND
            % CORRECTION D'ORBITE
            Und_ModeName = 'II1'
            Und_MeasName = strcat('CODs_',Und_ModeName);        % 5 minutes par phase
            [resFiles, resErr] = idMeasElecBeamVsUndParam(Und_Name, {{'phase', Und_phase, 0.01}, {'gap', Und_gap, 0.01}}, {{'phase', 0, 0.01}, {'gap', 240, 0.01}}, 1, 0, Und_MeasName, 1);
            [mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables(Und_Name, {{'phase', Und_phase}, {'gap', Und_gap}}, resFiles.filenames_meas_bkg, '', '', -1)
            %Prendre le nom du fichier summary
            CalcFFWDTables(Und_Name,Und_FileName,'CODs_II1_summary_2012-11-02_21-23-50',Und_MeasName,1)
   
        % LANCER LE MODE ANTIPARALLELE: MODE 1
            % LANCER LE TREND
            % CORRECTION D'ORBITE
            Und_ModeName = 'X1'
            Und_MeasName = strcat('CODs_',Und_ModeName);        % 5 minutes par phase
            [resFiles, resErr] = idMeasElecBeamVsUndParam(Und_Name, {{'phase', Und_phase, 0.01}, {'gap', Und_gap, 0.01}}, {{'phase', 0, 0.01}, {'gap', 240, 0.01}}, 1, 0, Und_MeasName, 1);
            [mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables(Und_Name, {{'phase', Und_phase}, {'gap', Und_gap}}, resFiles.filenames_meas_bkg, '', '', -1)
            %Prendre le nom du fichier summary
            CalcFFWDTables(Und_Name,Und_FileName,'CODs_X1_summary_2012-11-03_21-49-51.mat',Und_MeasName,1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ON NE CONSERVE QUE LES VALEURS COHERENTES (LES 20 PREMIÈRES COLONNES DE
% GAP ET LES 17 PREMIÈRES DE PHASE) ET ON AJOUTE UNE LIGNE DE ZEROS
%mCHEr = idAuxMatrResizeExt(mCHE, 20, 17, 1, 1); mCHEr = idAuxMatrResizeExt(mCHEr, 21, 17, 1, 1);
%mCHSr = idAuxMatrResizeExt(mCHS, 20, 17, 1, 1); mCHSr = idAuxMatrResizeExt(mCHSr, 21, 17, 1, 1);
%mCVEr = idAuxMatrResizeExt(mCVE, 20, 17, 1, 1); mCVEr = idAuxMatrResizeExt(mCVEr, 21, 17, 1, 1);
%mCVSr = idAuxMatrResizeExt(mCVS, 20, 17, 1, 1); mCVSr = idAuxMatrResizeExt(mCVSr, 21, 17, 1, 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AJOUTE LA LIGNE DES PHASES ET LA COLONNE DES ENTREFER
%[mCHE_wa, mCVE_wa, mCHS_wa, mCVS_wa] = idAuxMergeFeedForwardCorTablesWithArgForAppleII(mCHE, mCVE, mCHS, mCVS, resFiles.params)
% FAIRE UN COPIER/COLLER DE CHACUNE DES 4 MATRICES DANS LE FIHIER DES 4
% TABLES UTILISÉES PAR LE DEVICE SERVEUR DANS:
% /usr/Local/configFiles/InsertionFFTables/ANS-C04-HU80
% FF_ANTIPARALLELE_CHE_TABLE, ...

 %[resFiles, resErr] = idMeasElecBeamVsUndParam(UndName, {{'phase', vphase, 0.01}, {'gap', [15.5,16,18,20,22,24,26,28,30,35,40,50,60,70,80,90,100,110,130,150,175,200,225,239], 0.01}}, {{'gap', 240, 0.01}, {'phase', 0, 0.01}}, 1, 0, 'cod_HU80_PLEIADES_PARA', 1)
 %[mCHE, mCVE, mCHS, mCVS] = idCalcFeedForwardCorTables('HU80_SEXTANTS', {{'phase', [-40:4:40]}, {'gap', [15.5,16,18,20,22,24,26,28,30,35,40,50,60,70,80,90,100,110,130,150,175,200,225,239]}}, resFiles.filenames_meas_bkg, '', '', -1)
    
