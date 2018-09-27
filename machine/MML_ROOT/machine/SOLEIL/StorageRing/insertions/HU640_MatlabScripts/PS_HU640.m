function varargout = PS_HU640(varargin)
% PS_HU640 M-file for PS_HU640.fig
%      PS_HU640, by itself, creates a new PS_HU640 or raises the existing
%      singleton*.
%
%      H = PS_HU640 returns the handle to a new PS_HU640 or the handle to
%      the existing singleton*.
%
%      PS_HU640('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PS_HU640.M with the given input arguments.
%
%      PS_HU640('Property','Value',...) creates a new PS_HU640 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PS_HU640_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PS_HU640_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PS_HU640

% Last Modified by GUIDE v2.5 26-Sep-2008 17:52:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PS_HU640_OpeningFcn, ...
                   'gui_OutputFcn',  @PS_HU640_OutputFcn, ...
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


% --- Executes just before PS_HU640 is made visible.
function PS_HU640_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PS_HU640 (see VARARGIN)

% Choose default command line output for PS_HU640
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PS_HU640 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PS_HU640_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



function edit_PSName_Callback(hObject, eventdata, handles)
% hObject    handle to edit_PSName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_PSName as text
%        str2double(get(hObject,'String')) returns contents of edit_PSName as a double


% --- Executes during object creation, after setting all properties.
function edit_PSName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_PSName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_PSValue_Callback(hObject, eventdata, handles)
% hObject    handle to edit_PSValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_PSValue as text
%        str2double(get(hObject,'String')) returns contents of edit_PSValue as a double


% --- Executes during object creation, after setting all properties.
function edit_PSValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_PSValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

SESS=get(handles.edit_SESSION,'String');
PSNa=get(handles.edit_PSName,'String');
PS=str2double(get(handles.edit_PSValue,'String'));

ReadTablesAndApplyCurrentValue(SESS,PSNa,PS);
