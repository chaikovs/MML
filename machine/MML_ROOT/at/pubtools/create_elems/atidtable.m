function Elem = atidtable(fname, Nslice, filename, Energy, method)
% atidtable(fname, Nslice, filename, Energy, method)
%
% FamName	family name
% Nslice	number of slices (1 means the wiggler is represented by a
%           single kick in the center of the device).
% filename	name of file with wiggler tracking tables.
% Energy    Energy of the machine, needed for scaling
% method    name of the function to use for tracking. Use 'WigTablePass'
%
% The tracking table is described in
% P. Elleaume, "A new approach to the electron beam dynamics in undulators
% and wigglers", EPAC92.
%
% returns assigned structure

%---------------------------------------------------------------------------
% Modification Log:
% -----------------
% 13-09-2007:  Created by M. Munoz, based in J. Safranek code.
% 17-11-2008:  Modificated by Z.Martí
% 23-02-2012:  further modifications by B. Nash: reads in only matlab file
%---------------------------------------------------------------------------

Elem.FamName        = fname;  % add check for identical family names

Elem.Nslice    	= Nslice;
Elem.MaxOrder	    = 3;
Elem.NumIntSteps 	= 10;
Elem.R1             = diag(ones(6,1));
Elem.R2             = diag(ones(6,1));
Elem.T1             = zeros(1,6);
Elem.T2             = zeros(1,6);
Elem.PassMethod 	= method;


factor=1/((Energy/0.299792458)^2);
factor1=-1/((Energy/0.299792458));
    
% Read the file, first check if its a matlab file
%[pathstr, name, ext] = fileparts(filename)
%if  ~isequal(ext,'.mat');
 
    D=load(filename);
    x=(D.xtable)';
    y=(D.ytable)';
    xkick1=factor1*D.xkick1;
    ykick1=factor1*D.ykick1;
    xkick=factor*D.xkick;
    ykick=factor*D.ykick;
    L=D.Len;
    nn=size(xkick);
    Nx=nn(1);
    Ny=nn(2);
% Sort arrays in ascending order and transpose (needed for "IdTablePass.c")

[x indx]=sort(x);
[y indy]=sort(y);

xkick=xkick(indx,indy);
ykick=ykick(indx,indy);

xkick=xkick';
ykick=ykick';
xkick1=xkick1';
ykick1=ykick1';


Elem.Length= L;
Elem.NumX = Nx;
Elem.NumY = Ny;
Elem.xtable = x;
Elem.ytable = y;
Elem.xkick = xkick;
Elem.ykick = ykick;
Elem.xkick1 = xkick1;
Elem.ykick1 = ykick1;
Elem.PolynomA= [0 0 0 0];	 
Elem.PolynomB= [0 0 0 0];