function varargout = Correction_orbite_BPMs_Correcteurs_unpanel(varargin)
% CORRECTION_ORBITE_BPMS_CORRECTEURS_UNPANEL MATLAB code for Correction_orbite_BPMs_Correcteurs_unpanel.fig
%      CORRECTION_ORBITE_BPMS_CORRECTEURS_UNPANEL, by itself, creates a new CORRECTION_ORBITE_BPMS_CORRECTEURS_UNPANEL or raises the existing
%      singleton*.
%
%      H = CORRECTION_ORBITE_BPMS_CORRECTEURS_UNPANEL returns the handle to a new CORRECTION_ORBITE_BPMS_CORRECTEURS_UNPANEL or the handle to
%      the existing singleton*.
%
%      CORRECTION_ORBITE_BPMS_CORRECTEURS_UNPANEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CORRECTION_ORBITE_BPMS_CORRECTEURS_UNPANEL.M with the given input arguments.
%
%      CORRECTION_ORBITE_BPMS_CORRECTEURS_UNPANEL('Property','Value',...) creates a new CORRECTION_ORBITE_BPMS_CORRECTEURS_UNPANEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Correction_orbite_BPMs_Correcteurs_unpanel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Correction_orbite_BPMs_Correcteurs_unpanel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Correction_orbite_BPMs_Correcteurs_unpanel

% Last Modified by GUIDE v2.5 07-Apr-2014 10:42:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Correction_orbite_BPMs_Correcteurs_unpanel_OpeningFcn, ...
                   'gui_OutputFcn',  @Correction_orbite_BPMs_Correcteurs_unpanel_OutputFcn, ...
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


% --- Executes just before Correction_orbite_BPMs_Correcteurs_unpanel is made visible.
function Correction_orbite_BPMs_Correcteurs_unpanel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Correction_orbite_BPMs_Correcteurs_unpanel (see VARARGIN)

% Choose default command line output for Correction_orbite_BPMs_Correcteurs_unpanel
handles.output = hObject;
%handles=guidata(hObject);
  %cla(handles.dimension_graf);% pour effacer à chaque fois que tu cliques sur le bouton
  %errorbar(paramk, dimensions(:,1), - dimensions(:,2), dimensions(:,2),'-k','parent',handles.dimension_graf);
  %hold on,
  %errorbar(paramk, dimensions(:,3), - dimensions(:,4), dimensions(:,4),'-r.','parent',handles.dimension_graf);
  %axes(handles.gcf);
  %legend('horizontal','vertical');
  %xlabel('QP strength k (m^-^2)'), ylabel('transverse dimensions (m)')
  %set(gcf,'Color','white'); % parce que j'aime bien le blanc

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Correction_orbite_BPMs_Correcteurs_unpanel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Correction_orbite_BPMs_Correcteurs_unpanel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in RAZ.
function RAZ_Callback(hObject, eventdata, handles)
% hObject    handle to RAZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setpaththomx('TL_OC');
cla(handles.axes1);
Orbite_Initiale_Callback(hObject, eventdata, handles);


% --- Executes on button press in correction.
function correction_Callback(hObject, eventdata, handles)
% hObject    handle to correction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Initialisation;
CalcSVD;
stepsp('HCOR',DeltaAmps1);
stepsp('VCOR',DeltaAmps2);
a2=linepass(THERING,Rin,1:length(THERING)+1);
cla(handles.axes1);
axes(handles.axes1);
%hold on
plot(S1,a2(1,:)*1e3,'b-o',S1,a2(3,:)*1e3,'g-*');
legend('horizontal','vertical');
xlabel('s position (m)'), ylabel('transverse dimensions (m)')
set(gca,'ylim',[-30 30]);
%hold off;
axes(handles.axes2);
%hold on
plot(getspos('HCOR'),getam('HCOR'),'b-',getspos('VCOR'),getam('VCOR'),'g');
legend('horizontal','vertical');
xlabel('s position (m)'), ylabel('Horizontal Corrector values (A)'); 
set(gca,'ylim',[-5e-3,5e-3]);
%hold off;

% --- Executes on button press in Orbite_Initiale.
function Orbite_Initiale_Callback(hObject, eventdata, handles)
% hObject    handle to Orbite_Initiale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Initialisation;
axes(handles.axes1);
hold on
%legend('horizontal','vertical');
%xlabel('s position (m)'), ylabel('transverse dimensions (m)'); 
plot(S1,a(1,:)*1e3,'b-*',S1,a(3,:)*1e3,'g');
legend('horizontal','vertical');
xlabel('s position (m)'), ylabel('transverse dimensions (m)'); 
set(gca,'ylim',[-30 30]);
%set(gca,'YLim',20);
hold off;
axes(handles.axes2);
hold on
%legend('horizontal','vertical');
%xlabel('s position (m)'), ylabel('Horizontal Corrector values (A)'); 
plot(getspos('HCOR'),getam('HCOR'),'b-',getspos('VCOR'),getam('VCOR'),'g');
legend('horizontal','vertical');
xlabel('s position (m)'), ylabel('Horizontal Corrector values (A)'); 
set(gca,'ylim',[-5e-3,5e-3]);
hold off;