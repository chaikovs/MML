
% Pilotage en SdC 
% Repérage de la section Courte SDC06 sur l'OrbitManager
% Relever les valeurs des BPMx et BPMz en entrée et sortie de l'onduleur en
% début de session
% Valeur de l'offset sur U20 CRISTAL:-0.15 mm

% Bumps d'Angle en X
    % Mise à la valeur de départ
    setorbitbump('BPMx',[6 5;6 6],[-0.5;0.5],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');
    % Scan en Angle X par pas de -0.05/0.05. ENTRE CHAQUE VALEUR DE BUMP:
    % ACQUISITION DU SPECTRE SUR H5 ET H19
    setorbitbump('BPMx',[6 5;6 6],[.25;-.25],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[.25;-.25],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[.25;-.25],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[.25;-.25],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[.25;-.25],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');
    % Retour à l'angle d'origine
    setorbitbump('BPMx',[6 5;6 6],[-0.5;0.5],'HCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');
% Bumps d'Angle en Z
    % Mise à la valeur de départ
    setorbitbump('BPMz',[6 5;6 6],[-0.5;0.5],'VCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');
    % Scan en Angle Z par pas de -0.05/0.05. ENTRE CHAQUE VALEUR DE BUMP:
    % ACQUISITION DU SPECTRE SUR H5 ET H19
    setorbitbump('BPMz',[6 5;6 6],[.25;-.25],'VCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');
    setorbitbump('BPMz',[6 5;6 6],[.25;-.25],'VCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');
    setorbitbump('BPMz',[6 5;6 6],[.25;-.25],'VCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');
    setorbitbump('BPMz',[6 5;6 6],[.25;-.25],'VCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');
    setorbitbump('BPMz',[6 5;6 6],[.25;-.25],'VCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');
    % Retour à l'angle d'origine
    setorbitbump('BPMz',[6 5;6 6],[-0.5;0.5],'VCOR',[-4 -3 -2 -1 1 2 3 4],'FitRF');

% Bumps de Position en X
    % Mise à la valeur de départ
    setorbitbump('BPMx',[6 5;6 6],[-1;-1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[-1;-1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[-1;-1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[-1;-1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    
    % Scan en Angle X par pas de -0.05/0.05. ENTRE CHAQUE VALEUR DE BUMP:
    % ACQUISITION DU SPECTRE SUR H5 ET H19
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[0.5;.5],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');    
    % Retour à la position d'origine
    setorbitbump('BPMx',[6 5;6 6],[-1;-1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[-1;-1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[-1;-1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    setorbitbump('BPMx',[6 5;6 6],[-1;-1],'HCOR',[-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8],'FitRF');
    
    
