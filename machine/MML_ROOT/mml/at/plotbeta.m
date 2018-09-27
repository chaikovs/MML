function varargout = plotbeta(varargin)
%PLOTBETA - plots UNCOUPLED! beta-functions
%
%  INPUTS
%  0. - PLOTBETA with no argumnts uses THERING as the default lattice
%  1. RING - PLOTBETA(RING) calculates beta functions of the lattice RING
%
%  NOTES: PLOTBETA uses FINDORBIT4 and LINOPT which assume a lattice
%  with NO accelerating cavities and NO radiation
%
%  See Also plotcod, ploteta 

% Written by Andrei Terebilo
% Modified by Laurent S. Nadolski

if nargin == 0 | ~isstruct(varargin(1))
	global THERING
	RING = THERING;
end
L = length(RING);
spos = findspos(RING,1:L+1);

[TD, tune] = twissring(THERING,0,1:(length(THERING)+1));
BETA = cat(1,TD.beta);
S  = cat(1,TD.SPos);
disp(tune)

% figure
% plot betax and betay in two subplots

h1 = subplot(5,1,[1 2]);
plot(S,BETA(:,1),'.-b');
xlim([0 S(end)]);
ylabel('\beta_x [m]');
title('\beta-functions');

h2 = subplot(5,1,3);
drawlattice 
set(h2,'YTick',[])

h3 = subplot(5,1,[4 5]);
plot(S,BETA(:,2),'.-r');
xlabel('s - position [m]');
ylabel('\beta_z [m]');

linkaxes([h1 h2 h3],'x')
set([h1 h2 h3],'XGrid','On','YGrid','On');