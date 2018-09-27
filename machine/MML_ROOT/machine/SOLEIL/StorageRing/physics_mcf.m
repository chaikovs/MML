function [alpha1 alpha2 alpha3] = physics_mcf(varargin)
% PHYSICS_MCF - Computes momentum compaction up to 3rd order
%
%  INPUTS
%  1. Option Flag Display, NoDisplay
%
%  OUPUTS
%  2. pvalue - momentum compaction factor : alpha1, alpha2, alpha3 
%
%  See Also mcf2, getmcf 

%
%% Written by Laurent S. Nadolski

DisplayFlag = 1;

global THERING

for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin{i} = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin{i} = [];
    end
end
        
% energy variation for fitting mcf
deltamin = -1e-4;
deltamax = -deltamin;
%delta = deltamin:5e-5:deltamax;
delta = linspace(deltamin, deltamax, 7);
delta4eval = linspace(deltamin, deltamax, 21);
alpha = zeros(size(delta));

for k =1:length(delta)
    alpha(k) = mcf2(THERING,delta(k));
end

% fit curve upto 3rd order
porder =2;
pvalue = polyfit(delta, alpha, porder);
palpha = polyval(pvalue, delta4eval);


% warning, alpha value are effective mcf, local slope for offmomentum
% particle, so alpha = alpha1 + 2*alpha2*dp * 2*alpha3*dp^2
% This is the derivative of DT/T = alpha1*dp + alpha2*dp^2 + alpha3*dp^3;
alpha1 = pvalue(end);
alpha2 = pvalue(end-1)/2;
alpha3 = pvalue(end-2)/3;

if (0) % for debug
fprintf('Momentum compaction factor \n mcf = %3.2e + 2x %3.2e dp + 3x %3.2e dp**2\n', ...
        alpha1, alpha2, alpha3)
fprintf('Momentum compaction factor \n mcf = %3.2e (%3.2e) + %3.2e (%3.2e) dp + %3.2e (%3.2e) dp**2\n', ...
        [polymodel.Coefficients(end:-1:end-porder); polymodel.ParameterStd(end:-1:end-porder)])
end

if DisplayFlag
    figure
    plot(delta*100,alpha,'k.')
    grid on; hold on;
    plot(delta4eval*100,palpha,'r')
    title(sprintf('Momentum compaction factor \n alpha1= %3.2e alpha2= %3.2e  alpha3= %3.2e', ...
        alpha1, alpha2, alpha3))
    xlabel('Energy (%)')
    ylabel('Momemtum compaction factor');
    legend('Data', 'polyfit')
end
