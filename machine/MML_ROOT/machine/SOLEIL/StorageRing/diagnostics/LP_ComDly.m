function varargout = LP_ComDly(varargin)
% LP_COMDLY M-file for LP_ComDly.fig
%      LP_COMDLY, by itself, creates a new LP_COMDLY or raises the existing
%      singleton*.
%
%      H = LP_COMDLY returns the handle to a new LP_COMDLY or the handle to
%      the existing singleton*.
%
%      LP_COMDLY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LP_COMDLY.M with the given input arguments.
%
%      LP_COMDLY('Property','Value',...) creates a new LP_COMDLY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LP_ComDly_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LP_ComDly_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LP_ComDly

% Last Modified by GUIDE v2.5 01-Jul-2008 11:58:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LP_ComDly_OpeningFcn, ...
                   'gui_OutputFcn',  @LP_ComDly_OutputFcn, ...
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


% --- Executes just before LP_ComDly is made visible.
function LP_ComDly_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LP_ComDly (see VARARGIN)
set(handles.Device_name,'String',family2tangodev('BPMx'));
dev=get(handles.Device_name,'String');
%device_list=dev(1:120,:)
groupe=create_group_from_list(dev);
%fofb_read_LP_Delay(groupe);

CC_status=768*4;
read_array=int32([CC_status,4,256]);

result=(tango_group_command_inout2(groupe,'ReadFAData',1,read_array));
for i=1:1:size(dev,1)
    BPM_index(i)=i;
    Delay(i)=result.replies(i).data(29)/106;
    involved(i)=result.replies(i).data(30);
    for j=1:1:3        
        LP_array(i,j)=result.replies(i).data(j+2);
    end
end
%BPM_index(1)=size(dev,1);
tango_group_kill(groupe);
Full_array=[BPM_index' Delay' involved' LP_array];
sorted_array=sortrows(Full_array,2);
set(handles.index,'string',num2str(BPM_index'));
set(handles.involved,'string',num2str(involved'));
set(handles.LP1,'string',num2str(LP_array(:,1)));
set(handles.LP2,'string',num2str(LP_array(:,2)));
set(handles.LP3,'string',num2str(LP_array(:,3)));
set(handles.Comm_dly,'string',num2str(Delay'));
disp('BPMindex  seen    Com_dly        LP1        LP2        LP3')
disp(sorted_array)
% Choose default command line output for LP_ComDly
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LP_ComDly wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LP_ComDly_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Device_name.
function Device_name_Callback(hObject, eventdata, handles)
% hObject    handle to Device_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Device_name contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Device_name

val=get(handles.Device_name,'value');
top=get(handles.Device_name,'ListboxTop')
set(handles.index,'value',val)
set(handles.index,'ListboxTop',top)
set(handles.involved,'value',val)
set(handles.involved,'ListboxTop',top)
set(handles.LP1,'value',val)
set(handles.LP1,'ListboxTop',top)
set(handles.LP2,'value',val)
set(handles.LP2,'ListboxTop',top)
set(handles.LP3,'value',val)
set(handles.LP3,'ListboxTop',top)
set(handles.Comm_dly,'value',val)
set(handles.Comm_dly,'ListboxTop',top)

% --- Executes during object creation, after setting all properties.
function Device_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Device_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in LP1.
function LP1_Callback(hObject, eventdata, handles)
% hObject    handle to LP1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns LP1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LP1
val=get(handles.LP1,'value');
top=get(handles.LP1,'ListboxTop')
set(handles.index,'value',val)
set(handles.index,'ListboxTop',top)
set(handles.involved,'value',val)
set(handles.involved,'ListboxTop',top)
set(handles.Device_name,'value',val)
set(handles.Device_name,'ListboxTop',top)
set(handles.LP2,'value',val)
set(handles.LP2,'ListboxTop',top)
set(handles.LP3,'value',val)
set(handles.LP3,'ListboxTop',top)
set(handles.Comm_dly,'value',val)
set(handles.Comm_dly,'ListboxTop',top)


% --- Executes during object creation, after setting all properties.
function LP1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LP1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in index.
function index_Callback(hObject, eventdata, handles)
% hObject    handle to index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns index contents as cell array
%        contents{get(hObject,'Value')} returns selected item from index
val=get(handles.index,'value');
top=get(handles.index,'ListboxTop')
set(handles.Device_name,'value',val)
set(handles.Device_name,'ListboxTop',top)
set(handles.involved,'value',val)
set(handles.involved,'ListboxTop',top)
set(handles.LP1,'value',val)
set(handles.LP1,'ListboxTop',top)
set(handles.LP2,'value',val)
set(handles.LP2,'ListboxTop',top)
set(handles.LP3,'value',val)
set(handles.LP3,'ListboxTop',top)
set(handles.Comm_dly,'value',val)
set(handles.Comm_dly,'ListboxTop',top)


% --- Executes during object creation, after setting all properties.
function index_CreateFcn(hObject, eventdata, handles)
% hObject    handle to index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in LP3.
function LP3_Callback(hObject, eventdata, handles)
% hObject    handle to LP3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns LP3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LP3
val=get(handles.LP3,'value');
top=get(handles.LP3,'ListboxTop')
set(handles.index,'value',val)
set(handles.index,'ListboxTop',top)
set(handles.involved,'value',val)
set(handles.involved,'ListboxTop',top)
set(handles.LP1,'value',val)
set(handles.LP1,'ListboxTop',top)
set(handles.LP2,'value',val)
set(handles.LP2,'ListboxTop',top)
set(handles.Device_name,'value',val)
set(handles.Device_name,'ListboxTop',top)
set(handles.Comm_dly,'value',val)
set(handles.Comm_dly,'ListboxTop',top)


% --- Executes during object creation, after setting all properties.
function LP3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LP3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in LP2.
function LP2_Callback(hObject, eventdata, handles)
% hObject    handle to LP2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns LP2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LP2
val=get(handles.LP2,'value');
top=get(handles.LP2,'ListboxTop')
set(handles.index,'value',val)
set(handles.index,'ListboxTop',top)
set(handles.involved,'value',val)
set(handles.involved,'ListboxTop',top)
set(handles.LP1,'value',val)
set(handles.LP1,'ListboxTop',top)
set(handles.Device_name,'value',val)
set(handles.Device_name,'ListboxTop',top)
set(handles.LP3,'value',val)
set(handles.LP3,'ListboxTop',top)
set(handles.Comm_dly,'value',val)
set(handles.Comm_dly,'ListboxTop',top)


% --- Executes during object creation, after setting all properties.
function LP2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LP2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in involved.
function involved_Callback(hObject, eventdata, handles)
% hObject    handle to involved (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns involved contents as cell array
%        contents{get(hObject,'Value')} returns selected item from involved
val=get(handles.involved,'value');
top=get(handles.involved,'ListboxTop')
set(handles.index,'value',val)
set(handles.index,'ListboxTop',top)
set(handles.Device_name,'value',val)
set(handles.Device_name,'ListboxTop',top)
set(handles.LP1,'value',val)
set(handles.LP1,'ListboxTop',top)
set(handles.LP2,'value',val)
set(handles.LP2,'ListboxTop',top)
set(handles.LP3,'value',val)
set(handles.LP3,'ListboxTop',top)
set(handles.Comm_dly,'value',val)
set(handles.Comm_dly,'ListboxTop',top)


% --- Executes during object creation, after setting all properties.
function involved_CreateFcn(hObject, eventdata, handles)
% hObject    handle to involved (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Comm_dly.
function Comm_dly_Callback(hObject, eventdata, handles)
% hObject    handle to Comm_dly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Comm_dly contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Comm_dly
val=get(handles.Comm_dly,'value');
top=get(handles.Comm_dly,'ListboxTop')
set(handles.index,'value',val)
set(handles.index,'ListboxTop',top)
set(handles.involved,'value',val)
set(handles.involved,'ListboxTop',top)
set(handles.LP1,'value',val)
set(handles.LP1,'ListboxTop',top)
set(handles.LP2,'value',val)
set(handles.LP2,'ListboxTop',top)
set(handles.LP3,'value',val)
set(handles.LP3,'ListboxTop',top)
set(handles.Device_name,'value',val)
set(handles.Device_name,'ListboxTop',top)


% --- Executes during object creation, after setting all properties.
function Comm_dly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Comm_dly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in update.
function update_Callback(hObject, eventdata, handles)
% hObject    handle to update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dev=get(handles.Device_name,'String');
device_list=dev;
groupe=create_group_from_list(device_list);
%fofb_read_LP_Delay(groupe);

CC_status=768*4;
CC_index=0;
read_array=int32([CC_status,4,256]);
index_array=int32([CC_index,4,1]);

result=(tango_group_command_inout2(groupe,'ReadFAData',1,read_array));
index_result=(tango_group_command_inout2(groupe,'ReadFAData',1,index_array));
for i=1:1:size(dev,1)
    BPM_index(i)=index_result.replies(i).data;
    Delay(i)=single(result.replies(i).data(29)/10.6)/10;
    involved(i)=result.replies(i).data(30);
    for j=1:1:3        
        LP_array(i,j)=result.replies(i).data(j+2);
    end
end

tango_group_kill(groupe);

is_index=get(handles.sort_index,'value');
if is_index
   [sorted_array,I]=sortrows(BPM_index');
else
   [sorted_array,I]=sortrows(Delay',-1); 
end

set(handles.Device_name,'string',device_list(I,:));
set(handles.index,'string',num2str(BPM_index(I)'));
set(handles.involved,'string',num2str(involved(I)'));
set(handles.LP1,'string',num2str(LP_array(I,1)));
set(handles.LP2,'string',num2str(LP_array(I,2)));
set(handles.LP3,'string',num2str(LP_array(I,3)));
set(handles.Comm_dly,'string',num2str(Delay(I)'));

% --- Executes on button press in sort_index.
function sort_index_Callback(hObject, eventdata, handles)
% hObject    handle to sort_index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sort_delay.
function sort_delay_Callback(hObject, eventdata, handles)
% hObject    handle to sort_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


