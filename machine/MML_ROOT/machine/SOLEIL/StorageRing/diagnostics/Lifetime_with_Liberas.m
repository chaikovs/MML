function varargout = Lifetime_with_Liberas(varargin)
% LIFETIME_WITH_LIBERAS M-file for Lifetime_with_Liberas.fig
%      LIFETIME_WITH_LIBERAS, by itself, creates a new LIFETIME_WITH_LIBERAS or raises the existing
%      singleton*.
%
%      H = LIFETIME_WITH_LIBERAS returns the handle to a new LIFETIME_WITH_LIBERAS or the handle to
%      the existing singleton*.
%
%      LIFETIME_WITH_LIBERAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LIFETIME_WITH_LIBERAS.M with the given input arguments.
%
%      LIFETIME_WITH_LIBERAS('Property','Value',...) creates a new LIFETIME_WITH_LIBERAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Lifetime_with_Liberas_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Lifetime_with_Liberas_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Lifetime_with_Liberas

% Last Modified by GUIDE v2.5 11-Jul-2011 11:59:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Lifetime_with_Liberas_OpeningFcn, ...
                   'gui_OutputFcn',  @Lifetime_with_Liberas_OutputFcn, ...
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


% --- Executes just before Lifetime_with_Liberas is made visible.
function Lifetime_with_Liberas_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Lifetime_with_Liberas (see VARARGIN)

% Choose default command line output for Lifetime_with_Liberas
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Lifetime_with_Liberas wait for user response (see UIRESUME)
% uiwait(handles.figure1);
Red=0.877;
Green=0.889;
Blue=1.000;
BackgroundColor=[Red Green Blue];
setappdata(handles.figure1,'BackGroundColor',BackgroundColor);

set(handles.figure1,'Color',BackgroundColor);
set(handles.text_buff_length,'BackgroundColor',BackgroundColor);
set(handles.text_seuil_1,'BackgroundColor',BackgroundColor);
set(handles.text_seuil_2,'BackgroundColor',BackgroundColor);
set(handles.text_NLib2valid,'BackgroundColor',BackgroundColor);
set(handles.text_historic_size,'BackgroundColor',BackgroundColor);
set(handles.text_LT_Libera,'BackgroundColor',BackgroundColor);
set(handles.text_LT_DCCT,'BackgroundColor',BackgroundColor);
set(handles.text_title,'BackgroundColor',BackgroundColor);
set(handles.N_Liberas,'BackgroundColor',BackgroundColor);
set(handles.Process_Time,'BackgroundColor',BackgroundColor);
set(handles.start_stop,'BackgroundColor','Green');

text_color=[0.824 0.824 0.895]
set(handles.Lib_list,'BackgroundColor',text_color);


N_samples=1000;
setappdata(handles.figure1,'N_samples',N_samples);
set(handles.N_samples,'string',num2str(N_samples));

historic_size=10000;
setappdata(handles.figure1,'historic_size',historic_size);
set(handles.historic_size,'string',num2str(historic_size));

seuil_1=0.2;
setappdata(handles.figure1,'seuil_1',seuil_1);
set(handles.seuil_1,'string',num2str(seuil_1));

seuil_2=0.06;
setappdata(handles.figure1,'seuil_2',seuil_2);
set(handles.seuil_2,'string',num2str(seuil_2));

NLib2valid=60;
setappdata(handles.figure1,'NLib2valid',NLib2valid);
set(handles.NLib2valid,'string',num2str(NLib2valid));

NBPM=size(family2tangodev('BPMx'),1)
previous_LT_Lib(1:NBPM)=0;
setappdata(handles.figure1,'previous_LT_Lib',previous_LT_Lib);

N_lib_valid(1:historic_size)=NaN;
setappdata(handles.figure1,'N_lib_valid',N_lib_valid);

N_lib_valid_first_sort(1:historic_size)=NaN;
setappdata(handles.figure1,'N_lib_valid_first_sort',N_lib_valid_first_sort);

N_lib_valid_second_sort(1:historic_size)=NaN;
setappdata(handles.figure1,'N_lib_valid_second_sort',N_lib_valid_second_sort);

LT_lib_mean(1:historic_size)=NaN;
setappdata(handles.figure1,'LT_lib_mean',LT_lib_mean);

LT_lib_by_quarter(1:4,1:historic_size)=NaN;
setappdata(handles.figure1,'LT_lib_by_quarter',LT_lib_by_quarter);

LT_DCCT(1:historic_size)=NaN;
setappdata(handles.figure1,'LT_DCCT',LT_DCCT);

Time_history(1:historic_size)=NaN;
setappdata(handles.figure1,'Time_history',Time_history);

DCCT_history(1:historic_size)=NaN;
setappdata(handles.figure1,'DCCT_history',DCCT_history);



bpm_group=tango_group_create('bpms')
dev_list=family2tangodev('BPMx')
for i=1:1:size(dev_list,1)
    tango_group_add(bpm_group,dev_list{i})
    BPM_index(i)=i;
end
tango_group_dump(bpm_group)
tango_group_ping(bpm_group)
N_BPM=tango_group_size(bpm_group);
setappdata(handles.figure1,'dev_list',dev_list);
setappdata(handles.figure1,'N_BPM',N_BPM);
setappdata(handles.figure1,'BPM_index',BPM_index);
setappdata(handles.figure1,'bpm_group',bpm_group);

timer_id=timer('Period', 2.0,'ExecutionMode','fixedSpacing');
timer_id.TimerFcn = {@LT_Process,handles,hObject,eventdata};
%timer_id.StopFcn = {@stop_fofb,handles,hObject,eventdata};
setappdata(handles.figure1,'timer_id',timer_id);


% --- Outputs from this function are returned to the command line.
function varargout = Lifetime_with_Liberas_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function LT_Process(obj, event, handles,hObject,eventdata)

previous_LT_Lib=getappdata(handles.figure1,'previous_LT_Lib');
N_lib_valid=getappdata(handles.figure1,'N_lib_valid');
N_lib_valid_first_sort=getappdata(handles.figure1,'N_lib_valid_first_sort');
N_lib_valid_second_sort=getappdata(handles.figure1,'N_lib_valid_second_sort');
LT_lib_mean=getappdata(handles.figure1,'LT_lib_mean');
LT_lib_by_quarter=getappdata(handles.figure1,'LT_lib_by_quarter');
LT_DCCT=getappdata(handles.figure1,'LT_DCCT');
N_BPM=getappdata(handles.figure1,'N_BPM');
BPM_index=getappdata(handles.figure1,'BPM_index');
bpm_group=getappdata(handles.figure1,'bpm_group');
N_samples=str2num(get(handles.N_samples,'string'));
historic_size=str2num(get(handles.historic_size,'string'));
seuil_1=str2num(get(handles.seuil_1,'string'));
seuil_2=str2num(get(handles.seuil_2,'string'));
NLib2valid=str2num(get(handles.NLib2valid,'string'));
setappdata(handles.figure1,'NLib2valid',NLib2valid);
BackgroundColor=getappdata(handles.figure1,'BackGroundColor');

Time_history=getappdata(handles.figure1,'Time_history');
DCCT_history=getappdata(handles.figure1,'DCCT_history');
old_historic_size=getappdata(handles.figure1,'historic_size');
if old_historic_size<historic_size
    fill(1:historic_size-old_historic_size)=NaN;
    fill4(4,1:historic_size-old_historic_size)=NaN;
    N_lib_valid=[fill N_lib_valid];
    N_lib_valid_first_sort=[fill N_lib_valid_first_sort];
    N_lib_valid_second_sort=[fill N_lib_valid_second_sort];
    LT_lib_mean=[fill LT_lib_mean];
    LT_lib_by_quarter=[fill4 LT_lib_by_quarter];
    LT_DCCT=[fill LT_DCCT];
    Time_history=[fill Time_history];
    DCCT_history=[fill DCCT_history];
elseif old_historic_size>historic_size
    N_lib_valid=N_lib_valid(old_historic_size-historic_size+1:old_historic_size);
    N_lib_valid_first_sort=N_lib_valid_first_sort(old_historic_size-historic_size+1:old_historic_size);
    N_lib_valid_second_sort=N_lib_valid_second_sort(old_historic_size-historic_size+1:old_historic_size);
    LT_lib_mean=LT_lib_mean(old_historic_size-historic_size+1:old_historic_size);
    LT_lib_by_quarter=LT_lib_by_quarter(:,old_historic_size-historic_size+1:old_historic_size);

   LT_DCCT=LT_DCCT(old_historic_size-historic_size+1:old_historic_size);
    Time_history=Time_history(old_historic_size-historic_size+1:old_historic_size);
    DCCT_history=DCCT_history(old_historic_size-historic_size+1:old_historic_size);
end
tic  
h=now;
[previous_LT_Lib,LT_lib_mean,LT_lib_by_quarter,N_lib_valid,N_lib_valid_first_sort,N_lib_valid_second_sort,LT_DCCT,index_seuil_1,index_seuil_2,Time_history, DCCT_history]=...
    get_LT(bpm_group,BPM_index,N_samples,previous_LT_Lib,LT_lib_mean,LT_lib_by_quarter,N_lib_valid,...
            N_lib_valid_first_sort,N_lib_valid_second_sort,LT_DCCT,seuil_1,seuil_2,NLib2valid,Time_history,DCCT_history);
t=toc;
set(handles.Liberas_LT,'string',[num2str(LT_lib_mean(size(LT_lib_mean,2)),'%3.2f'),' Hrs']);
set(handles.DCCT_LT,'string',[num2str(LT_DCCT(size(LT_DCCT,2)),'%3.2f'),' Hrs']);
set(handles.N_Liberas,'string',['Number of valid Liberas = ',num2str(N_lib_valid_second_sort(size(N_lib_valid_second_sort,2)))]);
if N_lib_valid_second_sort(size(N_lib_valid_second_sort,2))<NLib2valid
    set(handles.N_Liberas,'BackgroundColor','Red');
else
    set(handles.N_Liberas,'BackgroundColor',BackgroundColor);
end    

set(handles.Process_Time,'string',['Process Time = ',num2str(t,'%2.1f'),' sec']);

axes(handles.LT_Libera)
plot(handles.LT_Libera,previous_LT_Lib,'bo','LineWidth',2)
xlabel(handles.LT_Libera,'BPM Number')
ylabel(handles.LT_Libera,'Hours')
title(handles.LT_Libera,'Last LT measurment for each Libera')
hold(handles.LT_Libera,'on')
plot(handles.LT_Libera,index_seuil_2,previous_LT_Lib(index_seuil_2),'gx','LineWidth',3,'MarkerSize',20)
plot(handles.LT_Libera,index_seuil_1,previous_LT_Lib(index_seuil_1),'rx','LineWidth',3,'MarkerSize',20)
hold(handles.LT_Libera,'off')

dev_list=getappdata(handles.figure1,'dev_list');

text=datestr(now);
text=strvcat(text,'First Sort:');
[Y1,I1]=sort(previous_LT_Lib(index_seuil_1));
for k=1:1:size(index_seuil_1,2)    
    next_line=[dev_list{index_seuil_1(I1(k))},': ',num2str(Y1(k),'%3.2f'),' hours'];
    text=strvcat(text,next_line);
end
text=strvcat(text,'Second Sort:');
[Y2,I2]=sort(previous_LT_Lib(index_seuil_2));
for k=1:1:size(index_seuil_2,2) 
    if isempty(find(I1==I2(k)))
    next_line=[dev_list{index_seuil_2(I2(k))},': ',num2str(Y2(k),'%3.2f'),' hours'];
    text=strvcat(text,next_line);
    end
end
set(handles.Lib_list,'string',text);

formatstr= 'HH:MM';

axes(handles.N_Libera_remaining)
if get(handles.is_stats,'value')
    plot(handles.N_Libera_remaining,Time_history,N_lib_valid,'b')
    hold(handles.N_Libera_remaining,'on')
    plot(handles.N_Libera_remaining,Time_history,N_lib_valid_first_sort,'r')
    plot(handles.N_Libera_remaining,Time_history,N_lib_valid_second_sort,'g')
    hold(handles.N_Libera_remaining,'off')
    legend(handles.N_Libera_remaining,'valid buffer length','first sort','second sort','Location','NorthWest')
    title(handles.N_Libera_remaining,'History of valid Libera measurments number')
else
    plot(handles.N_Libera_remaining,Time_history,DCCT_history,'b')
end
datetick(handles.N_Libera_remaining,'x',formatstr);


axes(handles.LT_History)
plot(handles.LT_History,Time_history,LT_lib_mean,'b','LineWidth',3)
hold(handles.LT_History,'on')
plot(handles.LT_History,Time_history,LT_DCCT,'r','LineWidth',3)
%ylim(handles.LT_History,[10 15]);
if get(handles.disp_quarter,'value')
    plot(handles.LT_History,Time_history,LT_lib_by_quarter(1,:),'k');
    plot(handles.LT_History,Time_history,LT_lib_by_quarter(2,:),'g');
    plot(handles.LT_History,Time_history,LT_lib_by_quarter(3,:),'m');
    plot(handles.LT_History,Time_history,LT_lib_by_quarter(4,:),'c');
    legend(handles.LT_History,'Libera all','DCCT','Libera Q1','Libera Q2','Libera Q3','Libera Q4','Location','NorthWest')
else
    legend(handles.LT_History,'Libera all','DCCT','Location','NorthWest')
end
hold(handles.LT_History,'off')
ylabel(handles.LT_History,'Hours')
title(handles.LT_History,'Lifetime History')
datetick(handles.LT_History,'x',formatstr);

setappdata(handles.figure1,'previous_LT_Lib',previous_LT_Lib);
setappdata(handles.figure1,'N_lib_valid',N_lib_valid);
setappdata(handles.figure1,'N_lib_valid_first_sort',N_lib_valid_first_sort);
setappdata(handles.figure1,'N_lib_valid_second_sort',N_lib_valid_second_sort);
setappdata(handles.figure1,'LT_lib_mean',LT_lib_mean);
setappdata(handles.figure1,'LT_lib_by_quarter',LT_lib_by_quarter);
setappdata(handles.figure1,'LT_DCCT',LT_DCCT);
setappdata(handles.figure1,'N_BPM',N_BPM);
setappdata(handles.figure1,'BPM_index',BPM_index);
setappdata(handles.figure1,'bpm_group',bpm_group);

setappdata(handles.figure1,'N_samples',N_samples);
setappdata(handles.figure1,'historic_size',historic_size);
setappdata(handles.figure1,'seuil_1',seuil_1);
setappdata(handles.figure1,'seuil_2',seuil_2);
setappdata(handles.figure1,'NLib2valid',NLib2valid);

setappdata(handles.figure1,'Time_history',Time_history);
setappdata(handles.figure1,'DCCT_history',DCCT_history);


function N_samples_Callback(hObject, eventdata, handles)
% hObject    handle to N_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N_samples as text
%        str2double(get(hObject,'String')) returns contents of N_samples as a double


% --- Executes during object creation, after setting all properties.
function N_samples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DCCT_LT_Callback(hObject, eventdata, handles)
% hObject    handle to DCCT_LT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DCCT_LT as text
%        str2double(get(hObject,'String')) returns contents of DCCT_LT as a double


% --- Executes during object creation, after setting all properties.
function DCCT_LT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DCCT_LT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Liberas_LT_Callback(hObject, eventdata, handles)
% hObject    handle to Liberas_LT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Liberas_LT as text
%        str2double(get(hObject,'String')) returns contents of Liberas_LT as a double


% --- Executes during object creation, after setting all properties.
function Liberas_LT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Liberas_LT (see GCBO)
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
state=get(handles.start_stop,'string');
switch state
    case 'Stop'
       set(handles.start_stop,'string','Start');
       set(handles.start_stop,'BackgroundColor','Green');
       %stop timer
       timer_id=getappdata(handles.figure1,'timer_id');
       stop(timer_id);
    case 'Start'
       set(handles.start_stop,'string','Stop');   
       set(handles.start_stop,'BackgroundColor','Red');
      %start timer
       timer_id=getappdata(handles.figure1,'timer_id');
       start(timer_id);

end


% --- Executes on selection change in Lib_list.
function Lib_list_Callback(hObject, eventdata, handles)
% hObject    handle to Lib_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Lib_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Lib_list


% --- Executes during object creation, after setting all properties.
function Lib_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lib_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function historic_size_Callback(hObject, eventdata, handles)
% hObject    handle to historic_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of historic_size as text
%        str2double(get(hObject,'String')) returns contents of historic_size as a double


% --- Executes during object creation, after setting all properties.
function historic_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to historic_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function seuil_1_Callback(hObject, eventdata, handles)
% hObject    handle to seuil_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seuil_1 as text
%        str2double(get(hObject,'String')) returns contents of seuil_1 as a double


% --- Executes during object creation, after setting all properties.
function seuil_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seuil_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function seuil_2_Callback(hObject, eventdata, handles)
% hObject    handle to seuil_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seuil_2 as text
%        str2double(get(hObject,'String')) returns contents of seuil_2 as a double


% --- Executes during object creation, after setting all properties.
function seuil_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seuil_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NLib2valid_Callback(hObject, eventdata, handles)
% hObject    handle to NLib2valid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NLib2valid as text
%        str2double(get(hObject,'String')) returns contents of NLib2valid as a double


% --- Executes during object creation, after setting all properties.
function NLib2valid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NLib2valid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in disp_quarter.
function disp_quarter_Callback(hObject, eventdata, handles)
% hObject    handle to disp_quarter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of disp_quarter


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
struct.LT_lib_mean=getappdata(handles.figure1,'LT_lib_mean');
struct.LT_lib_by_quarter=getappdata(handles.figure1,'LT_lib_by_quarter');
struct.LT_DCCT=getappdata(handles.figure1,'LT_DCCT');
struct.Time_history=getappdata(handles.figure1,'Time_history');
struct.DCCT_history=getappdata(handles.figure1,'DCCT_history');
uisave('struct','/home/operateur/GrpDiagnostics/matlab/data/');