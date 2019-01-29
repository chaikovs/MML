function [res, CellOfLabels]=AnalogPlotFFWDTable(HU256Cell, Mode, PlotType, AppendToGraph, PowerSuppliesToPlot, ForceColorAndLine, AddCellOnLabel, OldCellOfLabels)
%% Written by F. Briquez 15/09/2011
% HU256Cell           : 4, 12 or 15
% Mode                : 'LH', 'LV', 'AH', 'AV', 'BX' or 'BXvalue' (such as '250')
% PlotType            : 'Point' : describes cycle along time (inculding main PS)
%                   or  'Current' : shows hysteresis cycle for correctors only
% AppendToGraph       : if zero => creates new graph. if '' appendt to current graph.
%                           Else appends to graph n°AppendToGraph
%                        if >0   => new plot on figure (NewGraph)
% PowerSuppliesToPlot : contains names of PS to plot, among BZP,BX1,BX2,CVE,CHE,CVS and CHS
%                       if empty or 'all' => all PS are plotted
% ForceColorAndLine   : format string such as 'r-' or 'b--', etc...
% AddCellOnLabel      : Add Cell number in PS labels (in legend)
% OldCellOfLabels     : Former Cell of labels to add labels in (in legend)
    
%% Initialization
    res=-1;
    CorrectorCoeff=100;
    AbsoluteValueOfCorrectors=0;    % To force absolute values (to simulate trends in cas of analog driving)
    if (isempty(PowerSuppliesToPlot)||strcmpi(PowerSuppliesToPlot, 'all'))
        PowerSuppliesToPlot='BZP,BX1,BX2,CVE,CHE,CVS,CHS';
    end
%% Get table
    [FFWDTable, PowerSupplies]=AnalogGetFFWDTableFromDevice(HU256Cell, Mode);
    if (isempty(FFWDTable))
        fprintf ('''AnalogPlotFFWDTable'' : could not load table\n')
        return
    end
    NumberOfPowerSupplies=size(FFWDTable, 1);
    NumberOfCurrents=size(FFWDTable, 2);
    
%% Prepare figure
if isempty(AppendToGraph)
    AppendToGraph=gcf;
    h=gcf;
end
if AppendToGraph==0
    h=figure;
else
    if ishghandle(AppendToGraph)
        h=figure(AppendToGraph);
        %figure(AppendToGraph);
        hold on
    else
        fprintf('AnalogPlotFFWDTable : ''%g'' is a wrong figure handle!\n', AppendToGraph)
        return
    end
end

%     if (NewGraph>0)
%         if (ishghandle(NewGraph))
%             close(NewGraph);
%         end
%     end
%     if (ishghandle(NewGraph))
%         h=figure(NewGraph);
%         TitleString=sprintf('HU256 C%02.0f %s', HU256Cell, Mode);
%         title (TitleString);
%     else
%         h=figure(NewGraph);
%     end
%     hold on

%% Prepare Cell of labels for legend
    if isempty(OldCellOfLabels)
        CellOfLabels=cell(0, 1);
    else
        CellOfLabels=OldCellOfLabels;
    end

%% Beginning of loop
    for i=1:NumberOfPowerSupplies
%% Definition of plot vectors
        if (strcmp(PlotType, 'Point'))
            TempX=1:NumberOfCurrents;
        elseif (strcmp(PlotType, 'Current'))
            TempX=FFWDTable(1, :);
        end
        
        TempY=FFWDTable(i, :);
        TempName=PowerSupplies{i};
        if (strncmp(TempName, 'C', 1))
            if (AbsoluteValueOfCorrectors)
                TempY=abs(TempY*CorrectorCoeff);
            else
                TempY=TempY*CorrectorCoeff;
            end
        end
%% Plot characteristics        
        Display=1;
        if (strcmp(TempName, 'BZP'))
            Color='r';
            Line='-';
            Width=2;
            if (strcmp(PlotType, 'Current'))
                Display=0;
            end
        elseif (strncmp(TempName, 'BX1', 3))
            Color='b';
            Line='-';
            Width=2;
            if (strncmp(PlotType, 'Current', 3))
                Display=0;
            end
        elseif (strncmp(TempName, 'BX2', 3))
            Color='b';
            Line='--';
            Width=2;
            if (strncmp(PlotType, 'Current', 3))
                Display=0;
            end
        elseif (strncmp(TempName, 'CVE', 3))
            Color='c';
            Line='-';
            Width=1;
        elseif (strncmp(TempName, 'CHE', 3))
            Color='m';
            Line='-';
            Width=1;
        elseif (strncmp(TempName, 'CVS', 3))
            Color='k';
            Line='-';
            Width=1;
        elseif (strncmp(TempName, 'CHS', 3))
            Color='g';
            Line='-';
            Width=1;
        end
        if (~isempty(ForceColorAndLine))
            Color=ForceColorAndLine;
        end
%% Check PS should be plotted
        if (isempty(findstr(TempName, PowerSuppliesToPlot)))
            Display=0;
        end
        
%% Update of Cell of labels
        if (Display)
            if (~AddCellOnLabel)
                CellOfLabels{size(CellOfLabels, 1)+1, 1}=TempName;
            else
                CellOfLabels{size(CellOfLabels, 1)+1, 1}=[TempName ' C' num2str(HU256Cell)];
            end

%% Append plot
            plot (TempX, TempY, [Line Color], 'LineWidth', Width);
        end
%% End of loop
    end

%% Applying legend
%     if (strcmp(PlotType, 'Point'))
        legend (CellOfLabels);
%     elseif (strcmp(PlotType, 'Current'))
%         legend (CellOfLabels{2:size(CellOfLabels, 1), 1});
%     end

%% End
    hold off;
    res=h;
    return
end

%% Part of script to plot all BX values :
for i=0:25:275
    h=1;
    h=AnalogPlotFFWDTable(12, num2str(i), 'Point', (i~=0)*h, 'CVS', '', '', '');
end