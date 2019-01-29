function varargout = FFTABLE_INVAC(varargin)
%FFTABLE_INVAC M-file for FFTABLE_INVAC.fig
%      FFTABLE_INVAC, by itself, creates a new FFTABLE_INVAC or raises the existing
%      singleton*.
%
%      H = FFTABLE_INVAC returns the handle to a new FFTABLE_INVAC or the handle to
%      the existing singleton*.
%
%      FFTABLE_INVAC('Property','Value',...) creates a new FFTABLE_INVAC using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to FFTABLE_INVAC_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      FFTABLE_INVAC('CALLBACK') and FFTABLE_INVAC('CALLBACK',hObject,...) call the
%      local function named CALLBACK in FFTABLE_INVAC.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FFTABLE_INVAC

% Last Modified by GUIDE v2.5 22-Dec-2010 04:17:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FFTABLE_INVAC_OpeningFcn, ...
                   'gui_OutputFcn',  @FFTABLE_INVAC_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before FFTABLE_INVAC is made visible.
function FFTABLE_INVAC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for FFTABLE_INVAC
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FFTABLE_INVAC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FFTABLE_INVAC_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function CellName_Callback(hObject, eventdata, handles)
% hObject    handle to CellName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CellName as text
%        str2double(get(hObject,'String')) returns contents of CellName as a double


% --- Executes during object creation, after setting all properties.
function CellName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CellName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SSType_Callback(hObject, eventdata, handles)
% hObject    handle to SSType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SSType as text
%        str2double(get(hObject,'String')) returns contents of SSType as a double


% --- Executes during object creation, after setting all properties.
function SSType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SSType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function UndType_Callback(hObject, eventdata, handles)
% hObject    handle to UndType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of UndType as text
%        str2double(get(hObject,'String')) returns contents of UndType as a double


% --- Executes during object creation, after setting all properties.
function UndType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UndType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TableName_Callback(hObject, eventdata, handles)
% hObject    handle to TableName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TableName as text
%        str2double(get(hObject,'String')) returns contents of TableName as a double


% --- Executes during object creation, after setting all properties.
function TableName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TableName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SESSION_Callback(hObject, eventdata, handles)
% hObject    handle to SESSION (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SESSION as text
%        str2double(get(hObject,'String')) returns contents of SESSION as a double


% --- Executes during object creation, after setting all properties.
function SESSION_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SESSION (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in APPLY.
function APPLY_Callback(hObject, eventdata, handles)
% hObject    handle to APPLY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CellName=get(handles.CellName,'String');
SSType=get(handles.SSType,'String');
UndType=get(handles.UndType,'String');
TableName=get(handles.TableName,'String');
SESSION=get(handles.SESSION,'String');
fprintf('%s\t %s\t %s\t %s\t %s\n',SESSION,CellName,SSType,UndType,TableName)
Update_InVacID(SESSION,CellName,SSType,UndType,TableName)


function CurMin_Callback(hObject, eventdata, handles)
% hObject    handle to CurMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CurMin as text
%        str2double(get(hObject,'String')) returns contents of CurMin as a double


% --- Executes during object creation, after setting all properties.
function CurMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CurMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CurMax_Callback(hObject, eventdata, handles)
% hObject    handle to CurMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CurMax as text
%        str2double(get(hObject,'String')) returns contents of CurMax as a double


% --- Executes during object creation, after setting all properties.
function CurMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CurMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function CurStep_Callback(hObject, eventdata, handles)
% hObject    handle to CurStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CurStep as text
%        str2double(get(hObject,'String')) returns contents of CurStep as a double


% --- Executes during object creation, after setting all properties.
function CurStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CurStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function BLName_Callback(hObject, eventdata, handles)
% hObject    handle to BLName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BLName as text
%        str2double(get(hObject,'String')) returns contents of BLName as a double


% --- Executes during object creation, after setting all properties.
function BLName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BLName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CorCalib.
function CorCalib_Callback(hObject, eventdata, handles)
% hObject    handle to CorCalib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CellName=get(handles.CellName,'String');
SSType=get(handles.SSType,'String');
UndType=get(handles.UndType,'String');
CurMin=str2double(get(handles.CurMin,'String'));
CurMax=str2double(get(handles.CurMax,'String'));
CurStep=str2double(get(handles.CurStep,'String'));
TableName=get(handles.TableName,'String');
BLName=TableName(4:findstr(TableName,'.')-1);
DeviceServerName=[CellName '/EI/' SSType '-' UndType ]
FullUndName=[UndType '_' BLName]
IdCorCalibInVac(FullUndName,DeviceServerName,CurMin,CurMax,CurStep)



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LinExp_Callback(hObject, eventdata, handles)
% hObject    handle to LinExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LinExp as text
%        str2double(get(hObject,'String')) returns contents of LinExp as a double


% --- Executes during object creation, after setting all properties.
function LinExp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LinExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GapMin_Callback(hObject, eventdata, handles)
% hObject    handle to GapMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GapMin as text
%        str2double(get(hObject,'String')) returns contents of GapMin as a double


% --- Executes during object creation, after setting all properties.
function GapMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GapMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function GapMax_Callback(hObject, eventdata, handles)
% hObject    handle to GapMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GapMax as text
%        str2double(get(hObject,'String')) returns contents of GapMax as a double


% --- Executes during object creation, after setting all properties.
function GapMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GapMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Npts_Callback(hObject, eventdata, handles)
% hObject    handle to Npts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Npts as text
%        str2double(get(hObject,'String')) returns contents of Npts as a double


% --- Executes during object creation, after setting all properties.
function Npts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Npts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ZeroCurrentTable.
function ZeroCurrentTable_Callback(hObject, eventdata, handles)
% hObject    handle to ZeroCurrentTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LinExp=str2double(get(handles.LinExp,'String'));
CellName=get(handles.CellName,'String');
UndType=get(handles.UndType,'String');
GapMin=str2double(get(handles.GapMin,'String'));
GapMax=str2double(get(handles.GapMax,'String'));
Npts=str2double(get(handles.Npts,'String'));
FolderAndFFTableName=['/usr/Local/configFiles/InsertionFFTables/' CellName '-' UndType '/FF_TEST.txt'];
GenerateFFTableWithZeros(FolderAndFFTableName,GapMin,GapMax,Npts,LinExp)



function edit_TABLE_AFTER_ANALYSE_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TABLE_AFTER_ANALYSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TABLE_AFTER_ANALYSE as text
%        str2double(get(hObject,'String')) returns contents of edit_TABLE_AFTER_ANALYSE as a double


% --- Executes during object creation, after setting all properties.
function edit_TABLE_AFTER_ANALYSE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TABLE_AFTER_ANALYSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_OrbitMax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_OrbitMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_OrbitMax as text
%        str2double(get(hObject,'String')) returns contents of edit_OrbitMax as a double


% --- Executes during object creation, after setting all properties.
function edit_OrbitMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_OrbitMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
CellName=get(handles.CellName,'String');
SSType=get(handles.SSType,'String');
UndType=get(handles.UndType,'String');
TableName=get(handles.TableName,'String');
OrbitMax=str2double(get(handles.edit_OrbitMax,'String'));
NewTable=get(handles.edit_TABLE_AFTER_ANALYSE,'String');
AnalyseOrbitAndFixTheGapStep(NewTable,CellName,SSType,UndType,TableName,OrbitMax)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
