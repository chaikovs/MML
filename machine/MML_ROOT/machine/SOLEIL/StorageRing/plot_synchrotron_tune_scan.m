function varargout = plot_synchrotron_tune_scan(varargin)
% PLOT_SYNCHROTRON_TUNE_SCAN M-file for plot_synchrotron_tune_scan.fig
%      PLOT_SYNCHROTRON_TUNE_SCAN, by itself, creates a new PLOT_SYNCHROTRON_TUNE_SCAN or raises the existing
%      singleton*.
%
%      H = PLOT_SYNCHROTRON_TUNE_SCAN returns the handle to a new PLOT_SYNCHROTRON_TUNE_SCAN or the handle to
%      the existing singleton*.
%
%      PLOT_SYNCHROTRON_TUNE_SCAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_SYNCHROTRON_TUNE_SCAN.M with the given input arguments.
%
%      PLOT_SYNCHROTRON_TUNE_SCAN('Property','Value',...) creates a new PLOT_SYNCHROTRON_TUNE_SCAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_synchrotron_tune_scan_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_synchrotron_tune_scan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_synchrotron_tune_scan

% Last Modified by GUIDE v2.5 08-Dec-2008 15:03:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_synchrotron_tune_scan_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_synchrotron_tune_scan_OutputFcn, ...
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


% --- Executes just before plot_synchrotron_tune_scan is made visible.
function plot_synchrotron_tune_scan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_synchrotron_tune_scan (see VARARGIN)

% Choose default command line output for plot_synchrotron_tune_scan
handles.output = hObject;

BPM='ANS-C09/DG/BPM.NOD';


% get BPM value
rep = tango_read_attribute2(BPM,'DDBufferSize');pro=rep.value(1);
set(handles.edit_profondeur,'String',num2str(pro))
rep = tango_read_attribute2(BPM,'DDDecimationFactor');dec=rep.value(1);
set(handles.edit_decimation,'String',num2str(dec))
rep = tango_read_attribute2('ANS-C13/SY/LOCAL.DG.1', 'dcctEvent');adr=rep.value(1);
set(handles.edit_adress,'String',num2str(adr))

temp=tango_read_attribute2('ANS/RF/MasterClock','phaseFrequency');freq=temp.value(1);
set(handles.edit_freq,'String',num2str(freq))
temp=tango_read_attribute2('ANS/RF/MasterClock','phaseVariation');amp=temp.value(1);
set(handles.edit_amp,'String',num2str(amp))
    
handles.bpm=BPM;
setappdata(handles.figure1, 'amp_scan', []);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plot_synchrotron_tune_scan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_synchrotron_tune_scan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pushbutton_plot
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

% get max on window
minf=floor(minfreq*1000*N/frev/1e6*double(dec));
maxf=floor(maxfreq*1000*N/frev/1e6*double(dec));
max_amp= max(Amp(minf:maxf));

amp_scan= getappdata(handles.figure1, 'amp_scan');
amp_scan=[amp_scan max_amp];
setappdata(handles.figure1, 'amp_scan', amp_scan);




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

guidata(hObject, handles);

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


% --- Executes on button press in pushbutton_scan.
function pushbutton_scan_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%amp  =0.0002;
freq0=str2double(get(handles.edit_freq_min_scan,'String'));
freqm=str2double(get(handles.edit_freq_max_scan,'String'));
df   =str2double(get(handles.edit_step_scan,'String'));

ff   = [freq0 :df:freqm];


freq_scan=ff;
setappdata(handles.figure1, 'amp_scan',[]);

tango_write_attribute2('ANS/RF/MasterClock','phaseFrequency',freq0);pause(2)

for fs=ff
   
    tango_write_attribute2('ANS/RF/MasterClock','phaseFrequency',fs*1000);
    
    pause(4)
    temp=tango_read_attribute2('ANS/RF/MasterClock','phaseFrequency');freq=temp.value(1);
    set(handles.edit_freq,'String',num2str(freq))
    temp=tango_read_attribute2('ANS/RF/MasterClock','phaseVariation');amp=temp.value(1);
    set(handles.edit_amp,'String',num2str(amp))
    
    pushbutton_plot_Callback(hObject, eventdata, handles);
    
end

amp_scan= getappdata(handles.figure1, 'amp_scan');
minfreq=str2double(get(handles.edit_minfreq,'String'));
maxfreq=str2double(get(handles.edit_maxfreq,'String'));

% Fit the tune from model
X = fminsearch(@(x)fitfun1(x,freq_scan,amp_scan),[3.6;0.2;200])
freq_fit=(minfreq: 0.001 :maxfreq);
amp_fit=X(3)./sqrt( (X(1)^2-freq_fit.^2).^2 + (2*X(2)*freq_fit).^2);

plot(freq_scan,amp_scan,'ob'); hold on
plot(freq_fit,amp_fit,'-r'); hold off
%xaxis([minfreq maxfreq]); 
grid on
xlabel('Frequency Hz')

% [amps,ind]=max(amp_scan);
% tunes=freq_scan(ind);
% set(handles.edit_tune,'String',num2str(tunes))
set(handles.edit_tune,'String',num2str(X(1)))


% Update handles structure
guidata(handles.pushbutton_scan, handles);

% --- For the tune fit
function A = fitfun1(lambda,f,y)
% Forced damped linear harmonic oscillator amplitude respons
% lambda(1) : resonance
% lambda(2) : damping
% lambda(3) : Ampl
A=lambda(3)./sqrt( ( lambda(1)^2-f.^2 ).^2 + (2*lambda(2)*f).^2);
A=norm(A-y);




function edit_freq_min_scan_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq_min_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq_min_scan as text
%        str2double(get(hObject,'String')) returns contents of edit_freq_min_scan as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_min_scan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq_min_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_freq_max_scan_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq_max_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq_max_scan as text
%        str2double(get(hObject,'String')) returns contents of edit_freq_max_scan as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_max_scan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq_max_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_step_scan_Callback(hObject, eventdata, handles)
% hObject    handle to edit_step_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_step_scan as text
%        str2double(get(hObject,'String')) returns contents of edit_step_scan as a double


% --- Executes during object creation, after setting all properties.
function edit_step_scan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_step_scan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_modulationON.
function pushbutton_modulationON_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_modulationON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


tango_command_inout2('ANS/RF/MasterClock','PhaseModulationON');

% --- Executes on button press in pushbutton_modulationOFF.
function pushbutton_modulationOFF_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_modulationOFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tango_command_inout2('ANS/RF/MasterClock','PhaseModulationOFF');



function edit_amp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amp as text
%        str2double(get(hObject,'String')) returns contents of edit_amp as a double


% --- Executes during object creation, after setting all properties.
function edit_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tune_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tune as text
%        str2double(get(hObject,'String')) returns contents of edit_tune as a double


% --- Executes during object creation, after setting all properties.
function edit_tune_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






