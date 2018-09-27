function varargout = TestDialogAlex(varargin)
% TESTDIALOGALEX M-file for TestDialogAlex.fig
%      TESTDIALOGALEX, by itself, creates a new TESTDIALOGALEX or raises the existing
%      singleton*.
%
%      H = TESTDIALOGALEX returns the handle to a new TESTDIALOGALEX or the handle to
%      the existing singleton*.
%
%      TESTDIALOGALEX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTDIALOGALEX.M with the given input arguments.
%
%      TESTDIALOGALEX('Property','Value',...) creates a new TESTDIALOGALEX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TestDialogAlex_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TestDialogAlex_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TestDialogAlex

% Last Modified by GUIDE v2.5 15-Jun-2007 15:23:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TestDialogAlex_OpeningFcn, ...
                   'gui_OutputFcn',  @TestDialogAlex_OutputFcn, ...
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


% --- Executes just before TestDialogAlex is made visible.
function TestDialogAlex_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TestDialogAlex (see VARARGIN)

% Choose default command line output for TestDialogAlex
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TestDialogAlex wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TestDialogAlex_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_PS1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_PS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_PS1 as text
%        str2double(get(hObject,'String')) returns contents of edit_PS1 as a double



% --- Executes during object creation, after setting all properties.
function edit_PS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_PS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_PS2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_PS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_PS2 as text
%        str2double(get(hObject,'String')) returns contents of edit_PS2 as a double


% --- Executes during object creation, after setting all properties.
function edit_PS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_PS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_PS3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_PS3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_PS3 as text
%        str2double(get(hObject,'String')) returns contents of edit_PS3 as a double


% --- Executes during object creation, after setting all properties.
function edit_PS3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_PS3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_apply.
function pushbutton_apply_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I_ps1=str2double(get(handles.edit_PS1,'String')) ;
I_ps2=str2double(get(handles.edit_PS2,'String')) ;
I_ps3=str2double(get(handles.edit_PS3,'String')) ;


PutCurrentAndCorrectOrbitOnLine_2(I_ps1,I_ps2,I_ps3,30)

