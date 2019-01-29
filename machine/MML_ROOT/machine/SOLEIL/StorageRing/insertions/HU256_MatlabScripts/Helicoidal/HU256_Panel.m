function HU256_Panel()
    Fig=figure('Position',  [0 50 1000 500], 'SelectionHighlight', 'off');
    CellPanel=uipanel(Fig, 'Title', 'Cell', 'FontSize', 12, 'Units', 'pixels', 'Position', [5 210 300 200]);
    ModePanel=uipanel(Fig, 'Title', 'Polarisation', 'FontSize', 12, 'Units', 'pixels', 'Position', [5 5 300 200]);
    CorrPanel=uipanel(Fig, 'Title', 'Correction', 'FontSize', 12, 'Units', 'pixels', 'Position', [305 210 600 200]);
    TablePanel=uipanel(Fig, 'Title', 'Table Creation', 'FontSize', 12, 'Units', 'pixels', 'Position', [305 5 600 200]);
    CellGrp=uibuttongroup('Units', 'pixels', 'Position', [5 210 300 192], 'SelectionChangeFcn', @essai_panel) %'toto=source');
    CassiopeeButton=uicontrol(CellGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'Cassiopée', 'Units', 'pixels', 'Position', [10 70 70 30]);
    PleiadesButton=uicontrol(CellGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'Pléiades', 'Units', 'pixels', 'Position', [10 40 70 30]);
    AntaresButton=uicontrol(CellGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'Antarès', 'Units', 'pixels', 'Position', [10 10 70 30]);
    ModeGrp=uibuttongroup('Units', 'pixels', 'Position', [5 5 300 192]);
    LHButton=uicontrol(ModeGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'LH', 'Units', 'pixels', 'Position', [10 130 70 30]);
    LVButton=uicontrol(ModeGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'LV', 'Units', 'pixels', 'Position', [10 100 70 30]);
    AHButton=uicontrol(ModeGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'AH', 'Units', 'pixels', 'Position', [10 70 70 30]);
    AVButton=uicontrol(ModeGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'AV', 'Units', 'pixels', 'Position', [10 40 70 30]);
    HelButton=uicontrol(ModeGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'Helical', 'Units', 'pixels', 'Position', [10 10 70 30]);
end

function essai_panel(a, b, toto)
    fprintf('toto : %f\n', toto)
end