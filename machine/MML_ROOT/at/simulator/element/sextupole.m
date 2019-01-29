function Elem=sextupole(fname,L,S,method)

%SEXTUPOLE('FAMILYNAME',Length [m],S,'METHOD')
%	creates a new family in the FAMLIST - a structure with fields
%	FamName			    family name
%	Length		    	length[m]
%	S					S-strength of the sextupole
%	NumIntSteps		    Number of integration steps
%	MaxOrder
%	R1					6 x 6 rotation matrix at the entrance
%	R2        		    6 x 6 rotation matrix at the entrance
%	T1					6 x 1 translation at entrance 
%	T2					6 x 1 translation at exit4
%	ElemData.PolynomA= [0 0 0 0];	 
%	ElemData.PolynomB= [0 0 S 0]; 
%	PassMethod     name of the function to use for tracking
% returns assigned address in the FAMLIST that is uniquely identifies
% the family


ElemData.FamName = fname;  % add check for identical family names
ElemData.Length = L;
ElemData.MaxOrder = 3;
ElemData.NumIntSteps = 10;
ElemData.R1 = diag(ones(6,1));
ElemData.R2 = diag(ones(6,1));
ElemData.T1 = zeros(1,6);
ElemData.T2 = zeros(1,6);
ElemData.PolynomA= [0 0 0 0];	 
ElemData.PolynomB= [0 0 S 0]; 
ElemData.PassMethod=method;

global FAMLIST
% Check if familyname already exists in FAMLIST
% if (sum(cell2mat(cellfun(@(x) strcmp(x.FamName, fname),{FAMLIST{:}}, 'uni', false))) > 0)
%     error('Family Name %s exists already\n', fname);
% end

Elem = length(FAMLIST)+1; % number of declare families including this one
FAMLIST{Elem}.FamName = fname;
FAMLIST{Elem}.NumKids = 0;
FAMLIST{Elem}.KidsList= [];
FAMLIST{Elem}.ElemData= ElemData;
