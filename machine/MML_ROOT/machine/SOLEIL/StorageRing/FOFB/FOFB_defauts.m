function varargout = FOFB_defauts(varargin)
% FOFB_DEFAUTS M-file for FOFB_defauts.fig
%      FOFB_DEFAUTS, by itself, creates a new FOFB_DEFAUTS or raises the existing
%      singleton*.
%
%      H = FOFB_DEFAUTS returns the handle to a new FOFB_DEFAUTS or the handle to
%      the existing singleton*.
%
%      FOFB_DEFAUTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOFB_DEFAUTS.M with the given input arguments.
%
%      FOFB_DEFAUTS('Property','Value',...) creates a new FOFB_DEFAUTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FOFB_defauts_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FOFB_defauts_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FOFB_defauts

% Last Modified by GUIDE v2.5 03-Feb-2009 11:21:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FOFB_defauts_OpeningFcn, ...
                   'gui_OutputFcn',  @FOFB_defauts_OutputFcn, ...
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


% --- Executes just before FOFB_defauts is made visible.
function FOFB_defauts_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FOFB_defauts (see VARARGIN)

% Choose default command line output for FOFB_defauts
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FOFB_defauts wait for user response (see UIRESUME)
% uiwait(handles.figure1);
attr_list={'processTimeOutOfRange','xOrbitOutOfRange','zOrbitOutOfRange','xCorrectionOutOfRange','zCorrectionOutOfRange','bpmsCountOutOfRange','storageRingCurrentOutOfRange','fofbRecordTimeout','bpmsTangoComError','sniffersTangoComError','steerersTangoComError','dcctTangoComError','serviceLockerComError','logs','fofbErrorStatus'};
setappdata(handles.figure1,'attr_list',attr_list)
dev='ANS/DG/FOFB-MANAGER';

result=tango_read_attributes2(dev,attr_list);

set(handles.processTimeOutOfRange,'value',result(1).value);
set(handles.xOrbitOutOfRange,'value',result(2).value);
set(handles.zOrbitOutOfRange,'value',result(3).value);
set(handles.xCorrectionOutOfRange,'value',result(4).value);
set(handles.zCorrectionOutOfRange,'value',result(5).value);
set(handles.bpmsCountOutOfRange,'value',result(6).value);
set(handles.storageRingCurrentOutOfRange,'value',result(7).value);
set(handles.fofbRecordTimeout,'value',result(8).value);
set(handles.bpmsTangoComError,'value',result(9).value);
set(handles.sniffersTangoComError,'value',result(10).value);
set(handles.steerersTangoComError,'value',result(11).value);
set(handles.dcctTangoComError,'value',result(12).value);
set(handles.serviceLockerComError,'value',result(13).value);

% new_text='';
% for i=1:1:size(result(14).value,2)
%     new_text=strvcat(new_text,result(14).value{i});
% end    
new_text=result(14).value;

set(handles.logs,'string',new_text);
set(handles.logs,'value',size(new_text,1));

set(handles.fofbErrorStatus,'string',result(15).value);

switch result(15).value
    case 'no error'
        set(handles.fofbErrorStatus,'BackgroundColor',[1 1 1]*0.702)
    otherwise
        set(handles.fofbErrorStatus,'BackgroundColor','red')
end

% Count errors
sum = 0;
for k=1:13,
    sum = result(k).value;
end

% Change color of List defaut
if sum > 0
    set(handles.text_list_defaults, 'BackgroundColor', [1 0 0]);
else
    set(handles.text_list_defaults, 'BackgroundColor', [0 1 0]);
end


% --- Outputs from this function are returned to the command line.
function varargout = FOFB_defauts_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in processTimeOutOfRange.
function processTimeOutOfRange_Callback(hObject, eventdata, handles)
% hObject    handle to processTimeOutOfRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of processTimeOutOfRange


% --- Executes on button press in xOrbitOutOfRange.
function xOrbitOutOfRange_Callback(hObject, eventdata, handles)
% hObject    handle to xOrbitOutOfRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of xOrbitOutOfRange


% --- Executes on button press in zOrbitOutOfRange.
function zOrbitOutOfRange_Callback(hObject, eventdata, handles)
% hObject    handle to zOrbitOutOfRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of zOrbitOutOfRange


% --- Executes on button press in xCorrectionOutOfRange.
function xCorrectionOutOfRange_Callback(hObject, eventdata, handles)
% hObject    handle to xCorrectionOutOfRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of xCorrectionOutOfRange


% --- Executes on button press in zCorrectionOutOfRange.
function zCorrectionOutOfRange_Callback(hObject, eventdata, handles)
% hObject    handle to zCorrectionOutOfRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of zCorrectionOutOfRange


% --- Executes on button press in storageRingCurrentOutOfRange.
function storageRingCurrentOutOfRange_Callback(hObject, eventdata, handles)
% hObject    handle to storageRingCurrentOutOfRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of storageRingCurrentOutOfRange


% --- Executes on button press in fofbRecordTimeout.
function fofbRecordTimeout_Callback(hObject, eventdata, handles)
% hObject    handle to fofbRecordTimeout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fofbRecordTimeout


% --- Executes on button press in bpmsTangoComError.
function bpmsTangoComError_Callback(hObject, eventdata, handles)
% hObject    handle to bpmsTangoComError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bpmsTangoComError


% --- Executes on button press in sniffersTangoComError.
function sniffersTangoComError_Callback(hObject, eventdata, handles)
% hObject    handle to sniffersTangoComError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sniffersTangoComError


% --- Executes on button press in steerersTangoComError.
function steerersTangoComError_Callback(hObject, eventdata, handles)
% hObject    handle to steerersTangoComError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of steerersTangoComError


% --- Executes on button press in dcctTangoComError.
function dcctTangoComError_Callback(hObject, eventdata, handles)
% hObject    handle to dcctTangoComError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dcctTangoComError


% --- Executes on button press in serviceLockerComError.
function serviceLockerComError_Callback(hObject, eventdata, handles)
% hObject    handle to serviceLockerComError (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of serviceLockerComError


% --- Executes on button press in Aknowledge.
function Aknowledge_Callback(hObject, eventdata, handles)
% hObject    handle to Aknowledge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
attr_list=getappdata(handles.figure1,'attr_list');
dev='ANS/DG/FOFB-MANAGER';
tango_command_inout2(dev,'AcknowledgeError');
pause(1)
result=tango_read_attributes2(dev,attr_list);

set(handles.processTimeOutOfRange,'value',result(1).value);
set(handles.xOrbitOutOfRange,'value',result(2).value);
set(handles.zOrbitOutOfRange,'value',result(3).value);
set(handles.xCorrectionOutOfRange,'value',result(4).value);
set(handles.zCorrectionOutOfRange,'value',result(5).value);
set(handles.bpmsCountOutOfRange,'value',result(6).value);
set(handles.storageRingCurrentOutOfRange,'value',result(7).value);
set(handles.fofbRecordTimeout,'value',result(8).value);
set(handles.bpmsTangoComError,'value',result(9).value);
set(handles.sniffersTangoComError,'value',result(10).value);
set(handles.steerersTangoComError,'value',result(11).value);
set(handles.dcctTangoComError,'value',result(12).value);
set(handles.serviceLockerComError,'value',result(13).value);

% new_text='';
% for i=1:1:size(result(14).value,2)
%     new_text=strvcat(new_text,result(14).value{i});
% end    
new_text = result(14).value;
set(handles.logs,'string',new_text);
set(handles.logs,'value',size(new_text,1));

set(handles.fofbErrorStatus,'string',result(15).value);

switch result(15).value
    case 'no error'
        set(handles.fofbErrorStatus,'BackgroundColor',[1 1 1]*0.702)
    otherwise
        set(handles.fofbErrorStatus,'BackgroundColor','red')
end
  
set(handles.text_date_acquitter,'String', datestr(clock));

% Count errors
sum = 0;
for k=1:13,
    sum = result(k).value;
end

% Change color of List defaut
if sum > 0
    set(handles.text_list_defaults, 'BackgroundColor', [1 0 0]);
else
    set(handles.text_list_defaults, 'BackgroundColor', [0 1 0]);
end


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1)


% --- Executes on button press in bpmsCountOutOfRange.
function bpmsCountOutOfRange_Callback(hObject, eventdata, handles)
% hObject    handle to bpmsCountOutOfRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of bpmsCountOutOfRange


% --- Executes on selection change in logs.
function logs_Callback(hObject, eventdata, handles)
% hObject    handle to logs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns logs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from logs


% --- Executes during object creation, after setting all properties.
function logs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text_date_acquitter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_date_acquitter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject,'String', datestr(clock));


