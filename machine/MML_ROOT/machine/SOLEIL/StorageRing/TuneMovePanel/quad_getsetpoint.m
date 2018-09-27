function [quadlist val] = quad_getsetpoint
% QUAD_GETSETPOINT - Read First element of each quadrupole family
%
%  OUTPUTS
%  1. quadlist - qaudrupole family list
%  2. val      - first value of  quadrupoles

% Written By M. Munoz
% Modified by Laurent S. Nadolski


quadlist = findmemberof('QUAD')';
imax = size(quadlist,2);
data = getsp(quadlist,'Model','Physics');

val = cell(1,imax);

for k = 1:imax,
    val{k} = data{k}(1);
end
