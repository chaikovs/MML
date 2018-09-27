function xaxiss(x)
%XAXISS - Sets horizontal axis for all the axes in a figure
%  xaxiss(a)
%
%  INPUTS
%  1. a [Xmin Xmax]
%  2. FigList if not specified changes just the X-axis on the current plot
%     else application X-Axis to figure list

%
%  Written by Gregory J. Portmann

hgca = gca;
h = get(gcf,'children');

for i = 1:length(h)
    Hprops = get(h(i));
    
    % This is a clug to tell the difference between a plot and things like legends
    if isfield(Hprops, 'XTick')
        if isfield(Hprops, 'Tag')
            TagName = get(h(i), 'Tag');
            if isempty(TagName)
                %axes(h(i));
                xaxis(x, h(i));
            end
        end
    end
end
axes(hgca);

% subplot(4,1,1);
% xaxis([x(1) x(2)]);
% 
% subplot(4,1,2);
% xaxis([x(1) x(2)]);
% 
% subplot(4,1,3);
% xaxis([x(1) x(2)]);
% 
% subplot(4,1,4);
% xaxis([x(1) x(2)]);
