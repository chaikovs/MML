function xaxesposition(PercentChange)
%  X-axes scaling for all the axes in a figure
%
%  INPUTS
%  1. PercentChange - Percentage for scaling (1 means no change) 
%
%  See also yaxesposition


% 
%  Written by Gregory J. Portmann


h = get(gcf,'children');

% set(gcf, 'Units', get(0, 'Units'));
% Pfig = get(gcf, 'Position');
% set(gcf, 'Position', get(0, 'ScreenSize'));
    
for i = 1:length(h)
    hget = get(h(i));
    if isfield(hget, 'Position') & ~strcmpi(hget.Tag, 'Legend')
        p = get(h(i), 'Position');
        if PercentChange > 1
            Percent = PercentChange - 1;
            set(h(i), 'Position', [p(1)-p(3)*Percent/2 p(2) p(3)+p(3)*Percent p(4)]);
        else
            Percent = 1 - PercentChange;
            set(h(i), 'Position', [p(1)+p(3)*Percent/2 p(2) p(3)-p(3)*Percent p(4)]);
        end
    end
end

%set(gcf,'Position', Pfig);