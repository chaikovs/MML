function varargout = D1Thomx_017_064_r56_02_chro11_errorMAX
%************************************************************
% ThomX ring lattice for AT (Accelrator Toolbox). 
%   Based on the Alexandre Loulergue's
%  *** VERSION ***
%  BETA-LNS v8.06 /04/02/14/ 2016/11/28 10:01:1                                    
%                                                                                 
%  *** TITRE ***
%  Thomx-hexagone tune=3.17/1.64 chro=0/0 r56=-0.24 LDff=83.5mm h=30                
%
%
% DON'T change the Lattice element names, since
% the lattice element names are fixed in the 
% MML file: /machine/THOMX/StorageRing/updateatindex.m
%
%  tune = 3.17  1.64 - C=17.9867m h=30 (BPM in good locations + COR)
%************************************************************
 
 global FAMLIST THERING GLOBVAL
 
 
 GLOBVAL.E0 = 50e6; % Ring energy [eV]
 GLOBVAL.LatticeFile = mfilename;
 FAMLIST = cell(0);
 


%% Lattice definition
load ThomX_017_064_r56_02_chro11_errorMAX.mat

THERING = thomx_lattice_error;
      
              
%buildlat(ELIST);

% Set all magnets to same energy
THERING = setcellstruct(THERING,'Energy',1:length(THERING),GLOBVAL.E0);
    
evalin('caller','global THERING FAMLIST GLOBVAL');

%ATIndexList = atindex(THERING);

% print the summary of the lattice
atsummary;

if nargout
    varargout{1} = THERING;
end











  
