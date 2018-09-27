function varargout = Config_FOFB(varargin)
% CONFIG_FOFB M-file for Config_FOFB.fig
%      CONFIG_FOFB, by itself, creates a new CONFIG_FOFB or raises the existing
%      singleton*.
%
%      H = CONFIG_FOFB returns the handle to a new CONFIG_FOFB or the handle to
%      the existing singleton*.
%
%      CONFIG_FOFB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIG_FOFB.M with the given input arguments.
%
%      CONFIG_FOFB('Property','Value',...) creates a new CONFIG_FOFB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Config_FOFB_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Config_FOFB_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Config_FOFB

% Last Modified by GUIDE v2.5 15-Jul-2011 10:42:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Config_FOFB_OpeningFcn, ...
                   'gui_OutputFcn',  @Config_FOFB_OutputFcn, ...
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


% --- Executes just before Config_FOFB is made visible.
function Config_FOFB_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Config_FOFB (see VARARGIN)

% Choose default command line output for Config_FOFB
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Config_FOFB wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Config_FOFB_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes during object creation, after setting all properties.
function Device_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Device_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Read_fofb_status.
function Read_fofb_status_Callback(hObject, eventdata, handles)
% hObject    handle to Read_fofb_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dev=get(handles.Device_name,'String');
val_dev=get(handles.Device_name,'value');
device_name=dev{val_dev}
[CC_conf_reg,CC_Status_reg,RAM_X,RAM_Z]=fofb_read_cfg_memory(device_name)
set(handles.CC_version,'string',CC_Status_reg.CC_version)
set(handles.CC_status,'string',CC_Status_reg.CC_status)
set(handles.Partner_1,'string',CC_Status_reg.lp1)
set(handles.Partner_2,'string',CC_Status_reg.lp2)
set(handles.Partner_3,'string',CC_Status_reg.lp3)
set(handles.Partner_4,'string',CC_Status_reg.lp4)
set(handles.Link_RX_1,'value',str2num(CC_Status_reg.status_RX1))
set(handles.Link_RX_2,'value',str2num(CC_Status_reg.status_RX2))
set(handles.Link_RX_3,'value',str2num(CC_Status_reg.status_RX3))
set(handles.Link_RX_4,'value',str2num(CC_Status_reg.status_RX4))
set(handles.Link_TX_1,'value',str2num(CC_Status_reg.status_TX1))
set(handles.Link_TX_2,'value',str2num(CC_Status_reg.status_TX2))
set(handles.Link_TX_3,'value',str2num(CC_Status_reg.status_TX3))
set(handles.Link_TX_4,'value',str2num(CC_Status_reg.status_TX4))
set(handles.Time_frame_cnt,'string',CC_Status_reg.time_frame_count)
set(handles.H_error_1,'string',CC_Status_reg.hard_error_cnt_1)
set(handles.H_error_2,'string',CC_Status_reg.hard_error_cnt_2)
set(handles.H_error_3,'string',CC_Status_reg.hard_error_cnt_3)
set(handles.H_error_4,'string',CC_Status_reg.hard_error_cnt_4)
set(handles.S_error_1,'string',CC_Status_reg.soft_error_cnt_1)
set(handles.S_error_2,'string',CC_Status_reg.soft_error_cnt_2)
set(handles.S_error_3,'string',CC_Status_reg.soft_error_cnt_3)
set(handles.S_error_4,'string',CC_Status_reg.soft_error_cnt_4)
set(handles.F_error_1,'string',CC_Status_reg.frame_error_cnt_1)
set(handles.F_error_2,'string',CC_Status_reg.frame_error_cnt_2)
set(handles.F_error_3,'string',CC_Status_reg.frame_error_cnt_3)
set(handles.F_error_4,'string',CC_Status_reg.frame_error_cnt_4)
set(handles.RX_cnt_1,'string',CC_Status_reg.rx_pck_cnt_1)
set(handles.RX_cnt_2,'string',CC_Status_reg.rx_pck_cnt_2)
set(handles.RX_cnt_3,'string',CC_Status_reg.rx_pck_cnt_3)
set(handles.RX_cnt_4,'string',CC_Status_reg.rx_pck_cnt_4)
set(handles.TX_cnt_1,'string',CC_Status_reg.tx_pck_cnt_1)
set(handles.TX_cnt_2,'string',CC_Status_reg.tx_pck_cnt_2)
set(handles.TX_cnt_3,'string',CC_Status_reg.tx_pck_cnt_3)
set(handles.TX_cnt_4,'string',CC_Status_reg.tx_pck_cnt_4)
set(handles.process_time,'string',CC_Status_reg.process_time)
set(handles.bpm_involved,'string',CC_Status_reg.bpm_involved)

CC_conf_reg
set(handles.BPM_id,'String',num2str(CC_conf_reg.bpm_id))
set(handles.time_frame_length,'String',num2str(CC_conf_reg.time_frame_length))
set(handles.MGT_powerdown,'String',num2str(CC_conf_reg.MGT_powerdown))
set(handles.MGT_loopback,'String',num2str(CC_conf_reg.MGT_loopback))
set(handles.Buf_clr_dly,'String',num2str(CC_conf_reg.buf_clr_dly))
set(handles.Golden_X,'String',num2str(CC_conf_reg.Golden_X))
set(handles.Golden_Z,'String',num2str(CC_conf_reg.Golden_Z))


for j=1:1:256
    size_addr=size(num2str(j-1),2);
    size_X=size(num2str(RAM_X(j)),2);
    size_Z=size(num2str(RAM_Z(j)),2);
    switch size_addr
        case 1
            addr(j,:)=['00',num2str(j-1)];
        case 2
            addr(j,:)=['0',num2str(j-1)];
        case 3
            addr(j,:)=num2str(j-1);
    end
    switch size_X
        case 1
            X(j,:)=['         ',num2str(RAM_X(j))];
        case 2
             X(j,:)=['        ',num2str(RAM_X(j))];
        case 3
             X(j,:)=['       ',num2str(RAM_X(j))];
         case 4
             X(j,:)=['      ',num2str(RAM_X(j))];
         case 5
             X(j,:)=['     ',num2str(RAM_X(j))];
         case 6
             X(j,:)=['    ',num2str(RAM_X(j))];
         case 7
             X(j,:)=['   ',num2str(RAM_X(j))];
          case 8
             X(j,:)=['  ',num2str(RAM_X(j))];
           case 9
             X(j,:)=[' ',num2str(RAM_X(j))];
          case 10
             X(j,:)=['',num2str(RAM_X(j))];
    end

    switch size_Z
        case 1
            Z(j,:)=['         ',num2str(RAM_Z(j))];
        case 2
             Z(j,:)=['        ',num2str(RAM_Z(j))];
        case 3
             Z(j,:)=['       ',num2str(RAM_Z(j))];
         case 4
             Z(j,:)=['      ',num2str(RAM_Z(j))];
         case 5
             Z(j,:)=['     ',num2str(RAM_Z(j))];
         case 6
             Z(j,:)=['    ',num2str(RAM_Z(j))];
         case 7
             Z(j,:)=['   ',num2str(RAM_Z(j))];
         case 8
             Z(j,:)=['  ',num2str(RAM_Z(j))];
          case 9
             Z(j,:)=[' ',num2str(RAM_Z(j))];
         case 10
             Z(j,:)=['',num2str(RAM_Z(j))];
    end
 
    aff_RAM_X(j,:)=[addr(j,:),'     ',X(j,:)];
    aff_RAM_Z(j,:)=[addr(j,:),'     ',Z(j,:)];
    
end
set(handles.RAM_X,'string',aff_RAM_X); 
set(handles.RAM_Z,'string',aff_RAM_Z); 


% --- Executes on button press in Init_CC.
function Init_CC_Callback(hObject, eventdata, handles)
% hObject    handle to Init_CC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles    structure with handles and user data (see GUIDATA)
dev=get(handles.Device_name,'String');
val_dev=get(handles.Device_name,'value');
device_name=dev{val_dev}
answer=(inputdlg('choose BPM id'))
id=str2num(answer{1})
set(handles.BPM_id,'String',answer)
time_frame_lenght=str2num(get(handles.time_frame_length,'String'))
MGT_powerdown=str2num(get(handles.MGT_powerdown,'String'))
MGT_loopback=str2num(get(handles.MGT_loopback,'String'))
buf_clr_dly=str2num(get(handles.Buf_clr_dly,'String'))
Golden_X=str2num(get(handles.Golden_X,'String'))
Golden_Z=str2num(get(handles.Golden_Z,'String'))

fofb_init_CC(device_name,id,time_frame_lenght,MGT_powerdown,MGT_loopback,buf_clr_dly,Golden_X,Golden_Z)

%configure_fofb('write',device_name,'init_CC',id,time_frame_lenght,MGT_powerdown,MGT_loopback,buf_clr_dly,Golden_X,Golden_Z)

% --- Executes on button press in Stop_CC.
function Stop_CC_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_CC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dev=get(handles.Device_name,'String');
val_dev=get(handles.Device_name,'value');
device_alim_list=dev(val_dev,:)
groupe=create_group_from_list(device_alim_list);
fofb_stop_CC(groupe)
tango_group_kill(groupe)

% --- Executes on button press in Arm_CC.
function Arm_CC_Callback(hObject, eventdata, handles)
% hObject    handle to Arm_CC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dev=get(handles.Device_name,'String');
val_dev=get(handles.Device_name,'value');
device_alim_list=dev(val_dev,:)
groupe=create_group_from_list(device_alim_list);
data_selection=get(handles.radiobutton2,'value');
time_frame_cnt_limit_value=str2num(get(handles.time_frame_count_limit_value,'String'))
fofb_arm_CC(groupe,time_frame_cnt_limit_value,data_selection)
tango_group_kill(groupe)



function CC_version_Callback(hObject, eventdata, handles)
% hObject    handle to CC_version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CC_version as text
%        str2double(get(hObject,'String')) returns contents of CC_version as a double


% --- Executes during object creation, after setting all properties.
function CC_version_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CC_version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function CC_status_Callback(hObject, eventdata, handles)
% hObject    handle to CC_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CC_status as text
%        str2double(get(hObject,'String')) returns contents of CC_status as a double


% --- Executes during object creation, after setting all properties.
function CC_status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CC_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Partner_1_Callback(hObject, eventdata, handles)
% hObject    handle to Partner_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Partner_1 as text
%        str2double(get(hObject,'String')) returns contents of Partner_1 as a double


% --- Executes during object creation, after setting all properties.
function Partner_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Partner_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Partner_2_Callback(hObject, eventdata, handles)
% hObject    handle to Partner_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Partner_2 as text
%        str2double(get(hObject,'String')) returns contents of Partner_2 as a double


% --- Executes during object creation, after setting all properties.
function Partner_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Partner_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Partner_3_Callback(hObject, eventdata, handles)
% hObject    handle to Partner_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Partner_3 as text
%        str2double(get(hObject,'String')) returns contents of Partner_3 as a double


% --- Executes during object creation, after setting all properties.
function Partner_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Partner_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Partner_4_Callback(hObject, eventdata, handles)
% hObject    handle to Partner_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Partner_4 as text
%        str2double(get(hObject,'String')) returns contents of Partner_4 as a double


% --- Executes during object creation, after setting all properties.
function Partner_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Partner_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function H_error_1_Callback(hObject, eventdata, handles)
% hObject    handle to H_error_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of H_error_1 as text
%        str2double(get(hObject,'String')) returns contents of H_error_1 as a double


% --- Executes during object creation, after setting all properties.
function H_error_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to H_error_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function H_error_2_Callback(hObject, eventdata, handles)
% hObject    handle to H_error_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of H_error_2 as text
%        str2double(get(hObject,'String')) returns contents of H_error_2 as a double


% --- Executes during object creation, after setting all properties.
function H_error_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to H_error_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function H_error_3_Callback(hObject, eventdata, handles)
% hObject    handle to H_error_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of H_error_3 as text
%        str2double(get(hObject,'String')) returns contents of H_error_3 as a double


% --- Executes during object creation, after setting all properties.
function H_error_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to H_error_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function H_error_4_Callback(hObject, eventdata, handles)
% hObject    handle to H_error_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of H_error_4 as text
%        str2double(get(hObject,'String')) returns contents of H_error_4 as a double


% --- Executes during object creation, after setting all properties.
function H_error_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to H_error_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S_error_1_Callback(hObject, eventdata, handles)
% hObject    handle to S_error_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S_error_1 as text
%        str2double(get(hObject,'String')) returns contents of S_error_1 as a double


% --- Executes during object creation, after setting all properties.
function S_error_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_error_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S_error_2_Callback(hObject, eventdata, handles)
% hObject    handle to S_error_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S_error_2 as text
%        str2double(get(hObject,'String')) returns contents of S_error_2 as a double


% --- Executes during object creation, after setting all properties.
function S_error_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_error_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S_error_3_Callback(hObject, eventdata, handles)
% hObject    handle to S_error_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S_error_3 as text
%        str2double(get(hObject,'String')) returns contents of S_error_3 as a double


% --- Executes during object creation, after setting all properties.
function S_error_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_error_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S_error_4_Callback(hObject, eventdata, handles)
% hObject    handle to S_error_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S_error_4 as text
%        str2double(get(hObject,'String')) returns contents of S_error_4 as a double


% --- Executes during object creation, after setting all properties.
function S_error_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S_error_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F_error_1_Callback(hObject, eventdata, handles)
% hObject    handle to F_error_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F_error_1 as text
%        str2double(get(hObject,'String')) returns contents of F_error_1 as a double


% --- Executes during object creation, after setting all properties.
function F_error_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F_error_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F_error_2_Callback(hObject, eventdata, handles)
% hObject    handle to F_error_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F_error_2 as text
%        str2double(get(hObject,'String')) returns contents of F_error_2 as a double


% --- Executes during object creation, after setting all properties.
function F_error_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F_error_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F_error_3_Callback(hObject, eventdata, handles)
% hObject    handle to F_error_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F_error_3 as text
%        str2double(get(hObject,'String')) returns contents of F_error_3 as a double


% --- Executes during object creation, after setting all properties.
function F_error_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F_error_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F_error_4_Callback(hObject, eventdata, handles)
% hObject    handle to F_error_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F_error_4 as text
%        str2double(get(hObject,'String')) returns contents of F_error_4 as a double


% --- Executes during object creation, after setting all properties.
function F_error_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F_error_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RX_cnt_1_Callback(hObject, eventdata, handles)
% hObject    handle to RX_cnt_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RX_cnt_1 as text
%        str2double(get(hObject,'String')) returns contents of RX_cnt_1 as a double


% --- Executes during object creation, after setting all properties.
function RX_cnt_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RX_cnt_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RX_cnt_2_Callback(hObject, eventdata, handles)
% hObject    handle to RX_cnt_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RX_cnt_2 as text
%        str2double(get(hObject,'String')) returns contents of RX_cnt_2 as a double


% --- Executes during object creation, after setting all properties.
function RX_cnt_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RX_cnt_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RX_cnt_3_Callback(hObject, eventdata, handles)
% hObject    handle to RX_cnt_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RX_cnt_3 as text
%        str2double(get(hObject,'String')) returns contents of RX_cnt_3 as a double


% --- Executes during object creation, after setting all properties.
function RX_cnt_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RX_cnt_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RX_cnt_4_Callback(hObject, eventdata, handles)
% hObject    handle to RX_cnt_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RX_cnt_4 as text
%        str2double(get(hObject,'String')) returns contents of RX_cnt_4 as a double


% --- Executes during object creation, after setting all properties.
function RX_cnt_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RX_cnt_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TX_cnt_1_Callback(hObject, eventdata, handles)
% hObject    handle to TX_cnt_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX_cnt_1 as text
%        str2double(get(hObject,'String')) returns contents of TX_cnt_1 as a double


% --- Executes during object creation, after setting all properties.
function TX_cnt_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX_cnt_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TX_cnt_2_Callback(hObject, eventdata, handles)
% hObject    handle to TX_cnt_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX_cnt_2 as text
%        str2double(get(hObject,'String')) returns contents of TX_cnt_2 as a double


% --- Executes during object creation, after setting all properties.
function TX_cnt_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX_cnt_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TX_cnt_3_Callback(hObject, eventdata, handles)
% hObject    handle to TX_cnt_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX_cnt_3 as text
%        str2double(get(hObject,'String')) returns contents of TX_cnt_3 as a double


% --- Executes during object creation, after setting all properties.
function TX_cnt_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX_cnt_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TX_cnt_4_Callback(hObject, eventdata, handles)
% hObject    handle to TX_cnt_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX_cnt_4 as text
%        str2double(get(hObject,'String')) returns contents of TX_cnt_4 as a double


% --- Executes during object creation, after setting all properties.
function TX_cnt_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX_cnt_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Link_RX_1.
function Link_RX_1_Callback(hObject, eventdata, handles)
% hObject    handle to Link_RX_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Link_RX_1


% --- Executes on button press in Link_RX_2.
function Link_RX_2_Callback(hObject, eventdata, handles)
% hObject    handle to Link_RX_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Link_RX_2


% --- Executes on button press in Link_RX_3.
function Link_RX_3_Callback(hObject, eventdata, handles)
% hObject    handle to Link_RX_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Link_RX_3


% --- Executes on button press in Link_RX_4.
function Link_RX_4_Callback(hObject, eventdata, handles)
% hObject    handle to Link_RX_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Link_RX_4


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8



function Time_frame_cnt_Callback(hObject, eventdata, handles)
% hObject    handle to Time_frame_cnt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time_frame_cnt as text
%        str2double(get(hObject,'String')) returns contents of Time_frame_cnt as a double


% --- Executes during object creation, after setting all properties.
function Time_frame_cnt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time_frame_cnt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Link_TX_1.
function Link_TX_1_Callback(hObject, eventdata, handles)
% hObject    handle to Link_TX_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Link_TX_1


% --- Executes on button press in Link_TX_2.
function Link_TX_2_Callback(hObject, eventdata, handles)
% hObject    handle to Link_TX_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Link_TX_2


% --- Executes on button press in Link_TX_3.
function Link_TX_3_Callback(hObject, eventdata, handles)
% hObject    handle to Link_TX_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Link_TX_3


% --- Executes on button press in Link_TX_4.
function Link_TX_4_Callback(hObject, eventdata, handles)
% hObject    handle to Link_TX_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Link_TX_4


% --- Executes on button press in init_CC_all.
function init_CC_all_Callback(hObject, eventdata, handles)
% hObject    handle to init_CC_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

time_frame_lenght=str2num(get(handles.time_frame_length,'String'))
MGT_powerdown=str2num(get(handles.MGT_powerdown,'String'))
MGT_loopback=str2num(get(handles.MGT_loopback,'String'))
buf_clr_dly=str2num(get(handles.Buf_clr_dly,'String'))

dev=get(handles.Device_name,'String');
%clear new_goldenX
%clear new_goldenZ
clear last_goldenX
clear last_goldenZ
uiopen('load')
h = waitbar(0,'Please wait...');
for (i=1:1:120)
device_name=dev{i}
id=Get_index(device_name)
fofb_init_CC(device_name,id,time_frame_lenght,MGT_powerdown,MGT_loopback,buf_clr_dly,new_goldenX(id),new_goldenZ(id));
waitbar(i/120,h); 
end
last_goldenX=new_goldenX;
last_goldenZ=new_goldenZ;

variables(1)={'last_goldenX'}
variables(2)={'last_goldenZ'}

save('golden/last_golden','last_goldenX','last_goldenZ')

close(h);

% --- Executes on button press in Stop_CC_all.
function Stop_CC_all_Callback(hObject, eventdata, handles)
% hObject    handle to Stop_CC_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=waitbar(0,'please wait.....');
dev=get(handles.Device_name,'String');
device_alim_list=dev(1:120,:);
groupe=create_group_from_list(device_alim_list);
waitbar(1/2,h);
fofb_stop_CC(groupe);
tango_group_kill(groupe);
waitbar(1,h);
close(h)

% --- Executes on button press in Arm_CC_all.
function Arm_CC_all_Callback(hObject, eventdata, handles)
% hObject    handle to Arm_CC_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=waitbar(0,'please wait.....');
dev=get(handles.Device_name,'String');
device_alim_list=dev(1:120,:)
groupe=create_group_from_list(device_alim_list);
waitbar(1/2,h);
data_selection=get(handles.radiobutton2,'value')
time_frame_cnt_limit_value=str2num(get(handles.time_frame_count_limit_value,'String'));
fofb_arm_CC(groupe,time_frame_cnt_limit_value,data_selection);
tango_group_kill(groupe);
waitbar(1,h);
close(h)

function BPM_id_Callback(hObject, eventdata, handles)
% hObject    handle to BPM_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BPM_id as text
%        str2double(get(hObject,'String')) returns contents of BPM_id as a double


% --- Executes during object creation, after setting all properties.
function BPM_id_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BPM_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RAM_X.
function RAM_X_Callback(hObject, eventdata, handles)
% hObject    handle to RAM_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RAM_X contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RAM_X


% --- Executes during object creation, after setting all properties.
function RAM_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RAM_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RAM_Z.
function RAM_Z_Callback(hObject, eventdata, handles)
% hObject    handle to RAM_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RAM_Z contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RAM_Z


% --- Executes during object creation, after setting all properties.
function RAM_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RAM_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_frame_length_Callback(hObject, eventdata, handles)
% hObject    handle to time_frame_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_frame_length as text
%        str2double(get(hObject,'String')) returns contents of time_frame_length as a double


% --- Executes during object creation, after setting all properties.
function time_frame_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_frame_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MGT_powerdown_Callback(hObject, eventdata, handles)
% hObject    handle to MGT_powerdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MGT_powerdown as text
%        str2double(get(hObject,'String')) returns contents of MGT_powerdown as a double


% --- Executes during object creation, after setting all properties.
function MGT_powerdown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MGT_powerdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MGT_loopback_Callback(hObject, eventdata, handles)
% hObject    handle to MGT_loopback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MGT_loopback as text
%        str2double(get(hObject,'String')) returns contents of MGT_loopback as a double


% --- Executes during object creation, after setting all properties.
function MGT_loopback_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MGT_loopback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Buf_clr_dly_Callback(hObject, eventdata, handles)
% hObject    handle to Buf_clr_dly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Buf_clr_dly as text
%        str2double(get(hObject,'String')) returns contents of Buf_clr_dly as a double


% --- Executes during object creation, after setting all properties.
function Buf_clr_dly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Buf_clr_dly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Golden_X_Callback(hObject, eventdata, handles)
% hObject    handle to Golden_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Golden_X as text
%        str2double(get(hObject,'String')) returns contents of Golden_X as a double


% --- Executes during object creation, after setting all properties.
function Golden_X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Golden_X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Golden_Z_Callback(hObject, eventdata, handles)
% hObject    handle to Golden_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Golden_Z as text
%        str2double(get(hObject,'String')) returns contents of Golden_Z as a double


% --- Executes during object creation, after setting all properties.
function Golden_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Golden_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_frame_count_limit_value_Callback(hObject, eventdata, handles)
% hObject    handle to time_frame_count_limit_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_frame_count_limit_value as text
%        str2double(get(hObject,'String')) returns contents of time_frame_count_limit_value as a double


% --- Executes during object creation, after setting all properties.
function time_frame_count_limit_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_frame_count_limit_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Synchronize_all.
function Synchronize_all_Callback(hObject, eventdata, handles)
% hObject    handle to Synchronize_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=waitbar(0,'please wait.....');
dev=get(handles.Device_name,'String');
device_alim_list=dev(1:120,:)
groupe=create_group_from_list(device_alim_list);
waitbar(1/2,h);
tango_group_command_inout2(groupe,'SetTimeOnNextTrigger',1,1)
tango_group_kill(groupe);
waitbar(1,h);
close(h)


% --- Executes on button press in Trig_all.
function Trig_all_Callback(hObject, eventdata, handles)
% hObject    handle to Trig_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=waitbar(0,'please wait.....');
dev=get(handles.Device_name,'String');
device_alim_list=dev(1:120,:)
groupe=create_group_from_list(device_alim_list);
waitbar(1/2,h);
soft_trig_bpm;
tango_group_kill(groupe);
waitbar(1,h);
close(h)


% --- Executes on button press in RX_all.
function RX_all_Callback(hObject, eventdata, handles)
% hObject    handle to RX_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dev=get(handles.Device_name,'String');
val_dev=get(handles.Device_name,'value');
h=waitbar(0,'please wait.....')
for i=1:1:120
    waitbar(i/120,h);
    device_name=dev{i};
    [CC_conf_reg,CC_Status_reg,RAM_X,RAM_Z]=fofb_read_cfg_memory(device_name);
    RX_array(i,1)=CC_conf_reg.bpm_id;
    RX_array(i,2)=CC_Status_reg.rx_pck_cnt_1;
    RX_array(i,3)=CC_Status_reg.rx_pck_cnt_2;
    RX_array(i,4)=CC_Status_reg.tx_pck_cnt_1;
    RX_array(i,5)=CC_Status_reg.tx_pck_cnt_2;
    RX_array(i,6)=CC_Status_reg.process_time;
    RX_array(i,7)=CC_Status_reg.frame_error_cnt_1;
    RX_array(i,8)=CC_Status_reg.frame_error_cnt_2;
    RX_array(i,9)=CC_Status_reg.soft_error_cnt_1;
    RX_array(i,10)=CC_Status_reg.soft_error_cnt_2;
    
end
%msgbox(num2str(RX_array),'toto')
RX_array
max(RX_array(:,6))
close(h)



function X_value_Callback(hObject, eventdata, handles)
% hObject    handle to X_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_value as text
%        str2double(get(hObject,'String')) returns contents of X_value as a double


% --- Executes during object creation, after setting all properties.
function X_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z_value_Callback(hObject, eventdata, handles)
% hObject    handle to Z_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z_value as text
%        str2double(get(hObject,'String')) returns contents of Z_value as a double


% --- Executes during object creation, after setting all properties.
function Z_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Xon.
function Xon_Callback(hObject, eventdata, handles)
% hObject    handle to Xon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Xon


% --- Executes on button press in Zon.
function Zon_Callback(hObject, eventdata, handles)
% hObject    handle to Zon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Zon


% --- Executes on button press in apply_ram.
function apply_ram_Callback(hObject, eventdata, handles)
% hObject    handle to apply_ram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

coeff_X=str2num(get(handles.X_value,'string'))
coeff_Z=str2num(get(handles.Z_value,'string'))
on_X=(get(handles.Xon,'value'))
on_Z=(get(handles.Zon,'value'))

dev=get(handles.Device_name,'String');
val_dev=get(handles.Device_name,'value');
device_name=dev{val_dev}
all_bpm=get(handles.all_bpm,'value');
if all_bpm==1
    device_alim_list=dev(1:120,:);
else
    device_alim_list=dev(val_dev,:);
end;
groupe=create_group_from_list(device_alim_list);
fofb_write_matrix(groupe,coeff_X,coeff_Z,on_X,on_Z);
% k=1
% for i=1:1:10000
%     fofb_write_matrix(groupe,1000,0,on_X,on_Z);
%     i
%     pause(k)
%     fofb_write_matrix(groupe,1000,10,on_X,on_Z);
%     pause(k)
% end
tango_group_kill(groupe);
% --- Executes on button press in all_bpm.
function all_bpm_Callback(hObject, eventdata, handles)
% hObject    handle to all_bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of all_bpm


% --- Executes on button press in load_matrix.
function load_matrix_Callback(hObject, eventdata, handles)
% hObject    handle to load_matrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dev=get(handles.dev_list_for_matrix,'String')
clear matrixX
clear matrixZ
uiopen('load')
h = waitbar(0,'Please wait...');

for (i=1:1:48)
device_name=dev{i};
fofb_load_matrix(device_name,matrixX(i,:),matrixZ(i,:));
waitbar(i/48,h); 
id=Get_index(device_name)
end
close(h);


% --- Executes on button press in fofb_config.
function fofb_config_Callback(hObject, eventdata, handles)
% hObject    handle to fofb_config (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

comm_X=(get(handles.comm_x,'value'))
comm_Z=(get(handles.comm_z,'value'))
bypass_fir_X=(get(handles.enable_fofb_x,'value'))
bypass_fir_Z=(get(handles.enable_fofb_z,'value'))
trig_enable_X=(get(handles.trig_enable_x,'value'))
trig_enable_Z=(get(handles.trig_enable_z,'value'))
mux_conf0_X=(get(handles.mux_conf0_x,'value'))
mux_conf0_Z=(get(handles.mux_conf0_z,'value'))
mux_conf1_X=(get(handles.mux_conf1_x,'value'))
mux_conf1_Z=(get(handles.mux_conf1_z,'value'))

coeff1_x=int32(str2num(get(handles.coeff1_x,'string'))*2^14)
coeff1_z=int32(str2num(get(handles.coeff1_z,'string'))*2^14)

coeff1_x*(2^16)
X_conf=comm_X+2*bypass_fir_X+4*trig_enable_X+8*mux_conf0_X+16*mux_conf1_X+2^16*coeff1_x
Z_conf=comm_Z+2*bypass_fir_Z+4*trig_enable_Z+8*mux_conf0_Z+16*mux_conf1_Z+2^16*coeff1_z


dev=get(handles.dev_list_for_matrix,'String');
val_dev=get(handles.dev_list_for_matrix,'value');
device_name=dev{val_dev};
all_bpm=get(handles.all_bpm,'value');
if all_bpm==1
    device_alim_list=dev(1:48,:);
else
    device_alim_list=dev(val_dev,:);
end;
groupe=create_group_from_list(device_alim_list);


fofb_config(groupe,X_conf,Z_conf);

tango_group_kill(groupe);

% --- Executes on selection change in dev_list_for_matrix.
function dev_list_for_matrix_Callback(hObject, eventdata, handles)
% hObject    handle to dev_list_for_matrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns dev_list_for_matrix contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dev_list_for_matrix


% --- Executes during object creation, after setting all properties.
function dev_list_for_matrix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dev_list_for_matrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in comm_x.
function comm_x_Callback(hObject, eventdata, handles)
% hObject    handle to comm_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of comm_x


% --- Executes on button press in comm_z.
function comm_z_Callback(hObject, eventdata, handles)
% hObject    handle to comm_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of comm_z


% --- Executes on button press in enable_fofb_x.
function enable_fofb_x_Callback(hObject, eventdata, handles)
% hObject    handle to enable_fofb_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enable_fofb_x


% --- Executes on button press in enable_fofb_z.
function enable_fofb_z_Callback(hObject, eventdata, handles)
% hObject    handle to enable_fofb_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enable_fofb_z


% --- Executes on button press in trig_enable_x.
function trig_enable_x_Callback(hObject, eventdata, handles)
% hObject    handle to trig_enable_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of trig_enable_x


% --- Executes on button press in trig_enable_z.
function trig_enable_z_Callback(hObject, eventdata, handles)
% hObject    handle to trig_enable_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of trig_enable_z


% --- Executes on button press in mux_conf0_x.
function mux_conf0_x_Callback(hObject, eventdata, handles)
% hObject    handle to mux_conf0_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mux_conf0_x


% --- Executes on button press in mux_conf0_z.
function mux_conf0_z_Callback(hObject, eventdata, handles)
% hObject    handle to mux_conf0_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mux_conf0_z


% --- Executes on button press in mux_conf1_x.
function mux_conf1_x_Callback(hObject, eventdata, handles)
% hObject    handle to mux_conf1_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mux_conf1_x


% --- Executes on button press in mux_conf1_z.
function mux_conf1_z_Callback(hObject, eventdata, handles)
% hObject    handle to mux_conf1_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mux_conf1_z



function coeff1_x_Callback(hObject, eventdata, handles)
% hObject    handle to coeff1_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coeff1_x as text
%        str2double(get(hObject,'String')) returns contents of coeff1_x as a double


% --- Executes during object creation, after setting all properties.
function coeff1_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coeff1_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coeff1_z_Callback(hObject, eventdata, handles)
% hObject    handle to coeff1_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coeff1_z as text
%        str2double(get(hObject,'String')) returns contents of coeff1_z as a double


% --- Executes during object creation, after setting all properties.
function coeff1_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coeff1_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LP_Delay.
function LP_Delay_Callback(hObject, eventdata, handles)
% hObject    handle to LP_Delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LP_ComDly
