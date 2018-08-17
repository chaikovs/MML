function varargout = bpmrespmatgui(varargin)
% BPMRESPMATGUI M-file for bpmrespmatgui.fig
%      BPMRESPMATGUI, by itself, creates a new BPMRESPMATGUI or raises the existing
%      singleton*.
%
%      H = BPMRESPMATGUI returns the handle to a new BPMRESPMATGUI or the handle to
%      the existing singleton*.
%
%      BPMRESPMATGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BPMRESPMATGUI.M with the given input arguments.
%
%      BPMRESPMATGUI('Property','Value',...) creates a new BPMRESPMATGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bpmrespmatgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bpmrespmatgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bpmrespmatgui

% Last Modified by GUIDE v2.5 21-Mar-2011 17:01:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bpmrespmatgui_OpeningFcn, ...
                   'gui_OutputFcn',  @bpmrespmatgui_OutputFcn, ...
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


% --- Executes just before bpmrespmatgui is made visible.
function bpmrespmatgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bpmrespmatgui (see VARARGIN)

% Choose default command line output for bpmrespmatgui
handles.output = hObject;

% Directory name for saving data
handles.DirName = '';

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bpmrespmatgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bpmrespmatgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_bruit.
function pushbutton_bruit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bruit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch getmode('BPMx')
    case 'Online'
        [Rx Ry DCCT tout BPMxStd BPMyStd FileName] = monbpm('Archive',180);
    otherwise
        [Rx Ry DCCT tout BPMxStd BPMyStd FileName] = monbpm('Archive',10);
end
            
system(['mv ' FileName ' ' handles.DirName filesep]);


% --- Executes on button press in pushbutton_dispersion.
function pushbutton_dispersion_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dispersion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure
[Dx, Dy, FileName] = measdisp('Archive', 'Display');
system(['mv ' FileName ' ' handles.DirName filesep]);


% --- Executes on button press in pushbutton_matSOFB.
function pushbutton_matSOFB_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_matSOFB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch getmode('BPMx')
    case 'Online'
        [Rmat, OutputFileName] = measbpmresp('Archive');
        if ~isempty(Rmat)
            tango_giveInformationMessage('Fin de mesure Matrice réponse');
        end
    otherwise
        [Rmat, OutputFileName] = measbpmresp('Archive', 'Model');
end
if ~isempty(Rmat)
    system(['mv ' OutputFileName ' ' handles.DirName filesep]);
end

% --- Executes on button press in pushbutton_matFOFB.
function pushbutton_matFOFB_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_matFOFB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch getmode('BPMx')
    case 'Online'
        [Rmat, OutputFileName] = measbpmresp4FOFB('Archive');
        if ~isempty(Rmat)
            tango_giveInformationMessage('Fin de mesure Matrice réponse');
        end
    otherwise
        [Rmat, OutputFileName] = measbpmresp4FOFB('Archive', 'Model');
end

if ~isempty(Rmat)
    system(['mv ' OutputFileName ' ' handles.DirName filesep]);
end
        
% --- Executes on button press in pushbutton_directory.
function pushbutton_directory_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

RootDirectory = fileparts(getfamilydata('Directory', 'LOCOData'));
DirName = RootDirectory;
while ~ischar(DirName) || (strcmpi(DirName, RootDirectory) || exist(DirName, 'dir') ~=7)
    DirName = uigetdir(RootDirectory, 'Select or create a LOC0 directory');
    if strcmpi(DirName, RootDirectory)
        h = warndlg('Abort: Directory is not correct. Choose a subdirectory');
        uiwait(h)
    elseif ischar(DirName) && exist(DirName, 'dir') ~=7
        warndlg('Abort: Directory not selected');
    end
end
cd(DirName); % gotodirectory

handles.DirName = DirName;
% Update handles structure
guidata(hObject, handles);

ival = regexp(DirName,'/', 'end');

set(handles.text_directory, 'String', DirName(ival(end)+1:end));



% --- Executes on button press in pushbutton_buildloco.
function pushbutton_buildloco_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_buildloco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
buildlocoinput

% --- Executes on button press in pushbutton_locogui.
function pushbutton_locogui_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_locogui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

locogui


% --- Executes on button press in pushbutton_applysym.
function pushbutton_applysym_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_applysym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LOCOsymgui


% --- Executes on button press in pushbutton_directory2.
function pushbutton_directory2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_directory2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton_directory_Callback(hObject, eventdata, handles)

% --- Executes on button press in pushbutton_measdisp2.
function pushbutton_measdisp2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_measdisp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton_dispersion_Callback

% --- Executes on button press in pushbutton_bpmmon2.
function pushbutton_bpmmon2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bpmmon2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton_bruit_Callback


% --- Executes on button press in pushbutton_applyFOFB.
function pushbutton_applyFOFB_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_applyFOFB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_locogui2.
function pushbutton_locogui2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_locogui2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
locogui

% --- Executes on button press in pushbutton_buildlocoFOFB.
function pushbutton_buildlocoFOFB_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_buildlocoFOFB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
buildlocoinput_fofb
