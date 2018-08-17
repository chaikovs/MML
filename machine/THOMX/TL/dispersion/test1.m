function varargout = test1(varargin)
% TEST1 MATLAB code for test1.fig
%      TEST1, by itself, creates a new TEST1 or raises the existing
%      singleton*.
%
%      H = TEST1 returns the handle to a new TEST1 or the handle to
%      the existing singleton*.
%
%      TEST1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST1.M with the given input arguments.
%
%      TEST1('Property','Value',...) creates a new TEST1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test1

% Last Modified by GUIDE v2.5 30-Jan-2015 16:33:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test1_OpeningFcn, ...
                   'gui_OutputFcn',  @test1_OutputFcn, ...
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


% --- Executes just before test1 is made visible.
function test1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test1 (see VARARGIN)

% Choose default command line output for test1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function pas_scan_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));


function pas_scan_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function VRF_max_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));


function VRF_max_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function VRF_min_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));


function VRF_min_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function default_Callback(hObject, eventdata, handles)
defaultBPM=1;
defaultVRF_min=8;
defaultVRF_max=10;
defaultpas_scan=15;
set(handles.VRF_min,'String',num2str(defaultVRF_min));
set(handles.VRF_max,'String',num2str(defaultVRF_max));
set(handles.pas_scan,'String',num2str(defaultpas_scan));

set(handles.BPM1,'Value',defaultBPM);
set(handles.BPM2,'Value',defaultBPM);
set(handles.BPM3,'Value',defaultBPM);
set(handles.BPM4,'Value',defaultBPM);


function scan_Callback(hObject, eventdata, handles)
%%%%% fonction de test - a modifier pour le online %%%%%%%
deltaE=linspace(-0.02,0.02,20);
XBPM1 = 0*deltaE;
XBPM2 = 0.44*deltaE+12*deltaE.^2-5e2*deltaE.^3;
XBPM3 = -0.35*deltaE+8*deltaE.^2-1e2*deltaE.^3;
XBPM4 = -0.35*deltaE;

cla(handles.plot_xposition);
axes(handles.plot_xposition);

plot(deltaE, XBPM1,'b-o'); hold on, plot(deltaE, XBPM2,'r-o'), plot(deltaE, XBPM3,'g-o'), plot(deltaE, XBPM4,'k-o');
legend ('BPM1','BPM2','BPM3','BPM4');
xlabel('DP/P (%)','Fontsize',18),ylabel('X(mm)','Fontsize',18);
set(gca,'Fontsize',18);
set(gcf,'Color',[1,1,1]);
ethax1=polyfit(deltaE,XBPM1,3);
ethax2=polyfit(deltaE,XBPM2,3);
ethax3=polyfit(deltaE,XBPM3,3);
ethax4=polyfit(deltaE,XBPM4,3);

ethax=[ethax1; ethax2;ethax3;ethax4];

cla(handles.ethax_ordre);
axes(handles.ethax_ordre);
plot(ethax(:,3),'b-o'), hold on, plot(ethax(:,2),'r-o')/10, plot(ethax(:,1)/100,'g-o');
legend ('ordre 1','ordre 2/10','ordre3/100');
xlabel('BPMx','Fontsize',18),ylabel('fir order value','Fontsize',18);
set(gca,'Fontsize',18);
set(gcf,'Color',[1,1,1]);

function BPM1_Callback(hObject, eventdata, handles)


function BPM2_Callback(hObject, eventdata, handles)


function BPM3_Callback(hObject, eventdata, handles)


function BPM4_Callback(hObject, eventdata, handles)


function uipushtool1_ClickedCallback(hObject, eventdata, handles)
