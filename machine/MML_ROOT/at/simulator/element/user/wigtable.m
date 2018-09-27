function z = wigtable(fname, L, Nslice, filename, method)
% wigtable(fname, L, Nslice, filename, method)
%
% FamName	family name
% Length    length[m]
% Nslice	number of slices (1 means the wiggler is represented by a
%           single kick in the center of the device).
% filename	name of file with wiggler tracking tables.
% method    name of the function to use for tracking
%
% The tracking table is described in 
% P. Elleaume, "A new approach to the electron beam dynamics in undulators
% and wigglers", EPAC92.
%
% returns assigned address in the FAMLIST that is uniquely identifies
% the family

%---------------------------------------------------------------------------
% Modification Log:
% -----------------
% 
%---------------------------------------------------------------------------

ElemData.FamName        = fname;  % add check for identical family names
ElemData.Length		    = L;
ElemData.Nslice    	    = Nslice;
ElemData.MaxOrder		= 3;
ElemData.NumIntSteps 	= 10;
ElemData.R1             = diag(ones(6,1));
ElemData.R2             = diag(ones(6,1));
ElemData.T1             = zeros(1,6);
ElemData.T2             = zeros(1,6);
ElemData.PassMethod 	= method;

load(filename);
ElemData.xtable = x;
ElemData.ytable = y;
ElemData.xkick  = xkick;
ElemData.ykick  = ykick;

global FAMLIST
z = length(FAMLIST)+1; % number of declare families including this one
FAMLIST{z}.FamName = fname;
FAMLIST{z}.NumKids = 0;
FAMLIST{z}.KidsList= [];
FAMLIST{z}.ElemData= ElemData;
