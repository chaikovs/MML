function KSI=atchro(varargin)
% function atchro - AT function return linearchroamticity
%
%  INPUTS
%  1. lattice - lattice file
%
%  OUTPUTS
%  2. KSI - chromaticity vector

if isempty(varargin) || ~iscell(varargin{1}),
    error('atchro: lattice missing')
else
    RING = varargin{1};
end

[~,~, KSI] = linopt(RING,0);

KSI = KSI';