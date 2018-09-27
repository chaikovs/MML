%% addapth to lattices
addpath /home/production/matlab/matlabML/machine/SOLEIL/StorageRing/Lattices/lowalpha_dec08

%% lattice list
alphaby10_nouveau_modele_dec08_opt_lin_1
alphaby20_nouveau_modele_dec08_opt_nonlin
alphaby30_nouveau_modele_dec08_opt_nonlin_1
alphaby40_nouveau_modele_dec08_opt_nonlin_2
alphaby50_nouveau_modele_dec08_opt_nonlin_1
alphaby60_nouveau_modele_dec08_opt_nonlin_1
alphaby100_nouveau_modele_janvier2010_opt_nonlin_ksi_2_2
alphaby1000_nouveau_modele_janvier2010_opt_nonlin_ksi_2_2

% lattice   alpha1 alpha2
% Warning chromaticites not maintained close to zero (0.4) for ultra
% low-alpha   alpha1     alpha2    xmean@1Hz  xix   xiz
%  lattice                            µm
%alpha/10   4.3804e-05 -3.4855e-05   -12       4.42  3.61
%alpha/20   2.2518e-05 -1.4258e-05   -22       1.86  2.21
%alpha/30   1.5177e-05 -4.7204e-05   -33       0.92  1.23
%alpha/40   1.1165e-05 -5.9727e-05   -45       0.27  0.39
%alpha/50   8.9622e-06 -5.5751e-05   -56       0.24  0.39
%alpha/60   7.4957e-06 -5.3875e-05   -67       0.22  0.39

%% New and final
% sensitivity matrices
[DKx DKz DtuneVal]   = modeltunesensitivity;

[DSx DSz DchroVal]   = modelchrosensitivity;

[QuadRmcf1 QuadRmcf2]= modelmcfsensitivity('Quad');

[SextuRmcf1 SextuRmcf2]=modelmcfsensitivity('Sextu');

%measbpmresp('Model','Archive');

%measdisp('Model','Hardware', 'Archive','Struct');

%save('Rmatrix_alphaby10_nov10', 'DtuneVal', 'DchroVal', 'QuadRmcf1', 'QuadRmcf2', 'SextuRmcf1', 'SextuRmcf2');

% %% step tunes and alpha1
% DI = pinv([DtuneVal(:,[5 7 8 10]); QuadRmcf1([5 7 8 10]); QuadRmcf2([5 7 8 10])])*[0.0 0.0 -1e-5 0]'
% 
% stepsp('Q5', DI(1));
% stepsp('Q7', DI(2));
% stepsp('Q8', DI(3));
% stepsp('Q10', DI(4));
% alphaby60_nouveau_modele_dec08_opt_nonlin_1
% modeltune
% getmcf('Model')
% physics_mcf
% 
% %% step chro and alpha2
% DI = pinv([DchroVal(:,[4 7 9]); SextuRmcf2([4 7 9])])*[0.0 0.0 0.0]'
% stepsp('S4', DI(1));
% stepsp('S7', DI(2));
% stepsp('S9', DI(3));
% modelchro
% physics_mcf


%%    ******** Summary for 'alphaby10_nouveau_modele_dec08_opt_lin_1' ********
%   ******** Summary for 'alphaby10_nouveau_modele_dec08_opt_lin_1' ********
% Quadrupole change for a change of 1 A 
%  Q1 : Dnux =  2.93e-02 Dnuz = -2.31e-02
%  Q2 : Dnux =  6.79e-02 Dnuz = -3.01e-02
%  Q3 : Dnux =  1.46e-02 Dnuz = -3.88e-02
%  Q4 : Dnux =  8.11e-03 Dnuz = -1.16e-01
%  Q5 : Dnux =  3.60e-02 Dnuz = -4.63e-02
%  Q6 : Dnux =  3.03e-02 Dnuz = -2.60e-01
%  Q7 : Dnux =  2.00e-01 Dnuz = -1.44e-01
%  Q8 : Dnux = -1.26e-01 Dnuz =  4.39e-02
%  Q9 : Dnux =  7.55e-03 Dnuz = -1.41e-01
% Q10 : Dnux =  3.64e-02 Dnuz = -3.40e-02
%    ******** Summary for 'alphaby10_nouveau_modele_dec08_opt_lin_1' ********
% Sextupole change for a change of 1 A 
%  S1 : Dxix = -1.00e-02 Dxiz =  5.08e-03
%  S2 : Dxix =  1.10e-03 Dxiz = -4.84e-03
%  S3 : Dxix =  2.58e-03 Dxiz = -1.07e-02
%  S4 : Dxix =  9.27e-03 Dxiz = -1.03e-02
%  S5 : Dxix =  6.30e-04 Dxiz = -2.08e-03
%  S6 : Dxix =  3.72e-03 Dxiz = -1.73e-03
%  S7 : Dxix =  6.17e-04 Dxiz = -2.04e-03
%  S8 : Dxix =  3.67e-03 Dxiz = -1.71e-03
%  S9 : Dxix =  2.34e-03 Dxiz = -1.41e-02
% S10 : Dxix =  1.02e-02 Dxiz = -5.95e-03
%    ******** Summary for 'alphaby10_nouveau_modele_dec08_opt_lin_1' ********
% Quadrupole change for a change of 1 A 
%   Q1 : Delta MCF1 = -1.88e-06 Delta MCF2 = +1.81e-04
%   Q2 : Delta MCF1 = -4.10e-06 Delta MCF2 = +3.95e-04
%   Q3 : Delta MCF1 = -7.98e-07 Delta MCF2 = +7.48e-05
%   Q4 : Delta MCF1 = -2.84e-06 Delta MCF2 = -1.34e-04
%   Q5 : Delta MCF1 = -1.35e-05 Delta MCF2 = -6.39e-04
%   Q6 : Delta MCF1 = -1.25e-08 Delta MCF2 = -2.54e-07
%   Q7 : Delta MCF1 = -8.39e-07 Delta MCF2 = -2.09e-05
%   Q8 : Delta MCF1 = +9.53e-07 Delta MCF2 = +2.38e-05
%   Q9 : Delta MCF1 = -2.43e-06 Delta MCF2 = +1.27e-04
%  Q10 : Delta MCF1 = -1.35e-05 Delta MCF2 = +6.21e-04
%    ******** Summary for 'alphaby10_nouveau_modele_dec08_opt_lin_1' ********
% Sextupole change for a change of 1 A 
%   S1 : Delta MCF1 = +3.46e-13 Delta MCF2 = +3.12e-07
%   S2 : Delta MCF1 = -2.88e-14 Delta MCF2 = -2.77e-08
%   S3 : Delta MCF1 = -4.73e-13 Delta MCF2 = -4.96e-07
%   S4 : Delta MCF1 = -1.67e-12 Delta MCF2 = -1.75e-06
%   S5 : Delta MCF1 = -1.01e-14 Delta MCF2 = -8.03e-10
%   S6 : Delta MCF1 = -4.61e-14 Delta MCF2 = -1.16e-08
%   S7 : Delta MCF1 = +7.29e-15 Delta MCF2 = -7.53e-10
%   S8 : Delta MCF1 = +1.03e-14 Delta MCF2 = -1.11e-08
%   S9 : Delta MCF1 = -4.30e-13 Delta MCF2 = -4.14e-07
%  S10 : Delta MCF1 = -1.98e-12 Delta MCF2 = -1.91e-06

%%   ******** Summary for 'alphaby20_nouveau_modele_dec08_opt_nonlin' ********
%   ******** Summary for 'alphaby20_nouveau_modele_dec08_opt_nonlin' ********
% Quadrupole change for a change of 1 A 
%  Q1 : Dnux =  2.87e-02 Dnuz = -2.34e-02
%  Q2 : Dnux =  6.70e-02 Dnuz = -2.98e-02
%  Q3 : Dnux =  1.46e-02 Dnuz = -3.77e-02
%  Q4 : Dnux =  7.86e-03 Dnuz = -1.17e-01
%  Q5 : Dnux =  3.48e-02 Dnuz = -4.66e-02
%  Q6 : Dnux =  2.95e-02 Dnuz = -2.72e-01
%  Q7 : Dnux =  1.94e-01 Dnuz = -1.55e-01
%  Q8 : Dnux = -1.33e-01 Dnuz =  4.40e-02
%  Q9 : Dnux =  7.16e-03 Dnuz = -1.45e-01
% Q10 : Dnux =  3.40e-02 Dnuz = -3.47e-02
%    ******** Summary for 'alphaby20_nouveau_modele_dec08_opt_nonlin' ********
% Sextupole change for a change of 1 A 
%  S1 : Dxix = -9.91e-03 Dxiz =  5.10e-03
%  S2 : Dxix =  1.12e-03 Dxiz = -4.76e-03
%  S3 : Dxix =  2.47e-03 Dxiz = -1.05e-02
%  S4 : Dxix =  8.91e-03 Dxiz = -1.03e-02
%  S5 : Dxix =  5.63e-04 Dxiz = -2.01e-03
%  S6 : Dxix =  3.72e-03 Dxiz = -1.79e-03
%  S7 : Dxix =  4.63e-04 Dxiz = -1.66e-03
%  S8 : Dxix =  3.32e-03 Dxiz = -1.62e-03
%  S9 : Dxix =  2.17e-03 Dxiz = -1.44e-02
% S10 : Dxix =  9.41e-03 Dxiz = -6.07e-03
%    ******** Summary for 'alphaby20_nouveau_modele_dec08_opt_nonlin' ********
% Quadrupole change for a change of 1 A 
%   Q1 : Delta MCF1 = -1.89e-06 Delta MCF2 = +1.69e-04
%   Q2 : Delta MCF1 = -4.15e-06 Delta MCF2 = +3.73e-04
%   Q3 : Delta MCF1 = -8.17e-07 Delta MCF2 = +7.12e-05
%   Q4 : Delta MCF1 = -2.81e-06 Delta MCF2 = -1.25e-04
%   Q5 : Delta MCF1 = -1.34e-05 Delta MCF2 = -5.99e-04
%   Q6 : Delta MCF1 = -6.70e-09 Delta MCF2 = +1.71e-06
%   Q7 : Delta MCF1 = -6.91e-07 Delta MCF2 = -4.93e-06
%   Q8 : Delta MCF1 = +8.93e-07 Delta MCF2 = +1.32e-05
%   Q9 : Delta MCF1 = -2.42e-06 Delta MCF2 = +1.21e-04
%  Q10 : Delta MCF1 = -1.35e-05 Delta MCF2 = +5.90e-04
%    ******** Summary for 'alphaby20_nouveau_modele_dec08_opt_nonlin' ********
% Sextupole change for a change of 1 A 
%   S1 : Delta MCF1 = +3.41e-13 Delta MCF2 = +3.16e-07
%   S2 : Delta MCF1 = -3.12e-14 Delta MCF2 = -2.87e-08
%   S3 : Delta MCF1 = -4.65e-13 Delta MCF2 = -4.90e-07
%   S4 : Delta MCF1 = -1.63e-12 Delta MCF2 = -1.72e-06
%   S5 : Delta MCF1 = -7.71e-15 Delta MCF2 = -6.26e-10
%   S6 : Delta MCF1 = -3.56e-14 Delta MCF2 = -1.09e-08
%   S7 : Delta MCF1 = +5.86e-15 Delta MCF2 = -3.97e-10
%   S8 : Delta MCF1 = +1.26e-14 Delta MCF2 = -8.22e-09
%   S9 : Delta MCF1 = -4.25e-13 Delta MCF2 = -4.12e-07
%  S10 : Delta MCF1 = -1.97e-12 Delta MCF2 = -1.91e-06
  
%%   ******** Summary for 'alphaby30_nouveau_modele_dec08_opt_nonlin_1' ********
%    ******** Summary for 'alphaby30_nouveau_modele_dec08_opt_nonlin_1' ********
% Quadrupole change for a change of 1 A 
%  Q1 : Dnux =  2.81e-02 Dnuz = -2.31e-02
%  Q2 : Dnux =  6.57e-02 Dnuz = -2.99e-02
%  Q3 : Dnux =  1.43e-02 Dnuz = -3.85e-02
%  Q4 : Dnux =  7.56e-03 Dnuz = -1.19e-01
%  Q5 : Dnux =  3.33e-02 Dnuz = -4.72e-02
%  Q6 : Dnux =  2.94e-02 Dnuz = -2.76e-01
%  Q7 : Dnux =  1.93e-01 Dnuz = -1.59e-01
%  Q8 : Dnux = -1.37e-01 Dnuz =  4.42e-02
%  Q9 : Dnux =  7.12e-03 Dnuz = -1.47e-01
% Q10 : Dnux =  3.38e-02 Dnuz = -3.50e-02
%    ******** Summary for 'alphaby30_nouveau_modele_dec08_opt_nonlin_1' ********
% Sextupole change for a change of 1 A 
%  S1 : Dxix = -9.56e-03 Dxiz =  5.01e-03
%  S2 : Dxix =  1.08e-03 Dxiz = -4.76e-03
%  S3 : Dxix =  2.39e-03 Dxiz = -1.07e-02
%  S4 : Dxix =  8.58e-03 Dxiz = -1.05e-02
%  S5 : Dxix =  4.77e-04 Dxiz = -1.77e-03
%  S6 : Dxix =  3.44e-03 Dxiz = -1.71e-03
%  S7 : Dxix =  4.52e-04 Dxiz = -1.67e-03
%  S8 : Dxix =  3.35e-03 Dxiz = -1.66e-03
%  S9 : Dxix =  2.19e-03 Dxiz = -1.46e-02
% S10 : Dxix =  9.45e-03 Dxiz = -6.15e-03
%    ******** Summary for 'alphaby30_nouveau_modele_dec08_opt_nonlin_1' ********
% Quadrupole change for a change of 1 A 
%   Q1 : Delta MCF1 = -1.84e-06 Delta MCF2 = +1.52e-04
%   Q2 : Delta MCF1 = -4.02e-06 Delta MCF2 = +3.33e-04
%   Q3 : Delta MCF1 = -7.86e-07 Delta MCF2 = +6.29e-05
%   Q4 : Delta MCF1 = -2.84e-06 Delta MCF2 = -1.14e-04
%   Q5 : Delta MCF1 = -1.36e-05 Delta MCF2 = -5.49e-04
%   Q6 : Delta MCF1 = -5.07e-09 Delta MCF2 = +1.79e-07
%   Q7 : Delta MCF1 = -6.33e-07 Delta MCF2 = -1.43e-05
%   Q8 : Delta MCF1 = +8.64e-07 Delta MCF2 = +2.00e-05
%   Q9 : Delta MCF1 = -2.41e-06 Delta MCF2 = +1.16e-04
%  Q10 : Delta MCF1 = -1.35e-05 Delta MCF2 = +5.64e-04
%    ******** Summary for 'alphaby30_nouveau_modele_dec08_opt_nonlin_1' ********
% Sextupole change for a change of 1 A 
%   S1 : Delta MCF1 = +3.26e-13 Delta MCF2 = +3.02e-07
%   S2 : Delta MCF1 = -3.10e-14 Delta MCF2 = -2.70e-08
%   S3 : Delta MCF1 = -4.76e-13 Delta MCF2 = -5.00e-07
%   S4 : Delta MCF1 = -1.67e-12 Delta MCF2 = -1.76e-06
%   S5 : Delta MCF1 = -6.80e-15 Delta MCF2 = -4.21e-10
%   S6 : Delta MCF1 = -2.66e-14 Delta MCF2 = -8.90e-09
%   S7 : Delta MCF1 = +5.26e-15 Delta MCF2 = -3.78e-10
%   S8 : Delta MCF1 = +8.78e-15 Delta MCF2 = -8.28e-09
%   S9 : Delta MCF1 = -4.21e-13 Delta MCF2 = -4.13e-07
%  S10 : Delta MCF1 = -1.97e-12 Delta MCF2 = -1.91e-06

%%    ******** Summary for 'alphaby40_nouveau_modele_dec08_opt_nonlin_2' ********
%   ******** Summary for 'alphaby40_nouveau_modele_dec08_opt_nonlin_2' ********
% Quadrupole change for a change of 1 A 
%  Q1 : Dnux =  2.78e-02 Dnuz = -2.31e-02
%  Q2 : Dnux =  6.54e-02 Dnuz = -2.98e-02
%  Q3 : Dnux =  1.43e-02 Dnuz = -3.82e-02
%  Q4 : Dnux =  7.48e-03 Dnuz = -1.19e-01
%  Q5 : Dnux =  3.29e-02 Dnuz = -4.71e-02
%  Q6 : Dnux =  2.93e-02 Dnuz = -2.77e-01
%  Q7 : Dnux =  1.91e-01 Dnuz = -1.62e-01
%  Q8 : Dnux = -1.39e-01 Dnuz =  4.43e-02
%  Q9 : Dnux =  7.05e-03 Dnuz = -1.47e-01
% Q10 : Dnux =  3.33e-02 Dnuz = -3.50e-02
%    ******** Summary for 'alphaby40_nouveau_modele_dec08_opt_nonlin_2' ********
% Sextupole change for a change of 1 A 
%  S1 : Dxix = -9.46e-03 Dxiz =  4.97e-03
%  S2 : Dxix =  1.08e-03 Dxiz = -4.71e-03
%  S3 : Dxix =  2.36e-03 Dxiz = -1.06e-02
%  S4 : Dxix =  8.48e-03 Dxiz = -1.05e-02
%  S5 : Dxix =  4.52e-04 Dxiz = -1.70e-03
%  S6 : Dxix =  3.39e-03 Dxiz = -1.70e-03
%  S7 : Dxix =  4.29e-04 Dxiz = -1.62e-03
%  S8 : Dxix =  3.30e-03 Dxiz = -1.66e-03
%  S9 : Dxix =  2.16e-03 Dxiz = -1.47e-02
% S10 : Dxix =  9.33e-03 Dxiz = -6.15e-03
%    ******** Summary for 'alphaby40_nouveau_modele_dec08_opt_nonlin_2' ********
% Quadrupole change for a change of 1 A 
%   Q1 : Delta MCF1 = -1.82e-06 Delta MCF2 = +1.48e-04
%   Q2 : Delta MCF1 = -3.99e-06 Delta MCF2 = +3.27e-04
%   Q3 : Delta MCF1 = -7.80e-07 Delta MCF2 = +6.17e-05
%   Q4 : Delta MCF1 = -2.85e-06 Delta MCF2 = -1.13e-04
%   Q5 : Delta MCF1 = -1.36e-05 Delta MCF2 = -5.43e-04
%   Q6 : Delta MCF1 = -4.48e-09 Delta MCF2 = +1.20e-07
%   Q7 : Delta MCF1 = -6.04e-07 Delta MCF2 = -1.42e-05
%   Q8 : Delta MCF1 = +8.50e-07 Delta MCF2 = +2.01e-05
%   Q9 : Delta MCF1 = -2.41e-06 Delta MCF2 = +1.15e-04
%  Q10 : Delta MCF1 = -1.35e-05 Delta MCF2 = +5.60e-04
%    ******** Summary for 'alphaby40_nouveau_modele_dec08_opt_nonlin_2' ********
% Sextupole change for a change of 1 A 
%   S1 : Delta MCF1 = +3.21e-13 Delta MCF2 = +2.97e-07
%   S2 : Delta MCF1 = -2.63e-14 Delta MCF2 = -2.67e-08
%   S3 : Delta MCF1 = -4.77e-13 Delta MCF2 = -5.02e-07
%   S4 : Delta MCF1 = -1.67e-12 Delta MCF2 = -1.77e-06
%   S5 : Delta MCF1 = -5.55e-15 Delta MCF2 = -3.74e-10
%   S6 : Delta MCF1 = -2.71e-14 Delta MCF2 = -8.46e-09
%   S7 : Delta MCF1 = +5.66e-15 Delta MCF2 = -3.43e-10
%   S8 : Delta MCF1 = +9.86e-15 Delta MCF2 = -7.96e-09
%   S9 : Delta MCF1 = -4.24e-13 Delta MCF2 = -4.13e-07
%  S10 : Delta MCF1 = -1.97e-12 Delta MCF2 = -1.91e-06
 
%%   ******** Summary for 'alphaby50_nouveau_modele_dec08_opt_nonlin_1' ********
%    ******** Summary for 'alphaby50_nouveau_modele_dec08_opt_nonlin_1' ********
% Quadrupole change for a change of 1 A 
%  Q1 : Dnux =  2.77e-02 Dnuz = -2.31e-02
%  Q2 : Dnux =  6.53e-02 Dnuz = -2.98e-02
%  Q3 : Dnux =  1.43e-02 Dnuz = -3.82e-02
%  Q4 : Dnux =  7.44e-03 Dnuz = -1.19e-01
%  Q5 : Dnux =  3.27e-02 Dnuz = -4.71e-02
%  Q6 : Dnux =  2.92e-02 Dnuz = -2.78e-01
%  Q7 : Dnux =  1.90e-01 Dnuz = -1.63e-01
%  Q8 : Dnux = -1.40e-01 Dnuz =  4.43e-02
%  Q9 : Dnux =  7.02e-03 Dnuz = -1.47e-01
% Q10 : Dnux =  3.31e-02 Dnuz = -3.50e-02
%    ******** Summary for 'alphaby50_nouveau_modele_dec08_opt_nonlin_1' ********
% Sextupole change for a change of 1 A 
%  S1 : Dxix = -9.43e-03 Dxiz =  4.97e-03
%  S2 : Dxix =  1.08e-03 Dxiz = -4.70e-03
%  S3 : Dxix =  2.34e-03 Dxiz = -1.06e-02
%  S4 : Dxix =  8.42e-03 Dxiz = -1.05e-02
%  S5 : Dxix =  4.41e-04 Dxiz = -1.68e-03
%  S6 : Dxix =  3.37e-03 Dxiz = -1.70e-03
%  S7 : Dxix =  4.15e-04 Dxiz = -1.58e-03
%  S8 : Dxix =  3.27e-03 Dxiz = -1.65e-03
%  S9 : Dxix =  2.15e-03 Dxiz = -1.47e-02
% S10 : Dxix =  9.27e-03 Dxiz = -6.16e-03
%    ******** Summary for 'alphaby50_nouveau_modele_dec08_opt_nonlin_1' ********
% Quadrupole change for a change of 1 A 
%   Q1 : Delta MCF1 = -1.81e-06 Delta MCF2 = +1.55e-04
%   Q2 : Delta MCF1 = -3.98e-06 Delta MCF2 = +3.42e-04
%   Q3 : Delta MCF1 = -7.79e-07 Delta MCF2 = +6.46e-05
%   Q4 : Delta MCF1 = -2.85e-06 Delta MCF2 = -1.18e-04
%   Q5 : Delta MCF1 = -1.36e-05 Delta MCF2 = -5.66e-04
%   Q6 : Delta MCF1 = -4.22e-09 Delta MCF2 = +1.82e-07
%   Q7 : Delta MCF1 = -5.89e-07 Delta MCF2 = -1.33e-05
%   Q8 : Delta MCF1 = +8.42e-07 Delta MCF2 = +1.94e-05
%   Q9 : Delta MCF1 = -2.41e-06 Delta MCF2 = +1.17e-04
%  Q10 : Delta MCF1 = -1.35e-05 Delta MCF2 = +5.69e-04
%    ******** Summary for 'alphaby50_nouveau_modele_dec08_opt_nonlin_1' ********
% Sextupole change for a change of 1 A 
%   S1 : Delta MCF1 = +3.20e-13 Delta MCF2 = +2.97e-07
%   S2 : Delta MCF1 = -2.99e-14 Delta MCF2 = -2.67e-08
%   S3 : Delta MCF1 = -4.76e-13 Delta MCF2 = -5.02e-07
%   S4 : Delta MCF1 = -1.67e-12 Delta MCF2 = -1.77e-06
%   S5 : Delta MCF1 = -5.48e-15 Delta MCF2 = -3.64e-10
%   S6 : Delta MCF1 = -2.78e-14 Delta MCF2 = -8.35e-09
%   S7 : Delta MCF1 = +5.71e-15 Delta MCF2 = -3.28e-10
%   S8 : Delta MCF1 = +1.40e-14 Delta MCF2 = -7.80e-09
%   S9 : Delta MCF1 = -4.21e-13 Delta MCF2 = -4.13e-07
%  S10 : Delta MCF1 = -1.97e-12 Delta MCF2 = -1.91e-06
 
%%  ******** Summary for 'alphaby60_nouveau_modele_dec08_opt_nonlin_1' ********
% Quadrupole change for a change of 1 A 
%  Q1 : Dnux =  2.77e-02 Dnuz = -2.31e-02
%  Q2 : Dnux =  6.52e-02 Dnuz = -2.98e-02
%  Q3 : Dnux =  1.42e-02 Dnuz = -3.82e-02
%  Q4 : Dnux =  7.42e-03 Dnuz = -1.19e-01
%  Q5 : Dnux =  3.25e-02 Dnuz = -4.71e-02
%  Q6 : Dnux =  2.91e-02 Dnuz = -2.79e-01
%  Q7 : Dnux =  1.90e-01 Dnuz = -1.64e-01
%  Q8 : Dnux =  1.44e-01 Dnuz = -4.54e-02
%  Q9 : Dnux =  7.01e-03 Dnuz = -1.47e-01
% Q10 : Dnux =  3.30e-02 Dnuz = -3.50e-02
%    ******** Summary for 'alphaby60_nouveau_modele_dec08_opt_nonlin_1' ********
% Sextupole change for a change of 1 A 
%  S1 : Dxix = -9.42e-03 Dxiz =  4.97e-03
%  S2 : Dxix =  1.08e-03 Dxiz = -4.71e-03
%  S3 : Dxix =  2.34e-03 Dxiz = -1.06e-02
%  S4 : Dxix =  8.39e-03 Dxiz = -1.05e-02
%  S5 : Dxix =  4.33e-04 Dxiz = -1.66e-03
%  S6 : Dxix =  3.35e-03 Dxiz = -1.69e-03
%  S7 : Dxix =  4.03e-04 Dxiz = -1.55e-03
%  S8 : Dxix =  3.25e-03 Dxiz = -1.64e-03
%  S9 : Dxix =  2.15e-03 Dxiz = -1.47e-02
% S10 : Dxix =  9.24e-03 Dxiz = -6.16e-03
%    ******** Summary for 'alphaby60_nouveau_modele_dec08_opt_nonlin_1' ********
% Quadrupole change for a change of 1 A 
%   Q1 : Delta MCF1 = -1.81e-06 Delta MCF2 = +1.56e-04
%   Q2 : Delta MCF1 = -3.98e-06 Delta MCF2 = +3.44e-04
%   Q3 : Delta MCF1 = -7.79e-07 Delta MCF2 = +6.52e-05
%   Q4 : Delta MCF1 = -2.85e-06 Delta MCF2 = -1.19e-04
%   Q5 : Delta MCF1 = -1.36e-05 Delta MCF2 = -5.70e-04
%   Q6 : Delta MCF1 = -4.05e-09 Delta MCF2 = +2.07e-07
%   Q7 : Delta MCF1 = -5.77e-07 Delta MCF2 = -1.29e-05
%   Q8 : Delta MCF1 = -8.56e-07 Delta MCF2 = -1.96e-05
%   Q9 : Delta MCF1 = -2.41e-06 Delta MCF2 = +1.17e-04
%  Q10 : Delta MCF1 = -1.35e-05 Delta MCF2 = +5.69e-04
%    ******** Summary for 'alphaby60_nouveau_modele_dec08_opt_nonlin_1' ********
% Sextupole change for a change of 1 A 
%   S1 : Delta MCF1 = +3.20e-13 Delta MCF2 = +2.97e-07
%   S2 : Delta MCF1 = -3.02e-14 Delta MCF2 = -2.66e-08
%   S3 : Delta MCF1 = -4.73e-13 Delta MCF2 = -5.03e-07
%   S4 : Delta MCF1 = -1.66e-12 Delta MCF2 = -1.77e-06
%   S5 : Delta MCF1 = -4.88e-15 Delta MCF2 = -3.48e-10
%   S6 : Delta MCF1 = -3.12e-14 Delta MCF2 = -8.21e-09
%   S7 : Delta MCF1 = +5.76e-15 Delta MCF2 = -3.14e-10
%   S8 : Delta MCF1 = +1.72e-14 Delta MCF2 = -7.65e-09
%   S9 : Delta MCF1 = -4.23e-13 Delta MCF2 = -4.14e-07
%  S10 : Delta MCF1 = -1.97e-12 Delta MCF2 = -1.91e-06