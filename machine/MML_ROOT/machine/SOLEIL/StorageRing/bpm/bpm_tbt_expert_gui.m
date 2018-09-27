function varargout = bpm_tbt_expert_gui(varargin)
% BPM_TBT_EXPERT_GUI M-file for bpm_tbt_expert_gui.fig
%      BPM_TBT_EXPERT_GUI, by itself, creates a new BPM_TBT_EXPERT_GUI or raises the existing
%      singleton*.
%
%      H = BPM_TBT_EXPERT_GUI returns the handle to a new BPM_TBT_EXPERT_GUI or the handle to
%      the existing singleton*.
%
%      BPM_TBT_EXPERT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BPM_TBT_EXPERT_GUI.M with the given edit_inputsignal arguments.
%
%      BPM_TBT_EXPERT_GUI('Property','Value',...) creates a new BPM_TBT_EXPERT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bpm_tbt_expert_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bpm_tbt_expert_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help bpm_tbt_expert_gui
% Last Modified by GUIDE v2.5 30-Sep-2013 11:30:12
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @bpm_tbt_expert_gui_OpeningFcn, ...
    'gui_OutputFcn',  @bpm_tbt_expert_gui_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% Written by  B. B�ranger, Master 2013


% --- Executes just before bpm_tbt_expert_gui is made visible.
function bpm_tbt_expert_gui_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<*INUSL>

% Choose default command line output for bpm_tbt_expert_gui
handles.output = hObject;

% --- Move the GUI to the center of the screen ---
movegui('center')

% Get AcceleratorObjects to know if Mode is 'Online', and then save the
% Offset structure, then make visible the GetOnlineData button
AO = getfamilydata('BPMx');
if strcmp(AO.Monitor.Mode,'Online')
    set(handles.pushbutton_GetOnlineData,'Visible','on')
    set(handles.text_OR_1,'Visible','on')
end

% Try to load filters file if it exists in the directory
if exist('TbT_Filters_27_05_2013.mat','file')
    FilterFileName = 'TbT_Filters_27_05_2013';
    load(FilterFileName)
    handles.FilterStructure = eval(FilterFileName);
    set(handles.text_Echo,'String',...
        sprintf('%s filter file loaded \nSelect Input data',FilterFileName)); % Main Echo
    set(handles.text_SelectedFilter,'String',sprintf('%s',FilterFileName)); % Echo for filter
end

% Set default values for the mesh and the rebuilding function
set(handles.edit_HorizontalMesh,'String',65)
set(handles.edit_ObliqueMesh,'String',30)
set(handles.edit_VerticaleMesh,'String',5)
set(handles.edit_MaxIteration,'String',50)
set(handles.edit_Tolerance,'String',1e-6)

% In rebuilt module, preselect _IQ_exp_rebuilt
set(handles.uipanel_ModeSelection,'SelectedObject',handles.radiobutton_DemixBefore)
pushbutton_UpdateListbox_Callback(hObject, eventdata, handles)
set(handles.listbox_Signal,'Value',5)

% --- Update handles structure ---
guidata(hObject, handles);

function varargout = bpm_tbt_expert_gui_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;


% --- Executes when selected object is changed in uipanel_ModeSelection.
function uipanel_ModeSelection_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_ModeSelection 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

pushbutton_UpdateListbox_Callback(hObject, eventdata, handles)

guidata(hObject, handles)


function pushbutton_Save_Callback(hObject, eventdata, handles)

if isfield(handles,'InputStructure')
    
    getbpmrawdata_OutputStructure= handles.InputStructure; %#ok<NASGU>
    
    % --- Selection file name in the UISave Box ---
    uisave('getbpmrawdata_OutputStructure')
    
    set(handles.text_Echo,'String',...
        sprintf('User saved current input data where : \nTimeStamp is : %s',handles.InputStructure.TimeStamp)); % Echo
    
else
    
    set(handles.text_Echo,'String',sprintf('Enter input data before saving it')); % Echo
    
end

guidata(hObject, handles)


function pushbutton_GetOnlineData_Callback(hObject, eventdata, handles)

% Get online data
handles.InputStructure = getbpmrawdata([],'DD','alldata','struct');

% --- Display in the listbox BPM_List all the available BPM
set(handles.listbox_BPM_List,'String',handles.InputStructure.DeviceName(:));

set(handles.text_SelectedInput,'String',...
    sprintf('%s',handles.InputStructure.TimeStamp)); % Echo for input

set(handles.text_Echo,'String',...
    sprintf('Online data stored as input \nTimeStamp is : %s',handles.InputStructure.TimeStamp)); % Main Echo

guidata(hObject, handles)


function pushbutton_SelectStructureFromWorkspace_Callback(hObject, eventdata, handles)

% --- Run a GUI gathering workspace variables ---
uiworkspace;
waitfor(uiworkspace);

% --- Flags comming from uiworkspace ---
InputFlag = evalin('base','InputStructureFlag');
FilterFlag = evalin('base','FilterStructureFlag');

if InputFlag == 1
    % --- Using structure in workspace for the input ---
    handles.InputStructure = evalin('base','InputStructure');
    evalin('base','clear InputStructure');
    handles.InputName = evalin('base','InputName');
    evalin('base','clear InputName');
    handles.Data = handles.InputStructure.Data;
    set(handles.text_SelectedInput,'String',sprintf('%s',handles.InputName)); % Echo for input
    evalin('base','clear InputStructureFlag');
    % --- Display in the listbox BPM_List all the available BPM
    set(handles.listbox_BPM_List,'String',handles.InputStructure.DeviceName(:));
else
    evalin('base','clear InputStructureFlag');
end

if FilterFlag == 1
    % --- Using structure in workspace for the filter ---
    handles.FilterStructure = evalin('base','FilterStructure');
    evalin('base','clear FilterStructure');
    handles.FilterName = evalin('base','FilterName');
    evalin('base','clear FilterName');
    set(handles.text_SelectedFilter,'String',sprintf('%s',handles.FilterName)); % Echo for filter
    evalin('base','clear FilterStructureFlag');
else
    evalin('base','clear FilterStructureFlag');
end

guidata(hObject, handles);


function pushbutton_ApplyFilters_Callback(hObject, eventdata, handles) %#ok<*DEFNU>

set(handles.text_Echo,'String','Start of demixing function ( bpm_tbt_demixing ) '); % Echo
pause(0.1);

if isfield(handles,'InputStructure')
    
    % --- Using bpm_tbt_demixing ---
    handles.Filtered_bpm_data = bpm_tbt_demixing('InputStructure', handles.InputStructure, 'FilterStructure', handles.FilterStructure);
    
    
    % --- Display in the listbox BPM_List all the available BPM
    set(handles.listbox_BPM_List,'String',handles.InputStructure.DeviceName(:));
    
    % --- Display in axes_FilterPlots the simulated filter ---
    cla (handles.axes_FilterPlots,'reset');
    hold(handles.axes_FilterPlots,'all');
    plot(handles.axes_FilterPlots,handles.FilterStructure.SimulatedFilter(:),'-k');
    legend(handles.axes_FilterPlots,'Simulated filter')
    
    set(handles.text_Echo,'String',sprintf('Computation done \nSimulated filter ploted')); % Echo
    
else
    
    set(handles.text_Echo,'String',sprintf('Input data are required before Applying Filters ')); % Echo
    
end

guidata(hObject, handles);


function pushbutton_PlotFilters_Callback(hObject, eventdata, handles)

if isfield(handles,'Filtered_bpm_data')
    
    % --- Getting which device is selected in the listbox_BPM_List ---
    SelectedBPM_Number = get(handles.listbox_BPM_List,'Value');
    ListBPM = get(handles.listbox_BPM_List,'String');
    SelectedBPM_Name = ListBPM{SelectedBPM_Number};
    
    cla (handles.axes_FilterPlots,'reset');
    
    % --- Display in axes_FilterPlots the simulated filter and the selected BPM filter ---
    hold(handles.axes_FilterPlots,'all');
    plot(handles.axes_FilterPlots,handles.FilterStructure.SimulatedFilter(:),'-k');
    
    if handles.Filtered_bpm_data.DeviceAssociationList(SelectedBPM_Number,2) ~= 0 % Filter found
        
        plot(handles.axes_FilterPlots,handles.FilterStructure.DeviceExperimentalFilters(handles.Filtered_bpm_data.DeviceAssociationList(SelectedBPM_Number,2),:),'-r');
        xlim([1 length(handles.FilterStructure.SimulatedFilter)]);
        ylim([min([handles.FilterStructure.SimulatedFilter handles.FilterStructure.DeviceExperimentalFilters(handles.Filtered_bpm_data.DeviceAssociationList(SelectedBPM_Number,2),:)])...
            max([handles.FilterStructure.SimulatedFilter handles.FilterStructure.DeviceExperimentalFilters(handles.Filtered_bpm_data.DeviceAssociationList(SelectedBPM_Number,2),:)])*1.5]);
        legend(handles.axes_FilterPlots,'Simulated filter',sprintf('%s filter',SelectedBPM_Name));

        if ~isnan(handles.Filtered_bpm_data.DeviceAssociationList(SelectedBPM_Number,3)) % Offsets found
            set(handles.text_Echo,'String',sprintf('Plot BPM filter : %s \nPlot simulated filter \nOffsets found',SelectedBPM_Name));
        else % No offset found
            set(handles.text_Echo,'String',sprintf('Plot BPM filter : %s \nPlot simulated filter \n=== NO Offset found ===',SelectedBPM_Name));
        end
        
    else % No filter found
        
        legend('Simulated filter',handles.axes_FilterPlots);
        set(handles.text_Echo,'String',sprintf('=== No filter found for : %s ===\nPlot simulated filter',SelectedBPM_Name));
        
    end
    
else
    
    set(handles.text_Echo,'String',sprintf('Apply Filters is required before Plot Filters')); % Echo
    
end

guidata(hObject, handles);


function pushbutton_LoadInput_Callback(hObject, eventdata, handles)

% --- Selection of a file in the UIOpenBox ---
[InputFileName, InputFilePath] = uigetfile('*.mat');

if isequal(InputFileName,0)
    set(handles.text_Echo,'String','User selected Cancel'); % Echo for an error
else
    set(handles.text_Echo,'String',sprintf('User selected \n%s\n as Input file', fullfile(InputFilePath, InputFileName))); % Echo
    set(handles.text_SelectedInput,'String',sprintf('%s',InputFileName)); % Echo for filter
    

   % NH 2014-11-06 Try to correct for a bug when loading data from file
   InputStructure=load(fullfile(InputFilePath, InputFileName));
   fieldnamelist=fieldnames(InputStructure);
   %eval(['handles.InputStructure = ' InputStructure(1:end-4) ';']);
   handles.InputStructure = InputStructure.(fieldnamelist{1});
   
    
    % --- Display in the listbox BPM_List all the available BPM
    set(handles.listbox_BPM_List,'String',handles.InputStructure.DeviceName(:));
end

guidata(hObject, handles);


function pushbutton_LoadFilter_Callback(hObject, eventdata, handles)

% --- Selection of a file in the UIOpenBox ---
[FilterStructure, FilterFilePath] = uigetfile('*.mat');

if isequal(FilterStructure,0)
    set(handles.text_Echo,'String','User selected Cancel'); % Echo for an error
else
    set(handles.text_Echo,'String',sprintf('User selected \n%s\n as Filter file', fullfile(FilterFilePath, FilterStructure)));  % Echo
    set(handles.text_SelectedFilter,'String',sprintf('%s',FilterStructure)); % Echo for filter
    load(fullfile(FilterFilePath, FilterStructure)); 
    % NH 2014-11-06 Try to correct for a bug when loading a filter from
    % file
    %eval(['handles.FilterStructure = ' FilterStructure(1:end-4) ';']);
    handles.FilterStructure=FilterStructure;
end

guidata(hObject, handles);


function pushbutton_PlotCheckedSignals_Callback(hObject, eventdata, handles)

if isfield(handles,'Filtered_bpm_data')
    
    % --- Getting which device is selected in the listbox_BPM_List ---
    SelectedBPM_Number = get(handles.listbox_BPM_List,'Value');
    ListBPM = get(handles.listbox_BPM_List,'String');
    SelectedBPM_Name = ListBPM{SelectedBPM_Number};
    
    set(handles.text_Echo,'String',sprintf('%s selected \nPlotting checked signals',SelectedBPM_Name)); % Echo
    
    % --- Assigning colors for each type of signals ---
    RawColor = '-black';
    DirectExpColor = '-green';
    DirectSimColor = '--green';
    RebuiltExpColor = '-blue';
    RebuiltSimColor = '--blue';
    IQExpColor = '-red';
    IQSimColor = '--red';
    
    LineWidth = 2;
    FontSize = 20;
    
    % --- List of all categories of signals available ---
    SignalList = {'X','Z','Sum','Q','Va','Vb','Vc','Vd','Ia','Ib','Ic','Id','Qa','Qb','Qc','Qd'};
    
    % --- Loop for the different signals available ---
    for SignalNumber = 1:length(SignalList)
        if SignalNumber == 1
            SubSignalList = {'X','X_exp','X_sim','X_V_exp','X_V_sim','X_IQ_exp','X_IQ_sim'};
            Y_label = 'Horizontal position';
        elseif SignalNumber == 2
            SubSignalList = {'Z','Z_exp','Z_sim','Z_V_exp','Z_V_sim','Z_IQ_exp','Z_IQ_sim'};
            Y_label = 'Vertical position';
        elseif SignalNumber == 3
            SubSignalList = {'Sum','Sum_exp','Sum_sim'};
            Y_label = 'Sum of potentials';
        elseif SignalNumber == 4
            SubSignalList = {'Q','Q_exp','Q_sim'};
            Y_label = 'Q';
        elseif SignalNumber == 5
            SubSignalList = {'Va','Va_exp','Va_sim','Va_IQ_exp','Va_IQ_sim'};
            Y_label = 'Potential in electrode A';
        elseif SignalNumber == 6
            SubSignalList = {'Vb','Vb_exp','Vb_sim','Vb_IQ_exp','Vb_IQ_sim'};
            Y_label = 'Potential in electrode B';
        elseif SignalNumber == 7
            SubSignalList = {'Vc','Vc_exp','Vc_sim','Vc_IQ_exp','Vc_IQ_sim'};
            Y_label = 'Potential in electrode C';
        elseif SignalNumber == 8
            SubSignalList = {'Vd','Vd_exp','Vd_sim','Vd_IQ_exp','Vd_IQ_sim'};
            Y_label = 'Potential in electrode D';
        elseif SignalNumber == 9
            SubSignalList = {'Ia','Ia_exp','Ia_sim'};
            Y_label = 'In phase component of electrode A';
        elseif SignalNumber == 10
            SubSignalList = {'Ib','Ib_exp','Ib_sim'};
            Y_label = 'In phase component of electrode B';
        elseif SignalNumber == 11
            SubSignalList = {'Ic','Ic_exp','Ic_sim'};
            Y_label = 'In phase component of electrode C';
        elseif SignalNumber == 12
            SubSignalList = {'Id','Id_exp','Id_sim'};
            Y_label = 'In phase component of electrode D';
        elseif SignalNumber == 13
            SubSignalList = {'Qa','Qa_exp','Qa_sim'};
            Y_label = 'Quadrature component of electrode A';
        elseif SignalNumber == 14
            SubSignalList = {'Qb','Qb_exp','Qb_sim'};
            Y_label = 'Quadrature component of electrode B';
        elseif SignalNumber == 15
            SubSignalList = {'Qc','Qc_exp','Qc_sim'};
            Y_label = 'Quadrature component of electrode C';
        elseif SignalNumber == 16
            SubSignalList = {'Qd','Qd_exp','Qd_sim'};
            Y_label = 'Quadrature component of electrode D';
        end
        
        
        % === Plots ===
        DynamicFlagName = genvarname(['Plot_' SignalList{SignalNumber} '_Flag']);
        eval([DynamicFlagName ' = 0;']);
        
        % --- Check if signals are selected in checkboxs ---
        for SubSignal = 1:length(SubSignalList);
            if get(handles.(genvarname(['checkbox_' SubSignalList{SubSignal}])),'Value')==1
                eval([DynamicFlagName ' = 1;']);
            end
        end
        
        % --- If signals are selected in checkboxs... ---
        if eval([DynamicFlagName ' == 1;']);
            
            Legend = {};
            figure('Name',sprintf('Plot %s for %s',SignalList{SignalNumber},SelectedBPM_Name),'NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97]); % One figure per categorie of signal
            hold all;
            count = 0;
            
            % --- Loop for every checked signal (in the checkboxs) ---
            for SubSignal = 1:length(SubSignalList);
                
                if get(handles.(genvarname(['checkbox_' SubSignalList{SubSignal}])),'Value')==1
                    count = count+1;
                    
                    % --- Attribution of a color depending on the category ---
                    if isscalar(regexp(SubSignalList{SubSignal},'_exp'))
                        if isscalar(regexp(SubSignalList{SubSignal},'_V_exp'))
                            Color = RebuiltExpColor;
                        elseif isscalar(regexp(SubSignalList{SubSignal},'_IQ_exp'))
                            Color = IQExpColor;
                        else
                            Color = DirectExpColor;
                        end
                    elseif isscalar(regexp(SubSignalList{SubSignal},'_sim'))
                        if isscalar(regexp(SubSignalList{SubSignal},'_V_sim'))
                            Color = RebuiltSimColor;
                        elseif isscalar(regexp(SubSignalList{SubSignal},'_IQ_sim'))
                            Color = IQSimColor;
                        else
                            Color = DirectSimColor;
                        end
                    else
                        Color = RawColor;
                    end
                    
                    plot(handles.Filtered_bpm_data.Data.(genvarname(SubSignalList{SubSignal}))(handles.Filtered_bpm_data.DeviceAssociationList(SelectedBPM_Number,1),:),Color,'LineWidth',LineWidth)
                    Legend{count} = sprintf('%s',SubSignalList{SubSignal}); %#ok<AGROW>
                    
                end
                
            end
            % --- Optimization of figure ---
            title(sprintf('Plot %s for %s',SignalList{SignalNumber},SelectedBPM_Name),'FontSize',FontSize)
            set(legend(Legend),'Interpreter','none')
            xlabel('Turn','FontSize',FontSize)
            ylabel(Y_label,'FontSize',FontSize)
            set(gca,'FontSize',FontSize)
            removemarge
            %         axis tight
            
        end
        
    end
    
    set(handles.text_Echo,'String',sprintf('%s selected \nChecked signals plotted',SelectedBPM_Name)); % Echo
    
else
    
    set(handles.text_Echo,'String',sprintf('Apply Filters before Plot checked signals')); % Echo
    
end

guidata(hObject, handles);


function pushbutton_UpdateListbox_Callback(hObject, eventdata, handles)

% --- Switch of case depending on the 'Radio button' selected, in order to update the signals available in the listbox_Signal ---
switch get(get(handles.uipanel_ModeSelection,'SelectedObject'),'Tag') % Get Tag of selected object.
    
    case 'radiobutton_NoDemixing'
        set(handles.listbox_Signal,'Value',1)
        set(handles.listbox_Signal,'String','[ X , Z ]')
        
    case 'radiobutton_DemixBefore'
        set(handles.listbox_Signal,'Value',1)
        set(handles.listbox_Signal,'String',...
            {'_exp_rebuilt';'_sim_rebuilt';'_V_exp_rebuilt';'_V_sim_rebuilt';'_IQ_exp_rebuilt';'_IQ_sim_rebuilt'})
        
    case 'radiobutton_RebuildBefore'
        set(handles.listbox_Signal,'Value',1)
        set(handles.listbox_Signal,'String',...
            {'_rebuilt_exp';'_rebuilt_sim'})
        
    otherwise
        error('No mode detected.')
end

guidata(hObject, handles);


function pushbutton_get_bpm_rebuilt_position_expert_Callback(hObject, eventdata, handles)

if isfield(handles,'Filtered_bpm_data')
    
    % --- Generation of the vacuum chamber boundary mesh ---
    handles.MeshStructure = bpm_vacuum_chamber_mesh_generation(...
        'ObliqueMesh',str2double(get(handles.edit_ObliqueMesh,'String')),...
        'VerticalMesh',str2double(get(handles.edit_VerticaleMesh,'String')),...
        'HorizontalMesh',str2double(get(handles.edit_HorizontalMesh,'String')));
    
    set(handles.text_Echo,'String','Mesh generated') % Echo
    pause(0.1)
    
    % --- Which device is selected in the listbox_BPM_List ---
    SelectedBPM_Number = get(handles.listbox_BPM_List,'Value');
    ListBPM = get(handles.listbox_BPM_List,'String');
    SelectedBPM_Name = ListBPM{SelectedBPM_Number};
    
    % --- Get Tag of selected object for switch ---
    switch get(get(handles.uipanel_ModeSelection,'SelectedObject'),'Tag')
        
        case 'radiobutton_NoDemixing'
            
            set(handles.text_Echo,'String','''No demixing'' selected') % Echo
            pause(0.1)
            
            % Rebuilding position directly on the input data
            handles.get_bpm_rebuilt_position_expert_OutputStructure = get_bpm_rebuilt_position_expert(...
                'DataStructure', handles.InputStructure,...
                'MeshStructure',handles.MeshStructure,...
                'MaxIteration', str2double(get(handles.edit_MaxIteration,'String')),...
                'Tolerance',str2double(get(handles.edit_Tolerance,'String')),...
                'DeviceList',SelectedBPM_Number,...
                'Echo',...
                'DD',...
                'SignalName','',...
                'Display');
            
            set(handles.text_Echo,'String',sprintf('Reconstruction of raw [X,Z] position for %s',SelectedBPM_Name)) % Echo
            pause(0.1)
            
            % Rebuilding position after applying the demixing filters
        case 'radiobutton_DemixBefore'
            
            set(handles.text_Echo,'String','Demixing before Rebuilding selected'); % Echo
            pause(0.1);
            
            % --- Getting which signal is selected in the listbox_Signal ---
            SelectedSignal_Number = get(handles.listbox_Signal,'Value');
            ListSignal = get(handles.listbox_Signal,'String');
            SelectedSignal_Name = ListSignal{SelectedSignal_Number};
            SelectedSignal_Name = SelectedSignal_Name(1:end-8);
            
            % --- Rebuild selectred unmixed signals ---
            handles.get_bpm_rebuilt_position_expert_OutputStructure = get_bpm_rebuilt_position_expert(...
                'DataStructure', handles.Filtered_bpm_data,...
                'MeshStructure',handles.MeshStructure,...
                'MaxIteration', str2double(get(handles.edit_MaxIteration,'String')),...
                'Tolerance',str2double(get(handles.edit_Tolerance,'String')),...
                'DeviceList',SelectedBPM_Number,...
                'Echo',...
                'DD',...
                'SignalName',SelectedSignal_Name,...
                'Display');
            
            set(handles.text_Echo,'String',sprintf('[ X%s_rebuilt , Z%s_rebuilt ] position for %s',SelectedSignal_Name,SelectedSignal_Name,SelectedBPM_Name)) % Echo
            pause(0.1)
            
            % Apply demixing filters after rebuilding the position
        case 'radiobutton_RebuildBefore'
            
            set(handles.text_Echo,'String','Rebuilding before Demixing selected') % Echo
            pause(0.1)
            
            FontSize = 20;
            LineWidth = 2;
            
            % --- Getting which signal is selected in the listbox_Signal ---
            SelectedSignal_Number = get(handles.listbox_Signal,'Value');
            ListSignal = get(handles.listbox_Signal,'String');
            SelectedSignal_Name = ListSignal{SelectedSignal_Number};
            SelectedSignal_Name = SelectedSignal_Name(9:end);
            
            % --- Rebuild selected signal ---
            handles.get_bpm_rebuilt_position_expert_OutputStructure = get_bpm_rebuilt_position_expert(...
                'DataStructure', handles.InputStructure,...
                'MeshStructure',handles.MeshStructure,...
                'MaxIteration', str2double(get(handles.edit_MaxIteration,'String')),...
                'Tolerance',str2double(get(handles.edit_Tolerance,'String')),...
                'DeviceList',SelectedBPM_Number,...
                'Echo',...
                'DD',...
                'SignalName','',...
                'NoDisplay');
            
            % --- Use the right structure ---
            InputStructure = handles.InputStructure;
            InputStructure.Data.X(SelectedBPM_Number,:) = handles.get_bpm_rebuilt_position_expert_OutputStructure.X_rebuilt;
            InputStructure.Data.Z(SelectedBPM_Number,:) = handles.get_bpm_rebuilt_position_expert_OutputStructure.Z_rebuilt;
            
            % --- Unmixe the Rebuilt signals ---
            handles.Newton_FilteredBpmData = bpm_tbt_demixing('InputStructure', InputStructure, 'FilterStructure', handles.FilterStructure);
            
            % --- Assign shortcuts ---
            X_raw = handles.Filtered_bpm_data.Data.X(SelectedBPM_Number,:);
            X_read = handles.Filtered_bpm_data.Data.(genvarname(['X' SelectedSignal_Name]))(SelectedBPM_Number,:);
            X_rebuilt = handles.Newton_FilteredBpmData.Data.(genvarname(['X' SelectedSignal_Name]))(SelectedBPM_Number,:);
            Z_raw = handles.Filtered_bpm_data.Data.Z(SelectedBPM_Number,:);
            Z_read = handles.Filtered_bpm_data.Data.(genvarname(['Z' SelectedSignal_Name]))(SelectedBPM_Number,:);
            Z_rebuilt = handles.Newton_FilteredBpmData.Data.(genvarname(['Z' SelectedSignal_Name]))(SelectedBPM_Number,:);
            
            set(handles.text_Echo,'String',sprintf('[ X_rebuilt%s , Z_rebuilt%s ] position for %s',SelectedSignal_Name,SelectedSignal_Name,SelectedBPM_Name)) % Echo
            pause(0.1)
            
            % --- Plot Horizontal position ---
            figure('Name',sprintf('X_rebuilt%s for %s',SelectedSignal_Name,SelectedBPM_Name),'NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97]);
            hold all
            plot(X_raw,'-black','LineWidth',LineWidth)
            plot(X_read,'-blue','LineWidth',LineWidth)
            plot(X_rebuilt,'-red','LineWidth',LineWidth)
            xlabel('Turn','FontSize',FontSize)
            ylabel('Horizontal position','FontSize',FontSize)
            legend('Raw','Rebuilt','Rebuilt-Demixed')
            set(gca,'FontSize',FontSize)
            removemarge
            axis tight
            
            % --- Plot Vertical position ---
            figure('Name',sprintf('Z_rebuilt%s for %s',SelectedSignal_Name,SelectedBPM_Name),'NumberTitle','off','units','normalized','OuterPosition',[0 0.03 1 0.97])
            hold all
            plot(Z_raw,'-black','LineWidth',LineWidth)
            plot(Z_read,'-blue','LineWidth',LineWidth)
            plot(Z_rebuilt,'-red','LineWidth',LineWidth)
            xlabel('Turn','FontSize',FontSize)
            ylabel('Horizontal position','FontSize',FontSize)
            legend('Raw','Rebuilt','Rebuilt-Demixed')
            set(gca,'FontSize',FontSize)
            removemarge
            axis tight
            
        otherwise
            warning('SwitchError:NoCaseDetected','Switch problem')
    end
    
else
    
    set(handles.text_Echo,'String',sprintf('Apply Filters before using the Rebuilding module')); % Echo
    
end

guidata(hObject, handles);



%==========================================================================
% --- Not used functions ---
function listbox_Signal_Callback(hObject, eventdata, handles)
function listbox_Signal_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function listbox_BPM_List_Callback(hObject, eventdata, handles)
function listbox_BPM_List_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu_InputFormatSelection_Callback(hObject, eventdata, handles) %#ok<*INUSD>
function popupmenu_InputFormatSelection_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function popupmenu_FilterFormatSelection_Callback(hObject, eventdata, handles)
function popupmenu_FilterFormatSelection_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function checkbox_X_Callback(hObject, eventdata, handles)
function checkbox_X_exp_Callback(hObject, eventdata, handles)
function checkbox_X_sim_Callback(hObject, eventdata, handles)
function checkbox_X_V_exp_Callback(hObject, eventdata, handles)
function checkbox_Z_Callback(hObject, eventdata, handles)
function checkbox_Z_exp_Callback(hObject, eventdata, handles)
function checkbox_Z_sim_Callback(hObject, eventdata, handles)
function checkbox_Z_V_exp_Callback(hObject, eventdata, handles)
function checkbox_X_V_sim_Callback(hObject, eventdata, handles)
function checkbox_Z_V_sim_Callback(hObject, eventdata, handles)
function checkbox_X_IQ_exp_Callback(hObject, eventdata, handles)
function checkbox_Z_IQ_exp_Callback(hObject, eventdata, handles)
function checkbox_X_IQ_sim_Callback(hObject, eventdata, handles)
function checkbox_Z_IQ_sim_Callback(hObject, eventdata, handles)
function checkbox_Va_Callback(hObject, eventdata, handles)
function checkbox_Vb_Callback(hObject, eventdata, handles)
function checkbox_Vc_Callback(hObject, eventdata, handles)
function checkbox_Vd_Callback(hObject, eventdata, handles)
function checkbox_Va_exp_Callback(hObject, eventdata, handles)
function checkbox_Vb_exp_Callback(hObject, eventdata, handles)
function checkbox_Vc_exp_Callback(hObject, eventdata, handles)
function checkbox_Vd_exp_Callback(hObject, eventdata, handles)
function checkbox_Va_sim_Callback(hObject, eventdata, handles)
function checkbox_Vb_sim_Callback(hObject, eventdata, handles)
function checkbox_Vc_sim_Callback(hObject, eventdata, handles)
function checkbox_Vd_sim_Callback(hObject, eventdata, handles)
function checkbox_Va_IQ_exp_Callback(hObject, eventdata, handles)
function checkbox_Vb_IQ_exp_Callback(hObject, eventdata, handles)
function checkbox_Vc_IQ_exp_Callback(hObject, eventdata, handles)
function checkbox_Vd_IQ_exp_Callback(hObject, eventdata, handles)
function checkbox_Va_IQ_sim_Callback(hObject, eventdata, handles)
function checkbox_Vb_IQ_sim_Callback(hObject, eventdata, handles)
function checkbox_Vc_IQ_sim_Callback(hObject, eventdata, handles)
function checkbox_Vd_IQ_sim_Callback(hObject, eventdata, handles)
function checkbox_Qd_Callback(hObject, eventdata, handles)
function checkbox_Qc_Callback(hObject, eventdata, handles)
function checkbox_Ia_Callback(hObject, eventdata, handles)
function checkbox_Ib_Callback(hObject, eventdata, handles)
function checkbox_Ic_Callback(hObject, eventdata, handles)
function checkbox_Id_Callback(hObject, eventdata, handles)
function checkbox_Qa_Callback(hObject, eventdata, handles)
function checkbox_Qb_Callback(hObject, eventdata, handles)
function checkbox_Sum_Callback(hObject, eventdata, handles)
function checkbox_Qd_exp_Callback(hObject, eventdata, handles)
function checkbox_Qc_exp_Callback(hObject, eventdata, handles)
function checkbox_Ia_exp_Callback(hObject, eventdata, handles)
function checkbox_Ib_exp_Callback(hObject, eventdata, handles)
function checkbox_Ic_exp_Callback(hObject, eventdata, handles)
function checkbox_Id_exp_Callback(hObject, eventdata, handles)
function checkbox_Qa_exp_Callback(hObject, eventdata, handles)
function checkbox_Qb_exp_Callback(hObject, eventdata, handles)
function checkbox_Sum_exp_Callback(hObject, eventdata, handles)
function checkbox_Qd_sim_Callback(hObject, eventdata, handles)
function checkbox_Qc_sim_Callback(hObject, eventdata, handles)
function checkbox_Ia_sim_Callback(hObject, eventdata, handles)
function checkbox_Ib_sim_Callback(hObject, eventdata, handles)
function checkbox_Ic_sim_Callback(hObject, eventdata, handles)
function checkbox_Id_sim_Callback(hObject, eventdata, handles)
function checkbox_Qa_sim_Callback(hObject, eventdata, handles)
function checkbox_Qb_sim_Callback(hObject, eventdata, handles)
function checkbox_Sum_sim_Callback(hObject, eventdata, handles)
function checkbox_Q_Callback(hObject, eventdata, handles)
function checkbox_Q_exp_Callback(hObject, eventdata, handles)
function checkbox_Q_sim_Callback(hObject, eventdata, handles)
function edit_HorizontalMesh_Callback(hObject, eventdata, handles)
function edit_HorizontalMesh_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_ObliqueMesh_Callback(hObject, eventdata, handles)
function edit_ObliqueMesh_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_VerticaleMesh_Callback(hObject, eventdata, handles)
function edit_VerticaleMesh_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_MaxIteration_Callback(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_MaxIteration_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit_Tolerance_Callback(hObject, eventdata, handles)
function edit_Tolerance_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function text_MaxIteration_CreateFcn(hObject, eventdata, handles)
function pushbutton_GetOnlineData_CreateFcn(hObject, eventdata, handles)
%==========================================================================
