function insertelem0(LATTICE, DRIFTPOS, SPLITLENGTH, ELEMDATA) 
%INSERTELEM0 inserts element(s) of zero length into a drift space
%
% MODIFIEDLATTICE = INSERTELEM0(LATTICE, DRIFTINDEX, SPLITLENGTH, FAMNAMESTRING) 
%   inserts marker(s) with FamName field set to FAMNAMESTRING
%   at distance SPLITLENGTH ( 0 < SPLITLENGTH < 1) into a drift space 
%   located at DRIFTINDEX in LATTICE
% 
% MODIFIEDLATTICE = (LATTICE, DRIFTINDEX, SPLITLENGTH, ELEMDATA) 
%   inserts zero-length element(s)
%   at distance SPLITLENGTH ( 0 < SPLITLENGTH < 1) into a drift space 
%   located at DRIFTPOS in THERING
% 
% Number of elements in the LATTICE is thus increased by 2
% SPLITLENGTH (controls the position of the SPLITLENGTH 
% L1 = L0*SPLITLENGTH
% L2 = L0(1-SPLITLENGTH)
%  where L0 is the length of the original DRIFT
%   
% See also: MERGEDRIFT
 
