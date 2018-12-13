function [g1,g6,g3,CXZE, Np]=bunch_image_E(phasespace,nbin,w)
% Return 2D density image CXZE from phasespace binning
% sliced along energy
% nbin :     binx binz and binE
% W : window Xmax Zmax and Emax

pmax1=w(1);[phasespace]=acceptance(phasespace,1,pmax1);
pmax3=w(2);[phasespace]=acceptance(phasespace,3,pmax3);
pmax6=w(3);[phasespace]=acceptance(phasespace,6,pmax6);

% Mesh over X
g1=(-pmax1:(2*pmax1)/(nbin(1)):pmax1);
% Mesh over Z
g3=(-pmax3:(2*pmax3)/(nbin(2)):pmax3);
% Mesh over E
g6=(-pmax6:(2*pmax6)/(nbin(3)):pmax6);

% Imported from the net
[CXZE] = histcn(phasespace([1 6 3],:)',g1,g6,g3);
Np = sum(sum(sum(CXZE)));

% to get the good bin !
% Mesh over X
g1=(-pmax1:(2*pmax1)/(nbin(1)-1):pmax1);
% Mesh over Z
g3=(-pmax3:(2*pmax3)/(nbin(2)-1):pmax3);
% Mesh over E
g6=(-pmax6:(2*pmax6)/(nbin(3)-1):pmax6);

return