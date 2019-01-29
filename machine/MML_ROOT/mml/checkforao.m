function checkforao
%CHECKFORAO - Checks if Accelerator Object exists
%

%
% Written by Gregory J. Portmann

AO = getao;
if isempty(AO)
    aoinit;
end


