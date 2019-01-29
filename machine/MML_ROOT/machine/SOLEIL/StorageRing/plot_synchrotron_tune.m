function varargout = plot_synchrotron_tune(varargin)
% PLOT_SYNCHROTRON_TUNE M-file for plot_synchrotron_tune.fig
%      PLOT_SYNCHROTRON_TUNE, by itself, creates a new PLOT_SYNCHROTRON_TUNE or raises the existing
%      singleton*.
%
%      H = PLOT_SYNCHROTRON_TUNE returns the handle to a new PLOT_SYNCHROTRON_TUNE or the handle to
%      the existing singleton*.
%
%      PLOT_SYNCHROTRON_TUNE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_SYNCHROTRON_TUNE.M with the given input arguments.
%
%      PLOT_SYNCHROTRON_TUNE('Property','Value',...) creates a new PLOT_SYNCHROTRON_TUNE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_synchrotron_tune_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_synchrotron_tune_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_synchrotron_tune

% Last Modified by GUIDE v2.5 07-May-2008 15:57:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_synchrotron_tune_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_synchrotron_tune_OutputFcn, ...
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


% --- Executes just before plot_synchrotron_tune is made visible.
function plot_synchrotron_tune_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_synchrotron_tune (see VARARGIN)

% Choose default command line output for plot_synchrotron_tune
handles.output = hObject;

BPM='ANS-C09/DG/BPM.NOD';


% get BPM value
rep = tango_read_attribute2(BPM,'DDBufferSize');pro=rep.value(1);
set(handles.edit_profondeur,'String',num2str(pro))
rep = tango_read_attribute2(BPM,'DDDecimationFactor');dec=rep.value(1);
set(handles.edit_decimation,'String',num2str(dec))
rep = tango_read_attribute2('ANS-C13/SY/LOCAL.DG.1', 'dcctEvent');adr=rep.value(1);
set(handles.edit_adress,'String',num2str(adr))

handles.bpm=BPM;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plot_synchrotron_tune wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_synchrotron_tune_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_run.
function pushbutton_run_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pushbutton_run
BPM=handles.bpm;
rep = tango_read_attribute2(BPM,'DDDecimationFactor');dec=rep.value(1);
rep = tango_read_attribute2(BPM,'XPosDD');
N = length(rep.value);

minfreq=str2double(get(handles.edit_minfreq,'String'));
maxfreq=str2double(get(handles.edit_maxfreq,'String'));


Xvalue = zeros(1,N);
for ik =1:1, % averaging
    rep = tango_read_attribute2(BPM,'XPosDD');
    Xvalue = Xvalue + rep.value;
    pause(0.3)
end

Xvalue = Xvalue/3;
Amp=abs(fft(Xvalue));

frev = getrf/416;
freq =(1:N)/N*frev*1e6/double(dec);
len=length(freq);

plot(freq(1:len/2)/1000,Amp(1:len/2))
xaxis([minfreq maxfreq]); 
grid on
xlabel('Frequency kHz')

%[a ind] = max(abs(fft(rep.value)))

    
    
function edit_profondeur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_profondeur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_profondeur as text
%        str2double(get(hObject,'String')) returns contents of edit_profondeur as a double


% --- Executes during object creation, after setting all properties.
function edit_profondeur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_profondeur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_decimation_Callback(hObject, eventdata, handles)
% hObject    handle to edit_decimation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_decimation as text
%        str2double(get(hObject,'String')) returns contents of edit_decimation as a double


% --- Executes during object creation, after setting all properties.
function edit_decimation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_decimation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_adress_Callback(hObject, eventdata, handles)
% hObject    handle to edit_adress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_adress as text
%        str2double(get(hObject,'String')) returns contents of edit_adress as a double


% --- Executes during object creation, after setting all properties.
function edit_adress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_adress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_minfreq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_minfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_minfreq as text
%        str2double(get(hObject,'String')) returns contents of edit_minfreq as a double


% --- Executes during object creation, after setting all properties.
function edit_minfreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_minfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_maxfreq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_maxfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_maxfreq as text
%        str2double(get(hObject,'String')) returns contents of edit_maxfreq as a double


% --- Executes during object creation, after setting all properties.
function edit_maxfreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_maxfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


