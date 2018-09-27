function Test_which_lattice

% input
%
% output
% 
% PUMA W164 fermé @ 14.7 mm
%       Q8    [ 5,1]     -149.14004       -1.25287     -149.13949       -1.25286 
%       Q8    [ 6,1]     -149.97291       -1.25981     -149.97034       -1.25979 
% SLICING W164 fermé @ 16.7 mm
%       Q8    [ 5,1]     -152.10300       -1.27755     -152.10190       -1.27755 
%       Q8    [ 6,1]     -153.28100       -1.28736     -153.27941       -1.28734 
% ni l'un ni l'autre
%       Q8    [ 5,1]     -162.60600       -1.36465     -162.60498       -1.36464 
%       Q8    [ 6,1]     -163.99300       -1.37610     -163.99260       -1.37610 
%

Q8 = getam('Q8');
val = mean(Q8(7:8))
if val<151
    warndlg('Lattice is the one of PUMA, with W164 closed ar 14.7mm','!! Warning !!')
elseif val>=151&val<156
    warndlg('Lattice is the one of SLICING, with W164 closed ar 16.7mm','!! Warning !!')
else
    warndlg('Lattice is the one of standard Nanoscopium with W164 OPEN','!! Warning !!')
end
