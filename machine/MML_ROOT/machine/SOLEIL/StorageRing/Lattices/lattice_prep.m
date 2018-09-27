function lattice_prep
% lattice_prep - automatic generation of Golden lattice for a given lattice

% SOFB Response Matrice
[R, FileName] = measbpmresp('Model','Archive');
copybpmrespfile(FileName)

% FOFB Response Matrice
[R, FileName] = measbpmresp4FOFB('Model','Archive');
copybpmresp4FOFBfile(FileName);

% Chromaticity Response Matrice
[R, FileName] = measchroresp('Model','Archive');
copychrorespfile(FileName);

% tune Response Matrice
[R, FileName] = meastuneresp('Model','Archive');
copytunerespfile(FileName);

% dispersion
[etax,  etaz, FileName] = measdisp('Model','Hardware', 'Archive','Struct');
copydispersionfile(FileName);

fprintf('WARNING\n');
% Used for coupling/ vertical dispersion
fprintf('To be done by hand: write GoldenBPMGainCoupling_nameOfLattice\n');
% autobackup of the FOFB configuration
fprintf('To be done by hand: write GoldenMatrix4FPGA.mat \n');

fprintf('Matrix for low alpha');
modelalpharesponsemat;


% Other Golden file are created by FOFB Matlab application
%GoldenMatrix4FPGA.mat
%fofb_golden.mat

%automatic programme to be written
%GoldenBPMGainCoupling_lat_2020_3170b.mat  %% use for plotting vertical dispersion

% Used in solorbit ???
%GoldenLattice_lat_2020_3170b.mat   

% used by solorbit application
% physdata.mat
