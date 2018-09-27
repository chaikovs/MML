function varargout = TEMPOchicane_guiv2(varargin)
% TEMPOCHICANE_GUIV2 M-file for TEMPOchicane_guiv2.fig
%      TEMPOCHICANE_GUIV2, by itself, creates a new TEMPOCHICANE_GUIV2 or raises the existing
%      singleton*.
%
%      H = TEMPOCHICANE_GUIV2 returns the handle to a new TEMPOCHICANE_GUIV2 or the handle to
%      the existing singleton*.
%
%      TEMPOCHICANE_GUIV2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEMPOCHICANE_GUIV2.M with the given input arguments.
%
%      TEMPOCHICANE_GUIV2('Property','Value',...) creates a new TEMPOCHICANE_GUIV2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TEMPOchicane_guiv2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TEMPOchicane_guiv2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TEMPOchicane_guiv2

% Last Modified by GUIDE v2.5 29-Sep-2016 20:13:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TEMPOchicane_guiv2_OpeningFcn, ...
                   'gui_OutputFcn',  @TEMPOchicane_guiv2_OutputFcn, ...
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


% --- Executes just before TEMPOchicane_guiv2 is made visible.
function TEMPOchicane_guiv2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TEMPOchicane_guiv2 (see VARARGIN)


% Choose default command line output for TEMPOchicane_guiv2
handles.output = hObject;
handles.energy = 19.6; %MeV
handles.energyref = 19.6; %MeV Reference energy for scaling

% magnetic meas.
valOptimized(1) = 7.5742;
valOptimized(2) =-9.3261;
valOptimized(3) = 1.8177;
valOptimized = valOptimized';

handles.valOptimized = valOptimized;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TEMPOchicane_guiv2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TEMPOchicane_guiv2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_atkpanel.
function pushbutton_atkpanel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_atkpanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
system('atkpanel ANS-C08/AE/TEMPO.CHI.1 &');
system('atkpanel ANS-C08/AE/TEMPO.CHI.2 &');
system('atkpanel ANS-C08/AE/TEMPO.CHI.3 &');


% --- Executes on button press in pushbutton_ON.
function pushbutton_ON_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
TEMPOchicane_setcommand('On');


% --- Executes on button press in pushbutton_OFF.
function pushbutton_OFF_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_OFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if TEMPOchicane_statuscheck == 1,
    tmp = questdlg(sprintf('Do you want to zero the TEMPO chicane'), ...
        'TEMPOCHICANE','Yes','No','No');
    if strcmpi(tmp,'No')
        fprintf(sprintf('Warning: zeroing the chicane canceled\n'));
        return
    else
        switchchicaneTEMPOv2(zeros(3,1), 'Online');
    end
end
%TEMPOchicane_setcommand('Off');

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_energy.
function pushbutton_energy_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_energy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_modify.
function pushbutton_modify_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_modify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if TEMPOchicane_statuscheck == 1,
    factor = handles.energy/handles.energyref;
    
    tmp = questdlg(sprintf('Do you want to set the energy to %6.3f MeV', handles.energyref*factor), ...
        'TEMPOCHICANE','Yes','No','No');
    if strcmpi(tmp,'No')
        fprintf(sprintf('Warning: setting new value for chicane\n'));
        return
    else
        switchchicaneTEMPOv2(handles.valOptimized*factor, 'Online');
    end
end

% --- Executes on button press in pushbutton_trend.
function pushbutton_trend_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_trend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
system('atktrend /home/production/matlab/matlabML/machine/SOLEIL/StorageRing/trend_chicaneTEMPO.txt &')



function edit_energy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_energy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_energy as text
%        str2double(get(hObject,'String')) returns contents of edit_energy as a double
handles.energy = str2double(get(handles.edit_energy, 'String'));
% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit_energy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_energy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
