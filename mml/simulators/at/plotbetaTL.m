function varargout = plotbetaTL(varargin)
%PLOTBETA - plots UNCOUPLED! beta-functions
%
%  INPUTS
%  0. - PLOTBETATL with no argumnts uses THERING as the default lattice
%  1. RING - PLOTBETA(RING) calculates beta functions of the lattice RING
%
%  NOTES: PLOTBETATL uses twissline
%
%  See Also plotcod, ploteta 

% Written by Andrei Terebilo
% Modified by Laurent S. Nadolski
% Adapted by Christelle Bruni for transfert lines with TwissData defined in THERING 

if nargin == 0 | ~isstruct(varargin(1))
	global THERING
	RING = THERING;
end
L = length(RING);
spos = findspos(RING,1:L+1);

TD =twissline(THERING,0,THERING{1}.TwissData,1:(length(THERING)+1),'chrom');

BETA = cat(1,TD.beta);
ALPHA =cat(1,TD.alpha);
MU=cat(2,TD.Dispersion);%cat(1,TD.Dispersion);
eta=MU(1,:)';
S  = cat(1,TD.SPos);
%disp(tune)

 figure
% plot betax and betay in two subplots

h1 = subplot(5,1,[1 2]);
plot(S,BETA(:,1),'.-b'); hold on, plot(S,BETA(:,2),'.-r'), plot(S,eta*10,'.-g')
legend('\beta_x','\beta_y','10*\eta_x')
xlim([0 S(end)]);
ylabel('Optical function [m]');
title('\beta-functions');

h2 = subplot(5,1,3);
drawlattice 
set(h2,'YTick',[])

h3 = subplot(5,1,[4 5]);
plot(S,ALPHA(:,1),'.-b'), hold on, plot(S,ALPHA(:,2),'.-r'); 
legend('\alpha_x', '\alpha_y')
xlabel('s - position [m]');
ylabel('\alpha');

linkaxes([h1 h2 h3],'x')
set([h1 h2 h3],'XGrid','On','YGrid','On');
