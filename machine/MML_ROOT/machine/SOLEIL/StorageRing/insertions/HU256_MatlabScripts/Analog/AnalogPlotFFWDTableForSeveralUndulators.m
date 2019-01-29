function [res, CellOfLabels]=AnalogPlotFFWDTableForSeveralUndulators(HU256Cell, Mode, PlotType, PowerSuppliesToPlot)
if (strcmpi(HU256Cell, 'all')||isempty(HU256Cell))
    HU256Cell=[4, 12, 15];
end
AddCellOnLabel=1;
CellOfColors=cell(3, 1);
CellOfColors{1}='b';
CellOfColors{2}='r';
CellOfColors{3}='g';
for i=1:length(HU256Cell)
    if (i==1)
        CellOfLabels='';
        NewGraph=1;
    else
        NewGraph=0;
    end
    ForceColorAndLine=CellOfColors{i};
    [res, CellOfLabels]=AnalogPlotFFWDTable(HU256Cell(i), Mode, PlotType, NewGraph, PowerSuppliesToPlot, ForceColorAndLine, AddCellOnLabel, CellOfLabels);
end