function benchLength = physics_bunchlengtheningfactor(varargin)
%   physics_bunchlengtheningfactor - return experimental bunch lengthning
%   factor
%
%  INPUTS
%  1. current in mA [vector from 1 to 20 mA]
%  
%  OPTIONAL FLAG
%  DISPLAY, NON DISPLAY
%
%  See Also physics_bunchlength
%  

%
%% Written by Laurent S. Nadolski

DISPLAYFLAG = 0;
% switch factory
for i = length(varargin):-1:1
    if strcmpi(varargin{i}, 'DISPLAY')
    DISPLAYFLAG = 1;
    varargin(i) = [];
    elseif strcmpi(varargin{i}, 'NODISPLAY')
    DISPLAYFLAG = 0;
    varargin(i) = [];
    end
end

if isempty(varargin)
    current = 1:0.1:20;
else
    current = varargin{1};
end


%% 22 mai 2013. Data from M. Labat
% Bunch length with current
% mA   % RMS
Data=[
    0.09	15.9931
    0.17	15.9931
    0.28	16.6595
    0.37	16.6595
    0.46	16.6595
    0.81	17.9922
    1.04	18.6586
    1.52	19.325
    2.00	20.6578
    3.02	22.6569
    5.00	26.6552
    7.06	29.3207
    9.13	32.6526
    9.94	33.319
    12.17	36.6509
    13.98	38.65
    16.9	41.9819
    19.4	44.6474];

%%
p = polyfit(Data(:,1), Data(:,2)/Data(1,2), 3);

benchLength = polyval(p,current);

if DISPLAYFLAG
    figure
    plot(Data(:,1), Data(:,2)/Data(1,2),'kx'); hold on;
    plot(current, benchLength,'k'); hold on;
    title('Measurement May 4th 2012 (SOLEIL) @ 2.8 MV');
    xlabel('Bunch current (mA)')
    ylabel ('bunch lengthning factor');
    grid on;
end