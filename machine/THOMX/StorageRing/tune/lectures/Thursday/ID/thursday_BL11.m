
latticeprepmad;

%%
global THERING
latticeprepwig
plotbeta

%% build LOCO input for optics correction

fixoptics1

%% 

locogui

%(1)  open the inputfile 'spearlocoinput'
%(2)  fit for two iterations
%(3)  check the betabeat
%(4)  export the lattice (THERING) to the workspace and save it to a file
%with 
%   >> save  lat_BL11_corr THERING

%%
global THERING
load lat_BL11_corr THERING

plotbeta
