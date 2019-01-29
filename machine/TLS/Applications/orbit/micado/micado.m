function varargout = micado(varargin)
% micado M-file for micado.fig
%      micado, by itself, creates a new micado or raises the existing
%      singleton*.
%
%      H = micado returns the handle to a new micado or the handle to
%      the existing singleton*.
%
%      micado('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in micado.M with the given input arguments.
%
%      micado('Property','Value',...) creates a new micado or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before micado_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to micado_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help micado

% Last Modified by GUIDE v2.5 21-Dec-2011 15:07:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @micado_OpeningFcn, ...
                   'gui_OutputFcn',  @micado_OutputFcn, ...
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


% --- Executes just before micado is made visible.
function micado_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to micado (see VARARGIN)

% Choose default command line output for micado
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

getbpm_BBA('BPMx',[],handles);
getcm_BBA('HCM',[],handles);




function varargout = getbpm_BBA(X,Dev,handles)
% if isempty(Dev)
%     Dev = dev2elem(X,[1 1]);
% else
%     Dev = dev2elem(X,Dev);
% end
DataStruct1 = getfamilydata(X);
Data1 = getpv(X);
set(handles.DataList1, 'String', [DataStruct1.CommonNames, num2str(Data1(:),'= %+.4e')]);
axes(handles.Graph1);
if isempty(Dev)
    plot(handles.Graph1,DataStruct1.Position,Data1,'-*');
else
    Dev = dev2elem(X,Dev);
    plot(handles.Graph1,DataStruct1.Position,Data1,'-*',DataStruct1.Position(Dev),Data1(Dev),'O','MarkerFaceColor','r');
end
xlabel(sprintf('Position [m]'));
ylabel(sprintf('%s [mm]', DataStruct1.FamilyName));
i = find(~isnan(Data1));
if isempty(i)
    MeanString = '';
    RMSString  = '';
else
    MeanString = sprintf('%+9.6e Mean', mean(Data1(i)));
    RMSString  = sprintf('%+9.6e RMS', (length(Data1(i))-1)*std(Data1(i))/length(Data1(i)));
end
set(handles.Trace1RMS,'String',{MeanString, RMSString});
set(handles.Trace1RMS,'FontSize', 9);

% set(handles.text21, 'String', DataStruct1.FamilyName);
% set(handles.text23, 'String', num2str(DataStruct1.DeviceList(Dev,:),'[ %2d, %2d ]'));
% set(handles.text25, 'String', num2str(Data1(Dev),'%+.4e'));
L = getfamilydata('Circumference');
set(handles.Graph1, 'XLim',[0 L]);

function varargout = getcm_BBA(X,Dev,handles)
% if isempty(Dev)
%     Dev = dev2elem(X,[1 1]);
% else
%     Dev = dev2elem(X,Dev);
% end
DataStruct2 = getfamilydata(X);
Data2 = getpv(X);
set(handles.DataList2, 'String', [DataStruct2.CommonNames, num2str(Data2(:),'= %+.4e')]);
axes(handles.Graph2);
if isempty(Dev)
    plot(handles.Graph2,DataStruct2.Position,Data2,'-*');
else
    Dev = dev2elem(X,Dev);
    plot(handles.Graph2,DataStruct2.Position,Data2,'-*',DataStruct2.Position(Dev),Data2(Dev),'O','MarkerFaceColor','r');
end
xlabel(sprintf('Position [m]'));
ylabel(sprintf('%s [A]', DataStruct2.FamilyName));
i = find(~isnan(Data2));
if isempty(i)
    MeanString = '';
    RMSString  = '';
else
    MeanString = sprintf('%+9.6e Mean', mean(Data2(i)));
    RMSString  = sprintf('%+9.6e RMS', (length(Data2(i))-1)*std(Data2(i))/length(Data2(i)));
end
set(handles.Trace2RMS,'String',{MeanString, RMSString});
set(handles.Trace2RMS,'FontSize', 9);

% set(handles.text28, 'String', DataStruct2.FamilyName);
% set(handles.text30, 'String', num2str(DataStruct2.DeviceList(Dev,:),'[ %2d, %2d ]'));
% set(handles.text32, 'String', num2str(Data2(Dev),'%+.4e'));
L = getfamilydata('Circumference');
set(handles.Graph2, 'XLim',[0 L]);

% --- Outputs from this function are returned to the command line.
function varargout = micado_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in plane1.
function plane1_Callback(hObject, eventdata, handles)
% hObject    handle to plane1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hint: get(hObject,'Value') returns toggle state of plane1


% --- Executes on button press in plane2.
function plane2_Callback(hObject, eventdata, handles)
% hObject    handle to plane2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plane2


% --- Executes on button press in H.
function H_Callback(hObject, eventdata, handles)
% hObject    handle to H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.V,'Value',0);
axes(handles.Graph1);
cla;
getbpm_BBA('BPMx',[],handles);
axes(handles.Graph2);
cla;
getcm_BBA('HCM',[],handles);
set(handles.Plane,'UserData',1);
% Hint: get(hObject,'Value') returns toggle state of H




% --- Executes on button press in Q3.
function Q3_Callback(hObject, eventdata, handles)
% hObject    handle to Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Q
Q = 3;
set(handles.Device, 'String', []);
set(handles.Device, 'Value', []);
Q3 = get(handles.Q3, 'Value');
QD3L = getfamilydata('QD3L');
if Q3 == 1
    set(handles.Device, 'String', num2str(QD3L.DeviceList(QD3L.ElementList,:),'[ %2d, %2d ]'));
else
    set(handles.Device, 'String', []);
end

% Hint: get(hObject,'Value') returns toggle state of Q3


% --- Executes on button press in Q4.
function Q4_Callback(hObject, eventdata, handles)
% hObject    handle to Q4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Q
Q = 4;
set(handles.Device, 'String', []);
set(handles.Device, 'Value', []);
Q4 = get(handles.Q4, 'Value');
QD1S = getfamilydata('QD1S');
if Q4 == 1
    set(handles.Device, 'String', num2str(QD1S.DeviceList(QD1S.ElementList,:),'[ %2d, %2d ]'));
else
    set(handles.Device, 'String', []);
end


% Hint: get(hObject,'Value') returns toggle state of Q4


% --- Executes on button press in DL1.
function DL1_Callback(hObject, eventdata, handles)
% hObject    handle to DL1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DL1


% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox12


% --- Executes on button press in checkbox13.
function checkbox13_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox13


% --- Executes on button press in checkbox14.
function checkbox14_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox14


% --- Executes on button press in checkbox15.
function checkbox15_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox15


% --- Executes on button press in checkbox16.
function checkbox16_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox16


% --- Executes on button press in checkbox17.
function checkbox17_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox17


% --- Executes on button press in checkbox18.
function checkbox18_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox18


% --- Executes on button press in checkbox19.
function checkbox19_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox19


% --- Executes on button press in checkbox20.
function checkbox20_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox20


% --- Executes on button press in checkbox21.
function checkbox21_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox21


% --- Executes on button press in checkbox22.
function checkbox22_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox22


% --- Executes on button press in DL2.
function DL2_Callback(hObject, eventdata, handles)
% hObject    handle to DL2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DL2


% --- Executes on button press in DL3.
function DL3_Callback(hObject, eventdata, handles)
% hObject    handle to DL3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DL3


% --- Executes on button press in DL4.
function DL4_Callback(hObject, eventdata, handles)
% hObject    handle to DL4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DL4


% --- Executes on button press in DL5.
function DL5_Callback(hObject, eventdata, handles)
% hObject    handle to DL5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DL5


% --- Executes on button press in DL6.
function DL6_Callback(hObject, eventdata, handles)
% hObject    handle to DL6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DL6


% --- Executes on button press in DL7.
function DL7_Callback(hObject, eventdata, handles)
% hObject    handle to DL7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DL7


% --- Executes on button press in DL8.
function DL8_Callback(hObject, eventdata, handles)
% hObject    handle to DL8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DL8


% --- Executes on button press in DL9.
function DL9_Callback(hObject, eventdata, handles)
% hObject    handle to DL9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DL9


% --- Executes on button press in DL10.
function DL10_Callback(hObject, eventdata, handles)
% hObject    handle to DL10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DL10


% --- Executes on button press in DL11.
function DL11_Callback(hObject, eventdata, handles)
% hObject    handle to DL11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DL11


% --- Executes on button press in DL12.
function DL12_Callback(hObject, eventdata, handles)
% hObject    handle to DL12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DL12


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton8


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10


% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton11


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton12.
function radiobutton12_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton12


% --- Executes on button press in radiobutton13.
function radiobutton13_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton13


% --- Executes on button press in radiobutton14.
function radiobutton14_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton14


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton15.
function radiobutton15_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton15


% --- Executes on button press in radiobutton16.
function radiobutton16_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton16


% --- Executes on button press in radiobutton17.
function radiobutton17_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton17


% --- Executes on button press in radiobutton18.
function radiobutton18_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton18


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in DataList1.
function DataList1_Callback(hObject, eventdata, handles)
% hObject    handle to DataList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Mode = getmode('QF1','Monitor');
% DataStruct1 = getfamilydata('BPMx');
% Data1 = getpv('BPMx');
% set(handles.DataList1, 'String', [DataStruct1.CommonNames, num2str(Data1(:),'= %+.4e')]);



% Hints: contents = get(hObject,'String') returns DataList1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DataList1


% --- Executes during object creation, after setting all properties.
function DataList1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DataList2.
function DataList2_Callback(hObject, eventdata, handles)
% hObject    handle to DataList2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns DataList2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DataList2


% --- Executes during object creation, after setting all properties.
function DataList2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataList2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P1_Callback(hObject, eventdata, handles)
% hObject    handle to P1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P1 as text
%        str2double(get(hObject,'String')) returns contents of P1 as a double


% --- Executes during object creation, after setting all properties.
function P1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P2_Callback(hObject, eventdata, handles)
% hObject    handle to P2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P2 as text
%        str2double(get(hObject,'String')) returns contents of P2 as a double


% --- Executes during object creation, after setting all properties.
function P2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P5_Callback(hObject, eventdata, handles)
% hObject    handle to P5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P5 as text
%        str2double(get(hObject,'String')) returns contents of P5 as a double


% --- Executes during object creation, after setting all properties.
function P5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P6_Callback(hObject, eventdata, handles)
% hObject    handle to P6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P6 as text
%        str2double(get(hObject,'String')) returns contents of P6 as a double


% --- Executes during object creation, after setting all properties.
function P6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in P4.
function P4_Callback(hObject, eventdata, handles)
% hObject    handle to P4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns P4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from P4


% --- Executes during object creation, after setting all properties.
function P4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in P3.
function P3_Callback(hObject, eventdata, handles)
% hObject    handle to P3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns P3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from P3


% --- Executes during object creation, after setting all properties.
function P3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DataList3.
function DataList3_Callback(hObject, eventdata, handles)
% hObject    handle to DataList3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Data = get(handles.DataList3,'String');
index = get(handles.DataList3,'Value');
[QMS, WarningString] = quadplot_BBA(Data(index,:),0,[],handles);
set(handles.text58,'String',QMS.QuadFamily);
set(handles.text60,'String',num2str(QMS.QuadDev(1,:),'[ %2d, %2d ]'));
set(handles.text62,'String',num2str(QMS.Center,'%+.4e'));

% Hints: contents = get(hObject,'String') returns DataList3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DataList3


% --- Executes during object creation, after setting all properties.
function DataList3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataList3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3


% --- Executes on button press in R1.
function C1_Callback(hObject, eventdata, handles)
% hObject    handle to R1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Family = get(handles.Select,'UserData');
% DeviceList = get(handles.Device,'UserData');
% getcm_BBA(Family,DeviceList(1,:),handles);
Data = get(handles.uipushtool2,'UserData');
if get(handles.Plane,'UserData') == 1
    b = getam('BPMx');
    A = getrespmat('BPMx', 'HCM');
    x = getsp('HCM');
    m = length(family2elem('BPMx'));
    n = length(family2elem('HCM'));
    if ~isempty(Data) 
        r = b - Data(:,1);
        b = r;
    else
        r = b;
    end
else
    b = getam('BPMy');
    A = getrespmat('BPMy', 'VCM');
    x = getsp('VCM');
    m = length(family2elem('BPMy'));
    n = length(family2elem('VCM'));
    if ~isempty(Data) 
        r = b - Data(:,2);
        b = r;
    else
        r = b;
    end
end
set(handles.Reset,'UserData',x);
esp_value=str2num(get(handles.esp,'String'));
iter = str2num(get(handles.iter,'String'));
ipiv=[];
work=[];
[r1,A1,x1,b1,m1,n1,esp_value1,iter1,ipiv1,work1] = householder(r,A,x,b,m,n,esp_value,iter,ipiv,work,handles);
cm = x - x1;
set(handles.Set,'UserData',cm);
if get(handles.Plane,'UserData') == 1
    axes(handles.Graph1);
    cla;
    getbpm_BBA('BPMx',[],handles);
    axes(handles.Graph2);
    cla;
    getcm_BBA('HCM',[],handles);
    axes(handles.Graph1);
    hold on;
    spos = getspos('BPMx');
    if ~isempty(Data)
        plot(spos,Data(:,1),'-rs');
    else
        plot(spos,r1,'-rs');
    end
    axes(handles.Graph2);
    hold on;
    spos = getspos('HCM');
    plot(spos,cm,'-rs');

else
    axes(handles.Graph1);
    cla;
    getbpm_BBA('BPMy',[],handles);
    axes(handles.Graph2);
    cla;
    getcm_BBA('VCM',[],handles);
    axes(handles.Graph1);
    hold on;
    spos = getspos('BPMy');
    if ~isempty(Data)
        plot(spos,Data(:,2),'-rs');
    else
        plot(spos,r1,'-rs');
    end
    axes(handles.Graph2);
    hold on;
    spos = getspos('VCM');
    plot(spos,cm,'-rs');

end



% --- Executes on mouse press over axes background.
function Graph1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Graph1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% Hint: get(hObject,'Value') returns toggle state of Q2


% --- Executes on button press in Q3.
function checkbox36_Callback(hObject, eventdata, handles)
% hObject    handle to Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Q3


% --- Executes on button press in Q4.
function checkbox37_Callback(hObject, eventdata, handles)
% hObject    handle to Q4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Q4


% --- Executes on button press in V.
function V_Callback(hObject, eventdata, handles)
% hObject    handle to V (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.H,'Value',0);
axes(handles.Graph1);
cla;
getbpm_BBA('BPMy',[],handles);
axes(handles.Graph2);
cla;
getcm_BBA('VCM',[],handles);
set(handles.Plane,'UserData',2);



    



% Hints: contents = get(hObject,'String') returns Device contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Device


% --- Executes during object creation, after setting all properties.
function Device_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Device (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Q2.
function Q2_Callback(hObject, eventdata, handles)
% hObject    handle to Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Q
Q = 2;
set(handles.Device, 'String', []);
set(handles.Device, 'Value', []);
Q2 = get(handles.Q2, 'Value');
QF2L = getfamilydata('QF2L');
if Q2 == 1
    set(handles.Device, 'String', num2str(QF2L.DeviceList(QF2L.ElementList,:),'[ %2d, %2d ]'));
else
    set(handles.Device, 'String', []);
end

% Hint: get(hObject,'Value') returns toggle state of Q2


% --- Executes on button press in All.
function All_Callback(hObject, eventdata, handles)
% hObject    handle to All (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Q
Value = get(handles.Device, 'Value');
switch Q
    case 1
        QD1L = getfamilydata('QD1L');
        for i = 1:length(QD1L.DeviceList)
            Value(i,1) = i;
        end
        set(handles.Device, 'Value', Value);
    case 2
        QF2L = getfamilydata('QF2L');
        for i = 1:length(QF2L.DeviceList)
            Value(i,1) = i;
        end
        set(handles.Device, 'Value', Value);
    case 3
        QD3L = getfamilydata('QD3L');
        for i = 1:length(QD3L.DeviceList)
            Value(i,1) = i;
        end
        set(handles.Device, 'Value', Value);
    case 4
        QD1S = getfamilydata('QD1S');
        for i = 1:length(QD1S.DeviceList)
            Value(i,1) = i;
        end
        set(handles.Device, 'Value', Value);
    case 5
        QF2S = getfamilydata('QF2S');
        for i = 1:length(QF2S.DeviceList)
            Value(i,1) = i;
        end
        set(handles.Device, 'Value', Value);
    case 6
        QD3S = getfamilydata('QD3S');
        for i = 1:length(QD3S.DeviceList)
            Value(i,1) = i;
        end
        set(handles.Device, 'Value', Value);
    case 7
        QD4S = getfamilydata('QD4S');
        for i = 1:length(QD4S.DeviceList)
            Value(i,1) = i;
        end
        set(handles.Device, 'Value', Value);
    case 8
        QF5S = getfamilydata('QF5S');
        for i = 1:length(QF5S.DeviceList)
            Value(i,1) = i;
        end
        set(handles.Device, 'Value', Value);
end


% --- Executes on button press in Select.
function Select_Callback(hObject, eventdata, handles)
% hObject    handle to Select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.R1,'String',' ');
set(handles.R2,'String',' ');
set(handles.R3,'String',' ');
set(handles.R4,'String',' ');
selected = get(handles.Device, 'Value');
if get(handles.H, 'Value') == 1
    Family = 'HCM';
    Data = getfamilydata('HCM');
    BPM = getfamilydata('BPMx');
    for i=1:length(selected)
        DeviceList(i,:) = Data.DeviceList(selected(1,i),:);
    end
    if length(DeviceList) == 4
        spos = getspos('BPMx');
        Ref = [];
        for i = 1:length(spos)
            if spos(i) > getspos('HCM',DeviceList(2,:)) && spos(i) < getspos('HCM',DeviceList(3,:))
                Ref = cat(1,Ref,i);
            end
        end
        Ref = BPM.DeviceList(Ref,:);
    end
elseif get(handles.V, 'Value') == 1
    Family = 'VCM';
    Data = getfamilydata('VCM');
    BPM = getfamilydata('BPMy');
    for i=1:length(selected)
        DeviceList(i,:) = Data.DeviceList(selected(1,i),:);
    end
    if length(DeviceList) == 4
        spos = getspos('BPMy');
        Ref = [];
        for i = 1:length(spos)
            if spos(i) > getspos('VCM',DeviceList(2,:)) && spos(i) < getspos('VCM',DeviceList(3,:))
                Ref = cat(1,Ref,i);
            end
        end
        Ref = BPM.DeviceList(Ref,:);
    end
end
set(handles.Select,'UserData',Family);
set(handles.Device,'UserData',DeviceList);
set(handles.uipanel5,'UserData',getsp(Family,DeviceList));
set(handles.Name, 'String', num2str(DeviceList(1,:),'[ %2d, %2d ]'));
set(handles.Current, 'String', num2str(getsp(Family,DeviceList(1,:))));
set(handles.slider, 'Value', getsp(Family,DeviceList(1,:)));
if strcmpi(Family,'HCM')
    getbpm_BBA('BPMx',[],handles);
else
    getbpm_BBA('BPMy',[],handles);
end
if length(DeviceList) == 4
%     Ref(1,:) = [];
%     Ref(1,:) = [];
    set(handles.Method,'Enable','on');
    if strcmpi(get(handles.F2,'Checked'),'on')
        set(handles.Reference,'Enable','on');
        set(handles.Reference,'UserData',Ref(1,:));
        set(handles.Reference,'String',num2str(Ref,'[ %2d, %2d ]'));
    elseif strcmpi(get(handles.F1,'Checked'),'on')
        set(handles.Reference,'Enable','off');
        set(handles.BPM,'UserData',Ref(1,:));
        set(handles.BPM,'String',num2str(Ref,'[ %2d, %2d ]'));
    end
        
    if strcmpi(Family,'HCM')
        getbpm_BBA('BPMx',Ref(1,:),handles);
    else
        getbpm_BBA('BPMy',Ref(1,:),handles);
    end
    set(handles.Method,'Value',2);
elseif length(DeviceList) == 3
    set(handles.BPM,'String',num2str(BPM.DeviceList,'[ %2d, %2d ]'));
    if strcmpi(Family,'HCM')
        getbpm_BBA('BPMx',BPM.DeviceList(1,:),handles);
    else
        getbpm_BBA('BPMy',BPM.DeviceList(1,:),handles);
    end
end
getcm_BBA(Family,DeviceList(1,:),handles);




% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Device.
function Device_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Device (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on Device and none of its controls.
function Device_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Device (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function Name_Callback(hObject, eventdata, handles)
% hObject    handle to Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Name as text
%        str2double(get(hObject,'String')) returns contents of Name as a double


% --- Executes during object creation, after setting all properties.
function Name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider = get(handles.slider,'Value');
% Current = str2num(get(handles.Current,'String'));
% Current = Current + slider;
set(handles.Current,'String',num2str(slider));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Current_Callback(hObject, eventdata, handles)
% hObject    handle to Current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Current = str2num(get(handles.Current,'String'));
if Current > 10
    set(handles.slider,'Value',10);
    set(handles.Current,'String',10);
    warndlg('The current is out of the range!','!!! Warning !!!');
elseif Current < -10
    set(handles.slider,'Value',-10);
    set(handles.Current,'String',-10);
    warndlg('The current is out of the range!','!!! Warning !!!');
else
    set(handles.slider,'Value',Current);
end

% Hints: get(hObject,'String') returns contents of Current as text
%        str2double(get(hObject,'String')) returns contents of Current as a double


% --- Executes during object creation, after setting all properties.
function Current_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes during object creation, after setting all properties.
function R1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to R1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Family = get(handles.Select,'UserData');
DeviceList = get(handles.Device,'UserData');
getcm_BBA(Family,DeviceList(1,:),handles);
if strcmpi(Family,'HCM')
    getbpm_BBA('BPMx',[],handles);
else
    getbpm_BBA('BPMy',[],handles);
end


% --- Executes on selection change in Method.

% Hints: contents = cellstr(get(hObject,'String')) returns Method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Method


% --- Executes during object creation, after setting all properties.
function Method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes on selection change in Reference.
function Reference_Callback(hObject, eventdata, handles)
% hObject    handle to Reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Dev = get(handles.Reference,'String');
index = get(handles.Reference,'Value');
if get(handles.H, 'Value') == 1
    getbpm_BBA('BPMx',str2num(Dev(index,:)),handles);
elseif get(handles.V, 'Value') == 1
    getbpm_BBA('BPMy',str2num(Dev(index,:)),handles);
end
set(handles.Reference,'UserData',str2num(Dev(index,:)));



% Hints: contents = cellstr(get(hObject,'String')) returns Reference contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Reference


% --- Executes during object creation, after setting all properties.
function Reference_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
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


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
slider = get(handles.slider3,'Value');
% Current = str2num(get(handles.Current,'String'));
% Current = Current + slider;
set(handles.Position,'String',num2str(slider));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Position_Callback(hObject, eventdata, handles)
% hObject    handle to Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Position = str2num(get(handles.Position,'String'));
Max = get(handles.slider3,'Max');
Min = get(handles.slider3,'Min');
if Position > Max
    set(handles.slider3,'Value',Max);
    set(handles.Position,'String',Max);
    warndlg('The position is out of the range!','!!! Warning !!!');
elseif Position < Min
    set(handles.slider3,'Value',Min);
    set(handles.Position,'String',Min);
    warndlg('The position is out of the range!','!!! Warning !!!');
else
    set(handles.slider3,'Value',Position);
end

% Hints: get(hObject,'String') returns contents of Position as text
%        str2double(get(hObject,'String')) returns contents of Position as a double


% --- Executes during object creation, after setting all properties.
function Position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in BPM.
function BPM_Callback(hObject, eventdata, handles)
% hObject    handle to BPM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Dev = get(handles.BPM,'String');
index = get(handles.BPM,'Value');
if get(handles.H, 'Value') == 1
    getbpm_BBA('BPMx',str2num(Dev(index,:)),handles);
elseif get(handles.V, 'Value') == 1
    getbpm_BBA('BPMy',str2num(Dev(index,:)),handles);
end
set(handles.BPM,'UserData',str2num(Dev(index,:)));

% Hints: contents = cellstr(get(hObject,'String')) returns BPM contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BPM


% --- Executes during object creation, after setting all properties.
function BPM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BPM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Function_Callback(hObject, eventdata, handles)
% hObject    handle to Function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function F1_Callback(hObject, eventdata, handles)
% hObject    handle to F1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.F2,'Checked','off');
set(handles.F1,'Checked','on');
set(handles.Name,'Enable','off');
set(handles.slider,'Enable','off');
set(handles.Current,'Enable','off');
set(handles.BPM,'Enable','on');
set(handles.slider3,'Enable','on');
set(handles.Position,'Enable','on');

% --------------------------------------------------------------------
function F2_Callback(hObject, eventdata, handles)
% hObject    handle to F2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.F1,'Checked','off');
set(handles.F2,'Checked','on');
set(handles.BPM,'Enable','off');
set(handles.slider3,'Enable','off');
set(handles.Position,'Enable','off');
set(handles.Name,'Enable','inactive');
set(handles.slider,'Enable','on');
set(handles.Current,'Enable','on');



function Angle_Callback(hObject, eventdata, handles)
% hObject    handle to Angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Angle as text
%        str2double(get(hObject,'String')) returns contents of Angle as a double


% --- Executes during object creation, after setting all properties.
function Angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to R1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of R1 as text
%        str2double(get(hObject,'String')) returns contents of R1 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to R1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to R2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of R2 as text
%        str2double(get(hObject,'String')) returns contents of R2 as a double


% --- Executes during object creation, after setting all properties.
function R2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to R2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to R3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of R3 as text
%        str2double(get(hObject,'String')) returns contents of R3 as a double


% --- Executes during object creation, after setting all properties.
function R3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to R3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function R4_Callback(hObject, eventdata, handles)
% hObject    handle to R4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of R4 as text
%        str2double(get(hObject,'String')) returns contents of R4 as a double


% --- Executes during object creation, after setting all properties.
function R4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to R4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function R1_Callback(hObject, eventdata, handles)
% hObject    handle to R1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of R1 as text
%        str2double(get(hObject,'String')) returns contents of R1 as a double



function R2_Callback(hObject, eventdata, handles)
% hObject    handle to R2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of R2 as text
%        str2double(get(hObject,'String')) returns contents of R2 as a double



function R3_Callback(hObject, eventdata, handles)
% hObject    handle to R3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of R3 as text
%        str2double(get(hObject,'String')) returns contents of R3 as a double


% --- Executes during object creation, after setting all properties.
function C1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function Reset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function RPS1_Callback(hObject, eventdata, handles)
% hObject    handle to RPS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RPS1 as text
%        str2double(get(hObject,'String')) returns contents of RPS1 as a double


% --- Executes during object creation, after setting all properties.
function RPS1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RPS1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RPS2_Callback(hObject, eventdata, handles)
% hObject    handle to RPS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RPS2 as text
%        str2double(get(hObject,'String')) returns contents of RPS2 as a double


% --- Executes during object creation, after setting all properties.
function RPS2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RPS2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function [r,A,x,b,m,n,esp_value,iter,ipiv,work] = householder(r,A,x,b,m,n,esp_value,iter,ipiv,work,handles)
HTFOC_true = 1;
for i=1:m
    r(i) = b(i);
end

for k=1:n
    ipiv(k)=k; hh=0; gg=0;
    for i=1:m
        hh = hh + A(i,k)*A(i,k); 
        gg = gg + A(i,k)*b(i); 
    end
    work(k,1)=hh; work(k,2)=gg;
end
if iter > n
    itmax = n;
else
    itmax = iter;
end
loop = HTFOC_true;

for k=1:itmax
    pivot =0.; kpivot = -1;
    for j=k:n
        if work(j,1) ~= 0
            pivott = work(j,2)*work(j,2)/work(j,1);
            if pivott > pivot
                kpivot = j; 
                pivot = pivott;
            end
        end
    end
    if kpivot == -1
%         loop = HTFOC_false; 
        iter = k; 
        break; 
    end
    if kpivot > k
        temp = work(k,1); work(k,1) = work(kpivot,1); work(kpivot,1) = temp;
        temp = work(k,2); work(k,2) = work(kpivot,2); work(kpivot,2) = temp;
        itemp = ipiv(k); ipiv(k) = ipiv(kpivot); ipiv(kpivot) = itemp;
        for i=1:m
            temp = A(i,k); A(i,k) = A(i,kpivot); A(i,kpivot) = temp;
        end
    end
    hh=0;
    for i=k:m
        hh = hh + A(i,k)*A(i,k);
    end
    if A(k,k) < 0
        sigma = -sqrt(hh);
    else
        sigma = sqrt(hh);
    end
    work(k,1) = - sigma;
    A(k,k) = A(k,k) + sigma;
    beta = 1./ (A(k,k)*sigma);
    for j=k+1:n
        hh=0;
        for i=k:m
            hh = hh + A(i,k)*A(i,j);
        end
        h = beta*hh;
        for i=k:m
            A(i,j) = A(i,j) - A(i,k)*h;
        end
    end
    hh=0;
    for i=k:m
        hh = hh + A(i,k)*b(i);
    end
    h = beta*hh;
    for i=k:m
        b(i) = b(i) - A(i,k)*h;
    end
    for j=k+1:n
        work(j,1) = work(j,1) - A(k,j)*A(k,j); 
        work(j,2) = work(j,2) - A(k,j)*b(k);
    end
    x(k) = b(k)/work(k,1);
    for i=k-1:-1:1
        x(i) = b(i);
        for j=i+1:k
            x(i) = x(i) - A(i,j)*x(j);
        end
        x(i) = x(i) / work(i,1);
    end
    for i=1:m
        r(i) = b(i);
    end
    for j=k:-1:1
        r(j) = 0; hh = 0;
        for i=j:m
            hh = hh + A(i,j)*r(i);
        end
        h = hh/(work(j,1)*A(j,j));
        for i=j:m
            r(i) = r(i) + A(i,j)*h;
        end
    end
    rmax = abs(r(1)); rmin = abs(r(1));
    for i=2:m
        if abs(r(i)) > rmax
            rmax = abs(r(i));
        end
        if abs(r(i)) < rmin
            rmin = abs(r(i));
        end
    end
    esp_value1 = rmax-rmin;
    if esp_value1 <= esp_value
%         loop = HTFOC_false; 
        iter = k+1; 
        break; 
    end
    
end
    if loop == HTFOC_true 
        iter = itmax;
    end
    for k=1:n
        work(k,1) = x(k); x(k) = 0;
    end
    for k=1:iter
        x(ipiv(k)) = work(k,1);
    end



function S1_Callback(hObject, eventdata, handles)
% hObject    handle to S1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S1 as text
%        str2double(get(hObject,'String')) returns contents of S1 as a double


% --- Executes during object creation, after setting all properties.
function S1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function S2_Callback(hObject, eventdata, handles)
% hObject    handle to S2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of S2 as text
%        str2double(get(hObject,'String')) returns contents of S2 as a double


% --- Executes during object creation, after setting all properties.
function S2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to S2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function esp_Callback(hObject, eventdata, handles)
% hObject    handle to esp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of esp as text
%        str2double(get(hObject,'String')) returns contents of esp as a double


% --- Executes during object creation, after setting all properties.
function esp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to esp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iter_Callback(hObject, eventdata, handles)
% hObject    handle to iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iter as text
%        str2double(get(hObject,'String')) returns contents of iter as a double


% --- Executes during object creation, after setting all properties.
function iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Set.
function Set_Callback(hObject, eventdata, handles)
% hObject    handle to Set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cm = get(handles.Set,'UserData');
if get(handles.Plane,'UserData') == 1
    setsp('HCM',cm);
    axes(handles.Graph1);
    cla;
    getbpm_BBA('BPMx',[],handles);
    axes(handles.Graph2);
    cla;
    getcm_BBA('HCM',[],handles);
else
    setsp('VCM',cm);
    axes(handles.Graph1);
    cla;
    getbpm_BBA('BPMy',[],handles);
    axes(handles.Graph2);
    cla;
    getcm_BBA('VCM',[],handles);
end


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cm = get(handles.Reset,'UserData');
if get(handles.Plane,'UserData') == 1
    setsp('HCM',cm);
    axes(handles.Graph1);
    cla;
    getbpm_BBA('BPMx',[],handles);
    axes(handles.Graph2);
    cla;
    getcm_BBA('HCM',[],handles);
else
    setsp('VCM',cm);
    axes(handles.Graph1);
    cla;
    getbpm_BBA('BPMy',[],handles);
    axes(handles.Graph2);
    cla;
    getcm_BBA('VCM',[],handles);
end
set(handles.H,'Value',0);
set(handles.V,'Value',0);
set(handles.esp,'String',0.001);
set(handles.iter,'String',10);
set(handles.uipushtool2,'UserData',[]);


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiopen;
if ~isempty(ConfigMonitor)
    DataX = ConfigMonitor.BPMx.Monitor.Data;
    DataY = ConfigMonitor.BPMy.Monitor.Data;
    set(handles.uipushtool2,'UserData', [DataX,DataY]);
end
