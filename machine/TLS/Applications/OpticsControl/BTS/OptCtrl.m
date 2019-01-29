function varargout = OptCtrl(varargin)
% OPTCTRL MATLAB code for OptCtrl.fig
%      OPTCTRL, by itself, creates a new OPTCTRL or raises the existing
%      singleton*.
%
%      H = OPTCTRL returns the handle to a new OPTCTRL or the handle to
%      the existing singleton*.
%
%      OPTCTRL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTCTRL.M with the given input arguments.
%
%      OPTCTRL('Property','Value',...) creates a new OPTCTRL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OptCtrl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OptCtrl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OptCtrl

% Last Modified by GUIDE v2.5 12-Apr-2012 14:48:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OptCtrl_OpeningFcn, ...
                   'gui_OutputFcn',  @OptCtrl_OutputFcn, ...
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


% --- Executes just before OptCtrl is made visible.
function OptCtrl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OptCtrl (see VARARGIN)

% Choose default command line output for OptCtrl
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
switch2physics;
plotoptics(handles);
set(handles.Q1A,'String',getsp('Q1A'));
set(handles.Q1AS,'Value',getsp('Q1A'));
set(handles.Q1B,'String',getsp('Q1B'));
set(handles.Q1BS,'Value',getsp('Q1B'));
set(handles.Q1C,'String',getsp('Q1C'));
set(handles.Q1CS,'Value',getsp('Q1C'));
set(handles.Q2A,'String',getsp('Q2A'));
set(handles.Q2AS,'Value',getsp('Q2A'));
set(handles.Q2B,'String',getsp('Q2B'));
set(handles.Q2BS,'Value',getsp('Q2B'));
set(handles.Q2C,'String',getsp('Q2C'));
set(handles.Q2CS,'Value',getsp('Q2C'));
set(handles.Q3A,'String',getsp('Q3A'));
set(handles.Q3AS,'Value',getsp('Q3A'));
set(handles.Q3B,'String',getsp('Q3B'));
set(handles.Q3BS,'Value',getsp('Q3B'));
set(handles.Q4A,'String',getsp('Q4A'));
set(handles.Q4AS,'Value',getsp('Q4A'));
set(handles.Q4B,'String',getsp('Q4B'));
set(handles.Q4BS,'Value',getsp('Q4B'));
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax,'String',num2str(AlfaX(1)));
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay,'String',num2str(AlfaY(1)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax,'String',num2str(BetaX(1)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay,'String',num2str(BetaY(1)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx,'String',num2str(EtaX(1)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy,'String',num2str(EtaY(1)));
set(handles.dy2,'String',num2str(EtaY(end)));
% UIWAIT makes OptCtrl wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OptCtrl_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function [ax, h1, h2] = plotoptics(handles)
%PLOTTWISS - Plot the optical functions and tune of the present lattice


%[TD, Tune] = twissring(RING,0,1:(length(RING)+1),'chrom');

[BetaX, BetaY, Sx, Sy, Tune] = modeltwiss('Beta', 'All');
%BetaX(1), BetaY(1)

[EtaX, EtaY] = modeltwiss('Eta', 'All');
%EtaX(1), EtaY(1)

[N, Nsymmetry] = getnumberofsectors;
L = getfamilydata('Circumference');
Lsector = L / Nsymmetry;

i = 1:length(Sx);
i(find(Sx > Lsector)) = [];
% i(end+1) = i(end) + 1;   % 2009/11/15

%figure
% clf reset;
axes(handles.axes1);
[ax,h1,h2] = plotyy(Sx(i), [BetaX(i) BetaY(i)], Sx(i), EtaX(i));

xlabel('Position [meters]');
%ylabel('[meters]');
title('Optical Functions');
%axis tight;

set(get(ax(1),'ylabel'),'string','{\it\beta}  [meters]');
%set(get(ax(1),'ylabel'),'string','{\it\beta_x}   {\it\beta_y  [meters]}');
set(get(ax(2),'ylabel'),'string','{\it\eta [meters]}');


% Plot 1 sector
axes(ax(2));
%axis tight;
a2 = axis;
if ~isempty(L) && ~isempty(N)
    a2(1) = 0;
    a2(2) = Lsector;
end

% Make room for the lattice
DeltaY = a2(4) - a2(3);
a2(3) = a2(3) - .12 * DeltaY;
%a2(4) = a2(4) + .08 * DeltaY;
axis(a2);

axes(ax(1));
%axis tight
a1 = axis;
if ~isempty(L) && ~isempty(N)
    a1(2) = Lsector;
end

% Make room for the lattice
DeltaY = a1(4) - a1(3);
a1(3) = a1(3) - .12 * DeltaY;
%a1(4) = a1(4) + .08 * DeltaY;
axis([a2(1:2) a1(3:4)]);


% Draw the lattice
a = axis;
hold on;
drawlattice(a(3)+.06*DeltaY, .05*DeltaY, ax(1), Lsector);
axis(a);
hold off;


legend('{\it\beta_x}', '{\it\beta_y }', 0);

ax(end+1) = gca;
% linkaxes(ax, 'x');

axes(ax(2));



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q1A_Callback(hObject, eventdata, handles)
% hObject    handle to Q1A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2num(get(handles.Q1A,'String'));
set(handles.Q1AS,'Value',Value);
setsp('Q1A',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of Q1A as text
%        str2double(get(hObject,'String')) returns contents of Q1A as a double


% --- Executes during object creation, after setting all properties.
function Q1A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q1A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q1B_Callback(hObject, eventdata, handles)
% hObject    handle to Q1B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2num(get(handles.Q1B,'String'));
set(handles.Q1BS,'Value',Value);
setsp('Q1B',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of Q1B as text
%        str2double(get(hObject,'String')) returns contents of Q1B as a double


% --- Executes during object creation, after setting all properties.
function Q1B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q1B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q1C_Callback(hObject, eventdata, handles)
% hObject    handle to Q1C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2num(get(handles.Q1C,'String'));
set(handles.Q1CS,'Value',Value);
setsp('Q1C',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of Q1C as text
%        str2double(get(hObject,'String')) returns contents of Q1C as a double


% --- Executes during object creation, after setting all properties.
function Q1C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q1C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q2B_Callback(hObject, eventdata, handles)
% hObject    handle to Q2B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2num(get(handles.Q2B,'String'));
set(handles.Q2BS,'Value',Value);
setsp('Q2B',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of Q2B as text
%        str2double(get(hObject,'String')) returns contents of Q2B as a double


% --- Executes during object creation, after setting all properties.
function Q2B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q2B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q3B_Callback(hObject, eventdata, handles)
% hObject    handle to Q3B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2num(get(handles.Q3B,'String'));
set(handles.Q3BS,'Value',Value);
setsp('Q3B',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of Q3B as text
%        str2double(get(hObject,'String')) returns contents of Q3B as a double


% --- Executes during object creation, after setting all properties.
function Q3B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q3B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q2A_Callback(hObject, eventdata, handles)
% hObject    handle to Q2A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2num(get(handles.Q2A,'String'));
set(handles.Q2AS,'Value',Value);
setsp('Q2A',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of Q2A as text
%        str2double(get(hObject,'String')) returns contents of Q2A as a double


% --- Executes during object creation, after setting all properties.
function Q2A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q2A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q2C_Callback(hObject, eventdata, handles)
% hObject    handle to Q2C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2num(get(handles.Q2C,'String'));
set(handles.Q2CS,'Value',Value);
setsp('Q2C',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of Q2C as text
%        str2double(get(hObject,'String')) returns contents of Q2C as a double


% --- Executes during object creation, after setting all properties.
function Q2C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q2C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q3A_Callback(hObject, eventdata, handles)
% hObject    handle to Q3A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2num(get(handles.Q3A,'String'));
set(handles.Q3AS,'Value',Value);
setsp('Q3A',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of Q3A as text
%        str2double(get(hObject,'String')) returns contents of Q3A as a double


% --- Executes during object creation, after setting all properties.
function Q3A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q3A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q4B_Callback(hObject, eventdata, handles)
% hObject    handle to Q4B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2num(get(handles.Q4B,'String'));
set(handles.Q4BS,'Value',Value);
setsp('Q4B',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of Q4B as text
%        str2double(get(hObject,'String')) returns contents of Q4B as a double


% --- Executes during object creation, after setting all properties.
function Q4B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q4B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Q4A_Callback(hObject, eventdata, handles)
% hObject    handle to Q4A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = str2num(get(handles.Q4A,'String'));
set(handles.Q4AS,'Value',Value);
setsp('Q4A',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of Q4A as text
%        str2double(get(hObject,'String')) returns contents of Q4A as a double


% --- Executes during object creation, after setting all properties.
function Q4A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q4A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Q1AS_Callback(hObject, eventdata, handles)
% hObject    handle to Q1AS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = get(handles.Q1AS,'Value');
set(handles.Q1A,'String',Value);
setsp('Q1A',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Q1AS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q1AS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function Q1BS_Callback(hObject, eventdata, handles)
% hObject    handle to Q1BS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = get(handles.Q1BS,'Value');
set(handles.Q1B,'String',Value);
setsp('Q1B',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Q1BS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q1BS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Q1CS_Callback(hObject, eventdata, handles)
% hObject    handle to Q1CS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = get(handles.Q1CS,'Value');
set(handles.Q1C,'String',Value);
setsp('Q1C',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Q1CS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q1CS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Q2AS_Callback(hObject, eventdata, handles)
% hObject    handle to Q2AS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = get(handles.Q2AS,'Value');
set(handles.Q2A,'String',Value);
setsp('Q2A',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Q2AS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q2AS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Q2BS_Callback(hObject, eventdata, handles)
% hObject    handle to Q2BS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = get(handles.Q2BS,'Value');
set(handles.Q2B,'String',Value);
setsp('Q2B',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Q2BS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q2BS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Q2CS_Callback(hObject, eventdata, handles)
% hObject    handle to Q2CS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = get(handles.Q2CS,'Value');
set(handles.Q2C,'String',Value);
setsp('Q2C',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Q2CS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q2CS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Q3AS_Callback(hObject, eventdata, handles)
% hObject    handle to Q3AS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = get(handles.Q3AS,'Value');
set(handles.Q3A,'String',Value);
setsp('Q3A',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Q3AS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q3AS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Q3BS_Callback(hObject, eventdata, handles)
% hObject    handle to Q3BS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = get(handles.Q3BS,'Value');
set(handles.Q3B,'String',Value);
setsp('Q3B',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Q3BS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q3BS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Q4AS_Callback(hObject, eventdata, handles)
% hObject    handle to Q4AS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = get(handles.Q4AS,'Value');
set(handles.Q4A,'String',Value);
setsp('Q4A',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Q4AS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q4AS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Q4BS_Callback(hObject, eventdata, handles)
% hObject    handle to Q4BS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Value = get(handles.Q4BS,'Value');
set(handles.Q4B,'String',Value);
setsp('Q4B',Value);
plotoptics(handles);
global THERING
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Q4BS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q4BS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alfax_Callback(hObject, eventdata, handles)
% hObject    handle to alfax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global THERING
THERING{1}.TwissData.alpha(1) = str2num(get(handles.alfax,'String'));
plotoptics(handles);
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of alfax as text
%        str2double(get(hObject,'String')) returns contents of alfax as a double


% --- Executes during object creation, after setting all properties.
function alfax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alfax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function betax_Callback(hObject, eventdata, handles)
% hObject    handle to betax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global THERING
THERING{1}.TwissData.beta(1) = str2num(get(handles.betax,'String'));
plotoptics(handles);
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of betax as text
%        str2double(get(hObject,'String')) returns contents of betax as a double


% --- Executes during object creation, after setting all properties.
function betax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to betax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dx_Callback(hObject, eventdata, handles)
% hObject    handle to dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global THERING
THERING{1}.TwissData.Dispersion(1) = str2num(get(handles.dx,'String'));
plotoptics(handles);
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of dx as text
%        str2double(get(hObject,'String')) returns contents of dx as a double


% --- Executes during object creation, after setting all properties.
function dx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alfay_Callback(hObject, eventdata, handles)
% hObject    handle to alfay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global THERING
THERING{1}.TwissData.alpha(2) = str2num(get(handles.alfay,'String'));
plotoptics(handles);
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of alfay as text
%        str2double(get(hObject,'String')) returns contents of alfay as a double


% --- Executes during object creation, after setting all properties.
function alfay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alfay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function betay_Callback(hObject, eventdata, handles)
% hObject    handle to betay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global THERING
THERING{1}.TwissData.beta(2) = str2num(get(handles.betay,'String'));
plotoptics(handles);
[AlfaX, AlfaY] = modeltwiss('alpha');
[BetaX, BetaY] = modeltwiss('beta');
[EtaX, EtaY] = modeltwiss('eta');
set(handles.alfax2,'String',num2str(AlfaX(end)));
set(handles.alfay2,'String',num2str(AlfaY(end)));
set(handles.betax2,'String',num2str(BetaX(end)));
set(handles.betay2,'String',num2str(BetaY(end)));
set(handles.dx2,'String',num2str(EtaX(end)));
set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of betay as text
%        str2double(get(hObject,'String')) returns contents of betay as a double


% --- Executes during object creation, after setting all properties.
function betay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to betay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dy_Callback(hObject, eventdata, handles)
% hObject    handle to dy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global THERING
% THERING{1}.TwissData.Dispersion(3) = str2num(get(handles.dy,'String'));
% plotoptics(handles);
% [AlfaX, AlfaY] = modeltwiss('alpha');
% [BetaX, BetaY] = modeltwiss('beta');
% [EtaX, EtaY] = modeltwiss('eta');
% set(handles.alfax2,'String',num2str(AlfaX(end)));
% set(handles.alfay2,'String',num2str(AlfaY(end)));
% set(handles.betax2,'String',num2str(BetaX(end)));
% set(handles.betay2,'String',num2str(BetaY(end)));
% set(handles.dx2,'String',num2str(EtaX(end)));
% set(handles.dy2,'String',num2str(EtaY(end)));
% Hints: get(hObject,'String') returns contents of dy as text
%        str2double(get(hObject,'String')) returns contents of dy as a double


% --- Executes during object creation, after setting all properties.
function dy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dy (see GCBO)
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



function alfax2_Callback(hObject, eventdata, handles)
% hObject    handle to alfax2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alfax2 as text
%        str2double(get(hObject,'String')) returns contents of alfax2 as a double


% --- Executes during object creation, after setting all properties.
function alfax2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alfax2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function betax2_Callback(hObject, eventdata, handles)
% hObject    handle to betax2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of betax2 as text
%        str2double(get(hObject,'String')) returns contents of betax2 as a double


% --- Executes during object creation, after setting all properties.
function betax2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to betax2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dx2_Callback(hObject, eventdata, handles)
% hObject    handle to dx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dx2 as text
%        str2double(get(hObject,'String')) returns contents of dx2 as a double


% --- Executes during object creation, after setting all properties.
function dx2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit39_Callback(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit39 as text
%        str2double(get(hObject,'String')) returns contents of edit39 as a double


% --- Executes during object creation, after setting all properties.
function edit39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit40_Callback(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit40 as text
%        str2double(get(hObject,'String')) returns contents of edit40 as a double


% --- Executes during object creation, after setting all properties.
function edit40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit41_Callback(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit41 as text
%        str2double(get(hObject,'String')) returns contents of edit41 as a double


% --- Executes during object creation, after setting all properties.
function edit41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alfay2_Callback(hObject, eventdata, handles)
% hObject    handle to alfay2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alfay2 as text
%        str2double(get(hObject,'String')) returns contents of alfay2 as a double


% --- Executes during object creation, after setting all properties.
function alfay2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alfay2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function betay2_Callback(hObject, eventdata, handles)
% hObject    handle to betay2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of betay2 as text
%        str2double(get(hObject,'String')) returns contents of betay2 as a double


% --- Executes during object creation, after setting all properties.
function betay2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to betay2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dy2_Callback(hObject, eventdata, handles)
% hObject    handle to dy2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dy2 as text
%        str2double(get(hObject,'String')) returns contents of dy2 as a double


% --- Executes during object creation, after setting all properties.
function dy2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dy2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
