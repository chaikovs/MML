function varargout = xbpm_calibrate_vs_gap_GUI(varargin)
% function varargout = xbpm_calibrate_vs_gap_GUI(xbpm_param)
% XBPM_CALIBRATE_VS_GAP_GUI M-file for xbpm_calibrate_vs_gap_GUI.fig
%      XBPM_CALIBRATE_VS_GAP_GUI, by itself, creates a new XBPM_CALIBRATE_VS_GAP_GUI or raises the existing
%      singleton*.
%
%      H = XBPM_CALIBRATE_VS_GAP_GUI returns the handle to a new XBPM_CALIBRATE_VS_GAP_GUI or the handle to
%      the existing singleton*.
%
%      XBPM_CALIBRATE_VS_GAP_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XBPM_CALIBRATE_VS_GAP_GUI.M with the given input arguments.
%
%      XBPM_CALIBRATE_VS_GAP_GUI('Property','Value',...) creates a new XBPM_CALIBRATE_VS_GAP_GUI or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before xbpm_calibrate_vs_gap_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to xbpm_calibrate_vs_gap_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help xbpm_calibrate_vs_gap_GUI

% Last Modified by GUIDE v2.5 16-May-2017 15:39:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @xbpm_calibrate_vs_gap_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @xbpm_calibrate_vs_gap_GUI_OutputFcn, ...
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

% --- Executes just before xbpm_calibrate_vs_gap_GUI is made visible.
function xbpm_calibrate_vs_gap_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to xbpm_calibrate_vs_gap_GUI (see VARARGIN)

% Choose default command line output for xbpm_calibrate_vs_gap_GUI
handles.output = hObject;

handles.xbpm_param_in       =   varargin{1};

% Update handles structure
guidata(hObject, handles);

%
initialize_gui(hObject, handles, false);

% UIWAIT makes xbpm_calibrate_vs_gap_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = xbpm_calibrate_vs_gap_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when selected object is changed in calib_option.
function calib_option_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in calib_option 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if (hObject == handles.calib_it0)
    fprintf('Simple K and offset calibration selected \n');
    handles.calib_type      =   0;
elseif (hObject == handles.calib_it)
    fprintf('Iteration for offset correction selected \n');
    handles.calib_type      =   1;
end

% Update handles structure
guidata(handles.figure1, handles);

% --- Executes when selected object is changed in output_opt.
function output_opt_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in output_opt 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if (hObject == handles.table_overwrite)
    fprintf('Replace existing tables selected \n');
    handles.output          =   0;
elseif (hObject == handles.table_new)
    fprintf('Do not replace existing tables selected \n');
    handles.output          =   1;
end

% Update handles structure
guidata(handles.figure1, handles);


function nb_it_edit_Callback(hObject, eventdata, handles)
% hObject    handle to nb_it_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nb_it_edit as text
%        str2double(get(hObject,'String')) returns contents of nb_it_edit as a double
nb_it               =   str2num(get(hObject, 'String'));
handles.nb_it       =   nb_it;

% Update handles structure
guidata(handles.figure1, handles);


% --- Executes during object creation, after setting all properties.
function nb_it_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nb_it_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
% if isfield(handles, 'metricdata') && ~isreset
%     return;
% end

set(handles.calib_option, 'SelectedObject', handles.calib_it0);
set(handles.output_opt, 'SelectedObject', handles.table_overwrite);
set(handles.nb_it_edit,'String','1');
%
handles.calib_type      =   0;
handles.output          =   0;
handles.nb_it           =   1;

% Update handles structure
guidata(handles.figure1, handles);


% --- Executes on button press in calibrate.
function calibrate_Callback(hObject, eventdata, handles)
% hObject    handle to calibrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xbpm_param              =   handles.xbpm_param_in;
xbpm_param.calib_type   =   handles.calib_type;
xbpm_param.output       =   handles.output;
xbpm_param.nb_it        =   handles.nb_it;
%
if (handles.calib_type  ==  0)
    xbpm_calibrate_vs_gap_with_MOT(xbpm_param)
elseif (handles.calib_type  ==  1)
    xbpm_correct_offset_vs_gap(xbpm_param)
end
