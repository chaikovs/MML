function varargout = TbT_PSBgui(varargin)
% TBT_PSBGUI MATLAB code for TbT_PSBgui.fig
%      TBT_PSBGUI, by itself, creates a new TBT_PSBGUI or raises the existing
%      singleton*.
%
%      H = TBT_PSBGUI returns the handle to a new TBT_PSBGUI or the handle to
%      the existing singleton*.
%
%      TBT_PSBGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TBT_PSBGUI.M with the given input arguments.
%
%      TBT_PSBGUI('Property','Value',...) creates a new TBT_PSBGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TbT_PSBgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TbT_PSBgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TbT_PSBgui

% Last Modified by GUIDE v2.5 09-Dec-2010 19:31:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @TbT_PSBgui_OpeningFcn, ...
    'gui_OutputFcn',  @TbT_PSBgui_OutputFcn, ...
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


% --- Executes just before TbT_PSBgui is made visible.
function TbT_PSBgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TbT_PSBgui (see VARARGIN)

% Choose default command line output for TbT_PSBgui
handles.output = hObject;
handles.TimbelBoardName = 'ANS-C01/SY/Timbel';
handles.KEMHName = cell2mat(family2tangodev('KEMH'));
handles.KEMVName = cell2mat(family2tangodev('KEMV'));
handles.BPMId = getfamilydata('BPMx', 'GroupId');
% Update handles structure
guidata(hObject, handles);

% if strcmp(family2mode('BPMx'),'Online')
%     if strcmpi(tango_state2(handles.KEMHName),'ON')
%         value = 1;
%     else
%         value = 0;
%     end
%     set(handles.checkbox_KEMH_ON, 'Value', value);
%     
%     if strcmpi(tango_state2(handles.KEMVName),'ON')
%         value = 1;
%     else
%         value = 0;
%     end
%     set(handles.checkbox_KEMV_ON, 'Value', value);
%     
%     if readattribute([handles.TimbelBoardName, '/outputFrequency1']) == 1
%         value = 0;
%     else
%         value = 0;
%     end
%     set(handles.checkbox_Timbel_Enable, 'Value', value);
%     
%     pushbutton_RefreshData_Callback(handles.pushbutton_RefreshData, eventdata, handles);
% end
% UIWAIT makes TbT_PSBgui wait for user response (see UIRESUME)
% uiwait(handles.TbT_PSB);


% --- Outputs from this function are returned to the command line.
function varargout = TbT_PSBgui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_FirstTurn_PlotData.
function pushbutton_FirstTurn_PlotData_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FirstTurn_PlotData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% disable K1 Event is set to 0

tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigEvent', int32(0));

% Trigger the beam which will be lost after one turn.
% Double trigger to be sure that the timePhase delay of the BPMs is taken
% into account
burst_trigger;
pause(1);
burst_trigger;
pause(1);

% get the turn by turn data for all BPMs and plot first turn for sum signal
A = getbpmrawdata('NoDisplay', 'AllData', 'Struct');
% plot Sum signal
% TODO number of turn in menu
%figure; plot(A.Data.Sum(:,1:10)'./max(A.Data.Sum(:,1:10)'))
figure; plot(A.Data.Sum(:,1:10)'./max(repmat(max(A.Data.Sum(:,1:10)'),1,120)))
xlabel('Turn #')
ylabel('Sum signal (a.u)')
title('Check if all BPM are well synchronized')

%enable K1 Injection Event is to 3
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigEvent', int32(3));


function edit_KEMH_SP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_KEMH_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_KEMH_SP as text
%        str2double(get(hObject,'String')) returns contents of edit_KEMH_SP as a double


% --- Executes during object creation, after setting all properties.
function edit_KEMH_SP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_KEMH_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Timing_BPM_Injection.
function pushbutton_Timing_BPM_Injection_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Timing_BPM_Injection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%switchbpm('Injection');
Set_and_Check_Libera_config_for_USERS;
% Remove time phase for FOFB
reset_bpm_timephase;
pause
Check_Libera_config;

% --- Executes on button press in pushbutton_Timing_BPM_FMA.
function pushbutton_Timing_BPM_FMA_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Timing_BPM_FMA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

text = sprintf('1/ Choisir d''abord bon quart pour l''injection \n2/ Puis mettre les bons retards sur les BPMs');
Answer = questdlg(text,'Orbit Correction','Oui','Non','Non');
if strcmp(Answer,'Non')
    disp('   ********************************');
    disp('   ** Configuration Aborted      **');
    disp('   ********************************');
    fprintf('\n');
    return
end

%switchbpm('KEM');
Set_and_Check_Libera_config_for_FMA;
% Set the time phase for all BPMs to trig on the same turn
set_bpm_timephase(20); % 20 is for bunch 1 PSB
warndlg('Recommencer si message d''erreur TANGO','Attention', 'modal');

% --- Executes on button press in pushbutton_Timing_Board_Injection.
function pushbutton_Timing_Board_Injection_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Timing_Board_Injection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switchsynchro('Injection');

% --- Executes on button press in pushbutton_Timing_Board_Soft.
function pushbutton_Timing_Board_Soft_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Timing_Board_Soft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switchsynchro('KEM');

% --- Executes on button press in pushbutton_Timing_Trig_Soft.
function pushbutton_Timing_Trig_Soft_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Timing_Trig_Soft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
soft_trigger;

% --- Executes on button press in pushbutton_Timing_Trig_Injection.
function pushbutton_Timing_Trig_Injection_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Timing_Trig_Injection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ntimes = str2double(get(handles.edit_injection_number,'String'));

for k=1:ntimes,
    burst_trigger; pause(0.5);
end


% --- Executes on selection change in popupmenu_Timbel_Frequency.
function popupmenu_Timbel_Frequency_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_Timbel_Frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_Timbel_Frequency contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_Timbel_Frequency

% Write impulsion
dutyCycle = 0.0036; % to get 10 us pulse length
writeattribute([handles.TimbelBoardName, '/dutyCycleCh1'], dutyCycle);

% Write Frequency
contents = cellstr(get(hObject,'String'));
frequency = str2double(contents{get(hObject,'Value')});
writeattribute([handles.TimbelBoardName, '/outputFrequency1'], frequency);
pushbutton_RefreshData_Callback(handles.pushbutton_RefreshData, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu_Timbel_Frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_Timbel_Frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_HCell8.
function pushbutton_HCell8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_HCell8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

soft_trigger
pause(2); %s
BPMmeas = getbpmrawdata(getbpmbycell(8), 'NoDisplay', 'AllData', 'Struct', 'NoArchive');
load('Ref.mat')
%save('Ref','BPMmeas0')
%figure(100); plot(BPMmeas.Data.Sum(1,:)')
%
%BPMmeas0 = BPMmeas;

figure(101); clf;  iturn = 1:25;
subplot(2,3,1)
plot(BPMmeas.Data.X(1,iturn)');
hold on; plot(BPMmeas0.Data.X(1,iturn)','r');
title(sprintf('BPM[%d,%d]', BPMmeas.DeviceList(1,:)))

subplot(2,3,2)
plot(BPMmeas.Data.X(2,iturn)')
hold on; plot(BPMmeas0.Data.X(2,iturn)','r');
title(sprintf('BPM[%d,%d]', BPMmeas.DeviceList(2,:)))

subplot(2,3,3)
plot(BPMmeas.Data.X(3,iturn)')
hold on; plot(BPMmeas0.Data.X(3,iturn)','r');
title(sprintf('BPM[%d,%d]', BPMmeas.DeviceList(3,:)))

subplot(2,3,4)
plot(BPMmeas.Data.X(4,iturn)')
hold on; plot(BPMmeas0.Data.X(4,iturn)','r');
title(sprintf('BPM[%d,%d]', BPMmeas.DeviceList(4,:)))

subplot(2,3,5)
plot(BPMmeas.Data.X(5,iturn)')
hold on; plot(BPMmeas0.Data.X(5,iturn)','r');
title(sprintf('BPM[%d,%d]', BPMmeas.DeviceList(5,:)))

subplot(2,3,6)
plot(BPMmeas.Data.X(6,iturn)')
hold on; plot(BPMmeas0.Data.X(6,iturn)','r');
title(sprintf('BPM[%d,%d]', BPMmeas.DeviceList(6,:)))



% --- Executes on button press in pushbutton_Turn1.
function pushbutton_Turn1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Turn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

BPMmeas = getbpmrawdata([], 'NoDisplay', 'AllData', 'Struct', 'NoArchive');
load('RefAll.mat')

figure(102); clf
iturn1=15;
spos = getspos('BPMx');
plot(spos, BPMmeas.Data.X(:,iturn1)')
hold on; plot(spos, BPMmeas0All.Data.X(:,iturn1)','r');

% --- Executes on button press in pushbutton_RefreshData.
function pushbutton_RefreshData_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_RefreshData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Refresh data in the table
%tango_read_attribute2(handles.KEMHName, 'Voltage');
%tango_read_attribute2(handles.KEMHName, 'Voltage');

if strcmp(family2mode('BPMx'), 'Online'),
    if strcmpi(tango_state2(handles.KEMHName),'ON')
        tab{1,1} = 'true';
    else
        tab{1,1} = 'false';
    end
    
    tab{1,2} = getam('KEMH');
    tab{1,3} = 'V';
    tab{1,4} = readattribute('ANS-C01/SY/LOCAL.EP.1/k-h.trigTimeDelay');
    
    if strcmpi(tango_state2(handles.KEMVName),'ON')
        tab{2,1} = 'true';
    else
        tab{2,1} = 'false';
    end
    
    tab{2,2} = getam('KEMV');
    tab{2,3} = 'V';
    tab{2,4} = readattribute('ANS-C01/SY/LOCAL.EP.1/k-v.trigTimeDelay');
    
    
    if (readattribute([handles.TimbelBoardName, '/disableChan1']) == 0)
        tab{3,1} = 'true';
    else
        tab{3,1} = 'false';
    end
    
    tab{3,2} = readattribute([handles.TimbelBoardName, '/outputFrequency1']);
    tab{3,3} = 'Hz';
    tab{3,4} = readattribute([handles.TimbelBoardName, '/delayChannel1']); %
    set(handles.uitable_table1, 'Data', tab);
end

set(handles.text_BPM_Tune_AGC,'String', sprintf('Tune BPM: Gain %d', getbpmagcgain));


% --- Executes during object creation, after setting all properties.
function uitable_table1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable_table1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%pushbutton_RefreshData_Callback(handles.pushbutton_RefreshData, eventdata, handles);


% --- Executes on button press in pushbutton_BPM_BufferSize.
function pushbutton_BPM_BufferSize_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_BPM_BufferSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tango_group_read_attribute2(handles.BPMId,'DDBufferSize');
figure; bar(tango_group_read_attribute2(handles.BPMId,'DDBufferSize'));
xlabel('BPM #')
ylabel('Buffersize')

function edit_BPM_BufferSize_Callback(hObject, eventdata, handles)
% hObject    handle to edit_BPM_BufferSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_BPM_BufferSize as text
%        str2double(get(hObject,'String')) returns contents of edit_BPM_BufferSize as a double

tango_group_write_attribute2(handles.BPMId,'DDBufferSize', int32(str2double(get(hObject,'String'))));
pause(3);
pushbutton_BPM_BufferSize_Callback(handles.pushbutton_BPM_BufferSize, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_BPM_BufferSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_BPM_BufferSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_KEMV_ON.
function checkbox_KEMV_ON_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_KEMV_ON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_KEMV_ON
if get(hObject,'Value')
    tango_command_inout2(handles.KEMVName,'On')
else
    tango_command_inout2(handles.KEMVName,'Off')
end

pushbutton_RefreshData_Callback(handles.pushbutton_RefreshData, eventdata, handles);


% --- Executes on button press in checkbox_Timbel_Enable.
function checkbox_Timbel_Enable_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Timbel_Enable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Timbel_Enable

attrName = [handles.TimbelBoardName,'/disableChan1'];

if get(hObject,'Value')
    writeattribute(attrName,0, 'bool'); % uint8 for bool
else
    writeattribute(attrName,1, 'bool'); %
end

pushbutton_RefreshData_Callback(handles.pushbutton_RefreshData, eventdata, handles);


% --- Executes when entered data in editable cell(s) in uitable_table1.
function uitable_table1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_table1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

%%
if eventdata.Indices(1) ==  1 && eventdata.Indices(2) ==  2
    % Set new SP value for KEMH
    setsp('KEMH', eventdata.NewData)
elseif  eventdata.Indices(1) ==  2 && eventdata.Indices(2) ==  2
    % Set new SP value for KEMV
    setsp('KEMV', eventdata.NewData)
elseif  eventdata.Indices(1) ==  1 && eventdata.Indices(2) ==  4
    % Set new delay value for KEMH
    writeattribute('ANS-C01/SY/LOCAL.EP.1/k-h.trigTimeDelay', eventdata.NewData)
elseif  eventdata.Indices(1) ==  2 && eventdata.Indices(2) ==  4
    % Set new delay value for KEMV
    writeattribute('ANS-C01/SY/LOCAL.EP.1/k-v.trigTimeDelay', eventdata.NewData)
elseif  eventdata.Indices(1) ==  3 && eventdata.Indices(2) ==  1
    % Set new frequency value for Timbel
    writeattribute([handles.TimbelBoardName, '/outputFrequency1'], eventdata.EditData)
elseif  eventdata.Indices(1) ==  3 && eventdata.Indices(2) ==  4
    % Set new delay value for Timbel
    writeattribute([handles.TimbelBoardName, '/delayChannel1'], eventdata.NewData)
elseif  eventdata.Indices(1) ==  1 && eventdata.Indices(2) ==  1
    % ON/OFF on KEMH
    if eventdata.NewData
        tango_command_inout2(handles.KEMHName,'On')
    else
        tango_command_inout2(handles.KEMHName,'Off')
    end
elseif  eventdata.Indices(1) ==  2 && eventdata.Indices(2) ==  1
    % ON/OFF on KEMV
    if eventdata.NewData
        tango_command_inout2(handles.KEMVName,'On')
    else
        tango_command_inout2(handles.KEMVName,'Off')
    end
elseif  eventdata.Indices(1) ==  3 && eventdata.Indices(2) ==  1
    % TImbel enable/disable output
    attrName = [handles.TimbelBoardName,'/disableChan1'];
    if eventdata.NewData
        writeattribute(attrName,0, 'bool'); % uint8 for bool
    else
        writeattribute(attrName,1, 'bool'); %
    end
end




% --- Executes on button press in checkbox_Timing_BPM_AGC.
function checkbox_Timing_BPM_AGC_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Timing_BPM_AGC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Timing_BPM_AGC

if get(hObject,'Value')
    %Enable AGC
    tango_group_write_attribute2(handles.BPMId,'AGCEnabled',uint8(1));
else
    % Disable AGC
    tango_group_write_attribute2(handles.BPMId,'AGCEnabled',uint8(0));
end
pause(0.5);
figure; bar(tango_group_read_attribute2(handles.BPMId,'AGCEnabled'));
xlabel('BPM #')
ylabel('Buffersize')



function edit_injection_number_Callback(hObject, eventdata, handles)
% hObject    handle to edit_injection_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_injection_number as text
%        str2double(get(hObject,'String')) returns contents of edit_injection_number as a double


% --- Executes during object creation, after setting all properties.
function edit_injection_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_injection_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Turn2.
function pushbutton_Turn2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Turn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BPMmeas = getbpmrawdata([], 'NoDisplay', 'AllData', 'Struct', 'NoArchive');
load('RefAll.mat')

figure(102); clf
iturn1=16;
spos = getspos('BPMx');
plot(spos, BPMmeas.Data.X(:,iturn1)')
hold on; plot(spos, BPMmeas0All.Data.X(:,iturn1)','r');


% --- Executes on button press in pushbutton_VCell8.
function pushbutton_VCell8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_VCell8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
soft_trigger
pause(2); %s
BPMmeas = getbpmrawdata(getbpmbycell(8), 'NoDisplay', 'AllData', 'Struct', 'NoArchive');
load('RefZ.mat')

%BPMmeas0 = BPMmeas; save('RefZ','BPMmeas0')
%figure(100); plot(BPMmeas.Data.Sum(1,:)')
%
%BPMmeas0 = BPMmeas;

figure(101); clf;  iturn = 5:35;
subplot(2,3,1)
plot(BPMmeas.Data.Z(1,iturn)');
hold on; plot(BPMmeas0.Data.Z(1,iturn)','r');
title(sprintf('BPM[%d,%d]', BPMmeas.DeviceList(1,:)))

subplot(2,3,2)
plot(BPMmeas.Data.Z(2,iturn)')
hold on; plot(BPMmeas0.Data.Z(2,iturn)','r');
title(sprintf('BPM[%d,%d]', BPMmeas.DeviceList(2,:)))

subplot(2,3,3)
plot(BPMmeas.Data.Z(3,iturn)')
hold on; plot(BPMmeas0.Data.Z(3,iturn)','r');
title(sprintf('BPM[%d,%d]', BPMmeas.DeviceList(3,:)))

subplot(2,3,4)
plot(BPMmeas.Data.Z(4,iturn)')
hold on; plot(BPMmeas0.Data.Z(4,iturn)','r');
title(sprintf('BPM[%d,%d]', BPMmeas.DeviceList(4,:)))

subplot(2,3,5)
plot(BPMmeas.Data.Z(5,iturn)')
hold on; plot(BPMmeas0.Data.Z(5,iturn)','r');
title(sprintf('BPM[%d,%d]', BPMmeas.DeviceList(5,:)))

subplot(2,3,6)
plot(BPMmeas.Data.Z(6,iturn)')
hold on; plot(BPMmeas0.Data.Z(6,iturn)','r');
title(sprintf('BPM[%d,%d]', BPMmeas.DeviceList(6,:)))



% --- Executes on button press in pushbutton_Timing_BPM_3Hz.
function pushbutton_Timing_BPM_3Hz_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Timing_BPM_3Hz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switchsynchro('3Hz');


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ls
