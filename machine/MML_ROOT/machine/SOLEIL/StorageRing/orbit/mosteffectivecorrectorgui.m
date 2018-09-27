function varargout = mosteffectivecorrectorgui(varargin)
% MOSTEFFECTIVECORRECTORGUI M-file for mosteffectivecorrectorgui.fig
%      MOSTEFFECTIVECORRECTORGUI, by itself, creates a new MOSTEFFECTIVECORRECTORGUI or raises the existing
%      singleton*.
%
%      H = MOSTEFFECTIVECORRECTORGUI returns the handle to a new MOSTEFFECTIVECORRECTORGUI or the handle to
%      the existing singleton*.
%
%      MOSTEFFECTIVECORRECTORGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOSTEFFECTIVECORRECTORGUI.M with the given input arguments.
%
%      MOSTEFFECTIVECORRECTORGUI('Property','Value',...) creates a new MOSTEFFECTIVECORRECTORGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mosteffectivecorrectorgui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mosteffectivecorrectorgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mosteffectivecorrectorgui

% Last Modified by GUIDE v2.5 24-Jan-2008 13:03:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @mosteffectivecorrectorgui_OpeningFcn, ...
    'gui_OutputFcn',  @mosteffectivecorrectorgui_OutputFcn, ...
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


% --- Executes just before mosteffectivecorrectorgui is made visible.
function mosteffectivecorrectorgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mosteffectivecorrectorgui (see VARARGIN)

% Choose default command line output for mosteffectivecorrectorgui
handles.output = hObject;

%
handles.Rmat = getbpmresp('Struct');
nBPMx = length(family2dev('BPMx'));
nHCOR = length(family2dev('HCOR'));
nBPMy = length(family2dev('BPMz'));
nVCOR = length(family2dev('VCOR'));

handles.Hdelcm{1} = zeros(nHCOR,1);
handles.Vdelcm{1} = zeros(nVCOR,1);
handles.ResidualHOrbit{1} = zeros(nBPMx,nHCOR);
handles.ResidualVOrbit{1} = zeros(nBPMy,nVCOR);
handles.HRefOrbit = zeros(nBPMx,nHCOR);
handles.VRefOrbit = zeros(nBPMy,nVCOR);
handles.HOrbit = getx;
handles.VOrbit = getz;
handles.correctornumber = 1;
handles.HGoalOrbit = getgolden('BPMx');
handles.VGoalOrbit = getgolden('BPMz');
handles.spos = getspos('BPMx');
handles.Hiter = 1; % Iteration num in H-plane
handles.Viter = 1; % Iteration num in H-plane
handles.HCORselect = 1;
handles.HCORRemove = [];
handles.VCORselect = 1;
handles.VCORRemove = [];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mosteffectivecorrectorgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mosteffectivecorrectorgui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_Hcorrector.
function listbox_Hcorrector_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_Hcorrector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox_Hcorrector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_Hcorrector

plotHdata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listbox_Hcorrector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_Hcorrector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Hfind.
function pushbutton_Hfind_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Hfind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iFam = 'BPMx';
%set(handles.listbox_Hcorrector,'Value',1);

iterNum = handles.Hiter

if iterNum == 1
  %handles.HGoalOrbit = getgolden(iFam);
  handles.HGoalOrbit = handles.HRefOrbit;
  handles.HCORRemove = [];
    set(handles.text_HGoldenRMS, 'String', num2str(std(handles.HGoalOrbit), '%3.2e'));
else
    handles.HGoalOrbit =  handles.ResidualHOrbit{iterNum-1}(:, handles.HCORselect(iterNum-1));
end

%handles.HGoalOrbitNew = handles.HGoalOrbit;
    
% refreshthering;
%handles.HOrbit = getx; 

OrbitDiff = handles.HOrbit - handles.HGoalOrbit;

% Loop over all valid correctors
for k = 1:size(handles.Rmat(1,1).Data,2),
    Rmat  = handles.Rmat(1,1).Data(:,k);
    handles.Hdelcm{iterNum}(k,:) = -pinv(Rmat)*OrbitDiff; %-Rmat\OrbitDiff;
    handles.ResidualHOrbit{iterNum}(:,k) =  handles.Rmat(1,1).Data(:,k)*handles.Hdelcm{iterNum}(k,:) ...
        + OrbitDiff;
end

% Look for most effective corrector
Xrms = std(handles.ResidualHOrbit{iterNum});
[tmp ind] = sort(Xrms,'Ascend');

% Remove correctors already used in previous iterations
[tmp1 tmp2] = intersect(handles.Rmat(1,1).Actuator.DeviceList(ind,:), handles.HCORRemove,'rows');
if ~isempty(tmp1),
    ind(tmp2) = [];
end

fprintf('H-corrector [%2d %2d] is set to % 6.2e A or % 6.2e µT.m\n', handles.Rmat(1,1).Actuator.DeviceList(ind(1),:), ...
    handles.Hdelcm{iterNum}(ind(1)), hw2physics('HCOR', 'Setpoint', handles.Hdelcm{iterNum}(ind(1)), [1 1])*getbrho);

set(handles.text_HRMS, 'String', num2str(std(handles.ResidualHOrbit{iterNum}(:,1)), '%3.2e'));

handles.HCORRemove(iterNum,:) = handles.Rmat(1,1).Actuator.DeviceList(ind(1),:);
handles.HCORselect(iterNum) = ind(1);

% Update handles structure
guidata(hObject, handles);

plotHdata(hObject, handles);

% --- Executes as a subfunction
function plotHdata(hObject, handles)

iterNum = handles.Hiter;

% look whether most effective corrector function already was run for this iteration
lastIter = size(handles.HCORRemove, 1);
if isempty(handles.HCORRemove) || lastIter < iterNum
    if iterNum - lastIter > 1
        set(handles.popupmenu_Hiter,'Value', lastIter +1);
        handles.Hiter = lastIter +1;
    end
    pushbutton_Hfind_Callback(handles.pushbutton_Hfind , [], handles)    
end

iterNum = handles.Hiter

Bind = get(handles.listbox_Hcorrector,'Value');
Hrms = std(handles.ResidualHOrbit{iterNum});
[tmp ind] = sort(Hrms,'Ascend');

handles.HCORselect(handles.Hiter) = ind(Bind(1));
%handles.HCORRemove(iterNum,:) = handles.Rmat(1,1).Actuator.DeviceList(ind(1),:);
%handles.HCORRemove(iterNum,:) = handles.Rmat(1,1).Actuator.DeviceList(ind(Bind(1)),:);

set(handles.text_HRMS, 'String', num2str(std(handles.ResidualHOrbit{iterNum}(:,ind(Bind(1)))), '%3.2e'));

spos = handles.spos;

axes(handles.axes_Horbit)
cla
%plot(spos, handles.HGoalOrbit ,'k-*'); hold on
%plot(spos, handles.ResidualHOrbit{handles.Hiter}(:,ind(Bind(1)))  + handles.HGoalOrbit, 'r')
plot(spos, handles.HOrbit - handles.HGoalOrbit ,'k-*'); hold on
plot(spos, handles.ResidualHOrbit{handles.Hiter}(:,ind(Bind(1)))  + (handles.HOrbit - handles.HGoalOrbit), 'r')

grid on;
xlabel('s-position (m)');
ylabel('H-orbit (mm)');

% Corrector strenghts
axes(handles.axes_Hcorrector)
cla 
plot(handles.Hdelcm{handles.Hiter});
hold on; plot(ind(Bind(1)), handles.Hdelcm{handles.Hiter}(ind(Bind(1))), 'k*');
grid on;
xlabel('H-corrector number');
ylabel('Current (A)');

%handles.Hdelcm(ind(1));

% Residual orbit for selected corrector
axes(handles.axes_Hrmsorbit)
cla
plot(Hrms);
grid on;
hold on; plot(ind(Bind(1)), Hrms(ind(Bind(1))), 'k*')
xlabel('H-corrector number');
ylabel('Delta Orbit rms (mm)');

ListBoxString = [];
% Remove correctors already used in previous iterations
% [tmp1 tmp2] = intersect(handles.Rmat(1,1).Actuator.DeviceList(ind,:), handles.HCORRemove,'rows');
% if ~isempty(tmp1),
%     ind(tmp2) = [];
% end

for k=1:size(ind,2),
    ListBoxString = strvcat(ListBoxString, sprintf('[%2d %2d] = %+6.2e \n', ...
        handles.Rmat(1,1).Actuator.DeviceList(ind(k),:), handles.Hdelcm{handles.Hiter}(ind(k))));
end

set(handles.listbox_Hcorrector, 'String', ListBoxString);

% Update handles structure
guidata(hObject, handles);

% --- Executes as a subfunction
function plotVdata(handles)

iterNum = handles.Viter;

% look whether most effective corrector function already was run for this iteration
lastIter = size(handles.VCORRemove, 1);
if isempty(handles.VCORRemove) || lastIter < iterNum
    if iterNum - lastIter > 1
        set(handles.popupmenu_Viter,'Value', lastIter +1);
        handles.Viter = lastIter +1;
    end
    pushbutton_Vfind_Callback(handles.pushbutton_Vfind , [], handles)    
end

iterNum = handles.Viter

Bind = get(handles.listbox_Vcorrector,'Value');
Vrms = std(handles.ResidualVOrbit{iterNum});
[tmp ind] = sort(Vrms,'Ascend');

handles.VCORselect(handles.Viter) = ind(Bind(1));
% handles.VCORRemove(iterNum,:) = handles.Rmat(2,2).Actuator.DeviceList(ind(1),:);

set(handles.text_VRMS, 'String', num2str(std(handles.ResidualVOrbit{iterNum}(:,ind(Bind(1)))), '%3.2e'));
spos = handles.spos;

axes(handles.axes_Vorbit)
cla
plot(spos, handles.VGoalOrbit ,'k-*'); hold on

plot(spos, handles.ResidualVOrbit{handles.Viter}(:,ind(Bind(1))) +  handles.VGoalOrbit, 'r')

grid on;
xlabel('s-position (m)');
ylabel('V-orbit (mm)');

% Corrector strenghts
axes(handles.axes_Vcorrector)
cla 
plot(handles.Vdelcm{handles.Viter});
hold on; plot(ind(Bind(1)), handles.Vdelcm{handles.Viter}(ind(Bind(1))), 'k*');
grid on;
xlabel('V-corrector number');
ylabel('Current (A)');

% Residual orbit for selected corrector
axes(handles.axes_Vrmsorbit)
cla
plot(Vrms);
grid on;
hold on; plot(ind(Bind(1)), Vrms(ind(Bind(1))), 'k*')
xlabel('V-corrector number');
ylabel('Delta Orbit rms (mm)');

ListBoxString = [];
% Remove correctors already used in previous iterations
% [tmp1 tmp2] = intersect(handles.Rmat(2,2).Actuator.DeviceList(ind,:), handles.VCORRemove,'rows');
% if ~isempty(tmp1),
%     ind(tmp2) = [];
% end

for k=1:size(ind,2),
    ListBoxString = strvcat(ListBoxString, sprintf('[%2d %2d] = %+6.2e \n', ...
        handles.Rmat(2,2).Actuator.DeviceList(ind(k),:), handles.Vdelcm{handles.Viter}(ind(k))));
end

set(handles.listbox_Vcorrector, 'String', ListBoxString);



% --- Executes on selection change in listbox_Vcorrector.
function listbox_Vcorrector_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_Vcorrector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox_Vcorrector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_Vcorrector
plotVdata(handles);

% --- Executes during object creation, after setting all properties.
function listbox_Vcorrector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_Vcorrector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Vfind.
function pushbutton_Vfind_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Vfind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iFam = 'BPMz';
%set(handles.listbox_Hcorrector,'Value',1);

iterNum = handles.Viter

if iterNum == 1
    handles.VGoalOrbit = getgolden(iFam);
    handles.VCORRemove = [];
    set(handles.text_VGoldenRMS, 'String', num2str(std(handles.VGoalOrbit), '%3.2e'));
else
    handles.VGoalOrbit =  handles.ResidualVOrbit{iterNum-1}(:, handles.VCORselect(iterNum-1));
end

handles.VOrbit = getz; 

OrbitDiff = handles.VOrbit - handles.VGoalOrbit;

% Loop over all valid correctors
for k = 1:size(handles.Rmat(2,2).Data,2),
    Rmat  = handles.Rmat(2,2).Data(:,k);
    handles.Vdelcm{iterNum}(k,:) = -Rmat \ OrbitDiff;
    handles.ResidualVOrbit{iterNum}(:,k) =  handles.Rmat(2,2).Data(:,k)*handles.Vdelcm{iterNum}(k) ...
    + OrbitDiff;
end

% Look for most effective corrector
Vrms = std(handles.ResidualVOrbit{iterNum});
[tmp ind] = sort(Vrms,'Ascend');

% Remove correctors already used in previous iterations
[tmp1 tmp2] = intersect(handles.Rmat(1,1).Actuator.DeviceList(ind,:), handles.VCORRemove,'rows');
if ~isempty(tmp1),
    ind(tmp2) = [];
end

fprintf('V-corrector [%2d %2d] is set to % 6.2e A or % 6.2e µT.m\n\n', handles.Rmat(2,2).Actuator.DeviceList(ind(1),:), ...
    handles.Vdelcm{iterNum}(ind(1)), hw2physics('VCOR', 'Setpoint', handles.Vdelcm{iterNum}(ind(1)),[1 1])*getbrho);

set(handles.text_VRMS, 'String', num2str(std(handles.ResidualVOrbit{iterNum}(:,1)), '%3.2e'));

handles.VCORRemove(iterNum,:) = handles.Rmat(2,2).Actuator.DeviceList(ind(1),:);
handles.VCORselect(iterNum) = ind(1);

% Update handles structure
guidata(hObject, handles);

plotVdata(handles);


% --------------------------------------------------------------------
function uimenu_loadHreffile_Callback(hObject, eventdata, handles)
% hObject    handle to uimenu_loadHreffile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fileName directoryName] = uigetfile('*.mat','Select H-BPM file as H-reference');

set(handles.text_Hreffilename,'String', fileName);

tmp = load(fileName);

handles.HRefOrbit = tmp.Data1.Data;


% Update handles structure
guidata(hObject, handles);

% --------------------------------------------------------------------
function uimenu_loadHfile_Callback(hObject, eventdata, handles)
% hObject    handle to uimenu_loadHfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName directoryName] = uigetfile('*.mat','Select H-BPM file as H-reference');

%set(handles.text_Hreffilename,'String', fileName);

tmp = load(fileName);

handles.HOrbit = tmp.Data1.Data;

% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in popupmenu_Hiter.
function popupmenu_Hiter_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_Hiter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_Hiter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_Hiter

val = get(hObject,'Value');

handles.Hiter = val;
% Update handles structure
guidata(hObject, handles);

pushbutton_Hfind_Callback(handles.pushbutton_Hfind, eventdata, handles);
% plotHdata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_Hiter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_Hiter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_Viter.
function popupmenu_Viter_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_Viter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_Viter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_Viter

val = get(hObject,'Value');

handles.Viter = val;
% Update handles structure
guidata(hObject, handles);

pushbutton_Vfind_Callback(handles.pushbutton_Vfind, eventdata, handles);
% plotHdata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_Viter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_Viter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


