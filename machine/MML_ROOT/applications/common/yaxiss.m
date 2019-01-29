function yaxiss(x)
%YAXISS - Control the vertical axis scaling for all the axes in a figure
%
% INPUTS
%  1. a [Xmin Xmax]
%  2. FigList if not specified changes just the X-axis on the current plot
%     else application X-Axis to figure list

%
% Written by Gregory J. Portmann

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
                yaxis(x, h(i));
            end
        end
    end
end
axes(hgca);
