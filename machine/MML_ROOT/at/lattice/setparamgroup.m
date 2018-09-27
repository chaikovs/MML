function NEWLATTICE = setparamgroup(LATTICE,PARAMGROUP,PVALUE,varargin)
%SETPARAMGROUP modifies a group of parameters
% NEWLATTICE = setparamgroup(LATTICE,PARAMGROUP,PVALUE)
%
% INPUTS
%1. LATTICE - lattice to modify
%2. PARAMGROUP - group of parameters
%3. PVALUE - Parmeter value to set
% 
% See also atparamgroup restoreparamgroup saveparamgroup

%
% Written by Gregory J. Portmann

% Modify the lattice
NEWLATTICE = LATTICE;

%   S = SETFIELD(S,{i,j},'field',{k},V) is equivalent to the syntax
%       S(i,j).field(k) = V;    
%  S = SETFIELD(S,'field',{i,j},,{k},V)
%
% What is used here: (poorly Matlab documented)
%  S = SETFIELD(S,'field',{i,j},V) is equivalent to the syntax
%       S.field(i,j) = V;    

if nargin == 3
    for i=1:length(PARAMGROUP)
        NEWLATTICE{PARAMGROUP(i).ElemIndex}=...
            setfield(NEWLATTICE{PARAMGROUP(i).ElemIndex},...
            PARAMGROUP(i).FieldName,PARAMGROUP(i).FieldIndex,...
            feval(PARAMGROUP(i).Function,PVALUE,PARAMGROUP(i).Args{:}));
    end
else
    for i=1:length(PARAMGROUP)
        NEWLATTICE{PARAMGROUP(i).ElemIndex}=...
            setfield(NEWLATTICE{PARAMGROUP(i).ElemIndex},...
            PARAMGROUP(i).FieldName,PARAMGROUP(i).FieldIndex,...
            feval(PARAMGROUP(i).Function,PVALUE,varargin{:}));
    end
end
