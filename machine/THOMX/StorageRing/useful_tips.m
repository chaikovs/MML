
%CAP - Clears application data 
cap.m

% Saves the MML data structures ("AD" & "AD") and the model to a .mat file
savemml.m

% get filed values
atgetfieldvalues(thomx_ring,findcells(thomx_ring,'FamName','SX2'), 'PolynomB',{1,3})
getatfield('SX2','PolynomB')

%
atsetfieldvalues(thomx_ring,findcells(thomx_ring,'FamName','QP1'), 'PolynomB',{1,2},-4.9);

% make K identical to PolynomB(1,2)
pbind=findcells(r_optic,'PolynomB');
pbval=atgetfieldvalues(r_optic,pbind,'PolynomB',{1,2});
r_optic=atsetfieldvalues(r_optic,pbind,'K',{1,1},pbval);

% get filed values
BEND_indx = findcells(THERING,'FamName','BEND');

% RF cavity
thomx_ring=atsetcavity(thomx_ring,300e3,1,30); 
thomx_ring=atcavityoff(thomx_ring);
thomx_ring=atradon(thomx_ring);

%% Get energy

atenergy(thomx_ring) % check params=atgetcells(ring(:,1),'Class','RingParam');

%% get enerfy change due to correctors

findrf

%%

L = length(RING);
spos = findspos(RING,1:L+1);

%%
BPMindex=getlist('BPMz');	
findcells(THERING,'FamName','BPMx')