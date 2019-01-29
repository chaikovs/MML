function varargout = BBA(varargin)
% BBA M-file for BBA.fig
%      BBA, by itself, creates a new BBA or raises the existing
%      singleton*.
%
%      H = BBA returns the handle to a new BBA or the handle to
%      the existing singleton*.
%
%      BBA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BBA.M with the given input arguments.
%
%      BBA('Property','Value',...) creates a new BBA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BBA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BBA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BBA

% Last Modified by GUIDE v2.5 09-Apr-2010 17:57:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BBA_OpeningFcn, ...
                   'gui_OutputFcn',  @BBA_OutputFcn, ...
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


% --- Executes just before BBA is made visible.
function BBA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BBA (see VARARGIN)

% Choose default command line output for BBA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

getbpm_BBA('BPMx',[],handles);
getcm_BBA('HCM',[],handles);




function varargout = getbpm_BBA(X,Dev,handles)
if isempty(Dev)
    Dev = dev2elem(X,[1 1]);
else
    Dev = dev2elem(X,Dev);
end
DataStruct1 = getfamilydata(X);
Data1 = getpv(X);
set(handles.DataList1, 'String', [DataStruct1.CommonNames, num2str(Data1(:),'= %+.4e')]);
axes(handles.Graph1);
plot(handles.Graph1,DataStruct1.Position,Data1,'-*',DataStruct1.Position(Dev),Data1(Dev),'O','MarkerFaceColor','r');
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

set(handles.text21, 'String', DataStruct1.FamilyName);
set(handles.text23, 'String', num2str(DataStruct1.DeviceList(Dev,:),'[ %2d, %2d ]'));
set(handles.text25, 'String', num2str(Data1(Dev),'%+.4e'));

function varargout = getcm_BBA(X,Dev,handles)
if isempty(Dev)
    Dev = dev2elem(X,[1 1]);
else
    Dev = dev2elem(X,Dev);
end
DataStruct2 = getfamilydata(X);
Data2 = getpv(X);
set(handles.DataList2, 'String', [DataStruct2.CommonNames, num2str(Data2(:),'= %+.4e')]);
axes(handles.Graph2);
plot(handles.Graph2,DataStruct2.Position,Data2,'-*',DataStruct2.Position(Dev),Data2(Dev),'O','MarkerFaceColor','r');
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

set(handles.text28, 'String', DataStruct2.FamilyName);
set(handles.text30, 'String', num2str(DataStruct2.DeviceList(Dev,:),'[ %2d, %2d ]'));
set(handles.text32, 'String', num2str(Data2(Dev),'%+.4e'));

% --- Outputs from this function are returned to the command line.
function varargout = BBA_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in Q1.
function Q1_Callback(hObject, eventdata, handles)
% hObject    handle to Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Q1


% --- Executes on button press in Q2.
function Q2_Callback(hObject, eventdata, handles)
% hObject    handle to Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Q2


% --- Executes on button press in Q3.
function Q3_Callback(hObject, eventdata, handles)
% hObject    handle to Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Q3


% --- Executes on button press in Q4.
function Q4_Callback(hObject, eventdata, handles)
% hObject    handle to Q4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on button press in C1.
function C1_Callback(hObject, eventdata, handles)
% hObject    handle to C1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plane1 = get(handles.plane1, 'Value');
plane2 = get(handles.plane2, 'Value');
if (plane1 == 1)&&(plane2 == 1)
    XYPlane = 0;
elseif plane1 == 1
    XYPlane = 1;
elseif plane2 == 1
    XYPlane = 2;
end 

QuadDev = [];
DL1 = get(handles.DL1, 'Value');
DL2 = get(handles.DL2, 'Value');
DL3 = get(handles.DL3, 'Value');
DL4 = get(handles.DL4, 'Value');
DL5 = get(handles.DL5, 'Value');
DL6 = get(handles.DL6, 'Value');
DL7 = get(handles.DL7, 'Value');
DL8 = get(handles.DL8, 'Value');
DL9 = get(handles.DL9, 'Value');
DL10 = get(handles.DL10, 'Value');
DL11 = get(handles.DL11, 'Value');
DL12 = get(handles.DL12, 'Value');
if DL1 == 1
    QuadDev = cat(1,QuadDev,[1 1]);
end
if DL2 == 1
    QuadDev = cat(1,QuadDev,[1 2]);
end
if DL3 == 1
    QuadDev = cat(1,QuadDev,[2 1]);
end
if DL4 == 1
    QuadDev = cat(1,QuadDev,[2 2]);
end
if DL5 == 1
    QuadDev = cat(1,QuadDev,[3 1]);
end
if DL6 == 1
    QuadDev = cat(1,QuadDev,[3 2]);
end
if DL7 == 1
    QuadDev = cat(1,QuadDev,[4 1]);
end
if DL8 == 1
    QuadDev = cat(1,QuadDev,[4 2]);
end
if DL9 == 1
    QuadDev = cat(1,QuadDev,[5 1]);
end
if DL10 == 1
    QuadDev = cat(1,QuadDev,[5 2]);
end
if DL11 == 1
    QuadDev = cat(1,QuadDev,[6 1]);
end
if DL12 == 1
    QuadDev = cat(1,QuadDev,[6 2]);
end

Q1 = get(handles.Q1, 'Value');
Q2 = get(handles.Q2, 'Value');
Q3 = get(handles.Q3, 'Value');
Q4 = get(handles.Q4, 'Value');
if Q1 == 1
    for i = 1:size(QuadDev,1)
        [QMS1, QMS2] = Qcenter('QF1', QuadDev(i,:), XYPlane, 0, handles);
    end
end
if Q2 == 1
    for i = 1:size(QuadDev,1)
        [QMS1, QMS2] = Qcenter('QF2', QuadDev(i,:), XYPlane, 0, handles);
    end
end
if Q3 == 1
    for i = 1:size(QuadDev,1)
        [QMS1, QMS2] = Qcenter('QD1', QuadDev(i,:), XYPlane, 0, handles);
    end
end
if Q4 == 1
    for i = 1:size(QuadDev,1)
        [QMS1, QMS2] = Qcenter('QD2', QuadDev(i,:), XYPlane, 0, handles);
    end
end


% --- Executes on button press in C2.
function C2_Callback(hObject, eventdata, handles)
% hObject    handle to C2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.plane1, 'Value', 1);
set(handles.plane2, 'Value', 1);
set(handles.Q1, 'Value', 1);
set(handles.Q2, 'Value', 1);
set(handles.Q3, 'Value', 1);
set(handles.Q4, 'Value', 1);
set(handles.DL1, 'Value', 1);
set(handles.DL2, 'Value', 1);
set(handles.DL3, 'Value', 1);
set(handles.DL4, 'Value', 1);
set(handles.DL5, 'Value', 1);
set(handles.DL6, 'Value', 1);
set(handles.DL7, 'Value', 1);
set(handles.DL8, 'Value', 1);
set(handles.DL9, 'Value', 1);
set(handles.DL10, 'Value', 1);
set(handles.DL11, 'Value', 1);
set(handles.DL12, 'Value', 1);

% --- Executes on button press in C3.
function C3_Callback(hObject, eventdata, handles)
% hObject    handle to C3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% close hidden;
% BBA;
getbpm_BBA('BPMx',[],handles);
getcm_BBA('HCM',[],handles);
set(handles.plane1, 'Value', 0);
set(handles.plane2, 'Value', 0);
set(handles.Q1, 'Value', 0);
set(handles.Q2, 'Value', 0);
set(handles.Q3, 'Value', 0);
set(handles.Q4, 'Value', 0);
set(handles.DL1, 'Value', 0);
set(handles.DL2, 'Value', 0);
set(handles.DL3, 'Value', 0);
set(handles.DL4, 'Value', 0);
set(handles.DL5, 'Value', 0);
set(handles.DL6, 'Value', 0);
set(handles.DL7, 'Value', 0);
set(handles.DL8, 'Value', 0);
set(handles.DL9, 'Value', 0);
set(handles.DL10, 'Value', 0);
set(handles.DL11, 'Value', 0);
set(handles.DL12, 'Value', 0);
set(handles.P1, 'String', 0.5);
set(handles.P2, 'String', 1);
set(handles.P3, 'Value', 1);
set(handles.P4, 'Value', 1);
set(handles.P5, 'String', 1);
set(handles.P6, 'String', 5);
set(handles.text58, 'String', []);
set(handles.text60, 'String', []);
set(handles.text62, 'String', []);
DataList3 = get(handles.DataList3, 'String');
if  length(DataList3) ~= 0
    cla(handles.Graph3);
    axes(handles.Graph3);
    % hold on
    grid off
    xlabel('');
    ylabel('');
    set(handles.Graph3, 'XTick', []);
    set(handles.Graph3, 'YTick', []);
end
set(handles.DataList3, 'String', []);
set(handles.DataList3, 'Value', []);

% --- Executes on mouse press over axes background.
function Graph1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Graph1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function [QMS1, QMS2] = Qcenter(QuadFamily, QuadDev, XYPlane, FigureHandle,handles)
%QUADCENTER - Measure the magnet center of a quadrupole magnet
%  [QMS1, QMS2] = quadcenter(QuadFamily, QuadDev, XYPlane, FigureHandle)
%                     or
%  [QMS1, QMS2] = quadcenter(QMSstructure, FigureHandle)
%
%  Finds the center of an individual quadrupole magnet.
%  The data is automatically appended to quadcenter.log and 
%  saved to an individual mat file named by family, sector, and element number
%
%  INPUTS 
%  1. QuadFamily  = Family name
%  2. QuadDev     = Device list for quadrupole family
%  3. XYPlane     = 0 -> both horizontal and vertical {default}
%                   1 -> horizontal only
%                   2 -> vertical only 
%  4. FigureHandle can be a figure handle, a vector of 4 axes handles 
%                 (used by quadplot), or zero for no plots
%
%  The QuadFamily and QuadDev input get converted to a QMSstructure using quadcenterinit.  
%  One can also directly input this data structure.
%  QMSstructure = 
%         QuadFamily: Quadrupole family name, like 'QF'
%            QuadDev: Quadrupole device, like [7 1]
%          QuadDelta: Modulation amplitude in the quadrupole, like 1
%          QuadPlane: Horizontal (1) or vertical (2) plane
%         CorrFamily: Corrector magnet family, like 'HCM'
%        CorrDevList: Corrector magnet(s) using to vary the orbit in the quadrupole, like [7 1]
%          CorrDelta: Maximum change in the corrector(s), like 0.5000
%          BPMFamily: BPM family name, like 'BPMx'
%             BPMDev: BPM device next to the quadrupole, like [7 1]
%         BPMDevList: BPM device list used calculate the center and for orbit correction ([nx2 array])
%   ModulationMethod: Method for changing the quadrupole
%                         'bipolar' changes the quadrupole by +/- QuadDelta on each step
%                         'unipolar' changes the quadrupole from 0 to QuadDelta on each step
%                         'sweep' moves the quadrupole by QuadDelta at each step.  This allows for
%                                 staying on a given hysteresis branch.
%     NumberOfPoints: Number of points, like 3
%      DataDirectory: Directory to store the results.  Leave this field out or '.' will put the data
%                         in the present directory.
%       QuadraticFit: 0 = linear fit, else quadratic fit  (used by quadplot)
%      OutlierFactor: if abs(data - fit) > OutlierFactor, then remove that BPM from the center calculation [mm] (used by quadplot)
%         ExtraDelay: Extra delay added before reading the BPMs [seconds] {optional}
%
%  OUTPUTS
%  The QMSstructure input structure will get the following output fields appended to it.  
%  This structure will be output as well as saved to a file which is named based on the 
%  sector, quadrupole family name, and device number.  A log file will also be updated.
%  QMSstructure = 
%          OldCenter: Old quadrupole center (from getoffsetorbit)
%                 x1: horizonal data at quadrupole value #1
%                 x2: horizonal data at quadrupole value #2
%                 y1: vertical data at quadrupole value #1
%                 y2: vertical data at quadrupole value #2
%               Xerr: Horizonal BPM starting error
%               Yerr: Vertical  BPM starting error
%          TimeStamp: Time stamp as output by clock (6 element vector)
%          CreatedBy: 'quadcenter'
%      QMS.BPMStatus: Status of the BPMs
%         QMS.BPMSTD: Standard deviation of the BPMs (from getsigma)
%             Center: Mean of the BPM center calculations
%          CenterSTD: Standard deviation of the BPM center calculations 
%  For two planes, QMS1 is the horizontal and QMS2 is the vertical.  When only finding
%  one plane, only the first output is used.  For multiple magnets, the output is a column
%  vector containing the quadrupole center. 
%
%  NOTE
%  1. It is a good idea to have the global orbit reasonable well corrected at the start
%  2. If the quadrupole modulation system is not a simple device with one family name then
%     edit the setquad function (machine specific).
%  3. For the new BPM offsets to take effect, they must be loaded into the main AO data structure. 
%  4. This program changes the MML warning level to -2 -> Dialog Box
%     That way the measurement can be salvaged if something goes wrong
%
%  Machine specific setup:
%  1. setquad and getquad must exist for setting and getting the quadrupole current.
%     These function are often machine dependent.

%  Written by Greg Portmann



% Extra delay can be written over by the QMS.ExtraDelay field.  If this
% does not exist, then the value below is used.
ExtraDelay = 0.2; 


% Set the waitflag on power supply setpoints to wait for fresh data from the BPMs
WaitFlag = -2; 


% Record the tune at each point.
% In simulate mode the tunes are always saved unless the TUNE family does not exist.
GetTuneFlag = 0;


% Inputs
QMS1 = [];
QMS2 = [];
if nargin < 1
    FamilyList = getfamilylist;
    [tmp,i] = ismemberof(FamilyList,'QUAD');
    if ~isempty(i)
        FamilyList = FamilyList(i,:);
    end
    if size(FamilyList,1) == 1
        QuadFamily = deblank(FamilyList);
    else
        [i,ok] = listdlg('PromptString', 'Select a quadrupole family:', ...
            'SelectionMode', 'single', ...
            'ListString', FamilyList);
        if ok == 0
            return
        else
            QuadFamily = deblank(FamilyList(i,:));
        end
    end
end

if isstruct(QuadFamily)
    QMS = QuadFamily;
    XYPlane = QMS.QuadPlane;
    if QMS.QuadPlane == 1
        QMS_Horizontal = QMS;
        QMS_Vertical   = Qcenterinit(QMS.QuadFamily, QMS.QuadDev, 2, handles);
        QMS_Vertical.CorrectOrbit = QMS.CorrectOrbit;
    elseif QMS.QuadPlane == 2
        QMS_Horizontal = Qcenterinit(QMS.QuadFamily, QMS.QuadDev, 1, handles);
        QMS_Horizontal.CorrectOrbit = QMS.CorrectOrbit;
        QMS_Vertical = QMS;
    else
        error('QMS.QuadPlane must be 1 or 2 when using a QMS structure input');
    end
    if nargin >= 2 
        FigureHandle = QuadDev;
    else
        FigureHandle = [];
    end
    QuadFamily = QMS.QuadFamily;
    QuadDev    = QMS.QuadDev;
else
    if ~isfamily(QuadFamily)
        error(sprintf('Quadrupole family %s does not exist.  Make sure the middle layer had been initialized properly.',QuadFamily));
    end
    if nargin < 2
        QuadDev = editlist(getlist(QuadFamily),QuadFamily,zeros(length(getlist(QuadFamily)),1));
    end
    if nargin < 3
        ButtonNumber = menu('Which Plane?', 'Both','Horizontal Only','Vertical Only','Cancel');  
        drawnow;
        switch ButtonNumber
            case 1
                XYPlane = 0;
            case 2
                XYPlane = 1;
            case 3
                XYPlane = 2;
            otherwise
                fprintf('   quadcenter cancelled\n');
                return
        end
    end
    if nargin < 4 
        FigureHandle = [];
    end
    
    % If QuadDev is a vector
    if size(QuadDev,1) > 1
        for i = 1:size(QuadDev,1)
            if XYPlane == 0
                [Q1, Q2] = Qcenter(QuadFamily, QuadDev(i,:), XYPlane, FigureHandle);
                QMS1(i,1) = Q1.Center;
                QMS2(i,1) = Q2.Center;
            else
                [Q1] = Qcenter(QuadFamily, QuadDev(i,:), XYPlane, FigureHandle);
                QMS1(i,1) = Q1.Center;
            end
        end
        return
    end
    
    
    % Get QMS structure
    QMS_Horizontal = Qcenterinit(QuadFamily, QuadDev, 1, handles);
    QMS_Vertical   = Qcenterinit(QuadFamily, QuadDev, 2, handles);
end


% Change the MML warning level to -2 -> Dialog Box
% That way the measurement can be salvaged if something goes wrong
ErrorWarningLevel = getfamilydata('ErrorWarningLevel');
setfamilydata(-2, 'ErrorWarningLevel');


% Initialize variables
HCMFamily  = QMS_Horizontal.CorrFamily;
HCMDev     = QMS_Horizontal.CorrDevList;
DelHCM     = QMS_Horizontal.CorrDelta;
BPMxFamily = QMS_Horizontal.BPMFamily;
BPMxDev    = QMS_Horizontal.BPMDev;
BPMxDevList= QMS_Horizontal.BPMDevList;

VCMFamily  = QMS_Vertical.CorrFamily;
VCMDev     = QMS_Vertical.CorrDevList;
DelVCM     = QMS_Vertical.CorrDelta;
BPMyFamily = QMS_Vertical.BPMFamily;
BPMyDev    = QMS_Vertical.BPMDev;
BPMyDevList= QMS_Vertical.BPMDevList;

Xcenter = NaN;
Ycenter = NaN;


% Check status for BPMs next to the quadrupole and correctors used in orbit correction
HCMStatus = family2status(HCMFamily, HCMDev);

if ~isnan(HCMStatus) && any(HCMStatus==0) 
    error(sprintf('A %s corrector used in finding the center has a bad status', HCMFamily));
end
VCMStatus = family2status(VCMFamily, VCMDev);
if ~isnan(VCMStatus) && any(VCMStatus==0) 
    error(sprintf('A %s corrector used in finding the center has a bad status', VCMFamily));
end
BPMxStatus = family2status(BPMxFamily, BPMxDev);
if ~isnan(BPMxStatus) && any(BPMxStatus==0) 
    error(sprintf('The %s monitor next to the quadrupole has bad status', BPMxFamily));
end
BPMyStatus = family2status(BPMxFamily, BPMxDev);
if ~isnan(BPMyStatus) && any(BPMyStatus==0) 
    error(sprintf('The %s monitor next to the quadrupole has bad status', BPMxFamily));
end

    
% Record start directory
DirStart = pwd;


% Get the current offset orbit
Xoffset = getoffset(BPMxFamily, BPMxDev);
Yoffset = getoffset(BPMyFamily, BPMyDev);
XoffsetOld = Xoffset;
YoffsetOld = Yoffset;

% Starting correctors
HCM00 = getsp(HCMFamily, HCMDev);
VCM00 = getsp(VCMFamily, VCMDev);


% % Global orbit correction
% CM = getsp('HCM','struct');
% BPM = getx('struct');
% BPMWeight = ones(size(BPM.DeviceList,1),1);
% i = findrowindex(BPMxDev, BPM.DeviceList);
% 
% x = getoffset('BPMx');
% x = .1 * BPMWeight;
% %x(i) = -.2;
% BPMWeight(i) = 100;
% 
% setorbit(x, BPM, CM, 3, 20, BPMWeight, 'Display');


% Correct orbit to the old offsets first
if strcmpi(QMS_Horizontal.CorrectOrbit, 'yes')
    fprintf('   Correcting the orbit to the old horizontal center of %s(%d,%d)\n', QuadFamily, QuadDev); pause(0);
    if ~isnan(Xoffset)
        OrbitCorrection(Xoffset, BPMxFamily, BPMxDev, HCMFamily, HCMDev, 4);
    end
end
if strcmpi(QMS_Vertical.CorrectOrbit, 'yes')
    fprintf('   Correcting the orbit to the old vertical center of %s(%d,%d)\n', QuadFamily, QuadDev); pause(0);
    if ~isnan(Yoffset)
        OrbitCorrection(Yoffset, BPMyFamily, BPMyDev, VCMFamily, VCMDev, 4);
    end
end

%OrbitCorrection(Xoffset, BPMxFamily, BPMxDev, HCMFamily, HCMDev);
%OrbitCorrection(Yoffset, BPMyFamily, BPMyDev, VCMFamily, VCMDev);



% Algorithm
% 1.  Change the horzontal orbit in the quad
% 2.  Correct the vertical orbit
% 3.  Record the orbit
% 4.  Step the quad
% 5.  Record the orbit


% FIND HORIZONTAL OFFSET
if XYPlane==0 || XYPlane==1    
%     FigureHandle = 1;
        
    % BPM processor delay
    if isfield(QMS_Horizontal, 'ExtraDelay') 
        ExtraDelay = QMS_Horizontal.ExtraDelay;
    end

    % Get mode
    Mode = getmode(QMS_Horizontal.QuadFamily);
    
    % Record starting point
    QUAD0 = getquad(QMS_Horizontal);
    HCM0 = getsp(HCMFamily, HCMDev);
    VCM0 = getsp(VCMFamily, VCMDev);
    Xerr = getam(BPMxFamily, BPMxDev) - Xoffset;
    Yerr = getam(BPMyFamily, BPMyDev) - Yoffset;
    xstart = getam(BPMxFamily, BPMxDevList);
    ystart = getam(BPMyFamily, BPMyDevList);

    QMS_Horizontal.Orbit0 = getam(BPMxFamily, BPMxDevList, 'Struct');
    
    [tmp, iNotFound] = findrowindex(BPMxDev, BPMxDevList);
    if ~isempty(iNotFound)
        setsp(HCMFamily, HCM00, HCMDev, 0);
        setsp(VCMFamily, VCM00, VCMDev, 0);
        error('BPM at the quadrupole not found in the BPM device list');
    end
      
    DelQuad = QMS_Horizontal.QuadDelta;
    N = abs(round(QMS_Horizontal.NumberOfPoints));
    if N < 1
        error('The number of points must be 2 or more.');
    end
    
   
    fprintf('   Finding horizontal center of %s(%d,%d)\n', QuadFamily, QuadDev);
    fprintf('   Starting orbit error: %s(%d,%d)=%f , %s(%d,%d)=%f %s\n', BPMxFamily, BPMxDev, Xerr, BPMyFamily, BPMyDev, Yerr, QMS_Horizontal.Orbit0.UnitsString);
    if strcmpi(QMS_Horizontal.ModulationMethod, 'bipolar')
        fprintf('   Quadrupole starting current = %.3f, modulate by +/- %.3f\n', getquad(QMS_Horizontal), DelQuad);
    elseif strcmpi(QMS_Horizontal.ModulationMethod, 'unipolar')
        fprintf('   Quadrupole starting current = %.3f, modulate by 0 to %.3f\n', getquad(QMS_Horizontal), DelQuad);
    elseif strcmpi(QMS_Horizontal.ModulationMethod, 'sweep')
        fprintf('   Quadrupole starting current = %.3f, sweep by %.3f on each step\n', getquad(QMS_Horizontal), DelQuad);        
    else
        % Reset or error
        setsp(HCMFamily, HCM00, HCMDev, 0);
        setsp(VCMFamily, VCM00, VCMDev, 0);
        setquad(QMS_Horizontal, QUAD0, 0);
        cd(DirStart);
        error('Unknown ModulationMethod in the QMS input structure (likely a problem with quadcenterinit)');
    end
    pause(0);
    
    % Establish a hysteresis loop
    if strcmpi(QMS_Horizontal.ModulationMethod, 'bipolar')
        fprintf('   Establishing a hysteresis loop on the quadrupole (bi-polar case)\n'); pause(0);
        setquad(QMS_Horizontal, DelQuad+QUAD0, -1);
        getbpm_BBA('BPMx',BPMxDev,handles);
        setquad(QMS_Horizontal,-DelQuad+QUAD0, -1);
        getbpm_BBA('BPMx',BPMxDev,handles);
        setquad(QMS_Horizontal, DelQuad+QUAD0, -1);
        getbpm_BBA('BPMx',BPMxDev,handles);
        setquad(QMS_Horizontal,-DelQuad+QUAD0, -1);
        getbpm_BBA('BPMx',BPMxDev,handles);
        setquad(QMS_Horizontal,         QUAD0, -1);
        getbpm_BBA('BPMx',BPMxDev,handles);
    elseif strcmpi(QMS_Horizontal.ModulationMethod, 'unipolar')
        fprintf('   Establishing a hysteresis loop on the quadrupole (uni-polar case)\n'); pause(0);
        setquad(QMS_Horizontal, DelQuad+QUAD0, -1);
        getbpm_BBA('BPMx',BPMxDev,handles);
        setquad(QMS_Horizontal,         QUAD0, -1);
        getbpm_BBA('BPMx',BPMxDev,handles);
        setquad(QMS_Horizontal, DelQuad+QUAD0, -1);
        getbpm_BBA('BPMx',BPMxDev,handles);
        setquad(QMS_Horizontal,         QUAD0, -1);
        getbpm_BBA('BPMx',BPMxDev,handles);
    end
    
    
    % Corrector step size
    DelHCM = str2num(get(handles.P1, 'String'));
    CorrStep = 2 * DelHCM / (N-1);

    
    % Start the corrector a little lower first for hysteresis reasons 
    %stepsp(HCMFamily, -1.0*DelHCM, HCMDev, -1);
    stepsp(HCMFamily, -1.2*DelHCM, HCMDev, -1);
    stepsp(HCMFamily,   .2*DelHCM, HCMDev, WaitFlag); 

    
    % Main horizontal data loop
    clear DCCT
    for i = 1:N
        getbpm_BBA('BPMx',BPMxDev,handles);
        getcm_BBA('HCM',HCMDev,handles);
        % Step the horizontal orbit
        if i ~= 1
            stepsp(HCMFamily, CorrStep, HCMDev, WaitFlag);
            getbpm_BBA('BPMx',BPMxDev,handles);
            getcm_BBA('HCM',HCMDev,handles);
        end
        
        fprintf('   %d. %s(%d,%d) sp/am = %+.4f/%+.4f, %s(%d,%d) = %+.5f %s\n', i, HCMFamily, HCMDev(1,:), getsp(HCMFamily, HCMDev(1,:)), getam(HCMFamily, HCMDev(1,:)),  BPMxFamily, BPMxDev, getam(BPMxFamily, BPMxDev), QMS_Horizontal.Orbit0.UnitsString); pause(0);  
        
        % If correcting the orbit, then recorrect the vertical center now
        if strcmpi(QMS_Horizontal.CorrectOrbit, 'yes')
           % Correct the vertical orbit
           OrbitCorrection(Yoffset, BPMyFamily, BPMyDev, VCMFamily, VCMDev, 4);
        end
        
        if strcmpi(QMS_Horizontal.ModulationMethod, 'sweep')
            % One directional sweep of the quadrupole
            sleep(ExtraDelay);
            x1(:,i) = getam(BPMxFamily, BPMxDevList);
            y1(:,i) = getam(BPMyFamily, BPMyDevList);
            x0(:,i) = x1(:,i);
            y0(:,i) = y1(:,i);
           
            if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
                QMS_Horizontal.Tune1(:,i) = gettune;
            end

            setquad(QMS_Horizontal, i*DelQuad+QUAD0, WaitFlag);
            sleep(ExtraDelay);

            % If correcting the orbit, then recorrect the horizontal center now
            if strcmpi(QMS_Horizontal.CorrectOrbit, 'yes')
                % Correct the vertical orbit
                OrbitCorrection(Yoffset, BPMyFamily, BPMyDev, VCMFamily, VCMDev, 4);
                sleep(ExtraDelay);
            end

            x2(:,i) = getam(BPMxFamily, BPMxDevList);
            y2(:,i) = getam(BPMyFamily, BPMyDevList);
            
            if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
                QMS_Horizontal.Tune2(:,i) = gettune;
            end
   
        elseif strcmpi(QMS_Horizontal.ModulationMethod, 'bipolar')
            % Modulate the quadrupole
            sleep(ExtraDelay);
            x0(:,i) = getam(BPMxFamily, BPMxDevList);
            y0(:,i) = getam(BPMyFamily, BPMyDevList);
            setquad(QMS_Horizontal, DelQuad+QUAD0, WaitFlag);
            sleep(ExtraDelay);

            % If correcting the orbit, then recorrect the horizontal center now
            if strcmpi(QMS_Horizontal.CorrectOrbit, 'yes')
                % Correct the vertical orbit
                OrbitCorrection(Yoffset, BPMyFamily, BPMyDev, VCMFamily, VCMDev, 4);
                sleep(ExtraDelay);
            end

            x1(:,i) = getam(BPMxFamily, BPMxDevList);
            y1(:,i) = getam(BPMyFamily, BPMyDevList);
            
            if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
                QMS_Horizontal.Tune1(:,i) = gettune;
            end

            setquad(QMS_Horizontal,-DelQuad+QUAD0, WaitFlag);
            sleep(ExtraDelay);

            % If correcting the orbit, then recorrect the horizontal center now
            if strcmpi(QMS_Horizontal.CorrectOrbit, 'yes')
                % Correct the vertical orbit
                OrbitCorrection(Yoffset, BPMyFamily, BPMyDev, VCMFamily, VCMDev, 4);
                sleep(ExtraDelay);
            end

            x2(:,i) = getam(BPMxFamily, BPMxDevList);
            y2(:,i) = getam(BPMyFamily, BPMyDevList);
            
            if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
                QMS_Horizontal.Tune2(:,i) = gettune;
            end

            setquad(QMS_Horizontal, QUAD0, WaitFlag);
        
        elseif strcmpi(QMS_Horizontal.ModulationMethod, 'unipolar')
            % Modulate the quadrupole
            sleep(ExtraDelay);
            x1(:,i) = getam(BPMxFamily, BPMxDevList);
            y1(:,i) = getam(BPMyFamily, BPMyDevList);
            x0(:,i) = x1(:,i);
            y0(:,i) = y1(:,i);
            
            if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
                QMS_Horizontal.Tune1(:,i) = gettune;
            end

            setquad(QMS_Horizontal, DelQuad+QUAD0, WaitFlag);
            sleep(ExtraDelay);

            % If correcting the orbit, then recorrect the horizontal center now
            if strcmpi(QMS_Horizontal.CorrectOrbit, 'yes')
                % Correct the vertical orbit
                OrbitCorrection(Yoffset, BPMyFamily, BPMyDev, VCMFamily, VCMDev, 4);
                sleep(ExtraDelay);
            end

            x2(:,i) = getam(BPMxFamily, BPMxDevList);
            y2(:,i) = getam(BPMyFamily, BPMyDevList);
            
            if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
                QMS_Horizontal.Tune2(:,i) = gettune;
            end

            setquad(QMS_Horizontal, QUAD0, WaitFlag);
        end

        DCCT(i) = getdcct;
    end

    % Get the horizontal data filename and save the data
    % Append data and time
    FileName = ['s', num2str(QuadDev(1,1)), QuadFamily, num2str(QuadDev(1,2)), 'h1'];
    FileName = appendtimestamp(FileName, clock);

    % Use a version number
    %i=1;
    %FileName = ['s', num2str(QuadDev(1,1)), QuadFamily, num2str(QuadDev(1,2)), 'h', num2str(i)];
    %while exist([FileName,'.mat'], 'file')
    %    i = i + 1;
    %    FileName = ['s', num2str(QuadDev(1,1)), QuadFamily, num2str(QuadDev(1,2)), 'h', num2str(i)];
    %end
    
    QMS = QMS_Horizontal;
    QMS.QuadPlane = 1;
    
    QMS.OldCenter = Xoffset;
    QMS.XOffsetOld = XoffsetOld;
    QMS.YOffsetOld = YoffsetOld;
    
    QMS.xstart = xstart;
    QMS.ystart = ystart;
    
    QMS.x0 = x0;
    QMS.x1 = x1;
    QMS.x2 = x2;
    QMS.y0 = y0;
    QMS.y1 = y1;
    QMS.y2 = y2;
    QMS.Xerr = Xerr;
    QMS.Yerr = Yerr;
    QMS.TimeStamp = clock;
    QMS.DCCT = DCCT;
    QMS.DataDescriptor = 'Quadrupole Center';
    QMS.CreatedBy = 'Qcenter';
    
    % Get and store the BPM status and standard deviation (to be used by the center calculation routine)
    QMS.BPMStatus = family2status(BPMxFamily, BPMxDevList);
    N = getbpmaverages(BPMxDevList);
    QMS.BPMSTD = getsigma(BPMxFamily, BPMxDevList, N);

    % Set up figures, plot and find horizontal center
    try
        if isempty(FigureHandle)
            QMS = quadplot_BBA(QMS,[],[],handles);
        else
            QMS = quadplot_BBA(QMS, FigureHandle,[],handles);
        end
        drawnow;
    catch
        fprintf('\n%s\n', lasterr);
    end
    QMS1 = QMS;

    % Save the horizontal data
    if isfield(QMS_Horizontal, 'DataDirectory')
        [FinalDir, ErrorFlag] = gotodirectory(QMS_Horizontal.DataDirectory);
    end
    QMS.DataDirectory = pwd;
    save(FileName, 'QMS');
    fprintf('   Data saved to file %s in directory %s\n\n', FileName, QMS.DataDirectory);
    DataList3 = get(handles.DataList3, 'String');
    if isempty(DataList3)
        set(handles.DataList3, 'String', FileName);
    else
        DataList3 = cat(1,DataList3,FileName);
        set(handles.DataList3, 'String', DataList3);
    end
    
    % Output data to file
    fid1 = fopen('quadcenter.log','at');
    time=clock;
    fprintf(fid1, '%s   %d:%d:%2.0f \n', date, time(4),time(5),time(6));
    fprintf(fid1, 'Data saved to file %s (%s)\n', FileName, QMS.DataDirectory);
    fprintf(fid1, '%s(%d,%d) %s(%d,%d) = %f (+/- %f) [%s]\n\n', QuadFamily, QuadDev, BPMxFamily, BPMxDev, QMS.Center, QMS.CenterSTD, QMS_Horizontal.Orbit0.UnitsString);
    fclose(fid1);
    cd(DirStart);

    % Change the offset orbit to the new center so that the vertical plane uses it
    Xoffset = QMS.Center;
    
    % Restore magnets their starting points (correctors to values after orbit correction)
    setsp(HCMFamily, HCM0, HCMDev, WaitFlag);
    setsp(VCMFamily, VCM0, VCMDev, WaitFlag);
    setquad(QMS_Horizontal, QUAD0, WaitFlag);
    getbpm_BBA('BPMx',BPMxDev,handles);
    getcm_BBA('HCM',HCMDev,handles);
    sleep(ExtraDelay);
    
    if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
        % Print the tune information
        fprintf('   Tune and tune difference for the 1st points in the merit function (QMS.Tune1): \n');
        fprintf('   %8.5f', QMS.Tune1(1,:));
        fprintf('  Horizontal\n');
        fprintf('   %8.5f', QMS.Tune1(2,:));
        fprintf('  Vertical\n');
        fprintf('   ===================================================\n');
        fprintf('   %8.5f', diff(QMS.Tune1));
        fprintf('  Difference \n\n');
        
        fprintf('   Tune and tune difference for the 2nd points in the merit function (QMS.Tune2): \n');
        fprintf('   %8.5f', QMS.Tune2(1,:));
        fprintf('  Horizontal\n');
        fprintf('   %8.5f', QMS.Tune2(2,:));
        fprintf('  Vertical\n');
        fprintf('   ===================================================\n');
        fprintf('   %8.5f', diff(QMS.Tune2));
        fprintf('  Difference\n\n');

        dTune1 = diff(QMS.Tune1);
        dTune2 = diff(QMS.Tune2);
        
        if any(sign(dTune1/dTune1(1))==-1)
            fprintf('   Tune change sign!!!\n');            
        end
        
        if any(abs(dTune1) < .025) || any(abs(dTune2) < .025)
            fprintf('   Horizontal and vertical tunes seem too close.\n');
        end
        
        set(handles.text58,'String',QMS1.QuadFamily);
        set(handles.text60,'String',num2str(QMS1.QuadDev(1,:),'[ %2d, %2d ]'));
        set(handles.text62,'String',num2str(QMS1.Center,'%+.4e'));
    end    
end



% FIND VERTICAL OFFSET
if XYPlane==0 || XYPlane==2    
%     FigureHandle = 1;

    % BPM processor delay
    if isfield(QMS_Vertical, 'ExtraDelay')
        ExtraDelay = QMS_Vertical.ExtraDelay;
    end

    % Get mode
    Mode = getmode(QMS_Horizontal.QuadFamily);
    
    % Record starting point
    QUAD0 = getquad(QMS_Vertical);
    HCM0 = getsp(HCMFamily, HCMDev);
    VCM0 = getsp(VCMFamily, VCMDev);
    Xerr = getam(BPMxFamily, BPMxDev) - Xoffset;
    Yerr = getam(BPMyFamily, BPMyDev) - Yoffset;
    xstart = getam(BPMxFamily, BPMxDevList);
    ystart = getam(BPMyFamily, BPMyDevList);
    
    QMS_Vertical.Orbit0 = getam(BPMxFamily, BPMxDevList, 'Struct');

    [tmp, iNotFound] = findrowindex(BPMyDev, BPMyDevList);
    if ~isempty(iNotFound)
        setsp(HCMFamily, HCM00, HCMDev, 0);
        setsp(VCMFamily, VCM00, VCMDev, 0);
        error('BPM at the quadrupole not found in the BPM device list');
    end

    DelQuad = QMS_Vertical.QuadDelta;
    N = abs(round(QMS_Vertical.NumberOfPoints));
    if N < 1
        error('The number of points must be 2 or more.');
    end

    fprintf('   Finding vertical center of %s(%d,%d)\n', QuadFamily, QuadDev);
    fprintf('   Starting orbit error: %s(%d,%d)=%f , %s(%d,%d)=%f %s\n', BPMxFamily, BPMxDev, Xerr, BPMyFamily, BPMyDev, Yerr, QMS_Vertical.Orbit0.UnitsString);
    if strcmpi(QMS_Vertical.ModulationMethod, 'bipolar')
        fprintf('   Quadrupole starting current = %.3f, modulate by +/- %.3f\n', getquad(QMS_Vertical), DelQuad);
    elseif strcmpi(QMS_Vertical.ModulationMethod, 'unipolar')
        fprintf('   Quadrupole starting current = %.3f, modulate by 0 to %.3f\n', getquad(QMS_Vertical), DelQuad);
    elseif strcmpi(QMS_Vertical.ModulationMethod, 'sweep')
        fprintf('   Quadrupole starting current = %.3f, sweep by %.3f on each step\n', getquad(QMS_Vertical), DelQuad);
    else
        setsp(HCMFamily, HCM00, HCMDev, 0);
        setsp(VCMFamily, VCM00, VCMDev, 0);
        setquad(QMS_Vertical, QUAD0, 0);
        cd(DirStart);
        error('Unknown ModulationMethod in the QMS input structure (likely a problem with quadcenterinit)');
    end
    pause(0);
    
    
    % Establish a hysteresis loop (if not already done, or if the horizontal plane was sweep)
    if XYPlane == 2 || strcmpi(QMS_Horizontal.ModulationMethod, 'sweep')
        if strcmpi(QMS_Vertical.ModulationMethod, 'bipolar')
            fprintf('   Establishing a hysteresis loop on the quadrupole (bi-polar case)\n'); pause(0);
            setquad(QMS_Vertical, DelQuad+QUAD0, -1);
            getbpm_BBA('BPMy',BPMxDev,handles);
            setquad(QMS_Vertical,-DelQuad+QUAD0, -1);
            getbpm_BBA('BPMy',BPMxDev,handles);
            setquad(QMS_Vertical, DelQuad+QUAD0, -1);
            getbpm_BBA('BPMy',BPMxDev,handles);
            setquad(QMS_Vertical,-DelQuad+QUAD0, -1);
            getbpm_BBA('BPMy',BPMxDev,handles);
            setquad(QMS_Vertical,         QUAD0, -1);
            getbpm_BBA('BPMy',BPMxDev,handles);
        elseif strcmpi(QMS_Vertical.ModulationMethod, 'unipolar')
            fprintf('   Establishing a hysteresis loop on the quadrupole (uni-polar case)\n'); pause(0);
            setquad(QMS_Vertical, DelQuad+QUAD0, -1);
            getbpm_BBA('BPMy',BPMxDev,handles);
            setquad(QMS_Vertical,         QUAD0, -1);
            getbpm_BBA('BPMy',BPMxDev,handles);
            setquad(QMS_Vertical, DelQuad+QUAD0, -1);
            getbpm_BBA('BPMy',BPMxDev,handles);
            setquad(QMS_Vertical,         QUAD0, -1);
            getbpm_BBA('BPMy',BPMxDev,handles);
        end
    end
    

    % Corrector step size
    DelVCM = str2num(get(handles.P1, 'String'));
    CorrStep = 2 * DelVCM / (N-1);

    
    % Start the corrector a little lower first for hysteresis reasons 
    stepsp(VCMFamily, -1.2*DelVCM, VCMDev, -1);
    stepsp(VCMFamily,   .2*DelVCM, VCMDev, WaitFlag);


%     Debug
%     setquad(QMS_Vertical, DelQuad+QUAD0, WaitFlag);
%     QUAD0 = getquad(QMS_Vertical);
%     Xstart = getam(BPMxFamily, BPMxDev)
    

    clear DCCT
    for i = 1:N
        getbpm_BBA('BPMy',BPMxDev,handles);
        getcm_BBA('VCM',VCMDev,handles);
        % Step the vertical orbit
        if i ~= 1
            stepsp(VCMFamily, CorrStep, VCMDev, WaitFlag);
            getbpm_BBA('BPMy',BPMxDev,handles);
            getcm_BBA('VCM',VCMDev,handles);
        end

        fprintf('   %d. %s(%d,%d) sp/am = %+.4f/%+.4f, %s(%d,%d) = %+.5f %s\n', i, VCMFamily, VCMDev(1,:), getsp(VCMFamily, VCMDev(1,:)), getam(VCMFamily, VCMDev(1,:)),  BPMyFamily, BPMyDev, getam(BPMyFamily, BPMyDev), QMS_Vertical.Orbit0.UnitsString); pause(0);
        
        
        % If correcting the orbit, then recorrect the horizontal center now
        if strcmpi(QMS_Vertical.CorrectOrbit, 'yes')
           % Correct the horizontal orbit
           OrbitCorrection(Xoffset, BPMxFamily, BPMxDev, HCMFamily, HCMDev, 4);
        end

               
        if strcmpi(QMS_Vertical.ModulationMethod, 'sweep')
            % One dimensional sweep of the quadrupole
            sleep(ExtraDelay);
            x1(:,i) = getam(BPMxFamily, BPMxDevList);
            y1(:,i) = getam(BPMyFamily, BPMyDevList);
            x0(:,i) = x1(:,i);
            y0(:,i) = y1(:,i);
            
            if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
                QMS_Vertical.Tune1(:,i) = gettune;
            end

            setquad(QMS_Vertical, i*DelQuad+QUAD0, WaitFlag);
            sleep(ExtraDelay);

            % If correcting the orbit, then recorrect the horizontal center now
            if strcmpi(QMS_Vertical.CorrectOrbit, 'yes')
                % Correct the horizontal orbit
                OrbitCorrection(Xoffset, BPMxFamily, BPMxDev, HCMFamily, HCMDev, 4);
                sleep(ExtraDelay);
            end

            x2(:,i) = getam(BPMxFamily, BPMxDevList);
            y2(:,i) = getam(BPMyFamily, BPMyDevList);
            
            if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
                QMS_Vertical.Tune2(:,i) = gettune;
            end

        elseif strcmpi(QMS_Vertical.ModulationMethod, 'bipolar')
            % Modulate the quadrupole
            sleep(ExtraDelay);
            x0(:,i) = getam(BPMxFamily, BPMxDevList);
            y0(:,i) = getam(BPMyFamily, BPMyDevList);
            setquad(QMS_Vertical, DelQuad+QUAD0, WaitFlag);
            sleep(ExtraDelay);

            % If correcting the orbit, then recorrect the horizontal center now
            if strcmpi(QMS_Vertical.CorrectOrbit, 'yes')
                % Correct the horizontal orbit
                OrbitCorrection(Xoffset, BPMxFamily, BPMxDev, HCMFamily, HCMDev, 4);
                sleep(ExtraDelay);
            end

            x1(:,i) = getam(BPMxFamily, BPMxDevList);
            y1(:,i) = getam(BPMyFamily, BPMyDevList);
            
            if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
                QMS_Vertical.Tune1(:,i) = gettune;
            end

            setquad(QMS_Vertical,-DelQuad+QUAD0, WaitFlag);
            sleep(ExtraDelay);

            % If correcting the orbit, then recorrect the horizontal center now
            if strcmpi(QMS_Vertical.CorrectOrbit, 'yes')
                % Correct the horizontal orbit
                OrbitCorrection(Xoffset, BPMxFamily, BPMxDev, HCMFamily, HCMDev, 4);
                sleep(ExtraDelay);
            end

            x2(:,i) = getam(BPMxFamily, BPMxDevList);
            y2(:,i) = getam(BPMyFamily, BPMyDevList);
            
            if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
                QMS_Vertical.Tune2(:,i) = gettune;
            end

            setquad(QMS_Vertical, QUAD0, WaitFlag);
            
        elseif strcmpi(QMS_Vertical.ModulationMethod, 'unipolar')
            % Modulate the quadrupole
            sleep(ExtraDelay);
            x1(:,i) = getam(BPMxFamily, BPMxDevList);
            y1(:,i) = getam(BPMyFamily, BPMyDevList);
            x0(:,i) = x1(:,i);
            y0(:,i) = y1(:,i);
            
            if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
                QMS_Vertical.Tune1(:,i) = gettune;
            end

            setquad(QMS_Vertical, DelQuad+QUAD0, WaitFlag);
            sleep(ExtraDelay);

            % If correcting the orbit, then recorrect the horizontal center now
            if strcmpi(QMS_Vertical.CorrectOrbit, 'yes')
                % Correct the horizontal orbit
                OrbitCorrection(Xoffset, BPMxFamily, BPMxDev, HCMFamily, HCMDev, 4);
                sleep(ExtraDelay);
            end

            x2(:,i) = getam(BPMxFamily, BPMxDevList);
            y2(:,i) = getam(BPMyFamily, BPMyDevList);
            
            if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
                QMS_Vertical.Tune2(:,i) = gettune;
            end

            setquad(QMS_Vertical, QUAD0, WaitFlag);
        end
        
        DCCT(i) = getdcct;
    end

    setsp(VCMFamily, VCM0, VCMDev, -1);
    getbpm_BBA('BPMy',BPMxDev,handles);
    getcm_BBA('VCM',VCMDev,handles);
    sleep(ExtraDelay);
    
    % Get the vertical data filename and save the data
    % Append data and time
    FileName = ['s', num2str(QuadDev(1,1)), QuadFamily, num2str(QuadDev(1,2)), 'v1'];
    FileName = appendtimestamp(FileName, clock);

    %% Append version number
    %i=1;
    %FileName = ['s', num2str(QuadDev(1,1)), QuadFamily, num2str(QuadDev(1,2)), 'v', num2str(i)];
    %while exist([FileName,'.mat'], 'file')
    %    i = i + 1;
    %    FileName = ['s', num2str(QuadDev(1,1)), QuadFamily, num2str(QuadDev(1,2)), 'v', num2str(i)];
    %end

    QMS = QMS_Vertical;
    QMS.QuadPlane = 2;

    QMS.OldCenter = Yoffset;
    QMS.XOffsetOld = XoffsetOld;
    QMS.YOffsetOld = YoffsetOld;
    
    QMS.xstart = xstart;
    QMS.ystart = ystart;
    QMS.x0 = x0;
    QMS.x1 = x1;
    QMS.x2 = x2;
    QMS.y0 = y0;
    QMS.y1 = y1;
    QMS.y2 = y2;
    QMS.Xerr = Xerr;
    QMS.Yerr = Yerr;
    QMS.TimeStamp = clock;
    QMS.DCCT = DCCT;
    QMS.DataDescriptor = 'Quadrupole Center';
    QMS.CreatedBy = 'Qcenter';

    % Get and store the BPM status and standard deviation (to be used by the center calculation routine)
    QMS.BPMStatus = family2status(BPMyFamily, BPMyDevList);
    N = getbpmaverages(BPMyDevList);
    QMS.BPMSTD = getsigma(BPMyFamily, BPMyDevList, N);

    
    % Set up figures, plot and find vertical center
    if isempty(FigureHandle)
        QMS = quadplot_BBA(QMS,[],[],handles);
    else
        QMS = quadplot_BBA(QMS, FigureHandle,[],handles);
    end
    drawnow;

    if XYPlane==0
        QMS2 = QMS;
    else
        QMS1 = QMS;
    end
    
    
    % Save the vertical data 
    if isfield(QMS_Vertical,'DataDirectory')  
        [FinalDir, ErrorFlag] = gotodirectory(QMS_Vertical.DataDirectory);
    end
    QMS.DataDirectory = pwd;    
    save(FileName, 'QMS');
    fprintf('   Data saved to file %s in directory %s\n\n', FileName, QMS.DataDirectory);
    DataList3 = get(handles.DataList3, 'String');
    if isempty(DataList3)
        set(handles.DataList3, 'String', FileName);
    else
        DataList3 = cat(1,DataList3,FileName);
        set(handles.DataList3, 'String', DataList3);
    end
    
    % Output data to log file
    fid1 = fopen('quadcenter.log','at');
    time=clock;
    fprintf(fid1, '%s   %d:%d:%2.0f \n', date, time(4),time(5),time(6));
    fprintf(fid1, 'Data saved to file %s (%s)\n', FileName, QMS.DataDirectory);
    fprintf(fid1, '%s(%d,%d) %s(%d,%d) = %f (+/- %f) [%s]\n\n', QuadFamily, QuadDev, BPMyFamily, BPMyDev, QMS.Center, QMS.CenterSTD);
    fclose(fid1);
    cd(DirStart);
    

    if (GetTuneFlag || strcmpi(Mode, 'Simulator')) && isfamily('TUNE')
        % Print the tune information
        fprintf('   Tune and tune difference for the 1st points in the merit function (QMS.Tune1): \n');
        fprintf('   %8.5f', QMS.Tune1(1,:));
        fprintf('  Horizontal\n');
        fprintf('   %8.5f', QMS.Tune1(2,:));
        fprintf('  Vertical\n');
        fprintf('   ===================================================\n');
        fprintf('   %8.5f', diff(QMS.Tune1));
        fprintf('  Difference \n\n');
        
        fprintf('   Tune and tune difference for the 2nd points in the merit function (QMS.Tune2): \n');
        fprintf('   %8.5f', QMS.Tune2(1,:));
        fprintf('  Horizontal\n');
        fprintf('   %8.5f', QMS.Tune2(2,:));
        fprintf('  Vertical\n');
        fprintf('   ===================================================\n');
        fprintf('   %8.5f', diff(QMS.Tune2));
        fprintf('  Difference\n\n');

        dTune1 = diff(QMS.Tune1);
        dTune2 = diff(QMS.Tune2);
        
        if any(sign(dTune1/dTune1(1))==-1)
            fprintf('   Tune change sign!!!\n');            
        end
        
        if any(abs(dTune1) < .025) || any(abs(dTune2) < .025)
            fprintf('   Horizontal and vertical tunes seem too close.\n');
        end
        if isempty(QMS2)
            QMS2 = QMS1;
        end
        set(handles.text58,'String',QMS2.QuadFamily);
        set(handles.text60,'String',num2str(QMS2.QuadDev(1,:),'[ %2d, %2d ]'));
        set(handles.text62,'String',num2str(QMS2.Center,'%+.4e'));
    end
end


% Restore magnets their starting points
setsp(HCMFamily, HCM00, HCMDev, 0);
setsp(VCMFamily, VCM00, VCMDev, 0);
setquad(QMS_Horizontal, QUAD0, 0);


% Restore the MML error warning level
setfamilydata(ErrorWarningLevel, 'ErrorWarningLevel');


%%%%%%%%%%%%%%%%%%%%%
% End Main Function %
%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%
% Sub-Functions %
%%%%%%%%%%%%%%%%%

function OrbitCorrection(GoalOrbit, BPMFamily, BPMDevList, CMFamily, CMDevList, Iter)

WaitFlag = -2;

if nargin < 6
    Iter = 3;
end

if size(CMDevList,1) > 1
    % Pick the corrector based on the most effective corrector in the response matrix
    % This routine does not handle local bumps at the moment
    R = getrespmat(BPMFamily, BPMDevList, CMFamily, [], 'Struct', 'Physics');
    [i, iNotFound] = findrowindex(BPMDevList, R.Monitor.DeviceList);
    m = R.Data(i,:);
    [MaxValue, j] = max(abs(m));
    CMDevList = R.Actuator.DeviceList(j,:);
end

s = getrespmat(BPMFamily, BPMDevList, CMFamily, CMDevList);
if any(any(isnan(s)))
    error('Response matrix has a NaN');
end


for i = 1:Iter
    x = getam(BPMFamily, BPMDevList) - GoalOrbit;
    
    CorrectorSP = -(x./s);
    CorrectorSP = CorrectorSP(:);
    
    % Check limits
    MinSP = minsp(CMFamily, CMDevList);
    MaxSP = maxsp(CMFamily, CMDevList);
    if any(getsp(CMFamily,CMDevList)+CorrectorSP > MaxSP-5) 
        fprintf('   Orbit not corrected because a maximum power supply limit would have been exceeded!\n');
        return;
    end
    if any(getsp(CMFamily,CMDevList)+CorrectorSP < MinSP+5) 
        fprintf('   Orbit not corrected because a minimum power supply limit would have been exceeded!\n');
        return;
    end
    
    stepsp(CMFamily, CorrectorSP, CMDevList, WaitFlag);
    
    %x = getam(BPMFamily, BPMDevList) - GoalOrbit
end


function QMS = Qcenterinit(QuadFamily, QuadDev, QuadPlane, handles)
% QMS = Qcenterinit(Family, Device, QuadPlane, handles)
%
% QuadFamily = Quadrupole family
% QuadDev    = Quadrupole device 
% QuadPlane  = Plane (1=horizontal {default}, 2=vertical)
%
% QMS structure contains fields:
% QMS.QuadFamily
% QMS.QuadDev
% QMS.QuadDelta
% QMS.QuadPlane
% QMS.BPMFamily
% QMS.BPMDev
% QMS.BPMDevList
% QMS.CorrFamily
% QMS.CorrDevList             % Often one magnet but bumps or anything else is fine
% QMS.CorrDelta               % Scale factor for each magnet in CorrDevList
% QMS.DataDirectory           % From AD or '.'
% QMS.QuadraticFit = 1;       % 1=quadratic fit, else linear fit
% QMS.OutlierFactor = 1;      % if abs(data - fit) > OutlierFactor * BPMstd, then remove that BPM [mm]
% QMS.NumberOfPoints = 3;
% QMS.ModulationMethod = 'bipolar'
% QMS.CorrectOrbit 'yes' or 'no'
% QMS.CreatedBy


% Change in quadrupole strength from it's present value
DeltaQuadFraction = .02;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input checking and defaults %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
QMS = [];
if nargin < 1
    FamilyList = getfamilylist;
    [tmp,i] = ismemberof(FamilyList,'QUAD');
    if ~isempty(i)
        FamilyList = FamilyList(i,:);
    end
    [i,ok] = listdlg('PromptString', 'Select a quadrupole family', ...
        'SelectionMode', 'single', ...
        'ListString', FamilyList);
    if ok == 0
        return
    else
        QuadFamily = deblank(FamilyList(i,:));
    end
end
if ~isfamily(QuadFamily)
    error(sprintf('Quadrupole family %s does not exist.  Make sure the middle layer had been initialized properly.',QuadFamily));
end
if nargin < 2
    QuadDev = editlist(getlist(QuadFamily),QuadFamily,zeros(length(getlist(QuadFamily)),1));
    if isempty(QuadDev)
        return
    end
end
if nargin < 3
    %QuadPlane = 1;  % Horizontal default
    ButtonNumber = menu('Which Plane?', 'Horizontal', 'Vertical', 'Cancel');
    drawnow;
    switch ButtonNumber
        case 1
            QuadPlane = 1;
        case 2
            QuadPlane = 2;
        otherwise
            fprintf('   Qcenterinit cancelled');
            return
    end
end


% Initialize the QMS structure
QMS.QuadPlane  = QuadPlane;
QMS.QuadFamily = QuadFamily;
QMS.QuadDev    = QuadDev;


% If the orbit offset are reasonably close to the offset orbit 
QMS.CorrectOrbit = 'no';  % 'yes' or 'no';


% Note: DataDirectory must start with the root of the tree and end with filesep or be '.'
QMSDirectory = [getfamilydata('Directory','DataRoot') 'QMS'];
if isempty(QMSDirectory)
    QMS.DataDirectory = '.';
else
    QMS.DataDirectory = QMSDirectory;
end


% Default QMS structure
if get(handles.P4, 'Value') == 1
    QMS.QuadraticFit = 0;       % 0 = linear fit, else quadratic fit
else
    QMS.QuadraticFit = 1;       % 0 = linear fit, else quadratic fit
end
QMS.OutlierFactor = str2num(get(handles.P5, 'String'));      % BPM Outlier: abs(fit - measured data) > OutlierFactor * std(BPM) 
QMS.CreatedBy = 'Qcenterinit';
QMS.NumberOfPoints = str2num(get(handles.P6, 'String'));
if get(handles.P3, 'Value') == 1
    QMS.ModulationMethod = 'bipolar';
elseif get(handles.P3, 'Value') == 2
    QMS.ModulationMethod = 'unipolar';
else
    QMS.ModulationMethod = 'sweep';
end

if QMS.QuadPlane==1        
    % Default families
    QMS.BPMFamily  = 'BPMx';
    QMS.CorrFamily = 'HCM';
    
    % Quad delta
    %SPquad = maxsp(QMS.QuadFamily, QMS.QuadDev);
    SPquad = getsp(QMS.QuadFamily, QMS.QuadDev);
    QMS.QuadDelta = str2num(get(handles.P2, 'String'));

    % Use all BPMs in the minimization
    QMS.BPMDevList = family2dev(QMS.BPMFamily);

    % Find the BPM closest to the quadrupole
    [TmpFamily, QMS.BPMDev, SPosition, PhaseAdvance] = quad2bpm(QMS.QuadFamily, QMS.QuadDev);
    
    % Pick the corrector based on the response matrix
    R = getbpmresp('Struct','Physics');
    [i, iNotFound] = findrowindex(QMS.BPMDev, R(1,1).Monitor.DeviceList);
    m = R(1,1).Data(i,:);
    [MaxValue, j] = max(abs(m));
    QMS.CorrDevList = R(1,1).Actuator.DeviceList(j,:);
    
    % Corrector delta
    QMS.CorrDelta = (1/m(j)) * .5e-3;   % .5 mm change
    if strcmpi(getunits('HCM'), 'Hardware')
        QMS.CorrDelta = physics2hw('HCM', 'Setpoint', QMS.CorrDelta, QMS.CorrDevList);
    end
    

    % Check the phase advance between the BPM and Quad in the model
    PhaseAdvance = 360*PhaseAdvance/2/pi;
    if abs(PhaseAdvance) > 10
        fprintf('\n   Warning: Horizontal phase advance between %s(%d,%d) and %s(%d,%d) is %f degrees.\n', QMS.QuadFamily, QMS.QuadDev, QMS.BPMFamily, QMS.BPMDev, PhaseAdvance);
        fprintf('            This seems large for measuring the quadrupole center.\n\n');
    end

elseif QMS.QuadPlane==2       
    % Default families
    QMS.BPMFamily  = 'BPMy';
    QMS.CorrFamily = 'VCM';
    
    % Quad delta
    %SPquad = maxsp(QMS.QuadFamily, QMS.QuadDev);
    SPquad = getsp(QMS.QuadFamily, QMS.QuadDev);
    QMS.QuadDelta = str2num(get(handles.P2, 'String'));
    
    % Use all BPMs in the minimization
    QMS.BPMDevList = family2dev(QMS.BPMFamily);

    % Find the BPM closest to the quadrupole
    [TmpFamily, QMS.BPMDev, SPosition, PhaseAdvance] = quad2bpm(QMS.QuadFamily, QMS.QuadDev);
    
    % Pick the corrector based on the response matrix
    R = getbpmresp('Struct','Physics');
    [i, iNotFound] = findrowindex(QMS.BPMDev, R(2,2).Monitor.DeviceList);
    m = R(2,2).Data(i,:);
    [MaxValue, j] = max(abs(m));
    QMS.CorrDevList = R(2,2).Actuator.DeviceList(j,:);
    
    % Corrector delta
    QMS.CorrDelta = (1/m(j)) * .5e-3;  % .5 mm change
    if strcmpi(getunits('VCM'), 'Hardware')
        QMS.CorrDelta = physics2hw('VCM', 'Setpoint', QMS.CorrDelta, QMS.CorrDevList);
    end
    
    % Check the phase advance between the BPM and Quad in the model
    PhaseAdvance = 360*PhaseAdvance/2/pi;
    if abs(PhaseAdvance) > 10
        fprintf('\n   Warning: Vertical phase advance between %s(%d,%d) and %s(%d,%d) is %f degrees.\n', QMS.QuadFamily, QMS.QuadDev, QMS.BPMFamily, QMS.BPMDev, PhaseAdvance);
        fprintf('            This seems large for measuring the quadrupole center.\n\n');
    end

else
    error('QMS.QuadPlane must be 1 or 2');
end

QMS = orderfields(QMS);


function [QMS, WarningString] = quadplot_BBA(Input1, FigureHandle, sigmaBPM,handles)
%QUADPLOT - Plots quadrupole centering data
%  [QMS, WarningString] = quadplot_BBA(Input1, Handle, sigmaBPM)
%
%  INPUTS
%  1. Input1 can be a filename for the data or a QMS structure (see help quadcenter for details).
%     If empty or zero inputs, then a dialog box will be provided to select a file.
%  2. Handle can be a figure handle or a vector of 4 axes handles 
%     If Handle=0, no results are plotted
%  3. Standard deviation of the BPMs (scalar if all BPMs are the same) 
%     These should be in the data file, but this provides an override if not
%     found then the default is inf (ie, not used).
%
%  OUTPUTS
%  1. For details of the QMS data structure see help quadcenter
%     This function added:
%     QMS.Offset - Offset computed at each BPM
%     QMS.FitParameters - Fit parameter at each BPM
%     QMS.FitParametersStd - Sigma of the fit parameter at each BPM
%     QMS.BPMStd - BPM sigma at each BPM
%     QMS.OffsetSTDMontiCarlo - Monti Carlo estimate of the sigma of the offset (optional)
%
%  2. WarningString = string with warning message if you occurred

%  Written by Greg Portmann


% To Do:
% 1. It wouldn't be to difficult to added a LS weight based on slope or even the ideal weighting of std(center).
%    I haven't done it yet because the BPM errors are usually roughly equal at most accelerators.


% Remove BPM gain and roll before finding the center
ModelCoordinates = 0;

% Figure setup
Buffer = .03;
HeightBuffer = .08;


% Remove BPM if it's slope less than MinSlopeFraction * (the maximum slope)
MinSlopeFraction = .25;

% # of STD of the center calculation allowed
CenterOutlierFactor = 1;


QMS = [];
WarningString = '';


% Inputs
try
    if nargin == 0
        [FileName, PathName] = uigetfile('*.mat', 'Select a Quadrupole Center File', [getfamilydata('Directory','DataRoot'), 'QMS', filesep]);
        if ~isstr(FileName)
            return
        else
            load([PathName,FileName]);
        end
    else
        if isempty(Input1)
            [FileName, PathName] = uigetfile('*.mat', 'Select a Quadrupole Center File');
            %[FileName, PathName] = uigetfile('*.mat', 'Select a Quadrupole Center File', [getfamilydata('Directory','DataRoot'), 'QMS', filesep]);
            if ~isstr(FileName)
                return
            else
                load([PathName,FileName]);
            end
        elseif isstr(Input1)
            FileName = Input1;
            load(FileName);
        else
            QMS = Input1;
            FileName = [];
        end
    end
catch
    error('Problem getting input data');
end
if nargin < 2
    FigureHandle = [];
end

[BPMelem1, iNotFound] = findrowindex(QMS.BPMDev, QMS.BPMDevList);
if ~isempty(iNotFound)
    error('BPM at the quadrupole not found in the BPM device list');
end

QuadraticFit = QMS.QuadraticFit;       % 0 = linear fit, else quadratic fit
OutlierFactor = QMS.OutlierFactor;     % if abs(data - fit) > OutlierFactor, then remove that BPM


% Get BPM standard deviation
if nargin < 3
    % Get from the data file
    if isfield(QMS, 'BPMSTD')
        sigmaBPM = QMS.BPMSTD;
    else
        sigmaBPM = inf;
    end
end
if isempty(sigmaBPM)
    sigmaBPM = inf;
end
if isnan(sigmaBPM) | isinf(sigmaBPM)
    sigmaBPM = inf;
    fprintf('   WARNING: BPM standard deviation is unknown, hence there is no BPM outlier condition.\n');
end
sigmaBPM = sigmaBPM(:);
QMS.BPMSTD = sigmaBPM;


% Get figure handle
if all(FigureHandle ~= 0) 
    if isempty(FigureHandle)
        FigureHandle = figure;
        clf reset
        AxesHandles(1) = subplot(4,1,1);
        AxesHandles(2) = subplot(4,1,2);
        AxesHandles(3) = subplot(4,1,3);
        AxesHandles(4) = subplot(4,1,4);    
    else
        if length(FigureHandle) == 1
            FigureHandle = figure(FigureHandle);
            clf reset
            AxesHandles(1) = subplot(4,1,1);
            AxesHandles(2) = subplot(4,1,2);
            AxesHandles(3) = subplot(4,1,3);
            AxesHandles(4) = subplot(4,1,4);    
        elseif length(FigureHandle) == 4
            FigureHandle = figure;
            clf reset
            AxesHandles = FigureHandle;
        else
            error('Improper size of input FigureHandle');
        end
    end
end



% Change the coordinates to model X & Y
if ModelCoordinates
    fprintf('   Changing to model coordinates (the final center should be "rotated" back to the raw BPM coordinates).\n');
    Gx  = getgain('BPMx', QMS.BPMDevList);   % Unfortunately I don't have both families in the QMS structure???
    Gy  = getgain('BPMy', QMS.BPMDevList);
    Crunch = getcrunch(QMS.BPMFamily, QMS.BPMDevList);
    Roll   = getroll(QMS.BPMFamily, QMS.BPMDevList);
    
    for i = 1:length(Gx)
        M = gcr2loco(Gx(i), Gy(i), Crunch(i), Roll(i));
        invM = inv(M);
        
        tmp = invM * [QMS.x0(i,:); QMS.y0(i,:)];
        QMS.x0(i,:) = tmp(1,:);
        QMS.y0(i,:) = tmp(2,:);
        
        tmp = invM * [QMS.x1(i,:); QMS.y1(i,:)];
        QMS.x1(i,:) = tmp(1,:);
        QMS.y1(i,:) = tmp(2,:);
        
        tmp = invM * [QMS.x2(i,:); QMS.y2(i,:)];
        QMS.x2(i,:) = tmp(1,:);
        QMS.y2(i,:) = tmp(2,:);
        
        tmp = invM * [QMS.xstart(i,:); QMS.ystart(i,:)];
        QMS.xstart(i,:) = tmp(1,:);
        QMS.ystart(i,:) = tmp(2,:);
    end
end


% Select the x or y plane
if QMS.QuadPlane == 1    
    x0 = QMS.x0;
    x1 = QMS.x1;
    x2 = QMS.x2;

    % Plot setup
    if all(FigureHandle ~= 0) 
        set(FigureHandle,'units','normal','position',[Buffer .25+Buffer .5-Buffer-.003 .75-1.2*Buffer-HeightBuffer]);
    end
else
    x0 = QMS.y0;
    x1 = QMS.y1;
    x2 = QMS.y2;
        
    % Plot setup
    if all(FigureHandle ~= 0) 
        set(FigureHandle,'units','normal','position',[.503 .25+Buffer .5-Buffer-.003 .75-1.2*Buffer-HeightBuffer]);
    end
end


% % Change the number of points
% if strcmpi(QMS.ModulationMethod, 'Sweep')
%     %Ndiv2 = floor(size(x1,2)/2);
%     %Npoint1 = Ndiv2;
%     %Npoint2 = Ndiv2+2;
%     %x1 = x1(:,Npoint1:Npoint2);
%     %x2 = x2(:,Npoint1:Npoint2);
%     %y1 = y1(:,Npoint1:Npoint2);
%     %y2 = y2(:,Npoint1:Npoint2);
%     %N = size(x1,2);
%     %Ndiv2 = floor(size(x1,2)/2);
%     
%     Npoint1 = 2;
%     Npoint2 = size(QMS.x1, 2);
%     x0 = x0(:,Npoint1:Npoint2);
%     x1 = x1(:,Npoint1:Npoint2);
%     x2 = x2(:,Npoint1:Npoint2);
%     fprintf('  Using %d points (%d to %d, total %d) (%s method).', Npoint2-Npoint1+1, Npoint1, Npoint2, size(QMS.x1,2), QMS.ModulationMethod) ;  
% end


% Expand sigmaBPM is necessary
if length(sigmaBPM) == 1
    sigmaBPM = ones(size(x1,1),1) * sigmaBPM;
end

N = size(x1,2);


% 
% QUAD0 = getquad(QMS, 'Model');
% CM0 = getsp(QMS.CorrFamily, QMS.CorrDevList, 'Model');
% 
% 
% % Start the corrector a little lower first for hysteresis reasons
% CorrStep = 2 * QMS.CorrDelta / (N-1);
% stepsp(QMS.CorrFamily, -QMS.CorrDelta, QMS.CorrDevList, -1, 'Model');
%   
% %XstartModel = getam(BPMxFamily, BPMxDev)
% for i = 1:N
%     % Step the vertical orbit
%     if i ~= 1
%         stepsp(QMS.CorrFamily, CorrStep, QMS.CorrDevList, -1, 'Model');
%     end
% 
% %    fprintf('   %d. %s(%d,%d) = %+5.2f, %s(%d,%d) = %+.5f %s\n', i, QMS.CorrFamily, QMS.CorrDevList(1,:), getsp(QMS.CorrFamily, QMS.CorrDevList(1,:),'Model'),  BPMyFamily, BPMyDev, getam(BPMyFamily, BPMyDev,'Model'), QMS_Vertical.Orbit0.UnitsString); pause(0);
% 
%     %OrbitCorrection(XstartModel, BPMxFamily, BPMxDev, HCMFamily, HCMDev, 2, 'Model');
% 
%     if strcmpi(lower(QMS.ModulationMethod), 'sweep')
%         % One dimensional sweep of the quadrupole
%         xm1(:,i) = getam(QMS.BPMFamily, QMS.BPMDev, 'Model');
%         xm0(:,i) = xm1(:,i);
%         setquad(QMS, i*QMS.QuadDelta+QUAD0, -1, 'Model');
%         xm2(:,i) = getam(QMS.BPMFamily, QMS.BPMDevList, 'Model');
%     elseif strcmpi(lower(QMS.ModulationMethod), 'bipolar')
%         % Modulate the quadrupole
%         xm0(:,i) = getam(QMS.BPMFamily, QMS.BPMDev, 'Model');
%         [xq0(:,i), yq0(:,i)] = modeltwiss('x', QMS.QuadFamily, QMS.QuadDev);
%         
%         setquad(QMS, QMS.QuadDelta+QUAD0, -1, 'Model');
%         xm1(:,i) = getam(QMS.BPMFamily, QMS.BPMDev, 'Model');
%         [xq1(:,i), yq1(:,i)] = modeltwiss('x', QMS.QuadFamily, QMS.QuadDev);
% 
%         
%         setquad(QMS,-QMS.QuadDelta+QUAD0, -1, 'Model');
%         xm2(:,i) = getam(QMS.BPMFamily, QMS.BPMDev, 'Model');
%         [xq2(:,i), yq2(:,i)] = modeltwiss('x', QMS.QuadFamily, QMS.QuadDev);
% 
%         setquad(QMS, QUAD0, -1, 'Model');
%     elseif strcmpi(lower(QMS.ModulationMethod), 'unipolar')
%         % Modulate the quadrupole
%         xm1(:,i) = getam(QMS.BPMFamily, QMS.BPMDev, 'Model');
%         xm0(:,i) = x1(:,i);
%         setquad(QMS, QMS.QuadDelta+QUAD0, -1, 'Model');
%         xm2(:,i) = getam(QMS.BPMFamily, QMS.BPMDev, 'Model');
%         setquad(QMS, QUAD0, -1, 'Model');
%     end
% end
% 
% setquad(QMS, QUAD0, -1, 'Model');
% setsp(QMS.CorrFamily, CM0, QMS.CorrDevList, -1, 'Model');
% 
% xq0 = 1000*xq0;
% xq1 = 1000*xq1;
% xq2 = 1000*xq2;
%         
% yq0 = 1000*yq0;
% yq1 = 1000*yq1;
% yq2 = 1000*yq2;



% Fit verses the position at the BPM next to the quadrupole
if strcmpi(QMS.ModulationMethod, 'sweep')
    % One dimensional sweep of the quadrupole
    %x = x1(BPMelem1,:)';   
    x = (x1(BPMelem1,:)' + x2(BPMelem1,:)')/2;     
elseif strcmpi(QMS.ModulationMethod, 'bipolar')
    % Modulation of the quadrupole
    x = (x1(BPMelem1,:)' + x2(BPMelem1,:)')/2;     
elseif strcmpi(QMS.ModulationMethod, 'unipolar')
    % Unipolar modulation of the quadrupole
    %x = x1(BPMelem1,:)';   
    x = (x1(BPMelem1,:)' + x2(BPMelem1,:)')/2;     
end


% x = xm0 + yq0-(xm0-xm0(3));
% x = xm0(3) + yq0-yq0(3);
% x = x';



if isfield(QMS, 'Orbit0')
    BPMUnitsString = QMS.Orbit0.UnitsString;
else
    BPMUnitsString = 'mm';
end

% Figure #1
if all(FigureHandle ~= 0) 
        
    % Plot horizontal raw data
    axes(AxesHandles(1));
    plot((QMS.x2(BPMelem1,:)+QMS.x1(BPMelem1,:))/2, (QMS.x2-QMS.x1), '-x');
    hold on;
    plot((QMS.x2(BPMelem1,1)+QMS.x1(BPMelem1,1))/2, (QMS.x2(:,1)-QMS.x1(:,1)), 'xb');
    hold off;
    xlabel(sprintf('%s(%d,%d), raw values [%s]', 'BPMx', QMS.BPMDev(1), QMS.BPMDev(2), BPMUnitsString));
    ylabel({sprintf('\\Delta %s [%s]', 'BPMx', BPMUnitsString),'(raw data)'});
    if isempty(FileName)
        title(sprintf('Center for %s(%d,%d) %s(%d,%d)', QMS.BPMFamily, QMS.BPMDev(1), QMS.BPMDev(2), QMS.QuadFamily, QMS.QuadDev), 'interpreter', 'none');
    else
        title(sprintf('Center for %s(%d,%d) %s(%d,%d) (%s)', QMS.BPMFamily, QMS.BPMDev(1), QMS.BPMDev(2), QMS.QuadFamily, QMS.QuadDev, FileName), 'interpreter', 'none');
    end
    grid on
    axis tight

    if QMS.QuadPlane == 1
        Axes2Axis = axis;
    end

    % Plot vertical raw data
    axes(AxesHandles(2));
    plot((QMS.y2(BPMelem1,:)+QMS.y1(BPMelem1,:))/2, (QMS.y2-QMS.y1), '-x');
    hold on;
    plot((QMS.y2(BPMelem1,1)+QMS.y1(BPMelem1,1))/2, (QMS.y2(:,1)-QMS.y1(:,1)), 'xb');
    hold off;
    %plot(x, x2-x1, '-x');
    %plot(linspace(-DelHCM,DelHCM,3), x2-x1);
    xlabel(sprintf('%s(%d,%d), raw values [%s]', 'BPMy', QMS.BPMDev(1), QMS.BPMDev(2), BPMUnitsString));
    ylabel({sprintf('\\Delta %s [%s]', 'BPMy', BPMUnitsString),'(raw data)'});
    grid on
    axis tight

    if QMS.QuadPlane == 2
        Axes2Axis = axis;
    end
end


if isempty(FileName)
    fprintf('   Calculating the center of %s(%d,%d) using %s(%d,%d)\n', QMS.QuadFamily, QMS.QuadDev, QMS.BPMFamily, QMS.BPMDev);
else
    fprintf('   Calculating the center of %s(%d,%d) using %s(%d,%d) (Data file: %s)\n', QMS.QuadFamily, QMS.QuadDev, QMS.BPMFamily, QMS.BPMDev, FileName);
end
fprintf('   Quadrupole modulation delta = %.3f amps, %s(%d,%d) max step = %.3f amps  (%s)\n', QMS.QuadDelta, QMS.CorrFamily, QMS.CorrDevList(1,:), QMS.CorrDelta, QMS.ModulationMethod);


        
% Least squares fit
merit = x2 - x1;
if QuadraticFit
    X = [ones(size(x)) x x.^2];
    fprintf('   %d point parabolic least squares fit\n', N);
else
    X = [ones(size(x)) x];
    fprintf('   %d point linear least squares fit\n', N);
end


% Axes #3
if all(FigureHandle ~= 0) 
    axes(AxesHandles(3));
    xx = linspace(x(1), x(end), 200);
end

iBPMOutlier = [];
invXX   = inv(X'*X);
invXX_X = invXX * X';

for i = 1:size(x1,1)
    % least-square fit: m = slope and b = Y-intercept
    b = invXX_X * merit(i,:)';
    bhat(i,:) = b';
    
    % Should equal
    %b = X \merit(i,:)';
    %bhat1(i,:) = b';
    
    % Standard deviation
    bstd = sigmaBPM(i) * invXX; 
    bhatstd(i,:) = diag(bstd)';  % hopefully cross-correlation terms are small
    
    if all(FigureHandle ~= 0)   
        if QuadraticFit
            y = b(3)*xx.^2 + b(2)*xx + b(1);
        else
            y = b(2)*xx + b(1);
        end
%        plot(xx, y); hold on  
    end
    
    % Outlier condition: remove if the error between the fit and the data is greater than OutlierFactor
    if QuadraticFit
        y = b(3)*x.^2 + b(2)*x + b(1);
    else
        y = b(2)*x + b(1);
    end
    if max(abs(y - merit(i,:)')) > OutlierFactor * sigmaBPM(i)    % OutlierFactor was absolute max(abs(y - merit(i,:)')) > OutlierFactor
        iBPMOutlier = [iBPMOutlier;i];
    end
    
    if QuadraticFit
        % Quadratic fit
        if b(2) > 0
            offset(i,1) = (-b(2) + sqrt(b(2)^2 - 4*b(3)*b(1))) / (2*b(3));
        else
            offset(i,1) = (-b(2) - sqrt(b(2)^2 - 4*b(3)*b(1))) / (2*b(3));
        end
        if ~isreal(offset(i,1))
            % (b^2-4ac) can be negative but it will only happen if the slope is very small.  The offset 
            % should just get thrown out later as an outlier but change the solution to the minimum of the parabola.
            offset(i,1) = -b(2) / b(1) / 2;
        end
    else
        % Linear fit
        offset(i,1) = -b(1)/b(2); 
    end
end

QMS.Offset = offset;
QMS.FitParameters = bhat;
QMS.FitParametersStd = bhatstd;
QMS.BPMStd = sigmaBPM;


% % Label axes #2
% if all(FigureHandle ~= 0) 
%     xlabel(sprintf('%s(%d,%d), raw values [%s]', QMS.BPMFamily, QMS.BPMDev(1), QMS.BPMDev(2), BPMUnitsString));
%     ylabel(sprintf('BPM LS Fit [%s]', BPMUnitsString));
%     grid on
%     axis tight
% end


% Compute offset for different conditions
fprintf('   %d total BPMs\n', length(offset));
fprintf('   BPMs are removed for 1. Bad Status, 2. BPM Outlier, 3. Small Slope, or 4. Center Outlier\n');
%m1 = mean(offset);
%s1 = std(offset);
%fprintf('   0. Mean = %.5f %s, STD = %.5f %s, all %d BPMs\n', m1, BPMUnitsString, s1, BPMUnitsString, length(offset));


% Remove bad Status BPMs
iStatus = find(QMS.BPMStatus==0);
iBad = iStatus;
if length(iBad) == length(offset)
    error('All the BPMs have bad status');
end
offset1 = offset;
offset1(iBad) = [];
m2 = mean(offset1);
s2 = std(offset1);
fprintf('   1. Mean = %+.5f %s, STD = %.5f %s, %2d points with bad status\n', m2, BPMUnitsString, s2, BPMUnitsString, length(iBad));

% Remove bad Status + Outliers
iBad = unique([iStatus; iBPMOutlier]);
if length(iBad) == length(offset)
    error('All BPMs either have bad status or failed the BPM outlier condition');
end
offset1 = offset;
offset1(iBad) = [];
m2 = mean(offset1);
s2 = std(offset1);
fprintf('   2. Mean = %+.5f %s, STD = %.5f %s, %2d points with condition 1 and abs(fit - measured data) > %.2f std(BPM) (BPM outlier)\n', m2, BPMUnitsString, s2, BPMUnitsString, length(iBad), OutlierFactor);


% Remove bad Status + Small slopes
%iSlope = find(abs(bhat(:,2)) < max(abs(bhat(:,2)))*MinSlopeFraction);

% Look for slope outliers
Slopes = abs(bhat(:,2));
[Slopes, i] = sort(Slopes);
Slopes = Slopes(round(end/2):end);  % remove the first half
if length(Slopes) > 5
    SlopesMax = Slopes(end-4); 
else
    SlopesMax = Slopes(end); 
end
%i = find(abs(Slopes-mean(Slopes)) > 2 * std(Slopes));
%Slopes(i) = [];

iSlope = find(abs(bhat(:,2)) < SlopesMax * MinSlopeFraction);
iBad = unique([iStatus; iBPMOutlier; iSlope]);
if length(iBad) == length(offset)
    error('All BPMs either have bad status, failed the BPM outlier condition, or failed the slope condition');
end
offset1 = offset;
offset1(iBad) = [];
m2 = mean(offset1);
s2 = std(offset1);
fprintf('   3. Mean = %+.5f %s, STD = %.5f %s, %2d points with condition 1, 2, and slope < %.2f max(slope)\n', m2, BPMUnitsString, s2, BPMUnitsString, length(iBad), MinSlopeFraction);


% Offset outlier offsets-mean(offsets) greater than 1 std
itotal = (1:length(offset))';
iok = itotal;

offset1 = offset;
offset1(iBad) = [];
iok(iBad) = [];

i = find(abs(offset1-mean(offset1)) > CenterOutlierFactor * std(offset1));
iCenterOutlier = iok(i);
iBad = unique([iBad; iCenterOutlier]);
if length(iBad) == length(offset)
    error('All BPMs either have bad status, failed the BPM outlier condition, or failed the slope condition, , or failed the center outlier condition');
end
offset1(i) = [];
iok(i) = [];

m2 = mean(offset1);
s2 = std(offset1);
QMS.GoodIndex = iok;
fprintf('   4. Mean = %+.5f %s, STD = %.5f %s, %2d points with condition 1, 2, 3, and abs(center-mean(center)) > %.2f std(center) (Center outlier)\n', m2, BPMUnitsString, s2, BPMUnitsString, length(iBad), CenterOutlierFactor);


NN = length(offset);

% Axes #4
if all(FigureHandle ~= 0) 
    axes(AxesHandles(4));
    [xx1,yy1]=stairs(1:NN,offset);
    offset1 = offset;
    offset1(iBad) = NaN*ones(length(iBad),1);
    [xx2, yy2] = stairs(1:NN, offset1);
    plot(xx1,yy1,'r', xx2,yy2,'b');
    xlabel('BPM Number');
    ylabel(sprintf('%s Center [%s]', QMS.BPMFamily, BPMUnitsString));
    grid on
    axis tight
    %xaxis([0 NN+1]);
    axis([0 NN+1 min(offset1)-.1e-3 max(offset1)+.1e-3]);
end


% Axes #3

if all(FigureHandle ~= 0) 
    if 0
        % Plot red line over the bad lines
        axes(AxesHandles(3));
        for j = 1:length(iBad)
            i = iBad(j);
            if QuadraticFit
                y = bhat(i,3)*xx.^2 + bhat(i,2)*xx + bhat(i,1);
            else
                y = bhat(i,2)*xx + bhat(i,1);
            end
            plot(xx, y,'r'); 
        end
        hold off
        axis tight
    else
        % Only plot the good data
        axes(handles.Graph3);
        yy = [];
        for i = 1:size(x1,1)
            if ~any(i == iBad)
                if QuadraticFit
                    y = bhat(i,3)*xx.^2 + bhat(i,2)*xx + bhat(i,1);
                else
                    y = bhat(i,2)*xx + bhat(i,1);
                end
                yy = [yy;y];
            end
        end
        plot(xx, yy); 
        hold off
        grid on
        axis tight
    end
    xlabel(sprintf('%s(%d,%d), raw values [%s]', QMS.BPMFamily, QMS.BPMDev(1), QMS.BPMDev(2), BPMUnitsString));
    ylabel({sprintf('\\Delta %s [%s]', QMS.BPMFamily, BPMUnitsString),'(LS fit)'});
    grid on
    axis tight

    xaxis(Axes2Axis(1:2));
end

if all(FigureHandle == 0) 
        axes(handles.Graph3);
        xx = linspace(x(1), x(end), 200);
        yy = [];
        for i = 1:size(x1,1)
            if ~any(i == iBad)
                if QuadraticFit
                    y = bhat(i,3)*xx.^2 + bhat(i,2)*xx + bhat(i,1);
                else
                    y = bhat(i,2)*xx + bhat(i,1);
                end
                yy = [yy;y];
            end
        end
        plot(handles.Graph3,xx,yy);
        hold off
        grid on
        axis tight
        xlabel(sprintf('%s(%d,%d), raw values [%s]', QMS.BPMFamily, QMS.BPMDev(1), QMS.BPMDev(2), BPMUnitsString));
        ylabel({sprintf('\\Delta %s [%s]', QMS.BPMFamily, BPMUnitsString),'(LS fit)'});
        grid on
        axis tight
end

if ~isempty(iStatus)
    if ~isempty(find(iStatus==BPMelem1))
        fprintf('   WARNING: BPM(%d,%d) has a bad status\n', QMS.BPMDev(1), QMS.BPMDev(2));
        WarningString = sprintf('BPM(%d,%d) has a bad status', QMS.BPMDev(1), QMS.BPMDev(2));
    end
end
if ~isempty(iBPMOutlier)
    if ~isempty(find(iBPMOutlier==BPMelem1))
        fprintf('   WARNING: BPM(%d,%d) removed due to outlier (based on std(BPM))\n', QMS.BPMDev(1), QMS.BPMDev(2));
        WarningString = sprintf('BPM(%d,%d) removed due to outlier (based on std(BPM))', QMS.BPMDev(1), QMS.BPMDev(2));
    end
end
if ~isempty(iSlope)
    if ~isempty(find(iSlope==BPMelem1))
        fprintf('   WARNING: BPM(%d,%d) slope is too small\n', QMS.BPMDev(1), QMS.BPMDev(2));
        WarningString = sprintf('BPM(%d,%d) slope is too small', QMS.BPMDev(1), QMS.BPMDev(2));
    end
end
if ~isempty(iCenterOutlier)
    if ~isempty(find(iCenterOutlier==BPMelem1))
        fprintf('   WARNING: BPM(%d,%d) removed due to outlier (based on all the centers)\n', QMS.BPMDev(1), QMS.BPMDev(2));
        WarningString = sprintf('BPM(%d,%d) ', QMS.BPMDev(1), QMS.BPMDev(2));
    end
end


% % Axes #3
% if all(FigureHandle ~= 0) 
%     axes(AxesHandles(4));
%     iii=1:NN;
%     iii(iBad)=[];
%     for j = 1:length(iii)
%         i = iii(j);
%         
%         if 1
%             % Plot fit
%             if QuadraticFit
%                 y = bhat(i,3)*xx.^2 + bhat(i,2)*xx + bhat(i,1);
%             else
%                 y = bhat(i,2)*xx + bhat(i,1);
%             end
%             if all(FigureHandle ~= 0) 
%                 plot(xx, y,'b'); hold on 
%             end
%         else
%             % Plot error in fit
%             if QuadraticFit
%                 y = bhat(i,3)*x.^2 + bhat(i,2)*x + bhat(i,1);
%             else
%                 y = bhat(i,2)*x + bhat(i,1);
%             end
%             plot(x, y - merit(i,:)','b'); hold on 
%         end
%     end
%     hold off
%     xlabel(sprintf('%s(%d,%d), raw values [%s]', QMS.BPMFamily, QMS.BPMDev(1), QMS.BPMDev(2), BPMUnitsString));
%     ylabel(sprintf('Final %s Merit Fun [%s]', QMS.BPMFamily, BPMUnitsString));
%     grid on
%     axis tight
%     orient tall
% end


if ~isempty(QMS.OldCenter)
    fprintf('   Starting Offset %s(%d,%d) = %+f [%s]\n', QMS.BPMFamily, QMS.BPMDev, QMS.OldCenter, BPMUnitsString);
end
fprintf('   New Offset      %s(%d,%d) = %+f [%s]\n', QMS.BPMFamily, QMS.BPMDev, m2, BPMUnitsString);

QMS.Center = m2;
QMS.CenterSTD = s2;


if all(FigureHandle ~= 0)
    addlabel(1, 0, datestr(QMS.TimeStamp));
    addlabel(0, 0, sprintf('Offset %s(%d,%d)=%f, {\\Delta}%s(%d,%d)=%f, {\\Delta}%s(%d,%d)=%f', QMS.BPMFamily, QMS.BPMDev, QMS.Center, QMS.QuadFamily, QMS.QuadDev, QMS.QuadDelta, QMS.CorrFamily, QMS.CorrDevList(1,:), QMS.CorrDelta(1)));
end

fprintf('\n');


% Get and plot errors
if all(FigureHandle ~= 0)
    QMS = quaderrors(QMS, gcf+1);
else
    % This is a cluge for now
    QMS = quaderrors(QMS, 0);
end




