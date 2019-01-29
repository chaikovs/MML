function N = getnumberofsectors
%GETNUMBEROFSECTORS - Number of sectors in the lattice
%  N = getnumberofsectors

%
% Written By Gregory J. Portmann

% Get the sectors from the device list.
% Guess at a few family names.

List = family2dev(gethcmfamily);
if isempty(List)
    List = family2dev(gethbpmfamily);
end
if isempty(List)
    List = family2dev('BEND');
end


if isempty(List)
    N = 1;
else
    N = max(List(:,1));
end
