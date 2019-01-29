function run13decembre10

%% DEFINITION DES VALEURS DE COURANT  S

% alphaby10 sur optique MAHER lin 1 - optimisation de l'ouverture dynamique
IS= [24.48  -71.77  -217.19  256.27  -133.51  144.71  -117.02  133.12  -204.43  231.92   24.48];

%% ACTION

% appliquer_Q(IQ10)
% appliquer_S(IS10)

%% function sauvegarde
function IQ_depart = sauvegarde_Q
for iQ = 1:10
    Name = ['Q' num2str(iQ)];
    A = getam((Name),'Model');
    IQ(iQ) = A(1);
end

IQ_depart = IQ;

function IS_depart = sauvegarde_S
for iS = 1:11
    Name = ['S' num2str(iS)];
    A = getam((Name),'Model');
    IS(iS) = A(1);
end

IS_depart = IS;

%% fonction appliquer
function appliquer_Q(IQ)
for iQ = 1:10
    iQ
    Name = ['Q' num2str(iQ)];
    A = IQ(iQ);
    %s = getfamilydata((Name));
    %B = A * ones(length(s.DeviceList),1);
    setsp((Name),A);
end

function appliquer_S(IS)
for iS = 1:11
    iS
    Name = ['S' num2str(iS)];
    A = IS(iS);
    %s = getfamilydata((Name));
    %B = A * ones(length(s.DeviceList),1);
    setsp((Name),A);
end

%% V�rification des tendances de variation en courant
% figure(100);
% 
% hold on ; plot(IQ10./IQ10,'Color',nxtcolor)
% hold on ; plot(IQ20./IQ10,'Color',nxtcolor)
% hold on ; plot(IQ30./IQ10,'Color',nxtcolor)
% hold on ; plot(IQ40./IQ10,'Color',nxtcolor)
% hold on ; plot(IQ50./IQ10,'Color',nxtcolor)
% hold on ; plot(IQ60./IQ10,'Color',nxtcolor)
% 
% figure(200);
% 
% hold on ; plot(IS10./IS10,'Color',nxtcolor)
% hold on ; plot(IS20./IS10,'Color',nxtcolor)
% hold on ; plot(IS30./IS10,'Color',nxtcolor)
% hold on ; plot(IS40./IS10,'Color',nxtcolor)
% hold on ; plot(IS50./IS10,'Color',nxtcolor)
% hold on ; plot(IS60./IS10,'Color',nxtcolor)

% sensibilite alphas

   ******** Summary for 'alphaby10_AMOR_new_mod_nov10_lin_auto_0' ********
Quadrupole change for quadFamList change of 0.100000 A 
  Q1 (1A): Delta MCF1 = -2.35e-06 Delta MCF2 = -2.63e-05
  Q2 (1A): Delta MCF1 = -6.25e-06 Delta MCF2 = -6.54e-05
  Q3 (1A): Delta MCF1 = -1.29e-06 Delta MCF2 = -1.57e-05
  Q4 (1A): Delta MCF1 = -1.90e-06 Delta MCF2 = +1.06e-05
  Q5 (1A): Delta MCF1 = -9.29e-06 Delta MCF2 = +5.12e-05
  Q6 (1A): Delta MCF1 = -2.37e-07 Delta MCF2 = -3.11e-06
  Q7 (1A): Delta MCF1 = -3.77e-06 Delta MCF2 = -3.59e-05
  Q8 (1A): Delta MCF1 = -2.22e-06 Delta MCF2 = -2.22e-05
  Q9 (1A): Delta MCF1 = -1.63e-06 Delta MCF2 = +2.03e-05
 Q10 (1A): Delta MCF1 = -9.00e-06 Delta MCF2 = +9.52e-05
   ******** Summary for 'alphaby10_AMOR_new_mod_nov10_lin_auto_0' ********
Sextupole change for sextuFamList change of 0.100000 A 
  S1 (1A) : Delta MCF1 = +4.48e-17 Delta MCF2 = -4.25e-06
  S2 (1A) : Delta MCF1 = -1.51e-16 Delta MCF2 = -4.40e-07
  S3 (1A) : Delta MCF1 = -3.12e-16 Delta MCF2 = -3.65e-06
  S4 (1A) : Delta MCF1 = -1.00e-16 Delta MCF2 = -7.45e-06
  S5 (1A) : Delta MCF1 = -1.24e-16 Delta MCF2 = -1.03e-07
  S6 (1A) : Delta MCF1 = +1.33e-16 Delta MCF2 = -5.48e-07
  S7 (1A) : Delta MCF1 = -3.58e-17 Delta MCF2 = -1.88e-07
  S8 (1A) : Delta MCF1 = -3.31e-16 Delta MCF2 = -1.05e-06
  S9 (1A) : Delta MCF1 = +1.64e-16 Delta MCF2 = -3.65e-06
 S10 (1A) : Delta MCF1 = +5.27e-16 Delta MCF2 = -1.69e-05
 
% pour comparaison, les memes resultats pour l'optique low alpha maher
   ******** Summary for 'alphaby10_nouveau_modele_dec08_opt_lin_1' ********
Quadrupole change for quadFamList change of 0.100000 A 
  Q1 (1A): Delta MCF1 = -1.88e-06 Delta MCF2 = +1.80e-04
  Q2 (1A): Delta MCF1 = -4.10e-06 Delta MCF2 = +3.95e-04
  Q3 (1A): Delta MCF1 = -7.99e-07 Delta MCF2 = +7.47e-05
  Q4 (1A): Delta MCF1 = -2.84e-06 Delta MCF2 = -1.33e-04
  Q5 (1A): Delta MCF1 = -1.37e-05 Delta MCF2 = -6.46e-04
  Q6 (1A): Delta MCF1 = -1.24e-08 Delta MCF2 = -2.99e-07
  Q7 (1A): Delta MCF1 = -8.39e-07 Delta MCF2 = -2.13e-05
  Q8 (1A): Delta MCF1 = +9.54e-07 Delta MCF2 = +2.41e-05
  Q9 (1A): Delta MCF1 = -2.43e-06 Delta MCF2 = +1.27e-04
 Q10 (1A): Delta MCF1 = -1.34e-05 Delta MCF2 = +6.16e-04
   ******** Summary for 'alphaby10_nouveau_modele_dec08_opt_lin_1' ********
Sextupole change for sextuFamList change of 0.100000 A 
  S1 (1A) : Delta MCF1 = -1.56e-16 Delta MCF2 = +2.47e-06
  S2 (1A) : Delta MCF1 = -3.28e-16 Delta MCF2 = -2.20e-07
  S3 (1A) : Delta MCF1 = +1.89e-16 Delta MCF2 = -7.01e-06
  S4 (1A) : Delta MCF1 = -3.52e-16 Delta MCF2 = -1.40e-05
  S5 (1A) : Delta MCF1 = -1.65e-17 Delta MCF2 = -4.73e-09
  S6 (1A) : Delta MCF1 = -1.59e-16 Delta MCF2 = -8.27e-08
  S7 (1A) : Delta MCF1 = -1.31e-16 Delta MCF2 = -9.16e-09
  S8 (1A) : Delta MCF1 = +1.45e-16 Delta MCF2 = -1.62e-07
  S9 (1A) : Delta MCF1 = -1.00e-16 Delta MCF2 = -6.60e-06
 S10 (1A) : Delta MCF1 = -3.81e-16 Delta MCF2 = -3.04e-05
