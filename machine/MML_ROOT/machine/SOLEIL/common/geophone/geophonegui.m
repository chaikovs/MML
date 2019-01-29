function varargout = geophonegui(varargin)
% GEOPHONEGUI M-file for geophonegui.fig
%      GEOPHONEGUI, by itself, creates a new GEOPHONEGUI or raises the existing
%      singleton*.
%
%      H = GEOPHONEGUI returns the handle to a new GEOPHONEGUI or the handle to
%      the existing singleton*.
%
%      GEOPHONEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GEOPHONEGUI.M with the given input arguments.
%
%      GEOPHONEGUI('Property','Value',...) creates a new GEOPHONEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before geophonegui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to geophonegui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help geophonegui

% Last Modified by GUIDE v2.5 19-Feb-2015 08:23:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @geophonegui_OpeningFcn, ...
                   'gui_OutputFcn',  @geophonegui_OutputFcn, ...
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


% --- Executes just before geophonegui is made visible.
function geophonegui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to geophonegui (see VARARGIN)

% Choose default command line output for geophonegui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes geophonegui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

handles.chanId = 1;
handles.chanName = 'Channel';
Npoint = 24576;
maxChan = 16; 
handles.linearscale = 1;

% Geophone names
handles.channelName = family2common('GEO');

handles.tmax = 96; % s
handles.t  = NaN*ones(Npoint, 1);
handles.st = NaN*ones(Npoint, maxChan);
handles.Fe = 256; % sampling frequency
handles.unite = NaN; % units of data
handles.t0 = NaN; % starting time

% Graphics
handles.h1 = plot(handles.axes1, handles.t, handles.st(:,1));
xlabel(handles.axes1, 'time (s)')
ylabel(handles.axes1, 'Amplitude (nm)')

xlim(handles.axes1, [0 handles.tmax]);
ylim(handles.axes1, [-1000 1000]);
hold(handles.axes1, 'on');
handles.hline1 = plot(handles.axes1, [1 1], [-1000 1000], 'k-');
plot(handles.axes1, [0 handles.tmax], [500 500], 'r-');
plot(handles.axes1, [0 handles.tmax], -[500 500], 'r-');

handles.h2mem = semilogy(handles.axes2, handles.t, handles.st(:,1), 'r');
hold(handles.axes2, 'on');
handles.h2 = plot(handles.axes2, handles.t, handles.st(:,1),'b'); 
xlim(handles.axes2, [0 handles.Fe/2]);
ylim(handles.axes2, [1e-12 1e-6]);
set(handles.axes2, 'XMinorTick', 'on')
ylabel(handles.axes2, 'PSD m/sqrt(Hz)')
xlabel(handles.axes2, 'Frequency Hz')

[X Y] = meshgrid(1:1024,(1:maxChan)/maxChan*handles.tmax);
handles.hmesh3 = mesh(handles.axes3, X, Y, X, 'CDataMapping','scaled'); 
view(handles.axes3, 2); %caxis(handles.axes3, 'manual');
hold(handles.axes3, 'on');
handles.h3 = plot(handles.axes3, handles.t, handles.st(:,1));
% Hline for selected data
handles.hline3 = plot(handles.axes3, [-handles.Fe/2 handles.Fe/2], [1 1], 'k-');
ylabel(handles.axes3, 'Time (s)')
xlabel(handles.axes3, 'Frequency Hz')
axis(handles.axes3, [-handles.Fe/2 handles.Fe/2 0 handles.tmax])

handles.h4 = semilogy(handles.axes4, handles.t, handles.st(:,1));
xlim(handles.axes4, [0 handles.Fe/2]);
ylim(handles.axes2, [1e-12 1e-6]);
datacursormode('on');
ylabel(handles.axes4, 'PSD m/sqrt(Hz)')
xlabel(handles.axes4, 'Frequency Hz')

handles.windowsize = 1024;
set(handles.slider_windowsize, 'Value', handles.windowsize);
set(handles.edit_windowsize, 'String', handles.windowsize);
handles.shiftvalue = 100;
set(handles.slider_shiftvalue, 'Value', handles.shiftvalue);
set(handles.edit_shiftvalue, 'String', handles.shiftvalue);
set(handles.slider_windowsize, 'Max', Npoint);
set(handles.slider_windowsize, 'Min', 1);
slider_step(1) = 1000/Npoint;
slider_step(2) = 10000/Npoint;
set(handles.slider_windowsize,'sliderstep', slider_step);
set(handles.slider_shiftvalue, 'Max', Npoint/10);
set(handles.slider_shiftvalue, 'Min', 1);
slider_step(1) = 1000/Npoint;
slider_step(2) = 10000/Npoint;
set(handles.slider_shiftvalue,'sliderstep', slider_step);
set(handles.slider_select, 'Min', 1);
set(handles.slider_select, 'Max', 10);
set(handles.slider_select, 'Value', 1);

% watch the default path to find avl files
directoryname = '/home/data/Survib_geophones'
cd(directoryname)
listing = dir('*avl');
fileList = cell(length(listing),1);
for k=1:length(listing)
    fileList{k} = listing(k).name;
end

set(handles.listbox_file, 'String', fileList);

% Update handles structure
guidata(hObject, handles);

pushbutton_plot_Callback(handles.pushbutton_plot, eventdata, handles)


% --- Outputs from this function are returned to the command line.
function varargout = geophonegui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_file.
function listbox_file_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_file contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_file

contents = cellstr(get(hObject,'String'));
val = get(hObject,'Value');

if val > length(contents),
    val = length(contents);
    set(hObject, 'Value', val');
end


handles.chanName = contents{val};

[handles.t,handles.st, handles.Fe, handles.unite, handles.t0] = avl2mat(handles.chanName);

set(handles.text_fileName, 'String', datestr(handles.t0));
%fprintf('time: %s\n', datestr(handles.t0));

% Update handles structure
guidata(hObject, handles);

pushbutton_plot_Callback(handles.pushbutton_plot, eventdata, handles);
slider_select_Callback(handles.slider_select, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


listing = dir('*avl');
fileList = cell(length(listing),1);
for k=1:length(listing)
    fileList{k} = listing(k).name;
end

set(hObject, 'String', fileList);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% AXE1
chanId = handles.chanId;
y1 = handles.st(:,chanId)*1e9; % nm
set(handles.h1,'XData', handles.t);
set(handles.h1,'YData', y1); 
[y1max idx1] = max(abs(handles.st*1e6)); % micrometer

svalue = cell(length(idx1),1);
for k=1:length(idx1)
    svalue{k} = sprintf('%-26s: Max: %4.3f micron @ %2.0f s \n', ...
        handles.channelName{k}, y1max(k), handles.t(idx1(k)));
end

set(handles.text_stat1, 'String', svalue, 'FontSize', 8); 

% Print out at the screen level
fprintf('%s', svalue{:});


%% AXE2
len = length(handles.t);
NFFT = 2^nextpow2(len);
y2 = abs(fft(handles.st(:,chanId), NFFT))/NFFT*sqrt(2)/sqrt(handles.Fe/NFFT);
set(handles.h2,'XData', (1:NFFT)/NFFT*handles.Fe);

if ~handles.linearscale
    y2 = log10(y2);
end;
set(handles.h2,'YData', y2);

%% AXE3
fullLen = length(handles.t);
ishift = handles.shiftvalue;
kn = floor((fullLen-handles.windowsize)/ishift);
set(handles.slider_select, 'Max', kn);
slider_step(1) = 1/kn;
slider_step(2) = 10/kn;
set(handles.slider_select,'sliderstep', slider_step);

if get(handles.slider_select, 'Value') > kn 
    set(handles.slider_select, 'Value', kn - 10);
end

len = handles.windowsize;
NFFT = 2^nextpow2(len);
fftmat = zeros(kn, NFFT);
for ik =1:kn,
    istart = (ik-1)*ishift+1;
    istop  = istart + handles.windowsize;
    ivec = istart:istop;    
    fftmat(ik,:) = abs(fftshift(fft(handles.st(ivec,chanId),NFFT)/NFFT))/sqrt(handles.Fe/NFFT);
end

f = ((0:NFFT-1)/NFFT-0.5)*handles.Fe;

[X Y] = meshgrid(f,(1:kn)/kn*handles.tmax);
if handles.linearscale
    y = log10(fftmat);
else
    y = fftmat;
end
set(handles.hmesh3, 'XData', X, 'YData', Y, 'Zdata', y); 
%caxis(handles.axes3, [-11 -6]); 
%caxis(handles.axes3, 'auto')
% Update handles structure
guidata(hObject, handles);

% --- Executes on slider movement.
function slider_shiftvalue_Callback(hObject, eventdata, handles)
% hObject    handle to slider_shiftvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.shiftvalue = floor(get(hObject,'Value'));
set(handles.edit_shiftvalue, 'String', handles.shiftvalue);

% Update handles structure
guidata(hObject, handles);

slider_select_Callback(handles.slider_select, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function slider_shiftvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_shiftvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_windowsize_Callback(hObject, eventdata, handles)
% hObject    handle to edit_windowsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_windowsize as text
%        str2double(get(hObject,'String')) returns contents of edit_windowsize as a double
handles.windowsize = str2double(get(hObject,'String'));
set(handles.slider_windowsize, 'Value', handles.windowsize);

% Update handles structure
guidata(hObject, handles);

slider_select_Callback(handles.slider_select, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_windowsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_windowsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_shiftvalue_Callback(hObject, eventdata, handles)
% hObject    handle to edit_shiftvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_shiftvalue as text
%        str2double(get(hObject,'String')) returns contents of edit_shiftvalue as a double
handles.shiftvalue = str2double(get(hObject,'String'));
set(handles.slider_shiftvalue, 'Value', handles.shiftvalue);

% Update handles structure
guidata(hObject, handles);

slider_select_Callback(handles.slider_select, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_shiftvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_shiftvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_windowsize_Callback(hObject, eventdata, handles)
% hObject    handle to slider_windowsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles.windowsize = floor(get(hObject,'Value'));
set(handles.edit_windowsize, 'String', handles.windowsize);

% Update handles structure
guidata(hObject, handles);

slider_select_Callback(handles.slider_select, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider_windowsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_windowsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_select_Callback(hObject, eventdata, handles)
% hObject    handle to slider_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%% AXE4
ik = floor(get(hObject,'Value'));
istart = (ik-1)*handles.shiftvalue+1;
istop  = istart + handles.windowsize;
ivec = istart:istop;
len = length(ivec);
NFFT = 2^nextpow2(len);
y = abs(fftshift(fft(handles.st(ivec,handles.chanId), NFFT)))/NFFT*sqrt(2)/sqrt(handles.Fe/NFFT);
f = ((0:NFFT-1)/NFFT-0.5)*handles.Fe;
set(handles.h4,'XData', f);

if ~handles.linearscale
    y = log10(y);
end

set(handles.h4,'YData', y);

kn = get(handles.slider_select, 'Max');
set(handles.hline3,'YData', [ik ik]*handles.tmax/kn);
set(handles.hline1,'XData', [ik ik]*handles.tmax/kn);



% --- Executes during object creation, after setting all properties.
function slider_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in text_stat1.
function text_stat1_Callback(hObject, eventdata, handles)
% hObject    handle to text_stat1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns text_stat1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from text_stat1

handles.chanId = get(hObject,'Value');
if handles.chanId > 16,
    handles.chanId = 16;
end

% Update handles structure
guidata(hObject, handles);

pushbutton_plot_Callback(handles.pushbutton_plot, eventdata, handles)
slider_select_Callback(handles.slider_select, eventdata, handles)


% --- Executes on button press in pushbutton_popgraph.
function pushbutton_popgraph_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_popgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = figure;
AxeId = get(handles.popupmenu_popgraph,'Value');
b = copyobj(handles.(sprintf('axes%d',AxeId)), a);
% set(b, 'Position', [0.1300    0.1100    0.7750    0.3439]);
set(b, 'Position', get(gcf, 'DefaultAxesPosition'))
set(b, 'Units','normalized', 'OuterPosition', [0 0 1 1]);

fileList = get(handles.listbox_file, 'String');
num = get(handles.listbox_file, 'value');

svalue =  fileList{num};
addlabel(1,0,svalue);

%orient tall


% --- Executes on selection change in popupmenu_popgraph.
function popupmenu_popgraph_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_popgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_popgraph contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_popgraph


% --- Executes during object creation, after setting all properties.
function popupmenu_popgraph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_popgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_timeseries.
function pushbutton_timeseries_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_timeseries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
saveFlag = get(handles.checkbox_export,'Value');

channelName = handles.channelName;

hfig1 =figure('Position', [25 70 1200 600]);

y= handles.st(:,:)*1e9; % nm
for k=1:8,
    h(k)=subplot(4,2,k);
    plot(handles.t, y(:,k)); hold on;
    
    % For V plane tolerance is 1 micro peak to peak
    % For H plane tolorance is 4 micro peak to peak
    
    if  strcmp(channelName{k}(end), 'Z')
        plot([0 handles.tmax], [500 500], 'r-');
        plot([0 handles.tmax], -[500 500], 'r-');
    end
    
    if  k == 15 || k == 16
        xlabel(' Time (s)')
    end
    tmp = legend(sprintf('%s: %.0f nm', channelName{k}, max(abs(y(:,k)))));
    set(tmp, 'FontSize', 8, 'Location', 'NorthEast', 'Interpreter', 'None');
    set(tmp, 'Position', get(tmp, 'Position')+[0.004 0.03 0 0]);
    ylabel('Position (nm)')
end
fileList = get(handles.listbox_file, 'String');
num = get(handles.listbox_file, 'value');

svalue =  fileList{num};
addlabel(1,0,svalue);

% Repeat necessary for save data
linkaxes(h, 'xy');
xlim([0 96])
ylim([-1 1]*1e3);

if saveFlag
    name = sprintf('%s_Fig1.png', svalue(1:end-4)); 
    %print(hfig1, name, '-dpng');
    export_fig(name);
end

hfig2 = figure('Position', [25 70 1200 600]);

for k=9:16,
    h(k) = subplot(4,2,k-8);
    plot(handles.t, y(:,k)); hold on;

    % For V plane tolerance is 1 micro peak to peak
    % For H plane tolorance is 4 micro peak to peak

    if  strcmp(channelName{k}(end), 'Z')
        plot([0 handles.tmax], [500 500], 'r-');
        plot([0 handles.tmax], -[500 500], 'r-');
    end
    
    if k == 15 || k == 16
        xlabel(' Time (s)')
    end
    tmp = legend(sprintf('%s: %.0f nm', channelName{k}, max(abs(y(:,k)))));
    set(tmp, 'FontSize', 8, 'Location', 'NorthEast', 'Interpreter', 'None');
    get(tmp, 'Position')
    set(tmp, 'Position', get(tmp, 'Position')+[0.004 0.03 0 0]);
    ylabel('Position (nm)')
end

linkaxes(h, 'xy');
xlim([0 96])
ylim([-1 1]*1e3);

svalue =  fileList{num};
addlabel(1,0,svalue);

if saveFlag
    name = sprintf('%s_Fig2.png', svalue(1:end-4)); 
    %print(hfig2, name, '-dpng');
    export_fig(name);
end


% --- Executes on button press in checkbox_halfspectrum.
function checkbox_halfspectrum_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_halfspectrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_halfspectrum


if get(hObject,'Value')
    xlim(handles.axes3, [0 handles.Fe/2])
else
    xlim(handles.axes3, [-handles.Fe/2 handles.Fe/2])
end


% --- Executes on button press in checkbox_linearscale.
function checkbox_linearscale_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_linearscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_linearscale

if get(hObject,'Value')
    handles.linearscale = 1;
else
    handles.linearscale = 0;
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in checkbox_export.
function checkbox_export_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_export



% --- Executes on button press in pushbutton_memorize.
function pushbutton_memorize_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_memorize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.h2mem,'XData', get(handles.h2, 'Xdata'));
set(handles.h2mem,'YData', get(handles.h2, 'Ydata'));
channelName = handles.channelName;

fileList = get(handles.listbox_file, 'String');
num = get(handles.listbox_file, 'value');
svalue =  [fileList{num}(1:end-4), ': ', channelName{handles.chanId}];
set(handles.text_memorize, 'String', svalue); 


% --- Executes on button press in pushbutton_directory.
function pushbutton_directory_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
directoryname = uigetdir;
cd(directoryname)
listing = dir('*avl');
fileList = cell(length(listing),1);
for k=1:length(listing)
    fileList{k} = listing(k).name;
end

set(handles.listbox_file, 'String', fileList);

% Update handles structure
guidata(hObject, handles);
