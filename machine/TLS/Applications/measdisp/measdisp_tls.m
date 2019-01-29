function varargout = measdisp_tls(varargin)
% MEASDISP_TLS M-file for measdisp_tls.fig
%      MEASDISP_TLS, by itself, creates a new MEASDISP_TLS or raises the existing
%      singleton*.
%
%      H = MEASDISP_TLS returns the handle to a new MEASDISP_TLS or the handle to
%      the existing singleton*.
%
%      MEASDISP_TLS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MEASDISP_TLS.M with the given input arguments.
%
%      MEASDISP_TLS('Property','Value',...) creates a new MEASDISP_TLS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before measdisp_tls_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to measdisp_tls_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help measdisp_tls

% Last Modified by GUIDE v2.5 23-Jun-2010 14:47:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @measdisp_tls_OpeningFcn, ...
                   'gui_OutputFcn',  @measdisp_tls_OutputFcn, ...
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


% --- Executes just before measdisp_tls is made visible.
function measdisp_tls_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to measdisp_tls (see VARARGIN)

% Choose default command line output for measdisp_tls
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

axes(handles.lattice);
cla;
drawlattice;
set(handles.lattice, 'XTick', []);
set(handles.lattice, 'YTick', []);
modeldisp_tls(handles);

% UIWAIT makes measdisp_tls wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function modeldisp_tls(handles)
[Dx, Dy, Sx, Sy, h] = modeldisp;
axes(handles.betax)
plot(Sx,Dx);
ylabel('Horizontal [m]');
grid on;
set(handles.betax, 'XTickLabel', []);
set(handles.betax, 'XLim', [0 120]);
axes(handles.betay)
plot(Sy,Dy);
xlabel('Position [m]');
ylabel('Vertical [m]');
grid on;
set(handles.betay, 'XLim', [0 120]);

% --- Outputs from this function are returned to the command line.
function varargout = measdisp_tls_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in measure.
function measure_Callback(hObject, eventdata, handles)
% hObject    handle to measure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Mode = getmode('RF');
[Dx, Dy, FileName] = disp_tls(Mode,handles);
AO = [Dx, Dy];
set(handles.measure, 'UserData', AO);



function S1_Callback(hObject, eventdata, handles)
% hObject    handle to S1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S1 as text
%        str2double(get(hObject,'String')) returns contents of S1 as a double


% --- Executes during object creation, after setting all properties.
function S1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S3_Callback(hObject, eventdata, handles)
% hObject    handle to S3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S3 as text
%        str2double(get(hObject,'String')) returns contents of S3 as a double


% --- Executes during object creation, after setting all properties.
function S3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q3_Callback(hObject, eventdata, handles)
% hObject    handle to Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Q3 as text
%        str2double(get(hObject,'String')) returns contents of Q3 as a double


% --- Executes during object creation, after setting all properties.
function Q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q4_Callback(hObject, eventdata, handles)
% hObject    handle to Q4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Q4 as text
%        str2double(get(hObject,'String')) returns contents of Q4 as a double


% --- Executes during object creation, after setting all properties.
function Q4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.V1, 'String', 0);
set(handles.V2, 'String', 1);
set(handles.H1, 'String', 0);
set(handles.H2, 'String', 120);
set(handles.betax, 'XLim', [0 120]);
set(handles.betay, 'XLim', [0 120]);
set(handles.lattice, 'XLim', [0 120]);
axes(handles.betax);
title('');
cla;
axes(handles.betay);
cla;
modeldisp_tls(handles);
set(handles.S1, 'String', 1);
set(handles.S2, 'Value', 1);
set(handles.S3, 'String', 10);
set(handles.IF1, 'String', []);
set(handles.IF2, 'String', []);
set(handles.IF3, 'String', []);
set(handles.IF4, 'String', []);
set(handles.IF5, 'String', []);
set(handles.IF6, 'String', []);



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B1_Callback(hObject, eventdata, handles)
% hObject    handle to B1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B1 as text
%        str2double(get(hObject,'String')) returns contents of B1 as a double


% --- Executes during object creation, after setting all properties.
function B1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B2_Callback(hObject, eventdata, handles)
% hObject    handle to B2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B2 as text
%        str2double(get(hObject,'String')) returns contents of B2 as a double


% --- Executes during object creation, after setting all properties.
function B2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B3_Callback(hObject, eventdata, handles)
% hObject    handle to B3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B3 as text
%        str2double(get(hObject,'String')) returns contents of B3 as a double


% --- Executes during object creation, after setting all properties.
function B3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B4_Callback(hObject, eventdata, handles)
% hObject    handle to B4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B4 as text
%        str2double(get(hObject,'String')) returns contents of B4 as a double


% --- Executes during object creation, after setting all properties.
function B4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IF1_Callback(hObject, eventdata, handles)
% hObject    handle to IF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IF1 as text
%        str2double(get(hObject,'String')) returns contents of IF1 as a double


% --- Executes during object creation, after setting all properties.
function IF1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IF2_Callback(hObject, eventdata, handles)
% hObject    handle to IF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IF2 as text
%        str2double(get(hObject,'String')) returns contents of IF2 as a double


% --- Executes during object creation, after setting all properties.
function IF2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IF3_Callback(hObject, eventdata, handles)
% hObject    handle to IF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IF3 as text
%        str2double(get(hObject,'String')) returns contents of IF3 as a double


% --- Executes during object creation, after setting all properties.
function IF3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IF4_Callback(hObject, eventdata, handles)
% hObject    handle to IF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IF4 as text
%        str2double(get(hObject,'String')) returns contents of IF4 as a double


% --- Executes during object creation, after setting all properties.
function IF4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IF4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IF5_Callback(hObject, eventdata, handles)
% hObject    handle to IF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IF5 as text
%        str2double(get(hObject,'String')) returns contents of IF5 as a double


% --- Executes during object creation, after setting all properties.
function IF5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IF5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IF6_Callback(hObject, eventdata, handles)
% hObject    handle to IF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IF6 as text
%        str2double(get(hObject,'String')) returns contents of IF6 as a double


% --- Executes during object creation, after setting all properties.
function IF6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IF6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T1_Callback(hObject, eventdata, handles)
% hObject    handle to T1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T1 as text
%        str2double(get(hObject,'String')) returns contents of T1 as a double


% --- Executes during object creation, after setting all properties.
function T1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T2_Callback(hObject, eventdata, handles)
% hObject    handle to T2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2 as text
%        str2double(get(hObject,'String')) returns contents of T2 as a double


% --- Executes during object creation, after setting all properties.
function T2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T3_Callback(hObject, eventdata, handles)
% hObject    handle to T3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T3 as text
%        str2double(get(hObject,'String')) returns contents of T3 as a double


% --- Executes during object creation, after setting all properties.
function T3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T4_Callback(hObject, eventdata, handles)
% hObject    handle to T4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T4 as text
%        str2double(get(hObject,'String')) returns contents of T4 as a double


% --- Executes during object creation, after setting all properties.
function T4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function D1_Callback(hObject, eventdata, handles)
% hObject    handle to D1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of D1 as text
%        str2double(get(hObject,'String')) returns contents of D1 as a double


% --- Executes during object creation, after setting all properties.
function D1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to D1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function D2_Callback(hObject, eventdata, handles)
% hObject    handle to D2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of D2 as text
%        str2double(get(hObject,'String')) returns contents of D2 as a double


% --- Executes during object creation, after setting all properties.
function D2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to D2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function D3_Callback(hObject, eventdata, handles)
% hObject    handle to D3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of D3 as text
%        str2double(get(hObject,'String')) returns contents of D3 as a double


% --- Executes during object creation, after setting all properties.
function D3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to D3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit34_Callback(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit34 as text
%        str2double(get(hObject,'String')) returns contents of edit34 as a double


% --- Executes during object creation, after setting all properties.
function edit34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit35_Callback(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit35 as text
%        str2double(get(hObject,'String')) returns contents of edit35 as a double


% --- Executes during object creation, after setting all properties.
function edit35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit32 as text
%        str2double(get(hObject,'String')) returns contents of edit32 as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit33 as text
%        str2double(get(hObject,'String')) returns contents of edit33 as a double


% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function V1_Callback(hObject, eventdata, handles)
% hObject    handle to V1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
V1 = str2num(get(handles.V1, 'String'));
V2 = str2num(get(handles.V2, 'String'));
set(handles.betax, 'YLim', [V1 V2]);
set(handles.betay, 'YLim', [V1 V2]);

% Hints: get(hObject,'String') returns contents of V1 as text
%        str2double(get(hObject,'String')) returns contents of V1 as a double


% --- Executes during object creation, after setting all properties.
function V1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to V1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function V2_Callback(hObject, eventdata, handles)
% hObject    handle to V2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
V1 = str2num(get(handles.V1, 'String'));
V2 = str2num(get(handles.V2, 'String'));
set(handles.betax, 'YLim', [V1 V2]);
set(handles.betay, 'YLim', [V1 V2]);

% Hints: get(hObject,'String') returns contents of V2 as text
%        str2double(get(hObject,'String')) returns contents of V2 as a double


% --- Executes during object creation, after setting all properties.
function V2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to V2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AO = get(handles.measure, 'UserData');
if isempty(AO)
    X = [0 0];
else
    X = [max(abs(AO(:,1))),abs(max(AO(:,2)))];
end
[Dx, Dy, Sx, Sy, h] = modeldisp;
Y = [max(abs(Dx)),max(abs(Dy))];
Z = max(cat(1,X,Y));
set(handles.betax, 'YLim', [0 Z(1,1)]);
if Z(1,2) == 0
    set(handles.betay, 'YLim', [-1 1]);
else
    set(handles.betay, 'YLim', [-Z(1,2) Z(1,2)]);
end
set(handles.V1, 'String', 0);
set(handles.V2, 'String', ceil(Z(1,1)*10)/10);



function H1_Callback(hObject, eventdata, handles)
% hObject    handle to H1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
H1 = str2num(get(handles.H1, 'String'));
H2 = str2num(get(handles.H2, 'String'));
set(handles.betax, 'XLim', [H1 H2]);
set(handles.betay, 'XLim', [H1 H2]);
set(handles.lattice, 'XLim', [H1 H2]);

% Hints: get(hObject,'String') returns contents of H1 as text
%        str2double(get(hObject,'String')) returns contents of H1 as a double


% --- Executes during object creation, after setting all properties.
function H1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to H1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function H2_Callback(hObject, eventdata, handles)
% hObject    handle to H2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
H1 = str2num(get(handles.H1, 'String'));
H2 = str2num(get(handles.H2, 'String'));
set(handles.betax, 'XLim', [H1 H2]);
set(handles.betay, 'XLim', [H1 H2]);
set(handles.lattice, 'XLim', [H1 H2]);

% Hints: get(hObject,'String') returns contents of H2 as text
%        str2double(get(hObject,'String')) returns contents of H2 as a double


% --- Executes during object creation, after setting all properties.
function H2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to H2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.betax, 'XLim', [0 120]);
set(handles.betay, 'XLim', [0 120]);
set(handles.lattice, 'XLim', [0 120]);
set(handles.H1, 'String', 0);
set(handles.H2, 'String', 120);

function [DxOut, DyOut, FileName] = plotdisp_tls(varargin)
%PLOTDISP - Plots the dispersion function 
%
%  For structure inputs:
%  [Dx, Dy] = plotdisp(Dx, Dy)               Plots in the units stored in the structure
%  [Dx, Dy] = plotdisp(FileName)             Plots in the units stored in a file ('' to browse)
%  [Dx, Dy] = plotdisp(Dx, Dy,'Hardware')    Plots in hardware units (converts if necessary)
%  [Dx, Dy] = plotdisp(Dx, Dy,'Physics')     Plots in physics  units (converts if necessary)
%
%  When not using structure inputs, assumptions have to be made about the units
%  This function assumes that hardware units are mm/MHz and physics units are meters/Hz
%  [Dx,Dy] = plotdisp(Dx, Dy)                   Assumes that the units of Dx,Dy are mm/MHz
%  [Dx,Dy] = plotdisp(Dx, Dy, 'Physics')        Assumes that the units of Dx,Dy are m/(dp/p) (no conversion)
%                                             ie, was measured using [Dx, Dy] = measdisp('Physics')
%  [Dx,Dy] = plotdisp(Dx, Dy, 'Physics',mcf,rf) Converts Dx,Dy from mm/MHz to m/(dp/p)
%                                             ie, was measured using [Dx, Dy] = measdisp('Hardware')
%
%  INPUTS
%  1. d (dispersion structure) or Dx and Dy (vectors) as measure by measdisp
%  2. 'Physics'  is a flag to plot dispersion function in physics units
%     'Hardware' is a flag to plot dispersion function in hardware units
%     ('Eta' can be used instead of 'Physics')
%  3. mcf = momentum compaction factor (linear)
%  4. rf  = rf frequency (MHz)
%     rf and mcf input are only for nonstructure inputs when using the 'Physics' flag
%
%  OUTPUT
%  1. [Dx, Dy] is the dispersion function which may be different from the input
%     if units were changed.
%
%  NOTE
%  1. 'Hardware' and 'Physics' are not case sensitive
%
%  See also measdisp, getdisp

%  Written by William J. Corbett and Greg Portmann
%  Modified by Laurent S. Nadolski
%  More generic, Eta option was not working


MCF = [];
RF0 = [];
FileName = -1;
Dx = [];
Dy = [];
ModeString = '';

BPMxFamily = gethbpmfamily;
BPMyFamily = getvbpmfamily;

% Input parsing
UnitsFlag = {};
%UnitsFlag = {'Physics'};
for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignore structures
    elseif iscell(varargin{i})
        % Ignore cells
    elseif strcmpi(varargin{i},'Eta') || strcmpi(varargin{i},'Physics')
        UnitsFlag = {'Physics'};
        varargin(i) = [];
        if length(varargin) >= i         % Not sure if I'm using these inputs at the moment
            if isnumeric(varargin{i})
                MCF = varargin{i};
                if length(varargin) >= i+1
                    if isnumeric(varargin{i+1})
                        RF0 = varargin{i+1};
                        varargin(i+1) = [];    
                    end
                end
                varargin(i) = [];    
            end
        end
    elseif strcmpi(varargin{i},'Hardware')
        UnitsFlag = varargin(i);
        varargin(i) = [];    
    end
end


% Check if the input is a structure
if isempty(varargin)
elseif ischar(varargin{1})
    FileName = varargin{1};
elseif length(varargin) < 2
    error('Dx and Dy dispersion or a filename input are required.');
else
    if (isstruct(varargin{1}) || isnumeric(varargin{1})) && (isstruct(varargin{2}) || isnumeric(varargin{2})) 
        Dx = varargin{1};
        Dy = varargin{2};
        handles = varargin{3};
%         handles = handles{1,1};
    else
        error('Dx and Dy dispersion or a filename input are required.');
    end
end

if isempty(Dx)
    if ischar(FileName)
        [Dx, FileName] = getdisp(BPMxFamily, 'Struct', FileName, UnitsFlag{:});
    else
        [Dx, FileName] = getdisp(BPMxFamily, 'Struct', UnitsFlag{:});
    end
    if isempty(FileName) || ~ischar(FileName)
        return;
    else
        Dy = getdisp(BPMyFamily, FileName, 'Struct', UnitsFlag{:});
    end
end

if isstruct(Dx)
    if isempty(UnitsFlag)
        UnitsFlag = Dx.Units;
    end
    ModeString = Dx.Monitor.Mode;
    
    MCF = Dx.MCF;
    if strcmpi(UnitsFlag,'Physics') && strcmpi(Dx.Units,'Hardware')
        % Change to physics units
        Dx = hw2physics(Dx);
    end        
    if strcmpi(UnitsFlag,'Physics') && strcmpi(Dy.Units,'Hardware')
        % Change to physics units
        Dy = hw2physics(Dy);
    end
    % Change to denominator to energy shift (dp/p)
    %RF0 = Dx.Actuator.Data;    
    %RF0 = RF0(1);  % Just in case someone has a vector for multiple cavities
    %Dx.Data = -RF0 * MCF * Dx.Data;
    %Dy.Data = -RF0 * MCF * Dy.Data;
    %
    %Dx.UnitsString = [Dx.Monitor.UnitsString,'/(dp/p)'];
    %Dy.UnitsString = [Dy.Monitor.UnitsString,'/(dp/p)'];
    
    if strcmpi(UnitsFlag,'Hardware') && strcmpi(Dx.Units,'Physics')
        % Change to hardware units
        Dx = physics2hw(Dx);
    end
    if strcmpi(UnitsFlag,'Hardware') && strcmpi(Dy.Units,'Physics')
        % Change to hardware units
        Dy = physics2hw(Dy);
    end
    % Change to denominator to RF change
    %RF0 = Dx.Actuator.Data;    
    %RF0 = RF0(1);  % Just in case someone has a vector for multiple cavities
    %Dx.Data = Dx.Data / (-RF0 * MCF);
    %Dy.Data = Dy.Data / (-RF0 * MCF);
    % Change to hardware units
    %Dx = physics2hw(Dx);
    %Dy = physics2hw(Dy);
    %Dx.UnitsString = [Dx.Monitor.UnitsString,'/',Dx.Actuator.UnitsString];
    %Dy.UnitsString = [Dy.Monitor.UnitsString,'/',Dy.Actuator.UnitsString];
    
    DeltaRF = Dx.ActuatorDelta;        
    TimeStamp = Dx.TimeStamp;
    
    if isempty(strfind(Dx.UnitsString,'dp'))
        TitleString = sprintf('"Dispersion" Function: %s  (\\Deltaf=%g %s)', texlabel('{Delta}Orbit / {Delta}f'), DeltaRF, Dx.Actuator.UnitsString);
    else
        TitleString = sprintf('Dispersion Function: %s  (\\alpha=%.5f, f=%f %s, \\Deltaf=%g %s)', texlabel('-alpha f {Delta}Orbit / {Delta}f'), MCF, Dx.Actuator.Data, Dx.Actuator.UnitsString, DeltaRF, Dx.Actuator.UnitsString);
    end
    
    
    % Plot dispersion
    if isfamily(Dx.Monitor.FamilyName)
        sx = getspos(Dx.Monitor.FamilyName,Dx.Monitor.DeviceList);
        X1LabelString = sprintf('%s Position [meters]', Dx.Monitor.FamilyName);
    elseif strcmpi(Dx.Monitor.FamilyName, 'all');
        global THERING
        sx = findspos(THERING, 1:length(THERING)+1);
        X1LabelString = 'Position [meters]';
    else
        sx = 1:length(Dx.Data);
        X1LabelString = 'BPM Number';
        
        global THERING
        if ~isempty(THERING)
            Index = findcells(THERING, 'FamName', Dx.Monitor.FamilyName);
            if ~isempty(Index)
                sx = findspos(THERING, Index);
                X1LabelString = sprintf('%s Position [meters]', Dx.Monitor.FamilyName);
            end
        end
    end
    
    if isfamily(Dy.Monitor.FamilyName)
        sy = getspos(Dy.Monitor.FamilyName, Dy.Monitor.DeviceList);
        X2LabelString = sprintf('%s Position [meters]', Dy.Monitor.FamilyName);
    elseif strcmpi(Dy.Monitor.FamilyName, 'all');
        global THERING
        sy = findspos(THERING, 1:length(THERING)+1);
        X2LabelString = 'Position [meters]';
    else
        sy = 1:length(Dy.Data);
        X2LabelString = 'BPM Number';
        
        global THERING
        if ~isempty(THERING)
            Index = findcells(THERING, 'FamName', Dy.Monitor.FamilyName);
            if ~isempty(Index)
                sy = findspos(THERING, Index);
                X2LabelString = sprintf('%s Position [meters]', Dy.Monitor.FamilyName);
            end
        end
    end
    
    Y1LabelString = sprintf('Horizontal [%s]', Dx.UnitsString);
    Y2LabelString = sprintf('Vertical [%s]', Dx.UnitsString);
    
    DxOut = Dx;
    DyOut = Dy;
    
    Dx = Dx.Data;
    Dy = Dy.Data;
else
    % Non structure inputs
    if nargin == 2 || nargin == 3 || nargin == 5
        % OK
    else
        error('2, 3, or 5 inputs required');
    end
        
    if isempty(UnitsFlag)
        UnitsFlag = 'Physics';
    end

    if strcmpi(UnitsFlag,'Physics')
        Y1LabelString = sprintf('Horizontal [m]');
        Y2LabelString = sprintf('Vertical [m]');
        
        % Convert to physics units (if RF0 and MCF were not input, then assume that the units were already in mm/(dp/p))
        if ~isempty(RF0) && ~isempty(MCF)
            TitleString = sprintf('Dispersion Function: %s  (\\alpha=%f, f=%f)', texlabel('-alpha f {Delta}Orbit / {Delta}f'), MCF, RF0);
            % Change units to meters/(dp/p)
            Dx = -RF0(1) * MCF * Dx / 1000;
            Dy = -RF0(1) * MCF * Dy / 1000;
        else
            TitleString = sprintf('Dispersion Function: %s', texlabel('-alpha f {Delta}Orbit / {Delta}f'));
        end     
    else
        TitleString = sprintf('"Dispersion" Function: %s', texlabel('{Delta}Orbit / {Delta}f'));
        Y1LabelString = sprintf('Horizontal [mm/MHz]');
        Y2LabelString = sprintf('Vertical [mm/MHz]');                 
    end
    
    % Plot dispersion in terms of mm/MHz
    sx = 1:length(Dx);
    sy = 1:length(Dy);
    X1LabelString = 'BPM Number';
    X2LabelString = 'BPM Number';
    
    DxOut = Dx;
    DyOut = Dy;
end


% Plot
% clf reset
%set(gcf,'NumberTitle','On','Name','Dispersion');

axes(handles.betax);
hold on;
if any(strcmpi(ModeString, {'Online','Simulator'}))
    plot(sx, Dx, 'o','MarkerEdgeColor','r');
else
    plot(sx, Dx, '.-b');
end
% xlabel(X1LabelString);
set(handles.betax, 'XTickLabel', []);
ylabel('Horizontal [m]');
title(TitleString);
grid on;

axes(handles.betay);
hold on;
if any(strcmpi(ModeString, {'Online','Simulator'}))
    plot(sy, Dy, 'o','MarkerEdgeColor','r');
else
    plot(sy, Dy, '.-b');
end
xlabel('Position [m]');
ylabel('Vertical [m]');
grid on;

L = getfamilydata('Circumference');
if ~isempty(L)
    xaxiss([0 L]);
end

% Link the x-axes
% linkaxes(h, 'x');

orient tall

% if exist('TimeStamp','var')
%     %addlabel(1,0,sprintf('%s', datestr(TimeStamp,0)));
%     if any(strcmpi(ModeString, {'Model','Simulator'}))
%         addlabel(1,0,sprintf('%s (Model)', datestr(TimeStamp,0)));
%     else
%         addlabel(1,0,sprintf('%s', datestr(TimeStamp,0)));        
%     end
% end

if FileName == -1
    FileName = [];
end


function [Dx, Dy, FileName] = disp_tls(varargin)
%disp_tls - Measures the dispersion function
%  [Dx, Dy, FileName] = disp_tls(DeltaRF, BPMxFamily, BPMxList, BPMyFamily, BPMyList, WaitFlag, ModulationMethod)
%
%  Examples:
%  [Dx, Dy] = disp_tls(DeltaRF, BPMxList, BPMyList)
%  [Dx, Dy] = disp_tls('BPMx', [], 'BPMy')
%  [Dx, Dy] = disp_tls(DeltaRF, 'Physics', mcf)
%  [Dx, Dy] = disp_tls(DeltaRF, 'Physics')
%  [Dx, Dy] = disp_tls
%  [Dx, Dy] = disp_tls('Archive')
%  [Dx, Dy] = disp_tls('Struct')
%
%  INPUTS
%  1. DeltaRF is the change in RF frequency {Default: .2% energy change}
%     Units match the units the RF family is in (or the override units)
%  2. BPMxFamily and BPMyFamily are the family names of the BPM's, {Default: gethbpmfamily, getvbpmfamily}
%  3. BPMxList and BPMyList are the device list of BPM's, {Default or []: the entire list}
%  4. WaitFlag >= 0, wait WaitFlag seconds before measuring the tune (sec)
%               = -1, wait until the magnets are done ramping
%               = -2, wait until the magnets are done ramping + BPM processing delay {Default} 
%               = -4, wait until keyboard input
%  5. Modulation method for changing the RF frequency
%     'bipolar'  changes the RF by +/- DeltaRF/2 {Default}
%     'unipolar' changes the RF from 0 to DeltaRF
%  6. 'Physics' - For actual dispersion units (m/(dp/p)) add 'Physics' with an optional input 
%     of the momentum compaction factor.  If empty, the mcf will be found from the getmcf 
%     function.  That mean the model must be correct for the dispersion to be scaled properly.  For
%     instance, when measuring the disperison of the injection lattice the model lattice
%     would have to reflect the injection lattice too.  If not, override mcf on the input line.
%     'Hardware' in the input line forces hardware units, usually mm/MHz.  The actual units will
%     depend on the units for the BPM and RF families.
%  7. 'Struct'  will return data structures instead of vectors {Default for data structure inputs}
%     'Numeric' will return vector outputs {Default for non-data structure inputs}
%  8. Optional override of the mode
%     'Online'    - Set/Get data online  
%     'Simulator' - Set/Get data on the simulated accelerator using AT (ie, same commands as 'Online')
%     'Model'     - (same as Simulator, use modeldisp to get the model dispersion with no BPM errors)
%     'Manual'    - Set/Get data manually
%  9. Optional display
%     'Display'   - Plot the dispersion {Default if no outputs exist}
%     'NoDisplay' - Dispersion will not be plotted {Default if outputs exist}
%  10.'NoArchive' - No file archive {Default}
%     'Archive'   - Save a dispersion data structure to \<Directory.DispData>\<DispArchiveFile><Date><Time>.mat
%                   To change the filename, included the filename after the 'Archive', '' to browse
%
%  OUTPUTS
%  For hardware units:
%  Dx = Delta BPMx / Delta RF and Dy = Delta BPMy / Delta RF
%       hence Dx and Dy are not quite the definition of dispersion
%
%               x2(RF0+DeltaRF/2) - x1(RF0-DeltaRF/2) 
%           D = -------------------------------------
%                              DeltaRF
%           
%           where RF0 = is the present RF frequency
%
%  For physics units:
%  DeltaRF is converted to change in energy, dp/p 
%
%  The units for orbit change depend on what the hardware or physics units are.  
%  Typical units are mm for hardware and meters for physics.
%
%  Structure outputs have the following fields:
%                  Data: [double] - orbit shift with RF or energy shift
%            FamilyName: 'DispersionX' or 'DispersionY'
%              Actuator: [1x1 struct] - RF structure with starting frequency
%         ActuatorDelta: Change in RF in hardware units
%               Monitor: [1x1 struct] - BPM structure with starting orbit
%                   GeV: Storage ring energy
%             TimeStamp: Clock (for example, [2003 7 9 0 21 36.2620])
%                  DCCT: Beam current
%      ModulationMethod: 'bipolar' or 'unipolar'
%              WaitFlag: BPM wait flag (usually -2)
%            ExtraDelay: 0
%        DataDescriptor: 'Dispersion'
%             CreatedBy: 'disp_tls'
%                   MCF: momentum compaction factor
%                 Units: 'Hardware' or 'Physics'
%           UnitsString: typically 'mm/MHz' or meters/(dp/p)
%                    dp: change in moment
%                 Orbit: [2 column vectors]  (orbit at RF0+DeltaRF/2 and RF0-DeltaRF/2)
%                    RF: [RF0+DeltaRF/2 RF0-DeltaRF/2] 
%
%  If no output exists, the dispersion function will be plotted to the screen.
%
%  NOTES
%  1. 'Hardware', 'Physics', 'Eta', 'Archive', 'Numeric', and 'Struct' are not case sensitive
%  2. 'Eta' can be used instead of 'Physics'
%  3.  Get and set the RF frequency are done with getrf and setrf
%  4.  RF frequency is changed by +/-(DeltaRF/2)
%  5.  All inputs are optional
%  6.  Units for DeltaRF depend on the 'Physics' or 'Hardware' flags
%
%  See also plotdisp, modeldisp, measchro

%  Written by Greg Portmann and Jeff Corbett


BPMxFamily = gethbpmfamily;
BPMyFamily = getvbpmfamily;
BPMxList = [];
BPMyList = [];
WaitFlag = -2;
ModulationMethod = 'bipolar';
StructOutputFlag = 0;
NumericOutputFlag = 0; 
ArchiveFlag = 1;
FileName = [];
DisplayFlag = 1;
ModeFlag = {};  % model, online, manual, or '' for default mode
UnitsFlag = 'Physics'; % hardware, physics, or '' for default units
MCF = [];


InputFlags = {};
for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignor structures
    elseif iscell(varargin{i})
        % Ignor cells
    elseif strcmpi(varargin{i},'struct')
        StructOutputFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'numeric')
        NumericOutputFlag = 1;
        StructOutputFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'archive')
        ArchiveFlag = 1;
        if length(varargin) > i
            % Look for a filename as the next input
            if ischar(varargin{i+1})
                FileName = varargin{i+1};
                varargin(i+1) = [];
            end
        end
        varargin(i) = [];
    elseif strcmpi(varargin{i},'noarchive')
        ArchiveFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'bipolar')
        ModulationMethod = 'bipolar';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'unipolar')
        ModulationMethod = 'unipolar';
        varargin(i) = [];
    elseif strcmpi(varargin{i},'eta') || strcmpi(varargin{i},'physics')
        UnitsFlag = 'Physics';
        varargin(i) = [];
        if length(varargin) >= i
            if isnumeric(varargin{i})
                MCF = varargin{i};
                varargin(i) = [];
            end
        end
    elseif strcmpi(varargin{i},'hardware')
        UnitsFlag = varargin{i};
        varargin(i) = [];
        if length(varargin) >= i
            if isnumeric(varargin{i})
                MCF = varargin{i};
                varargin(i) = [];
            end
        end
    elseif strcmpi(varargin{i},'simulator') || strcmpi(varargin{i},'model')
        ModeFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'online')
        ModeFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'manual')
        ModeFlag = varargin(i);
        varargin(i) = [];
    end        
end
handles = varargin{1,1};
varargin = [];
ExtraDelay = str2num(get(handles.S3, 'String'));
index = get(handles.S2, 'Value');
Method = get(handles.S2, 'String');
ModulationMethod = Method{index};
% Look for DeltaRF input
if length(varargin) >= 1
    if isnumeric(varargin{1})
        DeltaRF = varargin{1}; 
        varargin(1) = [];
    else
        DeltaRF = str2num(get(handles.S1, 'String'))*1000;
    end
else
    DeltaRF = str2num(get(handles.S1, 'String'))*1000;
end

% Look for BPMx family info
if length(varargin) >= 1
    if ischar(varargin{1})
        BPMxFamily = varargin{1};
        varargin(1) = [];
        if length(varargin) >= 1
            if isnumeric(varargin{1})
                BPMxList = varargin{1};
                varargin(1) = [];
            end
        end
    elseif isnumeric(varargin{1})
        BPMxList = varargin{1};
        varargin(1) = [];
    elseif isstruct(varargin{1})
        BPMxFamily = varargin{1}.FamilyName;
        BPMxList = varargin{1}.DeviceList;
        if isempty(UnitsFlag)
            UnitsFlag = varargin{1}.Units;
        end
        if ~NumericOutputFlag
            % Only change StructOutputFlag if 'numeric' is not on the input line
            StructOutputFlag = 1;
        end
        varargin(1) = [];      
    end
end

% Look for BPMy family info
if length(varargin) >= 1
    if ischar(varargin{1})
        BPMyFamily = varargin{1};
        varargin(1) = [];
        if length(varargin) >= 1
            if isnumeric(varargin{1})
                BPMyList = varargin{1};
                varargin(1) = [];
            end
        end
    elseif isnumeric(varargin{1})
        BPMyList = varargin{1};
        varargin(1) = [];
    elseif isstruct(varargin{1})
        BPMyFamily = varargin{1}.FamilyName;
        BPMyList = varargin{1}.DeviceList;
        if isempty(UnitsFlag)
            UnitsFlag = varargin{1}.Units;
        end
        if ~NumericOutputFlag
            % Only change StructOutputFlag if 'numeric' is not on the input line
            StructOutputFlag = 1;
        end
        varargin(1) = [];      
    end
end

% Look for WaitFlag input
if length(varargin) >= 1
    if isnumeric(varargin{1}) && ~isempty(varargin{1})
        WaitFlag = varargin{1}; 
        varargin(1) = [];
    end
end
% End of input parsing


% Archive data structure
if ArchiveFlag
    if isempty(FileName)
        FileName = appendtimestamp(getfamilydata('Default', 'DispArchiveFile'));
        DirectoryName = getfamilydata('Directory','DispData');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot') 'Dispersion', filesep];
        else
            % Make sure default directory exists
            DirStart = pwd;
            [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
            cd(DirStart);
        end
        [FileName, DirectoryName] = uiputfile('*.mat', 'Select Dispersion File', [DirectoryName FileName]);
        drawnow;
        if FileName == 0
            ArchiveFlag = 0;
            disp('   Dispersion measurement canceled.');
            Dx=[]; Dy=[]; FileName='';
            return
        end
        FileName = [DirectoryName, FileName];
    elseif FileName == -1
        FileName = appendtimestamp(getfamilydata('Default', 'DispArchiveFile'));
        DirectoryName = getfamilydata('Directory','DispData');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot') 'Dispersion', filesep];
        end
        FileName = [DirectoryName, FileName];
    end
end


% Get the input units
if isempty(UnitsFlag)
    RFUnitsInput = getfamilydata('RF','Setpoint','Units');
    UnitsFlag = RFUnitsInput;
else
    RFUnitsInput = UnitsFlag;
end


% Get DeltaRF in Hardware units
RFHWUnits = getfamilydata('RF','Setpoint','HWUnits');


% Make sure DeltaRF is in hardware units
if isempty(DeltaRF) || ~isnumeric(DeltaRF)
    % Get the default from the AD is in Hardware units
    DeltaRF = getfamilydata('DeltaRFDisp');
    
    % If the default is not in the AD
    if isempty(DeltaRF)
        % Here is the second level default
        DeltaRF = getrf('Hardware', ModeFlag{:}) * getmcf * .002;  % .2% energy change
    end

else
    if strcmpi(UnitsFlag, 'Physics')
        % Change to hardware
        RFUnitsInput = UnitsFlag;
        DeltaRF = physics2hw('RF', 'Setpoint', DeltaRF, []);
    end
end

% DeltaRF must be in hardware units at this point


% Use the AT model directly (measdisp or modeldisp)
if ~isempty(ModeFlag) && strcmpi(ModeFlag{1}, 'Model')
    % Measure in hardware and convert later
    if ~isempty(getcavity)
        % Simulator mode (just so that the BPM gain or rotation errors are in the dispersion)
        [HorDisp, VertDisp] = disp_tls(DeltaRF, BPMxFamily, BPMxList, BPMyFamily, BPMyList, WaitFlag, ModulationMethod, 'Simulator', 'Struct', 'Hardware');
    else
        % Use the AT model directly (Note:  no BPM gain or rotation errors!!!) 
        [HorDisp, VertDisp] = modeldisp(DeltaRF, BPMxFamily, BPMxList, BPMyFamily, BPMyList, ModulationMethod, 'Struct', 'Hardware');
        HorDisp.Actuator  = getrf('Model', 'Struct', 'Hardware');
        VertDisp.Actuator = HorDisp.Actuator;
        
        % Add BPM roll/crunch ???
    end
    
    % This might not always work (it's only a problem if the first input family is in the vertical plane)
    if ~isempty(strfind(lower(BPMxFamily),'y')) || ~isempty(strfind(lower(BPMxFamily),'v'))
        d(1) = VertDisp;
        d(2) = HorDisp;
        d(1).Monitor = getam(BPMyFamily, BPMyList, 'Model', 'Struct', 'Hardware');
        d(2).Monitor = getam(BPMxFamily, BPMxList, 'Model', 'Struct', 'Hardware');
    else
        d(1) = HorDisp;
        d(2) = VertDisp;
        d(1).Monitor = getam(BPMxFamily, BPMxList, 'Model', 'Struct', 'Hardware');
        d(2).Monitor = getam(BPMyFamily, BPMyList, 'Model', 'Struct', 'Hardware');
    end
    
    if isempty(MCF)
        MCF = getmcf('Model');
    end
        
else
    % Online & Simulation Modes
        
    % Check DeltaRF for resonable values
    DeltaRFphysics = hw2physics('RF', 'Setpoint', DeltaRF, []);
    if DeltaRFphysics > 15000;  % Hz
        tmp = questdlg(sprintf('%f Hz is a large RF change.  Do you want to continue?', DeltaRFphysics),'Dispersion Measurement','YES','NO','YES');
        if strcmp(tmp,'NO')
            Dx=[];  Dy=[];
            return
        end
    end


    % Dispersion can be found using the response matrix generation program
    if DisplayFlag
        %DispRespMat = measrespmat({getam(BPMxFamily,BPMxList,'Struct','Hardware',ModeFlag), getam(BPMyFamily,BPMyList,'Struct',ModeFlag)}, getsp('RF','Struct',ModeFlag), DeltaRF, ModulationMethod, WaitFlag, ExtraDelay, 'Struct', 'Display', 'Hardware', ModeFlag{:});
        DispRespMat = measrespmat_tls({BPMxFamily,BPMyFamily}, {BPMxList,BPMyList}, 'RF', [], DeltaRF, ModulationMethod, WaitFlag, ExtraDelay, 'Struct', 'Display', 'Hardware', ModeFlag{:},handles);
    else
        %DispRespMat = measrespmat({getam(BPMxFamily,BPMxList,'Struct','Hardware',ModeFlag), getam(BPMyFamily,BPMyList,'Struct',ModeFlag)}, getsp('RF','Struct',ModeFlag), DeltaRF, ModulationMethod, WaitFlag, ExtraDelay, 'Struct', 'NoDisplay', 'Hardware', ModeFlag{:});
        DispRespMat = measrespmat_tls({BPMxFamily,BPMyFamily}, {BPMxList,BPMyList}, 'RF', [], DeltaRF, ModulationMethod, WaitFlag, ExtraDelay, 'Struct', 'NoDisplay', 'Hardware', ModeFlag{:},handles);
    end
    
    d(1) = DispRespMat{1};
    d(2) = DispRespMat{2};

    
    % For multiple RF cavities in the model it's possible to get multiple columns in the response matrix
    if size(d(1).Data,2) > 1
        % More Actuators means the RF was implemented as multiple cavities and not 1 RF frequency
        % This is really not recommended!!!
        d(1).Data = sum(d(1).Data,2);        
        d(1).Actuator.Data       = d(1).Actuator.Data(1);
        d(1).Actuator.DeviceList = d(1).Actuator.DeviceList(1);
        d(1).Actuator.Status     = d(1).Actuator.Status(1);
        d(1).Actuator.DataTime   = d(1).Actuator.DataTime(1);
        
        d(2).Data = sum(d(2).Data,2);
        d(2).Actuator.Data       = d(2).Actuator.Data(1);
        d(2).Actuator.DeviceList = d(2).Actuator.DeviceList(1);
        d(2).Actuator.Status     = d(2).Actuator.Status(1);
        d(2).Actuator.DataTime   = d(2).Actuator.DataTime(1);
        
        DeltaRFphysics = DeltaRFphysics(1);
    end


    % Get the momentum compaction factor in if was not on the input line
    if isempty(MCF)
        MCF = getmcf(ModeFlag);
    end
end


% Family name is not needed
%d(1).FamilyName = 'DispersionX';
%d(2).FamilyName = 'DispersionY';

d(1).GeV = getenergy(ModeFlag{:});
d(2).GeV = d(1).GeV;


for i = 1:2
    d(i).MCF = MCF;
    d(i).dp = -DeltaRF / (d(i).Actuator.Data * MCF);    
    d(i).Mode = d(i).Actuator.Mode;
    d(i).Units = d(i).Actuator.Units;
    d(i).UnitsString = [d(i).Monitor.UnitsString,'/',d(i).Actuator.UnitsString];
    d(i).OperationalMode = getfamilydata('OperationalMode');
    d(i).DataDescriptor = 'Dispersion';
    d(i).CreatedBy = 'disp_tls';
end


% Final units conversion
if strcmpi(RFUnitsInput, 'Physics')
    d = hw2physics(d);
end


% Plot if no output
if DisplayFlag
    %figure;
    plotdisp_tls(d(1),d(2),handles);
end


% Archive data structure
if ArchiveFlag
    % If the filename contains a directory then make sure it exists
    [DirectoryName, FileName, Ext] = fileparts(FileName);
    DirStart = pwd;
    [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
    BPMxDisp = d(1);
    BPMyDisp = d(2);
    save(FileName, 'BPMxDisp', 'BPMyDisp');
    if DisplayFlag
        fprintf('   Dispersion data saved to %s.mat\n', [DirectoryName FileName]);
        if ErrorFlag
            fprintf('   Warning: %s was not the desired directory\n', DirectoryName);
        end
    end
    cd(DirStart);
    FileName = [DirectoryName, FileName, '.mat'];
end
if FileName == -1
    FileName = '';
end


% Output
if StructOutputFlag
    Dx = d(1);
    Dy = d(2);
else
    Dx = d(1).Data;
    Dy = d(2).Data;
end


if DisplayFlag
    fprintf('   Dispersion measurement complete\n');
end


% --- Executes on selection change in S2.
function S2_Callback(hObject, eventdata, handles)
% hObject    handle to S2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns S2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from S2


% --- Executes during object creation, after setting all properties.
function S2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function S = measrespmat_tls(varargin)
%MEASRESPMAT - Measure a response matrix
%
%  For family name, device list inputs:
%  S = measrespmat(MonitorFamily, MonitorDeviceList, ActuatorFamily, ActuatorDeviceList, ActuatorDelta, ModulationMethod, WaitFlag, ExtraDelay)
%
%  For data structure inputs: 
%  S = measrespmat(MonitorStruct, ActuatorStruct, ActuatorDelta, ModulationMethod, WaitFlag, ExtraDelay)
%
%  INPUTS
%  1. MonitorFamily       - AcceleratorObjects family name for monitors
%     MonitorDeviceList   - AcceleratorObjects device list for monitors (element or device)
%                           (MonitorFamily and MonitorDeviceList can be cell arrays)
%     or 
%     MonitorStruct can replace MonitorFamily and MonitorDeviceList
%
%  2. ActuatorFamily      - AcceleratorObjects family name for actuators
%     ActuatorDeviceList  - AcceleratorObjects device list for actuators (element or device)
%     or 
%     ActuatorStruct can replace ActuatorFamily and ActuatorDeviceList
%
%  3. ActuatorDelta    - Change in actuator {Default: getfamilydata('ActuatorFamily','Setpoint','DeltaRespMat')}
%  4. ModulationMethod - Method for changing the ActuatorFamily
%                       'bipolar' changes the ActuatorFamily by +/- ActuatorDelta/2 on each step {Default}
%                       'unipolar' changes the ActuatorFamily from 0 to ActuatorDelta on each step
%  5. WaitFlag - (see setpv for WaitFlag definitions) {Default: []}
%                WaitFlag = -5 will override gets to manual mode
%
%  6. ExtraDelay - Extra time delay [seconds] after a setpoint change
%
%  7. 'Struct'  - Output will be a response matrix structure {Default for data structure inputs}
%     'Numeric' - Output will be a numeric matrix            {Default for non-data structure inputs}
%
%  8. Optional override of the units:
%     'Physics'  - Use physics  units
%     'Hardware' - Use hardware units
%
%  9. Optional override of the mode:
%     'Online' - Set/Get data online  
%     'Model'  - Set/Get data on the model (same as 'Simulator')
%     'Manual' - Set/Get data manually
%
%  10. 'Display'    - Prints status information to the command window {Default}
%      'NoDisplay'  - Nothing is printed to the command window
%
%  11. 'MinimumBeamCurrent' - Minimum beam current before prompting for a refill
%                             The current (as returned by getdcct) must follow the flag. 
%                             measbpmresp('MinimumBeamCurrent', 32.1) 
%                             will pause at a beam current of 32.1 and prompt for a refill.
%
%  OUTPUTS
%  1. S = Response matrix
%
%     For stucture outputs:
%     S(Monitor, Actuator).Data - Response matrix
%                         .Monitor - Monitor data structure (starting orbit)
%                         .Monitor1 - First  data point matrix
%                         .Monitor2 - Second data point matrix
%                         .Actuator - Corrector data structure
%                         .ActuatorDelta - Corrector kick vector
%                         .GeV - Electron beam energy
%                         .ModulationMethod - 'unipolar' or 'bipolar'
%                         .WaitFlag - Wait flag used when acquiring data
%                         .ExtraDelay - Extra time delay 
%                         .TimeStamp - Matlab clock at the start of each actuator family
%                         .CreatedBy
%                         .DCCT
%
%  NOTES
%  1. If MonitorFamily and MonitorDeviceList are cell arrrays, then S is a cell array of response matrices.
%  2. ActuatorFamily, ActuatorDeviceList, ActuatorDelta, ModulationMethod, WaitFlag are not cell arrrays.
%  3. If ActuatorDeviceList is empty, then the entire family is change together.
%  4. Bipolar mode changes the actuator by +/- ActuatorDelta/2
%  5. Unipolar mode changes the actuator by ActuatorDelta
%  6. Return values are MonitorChange/ActuatorDelta (normalized)
%  7. When using cell array inputs don't mix structure data inputs with non-structure data
%
%  EXAMPLES
%  1. 2x2 tune response matrix for QF and QD families:
%     TuneRmatrix = [measrespmat('TUNE',[1;2],'QF',[],.5,'unipolar') ... 
%                    measrespmat('TUNE',[1;2],'QD',[],.5,'unipolar')];
%
%  2. Orbit response matrix for all the horizontal correctors (+/-1 kick amplitude):
%     Smat = measrespmat({'BPMx','BPMy'}, {family2dev('BPMx'),family2dev('BPMy')}, 'HCM', family2dev('HCM'),1,'bipolar',-2);
%     The output is stored in a cell array.  Smat{1} is the horizontal plane and Smat{2} is the vertical cross plane.
%
%  3. Orbit response matrix for all the horizontal correctors (Default kick amplitude):
%     Smat = measrespmat(getx('Struct'), getsp('HCM','struct'));

%  Written by Greg Portmann


% Initialize
ActuatorDelta = [];
ActuatorDeviceList = [];
ModulationMethod = 'bipolar';
WaitFlag = [];
WaitFlagMonitor = 0;
ExtraDelay = 1; % 2009/05/08
StructOutputFlag = 0;
NumericOutputFlag = 0;
DisplayFlag = 1;
ModeFlagCell = {};
UnitsFlagCell = {};
DCCTStopFlag = 0;

InputFlags = {};
for i = length(varargin):-1:1
    if isstruct(varargin{i})
        % Ignor structures
    elseif iscell(varargin{i})
        % Ignor cells
    elseif strcmpi(varargin{i},'Struct')
        StructOutputFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Numeric')
        NumericOutputFlag = 1;
        StructOutputFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Simulator') || strcmpi(varargin{i},'Model')
        ModeFlagCell = varargin(i);
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Online')
        ModeFlagCell = varargin(i);
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Manual')
        ModeFlagCell = varargin(i);
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Physics')
        UnitsFlagCell = varargin(i);
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Hardware')
        UnitsFlagCell = varargin(i);
        InputFlags = [InputFlags varargin(i)];
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'MinimumBeamCurrent')
        DCCTStopFlag = 1;
        DCCTStop = varargin{i+1};
        varargin(i+1) = [];
        varargin(i) = [];
    end
end


if length(varargin) < 2
    error('Not enough inputs')
end
handles = varargin{length(varargin)};


% Find out if the inputs are data structures
StructInputFlag = 0;
if isstruct(varargin{1})
    StructInputFlag = 1;
elseif iscell(varargin{1})
    if isstruct(varargin{1}{1})
        StructInputFlag = 1;
    end
end


if StructInputFlag
    % S = measrespmat(MonitorStruct, ActuatorStruct, ActuatorDelta, ModulationMethod, WaitFlag, ExtraDelay)
    if length(varargin) < 2
        error('At least 2 inputs required in structure mode.');
    end
    
    % Only change StructOutputFlag if 'numeric' is not on the input line
    if ~NumericOutputFlag
        StructOutputFlag = 1;
    end
    
    MonitorStruct = varargin{1};
    ActuatorStruct = varargin{2};
    if ~isstruct(ActuatorStruct)
        error('If monitors are data structures, then the actuator must also be a data structure.');
    end
    
    if iscell(varargin{1})
        for j = 1:length(MonitorStruct)
            if ~isstruct(MonitorStruct{j})
                error('All monitors in the cell must be data structures or not (mixing methods not allowed).');
            end
            
            MonitorFamily{j} = MonitorStruct{j}.FamilyName;
            MonitorDeviceList{j} = MonitorStruct{j}.DeviceList;
        end
    else
        MonitorFamily = MonitorStruct.FamilyName;
        MonitorDeviceList = MonitorStruct.DeviceList;
    end
    ActuatorFamily = ActuatorStruct.FamilyName;
    ActuatorDeviceList = ActuatorStruct.DeviceList;
    if length(varargin) >= 3
        ActuatorDelta = varargin{3};
    end
    if length(varargin) >= 4
        ModulationMethod = varargin{4};
    end
    if length(varargin) >= 5
        WaitFlag = varargin{5};
    end
    if length(varargin) >= 6
        ExtraDelay = varargin{6};
    end
else
    % S = measrespmat(MonitorFamily, MonitorDeviceList, ActuatorFamily, ActuatorDeviceList, ActuatorDelta, ModulationMethod, WaitFlag, ExtraDelay)
    if length(varargin) < 3
        error('At least 3 inputs required ');
    end
    MonitorFamily = varargin{1};
    MonitorDeviceList = varargin{2};
    ActuatorFamily = varargin{3};
    if length(varargin) >= 4
        ActuatorDeviceList = varargin{4};
    end
    if length(varargin) >= 5
        ActuatorDelta = varargin{5};
    end
    if length(varargin) >= 6
        ModulationMethod = varargin{6};
    end
    if length(varargin) >= 7
        WaitFlag = varargin{7};
    end
    if length(varargin) >= 8
        ExtraDelay = varargin{8};
    end
end

% Remove extra delay for model
if any(strcmpi('Model', ModeFlagCell)) || any(strcmpi('Simulator', ModeFlagCell))
    if isempty(ExtraDelay)
        ExtraDelay = 0;
    end
end

if isempty(ModulationMethod)
    ModulationMethod = 'bipolar';
elseif ~strcmpi(ModulationMethod, 'unipolar') && ~strcmpi(ModulationMethod, 'bipolar')
    error('ModulationMethod must be ''unipolar'' or ''bipolar''');
end


% Force to be a cells of equal length
if ~iscell(MonitorFamily)
    MonitorFamily = {MonitorFamily};
end
if ~iscell(MonitorDeviceList)
    MonitorDeviceList = {MonitorDeviceList};
end
if ~iscell(ActuatorFamily)
    ActuatorFamily = {ActuatorFamily};
end
if isempty(ActuatorDeviceList)
    for i = 1:length(ActuatorFamily)
        ActuatorDeviceList{i} = [];
    end
elseif ~iscell(ActuatorDeviceList)
    ActuatorDeviceList = {ActuatorDeviceList};
end
if isempty(ActuatorDelta)
    for i = 1:length(ActuatorFamily)
        ActuatorDelta{i} = [];
    end
elseif ~iscell(ActuatorDelta)
    ActuatorDelta = {ActuatorDelta};
end


% Force column for monitors and rows for actuators
MonitorFamily = MonitorFamily(:);
MonitorDeviceList = MonitorDeviceList(:);
ActuatorFamily = ActuatorFamily(:)';
ActuatorDeviceList = ActuatorDeviceList(:)';
ActuatorDelta = ActuatorDelta(:)';


% Check length of cell inputs
if length(MonitorFamily) ~= length(MonitorDeviceList)
    error('The length of MonitorFamily (cell) must equal the length of MonitorDeviceList (cell)');
end
if length(ActuatorFamily) ~= length(ActuatorDeviceList)
    error('The length of ActuatorFamily (cell) must equal the length of ActuatorDeviceList (cell)');
end
if length(ActuatorFamily) ~= length(ActuatorDelta)
    error('The length of ActuatorFamily (cell) must equal the length of ActuatorDelta (cell)');
end


% Manual mode for monitors
WaitFlagMonitor = WaitFlag;
if WaitFlag == -5
    WaitFlag = 0;
end


% First get all defaults and do some error checking 
for iActFam = 1:length(ActuatorFamily)
    % Convert element list to a device list if necessary
    if size(ActuatorDeviceList{iActFam},2) == 1
        ActuatorDeviceList{iActFam} = elem2dev(ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam});
    end
    
    % Get ActuatorDelta if empty
    if isempty(ActuatorDelta{iActFam})
        % Find the delta from the AO (.DeltaRespMat is always hardware!!!)
        ActuatorDelta{iActFam} = getfamilydata(ActuatorFamily{iActFam}, 'Setpoint', 'DeltaRespMat', ActuatorDeviceList{iActFam});
        if isempty(ActuatorDelta{iActFam})
            error(sprintf('%s.Setpoint.DeltaRespMat field must be set properly',ActuatorFamily{iActFam}));
        end
        
        % Check if ActuatorDelta needs a units conversion
        if strcmpi(UnitsFlagCell,{'Physics'})
            % UnitsFlagCell comes from an input
            % Since hw2physics conversion can be nonlinear, do conversion about the present setpoint
            SPh = getpv(ActuatorFamily{iActFam}, 'Setpoint', ActuatorDeviceList{iActFam}, 'Hardware', ModeFlagCell{:});
            SPp = getpv(ActuatorFamily{iActFam}, 'Setpoint', ActuatorDeviceList{iActFam}, 'Physics',  ModeFlagCell{:});
            ActuatorDelta{iActFam} = hw2physics(ActuatorFamily{iActFam}, 'Setpoint', SPh+ActuatorDelta{iActFam}, ActuatorDeviceList{iActFam}, ModeFlagCell{:}) - SPp;
        else
            % If units were not input, then get the present family units
            Units = getfamilydata(ActuatorFamily{iActFam}, 'Setpoint', 'Units');
            if strcmpi(Units, 'Physics')
                % Since hw2physics conversion can be nonlinear, do conversion about the present setpoint
                SPh = getpv(ActuatorFamily{iActFam}, 'Setpoint', ActuatorDeviceList{iActFam}, 'Hardware', ModeFlagCell{:});
                SPp = getpv(ActuatorFamily{iActFam}, 'Setpoint', ActuatorDeviceList{iActFam}, 'Physics',  ModeFlagCell{:});
                ActuatorDelta{iActFam} = hw2physics(ActuatorFamily{iActFam}, 'Setpoint', SPh+ActuatorDelta{iActFam}, ActuatorDeviceList{iActFam}, ModeFlagCell{:}) - SPp;
            end
        end
        % Old method checked for the default units of the .DeltaRespMat field.  Now it's always hardware units
        %if strcmpi(UnitsFlagCell,{'Hardware'}) & strcmpi(Units, 'Physics')
        %    ActuatorDelta{iActFam} = physics2hw(ActuatorFamily{iActFam}, 'Setpoint', ActuatorDelta{iActFam}, ActuatorDeviceList{iActFam}, ModeFlagCell{:});        
        %end
    end
    if isempty(ActuatorDelta{iActFam})
        error('ActuatorDelta is empty.  Must be an input or in the family structure (.DeltaRespMat in hardware units)');
    end
    if ~isnumeric(ActuatorDelta{iActFam})
        error('ActuatorDelta must be numeric.');
    end
    
    % Force ActuatorDelta to be a column vector
    ActuatorDelta{iActFam} = ActuatorDelta{iActFam}(:);
    
    % Check for entire family
    if isempty(ActuatorDeviceList{iActFam})
        % Set the entire family at once
        iActDeviceTotal{iActFam} = 1;
        
        % Expand a scalar to all devices
        if length(ActuatorDelta{iActFam}) == 1
            % OK
        elseif length(ActuatorDelta{iActFam}) == length(family2dev(ActuatorFamily{iActFam}))
            % OK
        else
            error('ActuatorDelta must be a scalar or equal in length to the number of devices');
        end
    else
        iActDeviceTotal{iActFam} = size(ActuatorDeviceList{iActFam},1);
        
        % Expand a scalar to all devices if scalar
        if length(ActuatorDelta{iActFam}) == 1
            ActuatorDelta{iActFam} = ActuatorDelta{iActFam} * ones(iActDeviceTotal{iActFam},1);
        end
        % Size of ActuatorDelta must equal total number of devices 
        if length(ActuatorDelta{iActFam}) ~= iActDeviceTotal{iActFam}
            error('ActuatorDelta must be a scalar or equal in length to the number of devices');
        end
    end
    
    % Check for zeros
    if any(ActuatorDelta{iActFam} == 0)
        error('At least one the actuator deltas is zero.');
    end

    % Get initial actuator values
    ActuatorStart{iActFam} = getsp(ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam}, 'Struct', InputFlags{:});
    InitActuator = ActuatorStart{iActFam}.Data;
    
    % Check actuator limits 
    if strcmpi(ModulationMethod, 'unipolar')
        % unipolar measurement
        [LimitFlag, LimitList] = checklimits(ActuatorFamily{iActFam}, InitActuator+ActuatorDelta{iActFam}, ActuatorDeviceList{iActFam}, UnitsFlagCell{:});
        if LimitFlag
            if isempty(ActuatorDeviceList{iActFam})
                ActuatorDeviceList{iActFam} = family2dev(ActuatorFamily{iActFam});
            end
            MagnetString = sprintf('%s(%d,%d)=%f, Delta=%f', ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam}(LimitList(1),:), InitActuator(LimitList(1)), ActuatorDelta{iActFam}(LimitList(1)));
            error(['Actuator limit would be exceeded (Setpoint+Delta) (', MagnetString, ')']);
        end
    elseif strcmpi(ModulationMethod, 'bipolar')
        % bipolar measurement
        [LimitFlag, LimitList] = checklimits(ActuatorFamily{iActFam}, InitActuator-ActuatorDelta{iActFam}/2, ActuatorDeviceList{iActFam}, UnitsFlagCell{:});
        if LimitFlag
            if isempty(ActuatorDeviceList{iActFam})
                ActuatorDeviceList{iActFam} = family2dev(ActuatorFamily{iActFam});
            end
            MagnetString = sprintf('%s(%d,%d)=%f, Delta=%f', ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam}(LimitList(1),:), InitActuator(LimitList(1)), ActuatorDelta{iActFam}(LimitList(1)));
            error(['Actuator limit would be exceeded (Setpoint-Delta/2) (', MagnetString, ')']);
        end
        [LimitFlag, LimitList] = checklimits(ActuatorFamily{iActFam}, InitActuator+ActuatorDelta{iActFam}/2, ActuatorDeviceList{iActFam}, UnitsFlagCell{:});
        if LimitFlag
            if isempty(ActuatorDeviceList{iActFam})
                ActuatorDeviceList{iActFam} = family2dev(ActuatorFamily{iActFam});
            end
            MagnetString = sprintf('%s(%d,%d)=%f, Delta=%f', ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam}(LimitList(1),:), InitActuator(LimitList(1)), ActuatorDelta{iActFam}(LimitList(1)));
            error(['Actuator limit would be exceeded (Setpoint+Delta/2) (', MagnetString, ')']);
        end
    end
end


if DisplayFlag
    fprintf('   Measuring response using a %s actuator method\n', lower(ModulationMethod));
end
RF = getrf;
Q = gettune;


% Begin main loop over actuators
StopNow = 0;
for iActFam = 1:length(ActuatorFamily)
    t0 = clock;
    clear R;
        
    % Get initial monitor values
    if StructOutputFlag
        if WaitFlagMonitor == -5
            MonitorStart = getam(MonitorFamily, MonitorDeviceList, 'Struct', 'Manual', UnitsFlagCell{:});
        else
            MonitorStart = getam(MonitorFamily, MonitorDeviceList, 'Struct', InputFlags{:});
        end
        if isfamily('DCCT')
            DCCTStart = getdcct(ModeFlagCell{:});
        else
            DCCTStart = NaN;
        end
    end
    
    % Get initial actuator values
    InitActuator = ActuatorStart{iActFam}.Data;
    
    % Just to display common names (empty if not using common names)
    CommonNameList = family2common(ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam});

    % Iterate on each actuator in the device list
    if DisplayFlag % & ~isempty(ActuatorDeviceList{iActFam})  %iActDeviceTotal{iActFam} > 1
        fprintf('\n   %s family response matrix\n', ActuatorFamily{iActFam});
    end
    
    % Individual actuator loop
    for iActDevice = 1:iActDeviceTotal{iActFam}
        if ~isempty(CommonNameList)
            CommonName = [deblank(CommonNameList(iActDevice,:)), ' '];
            if strcmpi(deblank(CommonName), ActuatorFamily{iActFam})
                CommonName = '';
            end
        end

        % Remove the CommonName for now
        CommonName = '';

        % Step actuator down for bipolar
        try
            if strcmpi(ModulationMethod, 'bipolar')
                if isempty(ActuatorDeviceList{iActFam})
                    if DisplayFlag
                        fprintf('   %s family nominal value is %f [%s]\n', ActuatorFamily{iActFam}, InitActuator(1), ActuatorStart{iActFam}.UnitsString);
                        fprintf('   Changing family by %+f [%s] from nominal\n', -ActuatorDelta{iActFam}(1)/2, ActuatorStart{iActFam}.UnitsString);
                        drawnow;
                        set(handles.IF1, 'String', getrf);
                        set(handles.IF2, 'String', getrf-RF);
                        set(handles.IF3, 'String', getdcct);
                        set(handles.IF4, 'String', getenergy);
                        Tune = gettune;
                        set(handles.IF5, 'String', Tune(1)-Q(1));
                        set(handles.IF6, 'String', Tune(2)-Q(2));
                    end
                    DeltaActuator =                InitActuator-ActuatorDelta{iActFam}/2;
                    setsp(ActuatorFamily{iActFam}, InitActuator-ActuatorDelta{iActFam}/2, ActuatorDeviceList{iActFam}, WaitFlag, InputFlags{:});
                else
                    if DisplayFlag
                        fprintf('   %d. %s%s(%d,%d) nominal value is %f [%s]\n', iActDevice, CommonName, ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam}(iActDevice,:), InitActuator(iActDevice), ActuatorStart{iActFam}.UnitsString);
                        fprintf('   %d. Changing actuator by %+f [%s] from nominal\n', iActDevice, -ActuatorDelta{iActFam}(iActDevice)/2, ActuatorStart{iActFam}.UnitsString);
                        drawnow;
                    end
                    DeltaActuator =                InitActuator(iActDevice)-ActuatorDelta{iActFam}(iActDevice)/2;
                    setsp(ActuatorFamily{iActFam}, InitActuator(iActDevice)-ActuatorDelta{iActFam}(iActDevice)/2, ActuatorDeviceList{iActFam}(iActDevice,:), WaitFlag, InputFlags{:});
                end
            elseif strcmpi(ModulationMethod, 'unipolar')
                if isempty(ActuatorDeviceList{iActFam})
                    DeltaActuator = InitActuator(1);
                else
                    DeltaActuator = InitActuator(iActDevice);
                end
                if DisplayFlag
                    if isempty(ActuatorDeviceList{iActFam})
                        fprintf('   %s family nominal value is %f [%s]\n', ActuatorFamily{iActFam}, InitActuator(1), ActuatorStart{iActFam}.UnitsString);
                        %fprintf('   No change to actuator\n');
                        drawnow;
                        set(handles.IF1, 'String', getrf);
                        set(handles.IF2, 'String', getrf-RF);
                        set(handles.IF3, 'String', getdcct);
                        set(handles.IF4, 'String', getenergy);
                        Tune = gettune;
                        set(handles.IF5, 'String', Tune(1)-Q(1));
                        set(handles.IF6, 'String', Tune(2)-Q(2));
                    else
                        fprintf('   %d. %s%s(%d,%d) nominal value is %f [%s]\n', iActDevice, CommonName, ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam}(iActDevice,:), InitActuator(iActDevice), ActuatorStart{iActFam}.UnitsString);
                        %fprintf('   %d. No change to actuator\n', iActDevice);
                        drawnow;
                    end
                end
            end
            
        catch
            fprintf('   %s\n', lasterr);
            if isempty(ActuatorDeviceList{iActFam})
                FamilyMessage = sprintf('An error occurred setting %s to %f [%s].\n', ActuatorFamily{iActFam}, InitActuator(iActDevice), DeltaActuator, ActuatorStart{iActFam}.UnitsString);
            else
                FamilyMessage = sprintf('An error occurred setting %s(%d,%d) to %f [%s].\n', ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam}(iActDevice,:), DeltaActuator, ActuatorStart{iActFam}.UnitsString);
            end
            CommandInput = questdlg( ...
                strvcat(FamilyMessage, ...
                strvcat('Either manually varify that the magnet is at the proper setpoint', ...
                strvcat('and continue measuring the response matrix or stop','the response matrix measurement?'))), ...
                'MEASRESPMAT', ...
                'Continue', ...
                'Stop', ...
                'Continue');
            switch CommandInput
                case 'Stop'
                    error('Response matrix measurement stopped.');
                    %S = {}
                    %return;
                case 'Continue'
                    %keyboard
            end
        end

        % Wait for signal processing if requested
        sleep(ExtraDelay);
        h = msgbox(' Continue the process? ','','warn');
        hm = findall(h,'Type','Text');
        set(hm,'color','b');
        set(hm,'FontSize',10);
        set(hm,'FontWeight','bold');
        waitfor(h);
        set(handles.IF1, 'String', getrf);
        set(handles.IF2, 'String', getrf-RF);
        set(handles.IF3, 'String', getdcct);
        set(handles.IF4, 'String', getenergy);
        Tune = gettune;
        set(handles.IF5, 'String', Tune(1)-Q(1));
        set(handles.IF6, 'String', Tune(2)-Q(2));
        %if DisplayFlag
        %    fprintf('   Recording data point #1\n'); drawnow;
        %end

        % Acquire data
        if WaitFlagMonitor == -5
            Xm = getam(MonitorFamily, MonitorDeviceList, 'Manual', UnitsFlagCell{:});
        else
            Xm = getam(MonitorFamily, MonitorDeviceList, InputFlags{:});
        end

        % Step actuator up
        try
            if strcmpi(ModulationMethod, 'bipolar')
                if isempty(ActuatorDeviceList{iActFam})
                    if DisplayFlag
                        fprintf('   Changing family by %+f [%s] from nominal\n', ActuatorDelta{iActFam}(1)/2, ActuatorStart{iActFam}.UnitsString);
                        drawnow;
                    end
                    DeltaActuator =                InitActuator+ActuatorDelta{iActFam}/2;
                    setsp(ActuatorFamily{iActFam}, InitActuator+ActuatorDelta{iActFam}/2, ActuatorDeviceList{iActFam}, WaitFlag, InputFlags{:});
                else
                    if DisplayFlag
                        fprintf('   %d. Changing actuator by %+f [%s] from nominal\n', iActDevice, ActuatorDelta{iActFam}(iActDevice)/2, ActuatorStart{iActFam}.UnitsString);
                        drawnow;
                    end
                    DeltaActuator =                InitActuator(iActDevice)+ActuatorDelta{iActFam}(iActDevice)/2;
                    setsp(ActuatorFamily{iActFam}, InitActuator(iActDevice)+ActuatorDelta{iActFam}(iActDevice)/2, ActuatorDeviceList{iActFam}(iActDevice,:), WaitFlag, InputFlags{:});
                end
            elseif strcmpi(ModulationMethod, 'unipolar')
                if isempty(ActuatorDeviceList{iActFam})
                    if DisplayFlag
                        fprintf('   Changing family by %+f [%s] from nominal\n', ActuatorDelta{iActFam}(1), ActuatorStart{iActFam}.UnitsString);
                        drawnow;
                    end
                    DeltaActuator =                InitActuator+ActuatorDelta{iActFam};
                    setsp(ActuatorFamily{iActFam}, InitActuator+ActuatorDelta{iActFam}, ActuatorDeviceList{iActFam}, WaitFlag, InputFlags{:});
                else
                    if DisplayFlag
                        fprintf('   %d. Changing actuator by %+f [%s] from nominal\n', iActDevice, ActuatorDelta{iActFam}(iActDevice), ActuatorStart{iActFam}.UnitsString);
                        drawnow;
                    end
                    DeltaActuator =                InitActuator(iActDevice)+ActuatorDelta{iActFam}(iActDevice);
                    setsp(ActuatorFamily{iActFam}, InitActuator(iActDevice)+ActuatorDelta{iActFam}(iActDevice), ActuatorDeviceList{iActFam}(iActDevice,:), WaitFlag, InputFlags{:});
                end
            end
        catch
            fprintf('   %s\n', lasterr);
            if isempty(ActuatorDeviceList{iActFam})
                FamilyMessage = sprintf('An error occurred setting %s to %f [%s].\n', ActuatorFamily{iActFam}, InitActuator(iActDevice), DeltaActuator, ActuatorStart{iActFam}.UnitsString);
            else
                FamilyMessage = sprintf('An error occurred setting %s(%d,%d) to %f [%s].\n', ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam}(iActDevice,:), DeltaActuator, ActuatorStart{iActFam}.UnitsString);
            end
            CommandInput = questdlg( ...
                strvcat(FamilyMessage, ...
                strvcat('Either manually varify that the magnet is at the proper setpoint', ...
                strvcat('and continue measuring the response matrix or stop','the response matrix measurement?'))), ...
                'MEASRESPMAT', ...
                'Continue', ...
                'Stop', ...
                'Continue');
            switch CommandInput
                case 'Stop'
                    error('Response matrix measurement stopped.');
                    %S = {}
                    %return;
                case 'Continue'
                    %keyboard
            end
        end

        % Wait for signal processing if requested
        sleep(ExtraDelay);
        h = msgbox(' Continue the process? ','','warn');
        hm = findall(h,'Type','Text');
        set(hm,'color','b');
        set(hm,'FontSize',10);
        set(hm,'FontWeight','bold');
        waitfor(h);
        set(handles.IF1, 'String', getrf);
        set(handles.IF2, 'String', getrf-RF);
        set(handles.IF3, 'String', getdcct);
        set(handles.IF4, 'String', getenergy);
        Tune = gettune;
        set(handles.IF5, 'String', Tune(1)-Q(1));
        set(handles.IF6, 'String', Tune(2)-Q(2));
        if DisplayFlag
            %fprintf('   Recording data point #2\n'); drawnow;
        end

        % Acquire data
        if WaitFlagMonitor == -5
            Xp = getam(MonitorFamily, MonitorDeviceList, 'Manual', UnitsFlagCell{:});
        else
            Xp = getam(MonitorFamily, MonitorDeviceList, InputFlags{:});
        end

        % Restore actuators
        try
            if isempty(ActuatorDeviceList{iActFam})
                DeltaActuator = InitActuator;
                if WaitFlag == -2
                    WaitFlagReset = -1;
                else
                    WaitFlagReset = WaitFlag;
                end
                setsp(ActuatorFamily{iActFam}, InitActuator, ActuatorDeviceList{iActFam}, WaitFlagReset, InputFlags{:});
                if DisplayFlag
                    if strcmpi(ActuatorStart{iActFam}.Mode, 'Manual')
                        fprintf('   %s family reset\n', ActuatorFamily{iActFam});
                    else
                        FinalSP = getsp(ActuatorFamily{iActFam}, InputFlags{:});
                        fprintf('   %s family reset to %f [%s]\n', ActuatorFamily{iActFam}, FinalSP(1), ActuatorStart{iActFam}.UnitsString);
                    end
                end
            else
                DeltaActuator = InitActuator(iActDevice);
                if WaitFlag == -2
                    WaitFlagReset = -1;
                else
                    WaitFlagReset = WaitFlag;
                end
                setsp(ActuatorFamily{iActFam}, InitActuator(iActDevice), ActuatorDeviceList{iActFam}(iActDevice,:), WaitFlagReset, InputFlags{:});
                if DisplayFlag
                    if strcmpi(ActuatorStart{iActFam}.Mode,'Manual')
                        fprintf('   %d. %s%s(%d,%d) reset\n', iActDevice, CommonName, ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam}(iActDevice,:));
                    else
                        fprintf('   %d. %s%s(%d,%d) reset to %f [%s]\n', iActDevice, CommonName, ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam}(iActDevice,:), getsp(ActuatorFamily{iActFam},ActuatorDeviceList{iActFam}(iActDevice,:)), ActuatorStart{iActFam}.UnitsString);
                    end
                end
            end
            drawnow;
        catch
            fprintf('   %s\n', lasterr);
            if isempty(ActuatorDeviceList{iActFam})
                FamilyMessage = sprintf('An error occurred setting %s to %f [%s].\n', ActuatorFamily{iActFam}, InitActuator(iActDevice), DeltaActuator, ActuatorStart{iActFam}.UnitsString);
            else
                FamilyMessage = sprintf('An error occurred setting %s(%d,%d) to %f [%s].\n', ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam}(iActDevice,:), DeltaActuator, ActuatorStart{iActFam}.UnitsString);
            end
            CommandInput = questdlg( ...
                strvcat(FamilyMessage, ...
                strvcat('Either manually varify that the magnet is at the proper setpoint', ...
                strvcat('and continue measuring the response matrix or stop','the response matrix measurement?'))), ...
                'MEASRESPMAT', ...
                'Continue', ...
                'Stop', ...
                'Continue');
            switch CommandInput
                case 'Stop'
                    error('Response matrix measurement stopped.');
                    %S = {}
                    %return;
                case 'Continue'
                    %keyboard
            end
        end

        if DisplayFlag && (iActDevice < iActDeviceTotal{iActFam})
            fprintf('\n');
        end
        sleep(ExtraDelay);
        h = msgbox(' Continue the process? ','','warn');
        hm = findall(h,'Type','Text');
        set(hm,'color','b');
        set(hm,'FontSize',10);
        set(hm,'FontWeight','bold');
        waitfor(h);
        set(handles.IF1, 'String', getrf);
        set(handles.IF2, 'String', getrf-RF);
        set(handles.IF3, 'String', getdcct);
        set(handles.IF4, 'String', getenergy);
        Tune = gettune;
        set(handles.IF5, 'String', Tune(1)-Q(1));
        set(handles.IF6, 'String', Tune(2)-Q(2));
        % Compute differences
        for iMonFam = 1:length(MonitorFamily)
            if isempty(ActuatorDeviceList{iActFam})
                % Compute response matrix columns
                % For each magnet:  1. Divide by the change in amperes, like [Tune / Ampere]
                %                   2. Scale each magnet by its fractional contribution in physics units (should use K*L, not just K)
                if strcmpi(family2units(ActuatorFamily{iActFam},'Setpoint'),'Hardware')
                    DeltaPhysics = hw2physics(ActuatorFamily{iActFam}, 'Setpoint', InitActuator+ActuatorDelta{iActFam}, ActuatorDeviceList{iActFam}, ModeFlagCell{:}) - hw2physics(ActuatorFamily{iActFam}, 'Setpoint', InitActuator, ActuatorDeviceList{iActFam}, ModeFlagCell{:});
                else
                    DeltaPhysics = ActuatorDelta{iActFam};
                end
                
                % DeltaPhysics should be scaled by K*Leff (not just "K")
                try
                    Leff = getleff(ActuatorFamily{iActFam}, ActuatorDeviceList{iActFam});
                catch
                    Leff = 0;
                end
                i = find(Leff==0);      % Zero Leff is trouble, just divide by the number of actuators
                Leff(i) = 1 / length(Leff);
                DeltaPhysics = DeltaPhysics .* Leff / mean(Leff);
                
                % In order to backout the response at each magnet, assume that
                % the response at each magnet is equal in physics units.  
                DeltaMonitorPerPhysicsUnit = (Xp{iMonFam}-Xm{iMonFam}) / sum(DeltaPhysics);
                
                % Expand to each magnet
                R{iMonFam} = DeltaMonitorPerPhysicsUnit * ones(1,length(DeltaPhysics));
                
                % When in hardware unit convert to delta monitor / hardware delta actuator
                if strcmpi(family2units(ActuatorFamily{iActFam},'Setpoint'),'Hardware')
                    PhysicsUnitPerAmp = DeltaPhysics ./ ActuatorDelta{iActFam};
                    for n = 1:length(DeltaPhysics)
                        R{iMonFam}(:,n) = PhysicsUnitPerAmp(n) * R{iMonFam}(:,n);
                    end
                end
                
            else
                % Just divide the monitor value by the actuator value
                R{iMonFam}(:,iActDevice) = (Xp{iMonFam}-Xm{iMonFam}) / ActuatorDelta{iActFam}(iActDevice); 
            end
            
            % Save the measurements
            Monitor1{iMonFam}(:,iActDevice) = Xm{iMonFam};
            Monitor2{iMonFam}(:,iActDevice) = Xp{iMonFam};

        end % iMonFam
        
        % If the beam current is too low, prompt for a refill
        if DCCTStopFlag
            if (getdcct - DCCTStop) < 0
                CommandInput = questdlg( ...
                    {sprintf('The present beam current is %f', getdcct), ...
                    sprintf('A refill prompt was requested at %f', DCCTStop), ...
                    '   ', ...
                    'Your choices are:'
                    sprintf('Continue - Continue and you will be prompted again a %f', DCCTStop), ...
                    'Stop - Stop the measure right now', ...
                    'Don''t ask again - Continue on without another interruption'}, ...
                    'MEASRESPMAT', ...
                    'Continue', ...
                    'Stop', ...
                    'Don''t ask again', 'Don''t ask again');
                if isempty(CommandInput) || strcmp(CommandInput, 'Don''t ask again')
                    DCCTStopFlag = 0;
                elseif strcmp(CommandInput, 'Stop')
                    StopNow = 1;
                    break;
                end
            end
        end
    
    end % iActDevice
        
    for iMonFam = 1:length(MonitorFamily)
        if StructOutputFlag
            S{iMonFam,iActFam}.Data = R{iMonFam};
            
            S{iMonFam,iActFam}.Monitor = MonitorStart{iMonFam};
            S{iMonFam,iActFam}.Actuator = ActuatorStart{iActFam};
            S{iMonFam,iActFam}.ActuatorDelta = ActuatorDelta{iActFam};
            
            S{iMonFam,iActFam}.Monitor1 = Monitor1{iMonFam};
            S{iMonFam,iActFam}.Monitor2 = Monitor2{iMonFam};
            
            if ~strcmpi(MonitorStart{iMonFam}.Units, ActuatorStart{iActFam}.Units)
                S{iMonFam,iActFam}.Units =  [MonitorStart{iMonFam}.Units, '/', ActuatorStart{iActFam}.Units];
                fprintf('   Warning: Units are in a mixed mode');
            else
                S{iMonFam,iActFam}.Units = MonitorStart{iMonFam}.Units;
            end
            %S{iMonFam,iActFam}.UnitsString = ['[',MonitorStart{iMonFam}.UnitsString,']', '/', '[',ActuatorStart{iActFam}.UnitsString,']'];
            S{iMonFam,iActFam}.UnitsString = [MonitorStart{iMonFam}.UnitsString, '/', ActuatorStart{iActFam}.UnitsString];

            S{iMonFam,iActFam}.GeV = getenergy(ModeFlagCell{:}); 
            S{iMonFam,iActFam}.TimeStamp = t0;
            S{iMonFam,iActFam}.DCCT = DCCTStart;
            S{iMonFam,iActFam}.ModulationMethod = ModulationMethod;
            S{iMonFam,iActFam}.WaitFlag = WaitFlagMonitor;
            S{iMonFam,iActFam}.ExtraDelay = ExtraDelay;
            S{iMonFam,iActFam}.DataDescriptor = 'Response Matrix';
            S{iMonFam,iActFam}.CreatedBy = 'measrespmat';
            S{iMonFam,iActFam}.OperationalMode = getfamilydata('OperationalMode');
        else
            S{iMonFam,iActFam} = R{iMonFam};
        end
    end

    if StopNow
        break;
    end

end
set(handles.IF1, 'String', getrf);
set(handles.IF2, 'String', getrf-RF);
set(handles.IF3, 'String', getdcct);
set(handles.IF4, 'String', getenergy);
Tune = gettune;
set(handles.IF5, 'String', Tune(1)-Q(1));
set(handles.IF6, 'String', Tune(2)-Q(2));
% For one family inputs, there is no need for a cell output
if all(size(S) == [1 1])
    S = S{1};
end


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Reset_Callback(hObject, eventdata, handles);
[FileName, DirectoryName] = uigetfile;
FileName = [DirectoryName FileName];
load(FileName);
BPMx = BPMxDisp.Data;
BPMy = BPMyDisp.Data;
spos = getspos('BPMx');
axes(handles.betax);
hold on;
plot(spos, BPMx, 'o','MarkerEdgeColor','r');
TitleString = sprintf('Dispersion Function: %s  (\\alpha=%.5f, f=%f %s, \\Deltaf=%g %s)', texlabel('-alpha f {Delta}Orbit / {Delta}f'), BPMxDisp.MCF, BPMxDisp.Actuator.Data, BPMxDisp.Actuator.UnitsString, BPMxDisp.ActuatorDelta, BPMxDisp.Actuator.UnitsString);
title(TitleString);
axes(handles.betay);
hold on;
plot(spos, BPMy, 'o','MarkerEdgeColor','r');
