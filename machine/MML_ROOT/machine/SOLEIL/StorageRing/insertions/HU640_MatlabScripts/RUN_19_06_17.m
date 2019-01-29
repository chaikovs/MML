% Bumps between - mm and +2 mm by steps of 1 mm 
% 2 cyclages de HU640
% SOFB et FOFB OFF
% Correction d'orbite
% Bumps de -2 mm à +2 mm par pas de 0.5 mm entre -600A et +600A
HU640_SmallBump('SESSION_19_06_17',-600,600,300,-2,2,0.5)
% Analyse des CODs
PS1_Toutes_Integrales('SESSION_19_06_17',-600,600,300,-2,2,0.5)

% Déplacement des bobines d'entrée: +1 mm (direction extérieur anneau)
% Correction d'orbite
% Bumps de -2 mm à +2 mm par pas de 0.5 mm entre -600A et +600A
% Bumps de -2 mm à +2 mm par pas de 0.5 mm entre -600A et +600A
HU640_SmallBump('SESSION_19_06_17',-600,600,300,-2,2,0.5)
% Analyse des CODs
PS1_Toutes_Integrales('SESSION_19_06_17',-600,600,300,-2,2,0.5)

% HU640 à 0A
% CVE = 1.5A et CVS = -1.5 A
% Acquisition des CODs: bumps de -2mm à +2 mmpar pas de 0.5 mm

% Nouvelles tables de FFWD
PowerSupplyCycleAndBuildTables_3('SESSION_01_05_17','PS1',600,0,0,40,5)
% stocker fichier FF sous:
% /usr/Local/configFiles/InsertionFFTables/ANS-C05-HU640
