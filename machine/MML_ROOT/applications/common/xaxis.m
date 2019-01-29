function varargout = xaxis(a, FigList)
%XAXIS - Control the horizontal axis scaling
%  xaxis(a)
%
% INPUTS
%  1. a [Xmin Xmax]
%  2. FigList if not specified changes just the X-axis on the current plot
%     else application X-Axis to figure list

%
% Written by Gregory J. Portmann

if nargin == 1
    set(gca, 'XLim', a);
elseif nargin >= 2
    for i = 1:length(FigList)
        if rem(FigList,1) == 0
            haxes = gca;
            figure(FigList(i));
            set(gca, 'XLim', a);
            axes(haxes);
        else
            % FigList is really a axes list
            set(FigList(i), 'XLim', a);
        end
    end
end

if nargout >= 1 || nargin == 0
    a = axis;
    varargout{1} = a(1:2);
end
