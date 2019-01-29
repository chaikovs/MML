function varargout = Step_RF_Progressive(varargin)
% STEP_RF_PROGRESSIVE M-file for Step_RF_Progressive.fig
%      STEP_RF_PROGRESSIVE, by itself, creates a new STEP_RF_PROGRESSIVE or raises the existing
%      singleton*.
%
%      H = STEP_RF_PROGRESSIVE returns the handle to a new STEP_RF_PROGRESSIVE or the handle to
%      the existing singleton*.
%
%      STEP_RF_PROGRESSIVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEP_RF_PROGRESSIVE.M with the given input arguments.
%
%      STEP_RF_PROGRESSIVE('Property','Value',...) creates a new STEP_RF_PROGRESSIVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Step_RF_Progressive_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Step_RF_Progressive_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Step_RF_Progressive

% Last Modified by GUIDE v2.5 09-Jan-2012 20:31:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Step_RF_Progressive_OpeningFcn, ...
                   'gui_OutputFcn',  @Step_RF_Progressive_OutputFcn, ...
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


% --- Executes just before Step_RF_Progressive is made visible.
function Step_RF_Progressive_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Step_RF_Progressive (see VARARGIN)

% Choose default command line output for Step_RF_Progressive
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
startRF=num2str(getrf('Hz'), '%6.0f');
set(handles.txt_StartFrequency,'string',char('StartFrequency:',strcat(startRF,' Hz')));
set(handles.text_RF_Frequency,'string',char('NowFrequency:',strcat(startRF,' Hz')));
set(handles.txt_delta_applied,'string',char('TotalDeltaApplied:','0 Hz'));
%%insert variable into handles for sharing data between multiple callBack
%%and subfunction
handles.StartRF=getrf('Hz');
handles.before_step_RF=0;
handles.stepvalue=0;
guidata(hObject, handles);






% UIWAIT makes Step_RF_Progressive wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Step_RF_Progressive_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function text_RF_Frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_RF_Frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
function edit_num_StepRF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_StepRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_num_StepRF_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_StepRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
deltavalue=get(handles.edit_num_StepRF,'string');
nums=sscanf(deltavalue,'%d');
%nums = regexp(deltavalue,'\d+','match') 
%nums=nums{1}
handles.stepvalue=nums;
set(handles.edit_num_StepRF,'String',strcat(num2str(nums),'Hz'));
guidata(hObject, handles);


% --- Executes on button press in pushbutton_Do_StepRF.
function pushbutton_Do_StepRF_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Do_StepRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.before_step_RF=getrf('Hz');
delta_frequency=handles.stepvalue;
A=get(handles.pushbutton_Do_StepRF,'Visible');
set(handles.pushbutton_Do_StepRF,'Visible','off');
DO_STEP_RF(delta_frequency,handles);
set(handles.pushbutton_Do_StepRF,'Visible','on');
guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of edit_num_StepRF as text
%        str2double(get(hObject,'String')) returns contents of edit_num_StepRF as a double

% --- Executes on button press in pushbutton_undo_step.
function pushbutton_undo_step_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_undo_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
step_value=handles.before_step_RF-getrf('Hz');
set(handles.edit_num_StepRF,'string',strcat(num2str(step_value),' Hz'));
handles.stepvalue=step_value;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_undo_all.
function pushbutton_undo_all_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_undo_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
step_value=handles.StartRF-getrf('Hz');
set(handles.edit_num_StepRF,'string',strcat(num2str(step_value),' Hz'));
handles.stepvalue=step_value;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function txt_StartFrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_StartFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function txt_delta_applied_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_delta_applied (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUT DE LA SOUS-FONCTION DO_STEP_RF%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DO_STEP_RF(delta_frequency,handles)
Initial_delta=delta_frequency;
while delta_frequency>100
    steprf(100e-6);
    delta_frequency=delta_frequency-100;
    pause(3);
    nowRF=num2str(getrf('Hz'), '%6.0f');
    set(handles.text_RF_Frequency,'string',char('NowFrequency:',strcat(nowRF,' Hz'))); 
    set(handles.edit_num_StepRF,'string',strcat(num2str(delta_frequency),' Hz'));
    Total_step_value=getrf('Hz')-handles.StartRF;
    set(handles.txt_delta_applied,'string',char('TotalDeltaApplied:',strcat(num2str(Total_step_value),' Hz')));
  
end
while delta_frequency<-100
    steprf(-100e-6);
    delta_frequency=delta_frequency+100;
    pause(3);
    nowRF=num2str(getrf('Hz'), '%6.0f');
    set(handles.text_RF_Frequency,'string',char('NowFrequency:',strcat(nowRF,' Hz'))); 
    set(handles.edit_num_StepRF,'string',strcat(num2str(delta_frequency),' Hz')); 
    Total_step_value=getrf('Hz')-handles.StartRF;
    set(handles.txt_delta_applied,'string',char('TotalDeltaApplied:',strcat(num2str(Total_step_value),' Hz')));
  
end    
steprf(delta_frequency*1e-6);
pause(3);
nowRF=num2str(getrf('Hz'), '%6.0f');
set(handles.text_RF_Frequency,'string',char('NowFrequency:',strcat(nowRF,' Hz')));
set(handles.edit_num_StepRF,'string',strcat(num2str(Initial_delta),' Hz'));
Total_step_value=getrf('Hz')-handles.StartRF;
set(handles.txt_delta_applied,'string',char('TotalDeltaApplied:',strcat(num2str(Total_step_value),' Hz')));


%%%%%%%%%%%%%%%%%%%%%%%%%
%FIN DE LA SOUS-FONCTION%
%%%%%%%%%%%%%%%%%%%%%%%%%
