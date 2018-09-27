function varargout = sniffer_interface(varargin)
% SNIFFER_INTERFACE M-file for sniffer_interface.fig
%      SNIFFER_INTERFACE, by itself, creates a new SNIFFER_INTERFACE or raises the existing
%      singleton*.
%
%      H = SNIFFER_INTERFACE returns the handle to a new SNIFFER_INTERFACE or the handle to
%      the existing singleton*.
%
%      SNIFFER_INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SNIFFER_INTERFACE.M with the given input arguments.
%
%      SNIFFER_INTERFACE('Property','Value',...) creates a new SNIFFER_INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sniffer_interface_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sniffer_interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sniffer_interface

% Last Modified by GUIDE v2.5 29-Sep-2008 14:38:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sniffer_interface_OpeningFcn, ...
                   'gui_OutputFcn',  @sniffer_interface_OutputFcn, ...
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


% --- Executes just before sniffer_interface is made visible.
function sniffer_interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sniffer_interface (see VARARGIN)

% Choose default command line output for sniffer_interface
handles.output = hObject;
global continuous;
continuous=0;
dev='ANS/DG/fofb-sniffer.1';
tango_set_timeout(dev,10000)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sniffer_interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sniffer_interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function selection_Callback(hObject, eventdata, handles)
% hObject    handle to selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of selection as text
%        str2double(get(hObject,'String')) returns contents of selection as a double


% --- Executes during object creation, after setting all properties.
function selection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RX_link_up_1.
function RX_link_up_1_Callback(hObject, eventdata, handles)
% hObject    handle to RX_link_up_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RX_link_up_1


% --- Executes on button press in RX_link_up_2.
function RX_link_up_2_Callback(hObject, eventdata, handles)
% hObject    handle to RX_link_up_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RX_link_up_2


% --- Executes on button press in TX_link_up_1.
function TX_link_up_1_Callback(hObject, eventdata, handles)
% hObject    handle to TX_link_up_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX_link_up_1


% --- Executes on button press in TX_link_up_2.
function TX_link_up_2_Callback(hObject, eventdata, handles)
% hObject    handle to TX_link_up_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TX_link_up_2



function sniffer_firmware_Callback(hObject, eventdata, handles)
% hObject    handle to sniffer_firmware (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sniffer_firmware as text
%        str2double(get(hObject,'String')) returns contents of sniffer_firmware as a double


% --- Executes during object creation, after setting all properties.
function sniffer_firmware_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sniffer_firmware (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CC_firmware_Callback(hObject, eventdata, handles)
% hObject    handle to CC_firmware (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CC_firmware as text
%        str2double(get(hObject,'String')) returns contents of CC_firmware as a double


% --- Executes during object creation, after setting all properties.
function CC_firmware_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CC_firmware (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function link_partner_2_Callback(hObject, eventdata, handles)
% hObject    handle to link_partner_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of link_partner_2 as text
%        str2double(get(hObject,'String')) returns contents of link_partner_2 as a double


% --- Executes during object creation, after setting all properties.
function link_partner_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to link_partner_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RX_count_2_Callback(hObject, eventdata, handles)
% hObject    handle to RX_count_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RX_count_2 as text
%        str2double(get(hObject,'String')) returns contents of RX_count_2 as a double


% --- Executes during object creation, after setting all properties.
function RX_count_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RX_count_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RX_count_1_Callback(hObject, eventdata, handles)
% hObject    handle to RX_count_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RX_count_1 as text
%        str2double(get(hObject,'String')) returns contents of RX_count_1 as a double


% --- Executes during object creation, after setting all properties.
function RX_count_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RX_count_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TX_count_2_Callback(hObject, eventdata, handles)
% hObject    handle to TX_count_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX_count_2 as text
%        str2double(get(hObject,'String')) returns contents of TX_count_2 as a double


% --- Executes during object creation, after setting all properties.
function TX_count_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX_count_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TX_count_1_Callback(hObject, eventdata, handles)
% hObject    handle to TX_count_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TX_count_1 as text
%        str2double(get(hObject,'String')) returns contents of TX_count_1 as a double


% --- Executes during object creation, after setting all properties.
function TX_count_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TX_count_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hard_err_cnt_2_Callback(hObject, eventdata, handles)
% hObject    handle to hard_err_cnt_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hard_err_cnt_2 as text
%        str2double(get(hObject,'String')) returns contents of hard_err_cnt_2 as a double


% --- Executes during object creation, after setting all properties.
function hard_err_cnt_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hard_err_cnt_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hard_err_cnt_1_Callback(hObject, eventdata, handles)
% hObject    handle to hard_err_cnt_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hard_err_cnt_1 as text
%        str2double(get(hObject,'String')) returns contents of hard_err_cnt_1 as a double


% --- Executes during object creation, after setting all properties.
function hard_err_cnt_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hard_err_cnt_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function soft_err_cnt_2_Callback(hObject, eventdata, handles)
% hObject    handle to soft_err_cnt_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of soft_err_cnt_2 as text
%        str2double(get(hObject,'String')) returns contents of soft_err_cnt_2 as a double


% --- Executes during object creation, after setting all properties.
function soft_err_cnt_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to soft_err_cnt_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function soft_err_cnt_1_Callback(hObject, eventdata, handles)
% hObject    handle to soft_err_cnt_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of soft_err_cnt_1 as text
%        str2double(get(hObject,'String')) returns contents of soft_err_cnt_1 as a double


% --- Executes during object creation, after setting all properties.
function soft_err_cnt_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to soft_err_cnt_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frame_err_cnt_2_Callback(hObject, eventdata, handles)
% hObject    handle to frame_err_cnt_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_err_cnt_2 as text
%        str2double(get(hObject,'String')) returns contents of frame_err_cnt_2 as a double


% --- Executes during object creation, after setting all properties.
function frame_err_cnt_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_err_cnt_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frame_err_cnt_1_Callback(hObject, eventdata, handles)
% hObject    handle to frame_err_cnt_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_err_cnt_1 as text
%        str2double(get(hObject,'String')) returns contents of frame_err_cnt_1 as a double


% --- Executes during object creation, after setting all properties.
function frame_err_cnt_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_err_cnt_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CC_process_time_Callback(hObject, eventdata, handles)
% hObject    handle to CC_process_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CC_process_time as text
%        str2double(get(hObject,'String')) returns contents of CC_process_time as a double


% --- Executes during object creation, after setting all properties.
function CC_process_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CC_process_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bpm_involved_Callback(hObject, eventdata, handles)
% hObject    handle to bpm_involved (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bpm_involved as text
%        str2double(get(hObject,'String')) returns contents of bpm_involved as a double


% --- Executes during object creation, after setting all properties.
function bpm_involved_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bpm_involved (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rd_fifo_full.
function rd_fifo_full_Callback(hObject, eventdata, handles)
% hObject    handle to rd_fifo_full (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rd_fifo_full


% --- Executes on button press in rd_fifo_empty.
function rd_fifo_empty_Callback(hObject, eventdata, handles)
% hObject    handle to rd_fifo_empty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rd_fifo_empty


% --- Executes on button press in wt_fifo_full.
function wt_fifo_full_Callback(hObject, eventdata, handles)
% hObject    handle to wt_fifo_full (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of wt_fifo_full


% --- Executes on button press in wt_fifo_empty.
function wt_fifo_empty_Callback(hObject, eventdata, handles)
% hObject    handle to wt_fifo_empty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of wt_fifo_empty



function rd_fifo_data_cnt_Callback(hObject, eventdata, handles)
% hObject    handle to rd_fifo_data_cnt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rd_fifo_data_cnt as text
%        str2double(get(hObject,'String')) returns contents of rd_fifo_data_cnt as a double


% --- Executes during object creation, after setting all properties.
function rd_fifo_data_cnt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rd_fifo_data_cnt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sniffer_id_Callback(hObject, eventdata, handles)
% hObject    handle to sniffer_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sniffer_id as text
%        str2double(get(hObject,'String')) returns contents of sniffer_id as a double


% --- Executes during object creation, after setting all properties.
function sniffer_id_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sniffer_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_frame_lenght_Callback(hObject, eventdata, handles)
% hObject    handle to time_frame_lenght (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_frame_lenght as text
%        str2double(get(hObject,'String')) returns contents of time_frame_lenght as a double


% --- Executes during object creation, after setting all properties.
function time_frame_lenght_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_frame_lenght (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mgt_powerdown_Callback(hObject, eventdata, handles)
% hObject    handle to mgt_powerdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mgt_powerdown as text
%        str2double(get(hObject,'String')) returns contents of mgt_powerdown as a double


% --- Executes during object creation, after setting all properties.
function mgt_powerdown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mgt_powerdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mgt_loopback_Callback(hObject, eventdata, handles)
% hObject    handle to mgt_loopback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mgt_loopback as text
%        str2double(get(hObject,'String')) returns contents of mgt_loopback as a double


% --- Executes during object creation, after setting all properties.
function mgt_loopback_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mgt_loopback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function buf_clr_dly_Callback(hObject, eventdata, handles)
% hObject    handle to buf_clr_dly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of buf_clr_dly as text
%        str2double(get(hObject,'String')) returns contents of buf_clr_dly as a double


% --- Executes during object creation, after setting all properties.
function buf_clr_dly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to buf_clr_dly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data_rate_Callback(hObject, eventdata, handles)
% hObject    handle to data_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data_rate as text
%        str2double(get(hObject,'String')) returns contents of data_rate as a double


% --- Executes during object creation, after setting all properties.
function data_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lost_frames_Callback(hObject, eventdata, handles)
% hObject    handle to lost_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lost_frames as text
%        str2double(get(hObject,'String')) returns contents of lost_frames as a double


% --- Executes during object creation, after setting all properties.
function lost_frames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lost_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fifo_overruns_Callback(hObject, eventdata, handles)
% hObject    handle to fifo_overruns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fifo_overruns as text
%        str2double(get(hObject,'String')) returns contents of fifo_overruns as a double


% --- Executes during object creation, after setting all properties.
function fifo_overruns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fifo_overruns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frame_offset_in_DMA_Callback(hObject, eventdata, handles)
% hObject    handle to frame_offset_in_DMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_offset_in_DMA as text
%        str2double(get(hObject,'String')) returns contents of frame_offset_in_DMA as a double


% --- Executes during object creation, after setting all properties.
function frame_offset_in_DMA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_offset_in_DMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frame_offset_between_DMA_Callback(hObject, eventdata, handles)
% hObject    handle to frame_offset_between_DMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_offset_between_DMA as text
%        str2double(get(hObject,'String')) returns contents of frame_offset_between_DMA as a double


% --- Executes during object creation, after setting all properties.
function frame_offset_between_DMA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_offset_between_DMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lost_frame_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to lost_frame_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lost_frame_ratio as text
%        str2double(get(hObject,'String')) returns contents of lost_frame_ratio as a double


% --- Executes during object creation, after setting all properties.
function lost_frame_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lost_frame_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in refresh.
function refresh_Callback(hObject, eventdata, handles)
% hObject    handle to refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
attr_list={'inputDataRate','lostFrames','fifoOverruns','frameOffsetInDMA','frameOffsetBetweenDMA','firmwareType','comConfig','comProcessTime','bpmCount','rdFIFOContent','rdFIFOFull','wtFIFOFull','rdFIFOEmpty','wtFIFOEmpty','comFirmwareType','comStatus','comLinkPartner1','comLinkPartner2','comLinkUp','comHwErrCont1','comHwErrCont2','comSwErrCont1','comSwErrCont2','comFrameErrCont1','comFrameErrCont2','comRxPacketsCont1','comRxPacketsCont2','comTxPacketsCont1','comTxPacketsCont2','cfgSnifferID','cfgTimeFrameLength','cfgMgtPowerDown','cfgMgtLoopBack','cfgBufferClearDelay','lostFramesRatio'};
dev_list=get(handles.sniffer_dev,'string');
dev_value=get(handles.sniffer_dev,'value');    
dev=dev_list{dev_value};
result=tango_read_attributes(dev,attr_list)
set(handles.data_rate,'string',num2str(result(1).value));
set(handles.lost_frames,'string',num2str(result(2).value));
set(handles.fifo_overruns,'string',num2str(result(3).value));
set(handles.frame_offset_in_DMA,'string',num2str(result(4).value));
set(handles.frame_offset_between_DMA,'string',num2str(result(5).value));
set(handles.sniffer_firmware,'string',num2str(result(6).value));
set(handles.CC_process_time,'string',num2str(result(8).value));
set(handles.bpm_involved,'string',num2str(result(9).value));
set(handles.rd_fifo_data_cnt,'string',num2str(result(10).value));
set(handles.rd_fifo_full,'value',(result(11).value));
set(handles.wt_fifo_full,'value',(result(12).value));
set(handles.rd_fifo_empty,'value',(result(13).value));
set(handles.wt_fifo_empty,'value',(result(14).value));
set(handles.CC_firmware,'string',num2str(result(15).value));
set(handles.link_partner_1,'string',num2str(result(17).value));
set(handles.link_partner_2,'string',num2str(result(18).value));
link_up=dec2bin(result(19).value,8);
set(handles.RX_link_up_1,'value',str2num(link_up(8)));
set(handles.RX_link_up_2,'value',str2num(link_up(7)));
set(handles.TX_link_up_1,'value',str2num(link_up(4)));
set(handles.TX_link_up_2,'value',str2num(link_up(3)));
set(handles.hard_err_cnt_1,'string',num2str(result(20).value));
set(handles.hard_err_cnt_2,'string',num2str(result(21).value));
set(handles.soft_err_cnt_1,'string',num2str(result(22).value));
set(handles.soft_err_cnt_2,'string',num2str(result(23).value));
set(handles.frame_err_cnt_1,'string',num2str(result(24).value));
set(handles.frame_err_cnt_2,'string',num2str(result(25).value));
set(handles.RX_count_1,'string',num2str(result(26).value));
set(handles.RX_count_2,'string',num2str(result(27).value));
set(handles.TX_count_1,'string',num2str(result(28).value));
set(handles.TX_count_2,'string',num2str(result(29).value));
set(handles.sniffer_id,'string',num2str(result(30).value));
set(handles.time_frame_lenght,'string',num2str(result(31).value));
set(handles.mgt_powerdown,'string',num2str(result(32).value));
set(handles.mgt_loopback,'string',num2str(result(33).value));
set(handles.buf_clr_dly,'string',num2str(result(34).value));
set(handles.lost_frame_ratio,'string',num2str(result(35).value));


% --- Executes on button press in display.
function display_Callback(hObject, eventdata, handles)
% hObject    handle to display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%attr_list={'xPosData','zPosData','firstTimeFrame','lastTimeFrame'};
dev_list=get(handles.sniffer_dev,'string');
dev_value=get(handles.sniffer_dev,'value');    
dev=dev_list{dev_value};

%while continuous==1
%Nsamples=4096*Nbuffer;

% for i=1:1:Nbuffer
%     result{i}=tango_read_attributes(dev,attr_list);
%     delai=.8 + sqrt(0.5) * randn
%     pause(delai)
%     waitbar(i/Nbuffer,h); 
% end

axes(handles.graph)

if get(handles.is_orbit,'value')
    attr_list={'XPosMean','ZPosMean'};
    result=tango_read_attributes2(dev,attr_list)
    plot(double(result(2).value(2:121))./1000)
    hold on
    plot(double(result(1).value(2:121))./1000,'r')
    xlabel('bpm number')
    ylabel('µm')
    title('orbit display')
    legend('Vertical','Horizontal');
    hold off
    grid on


else if get(handles.is_buffer,'value')
    dataX=0;
    dataZ=0;
    bpm=str2num(get(handles.selection,'string'))
    dataX=tango_command_inout2(dev,'GetXPosData',uint16(bpm));
    dataZ=tango_command_inout2(dev,'GetZPosData',uint16(bpm));

%         for j=2:1:121
%         [toto tata]=find(result{i}(1).value(j,:)==0);
%         if isempty(find(result{i}(2).value(j,tata)==0))==0
%             bpm_nul=bpm_nul+1;
%             frame_nulle(tata)=frame_nulle(tata)+1;
%          end
%         
%         end

%     index=find(frame_nulle)
%     frame_nulle(index)
%     dataX=dataX(2:size(dataX,2));
%     dataZ=dataZ(2:size(dataZ,2));
    plot(double(dataX)./1000.0)
    hold on
    plot(double(dataZ)./1000.0,'r')
    xlabel('sample number (at 10 kHz)')
    ylabel('µm')
    title(['buffer display bpm ',num2str(bpm)])
    legend('Horizontal','Vertical');
    hold off
    grid on
%     (result{Nbuffer}(4).value-result{1}(3).value)/4096;
    
%     
%     set(handles.ff_cnt,'string',num2str(result(3).value));
%     set(handles.lf_cnt,'string',num2str(result(4).value));
%     
   
else if get(handles.is_fft,'value')
    dataX=0;
    dataZ=0;
    bpm=str2num(get(handles.selection,'string'))
    dataX=tango_command_inout2(dev,'GetXPosData',uint16(bpm));
    dataZ=tango_command_inout2(dev,'GetZPosData',uint16(bpm));
    Nsamples=size(dataX,2)
    xfft=0;
    pxfft=0;
    pxfftaff=0;
%      for i=1:1:Nbuffer
%         dataX=[dataX result{i}(1).value(bpm+1,:)];
%         dataZ=[dataZ result{i}(2).value(bpm+1,:)];
% 
%     end
%     dataX=dataX(2:size(dataX,2));
%     dataZ=dataZ(2:size(dataZ,2));

    fech=10079;
    fmax=100;
    Nfft=1000*Nsamples;
    xfft=fft(double(dataX./10^3),Nsamples)/Nsamples;
    zfft=fft(double(dataZ./10^3),Nsamples)/Nsamples;
    pxfft=2*xfft.*conj(xfft);
    pzfft=2*zfft.*conj(zfft);
    %on normalise pour afficher la dsp en µm^2/Hz et non pas en µm^2/largeur de bande entre 2 échantillons
    pxfftaff=sqrt(pxfft*Nsamples/fech);
    pzfftaff=sqrt(pzfft*Nsamples/fech);
    f_bpm=(1:Nsamples-1)*fech/Nsamples;
    n_bpm=(1:120);
    semilogy(f_bpm,pxfftaff(1,2:Nsamples),'r');
    hold on;
    semilogy(f_bpm,pzfftaff(1,2:Nsamples),'b');
    %xlim([0 fmax]);
    fmin=str2num(get(handles.fmin,'string'));
    fmax=str2num(get(handles.fmax,'string'));
    xlim([fmin fmax]);
 %   xlim([0 90]);
    ylim([10^-3 10^2]);
    xlabel('frequency (Hz)')
    ylabel('µm/sqrt(Hz)')
    title(['fft on bpm ',num2str(bpm)])
    legend('Horizontal','Vertical');
    hold off
     grid on;
    axes(handles.graph2)
    PXintegrale_bpm(1:Nsamples)=0;
    PZintegrale_bpm(1:Nsamples)=0;

    for step=2:Nsamples
        PXintegrale_bpm(step)=PXintegrale_bpm(step-1) + pxfft(step);
        PZintegrale_bpm(step)=PZintegrale_bpm(step-1) + pzfft(step);
    end
    Xintegrale_bpm=sqrt((PXintegrale_bpm));
    Zintegrale_bpm=sqrt((PZintegrale_bpm));
    bruitX_bpm = Xintegrale_bpm(floor(Nsamples/2))
    bruitZ_bpm = Zintegrale_bpm(floor(Nsamples/2))
    plot(f_bpm,Xintegrale_bpm(2:Nsamples),'r')
    hold on
    plot(f_bpm,Zintegrale_bpm(2:Nsamples),'b')
    %xlim([0 fmax]);
    xlim([fmin fmax]);
    %xlim([0 90]);
    xlabel('frequence (Hz)');
    ylabel('µm');
    legend('Horizontal','Vertical');
    hold off
    grid on;
    end
    end

end
% close(h);
%end
% first_frame=result{1}(3).value;
%     last_frame=result{Nbuffer}(4).value;
%     if last_frame<first_frame
%         last_frame=last_frame+2^16;
%     end
%     last_frame-first_frame
%     if ((last_frame-first_frame)+1==Nsamples)
%         set(handles.record_done,'value',1)
%     else
%          set(handles.record_done,'value',0)
%     end
%  
function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit32 as text
%        str2double(get(hObject,'String')) returns contents of edit32 as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in command.
function command_Callback(hObject, eventdata, handles)
% hObject    handle to command (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns command contents as cell array
%        contents{get(hObject,'Value')} returns selected item from command
button=questdlg('Apply command ?','Confirm','Yes');
switch button
    case 'Yes'
    command_list=get(handles.command,'string')
    command_line=get(handles.command,'value')
    command=command_list{command_line}
    dev_list=get(handles.sniffer_dev,'string');
    dev_value=get(handles.sniffer_dev,'value');    
    dev=dev_list{dev_value};
    result=tango_command_inout2(dev,command)   
    otherwise
end

% --- Executes during object creation, after setting all properties.
function command_CreateFcn(hObject, eventdata, handles)
% hObject    handle to command (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in is_fft_3d.
function fft_3d_Callback(hObject, eventdata, handles)
% hObject    handle to is_fft_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
attr_list={'xPosData','zPosData'};
dev_list=get(handles.sniffer_dev,'string');
dev_value=get(handles.sniffer_dev,'value');    
dev=dev_list{dev_value};
result=tango_read_attributes(dev,attr_list)

xfft=0;
pxfft=0;
pxfftaff=0;
Nsamples=4096;
fech=10079

xfft=fft((double(transpose(result(1).value(2:121,:)./1000))))./Nsamples;
zfft=fft((double(transpose(result(2).value(2:121,:)./1000))))./Nsamples;
pxfft=2*xfft.*conj(xfft);
pzfft=2*zfft.*conj(zfft);
pxfftaff=pxfft*Nsamples/fech;
pzfftaff=pzfft*Nsamples/fech;
f_bpm=(0:Nsamples-1)*fech/Nsamples;
n_bpm=(1:120);

figure(1)
surf(n_bpm,f_bpm(2:Nsamples),log(pxfftaff(2:Nsamples,:)))
ylim([0 1000])
xlabel('bpm number');
ylabel('frequency (Hz)');
zlabel('log de la densite spectrale de puissance')
title('densité spectrale de puissance mesurée sur les données FA (@10 kHz) sur les 120 BPMs dans le plan horizontal');
figure(2)
surf(n_bpm,f_bpm(2:Nsamples),log(pzfftaff(2:Nsamples,:)))
ylim([0 1000])
xlabel('bpm number');
ylabel('frequency (Hz)');
zlabel('log de la densite spectrale de puissance')
title('densité spectrale de puissance mesurée sur les données FA (@10 kHz) sur les 120 BPMs dans le plan vertical');



% --- Executes on button press in is_fft.
function is_fft_Callback(hObject, eventdata, handles)
% hObject    handle to is_fft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in integrated_noise.
function integrated_noise_Callback(hObject, eventdata, handles)
% hObject    handle to integrated_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
attr_list={'xPosData','zPosData'};
dev_list=get(handles.sniffer_dev,'string');
dev_value=get(handles.sniffer_dev,'value');    
dev=dev_list{dev_value};
result=tango_read_attributes(dev,attr_list)
xfft=0;
pxfft=0;
pxfftaff=0;
Nsamples=4096;
fech=10079
fmax=1200;
xfft=fft((double(transpose(result(1).value(2:121,:)./1000))))./Nsamples;
zfft=fft((double(transpose(result(2).value(2:121,:)./1000))))./Nsamples;
pxfft=2*xfft.*conj(xfft);
pzfft=2*zfft.*conj(zfft);
pxfftaff=pxfft*Nsamples/fech;
pzfftaff=pzfft*Nsamples/fech;
f_bpm=(0:Nsamples-1)*fech/Nsamples;
n_bpm=(1:120);

PXintegrale_bpm(1:4096,1:120)=0;
PZintegrale_bpm(1:4096,1:120)=0;

for j=1:1:120
    for step=2:Nsamples
        PXintegrale_bpm(step,j)=PXintegrale_bpm(step-1,j) + pxfft(step,j);
        PZintegrale_bpm(step,j)=PZintegrale_bpm(step-1,j) + pzfft(step,j);
    end
end
Xintegrale_bpm=sqrt((PXintegrale_bpm));
Zintegrale_bpm=sqrt((PZintegrale_bpm));
bruitX_bpm = Xintegrale_bpm(Nsamples/2)
bruitZ_bpm = Zintegrale_bpm(Nsamples/2)

figure(1)
subplot(3,2,1)
semilogy(f_bpm(2:Nsamples),pxfftaff(2:Nsamples,:));
xlim([0 fmax]);
ylim([10^-6 10^2])
title('densité spectrale de puissance horizontale sur les 120 bpms');
xlabel('frequence (Hz)');
ylabel('µm^2/Hz');
grid on;

subplot(3,2,2)
semilogy(f_bpm(2:Nsamples),pzfftaff(2:Nsamples,:));
xlim([0 fmax]);
ylim([10^-6 10^2])
title('densité spectrale de puissance verticale sur les 120 bpms');
xlabel('frequence (Hz)');
ylabel('µm^2/Hz');
grid on;

subplot(3,2,3)
plot(f_bpm,Xintegrale_bpm)
xlim([0 fmax]);
title('bruit integré horizontal en fonction de la frequence sur les 120 bpms');
xlabel('frequence (Hz)');
ylabel('µm');
grid on;

subplot(3,2,4)
plot(f_bpm,Zintegrale_bpm)
xlim([0 fmax]);
title('bruit integré vertical en fonction de la frequence sur les 120 bpms');
xlabel('frequence (Hz)');
ylabel('µm');
grid on;

index=find(f_bpm>=fmax)

subplot(3,2,5)
plot(Xintegrale_bpm(index(1),:))
xlim([0 120]);
title(['bruit integré horizontal dans la bande 0-',num2str(fmax),' Hz en fonction de la position sur les 120 bpms']);
xlabel('numéro du bpm');
ylabel('µm');
grid on;

subplot(3,2,6)
plot(Zintegrale_bpm(index(1),:))
xlim([0 120]);
title(['bruit integré vertical dans la bande 0-',num2str(fmax),' Hz en fonction de la position sur les 120 bpms']);
xlabel('numéro du bpm');
ylabel('µm');   
grid on;

save bruit_integre pxfftaff pzfftaff Xintegrale_bpm Zintegrale_bpm f_bpm


% --- Executes on button press in continuous.
function continuous_Callback(hObject, eventdata, handles)
% hObject    handle to continuous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of continuous
% global continuous;
% 
% continuous=get(handles.continuous,'value')



function ff_cnt_Callback(hObject, eventdata, handles)
% hObject    handle to ff_cnt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ff_cnt as text
%        str2double(get(hObject,'String')) returns contents of ff_cnt as a double


% --- Executes during object creation, after setting all properties.
function ff_cnt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ff_cnt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lf_cnt_Callback(hObject, eventdata, handles)
% hObject    handle to lf_cnt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lf_cnt as text
%        str2double(get(hObject,'String')) returns contents of lf_cnt as a double


% --- Executes during object creation, after setting all properties.
function lf_cnt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lf_cnt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function Buffer_length_Callback(hObject, eventdata, handles)
% hObject    handle to Buffer_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Buffer_length as text
%        str2double(get(hObject,'String')) returns contents of Buffer_length as a double
duree=get(handles.Buffer_length,'string')
dev_list=get(handles.sniffer_dev,'string');
dev_value=get(handles.sniffer_dev,'value');    
dev=dev_list{dev_value};
tango_write_attribute2(dev,'recordLengthInSecs',str2num(duree))


% --- Executes during object creation, after setting all properties.
function Buffer_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Buffer_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in record_done.
function record_done_Callback(hObject, eventdata, handles)
% hObject    handle to record_done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of record_done





function fmax_Callback(hObject, eventdata, handles)
% hObject    handle to fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fmax as text
%        str2double(get(hObject,'String')) returns contents of fmax as a double
axes(handles.graph)
fmin=str2num(get(handles.fmin,'string'));
fmax=str2num(get(handles.fmax,'string'));
xlim([fmin fmax]);
axes(handles.graph2)
xlim([fmin fmax]);

% --- Executes during object creation, after setting all properties.
function fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fmin_Callback(hObject, eventdata, handles)
% hObject    handle to fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fmin as text
%        str2double(get(hObject,'String')) returns contents of fmin as a double
axes(handles.graph)
fmin=str2num(get(handles.fmin,'string'));
fmax=str2num(get(handles.fmax,'string'));
xlim([fmin fmax]);
axes(handles.graph2)
xlim([fmin fmax]);

% --- Executes during object creation, after setting all properties.
function fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in start_record.
function start_record_Callback(hObject, eventdata, handles)
% hObject    handle to start_record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dev_list=get(handles.sniffer_dev,'string');
dev_value=get(handles.sniffer_dev,'value');    
dev=dev_list{dev_value};
set(handles.record_done,'value',0)
record_done=0;
result_duree=tango_read_attribute2(dev,'recordLengthInSecs');
duree=result_duree.value(1)
set(handles.Buffer_length,'string',num2str(duree));
tango_command_inout2(dev,'StartRecording');
h = waitbar(0,'Please wait...');
for i=1:10,
pause(duree/10) 
% computation here %
waitbar(i/10,h)
end
while record_done==0
    result=tango_read_attribute2(dev,'recordReady')
    if result.value==1
        set(handles.record_done,'value',1)
        close(h)
        record_done=1;
    else
        pause(1)
    end
end


% --- Executes on selection change in sniffer_dev.
function sniffer_dev_Callback(hObject, eventdata, handles)
% hObject    handle to sniffer_dev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns sniffer_dev contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sniffer_dev


% --- Executes during object creation, after setting all properties.
function sniffer_dev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sniffer_dev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


