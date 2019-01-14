
%CAP - Clears application data 
cap.m

% Saves the MML data structures ("AD" & "AD") and the model to a .mat file
savemml.m

% get filed values
atgetfieldvalues(thomx_ring,findcells(thomx_ring,'FamName','SX2'), 'PolynomB',{1,3})
getatfield('SX2','PolynomB')

% get filed values
BEND_indx = findcells(THERING,'FamName','BEND');