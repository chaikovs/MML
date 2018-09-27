function varargout = ANALYSE_INTEGRALES(varargin)
% ANALYSE_INTEGRALES M-file for ANALYSE_INTEGRALES.fig
%      ANALYSE_INTEGRALES, by itself, creates a new ANALYSE_INTEGRALES or raises the existing
%      singleton*.
%
%      H = ANALYSE_INTEGRALES returns the handle to a new ANALYSE_INTEGRALES or the handle to
%      the existing singleton*.
%
%      ANALYSE_INTEGRALES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYSE_INTEGRALES.M with the given input arguments.
%
%      ANALYSE_INTEGRALES('Property','Value',...) creates a new ANALYSE_INTEGRALES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ANALYSE_INTEGRALES_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ANALYSE_INTEGRALES_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ANALYSE_INTEGRALES

% Last Modified by GUIDE v2.5 06-Jul-2010 17:17:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ANALYSE_INTEGRALES_OpeningFcn, ...
                   'gui_OutputFcn',  @ANALYSE_INTEGRALES_OutputFcn, ...
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


% --- Executes just before ANALYSE_INTEGRALES is made visible.
function ANALYSE_INTEGRALES_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ANALYSE_INTEGRALES (see VARARGIN)

% Choose default command line output for ANALYSE_INTEGRALES
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ANALYSE_INTEGRALES wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ANALYSE_INTEGRALES_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_IDName_Callback(hObject, eventdata, handles)
% hObject    handle to edit_IDName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_IDName as text
%        str2double(get(hObject,'String')) returns contents of edit_IDName as a double


% --- Executes during object creation, after setting all properties.
function edit_IDName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_IDName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_SESSION_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SESSION (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SESSION as text
%        str2double(get(hObject,'String')) returns contents of edit_SESSION as a double


% --- Executes during object creation, after setting all properties.
function edit_SESSION_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SESSION (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Xmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Xmin as text
%        str2double(get(hObject,'String')) returns contents of edit_Xmin as a double


% --- Executes during object creation, after setting all properties.
function edit_Xmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Xmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Xmax as text
%        str2double(get(hObject,'String')) returns contents of edit_Xmax as a double


% --- Executes during object creation, after setting all properties.
function edit_Xmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gap_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gap as text
%        str2double(get(hObject,'String')) returns contents of edit_gap as a double


% --- Executes during object creation, after setting all properties.
function edit_gap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Step_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Step as text
%        str2double(get(hObject,'String')) returns contents of edit_Step as a double


% --- Executes during object creation, after setting all properties.
function edit_Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gapmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gapmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gapmax as text
%        str2double(get(hObject,'String')) returns contents of edit_gapmax as a double


% --- Executes during object creation, after setting all properties.
function edit_gapmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gapmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_BPMtoSkip_Callback(hObject, eventdata, handles)
% hObject    handle to edit_BPMtoSkip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_BPMtoSkip as text
%        str2double(get(hObject,'String')) returns contents of edit_BPMtoSkip as a double


% --- Executes during object creation, after setting all properties.
function edit_BPMtoSkip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_BPMtoSkip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in APPLY.
function APPLY_Callback(hObject, eventdata, handles)
% hObject    handle to APPLY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IDName=get(handles.edit_IDName,'String');
SESSION=get(handles.edit_SESSION,'String');
BPMtoSkip=get(handles.edit_BPMtoSkip,'String');
Xmin=str2double(get(handles.edit_Xmin,'String'));
Xmax=str2double(get(handles.edit_Xmax,'String'));
Step=str2double(get(handles.edit_Step,'String'));
gap=str2double(get(handles.edit_gap,'String'));
gapmax=str2double(get(handles.edit_gapmax,'String'));

Analyse_Bump_InVac(IDName,SESSION,Xmin,Xmax,Step,gap,gapmax,BPMtoSkip)

