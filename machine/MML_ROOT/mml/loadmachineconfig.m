function loadmachineconfig(Flag)
%LOADMACHINECONFIG - Sets the storage ring setpoints and monitors from a file 
%                    (same as setmachineconfig)
%  
% See also setmachineconfig for details

% 
% Written by Gregory J. Portmann

if nargin < 1
    setmachineconfig;
else
    setmachineconfig(Flag);
end
