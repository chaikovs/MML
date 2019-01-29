function varargout = TuneMovePanel(varargin)
% TUNEMOVEPANEL M-file for TuneMovePanel.fig
%      TUNEMOVEPANEL, by itself, creates a new TUNEMOVEPANEL or raises the existing
%      singleton*.
%
%      H = TUNEMOVEPANEL returns the handle to a new TUNEMOVEPANEL or the handle to
%      the existing singleton*.
%
%      TUNEMOVEPANEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUNEMOVEPANEL.M with the given input arguments.
%
%      TUNEMOVEPANEL('Property','Value',...) creates a new TUNEMOVEPANEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TuneMovePanel_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TuneMovePanel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TuneMovePanel

% Last Modified by GUIDE v2.5 05-Aug-2005 17:18:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TuneMovePanel_OpeningFcn, ...
                   'gui_OutputFcn',  @TuneMovePanel_OutputFcn, ...
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

% --- Executes just before TuneMovePanel is made visible.
function TuneMovePanel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TuneMovePanel (see VARARGIN)

% Choose default command line output for TuneMovePanel
handles.output = hObject;

% Update handles structure
display('Launching Tune Move Panel ....');

theReset(hObject, eventdata, handles)

%tunespaceplot([18 18.5] , [8 8.5], 8, 4, handles.webAxe);

% UIWAIT makes TuneMovePanel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TuneMovePanel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function dqField_Callback(hObject, eventdata, handles)
% hObject    handle to dqField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dqField as text
%        str2double(get(hObject,'String')) returns contents of dqField as a double


% --- Executes during object creation, after setting all properties.
function dqField_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dqField (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in qyUpButton.
function qyUpButton_Callback(hObject, eventdata, handles)
% hObject    handle to qyUpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dQx=0;
dQy=str2double(get(handles.dqField,'string'));
thesteptune(dQx,dQy);
UpdatePlot(hObject, handles);
% --- Executes on button press in qyDownButton.
function qyDownButton_Callback(hObject, eventdata, handles)
% hObject    handle to qyDownButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dQx=0;
dQy=str2double(get(handles.dqField,'string'));
thesteptune(dQx,-dQy);
UpdatePlot(hObject, handles);
% --- Executes on button press in qxUpButton.
function qxUpButton_Callback(hObject, eventdata, handles)
% hObject    handle to qxUpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dQx=str2double(get(handles.dqField,'string'));
dQy=0;
thesteptune(dQx,dQy);
UpdatePlot(hObject, handles);

% --- Executes on button press in qxDownButton.
function qxDownButton_Callback(hObject, eventdata, handles)
% hObject    handle to qxDownButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dQx=str2double(get(handles.dqField,'string'));
dQy=0;
thesteptune(-dQx,dQy);
UpdatePlot(hObject, handles);

function UpdatePlot(hObject, handles)
global THERING;
handles.THERING = THERING;
[TD, tune, chrom] = twissring(handles.THERING,0,1:handles.L+1,'chrom', 1e-8);
BETA = cat(1,TD.beta);
S  = cat(1,TD.SPos);
Disp=cat(2,TD.Dispersion);


set(handles.betax,'YData',BETA(:,1));
set(handles.qxText,'String',num2str(tune(1)));

set(handles.betay,'YData',BETA(:,2));
set(handles.qyText,'String',num2str(tune(2)));

set(handles.dx, 'YData', 10*Disp(1,:)');

delete(handles.QDot);
handles.Qx = tune(1);
handles.Qy = tune(2);
handles.QDot = line('parent',handles.webAxe,'XData',handles.Qx,'YData',handles.Qy,'Marker','+','MarkerSize',12.0);
[name, val] = quad_getsetpoint;
%handles.figure1;
quad_table('title', name, val, [0.1 0.45 0.2 0.325] );
set(handles.cxText,'String',num2str(chrom(1)));
set(handles.cyText,'String',num2str(chrom(2)));
if handles.emitCalc
    e=getemit(TD);
    set(handles.emitText,'String',num2str(e(1)));
else
    set(handles.emitText,'String','No Calc');
end
guidata(hObject,handles);


% --- Executes on button press in summaryButton.
function summaryButton_Callback(hObject, eventdata, handles)
% hObject    handle to summaryButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in emitCheckBox.
function emitCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to emitCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of emitCheckBox
if (get(hObject,'Value') == get(hObject,'Max'))
    % then checkbox is checked-take approriate action
    handles.emitCalc=true;
else
    % checkbox is not checked-take approriate action
    handles.emitCalc=false;
end
guidata(hObject,handles);

function thesteptune(dqx, dqy)
ALBAsteptune(dqx, dqy);
% original was
% steptune([-dqx,dqy]')


% --------------------------------------------------------------------
function optionsMeno_Callback(hObject, eventdata, handles)
% hObject    handle to optionsMeno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function panelResetMenu_Callback(hObject, eventdata, handles)
% hObject    handle to panelResetMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.QDot);
delete(handles.betax);
delete(handles.betay);
delete(handles.dx);
theReset (hObject, eventdata, handles)

function theReset(hObject, eventdata, handles)
global THERING
handles.L = length(THERING);
[TD, tune] = twissring(THERING,0,1:handles.L+1);
if isnan(tune(1)), tune(1)=0.25, end;
if isnan(tune(2)), tune(2)=0.25, end;

handles.spos = findspos(THERING,1:handles.L+1);
handles.THERING = THERING;
handles.betax   =	line('parent',handles.betaAxe,'XData',handles.spos,'YData',0*handles.spos,'Color','r');
handles.betay   =	line('parent',handles.betaAxe,'XData',handles.spos,'YData',0.*handles.spos,'Color','b');
handles.dx     =	line('parent',handles.betaAxe,'XData',handles.spos,'YData',0.*handles.spos,'Color','g');

ALBAdrawlattice(handles, -1, 1);

xlabel(handles.betaAxe,'s - position [m]');
ylabel(handles.betaAxe,'\beta_y [m]');
xaxis([0 handles.spos(handles.L+1)/4], handles.betaAxe);
guidata(hObject,handles);
handles.Qx = tune(1);
handles.Qy = tune(2);
handles.emitCalc = false;
handles.QDot = line('parent',handles.webAxe,'XData',handles.Qx,'YData',handles.Qy,'Marker','+');
UpdatePlot(hObject, handles);
handles.webAxe;
max_order= 5;
per = 4;
window = [tune(1)-0.255 tune(1)+0.255 tune(2)-0.255 tune(2)+0.255];
for i=max_order:-1:1,
    [k, tab] = reson(i,per,window);
end
axis(window);
handles.betaAxe;
set(handles.emitCheckBox, 'Value',0);
%guidata(hObject,handles);
