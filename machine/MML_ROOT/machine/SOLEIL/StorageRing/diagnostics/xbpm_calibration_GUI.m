function varargout = xbpm_calibration_GUI(varargin)
% XBPM_CALIBRATION_GUI M-file for xbpm_calibration_GUI.fig
%      XBPM_CALIBRATION_GUI, by itself, creates a new XBPM_CALIBRATION_GUI or raises the existing
%      singleton*.
%
%      H = XBPM_CALIBRATION_GUI returns the handle to a new XBPM_CALIBRATION_GUI or the handle to
%      the existing singleton*.
%
%      XBPM_CALIBRATION_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XBPM_CALIBRATION_GUI.M with the given input arguments.
%
%      XBPM_CALIBRATION_GUI('Property','Value',...) creates a new XBPM_CALIBRATION_GUI or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before xbpm_calibration_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to xbpm_calibration_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help xbpm_calibration_GUI

% Last Modified by GUIDE v2.5 18-May-2017 07:52:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @xbpm_calibration_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @xbpm_calibration_GUI_OutputFcn, ...
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

% --- Executes just before xbpm_calibration_GUI is made visible.
function xbpm_calibration_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to xbpm_calibration_GUI (see VARARGIN)

% Choose default command line output for xbpm_calibration_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes xbpm_calibration_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = xbpm_calibration_GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% Save the new comment_edit value
% handles.metricdata.density = density;
guidata(hObject,handles)


% --- Executes when selected object changed in IDgroup.
function IDgroup_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in IDgroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (hObject == handles.cristal)
    fprintf('CRISTAL selected \n')
    handles.ID='cristal';
elseif (hObject == handles.galaxies)
    fprintf('GALAXIES selected \n')
    handles.ID='galaxies';
elseif (hObject == handles.px1)
    fprintf('PX1 selected \n')
    handles.ID='px1';    
elseif (hObject == handles.px2)
    fprintf('PX2 selected \n')
    handles.ID='px2';    
elseif (hObject == handles.nano)
    fprintf('NANO selected \n')
    handles.ID='nano';
elseif (hObject == handles.tomo)
    fprintf('TOMO selected \n')
    handles.ID='tomo';    
elseif (hObject == handles.sixs)
    fprintf('SIXS selected \n')
    handles.ID='sixs';    
elseif (hObject == handles.swing)
    fprintf('SWING selected \n')
    handles.ID='swing'; 
else
    fprintf('!!!!!!!!!!!!!! Error in ID selection !!!!!!!!!!!!! \n')
end

% Update handles structure
guidata(handles.figure1, handles);

% --- Executes when selected object is changed in nb_group.
function nb_group_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in nb_group 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if (hObject == handles.xbpm1)
    fprintf('XBPM # 1 selected \n');
    handles.xbpm_nb =   1;
elseif (hObject == handles.xbpm2)
    fprintf('XBPM # 2 selected \n');
    handles.xbpm_nb =   2;
end

% Update handles structure
guidata(handles.figure1, handles);


% --- Executes during object creation, after setting all properties.
function nb_group_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nb_group (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function comment_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to comment_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function comment_edit_Callback(hObject, eventdata, handles)
% hObject    handle to comment_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of comment_edit as text
%        str2double(get(hObject,'String')) returns contents of comment_edit as a double
comment             =   get(hObject, 'String');
handles.comment     =   comment;

% Update handles structure
guidata(handles.figure1, handles);


% --- Executes when selected object is changed in directory.
function directory_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in directory 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if (hObject == handles.rep_default)
    fprintf('Default directory selected \n');
    handles.rep     =   0;
elseif (hObject == handles.rep_user)
    fprintf('User defined directory selected \n');
    handles.rep     =   1;
end

% Update handles structure
guidata(handles.figure1, handles);



% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
if isfield(handles, 'metricdata') && ~isreset
    return;
end

set(handles.IDgroup, 'SelectedObject', handles.cristal);
set(handles.nb_group, 'SelectedObject', handles.xbpm1);
set(handles.comment_edit, 'String', '');
set(handles.directory, 'SelectedObject', handles.rep_default);
%
handles.ID          =   'cristal';
handles.xbpm_nb     =   1;
handles.comment     =   '';
handles.rep         =   0;
%

% Update handles structure
guidata(handles.figure1, handles);


% --- Executes on button press in test_calibration.
function test_calibration_Callback(hObject, eventdata, handles)
% hObject    handle to test_calibration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xbpm_param.ID       =   handles.ID;
xbpm_param.xbpm_nb  =   handles.xbpm_nb;
xbpm_param.comment  =   handles.comment;
xbpm_param.rep      =   handles.rep;
xbpm_test_calibration(xbpm_param);


% --- Executes on button press in calibrate.
function calibrate_Callback(hObject, eventdata, handles)
% hObject    handle to calibrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xbpm_param.ID       =   handles.ID;
xbpm_param.xbpm_nb  =   handles.xbpm_nb;
xbpm_param.comment  =   handles.comment;
xbpm_param.rep      =   handles.rep;
xbpm_calibrate_vs_gap_GUI(xbpm_param);
