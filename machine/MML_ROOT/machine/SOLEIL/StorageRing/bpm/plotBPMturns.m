function varargout = plotBPMturns(varargin)
% PLOTBPMTURNS M-file for plotBPMturns.fig
%      PLOTBPMTURNS, by itself, creates a new PLOTBPMTURNS or raises the existing
%      singleton*.
%
%      H = PLOTBPMTURNS returns the handle to a new PLOTBPMTURNS or the handle to
%      the existing singleton*.
%
%      PLOTBPMTURNS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTBPMTURNS.M with the given input arguments.
%
%      PLOTBPMTURNS('Property','Value',...) creates a new PLOTBPMTURNS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plotBPMturns_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plotBPMturns_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plotBPMturns

% Last Modified by GUIDE v2.5 08-Aug-2006 14:29:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plotBPMturns_OpeningFcn, ...
                   'gui_OutputFcn',  @plotBPMturns_OutputFcn, ...
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


% --- Executes just before plotBPMturns is made visible.
function plotBPMturns_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plotBPMturns (see VARARGIN)

% fprintf('%6.2f\n',hObject);

datacursormode on;

% Choose default command line output for plotBPMturns
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Make figure resizable
set(hObject,'Resize','off');

% Set default values for the various fields.
set(handles.turns_input,'String','[1:100]');
set(handles.FFTturns_input,'String','[1:100]');
set(handles.fftxaxis,'String','[0 0.5 0 0.2 0.1 0.4]');
set(handles.fftyaxis,'String','[0 0.5 0 0.1 0.1 0.4]');
set(handles.FFTturns_input,'String','[1:512]');
set(handles.BPMdev_input,'String','[1 1]');
set(handles.sumplot_max,'String','15e5');
set(handles.sumplot_min,'String','0');
set(handles.xyplot_max,'String','10');
set(handles.xyplot_min,'String','-10');
set(handles.tuneplot_max,'String','0.5');
set(handles.tuneplot_min,'String','0');

% User data structure to store data
data.maxturns = 6663;
data.maxtunesamples = 20;
data.turnsstr = '[1:100]';
data.turns = 1:100;
data.BPMdev = [1 1];
data.sumplotaxis = [0 15e5];
data.xyplotaxis = [-10 10];
data.tuneplotaxis = [0 0.5];
data.fftturnsstr = '[1:512]';
data.fftturns = 1:512;
% The last 2 numbers define the window over which to detect the tune.
data.fftxaxis = [0 0.5 0 0.2 0.1 0.4];
data.fftyaxis = [0 0.5 0 0.1 0.1 0.4];
data.fftaverage = 10;
data.Pxx = [];   % store power spectrum for averaging
data.Pyy = [];   % store power spectrum for averaging

% for liftime calculations
data.prev_sum = NaN;
data.prev_time = NaN;
data.lifetime = NaN;
%data.lifetime_pv = 'CR01:GENERAL_ANALOG_01_MONITOR';
data.lifetime_handle = getlifetime;
data.currsumarray = NaN;
data.currsumarray2 = NaN;

data.tuneind = 1;

data.sum = zeros(data.maxturns,1);
data.x = zeros(data.maxturns,1);
data.y = zeros(data.maxturns,1)+1;
data.xtune = zeros(data.maxtunesamples,1); data.xtune(:) = NaN;
data.ytune = zeros(data.maxtunesamples,1); data.ytune(:) = NaN;

% Initialise plots
axes(handles.sum_plot);
plot(data.sum,'LineWidth',2);
set(gca,'XLim',[data.turns(1) data.turns(end)]);
set(gca,'YLim',data.sumplotaxis);

axes(handles.xy_plot);
plot(data.x,'LineWidth',2,'Color','k','Tag','Horizontal');
hold on;
plot(data.y,'LineWidth',2,'Color','b','LineStyle','--','Tag','Vertical');
hold off;
set(gca,'XLim',[data.turns(1) data.turns(end)]);
set(gca,'YLim',data.xyplotaxis);

% Tunes only plot 20 samples/updates worth of tunes
axes(handles.tune_plot);
plot(data.xtune,'LineWidth',2,'Color','k','Tag','Htune','Marker','.');
hold on;
plot(data.ytune,'LineWidth',2,'Color','b','Tag','Vtune','Marker','.','LineStyle','--');
hold off;
set(gca,'XLim',[1 data.maxtunesamples]);
set(gca,'YLim',data.tuneplotaxis);

% Plots for the FFT. With more points than would be needed.
axes(handles.fft_x);
plot(zeros(1,length(data.maxturns/2)),'LineWidth',1,'Color','k','Tag','fftx');
hold on;
% Plot the tune window over which to detect the tune
plot([data.fftxaxis(5) data.fftxaxis(5)],data.fftxaxis(3:4),'--','Color',[1.0 0.7 0.7],'Tag','fftx_lower');
plot([data.fftxaxis(6) data.fftxaxis(6)],data.fftxaxis(3:4),'--','Color',[1.0 0.7 0.7],'Tag','fftx_upper');
hold off;
axis(data.fftxaxis(1:4));

axes(handles.fft_y);
plot(zeros(1,length(data.maxturns/2)),'LineWidth',1,'Color','k','Tag','ffty');
hold on;
% Plot the tune window over which to detect the tune
plot([data.fftyaxis(5) data.fftyaxis(5)],data.fftyaxis(3:4),'--','Color',[1.0 0.7 0.7],'Tag','ffty_lower');
plot([data.fftyaxis(6) data.fftyaxis(6)],data.fftyaxis(3:4),'--','Color',[1.0 0.7 0.7],'Tag','ffty_upper');
hold off;
axis(data.fftyaxis(1:4));


set(handles.main,'UserData',data);



% --- Outputs from this function are returned to the command line.
function varargout = plotBPMturns_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function turns_input_Callback(hObject, eventdata, handles)
% hObject    handle to turns_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of turns_input as text
%        str2double(get(hObject,'String')) returns contents of turns_input as a double

data = get(handles.main,'UserData');

turnsstr = get(hObject,'String');
turns = eval(turnsstr);
if isnumeric(turns) && turns(end) < data.maxturns
    data.turnsstr = turnsstr;
    data.turns = turns;
else
    msgbox(sprintf('Invalid turns input. Max turns is < %d',data.maxturns));
    set(hObject,'String',data.turnsstr);
end
    
set(handles.main,'UserData',data);


% --- Executes during object creation, after setting all properties.
function turns_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to turns_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function BPMdev_input_Callback(hObject, eventdata, handles)
% hObject    handle to BPMdev_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BPMdev_input as text
%        str2double(get(hObject,'String')) returns contents of BPMdev_input as a double

data = get(handles.main,'UserData');

BPMdev = eval(get(hObject,'String'));
BPMdevlist = family2dev('BPMx',1);

ind = findrowindex(BPMdevlist,BPMdev);
if isempty(ind)
    msgbox('Invalid BPM device index');
    set(hObject,'String',sprintf('[%d %d]',data.BPMdev(1), data.BPMdev(2)));
else
    data.BPMdev = BPMdev;
end

set(handles.main,'UserData',data);


% --- Executes during object creation, after setting all properties.
function BPMdev_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BPMdev_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start_stop.
function start_stop_Callback(hObject, eventdata, handles)
% hObject    handle to start_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of start_stop

OnFlag = get(handles.start_stop,'Value');

if OnFlag
    % Turn on updates
    set(handles.start_stop, 'String', 'Running');    
    
    % Turn lattice menu back off
    %set(handles.('LatticeMenu'),'enable','off');
    
    % Setup timer
    UpdatePeriod = 0.5;
    t = timer;
    set(t,'StartDelay',0);
    set(t,'Period', UpdatePeriod);
    tagstr = sprintf('PlotBPMTimer_%6.2f',handles.main);
    set(t,'Tag', tagstr);
    timerstr = sprintf('plotBPMturns(''single_shot_Callback'', getfield(get(timerfind(''Tag'',''%s''),''Userdata''),''main''), [], get(timerfind(''Tag'',''%s''),''Userdata'')); drawnow;',...
        tagstr,tagstr);
    set(t,'TimerFcn', timerstr);
    set(t,'UserData', handles);
       
    set(t,'BusyMode','drop');  %'queue'
    set(t,'TasksToExecute', 10000000);
    set(t,'ExecutionMode','FixedRate');
    start(t);
    
else
    % Turn off updating by deleting timer handle
    tagstr = sprintf('PlotBPMTimer_%6.2f',handles.main);
    h = timerfind('Tag',tagstr);
    for i = 1:length(h)
        stop(h(i));
        delete(h(i));
    end

    % Change OnOff label string
    set(handles.start_stop, 'String', 'Continuous');
end




function sumplot_max_Callback(hObject, eventdata, handles)
% hObject    handle to sumplot_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sumplot_max as text
%        str2double(get(hObject,'String')) returns contents of sumplot_max as a double
data = get(handles.main,'UserData');

val = str2double(get(hObject,'String'));
if ~isnan(val) 
    data.sumplotaxis(2) = val;
else
    msgbox('Invalid number');
    set(hObject,'String',num2str(data.sumplotaxis(2)));
end

set(handles.main,'UserData',data);
    

% --- Executes during object creation, after setting all properties.
function sumplot_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sumplot_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sumplot_min_Callback(hObject, eventdata, handles)
% hObject    handle to sumplot_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sumplot_min as text
%        str2double(get(hObject,'String')) returns contents of sumplot_min as a double

data = get(handles.main,'UserData');

val = str2double(get(hObject,'String'));
if ~isnan(val) 
    data.sumplotaxis(1) = val;
else
    msgbox('Invalid number');
    set(hObject,'String',num2str(data.sumplotaxis(1)));
end

set(handles.main,'UserData',data);

% --- Executes during object creation, after setting all properties.
function sumplot_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sumplot_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xyplot_max_Callback(hObject, eventdata, handles)
% hObject    handle to xyplot_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xyplot_max as text
%        str2double(get(hObject,'String')) returns contents of xyplot_max as a double

data = get(handles.main,'UserData');

val = str2double(get(hObject,'String'));
if ~isnan(val) 
    data.xyplotaxis(2) = val;
else
    msgbox('Invalid number');
    set(hObject,'String',num2str(data.xyplotaxis(2)));
end

set(handles.main,'UserData',data);


% --- Executes during object creation, after setting all properties.
function xyplot_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xyplot_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xyplot_min_Callback(hObject, eventdata, handles)
% hObject    handle to xyplot_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xyplot_min as text
%        str2double(get(hObject,'String')) returns contents of xyplot_min as a double

data = get(handles.main,'UserData');

val = str2double(get(hObject,'String'));
if ~isnan(val) 
    data.xyplotaxis(1) = val;
else
    msgbox('Invalid number');
    set(hObject,'String',num2str(data.xyplotaxis(1)));
end

set(handles.main,'UserData',data);

% --- Executes during object creation, after setting all properties.
function xyplot_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xyplot_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tuneplot_max_Callback(hObject, eventdata, handles)
% hObject    handle to tuneplot_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tuneplot_max as text
%        str2double(get(hObject,'String')) returns contents of tuneplot_max as a double

data = get(handles.main,'UserData');

val = str2double(get(hObject,'String'));
if ~isnan(val) 
    data.tuneplotaxis(2) = val;
else
    msgbox('Invalid number');
    set(hObject,'String',num2str(data.tuneplotaxis(2)));
end

set(handles.main,'UserData',data);

% --- Executes during object creation, after setting all properties.
function tuneplot_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tuneplot_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tuneplot_min_Callback(hObject, eventdata, handles)
% hObject    handle to tuneplot_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tuneplot_min as text
%        str2double(get(hObject,'String')) returns contents of tuneplot_min as a double

data = get(handles.main,'UserData');

val = str2double(get(hObject,'String'));
if ~isnan(val) 
    data.tuneplotaxis(1) = val;
else
    msgbox('Invalid number');
    set(hObject,'String',num2str(data.tuneplotaxis(1)));
end

set(handles.main,'UserData',data);

% --- Executes during object creation, after setting all properties.
function tuneplot_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tuneplot_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in single_shot.
function single_shot_Callback(hObject, eventdata, handles)
% hObject    handle to single_shot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = get(handles.main,'UserData');

setlibera('TT_READY_STATUS',0,data.BPMdev);
setlibera('TT_ARM_CMD',1,data.BPMdev);

ii = 0;
while ~getlibera('TT_READY_STATUS',data.BPMdev);
    pause(0.3);
    ii = ii + 1;
    if ii > 20
        msgbox('Problem with this bpm. Maybe not triggering properly. Try another BPM');
        return
    end
end

[data.sum temp datatime] = getlibera('TT_WF_S_MONITOR',data.BPMdev);
data.x = getlibera('TT_WF_HPOS_MONITOR',data.BPMdev)/1e6; % convert into mm
data.y = getlibera('TT_WF_VPOS_MONITOR',data.BPMdev)/1e6; % convert into mm

% FFT 
npoints = 2^(floor(log2(length(data.fftturns))));

% FFT horizontal. Data stack is cleared everytime number of fft_turns is
% changed
XX = fft(data.x(data.fftturns) - mean(data.x(data.fftturns)));
f = [0:npoints/2]/npoints;
if size(data.Pxx,2) >= data.fftaverage
    % First In First Out, push data on stack
    data.Pxx(:,1:end-1) = data.Pxx(:,2:end);
    data.Pxx(:,end) = XX.*conj(XX)/npoints;
else
    data.Pxx(:,end+1) = XX.*conj(XX)/npoints;
end
Pxx_mean = mean(data.Pxx(1:npoints/2+1,:),2);

linehandle = get(handles.fft_x,'Children');
for i=1:length(linehandle)
    switch get(linehandle(i),'Tag')
        case 'fftx'
            set(linehandle(i),'XData',f,'YData',Pxx_mean);
            set(handles.fft_x,'YLim',data.fftxaxis(3:4),'XLim',data.fftxaxis(1:2));
        case 'fftx_lower'
            set(linehandle(i),'XData',[data.fftxaxis(5) data.fftxaxis(5)],'YData',data.fftxaxis(3:4));
        case 'fftx_upper'
            set(linehandle(i),'XData',[data.fftxaxis(6) data.fftxaxis(6)],'YData',data.fftxaxis(3:4));
    end
end

% Detect peak within window
indices = find(f > data.fftxaxis(5) & f < data.fftxaxis(6));
[temp xtuneind] = max(Pxx_mean(indices));
xtuneind = xtuneind + 3;
if data.tuneind == data.maxtunesamples + 1
    data.xtune(1:data.maxtunesamples-1) = data.xtune(2:data.maxtunesamples);
    data.xtune(data.maxtunesamples) = f(xtuneind+indices(1));
else
    data.xtune(data.tuneind) = f(xtuneind+indices(1));
end


% FFT vertical. Data stack is cleared everytime number of fft_turns is
% changed
YY = fft(data.y(data.fftturns) - mean(data.y(data.fftturns)));
f = [0:npoints/2]/npoints;
if size(data.Pyy,2) >= data.fftaverage
    % First In First Out, push data on stack
    data.Pyy(:,1:end-1) = data.Pyy(:,2:end);
    data.Pyy(:,end) = YY.*conj(YY)/npoints;
else
    data.Pyy(:,end+1) = YY.*conj(YY)/npoints;
end
Pyy_mean = mean(data.Pyy(1:npoints/2+1,:),2);


linehandle = get(handles.fft_y,'Children');
for i=1:length(linehandle)
    switch get(linehandle(i),'Tag')
        case 'ffty'
            set(linehandle(i),'XData',f,'YData',Pyy_mean);
            set(handles.fft_y,'YLim',data.fftyaxis(3:4),'XLim',data.fftyaxis(1:2));
        case 'ffty_lower'
            set(linehandle(i),'XData',[data.fftyaxis(5) data.fftyaxis(5)],'YData',data.fftyaxis(3:4));
        case 'ffty_upper'
            set(linehandle(i),'XData',[data.fftyaxis(6) data.fftyaxis(6)],'YData',data.fftyaxis(3:4));
    end
end

% Detect peak within window
indices = find(f > data.fftyaxis(5) & f < data.fftyaxis(6));
[temp ytuneind] = max(Pyy_mean(indices));
ytuneind = ytuneind + 3;
if data.tuneind == data.maxtunesamples + 1
    data.ytune(1:data.maxtunesamples-1) = data.ytune(2:data.maxtunesamples);
    data.ytune(data.maxtunesamples) = f(ytuneind+indices(1));
else
    data.ytune(data.tuneind) = f(ytuneind+indices(1));
    data.tuneind = data.tuneind + 1;
end


    

linehandle = get(handles.sum_plot,'Children');
set(linehandle,'YData',data.sum);
set(handles.sum_plot,'XLim',[data.turns(1) data.turns(end)]);
set(handles.sum_plot,'YLim',data.sumplotaxis);

linehandle = get(handles.xy_plot,'Children');
for i=1:length(linehandle)
    switch get(linehandle(i),'Tag')
        case 'Horizontal'
            % only set the axis limits once since it should cycle through
            % both horizontal and vertical
            set(linehandle(i),'YData',data.x);
            set(handles.xy_plot,'XLim',[data.turns(1) data.turns(end)]);
            set(handles.xy_plot,'YLim',data.xyplotaxis);
        case 'Vertical'
            set(linehandle(i),'YData',data.y);
    end
end

linehandle = get(handles.tune_plot,'Children');
for i=1:length(linehandle)
    switch get(linehandle(i),'Tag')
        case 'Htune'
            set(linehandle(i),'YData',data.xtune);
            set(handles.tune_plot,'XLim',[1 data.maxtunesamples]);
            set(handles.tune_plot,'YLim',data.tuneplotaxis);
        case 'Vtune'
            set(linehandle(i),'YData',data.ytune);
    end
end

% Calculate Lifetime
sumindex = 1000:1002;
%sumindex2 = 5000:6000;
currsum = mean(data.sum(sumindex));
%currsum2 = mean(data.sum(sumindex2));
data.currsumarray = [data.currsumarray currsum];
%data.currsumarray2 = [data.currsumarray2 currsum2];
%figure(10);
%plot(data.currsumarray,'x-');
%hold on
%plot(data.currsumarray2,'ro-');
%axis([1 length(data.currsumarray) 1.525e6 1.535e6]);
%hold off;

if isnan(data.prev_sum)
    data.lifetime = NaN;
else
    data.lifetime = - currsum/(currsum-data.prev_sum)*(datatime - data.prev_time)*1e5/60;
    %data.lifetime = - currsum/(currsum-data.prev_sum)*1/60;
end
data.prev_sum = currsum;
data.prev_time = datatime;
if data.lifetime_handle ~= 0
    mcaput(data.lifetime_handle,data.lifetime);
end

set(handles.lifetime_text,'String',sprintf('%+06.3f',data.lifetime));


set(handles.main,'UserData',data);



function FFTturns_input_Callback(hObject, eventdata, handles)
% hObject    handle to FFTturns_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FFTturns_input as text
%        str2double(get(hObject,'String')) returns contents of FFTturns_input as a double
data = get(handles.main,'UserData');

fftturnsstr = get(hObject,'String');
fftturns = eval(fftturnsstr);
if isnumeric(fftturns) && fftturns(end) < data.maxturns
    data.fftturnsstr = fftturnsstr;
    data.fftturns = fftturns;
    % If changing fft turns then must reset FFT data structure due to
    % averaging.
    data.Pxx = [];
    data.Pyy = [];
else
    msgbox(sprintf('Invalid FFT turns input. Max turns is < %d',data.maxturns));
    set(hObject,'String',data.fftturnsstr);
end

set(handles.main,'UserData',data);


% --- Executes during object creation, after setting all properties.
function FFTturns_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FFTturns_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes when main is resized.
function main_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function fftyaxis_Callback(hObject, eventdata, handles)
% hObject    handle to fftyaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fftyaxis as text
%        str2double(get(hObject,'String')) returns contents of fftyaxis as a double
data = get(handles.main,'UserData');

fftystr = get(hObject,'String');
data.fftyaxis = eval(fftystr);

set(handles.main,'UserData',data);

% --- Executes during object creation, after setting all properties.
function fftyaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fftyaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fftxaxis_Callback(hObject, eventdata, handles)
% hObject    handle to fftxaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fftxaxis as text
%        str2double(get(hObject,'String')) returns contents of fftxaxis as a double
data = get(handles.main,'UserData');

fftxstr = get(hObject,'String');
data.fftxaxis = eval(fftxstr);

set(handles.main,'UserData',data);

% --- Executes during object creation, after setting all properties.
function fftxaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fftxaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes when user attempts to close main.
function main_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

% If the continuous update still running, then turn off before closing
% window. Else it will loop and keep creating new figure, new application.
if get(handles.start_stop,'Value')
    set(handles.start_stop,'Value',0);
    start_stop_Callback(handles.start_stop, eventdata, handles)
end

% Close handle for the PV holding the lifetime values.
data = get(handles.main,'UserData');

delete(hObject);




