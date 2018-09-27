function Elem=rbend(fname,L,A,A1,A2,K,method)
%BEND('FAMILYNAME',  Length[m], BendingAngle[rad], EntranceAngle[rad],
%	ExitAngle[rad], K, 'METHOD')
%	creates a new family in the FAMLIST - a structure with fields
%		FamName        	family name
%		Length         	length of the arc for an on-energy particle [m]
%		BendingAngle		total bending angle [rad]
%		EntranceAngle		[rad] (0 - for sector bends)
%		ExitAngle			[rad] (0 - for sector bends)
%		ByError				error in the dipole field relative to the design value 
%		K						quadrupole K-value for combined funtion bends
%		PassMethod        name of the function to use for tracking
% returns assigned address in the FAMLIST that is uniquely identifies
% the family


ElemData.FamName        = fname;  % add check for identical family names
ElemData.Length			= L;
ElemData.MaxOrder	    = 3;
ElemData.NumIntSteps 	= 10;
ElemData.BendingAngle  	= A;
ElemData.EntranceAngle 	= A1;
ElemData.ExitAngle     	= A2;
ElemData.ByError     	= 0;
ElemData.K      		= K;
ElemData.R1             = diag(ones(6,1));
ElemData.R2             = diag(ones(6,1));
ElemData.T1             = zeros(1,6);
ElemData.T2             = zeros(1,6);
ElemData.PolynomA		= [0 0 0 0];	 
ElemData.PolynomB		= [0 K 0 0]; 
ElemData.PassMethod 	= method;

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
