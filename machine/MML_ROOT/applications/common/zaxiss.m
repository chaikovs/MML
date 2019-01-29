function zaxiss(x)
%ZAXISS - Control the z-axis scaling for all the axes in a figure
%
%  Written by Greg Portmann

hgca = gca;

h = get(gcf,'children');

for i = 1:length(h)
    Hprops = get(h(i));
    if isfield(Hprops, 'ZTick')
        axes(h(i));
        zaxis(x);
    end
end

axes(hgca);
