%% Main Fonction

function HU256_Panel3()
    global HU256PANELHANDLES;
    global HU256PANELVALUES;
    
%% Initialisation
HU256_TotalCycling(4, 'inithel', 'hel', '', 0, '', 0, 0) % In order to initialise the lists of currents

%     StartPathForApplyingCorrection='c:'; %'toto'; %'c:\';
    StartPathForApplyingCorrection='/home/operateur/GrpGMI/HU256_PLEIADES/SESSION_2008_08_31/Circulaire';  %%/home/operateur/GrpGMI/HU256_PLEIADES/SESSION_2007_10_28
    StartPathForBuildingCorrection='/home/operateur/GrpGMI/HU256_PLEIADES/SESSION_2008_08_31/Circulaire';      %%/home/operateur/GrpGMI/HU256_PLEIADES/SESSION_2007_10_28
    HU256PANELVALUES.StartPathForApplyingCorrection=StartPathForApplyingCorrection;
    HU256PANELVALUES.StartPathForBuildingCorrection=StartPathForBuildingCorrection;
    
    LeftPartWidth=100;
    MiddlePartWidth=1000;
    RightPartWidth=100;
    
    VerticalGap=5;
    HorizontalGap=5;
    
    CharactersHeight=12;
    
    FigureHorizontalMargin=0;
    FigureVerticalMargin=0;
    
    BottomPartHeight=400;  % 200
    TopPartHeight=400; % 200
    
    FigureWidth=HorizontalGap+LeftPartWidth+HorizontalGap+MiddlePartWidth+HorizontalGap+RightPartWidth+HorizontalGap+FigureHorizontalMargin;
    FigureHeight=VerticalGap+BottomPartHeight+VerticalGap+TopPartHeight+VerticalGap+FigureVerticalMargin;
    
    ScreenSize=get(0, 'ScreenSize');
    FigureLeftStart=(ScreenSize(3)-FigureWidth)/2;
    FigureBottomStart=(ScreenSize(4)-FigureHeight)/2;

    
%     LeftPartHorizontalStart=FigureLeftStart+HorizontalGap;
%     BottomPartVerticalStart=FigureBottomStart+VerticalGap;
%     MiddlePartHorizontalStart=LeftPartHorizontalStart+HorizontalGap+LeftPartWidth;
%     RightPartHorizontalStart=MiddlePartHorizontalStart+HorizontalGap+MiddlePartWidth;
%     TopPartVerticalStart=BottomPartVerticalStart+VerticalGap+BottomPartHeight;
    
    LeftPartHorizontalStart=HorizontalGap;
    BottomPartVerticalStart=VerticalGap;
    MiddlePartHorizontalStart=HorizontalGap+LeftPartWidth+HorizontalGap;
    RightPartHorizontalStart=MiddlePartHorizontalStart+MiddlePartWidth+HorizontalGap;
    TopPartVerticalStart=VerticalGap+BottomPartHeight;
    RightPartHeight=BottomPartHeight+TopPartHeight; %+VerticalGap;
    
    fprintf ('H Start : %1.0f %1.0f %1.0f %1.0f\n', FigureLeftStart, LeftPartHorizontalStart, MiddlePartHorizontalStart, RightPartHorizontalStart)
    fprintf ('Panel Width: %1.0f Parts Width : %1.0f %1.0f %1.0f\n', FigureWidth, LeftPartWidth, MiddlePartWidth, RightPartWidth)
    fprintf ('V Start : %1.0f %1.0f %1.0f\n', FigureBottomStart, BottomPartVerticalStart, TopPartVerticalStart)
    fprintf ('Panel Height: %1.0f Parts Height : %1.0f %1.0f\n', FigureHeight, BottomPartHeight, TopPartHeight)

%% Global Variables Initialisation

    HU256PANELVALUES.Correction=0;
    HU256PANELVALUES.CorrectionDirectory='';
    HU256PANELVALUES.CorrectionSuffix='';
    HU256PANELVALUES.Acquisition=0;
    HU256PANELVALUES.AcquisitionDirectory='';
    HU256PANELVALUES.Table=0;
    HU256PANELVALUES.TableSuffix='';
    
    
%% Figure & Panels creations

    % Figure position
    HU256PANELHANDLES.Fig=figure('Position',  [FigureLeftStart FigureBottomStart FigureWidth FigureHeight], 'SelectionHighlight', 'off');
    
    
    % Panels positions
    HU256PANELHANDLES.CellPanel=uipanel(HU256PANELHANDLES.Fig, 'Title', 'Cell', 'FontSize', 12, 'Units', 'pixels', 'Position', [LeftPartHorizontalStart TopPartVerticalStart LeftPartWidth TopPartHeight]);
    HU256PANELHANDLES.ModePanel=uipanel(HU256PANELHANDLES.Fig, 'Title', 'Polarisation', 'FontSize', 12, 'Units', 'pixels', 'Position', [LeftPartHorizontalStart BottomPartVerticalStart LeftPartWidth BottomPartHeight]);
    HU256PANELHANDLES.CorrectionPanel=uipanel(HU256PANELHANDLES.Fig, 'Title', 'Applying correction', 'FontSize', 12, 'Units', 'pixels', 'Position', [MiddlePartHorizontalStart TopPartVerticalStart MiddlePartWidth TopPartHeight]);
    HU256PANELHANDLES.TablePanel=uipanel(HU256PANELHANDLES.Fig, 'Title', 'Table Creation', 'FontSize', 12, 'Units', 'pixels', 'Position', [MiddlePartHorizontalStart BottomPartVerticalStart MiddlePartWidth BottomPartHeight]);
    HU256PANELHANDLES.ActionPanel=uipanel(HU256PANELHANDLES.Fig, 'Title', 'Action', 'FontSize', 12, 'Units', 'pixels', 'Position', [RightPartHorizontalStart BottomPartVerticalStart RightPartWidth RightPartHeight]);
    
    % CellPanel definition
    HU256PANELHANDLES.CellGrp=uibuttongroup('Units', 'pixels', 'Position', [LeftPartHorizontalStart TopPartVerticalStart LeftPartWidth TopPartHeight-CharactersHeight]); %'toto=source');
    HU256PANELHANDLES.CassiopeeButton=uicontrol(HU256PANELHANDLES.CellGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'Cassiopee', 'Units', 'pixels', 'Position', [10 70 70 30]);
    HU256PANELHANDLES.PleiadesButton=uicontrol(HU256PANELHANDLES.CellGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'Pleiades', 'Units', 'pixels', 'Position', [10 40 70 30]);
    HU256PANELHANDLES.AntaresButton=uicontrol(HU256PANELHANDLES.CellGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'Antares', 'Units', 'pixels', 'Position', [10 10 70 30]);
    set(HU256PANELHANDLES.CellGrp, 'SelectionChangeFcn', @HU256_ChangeCell, 'SelectedObject', []);
    
    % ModePanel definition
    HU256PANELHANDLES.ModeGrp=uibuttongroup('Units', 'pixels', 'Position', [LeftPartHorizontalStart BottomPartVerticalStart LeftPartWidth BottomPartHeight-CharactersHeight]);
    HU256PANELHANDLES.LHButton=uicontrol(HU256PANELHANDLES.ModeGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'LH', 'Units', 'pixels', 'Position', [10 130 70 30]);
    HU256PANELHANDLES.LVButton=uicontrol(HU256PANELHANDLES.ModeGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'LV', 'Units', 'pixels', 'Position', [10 100 70 30]);
    HU256PANELHANDLES.AHButton=uicontrol(HU256PANELHANDLES.ModeGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'AH', 'Units', 'pixels', 'Position', [10 70 70 30]);
    HU256PANELHANDLES.AVButton=uicontrol(HU256PANELHANDLES.ModeGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'AV', 'Units', 'pixels', 'Position', [10 40 70 30]);
    HU256PANELHANDLES.HelButton=uicontrol(HU256PANELHANDLES.ModeGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'Helical', 'Units', 'pixels', 'Position', [10 10 70 30]);
    set(HU256PANELHANDLES.ModeGrp, 'SelectionChangeFcn', @HU256_ChangeMode, 'SelectedObject', []);
    
    % CorrectionPanel definition
%     HU256PANELHANDLES.CorrectionCheckbox=uicontrol(HU256PANELHANDLES.CorrectionPanel,  'BackgroundColor', 'b', 'Style', 'checkbox', 'Position', [10, 150, 450, 30], 'Value', 0, 'String', 'Directory of tables to apply correction', 'CallBack', @HU256_CorrectionCheckbox);
    HU256PANELHANDLES.CorrectionDirectoryText=uicontrol(HU256PANELHANDLES.CorrectionPanel, 'Style', 'edit', 'Position', [10, 120, 450, 30], 'BackgroundColor', [1 1 1], 'Enable', 'on', 'CallBack', @HU256_CorrectionDirectoryText, 'ButtonDownFcn', @HU256_CorrectionDirectoryTextClick, 'String', HU256PANELVALUES.StartPathForApplyingCorrection);
    HU256PANELHANDLES.CorrectionDirectoryButton=uicontrol(HU256PANELHANDLES.CorrectionPanel, 'Style', 'pushbutton', 'Position', [460, 120, 30, 30], 'CallBack', @HU256_CorrectionDirectoryButton);
    HU256PANELHANDLES.CorrectionCheckbox=uicontrol(HU256PANELHANDLES.CorrectionPanel, 'Style', 'checkbox', 'Position', [520, 150, 100, 30], 'Value', 0, 'String', 'Correction', 'Callback', @HU256_CorrectionCheckbox);
    HU256PANELHANDLES.CorrectionSuffixText=uicontrol(HU256PANELHANDLES.CorrectionPanel, 'Style', 'edit', 'Position', [520, 120, 100, 30], 'BackgroundColor', [1 1 1], 'Enable', 'off', 'CallBack', @HU256_CorrectionSuffixText); %, 'ButtonDownFcn', @HU256_CorrectionSuffixTextClick);
    HU256PANELHANDLES.CorrectionCheckList=uicontrol(HU256PANELHANDLES.CorrectionPanel, 'Style', 'text', 'Position', [650, 5, 330, TopPartHeight-20], 'BackgroundColor', 'w', 'String', 'tata');
    HU256_CorrectionDirectoryText(HU256PANELHANDLES.CorrectionDirectoryText, 1);
    HU256_CorrectionCheckbox(HU256PANELHANDLES.CorrectionCheckbox, 1);

    % TablePanel definition
    HU256PANELHANDLES.AcquisitionCheckbox=uicontrol(HU256PANELHANDLES.TablePanel, 'Style', 'checkbox', 'Position', [10, 150, 450, 30], 'Value', 0, 'String', 'Orbits acquisitions', 'CallBack', @HU256_AcquisitionCheckbox);
    HU256PANELHANDLES.AcquisitionDirectoryText=uicontrol(HU256PANELHANDLES.TablePanel, 'Style', 'edit', 'Position', [10, 120, 450, 30], 'BackgroundColor', [1 1 1], 'Enable', 'on', 'CallBack', @HU256_AcquisitionDirectoryText, 'ButtonDownFcn', @HU256_AcquisitionDirectoryTextClick, 'String', HU256PANELVALUES.StartPathForBuildingCorrection);
    HU256PANELHANDLES.AcquisitionDirectoryButton=uicontrol(HU256PANELHANDLES.TablePanel, 'Style', 'pushbutton', 'Position', [460, 120, 30, 30], 'CallBack', @HU256_AcquisitionDirectoryButton);
    HU256PANELHANDLES.TableSuffixCheckbox=uicontrol(HU256PANELHANDLES.TablePanel, 'Style', 'checkbox', 'Position', [520, 150, 100, 30], 'Value', 0, 'String', 'Building tables', 'Callback', @HU256_TableSuffixCheckbox);
    HU256PANELHANDLES.TableSuffixText=uicontrol(HU256PANELHANDLES.TablePanel, 'Style', 'edit', 'Position', [520, 120, 100, 30], 'BackgroundColor', [1 1 1], 'Enable', 'off', 'CallBack', @HU256_TableSuffixText, 'ButtonDownFcn', @HU256_TableSuffixTextClick);
    HU256PANELHANDLES.TableCheckList=uicontrol(HU256PANELHANDLES.TablePanel, 'Style', 'text', 'Position', [650, 5, 330, TopPartHeight-20], 'BackgroundColor', 'w', 'String', 'tata\r\ntoto');
    HU256_AcquisitionDirectoryText(HU256PANELHANDLES.AcquisitionDirectoryText, 1);
    HU256_AcquisitionCheckbox(HU256PANELHANDLES.AcquisitionCheckbox, 1);
    HU256_TableSuffixCheckbox(HU256PANELHANDLES.TableSuffixCheckbox, 1);
    

%     HU256PANELHANDLES.HelSelection=uicontrol(HU256PANELHANDLES.ActionPanel, 

    HU256PANELHANDLES.ActionPanel=uipanel(HU256PANELHANDLES.Fig, 'Title', 'Action', 'FontSize', 12, 'Units', 'pixels', 'Position', [RightPartHorizontalStart BottomPartVerticalStart RightPartWidth BottomPartHeight]);
    HU256PANELHANDLES.HelSelectionGrp=uibuttongroup('Visible', 'off', 'BorderType', 'etchedin', 'Units', 'pixels', 'Position', [RightPartHorizontalStart TopPartVerticalStart LeftPartWidth TopPartHeight]);
%     HU256PANELHANDLES.HelSelectionGrp=uibuttongroup('BorderType', 'etchedin', 'Units', 'pixels', 'Position', [RightPartHorizontalStart BottomPartVerticalStart RightPartWidth BottomPartHeight]);
    HU256PANELHANDLES.InitButton=uicontrol(HU256PANELHANDLES.HelSelectionGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'Init', 'Units', 'pixels', 'Position', [10 130 70 30]);
    HU256PANELHANDLES.BzButton=uicontrol(HU256PANELHANDLES.HelSelectionGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'Bz', 'Units', 'pixels', 'Position', [10 100 70 30]);
    HU256PANELHANDLES.BxButton=uicontrol(HU256PANELHANDLES.HelSelectionGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'Bx', 'Units', 'pixels', 'Position', [10 70 70 30]);
    HU256PANELHANDLES.MaxButton=uicontrol(HU256PANELHANDLES.HelSelectionGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'Max', 'Units', 'pixels', 'Position', [10 40 70 30]);
    HU256PANELHANDLES.OffButton=uicontrol(HU256PANELHANDLES.HelSelectionGrp, 'Style', 'radiobutton', 'SelectionHighlight', 'off', 'String', 'Off', 'Units', 'pixels', 'Position', [10 10 70 30]);
    set(HU256PANELHANDLES.HelSelectionGrp, 'SelectionChangeFcn', @HU256_ChangeHelSelection, 'SelectedObject', []);
    HU256PANELHANDLES.GoButton=uicontrol(HU256PANELHANDLES.ActionPanel, 'Style', 'PushButton', 'String', 'Go!', 'Units', 'pixels', 'Position', [10, 10, 80, 60], 'CallBack', @HU256_Go);
% HU256PANELHANDLES.GoButton=uicontrol(HU256PANELHANDLES.HelSelectionGrp, 'Style', 'PushButton', 'String', 'Go!', 'Units', 'pixels', 'Position', [10, 10, 80, 60], 'CallBack', @HU256_Go);
%     HU256PANELHANDLES.HelSelectionGrp=uibuttongroup('BorderType', 'etchedin', 'Units', 'pixels', 'Position', [RightPartHorizontalStart TopPartVerticalStart LeftPartWidth TopPartHeight-CharactersHeight]); %'toto=source');
end




%% Cell Panel functions
function HU256_ChangeCell(source, eventdata)
    global HU256PANELHANDLES;
    global HU256PANELVALUES;

    CellHandle=eventdata.NewValue;
    if (CellHandle==HU256PANELHANDLES.CassiopeeButton)
        HU256PANELVALUES.Cell=15;
        HU256PANELVALUES.Beamline='Cassioper';
    elseif (CellHandle==HU256PANELHANDLES.PleiadesButton)
        HU256PANELVALUES.Cell=4;
        HU256PANELVALUES.Beamline='Pleillade';
    elseif (CellHandle==HU256PANELHANDLES.AntaresButton)
        HU256PANELVALUES.Cell=12;
        HU256PANELVALUES.Beamline='Antaresse';
    end
end

%% Mode Panel functions
function HU256_ChangeMode(source, eventdata)
    global HU256PANELHANDLES;
    global HU256PANELVALUES;

    ModeHandle=eventdata.NewValue;
    if (ModeHandle==HU256PANELHANDLES.LHButton)
        set (HU256PANELHANDLES.HelSelectionGrp, 'Visible', 'off');
        HU256PANELVALUES.PowerSupply='bz';
        HU256PANELVALUES.Aperiodic=0;
    elseif (ModeHandle==HU256PANELHANDLES.LVButton)
        set (HU256PANELHANDLES.HelSelectionGrp, 'Visible', 'off');
        HU256PANELVALUES.PowerSupply='bx';
        HU256PANELVALUES.Aperiodic=0;
    elseif (ModeHandle==HU256PANELHANDLES.AHButton)
        set (HU256PANELHANDLES.HelSelectionGrp, 'Visible', 'off');
        HU256PANELVALUES.PowerSupply='bz';
        HU256PANELVALUES.Aperiodic=1;
	elseif (ModeHandle==HU256PANELHANDLES.AVButton)
        set (HU256PANELHANDLES.HelSelectionGrp, 'Visible', 'off');
        HU256PANELVALUES.PowerSupply='bx';
        HU256PANELVALUES.Aperiodic=1;
    elseif (ModeHandle==HU256PANELHANDLES.HelButton)
        set (HU256PANELHANDLES.HelSelectionGrp, 'Visible', 'on', 'SelectedObject', HU256PANELHANDLES.InitButton);
%         HU256_ChangeHelSelection(HU256PANELHANDLES.HelSelectionGrp, 1)
        HU256PANELVALUES.PowerSupply='inithel';
        HU256PANELVALUES.Aperiodic='hel';
    end
end

%% Correction Panel functions
function HU256_CorrectionCheckbox(source, eventdata)
    global HU256PANELVALUES;
    global HU256PANELHANDLES;
    HU256PANELVALUES.Correction=get(source, 'Value');
end

function HU256_CorrectionDirectoryText(source, eventdata)
    global HU256PANELVALUES;
    global HU256PANELHANDLES;
    TempDirectory=get(source, 'String');
    TempIsDir=isdir(TempDirectory);
    if (TempIsDir==1) %HU256PANELVALUES.Temp==1)
        HU256PANELVALUES.CorrectionDirectory=TempDirectory;
        set(HU256PANELHANDLES.CorrectionDirectoryText, 'BackgroundColor', 'g');
        set(HU256PANELHANDLES.CorrectionCheckbox, 'Enable', 'on', 'Value', 1);
        HU256PANELVALUES.Correction=1;
        set (HU256PANELHANDLES.CorrectionSuffixText, 'Enable', 'on');
    else
        set (HU256PANELHANDLES.CorrectionCheckbox, 'Enable', 'off', 'Value', 0);
        set (HU256PANELHANDLES.CorrectionDirectoryText, 'BackgroundColor', 'r');
        HU256PANELVALUES.CorrectionDirectory='';
        HU256PANELVALUES.Correction=0;
        set (HU256PANELHANDLES.CorrectionCheckbox, 'Value', 0, 'Enable', 'off');
        set (HU256PANELHANDLES.CorrectionSuffixText, 'Enable', 'off');
    end
    HU256_CorrectionCheckListUpdate()
end

function HU256_CorrectionDirectoryTextClick(source, eventdata)
    global HU256PANELVALUES;
    global HU256PANELHANDLES;
    set (HU256PANELHANDLES.CorrectionCheckbox, 'Value', 1);
    HU256PANELVALUES.Correction=1;
    set (HU256PANELHANDLES.CorrectionDirectoryText, 'Enable', 'on');
end

% function HU256_CorrectionDirectoryButton(source, eventdata)
%     global HU256PANELVALUES;
%     global HU256PANELHANDLES;
%     Temp=uigetdir(HU256PANELVALUES.StartPathForApplyingCorrection, 'Choose the directory where correction tables are stored');
%     if (isa(Temp, 'numeric')==1&&Temp==0)
%         return
%     else
%         HU256PANELVALUES.CorrectionDirectory=Temp;
%         set(HU256PANELHANDLES.CorrectionDirectoryText, 'Enable', 'on');
%         set (HU256PANELHANDLES.CorrectionDirectoryText, 'String', HU256PANELVALUES.CorrectionDirectory);
%         set(HU256PANELHANDLES.CorrectionCheckbox, 'Value', 1);
%         HU256PANELVALUES.Correction=1;
%     end
% end

function HU256_CorrectionDirectoryButton(source, eventdata)
    global HU256PANELVALUES;
    global HU256PANELHANDLES;
    Temp=uigetdir(HU256PANELVALUES.StartPathForApplyingCorrection, 'Choose the directory where correction tables are stored');
    if (isa(Temp, 'numeric')==1&&Temp==0)
        return
    else
        set (HU256PANELHANDLES.CorrectionDirectoryText, 'String', Temp);
        HU256_CorrectionDirectoryText(HU256PANELHANDLES.CorrectionDirectoryText, eventdata)
    end
end

function HU256_CorrectionSuffixText(source, eventdata)
    global HU256PANELVALUES;
    global HU256PANELHANDLES;
    HU256PANELVALUES.CorrectionSuffix=get(source, 'String');
    set(HU256PANELHANDLES.CorrectionCheckbox, 'Value', 1);
    HU256PANELVALUES.Correction=1;
    HU256_CorrectionCheckListUpdate()
end
% function HU256_CorrectionSuffixTextClick(source, eventdata)
%     fprintf ('***HU256_CorrectionSuffixTextClick***\n')
%     global HU256PANELVALUES;
%     global HU256PANELHANDLES;
%           set (HU256PANELHANDLES.CorrectionDirectoryText, 'Enable', 'on');
%     set (HU256PANELHANDLES.CorrectionCheckbox, 'Value', 1);
%     HU256PANELVALUES.Correction=1;
%     set (HU256PANELHANDLES.CorrectionSuffixText, 'Enable', 'on');
    
%     if (isdir(HU256PANELVALUES.CorrectionDirectory)==0);
%         HU256_CorrectionDirectoryButton;
%     end
% end

function HU256_CorrectionCheckListUpdate()
    global HU256PANELVALUES;
    global HU256PANELHANDLES;
    TempCell=HU256_GlobalCheckOfHelTables(HU256PANELVALUES.CorrectionDirectory, HU256PANELVALUES.CorrectionSuffix, 0);
    TempString=textwrap(HU256PANELHANDLES.CorrectionCheckList, TempCell);
    set(HU256PANELHANDLES.CorrectionCheckList, 'String', TempString);
end

%% Table Panel functions

function HU256_AcquisitionCheckbox(source, eventdata)
    global HU256PANELVALUES;
    global HU256PANELHANDLES;
    HU256PANELVALUES.Acquisition=get(source, 'Value');
    if (HU256PANELVALUES.Acquisition==1)
%         set(HU256PANELHANDLES.AcquisitionDirectoryText, 'Enable', 'on');
        set (HU256PANELHANDLES.TableSuffixCheckbox, 'Enable', 'on', 'Value', 0);
        set (HU256PANELHANDLES.TableSuffixText, 'Enable', 'on');
    else
        set (HU256PANELHANDLES.TableSuffixCheckbox, 'Enable', 'off', 'Value', 0);
        set (HU256PANELHANDLES.TableSuffixText, 'Enable', 'off');
    end
    HU256PANELVALUES.Table=0;
end

function HU256_AcquisitionDirectoryTextClick(source, eventdata)
    fprintf ('***HU256_AcquisitionDirectoryTextClick***\n')
end

function HU256_AcquisitionDirectoryText(source, eventdata)
    global HU256PANELVALUES;
    global HU256PANELHANDLES;
    TempDirectory=get(source, 'String');
    TempIsDir=isdir(TempDirectory);
    if (TempIsDir==1)
        set(HU256PANELHANDLES.AcquisitionDirectoryText, 'BackgroundColor', 'g');
        set(HU256PANELHANDLES.AcquisitionCheckbox, 'Enable', 'on', 'Value', 1);
        HU256PANELVALUES.Acquisition=1;
        HU256PANELVALUES.AcquisitionDirectory=TempDirectory;
        set (HU256PANELHANDLES.TableSuffixCheckbox, 'Enable', 'on');
        set (HU256PANELHANDLES.TableSuffixText, 'Enable', 'on');
    else
        set (HU256PANELHANDLES.AcquisitionCheckbox, 'Enable', 'off', 'Value', 0);
        set (HU256PANELHANDLES.AcquisitionDirectoryText, 'BackgroundColor', 'r');
        HU256PANELVALUES.Aquisition=0;
        HU256PANELVALUES.Table=0;
        HU256PANELVALUES.AcquisitionDirectory='';
        set (HU256PANELHANDLES.TableSuffixText, 'Enable', 'off');
        set (HU256PANELHANDLES.TableSuffixCheckbox, 'Enable', 'off', 'Value', 0);
    end
    HU256_TableCheckListUpdate()
end

function HU256_AcquisitionDirectoryButton(source, eventdata)
    global HU256PANELVALUES;
    global HU256PANELHANDLES;
    Temp=uigetdir(HU256PANELVALUES.StartPathForBuildingCorrection, 'Choose the directory where correction tables are stored');
    if (isa(Temp, 'numeric')==1&&Temp==0)
        return
    else
        set (HU256PANELHANDLES.AcquisitionDirectoryText, 'String', Temp);
        HU256_AcquisitionDirectoryText(HU256PANELHANDLES.AcquisitionDirectoryText, eventdata)
    end
end

function HU256_TableSuffixCheckbox(source, eventdata)
    global HU256PANELVALUES;
    global HU256PANELHANDLES;
    Temp=get(source, 'Value');
    if (Temp==1)
        HU256PANELVALUES.Table=1;
    else
        HU256PANELVALUES.Table=0;
    end
end

function HU256_TableSuffixText(source, eventdata)
    global HU256PANELVALUES;
    global HU256PANELHANDLES;
    set (HU256PANELHANDLES.TableSuffixCheckbox, 'Enable', 'on', 'Value', 1);
    HU256PANELVALUES.Table=1;
    HU256PANELVALUES.TableSuffix=get(source, 'String');
    HU256_TableCheckListUpdate()
end

function HU256_TableCheckListUpdate()
    global HU256PANELVALUES;
    global HU256PANELHANDLES;
    TempCell=HU256_GlobalCheckOfHelTables(HU256PANELVALUES.AcquisitionDirectory, HU256PANELVALUES.TableSuffix, 0);
    TempString=textwrap(HU256PANELHANDLES.TableCheckList, TempCell);
    set(HU256PANELHANDLES.TableCheckList, 'String', TempString);
end
    
%     %% METTRE A JOUR
%     TempCell=HU256_CheckListOfTables(HU256PANELVALUES.AcquisitionDirectory, HU256PANELVALUES.TableSuffix);
%     TempString=textwrap(HU256PANELHANDLES.CorrectionCheckList, TempCell);
%     set(HU256PANELHANDLES.CorrectionCheckList, 'String', TempString);
% end

%% Action Panel Functions
function HU256_ChangeHelSelection(source, eventdata)
    global HU256PANELHANDLES;
    global HU256PANELVALUES;

    HelHandle=eventdata.NewValue;
    if (HelHandle==HU256PANELHANDLES.InitButton)
%         set (HU256PANELHANDLES.HelSelectionGrp, 'Visible', 'off');
        HU256PANELVALUES.PowerSupply='inithel';
%         HU256PANELVALUES.Aperiodic=0;
    elseif (HelHandle==HU256PANELHANDLES.BzButton)
%         set (HU256PANELHANDLES.HelSelectionGrp, 'Visible', 'off');
        HU256PANELVALUES.PowerSupply='bz';
%         HU256PANELVALUES.Aperiodic=0;
    elseif (HelHandle==HU256PANELHANDLES.BxButton)
%         set (HU256PANELHANDLES.HelSelectionGrp, 'Visible', 'off');
        HU256PANELVALUES.PowerSupply='bx';
%         HU256PANELVALUES.Aperiodic=1;
	elseif (HelHandle==HU256PANELHANDLES.MaxButton)
%         set (HU256PANELHANDLES.HelSelectionGrp, 'Visible', 'off');
        HU256PANELVALUES.PowerSupply='max';
%         HU256PANELVALUES.Aperiodic=1;
    elseif (HelHandle==HU256PANELHANDLES.OffButton)
%         set (HU256PANELHANDLES.HelSelectionGrp, 'Visible', 'on');
        HU256PANELVALUES.PowerSupply='off';
%         HU256PANELVALUES.Aperiodic='hel';
    end
end
%% Go Function
function HU256_Go(source, event)
    global HU256PANELHANDLES;
    global HU256PANELVALUES;
    
    if (isempty(get(HU256PANELHANDLES.CellGrp, 'SelectedObject'))==1)
        fprintf('You must select a Cell!\n')
        return
    end
    if (isempty(get(HU256PANELHANDLES.ModeGrp, 'SelectedObject'))==1)
        fprintf('You must select a Polarisation Mode!\n')
        return
    end
%     fprintf('Cellule : %1.0f\n', HU256PANELVALUES.Cell);
%     fprintf('Power Supply : %s\n', HU256PANELVALUES.PowerSupply);
%     if (isa(HU256PANELVALUES.Aperiodic, 'numeric')==1)
%         fprintf('Aperiodic : %1.0f\n', HU256PANELVALUES.Aperiodic);
%     elseif (isa(HU256PANELVALUES.Aperiodic, 'char')==1)
%         fprintf('Aperiodic : %s\n', HU256PANELVALUES.Aperiodic);
%     end
%     if (HU256PANELVALUES.Correction==1)
        CorrectionDirectory=HU256PANELVALUES.CorrectionDirectory;
%     else
%         CorrectionDirectory='''''';
%     end
%     if (HU256PANELVALUES.Correction==1)
%         CorrectionSuffix=HU256PANELVALUES.CorrectionSuffix
%     else
%         CorrectionSuffix=0
%     end
%     global toto
%     HU256PANELVALUES.Aperiodic
    if (isa(HU256PANELVALUES.Aperiodic, 'char')==1)
        AperiodicText='''%s''';
    else
        AperiodicText='%1.0f';
    end
    if (HU256PANELVALUES.Correction==1)
        CorrectionSuffixText='''%s''';
        CorrectionSuffix=HU256PANELVALUES.CorrectionSuffix; 
    else
        CorrectionSuffixText='%1.0f';
        CorrectionSuffix=HU256PANELVALUES.Correction;
    end
    if (HU256PANELVALUES.Acquisition==1)
        AcquisitionDirectory=HU256PANELVALUES.AcquisitionDirectory;
    else
        AcquisitionDirectory='';
    end
    if (HU256PANELVALUES.Table==1)
        TableSuffixText='''%s''';
        TableSuffix=HU256PANELVALUES.TableSuffix; 
    else
        TableSuffixText='%1.0f';
        TableSuffix=HU256PANELVALUES.Table;
    end


    set(HU256PANELHANDLES.GoButton, 'Enable', 'off');
    CommandString=sprintf('HU256_TotalCycling(%%1.0f, ''%%s'', %s, ''%%s'', %s, ''%%s'', %s)\n', AperiodicText, CorrectionSuffixText, TableSuffixText);
    fprintf(CommandString, HU256PANELVALUES.Cell, HU256PANELVALUES.PowerSupply, HU256PANELVALUES.Aperiodic, HU256PANELVALUES.CorrectionDirectory, CorrectionSuffix, AcquisitionDirectory, TableSuffix)
    toto=HU256_TotalCycling(HU256PANELVALUES.Cell, HU256PANELVALUES.PowerSupply, HU256PANELVALUES.Aperiodic, HU256PANELVALUES.CorrectionDirectory, CorrectionSuffix, AcquisitionDirectory, TableSuffix, 1);
    if (toto~=1)
        fprintf('**** ERREUR AVEC TOTAL CYCLING ****\n');
    end
%     TextCell{1}='Cyclage terminé';
%     TextChar='Cyclage terminé';
%     write_attribute('ans/ca/texttalker.2/text_to_talk', 'fabien ');
%     tango_command_inout2('ans/ca/texttalker.2', 'DevTalk', 'DevRun');    
    if (strcmp(HU256PANELVALUES.PowerSupply, 'bz')==1)
        tango_command_inout2('ans/ca/texttalker.2', 'DevTalk', sprintf('Cyclage terminer sur HU256 %s', HU256PANELVALUES.Beamline));
    end
    set(HU256PANELHANDLES.GoButton, 'Enable', 'on');
    HU256_CorrectionCheckListUpdate();
    HU256_TableCheckListUpdate();

end

