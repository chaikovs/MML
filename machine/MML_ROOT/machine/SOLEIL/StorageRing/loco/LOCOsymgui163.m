function varargout = LOCOsymgui(varargin)
% LOCOSYMGUI M-file for LOCOsymgui.fig
%      LOCOSYMGUI, by itself, creates a new LOCOSYMGUI or raises the existing
%      singleton*.
%
%      H = LOCOSYMGUI returns the handle to a new LOCOSYMGUI or the handle to
%      the existing singleton*.
%
%      LOCOSYMGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOCOSYMGUI.M with the given input arguments.
%
%      LOCOSYMGUI('Property','Value',...) creates a new LOCOSYMGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LOCOsymgui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LOCOsymgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LOCOsymgui

% Last Modified by GUIDE v2.5 21-Jul-2009 20:40:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LOCOsymgui_OpeningFcn, ...
                   'gui_OutputFcn',  @LOCOsymgui_OutputFcn, ...
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


% --- Executes just before LOCOsymgui is made visible.
function LOCOsymgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LOCOsymgui (see VARARGIN)

% Choose default command line output for LOCOsymgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LOCOsymgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

handles.DK = NaN;
handles.Mode = 'Online';

handles.K1i_before = NaN;
handles.K2i_before = NaN;
handles.K3i_before = NaN;
handles.K4i_before = NaN;
handles.K5i_before = NaN;
handles.K6i_before = NaN;
handles.K7i_before = NaN;
handles.K8i_before = NaN;
handles.K9i_before = NaN;
handles.K10i_before = NaN;
handles.QT_before = NaN;
handles.tune_before = NaN;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = LOCOsymgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton_storedata.
function pushbutton_storedata_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_storedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Mode = 'Online';

fprintf('Reading Quad values \n');

try
    handles.K1i_before=getsp('Q1',handles.Mode,'Physics');
    handles.K2i_before=getsp('Q2',handles.Mode,'Physics');
    handles.K3i_before=getsp('Q3',handles.Mode,'Physics');
    handles.K4i_before=getsp('Q4',handles.Mode,'Physics');
    handles.K5i_before=getsp('Q5',handles.Mode,'Physics');
    handles.K6i_before=getsp('Q6',handles.Mode,'Physics');
    handles.K7i_before=getsp('Q7',handles.Mode,'Physics');
    handles.K8i_before=getsp('Q8',handles.Mode,'Physics');
    handles.K9i_before=getsp('Q9',handles.Mode,'Physics');
    handles.K10i_before=getsp('Q10',handles.Mode,'Physics');

    handles.QT_before = getsp('QT', handles.Mode, 'Physics');

    handles.tune_before = gettune;

    fprintf('Nux = %f Nuz = %f\n', handles.tune_before);

    set(handles.pushbutton_Symmetry,'Enable', 'On')
    set(handles.pushbutton_Coupling,'Enable', 'On')

catch
    fprintf('Error \n')
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_Symmetry.
function pushbutton_Symmetry_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Symmetry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% 160 quad % -1 full correctionvehandles.DK
k = -1;
setsp('Q1',k* handles.DK(1:8) + handles.K1i_before, handles.Mode,'Physics');
setsp('Q2',k* handles.DK(9:16) + handles.K2i_before, handles.Mode,'Physics');
setsp('Q3',k* handles.DK(17:24) + handles.K3i_before, handles.Mode,'Physics');
setsp('Q4',k* handles.DK(25:40) + handles.K4i_before, handles.Mode,'Physics');
setsp('Q5',k* handles.DK(41:56) + handles.K5i_before, handles.Mode,'Physics');
setsp('Q6',k* handles.DK(57:80) + handles.K6i_before, handles.Mode,'Physics');
setsp('Q7',k* handles.DK(81:104) + handles.K7i_before, handles.Mode,'Physics');
setsp('Q8',k* handles.DK(105:128) + handles.K8i_before, handles.Mode,'Physics');
setsp('Q9',k* handles.DK(129:144) + handles.K9i_before, handles.Mode,'Physics');
setsp('Q10',k* handles.DK(145:160) + handles.K10i_before, handles.Mode,'Physics');
setsp('Q11',k* handles.DK(161:162) + handles.K10i_before, handles.Mode,'Physics');
setsp('Q12',k* handles.DK(163:163) + handles.K10i_before, handles.Mode,'Physics');
pause(5);
tune = gettune;
fprintf('Tunes variations for iter0 is Dnux = %f Dnuz =%f\n', tune-handles.tune_before);

set(handles.pushbutton_CancelDK, 'Enable', 'on');

% --- Executes on button press in pushbutton_Coupling.
function pushbutton_Coupling_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Coupling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% skew quad -1 for full correction
k =-1;
setsp('QT',k* handles.DK(161:192) + handles.QT_before, handles.Mode,'Physics');

fprintf('Correction applied on QTs \n');

set(handles.pushbutton_CancelDK, 'Enable', 'on');

% --- Executes on button press in pushbutton_LOCODATA.
function pushbutton_LOCODATA_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_LOCODATA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

temp = evalin('base', 'LOCOstruct');

handles.DK = temp.DK;

% Update handles structure
guidata(hObject, handles);

set(handles.pushbutton_LOCODATA, 'BackgroundColor', [0 1 0]);
set(handles.pushbutton_PlotDK, 'Enable', 'on');



% --- Executes on button press in pushbutton_PlotDK.
function pushbutton_PlotDK_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PlotDK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

analoco('160quad');


% --- Executes on button press in pushbutton_CancelDK.
function pushbutton_CancelDK_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_CancelDK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% 160 quad % -1 full correctionvehandles.DK
k = 0;
QuadFlag = 0;
QTFlag = 1;

if QuadFlag
    setsp('Q1',k* handles.DK(1:8) + handles.K1i_before, handles.Mode,'Physics');
    setsp('Q2',k* handles.DK(9:16) + handles.K2i_before, handles.Mode,'Physics');
    setsp('Q3',k* handles.DK(17:24) + handles.K3i_before, handles.Mode,'Physics');
    setsp('Q4',k* handles.DK(25:40) + handles.K4i_before, handles.Mode,'Physics');
    setsp('Q5',k* handles.DK(41:56) + handles.K5i_before, handles.Mode,'Physics');
    setsp('Q6',k* handles.DK(57:80) + handles.K6i_before, handles.Mode,'Physics');
    setsp('Q7',k* handles.DK(81:104) + handles.K7i_before, handles.Mode,'Physics');
    setsp('Q8',k* handles.DK(105:128) + handles.K8i_before, handles.Mode,'Physics');
    setsp('Q9',k* handles.DK(129:144) + handles.K9i_before, handles.Mode,'Physics');
    setsp('Q10',k* handles.DK(145:160) + handles.K10i_before, handles.Mode,'Physics');
end

if QTFlag
    setsp('QT',k* handles.DK(161:192) + handles.QT_before, handles.Mode,'Physics');
end    

pause(5);
tune = gettune;
fprintf('Tunes variations for iter0 is Dnux = %f Dnuz =%f\n', tune-handles.tune_before);

set(handles.pushbutton_CancelDK, 'Enable', 'off');


% --- Executes on button press in checkbox_Quad.
function checkbox_Quad_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Quad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Quad


% --- Executes on button press in checkbox_QT.
function checkbox_QT_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_QT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_QT


