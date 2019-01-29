function varargout = kicker_scaling(varargin)
% KICKER_SCALING M-file for kicker_scaling.fig
%      KICKER_SCALING, by itself, creates a new KICKER_SCALING or raises the existing
%      singleton*.
%
%      H = KICKER_SCALING returns the handle to a new KICKER_SCALING or the handle to
%      the existing singleton*.
%
%      KICKER_SCALING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KICKER_SCALING.M with the given input arguments.
%
%      KICKER_SCALING('Property','Value',...) creates a new KICKER_SCALING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kicker_scaling_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kicker_scaling_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kicker_scaling

% Last Modified by GUIDE v2.5 14-Nov-2008 21:39:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kicker_scaling_OpeningFcn, ...
                   'gui_OutputFcn',  @kicker_scaling_OutputFcn, ...
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


% --- Executes just before kicker_scaling is made visible.
function kicker_scaling_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kicker_scaling (see VARARGIN)

% Choose default command line output for kicker_scaling
handles.output = hObject;

temp=tango_read_attribute2('ANS-C01/EP/AL_K.1', 'voltage');handles.K1=temp.value(2);
temp=tango_read_attribute2('ANS-C01/EP/AL_K.2', 'voltage');handles.K2=temp.value(2);
temp=tango_read_attribute2('ANS-C01/EP/AL_K.3', 'voltage');handles.K3=temp.value(2);
temp=tango_read_attribute2('ANS-C01/EP/AL_K.4', 'voltage');handles.K4=temp.value(2);

set(handles.edit_init_K1,'String',num2str(handles.K1));
set(handles.edit_init_K2,'String',num2str(handles.K2));
set(handles.edit_init_K3,'String',num2str(handles.K3));
set(handles.edit_init_K4,'String',num2str(handles.K4));

set(handles.edit_scaled_K1,'String',num2str(handles.K1));
set(handles.edit_scaled_K2,'String',num2str(handles.K2));
set(handles.edit_scaled_K3,'String',num2str(handles.K3));
set(handles.edit_scaled_K4,'String',num2str(handles.K4));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kicker_scaling wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kicker_scaling_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_restore.
function pushbutton_restore_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_restore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tango_write_attribute2('ANS-C01/EP/AL_K.1', 'voltage',handles.K1);
tango_write_attribute2('ANS-C01/EP/AL_K.2', 'voltage',handles.K2); 
tango_write_attribute2('ANS-C01/EP/AL_K.3', 'voltage',handles.K3);
tango_write_attribute2('ANS-C01/EP/AL_K.4', 'voltage',handles.K4); 

set(handles.edit_scaled_K1,'String',num2str(handles.K1));
set(handles.edit_scaled_K2,'String',num2str(handles.K2));
set(handles.edit_scaled_K3,'String',num2str(handles.K3));
set(handles.edit_scaled_K4,'String',num2str(handles.K4));

% --- Executes on button press in pushbutton_apply.
function pushbutton_apply_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

r=str2double(get(handles.edit_scaling,'String'));
if r>1.5
    r=1 ;
    set(handles.edit_scaling,'String','1');
elseif r<0
    r=1 ;
    set(handles.edit_scaling,'String','1');
end

tango_write_attribute2('ANS-C01/EP/AL_K.1', 'voltage',handles.K1*r);
tango_write_attribute2('ANS-C01/EP/AL_K.2', 'voltage',handles.K2*r);
tango_write_attribute2('ANS-C01/EP/AL_K.3', 'voltage',handles.K3*r);
tango_write_attribute2('ANS-C01/EP/AL_K.4', 'voltage',handles.K4*r);

set(handles.edit_scaled_K1,'String',num2str(handles.K1*r));
set(handles.edit_scaled_K2,'String',num2str(handles.K2*r));
set(handles.edit_scaled_K3,'String',num2str(handles.K3*r));
set(handles.edit_scaled_K4,'String',num2str(handles.K4*r));

function edit_scaling_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scaling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scaling as text
%        str2double(get(hObject,'String')) returns contents of edit_scaling as a double


% --- Executes during object creation, after setting all properties.
function edit_scaling_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scaling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_init_K1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_init_K1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_init_K1 as text
%        str2double(get(hObject,'String')) returns contents of edit_init_K1 as a double


% --- Executes during object creation, after setting all properties.
function edit_init_K1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_init_K1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_init_K2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_init_K2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_init_K2 as text
%        str2double(get(hObject,'String')) returns contents of edit_init_K2 as a double


% --- Executes during object creation, after setting all properties.
function edit_init_K2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_init_K2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_init_K3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_init_K3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_init_K3 as text
%        str2double(get(hObject,'String')) returns contents of edit_init_K3 as a double


% --- Executes during object creation, after setting all properties.
function edit_init_K3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_init_K3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_init_K4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_init_K4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_init_K4 as text
%        str2double(get(hObject,'String')) returns contents of edit_init_K4 as a double


% --- Executes during object creation, after setting all properties.
function edit_init_K4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_init_K4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scaled_K1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scaled_K1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scaled_K1 as text
%        str2double(get(hObject,'String')) returns contents of edit_scaled_K1 as a double


% --- Executes during object creation, after setting all properties.
function edit_scaled_K1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scaled_K1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scaled_K2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scaled_K2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scaled_K2 as text
%        str2double(get(hObject,'String')) returns contents of edit_scaled_K2 as a double


% --- Executes during object creation, after setting all properties.
function edit_scaled_K2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scaled_K2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scaled_K3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scaled_K3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scaled_K3 as text
%        str2double(get(hObject,'String')) returns contents of edit_scaled_K3 as a double


% --- Executes during object creation, after setting all properties.
function edit_scaled_K3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scaled_K3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scaled_K4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scaled_K4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scaled_K4 as text
%        str2double(get(hObject,'String')) returns contents of edit_scaled_K4 as a double


% --- Executes during object creation, after setting all properties.
function edit_scaled_K4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scaled_K4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


