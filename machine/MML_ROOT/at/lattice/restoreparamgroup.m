function NEWLATTICE = restoreparamgroup(LATTICE,PARAMGROUP)
%RESTOREPARAMGROUP restores the values of multiple physical 
% parameters of the lattice using the special SavedValue field of 
% AT parameter group structure. 
% NEWLATTICE = RESTOREPARAMGROUP(LATTICE,PARAMGROUP)
% 
% See also atparamgroup setparamgroup saveparamgroup

NEWLATTICE = LATTICE;

for i=1:length(PARAMGROUP)
   NEWLATTICE{PARAMGROUP(i).ElemIndex}=...
       setfield(NEWLATTICE{PARAMGROUP(i).ElemIndex},...
       PARAMGROUP(i).FieldName,PARAMGROUP(i).FieldIndex,...
       PARAMGROUP(i).SavedValue);
end
