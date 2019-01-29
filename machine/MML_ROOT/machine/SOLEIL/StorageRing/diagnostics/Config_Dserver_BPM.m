function varargout = Config_Dserver_BPM(varargin)
% CONFIG_DSERVER_BPM M-file for Config_Dserver_BPM.fig
%      CONFIG_DSERVER_BPM, by itself, creates a new CONFIG_DSERVER_BPM or raises the existing
%      singleton*.
%
%      H = CONFIG_DSERVER_BPM returns the handle to a new CONFIG_DSERVER_BPM or the handle to
%      the existing singleton*.
%
%      CONFIG_DSERVER_BPM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIG_DSERVER_BPM.M with the given input arguments.
%
%      CONFIG_DSERVER_BPM('Property','Value',...) creates a new CONFIG_DSERVER_BPM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Config_Dserver_BPM_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Config_Dserver_BPM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Config_Dserver_BPM

% Last Modified by GUIDE v2.5 01-Dec-2006 16:56:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Config_Dserver_BPM_OpeningFcn, ...
                   'gui_OutputFcn',  @Config_Dserver_BPM_OutputFcn, ...
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


% --- Executes just before Config_Dserver_BPM is made visible.
function Config_Dserver_BPM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:1:16
handles.table(i)=0;
end
% varargin   command line arguments to Config_Dserver_BPM (see VARARGIN)

% Choose default command line output for Config_Dserver_BPM
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Config_Dserver_BPM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Config_Dserver_BPM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Booster.
function Booster_Callback(hObject, eventdata, handles)
% hObject    handle to Booster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Booster
set(handles.Tune_BPM,'value',0);
set(handles.LT2,'value',0);
set(handles.Baie_test,'value',0);
    set(handles.All,'value',0);
    set(handles.Baie1,'value',0);
    set(handles.Baie2,'value',0);
    set(handles.Baie3,'value',0);
    set(handles.Baie4,'value',0);
    set(handles.Baie5,'value',0);
    set(handles.Baie6,'value',0);
    set(handles.Baie7,'value',0);
    set(handles.Baie8,'value',0);
    set(handles.Baie9,'value',0);
    set(handles.Baie10,'value',0);
    set(handles.Baie11,'value',0);
    set(handles.Baie12,'value',0);
    set(handles.Baie13,'value',0);
    set(handles.Baie14,'value',0);
    set(handles.Baie15,'value',0);
    set(handles.Baie16,'value',0);
    for i=1:1:16
        handles.table(i)=0;
        guidata(hObject, handles);
    end
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
List=Get_Dev_List('Booster');
for j=1:1:size(List,1)
    Dev_List(Index+j,:)=List(j,:);
end
set(handles.Devices_list,'string',Dev_List); 
current_list=get(handles.Devices_list,'string');
Index=size(current_list,1);

% --- Executes on button press in LT2.
function LT2_Callback(hObject, eventdata, handles)
% hObject    handle to LT2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LT2
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
    set(handles.All,'value',0);
    set(handles.Baie1,'value',0);
    set(handles.Baie2,'value',0);
    set(handles.Baie3,'value',0);
    set(handles.Baie4,'value',0);
    set(handles.Baie5,'value',0);
    set(handles.Baie6,'value',0);
    set(handles.Baie7,'value',0);
    set(handles.Baie8,'value',0);
    set(handles.Baie9,'value',0);
    set(handles.Baie10,'value',0);
    set(handles.Baie11,'value',0);
    set(handles.Baie12,'value',0);
    set(handles.Baie13,'value',0);
    set(handles.Baie14,'value',0);
    set(handles.Baie15,'value',0);
    set(handles.Baie16,'value',0);
    for i=1:1:16
        handles.table(i)=0;
        guidata(hObject, handles);
    end
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
List=Get_Dev_List('LT2');
for j=1:1:size(List,1)
    Dev_List(Index+j,:)=List(j,:);
end
set(handles.Devices_list,'string',Dev_List); 
current_list=get(handles.Devices_list,'string');
Index=size(current_list,1);

% --- Executes on button press in Baie_test.
function Baie_test_Callback(hObject, eventdata, handles)
% hObject    handle to Baie_test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Baie_test
    set(handles.Tune_BPM,'value',0);
    set(handles.LT2,'value',0);
    set(handles.Booster,'value',0);
    set(handles.All,'value',0);
    set(handles.Baie1,'value',0);
    set(handles.Baie2,'value',0);
    set(handles.Baie3,'value',0);
    set(handles.Baie4,'value',0);
    set(handles.Baie5,'value',0);
    set(handles.Baie6,'value',0);
    set(handles.Baie7,'value',0);
    set(handles.Baie8,'value',0);
    set(handles.Baie9,'value',0);
    set(handles.Baie10,'value',0);
    set(handles.Baie11,'value',0);
    set(handles.Baie12,'value',0);
    set(handles.Baie13,'value',0);
    set(handles.Baie14,'value',0);
    set(handles.Baie15,'value',0);
    set(handles.Baie16,'value',0);
    for i=1:1:16
        handles.table(i)=0;
        guidata(hObject, handles);
    end
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
List=Get_Dev_List('test');
for j=1:1:size(List,1)
    Dev_List(Index+j,:)=List(j,:);
end
set(handles.Devices_list,'string',Dev_List); 
current_list=get(handles.Devices_list,'string');
Index=size(current_list,1);

% --- Executes on button press in Tune_BPM.
function Tune_BPM_Callback(hObject, eventdata, handles)
% hObject    handle to Tune_BPM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Tune_BPM
set(handles.LT2,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
    set(handles.All,'value',0);
    set(handles.Baie1,'value',0);
    set(handles.Baie2,'value',0);
    set(handles.Baie3,'value',0);
    set(handles.Baie4,'value',0);
    set(handles.Baie5,'value',0);
    set(handles.Baie6,'value',0);
    set(handles.Baie7,'value',0);
    set(handles.Baie8,'value',0);
    set(handles.Baie9,'value',0);
    set(handles.Baie10,'value',0);
    set(handles.Baie11,'value',0);
    set(handles.Baie12,'value',0);
    set(handles.Baie13,'value',0);
    set(handles.Baie14,'value',0);
    set(handles.Baie15,'value',0);
    set(handles.Baie16,'value',0);
    for i=1:1:16
        handles.table(i)=0;
        guidata(hObject, handles);
    end
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
List=Get_Dev_List('Tune_BPM');
for j=1:1:size(List,1)
    Dev_List(Index+j,:)=List(j,:);
end
set(handles.Devices_list,'string',Dev_List); 
current_list=get(handles.Devices_list,'string');
Index=size(current_list,1);


% --- Executes on button press in All.
function All_Callback(hObject, eventdata, handles)
% hObject    handle to All (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of All

set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
all=get(handles.All,'value');
set(handles.Baie_test,'value',0);
    set(handles.Baie1,'value',all);
    set(handles.Baie2,'value',all);
    set(handles.Baie3,'value',all);
    set(handles.Baie4,'value',all);
    set(handles.Baie5,'value',all);
    set(handles.Baie6,'value',all);
    set(handles.Baie7,'value',all);
    set(handles.Baie8,'value',all);
    set(handles.Baie9,'value',all);
    set(handles.Baie10,'value',all);
    set(handles.Baie11,'value',all);
    set(handles.Baie12,'value',all);
    set(handles.Baie13,'value',all);
    set(handles.Baie14,'value',all);
    set(handles.Baie15,'value',all);
    set(handles.Baie16,'value',all);
    for i=1:1:16
        handles.table(i)=all;
        guidata(hObject, handles);
    end
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)


if all
    List=Get_Dev_List('ANS');
    for j=1:1:size(List,1)
     Dev_List(Index+j,:)=List(j,:);
    end
    set(handles.Devices_list,'string',Dev_List); 
    current_list=get(handles.Devices_list,'string');
    Index=size(current_list,1);
end  

if all==0
    set(handles.Devices_list,'string','');
end
    

% --- Executes on button press in Baie1.
function Baie1_Callback(hObject, eventdata, handles)
% hObject    handle to Baie1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(1)=get(handles.Baie1,'value');
val=handles.table
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of Baie1
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i))
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List) 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie2.
function Baie2_Callback(hObject, eventdata, handles)
% hObject    handle to Baie2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(2)=get(handles.Baie2,'value');
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of Baie2
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie3.
function Baie3_Callback(hObject, eventdata, handles)
% hObject    handle to Baie3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(3)=get(handles.Baie3,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie3
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie4.
function Baie4_Callback(hObject, eventdata, handles)
% hObject    handle to Baie4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(4)=get(handles.Baie4,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie4
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie5.
function Baie5_Callback(hObject, eventdata, handles)
% hObject    handle to Baie5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(5)=get(handles.Baie5,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie5
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie6.
function Baie6_Callback(hObject, eventdata, handles)
% hObject    handle to Baie6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(6)=get(handles.Baie6,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie6
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie7.
function Baie7_Callback(hObject, eventdata, handles)
% hObject    handle to Baie7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(7)=get(handles.Baie7,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie7
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie8.
function Baie8_Callback(hObject, eventdata, handles)
% hObject    handle to Baie8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(8)=get(handles.Baie8,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie8
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie9.
function Baie9_Callback(hObject, eventdata, handles)
% hObject    handle to Baie9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(9)=get(handles.Baie9,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie9
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie10.
function Baie10_Callback(hObject, eventdata, handles)
% hObject    handle to Baie10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(10)=get(handles.Baie10,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie10
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie11.
function Baie11_Callback(hObject, eventdata, handles)
% hObject    handle to Baie11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(11)=get(handles.Baie11,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie11
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie12.
function Baie12_Callback(hObject, eventdata, handles)
% hObject    handle to Baie12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(12)=get(handles.Baie12,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie12
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie13.
function Baie13_Callback(hObject, eventdata, handles)
% hObject    handle to Baie13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(13)=get(handles.Baie13,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie13
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie14.
function Baie14_Callback(hObject, eventdata, handles)
% hObject    handle to Baie14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(14)=get(handles.Baie14,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie14
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie15.
function Baie15_Callback(hObject, eventdata, handles)
% hObject    handle to Baie15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(15)=get(handles.Baie15,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie15
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end

% --- Executes on button press in Baie16.
function Baie16_Callback(hObject, eventdata, handles)
% hObject    handle to Baie16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.LT2,'value',0);
set(handles.Tune_BPM,'value',0);
set(handles.Booster,'value',0);
set(handles.Baie_test,'value',0);
handles.table(16)=get(handles.Baie16,'value');
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of Baie16
List=0;
Index=0;
handles.table
set(handles.Devices_list,'value',1)
for i=1:1:16
    if handles.table(i)==1
        List=Get_Dev_List(num2str(i));
        for j=1:1:size(List,1)
         Dev_List(Index+j,:)=List(j,:);
        end
        set(handles.Devices_list,'string',Dev_List); 
        current_list=get(handles.Devices_list,'string');
        Index=size(current_list,1);
    end  
end




% --- Executes on selection change in Devices_list.
function Devices_list_Callback(hObject, eventdata, handles)
% hObject    handle to Devices_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Devices_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Devices_list


% --- Executes during object creation, after setting all properties.
function Devices_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Devices_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in attribute_list.
function attribute_list_Callback(hObject, eventdata, handles)
% hObject    handle to attribute_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns attribute_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from attribute_list
Val=get(handles.attribute_list,'value');
String=get(handles.attribute_list,'string');
attribute=String{Val};

switch attribute
    case{'DDTriggerCounter','DDBufferFreezingEnabled','DDBufferFrozen','ExternalTriggerEnabled','PMNotified','XHigh','XLow','ZHigh','ZLow','MC locked','XRMSPosSA','ZRMSPosSA','State','Status'}
        set(handles.Write_attribute,'Enable','off')
    otherwise
        set(handles.Write_attribute,'Enable','on')
end

% --- Executes during object creation, after setting all properties.
function attribute_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attribute_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Read_attribute.
function Read_attribute_Callback(hObject, eventdata, handles)
% hObject    handle to Read_attribute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Val=get(handles.attribute_list,'value');
String=get(handles.attribute_list,'string');
attribute=String{Val};

list=get(handles.Devices_list,'string');
index=get(handles.Devices_list,'value');
Dev_List=list(index,:)
switch attribute
    case {'XPosDD','ZPosDD','QuadDD','SumDD','VaDD','VbDD','VcDD','VdDD','XPosSAHistory','ZPosSAHistory','XPosPM','ZPosPM','QuadPM','SumPM','VaPM','VbPM','VcPM','VdPM','InterlockConfiguration','ADCChannelA','ADCChannelB','ADCChannelC','ADCChannelD'}
         if(size(Dev_List,1)~=1)
         warndlg('You can not select more than 1 Dserver to display an attribute that is a vector') 
         else
         res=tango_read_attribute2(Dev_List(1,:),attribute);
         axes(handles.graph);
         plot(res.value);
         ylabel('mm');
         title(attribute);
         end
    otherwise
%h = waitbar(0,'Please wait...');
groupe=create_bpm_group(Dev_List);
result=tango_group_read_attribute(groupe,attribute,1)
tango_group_kill(groupe);
for i=1:1:size(Dev_List,1)
val_list(i)=result.replies(i).value(1);
%     switch attribute
%         case 'MC locked'
%             if i==1
%                MCstatus_file=fopen('MC_Locked_satus.txt','wt');
%             end 
%             libera_ip=tango_get_property2(Dev_List(i,:),'LiberaIpAddr');
%             fid=fopen('liste-IP-libera-test.txt','wt');
%             fprintf(fid,libera_ip.value{1});
%             fclose(fid);
%             command='./Read_MC_lock_anneau.sh liste-IP-libera-test.txt';
%             [status,result]=unix(command,'-echo');
%             lmtd_index=regexp(result,'lmtd');
%             if isempty(lmtd_index)
%                 ligne=[Dev_List(i,:),' ',libera_ip.value{1},'  no locked message\n'];
%                 val_list(i,:)=[Dev_List(i,5:8),Dev_List(i,12:16),' not locked'];
%             else
%             return_index_array=regexp(result,'\n');
%             return_index=find(return_index_array>lmtd_index,1)-1;
%             start_line_index=return_index_array(return_index)+1;
%             stop_line_index=return_index_array(return_index+1);
%             ligne=[Dev_List(i,:),' ',result(start_line_index:stop_line_index)];
%             if isempty(regexp(ligne,' locked'))
%             val_list(i,:)=[Dev_List(i,5:8),Dev_List(i,12:16),'   unlocked'];
%             else
%             val_list(i,:)=[Dev_List(i,5:8),Dev_List(i,12:16),'     locked'];   
%             end
%             end
%             fprintf(MCstatus_file,ligne);
%             if(i==size(Dev_List,1))
%             fclose(MCstatus_file);
%             %   edit('MC_Locked_satus.txt');
%             end
%            
%         otherwise
 
            
%             res=tango_read_attribute2(Dev_List(i,:),attribute);
%             val_list(i)=res.value(1); 
    
%   waitbar(i/size(Dev_List,1)); 
end

set(handles.Attribute_current_value_list,'value',1)
set(handles.Attribute_current_value_list,'string',val_list);
%close(h);
end
% --- Executes on button press in Write_attribute.
function Write_attribute_Callback(hObject, eventdata, handles)
% hObject    handle to Write_attribute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Val=get(handles.attribute_list,'value');
String=get(handles.attribute_list,'string');
attribute=String{Val};
switch attribute
    case {'DDBufferSize','ADCBufferSize','RMSSamples','TimePhase','OffsetTune','MAFDelay','MAFLength','SwitchingDelay','SAStatNumSamples','DDTriggerOffset','PMOffset'}
        disp('toto')
        New_value=int32(str2num(get(handles.Attribute_next_value,'string')));
    case {'DDEnabled', 'SAEnabled','ADCEnabled','AGCEnabled','CompensateTune','ExternalSwitching','HasMAFSupport','UseLiberaSAData'}
        New_value=uint8(str2num(get(handles.Attribute_next_value,'string')));
    case {'Switches','DSCMode'}
        New_value=int16(str2num(get(handles.Attribute_next_value,'string')));
    case 'DDDecimationFactor'
        New_value=uint16(str2num(get(handles.Attribute_next_value,'string')));
    case 'Gain'
         New_value=(str2num(get(handles.Attribute_next_value,'string')));
    case {'MachineTime','SystemTime','MaxIncoherence','MaxIncoherenceDrift'}
         New_value=double(str2num(get(handles.Attribute_next_value,'string')));
    otherwise
end

list=get(handles.Devices_list,'string');
index=get(handles.Devices_list,'value');
Dev_List=list(index,:);

groupe=create_bpm_group(Dev_List);
tango_group_write_attribute(groupe,attribute,1,New_value)
% 
% for i=1:1:size(Dev_List,1)
%     tango_write_attribute2(Dev_List(i,:),attribute,New_value);  
% end

% Val=get(handles.attribute_list,'value');
% String=get(handles.attribute_list,'string');
% attribute=String{Val};
%groupe=create_bpm_group(Dev_List);
pause(1.3);
result=tango_group_read_attribute(groupe,attribute,1)
tango_group_kill(groupe);
if result.has_failed==0
    for i=1:1:size(Dev_List,1)
%     res=tango_read_attribute2(Dev_List(i,:),attribute);
%     val_list(i)=res.value(1); 
    val_list(i)=result.replies(i).value(1);   
    end
set(handles.Attribute_current_value_list,'string',val_list);
else
    errordlg('read faild on at least one BPM');
end;

function Attribute_next_value_Callback(hObject, eventdata, handles)
% hObject    handle to Attribute_next_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Attribute_next_value as text
%        str2double(get(hObject,'String')) returns contents of Attribute_next_value as a double


% --- Executes during object creation, after setting all properties.
function Attribute_next_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Attribute_next_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Attribute_current_value_list.
function Attribute_current_value_list_Callback(hObject, eventdata, handles)
% hObject    handle to Attribute_current_value_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Attribute_current_value_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Attribute_current_value_list

% list=get(handles.Devices_list,'string');
% index=get(handles.Devices_list,'value');
% Dev_List=list(index,:);
% 
% index_attributs=get(handles.Attribute_current_value_list,'value')
% corresponding_device=Dev_List(index_attributs,:)
% index(1)-1+index_attributs
% set(handles.Devices_list,'value',index-1+index_attributs)

% --- Executes during object creation, after setting all properties.
function Attribute_current_value_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Attribute_current_value_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Commands_list.
function Commands_list_Callback(hObject, eventdata, handles)
% hObject    handle to Commands_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Commands_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Commands_list


% --- Executes during object creation, after setting all properties.
function Commands_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Commands_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Apply_command.
function Apply_command_Callback(hObject, eventdata, handles)
% hObject    handle to Apply_command (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Val=get(handles.Commands_list,'value');
String=get(handles.Commands_list,'string');
commande=String{Val};

list=get(handles.Devices_list,'string');
index=get(handles.Devices_list,'value');
Dev_List=list(index,:);

switch commande
    case {'Detune','Retune','Design'}
         h = waitbar(0,'Please wait...');
       for i=1:1:size(Dev_List,1)          
            waitbar(i/size(Dev_List,1));
            libera_ip=tango_get_property2(Dev_List(i,:),'LiberaIpAddr')
            fid=fopen('liste-IP-libera-test.txt','wt');
            fprintf(fid,libera_ip.value{1});
            fclose(fid);
            if commande=='Detune'
                command='./Detune_liste.sh liste-IP-libera-test.txt';
                [status,result]=unix(command,'-echo');
                detune_index=regexp(result,' -o ');
                if isempty(detune_index)
                    val_list(i,:)=[Dev_List(i,5:8),Dev_List(i,12:16),' no detuning'];
                else
                    ligne=[result(detune_index+1:detune_index+5),'      '];
                    val_list(i,:)=[Dev_List(i,5:8),Dev_List(i,12:16),' ',ligne]; 
                end
            end
            if commande=='Retune'
                command='./Retune_liste.sh liste-IP-libera-test.txt';          
                [status,result]=unix(command,'-echo');
                detune_index=regexp(result,' -o ');
                if isempty(detune_index)
                    val_list(i,:)=[Dev_List(i,5:8),Dev_List(i,12:16),' no detuning'];
                else
                    ligne=[result(detune_index+1:detune_index+5),'      '];
                    val_list(i,:)=[Dev_List(i,5:8),Dev_List(i,12:16),' ',ligne]; 
                end
            end
             if commande=='Design'
                command='./get_FPGA_design.sh liste-IP-libera-test.txt';      
                [status,result]=unix(command,'-echo');
                index=regexp(result,'->');
                if isempty(index)
                    val_list(i,:)=[Dev_List(i,5:8),Dev_List(i,12:16),' error'];
                else
                    ligne=[result(index+15:index+27)];
                    val_list(i,:)=[Dev_List(i,12:16),' ',ligne]; 
                end
              end    
         end

       set(handles.Attribute_current_value_list,'string',val_list);
       close(h)
    otherwise

        groupe=create_bpm_group(Dev_List);
        tango_group_command_inout2(groupe,commande,0,1)
        tango_group_kill(groupe);
end
% for i=1:1:size(Dev_List,1)
%     switch commande
%     case 'Set_Time(synchro sur MC)'
%         libera_ip='0';
%         Correspondance=tango_get_db_property('BPM','DeviceParameters');
%         for j=1:1:size(Correspondance,2)
%                 ligne=regexpi(Correspondance{j},Dev_List(i,:));
%                 if isempty(ligne)==0
%                    if size(Correspondance{j},2)==36
%                         libera_ip=[Correspondance{j}(34),Correspondance{j}(35),Correspondance{j}(36)];
%                    elseif size(Correspondance{j},2)==35
%                          libera_ip=[Correspondance{j}(34),Correspondance{j}(35)]  ;
%                    elseif size(Correspondance{j},2)==34
%                          libera_ip=Correspondance{j}(34) ;
%                    end
%                 end
%         end
%         set_time_command=['./net-libera -x 0: 172.17.15.',libera_ip]
%         
%         unix(set_time_command)
%         
%         case 'Detune'
%             libera_ip=tango_get_property2(Dev_List(i,:),'LiberaIpAddr')
%             fid=fopen('liste-IP-libera-test.txt','wt');
%             fprintf(fid,libera_ip.value{1});
%             fclose(fid);
%             command='./Detune_liste.sh liste-IP-libera-test.txt';
%             [status,result]=unix(command,'-echo');
%             detune_index=regexp(result,' -f ');
%             if isempty(detune_index)
%                 val_list(i,:)=[Dev_List(i,5:8),Dev_List(i,12:16),' no detuning'];
%             else
%                 ligne=[result(detune_index+1:detune_index+5),'      '];
%                 val_list(i,:)=[Dev_List(i,5:8),Dev_List(i,12:16),' ',ligne]; 
%             end
%    
%         case 'Retune'
%             libera_ip=tango_get_property2(Dev_List(i,:),'LiberaIpAddr')
%             fid=fopen('liste-IP-libera-test.txt','wt');
%             fprintf(fid,libera_ip.value{1});
%             fclose(fid);
%             command='./Retune_liste.sh liste-IP-libera-test.txt';
%             [status,result]=unix(command,'-echo');
%             detune_index=regexp(result,' -f ');
%             if isempty(detune_index)
%                 val_list(i,:)=[Dev_List(i,5:8),Dev_List(i,12:16),' no detuning'];
%             else
%                 ligne=[result(detune_index+1:detune_index+5),'      '];
%                 val_list(i,:)=[Dev_List(i,5:8),Dev_List(i,12:16),' ',ligne];
%             end
%         otherwise
        
%     tango_command_inout2(Dev_List(i,:),commande);  
%     end
%     waitbar(i/size(Dev_List,1));
% end
% switch commande
%     case {'Detune','Retune'}
%     set(handles.Attribute_current_value_list,'string',val_list);
%     otherwise
% end
% close(h)

% --- Executes on selection change in property_list.
function property_list_Callback(hObject, eventdata, handles)
% hObject    handle to property_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns property_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from property_list


% --- Executes during object creation, after setting all properties.
function property_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to property_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in property_current_value_list.
function property_current_value_list_Callback(hObject, eventdata, handles)
% hObject    handle to property_current_value_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns property_current_value_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from property_current_value_list


% --- Executes during object creation, after setting all properties.
function property_current_value_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to property_current_value_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Read_property.
function Read_property_Callback(hObject, eventdata, handles)
% hObject    handle to Read_property (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Val=get(handles.property_list,'value');
propertylist=get(handles.property_list,'string');
list=get(handles.Devices_list,'string');
index=get(handles.Devices_list,'value');
Dev_List=list(index,:);
switch Val
    case {1, 2, 3, 4, 5, 6, 7, 8}
        Val
        for i=1:1:size(Dev_List,1)
            res=tango_get_property2(Dev_List(i,:),'InterlockConfiguration');
            val_list(i)=res.value(Val) ; 
        end

    otherwise
         for i=1:1:size(Dev_List,1)
            propertyname=propertylist{Val};
            res=tango_get_property2(Dev_List(i,:),propertyname);
            val_list(i)=res.value;
         end
end
set(handles.property_current_value_list,'string',val_list);


% --- Executes on button press in Write_property.
function Write_property_Callback(hObject, eventdata, handles)
% hObject    handle to Write_property (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
confirmation=questdlg('Modifier certaines properties peut déclencher l interlock. Voulez-vous continuer?','Avertissement','Oui','Non','Oui');
switch confirmation
    case 'Oui'
      
    Val=get(handles.property_list,'value');
    String=get(handles.property_list,'string');
    property_name=String{Val};    
    list=get(handles.Devices_list,'string');
    index=get(handles.Devices_list,'value');
    Dev_List=list(index,:);
    % String=get(handles.property_list,'string');
    % property=String{Val};
    New_Value=(get(handles.property_next_value,'string'));
    h = waitbar(0,'Please wait...');
    for i=1:1:size(Dev_List,1)
        if Val<9 
            res=tango_get_property2(Dev_List(i,:),'UserDefinedStartupEnvParameters');
            res.value{Val+10}=New_Value;
            tango_put_property2(Dev_List(i,:),res.name,res.value);
            verif=tango_get_property2(Dev_List(i,:),'UserDefinedStartupEnvParameters');

         val_list(i)=verif.value(Val+10) ;
         
        else
            res=tango_get_property2(Dev_List(i,:),property_name);
            res.value={New_Value};
           tango_put_property2(Dev_List(i,:),res.name,res.value);
            verif=tango_get_property2(Dev_List(i,:),property_name);
            val_list(i,:)=verif.value;
        end
        waitbar(i/size(Dev_List,1));
    end
    set(handles.property_current_value_list,'string',val_list);
    otherwise
end
close(h);

function property_next_value_Callback(hObject, eventdata, handles)
% hObject    handle to property_next_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of property_next_value as text
%        str2double(get(hObject,'String')) returns contents of property_next_value as a double


% --- Executes during object creation, after setting all properties.
function property_next_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to property_next_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ssh.
function ssh_Callback(hObject, eventdata, handles)
% hObject    handle to ssh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
list=get(handles.Devices_list,'string');
index=get(handles.Devices_list,'value');
Dev_List=list(index,:);
if(size(Dev_List,1)~=1)
warndlg('You can not select more than 1 Dserver to connect to a libera') 
else
    commandwindow
    IP_address=tango_get_property2(Dev_List(1,:),'LiberaIPAddr');
    command=['ssh root@',IP_address.value{1}]
    unix(command,'-echo')
end

