function varargout = measbeta_tls(varargin)
% MEASBETA_TLS M-file for measbeta_tls.fig
%      MEASBETA_TLS, by itself, creates a new MEASBETA_TLS or raises the existing
%      singleton*.
%
%      H = MEASBETA_TLS returns the handle to a new MEASBETA_TLS or the handle to
%      the existing singleton*.
%
%      MEASBETA_TLS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MEASBETA_TLS.M with the given input arguments.
%
%      MEASBETA_TLS('Property','Value',...) creates a new MEASBETA_TLS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before measbeta_tls_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to measbeta_tls_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help measbeta_tls

% Last Modified by GUIDE v2.5 18-Jun-2010 16:55:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @measbeta_tls_OpeningFcn, ...
                   'gui_OutputFcn',  @measbeta_tls_OutputFcn, ...
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


% --- Executes just before measbeta_tls is made visible.
function measbeta_tls_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to measbeta_tls (see VARARGIN)

% Choose default command line output for measbeta_tls
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

axes(handles.lattice);
cla;
drawlattice;
set(handles.lattice, 'XTick', []);
set(handles.lattice, 'YTick', []);
plottwiss_tls(handles);

% UIWAIT makes measbeta_tls wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = measbeta_tls_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function [ax, h1, h2] = plottwiss_tls(handles)
%PLOTTWISS - Plot the optical functions and tune of the present lattice


%[TD, Tune] = twissring(RING,0,1:(length(RING)+1),'chrom');

[BetaX, BetaY, Sx, Sy, Tune] = modeltwiss('Beta', 'All');
%BetaX(1), BetaY(1)

[EtaX, EtaY] = modeltwiss('Eta', 'All');
%EtaX(1), EtaY(1)

[N, Nsymmetry] = getnumberofsectors;
L = getfamilydata('Circumference');
Lsector = L;

i = 1:length(Sx);
i(find(Sx > Lsector)) = [];
% i(end+1) = i(end) + 1;   % 2009/11/15

%figure
% clf reset;
% [ax,h1,h2] = plotyy(Sx(i), [BetaX(i) BetaY(i)], Sx(i), EtaX(i));
axes(handles.betax);
plot(Sx(i), BetaX(i));
% xlabel('Position [meters]');
%ylabel('[meters]');
% title(sprintf('Optical Functions ({\\it\\nu_x} = %5.3f, {\\it\\nu_y} = %5.3f)', Tune(1),Tune(2)));
%axis tight;
grid on;
set(handles.betax, 'XTickLabel', []);
set(handles.betax, 'XLim', [0 120]);
ylabel('\beta_x  [meters]');
%set(get(ax(1),'ylabel'),'string','{\it\beta_x}   {\it\beta_y  [meters]}');
% set(get(ax(2),'ylabel'),'string','{\it\eta_x [meters]}');

axes(handles.betay);
plot(Sx(i), BetaY(i));
grid on;
set(handles.betay, 'XLim', [0 120]);
xlabel('Position [meters]');
ylabel('\beta_y  [meters]');


% --- Executes on button press in measure.
function measure_Callback(hObject, eventdata, handles)
% hObject    handle to measure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Mode = getmode('RF');
AO = beta_tls(Mode,handles);
set(handles.measure, 'UserData', AO);



function Q1_Callback(hObject, eventdata, handles)
% hObject    handle to Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Q1 as text
%        str2double(get(hObject,'String')) returns contents of Q1 as a double


% --- Executes during object creation, after setting all properties.
function Q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q2_Callback(hObject, eventdata, handles)
% hObject    handle to Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Q2 as text
%        str2double(get(hObject,'String')) returns contents of Q2 as a double


% --- Executes during object creation, after setting all properties.
function Q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q2 (see GCBO)
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
TWISS = gettwiss;
Y = ceil([max(TWISS.betax),max(TWISS.betay)]);
set(handles.betax, 'YLim', [0 ceil(Y(1,1)/5)*5]);
set(handles.betay, 'YLim', [0 ceil(Y(1,2)/5)*5]);
set(handles.V1, 'String', 0);
set(handles.V2, 'String', ceil(max(Y)/5)*5);
set(handles.H1, 'String', 0);
set(handles.H2, 'String', 120);
set(handles.betax, 'XLim', [0 120]);
set(handles.betay, 'XLim', [0 120]);
set(handles.lattice, 'XLim', [0 120]);
axes(handles.betax);
cla;
axes(handles.betay);
cla;
plottwiss_tls(handles);
set(handles.Q1, 'String', 1);
set(handles.Q2, 'String', 1);
set(handles.Q3, 'String', 1);
set(handles.Q4, 'String', 1);
set(handles.IF1, 'String', []);
set(handles.IF2, 'String', []);
set(handles.IF3, 'String', []);
set(handles.IF4, 'String', []);
set(handles.IF5, 'String', []);
set(handles.IF6, 'String', []);
set(handles.T1, 'String', []);
set(handles.T2, 'String', []);
set(handles.T3, 'String', []);
set(handles.T4, 'String', []);
set(handles.B1, 'String', []);
set(handles.B2, 'String', []);
set(handles.B3, 'String', []);
set(handles.B4, 'String', []);
set(handles.D1, 'String', []);
set(handles.D2, 'String', []);
set(handles.D3, 'String', []);


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


function AO = beta_tls(varargin,handles)
%MEASBETA - Measure the betatron functions 
%
%  INPUTS
%  1. Quadrupole family name {Default : All}
%  Optional
%  'Archive', 'Display'
%  Optional override of the mode:
%     'Online'    - Set/Get data online  
%     'Model'     - Get the model chromaticity directly from AT (uses modelchro, DeltaRF is ignored)
%     'Simulator' - Set/Get data on the simulated accelerator using AT (ie, same commands as 'Online')
%
%  OUPUTS
%  1. betax - Horizontal beta functions
%  2. betaz - Vertical beta functions
%
%  ALGORITHM
%  betax =  4*pi*Dtunex/D(KL)
%  betaz = -4*pi*Dtunez/D(KL)
%
%  See also plotmeasbeta, plotbeta


%  Written by Laurent S. Nadolski


DisplayFlag = 1;
ArchiveFlag = 1;
FileName = '';
ModeFlag = getmode('RF');  % model, online, manual, or '' for default mode
waittime = 0;
OutputFlag = 1;

for i = size(varargin,1):-1:1
    if isstruct(varargin(i,:))
        % Ignore structures
    elseif iscell(varargin(i,:))
        % Ignore cells
    elseif strcmpi(varargin(i,:),'Display')
        DisplayFlag = 1;
        varargin(i,:) = [];
    elseif strcmpi(varargin(i,:),'NoDisplay')
        DisplayFlag = O;
        varargin(i,:) = [];
    elseif strcmpi(varargin(i,:),'NoArchive')
        ArchiveFlag = 0;
        varargin(i,:) = [];
    elseif strcmpi(varargin(i,:),'Archive')
        ArchiveFlag = 1;
        varargin(i,:) = [];
    elseif any(strcmpi(varargin(i,:),{'Online','Manual'}))
        ModeFlag = varargin(i,:);
        varargin(i,:) = [];
        waittime = 5;
    elseif strcmpi(varargin(i,:),'Model')
        waittime = -1;
        OutputFlag = 0;
        varargin(i,:) = [];
    elseif strcmpi(varargin(i,:),'Simulator')
        waittime = 0.1;
        OutputFlag = 1;
        varargin(i,:) = [];
    end
end


% % Input parsing
% if isempty(varargin)
%     QuadFam = findmemberof('QUAD');
% elseif ischar(varargin(1))  
%     QuadFam = {varargin(:)};
% else
%     QuadFam = varargin(:)
% end
QuadFam = findmemberof('QUAD');
if ArchiveFlag
    if isempty(FileName)
        FileName = appendtimestamp(getfamilydata('Default', 'QUADArchiveFile'));
        DirectoryName = getfamilydata('Directory', 'QUAD');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot'), 'Response', filesep, 'BPM', filesep];
        else
            % Make sure default directory exists
            DirStart = pwd;
            [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
            cd(DirStart);
        end
        [FileName, DirectoryName] = uiputfile('*.mat', 'Select a Quad File ("Save" starts measurement)', [DirectoryName FileName]);
        File = FileName;
        if FileName == 0 
            ArchiveFlag = 0;
            disp('   Quadrupole betatron measurement canceled.');
            return
        end
        FileName = [DirectoryName, FileName];
    elseif FileName == -1
        FileName = appendtimestamp(getfamilydata('Default', 'QUADArchiveFile'));
        DirectoryName = getfamilydata('Directory', 'QUAD');
        FileName = [DirectoryName, FileName];
    end    
end

% Starting time
t0 = clock;

if get(handles.action, 'UserData') == 1
    nu_start = gettune(ModeFlag);
else
    prompt = {'Enter Horizontal Tune:','Enter Vertical Tune:'};
    dlg_title = 'Start Tune';
    num_lines = 1;
    def = {'',''};
    options.Resize='on';
    options.WindowStyle='normal';
    options.Interpreter='tex';
    answer = inputdlg(prompt,dlg_title,num_lines,def,options);
    nu_start = [str2num(answer{1,1});str2num(answer{2,1})];
end

for k1 = 1:length(QuadFam),
    
    if ~isfamily(QuadFam{k1})
        error('%s is not a valid Family \n', QuadFam{k1});
        return;
    end
        
    DeviceList = family2dev(QuadFam{k1});
    
    % initialize data to zeros
    beta = zeros(length(DeviceList),2);
    beta_vrai = beta;
    tune0 = beta;
    tune1 = beta;
    tune2 = beta;
    dtune = beta;
    
    k3 = 0;
    
    for k2 = 1:length(DeviceList),
        Ic = getquad_tls(QuadFam{k1}, DeviceList(k2,:));
        K = hw2physics(QuadFam{k1}, 'Setpoint', Ic, DeviceList(k2,:));

        if OutputFlag
            fprintf('Measuring Family %s [%d %d] actual current %f A : ... \n', ...
                QuadFam{k1}, DeviceList(k2,:),Ic)
        end
        
        k3 = k3 + 1;
%         tune0(k3,:) = gettune(ModeFlag); % Starting time
        if get(handles.action, 'UserData') == 1
            tune0(k3,:) = gettune(ModeFlag);
        else
            prompt = {'Enter Horizontal Tune:','Enter Vertical Tune:'};
            dlg_title = 'Initial Tune';
            num_lines = 1;
            def = {'',''};
            options.Resize='on';
            options.WindowStyle='normal';
            options.Interpreter='tex';
            answer = inputdlg(prompt,dlg_title,num_lines,def,options);
            tune0(k3,:) = [str2num(answer{1,1}),str2num(answer{2,1})];
        end
        switch(k1)
            case 1
                DeltaI = str2num(get(handles.Q2, 'String'));
            case 2
                DeltaI = str2num(get(handles.Q4, 'String'));
            case 3
                DeltaI = str2num(get(handles.Q1, 'String'));
            case 4
                DeltaI = str2num(get(handles.Q3, 'String'));
        end
                
%         DeltaI = getfamilydata(QuadFam{k1},'Setpoint','DeltaKBeta')*1.; % Amp

        if OutputFlag
            fprintf('Current increment of %d A\n', DeltaI)
        end
        
        setquad_tls(QuadFam{k1}, DeltaI, DeviceList(k2,:)); % Step value
        sleep(waittime) % wait for quad reaching new setpoint value
 
%         tune1(k3,:) = gettune(ModeFlag); % get new tunes
        if get(handles.action, 'UserData') == 1
            tune1(k3,:) = gettune(ModeFlag);
        else
            prompt = {'Enter Horizontal Tune:','Enter Vertical Tune:'};
            dlg_title = 'First Tune';
            num_lines = 1;
            def = {'',''};
            options.Resize='on';
            options.WindowStyle='normal';
            options.Interpreter='tex';
            answer = inputdlg(prompt,dlg_title,num_lines,def,options);
            tune1(k3,:) = [str2num(answer{1,1}),str2num(answer{2,1})];
        end
        
        if OutputFlag
            tune1
            if strcmpi(ModeFlag,'Online')
                fprintf('Current increment of %d A\n', 0)
                setquad_tls(QuadFam{k1}, 0, DeviceList(k2,:)); % go back to initial values
            else
                fprintf('Current increment of %d A\n', -2*DeltaI)
                setquad_tls(QuadFam{k1}, -2*DeltaI, DeviceList(k2,:)); % go back to initial values
            end
        end

        sleep(waittime) % wait for quad reaching new setpoint value
        
%         tune2(k3,:) = gettune(ModeFlag); % get new tunes
        if get(handles.action, 'UserData') == 1
            tune2(k3,:) = gettune(ModeFlag);
        else
            prompt = {'Enter Horizontal Tune:','Enter Vertical Tune:'};
            dlg_title = 'Second Tune';
            num_lines = 1;
            def = {'',''};
            options.Resize='on';
            options.WindowStyle='normal';
            options.Interpreter='tex';
            answer = inputdlg(prompt,dlg_title,num_lines,def,options);
            tune2(k3,:) = [str2num(answer{1,1}),str2num(answer{2,1})];
        end
        
        if OutputFlag
            tune2
        end

        if OutputFlag
            fprintf('Current increment of %d A\n', DeltaI)
        end
        if strcmpi(ModeFlag,'Online')
            setquad_tls(QuadFam{k1}, 0, DeviceList(k2,:)); % go back to initial values
        else
            setquad_tls(QuadFam{k1}, DeltaI, DeviceList(k2,:)); % go back to initial values
        end
        sleep(waittime) % wait for quad reaching new setpoint value

        %% computation part
        
        dtune(k3,:) = tune1(k3,:) - tune2(k3,:);
        
        Leff = getleff(QuadFam{k1}, DeviceList(k2,:)); % Get effective length
        %KL   = hw2physics(QuadFam{k1}, 'Setpoint', DeltaK, DeviceList(k2,:))*Leff;
        DeltaKL =  2*DeltaI/Ic*K*Leff;
        
        if strcmpi(ModeFlag,'Online')
            Energy = getenergy;
            Brho = getbrho(Energy);
            if strcmpi(QuadFam{k1},'QD1')
                K1 = DeltaI*0.019/Brho/0.35;
                K2 = 0;
            elseif strcmpi(QuadFam{k1},'QF1')
                K1 = DeltaI*(-0.019)/Brho/0.35;
                K2 = 0;
            elseif strcmpi(QuadFam{k1}, 'QD2')
                K1 = DeltaI*(0.013)/Brho/0.24;
                K2 = 0;
            elseif strcmpi(QuadFam{k1},'QF2')
                K1 = DeltaI*(-0.019)/Brho/0.35;
                K2 = 0;
            end
        else
            K1 = hw2physics(QuadFam{k1}, 'Setpoint', Ic+DeltaI, DeviceList(k2,:));
            K2 = hw2physics(QuadFam{k1}, 'Setpoint', Ic-DeltaI, DeviceList(k2,:));
        end
        DeltaKL_vrai =  (K1-K2)*Leff;
        
        beta(k3,:) = 4*pi*dtune(k3,:)./DeltaKL.*[1 -1];
        beta_vrai(k3,:) = 4*pi*dtune(k3,:)./DeltaKL_vrai.*[1 -1];
        if beta_vrai(k3,1) < 0
            beta_vrai(k3,1) = -beta_vrai(k3,1);
        end
        if beta_vrai(k3,2) < 0
            beta_vrai(k3,2) = -beta_vrai(k3,2);
        end

        if OutputFlag
            dtune
            beta
            beta_vrai
        end
        set(handles.IF1, 'String', QuadFam{k1});
        set(handles.IF2, 'String', num2str(DeviceList(k2,:),'[ %2d, %2d ]'));
        set(handles.IF3, 'String', beta_vrai(k2,1));
        set(handles.IF4, 'String', beta_vrai(k2,2));
        set(handles.IF5, 'String', dtune(k2,1));
        set(handles.IF6, 'String', dtune(k2,2));
        axes(handles.betax);
        hold on;
        spos = getfamilydata(QuadFam{k1},'Position');
        switch (k1)
            case 1
                plot(spos(k2), beta_vrai(k2,1),'O', 'MarkerFaceColor','r');
            case 2
                plot(spos(k2), beta_vrai(k2,1),'O', 'MarkerFaceColor','g');
            case 3
                plot(spos(k2), beta_vrai(k2,1),'O', 'MarkerFaceColor','b');
            case 4
                plot(spos(k2), beta_vrai(k2,1),'O', 'MarkerFaceColor','m');
        end
        
        axes(handles.betay);
        hold on;
        switch (k1)
            case 1
                plot(spos(k2), beta_vrai(k2,2),'O', 'MarkerFaceColor','r');
            case 2
                plot(spos(k2), beta_vrai(k2,2),'O', 'MarkerFaceColor','g');
            case 3
                plot(spos(k2), beta_vrai(k2,2),'O', 'MarkerFaceColor','b');
            case 4
                plot(spos(k2), beta_vrai(k2,2),'O', 'MarkerFaceColor','m');
        end


    end
    
    % structure to be saved
    AO.FamilyName.(QuadFam{k1}).beta = beta;
    AO.FamilyName.(QuadFam{k1}).beta_vrai = beta_vrai;
    AO.FamilyName.(QuadFam{k1}).dtune = dtune;
    AO.FamilyName.(QuadFam{k1}).tune0 = tune0;
    AO.FamilyName.(QuadFam{k1}).tune1 = tune1;
    AO.FamilyName.(QuadFam{k1}).tune2 = tune2;
    AO.FamilyName.(QuadFam{k1}).deltaI = DeltaI;
    AO.FamilyName.(QuadFam{k1}).DeviceList = DeviceList;
    %AO.FamilyName.(QuadFam{k1}).Position = getspos(QuadFam{k1},DeviceList);
end

AO.CreatedBy = 'measbeta';
AO.GeV       = getenergy;
AO.t         = t0;
AO.tout      = etime(clock,t0);
AO.TimeStamp = datestr(clock);

if ArchiveFlag
    save(FileName,'AO');
    fprintf('Data save in filename %s \n', FileName);
end
set(handles.D1, 'String', File);
set(handles.D2, 'String', num2str(AO.tout));
set(handles.D3, 'String', num2str(AO.TimeStamp));
%% tune variation during measurement
% nu_end = gettune(ModeFlag);
if get(handles.action, 'UserData') == 1
    nu_end = gettune(ModeFlag);
else
    prompt = {'Enter Horizontal Tune:','Enter Vertical Tune:'};
    dlg_title = 'End Tune';
    num_lines = 1;
    def = {'',''};
    options.Resize='on';
    options.WindowStyle='normal';
    options.Interpreter='tex';
    answer = inputdlg(prompt,dlg_title,num_lines,def,options);
    nu_end = [str2num(answer{1,1});str2num(answer{2,1})];
end
fprintf('Tunes before mesurement nux = %4.4f nuz = %4.4f \n', nu_start);
fprintf('Tunes after  mesurement nux = %4.4f nuz = %4.4f \n', nu_end);
set(handles.T1, 'String', num2str(nu_start(1)));
set(handles.T2, 'String', num2str(nu_start(2)));
set(handles.T3, 'String', num2str(nu_end(1)));
set(handles.T4, 'String', num2str(nu_end(2)));

%% raw statistics on beta measurement
dbxobx = (max(beta_vrai(:,1)-min(beta_vrai(:,1))))./min(beta_vrai(:,1))*100;
dbzobz = (max(beta_vrai(:,2)-min(beta_vrai(:,2))))./min(beta_vrai(:,2))*100;
fprintf('maximum betabeat dbxobx = %4.1f %% dbzobz = %4.1f %% \n', dbxobx, dbzobz);
set(handles.B1, 'String', num2str(dbxobx));
set(handles.B2, 'String', num2str(dbzobz));
rmsbx = std((beta_vrai(:,1)-mean(beta_vrai(:,1)))./mean(beta_vrai(:,1)))*100;
rmsbz = std((beta_vrai(:,2)-mean(beta_vrai(:,2)))./mean(beta_vrai(:,2)))*100;
fprintf('rms betabeat bx = %4.1f %% rms bz = %4.1f %% rms \n', rmsbx, rmsbz);
set(handles.B3, 'String', num2str(rmsbx));
set(handles.B4, 'String', num2str(rmsbz));

function SP = getquad_tls(QuadFamily, QuadDev)
Mode = getfamilydata(QuadFamily,'Setpoint','Mode');
if strcmpi(Mode,'Simulator')
    % Simulator
    SP = getsp(QuadFamily, QuadDev);
    if nargout >= 2
        SP = getam(QuadFamily, QuadDev);
    end
else
    % Online
    if strcmpi(QuadFamily,'QD1')
        if QuadDev(1,2) == 1
            QuadDev = [ QuadDev(1,1) 1];
        else
            QuadDev = [ QuadDev(1,1) 8];
        end

    elseif strcmpi(QuadFamily,'QF1')
        if QuadDev(1,2) == 1
            QuadDev = [ QuadDev(1,1) 2];
        else
            QuadDev = [ QuadDev(1,1) 7];
        end

    elseif strcmpi(QuadFamily,'QD2')
        if QuadDev(1,2) == 1
            QuadDev = [ QuadDev(1,1) 3];
        else
            QuadDev = [ QuadDev(1,1) 6];
        end

    elseif strcmpi(QuadFamily,'QF2')
        if QuadDev(1,2) == 1
            QuadDev = [ QuadDev(1,1) 4];
        else
            QuadDev = [ QuadDev(1,1) 5];
        end

    end

    QuadFamily = 'TrimQ';
    SP = getsp(QuadFamily, QuadDev);
    if nargout >= 2
        SP = getam(QuadFamily, QuadDev);
    end
end

function setquad_tls(QuadFamily, DeltaI, QuadDev)
Mode = getfamilydata(QuadFamily,'Setpoint','Mode');
if strcmpi(Mode,'Simulator')
    % Simulator
    stepsp(QuadFamily, DeltaI, QuadDev, Mode);
else
    % Online
    if strcmpi(QuadFamily,'QD1')
        if QuadDev(1,2) == 1
            QuadDev = [ QuadDev(1,1) 1];
        else
            QuadDev = [ QuadDev(1,1) 8];
        end

    elseif strcmpi(QuadFamily,'QF1')
        if QuadDev(1,2) == 1
            QuadDev = [ QuadDev(1,1) 2];
        else
            QuadDev = [ QuadDev(1,1) 7];
        end

    elseif strcmpi(QuadFamily,'QD2')
        if QuadDev(1,2) == 1
            QuadDev = [ QuadDev(1,1) 3];
        else
            QuadDev = [ QuadDev(1,1) 6];
        end

    elseif strcmpi(QuadFamily,'QF2')
        if QuadDev(1,2) == 1
            QuadDev = [ QuadDev(1,1) 4];
        else
            QuadDev = [ QuadDev(1,1) 5];
        end

    end

    QuadFamily = 'TrimQ';

    DeV = [
        1 6
        1 7
        1 8
        2 1
        2 2
        2 3
        ];


    for i=1:6
        if all(QuadDev(1,:) == DeV(i,:))
            setsp(QuadFamily, DeltaI, QuadDev, Mode);
            sleep(3);
            X = 0;
            break;
        end
        X = 1;
    end

    if (X == 1)
        if abs(DeltaI) < 0.001 
            setsp(QuadFamily, 0, QuadDev, Mode);
        else
            setsp(QuadFamily, X, QuadDev, Mode);
        end
        sleep(3);
        ctl_set('RCMTPS',-DeltaI);
        sleep(3);
    end
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
    X = ceil(max([max(AO.FamilyName.QF1.beta_vrai);max(AO.FamilyName.QF2.beta_vrai);max(AO.FamilyName.QD1.beta_vrai);max(AO.FamilyName.QD2.beta_vrai);]));
end
TWISS = gettwiss;
Y = ceil([max(TWISS.betax),max(TWISS.betay)]);
Z = max(cat(1,X,Y));
set(handles.betax, 'YLim', [0 ceil(Z(1,1)/5)*5]);
set(handles.betay, 'YLim', [0 ceil(Z(1,2)/5)*5]);
set(handles.V1, 'String', 0);
set(handles.V2, 'String', ceil(max(Z)/5)*5);



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


% --- Executes on button press in action.
function action_Callback(hObject, eventdata, handles)
% hObject    handle to action (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.action, 'UserData') == 1
    set(handles.action, 'String', 'Manual');
    set(handles.action, 'UserData', 0);
else
    set(handles.action, 'String', 'Automatic');
    set(handles.action, 'UserData', 1);
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
QuadFam = fieldnames(AO.FamilyName);
for k = 1:length(QuadFam)
%     spos  = [spos AO.FamilyName.(QuadFam{k}).Position];
%     betax = [betax AO.FamilyName.(QuadFam{k}).beta(:,1)];
%     betaz = [betaz AO.FamilyName.(QuadFam{k}).beta(:,2)];
     betax = AO.FamilyName.(QuadFam{k}).beta_vrai(:,1);
     betaz = AO.FamilyName.(QuadFam{k}).beta_vrai(:,2);
     spos =getspos(QuadFam{k});
     axes(handles.betax);
     hold on;
     switch (k)
            case 1
                plot(spos,betax,'O', 'MarkerFaceColor','r');
            case 2
                plot(spos,betax,'O', 'MarkerFaceColor','g');
            case 3
                plot(spos,betax,'O', 'MarkerFaceColor','b');
            case 4
                plot(spos,betax,'O', 'MarkerFaceColor','m');
     end
     axes(handles.betay);
     hold on;
     switch (k)
            case 1
                plot(spos,betaz,'O', 'MarkerFaceColor','r');
            case 2
                plot(spos,betaz,'O', 'MarkerFaceColor','g');
            case 3
                plot(spos,betaz,'O', 'MarkerFaceColor','b');
            case 4
                plot(spos,betaz,'O', 'MarkerFaceColor','m');
     end
end
set(handles.D1, 'String', FileName);
set(handles.D2, 'String', AO.tout);
set(handles.D3, 'String', AO.TimeStamp);
