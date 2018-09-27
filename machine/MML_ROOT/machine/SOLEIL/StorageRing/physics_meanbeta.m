function [Hbet_mean Vbet_mean] = physics_meanbeta(varargin)
%  PHYSICS_MEANBETA - get mean betafunction around the ring
%
%  INPUTS
%  1. Empty or RING structure
%
%  OUTPUTS
%  1. Hbet_mean - Horizontal mean beta function
%  2. Vbet_mean - Vorizontal mean beta function
%
%  NOTES
%  1. Using Trapeze method, 10 cm stepsize
%
%  TODO
%  Interface getcircumference

%
%% Written by Laurent S. Nadolski

% if isempty(varargin)
%     global THERING;
%     SR=THERING;
% else
%     SR = varargin{1}
% end

 global THERING;
    SR=THERING;
circumference = getcircumference; % need input arguement


elmlength= varargin{1}; %meter

npts = round(circumference/elmlength);

% slice the ring
slicedSR = atslice(SR,npts);
res = atlinopt(slicedSR,0,1:length(slicedSR)+1); beta = cat(1,res.beta); 
spos = cat(1,res.SPos);
Hbet_mean = trapz(cat(1,res.SPos), beta(:,1))/getcircumference;
Vbet_mean = trapz(cat(1,res.SPos), beta(:,2))/getcircumference;
