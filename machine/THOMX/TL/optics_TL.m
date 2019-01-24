function varargout = optics_TL(varargin)
%OPTICS_LT1_LT2 - M-file for optics_LT1_LT2.fig
%      OPTICS_LT1_LT2, by itself, creates a new OPTICS_LT1_LT2 or raises the existing
%      singleton*.
%
%      H = OPTICS_LT1_LT2 returns the handle to a new OPTICS_LT1_LT2 or the handle to
%      the existing singleton*.
%
%      OPTICS_LT1_LT2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTICS_LT1_LT2.M with the given input arguments.
%
%      OPTICS_LT1_LT2('Property','Value',...) creates a new OPTICS_LT1_LT2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before optics_LT1_LT2_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to optics_LT1_LT2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help optics_LT1_LT2

% Last Modified by GUIDE v2.5 25-Oct-2013 14:42:37

% Begin initialization code - DO NOT EDIT

global THERING

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @optics_TL_OpeningFcn, ...
                   'gui_OutputFcn',  @optics_TL_OutputFcn, ...
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

% --- Executes just before optics_LT1_LT2 is made visible.
function optics_TL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to optics_LT1_LT2 (see VARARGIN)

% Choose default command line output for optics_LT1_LT2
global THERING

handles.output = hObject;

%mat: utilite ???
setappdata(handles.figure1, 'twissdatain',struct([]));

% construct initial twiss parameters

Machine = getfamilydata('SubMachine');

switch Machine
    case {'TL','TL_SL','TL_OC'}
        
       % twissdatain=THERING{1}.TwissData;

%         twissdatain.ElemIndex  = 1;
%         twissdatain.SPos       = 0;
%         twissdatain.ClosedOrbit= [1e-3 0 2e-3 0]'*0;
%         twissdatain.M44        = eye(4);
%         % theorique
%         twissdatain.beta       = [34.46 33.94];
%         twissdatain.alpha      = [-4.24 -4.34];
%         % mesure 2006-02-06
%         %twissdatain.beta       = [9.5 13.5];
%         %twissdatain.alpha      = [-1.16 -2.43];
%         twissdatain.mu         = [0 0];
%         twissdatain.Dispersion = [0 0 0 0]';
        set(handles.figure1,'Name', 'TL Optical functions');
        
    case {'EL'}
        
        twissdatain.ElemIndex  = 1;
        twissdatain.SPos       = 0;
        twissdatain.ClosedOrbit= [1e-3 0 2e-3 0]'*0;
        twissdatain.M44        = eye(4);
        twissdatain.beta       = [6.0 6.0];
        twissdatain.alpha      = [-1.8 1.5];
        twissdatain.mu         = [0 0];
        twissdatain.Dispersion = [0 0 0 0]';
        set(handles.figure1,'Name', 'EL Optical functions');

    otherwise
        error('No Machine loaded')        
end

setappdata(handles.figure1, 'twissdatain0',THERING{1}.TwissData);
handles.restart = 1;

%% Initialize structure for handling TL and EL magnets
handles = init_handles(handles);

% Update handles structure
guidata(hObject, handles);

AO = getao;
% setappdata(handles.figure1,'AOmagnet', AO);

%set(handles.(name),'Max',9, 'Min', -9)

% min et max des sliders (figé à l'ouverture puis modifiable par SETBAR)
% the values are set in TLinit.m
for i=1:7
    val_max(i) = getmaxsp(['QP',num2str(i),'L']);
    val_min(i) = getminsp(['QP',num2str(i),'L']);
end

%% Number of sliders    
handles.sliderNumber = 7;

for k = 1:handles.sliderNumber,
    name = strcat('sliderQP',num2str(k),'L');
    %set(handles.(name),'Max',val_max(k),'Min',val_min(k));
    set(handles.(name),'Max',max(val_max),'Min',min(val_min)); % set the change range of magnets 
end


%% liste de aimants a controler (menu deroulant)
list = [...
        AO.QP1L.CommonNames;...
        AO.QP2L.CommonNames;...
        AO.QP3L.CommonNames;...
        AO.QP4L.CommonNames;...
        AO.QP5L.CommonNames;...
        AO.QP6L.CommonNames;...
        AO.QP7L.CommonNames;...
        AO.BEND1.CommonNames;...
        AO.BEND2.CommonNames;...
        AO.HCOR.CommonNames; ...
        AO.VCOR.CommonNames
        ];
    

%% Automatic configuration for sliders
for k = 1:handles.sliderNumber
    name = ['popupmenu_bar' num2str(k)];
    set(handles.(name),'String',list);
    set(handles.(name),'Value',k);
end

%% graphe par defaut
axes(handles.axes1);
handles.xtype = 'spos';
handles.ytype = 'beta';

%% initialisation AT et IHM
handles = restart(handles);

%% Read Tango values
%read_tango(handles);

% UIWAIT makes optics_LT1_LT2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(0,'DefaultAxesXgrid','on','DefaultAxesYgrid','on');

%% graphe symboles
axes(handles.axes2);
drawlattice(0,0.8);
set(handles.axes2,'Xlim',[handles.spos(1) handles.spos(end)], ...
    'XTick',[],'YTick',[]);


% Update handles structure
guidata(hObject, handles);

%% -------------------------------------
function handles = computeTwiss(handles)
% update ATmodel
% compute new twiss parameters
% 
global THERING;

%%% parameters at the entrance of the line
% twissdatain.ElemIndex=1;
% twissdatain.SPos=0;
% twissdatain.ClosedOrbit=[1e-3 0 2e-3 0]'*0;
% twissdatain.M44=eye(4);
% 
% if isequal(isfield(twissdatain,'beta'),0)
 
%  if handles.restart == 1
%      twissdatain = THERING{1}.TwissData;%getappdata(handles.figure1,'twissdatain0');
%      handles.restart = 0;
%  else
%      twissdatain = THERING{1}.TwissData;%getappdata(handles.figure1,'twissdatain');
%  end
%     twissdatain.beta= [8.1 8.1];
%     twissdatain.alpha= [0 0];
% else
%     twissdatain = getappdata(handles.figure1,'twissdatain')
% end

% twissdatain.mu= [0 0];a&
% twissdatain.Dispersion= [0 0 0 0]';

%%% get twiss paramaters
TD = twissline(THERING,0.0,THERING{1}.TwissData,1:length(THERING),'chroma');

handles.twissdatain = THERING{1}.TwissData;
handles.beta  = cat(1,TD.beta);
handles.cod   = cat(2,TD.ClosedOrbit)';
handles.eta   = cat(2,TD.Dispersion)';
handles.spos  = cat(1,TD.SPos);
handles.phase = cat(1,TD.mu);

setappdata(handles.figure1,'twissdatain',THERING{1}.TwissData);

% --- Outputs from this function are returned to the command line.
function varargout = optics_TL_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function sliderQP1L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP1L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on slider movement.
function sliderQP1L_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQP1L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

handles = setslider(hObject,handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function editQP1L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editQP1L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','green');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on slider movement.
function editQP1L_Callback(hObject, eventdata, handles)
% hObject    handle to editQP1L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editQP1L as text
%        str2double(get(hObject,'String')) returns contents of editQP1L as a double
handles = setedit(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sliderQP2L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP2L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on slider movement.
function sliderQP2L_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQP2L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles = setslider(hObject,handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function editQP2L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editQP2L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editQP2L_Callback(hObject, eventdata, handles)
% hObject    handle to editQP2L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editQP2L as text
%        str2double(get(hObject,'String')) returns contents of editQP2L as a double
handles = setedit(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sliderQP3L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP3L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on slider movement.
function sliderQP3L_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQP3L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles = setslider(hObject,handles);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function editQP3L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editQP3L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editQP3L_Callback(hObject, eventdata, handles)
% hObject    handle to editQP3L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editQP3L as text
%        str2double(get(hObject,'String')) returns contents of editQP3L as a double
handles = setedit(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function editQP4L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editQP4L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editQP4L_Callback(hObject, eventdata, handles)
% hObject    handle to editQP4L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editQP4L as text
%        str2double(get(hObject,'String')) returns contents of editQP4L as a double
handles = setedit(handles);


% --- Executes during object creation, after setting all properties.
function sliderQP4L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP4L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function sliderQP4L_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQP4L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles = setslider(hObject,handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function editQP5L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editQP5L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function editQP5L_Callback(hObject, eventdata, handles)
% hObject    handle to editQP5L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editQP5L as text
%        str2double(get(hObject,'String')) returns contents of editQP5L as a double
handles = setedit(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sliderQP5L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP5L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on slider movement.
function sliderQP5L_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQP5L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles = setslider(hObject,handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sliderQP6L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP6L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on slider movement.
function sliderQP6L_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQP6L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles = setslider(hObject,handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function editQP6L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editQP6L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editQP6L_Callback(hObject, eventdata, handles)
% hObject    handle to editQP6L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editQP6L as text
%        str2double(get(hObject,'String')) returns contents of editQP6L as a double
handles = setedit(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function editQP7L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editQP7L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function editQP7L_Callback(hObject, eventdata, handles)
% hObject    handle to editQP7L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editQP7L as text
%        str2double(get(hObject,'String')) returns contents of editQP7L as a double
handles = setedit(handles);


% --- Executes during object creation, after setting all properties.
function sliderQP7L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP7L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on slider movement.
function sliderQP7L_Callback(hObject, eventdata, handles)
% hObject    handle to sliderQP7L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles = setslider(hObject,handles);
guidata(hObject, handles);

%-----------------------------------------------------------------------
function plot_axes(handles,quoi)
%%% fonction generique

axes(handles.axes1); cla; hold on;

switch handles.xtype
    case 'spos'
        x=handles.(handles.xtype);
    case 'phase'
        x=handles.(handles.xtype); x = x(:,1);
end

switch quoi
    case 'beta'
        plot(x,handles.beta(:,1),'r.-'); 
        plot(x,handles.beta(:,2),'b.-'); 
        ylabel('\beta (m)');
        %mat
   %ylim([0 130]);
        
    case 'eta'        
        plot(x,handles.eta(:,1),'r.-');
        plot(x,handles.eta(:,3),'b.-');
        ylabel('\eta (m)');
    case 'cod'        
        plot(x,handles.cod(:,1)*1e3,'r.-');
        plot(x,handles.cod(:,3)*1e3,'b.-');
        ylabel('cod (mm)');
    case 'phase'        
        plot(x,handles.phase(:,1),'r.-');
        plot(x,handles.phase(:,2),'b.-');
        ylabel('phase ');
end
axis([x(1) x(end) -inf inf]);
datalabel on

%--------------------------------------------------------------------------
function handles = setslider(hObject, handles)
%%% fonction generique pour un slider de type aimant

AOmagnet = getappdata(handles.figure1,'AOmagnet'); %% get LT1 structure
%% extrait le numero
tagstring = get(hObject,'Tag');
num = tagstring(regexp(tagstring,'\d'));
magnet0 = ['QP' num2str(num),'L'];
val =  get(hObject,'Value');
str = num2str(val);
set(handles.(['edit' magnet0]),'string',str);

%% Cherche le nom de l'aimant
h = handles.(['popupmenu_bar' num]);
contents = get(h,'String');
magnet = contents{get(h,'Value')};
handles = setATmagnet(handles,magnet,val);

%AOmagnet.(magnet(1:2)).ModelVal(str2double(magnet(end))) = val;
AOmagnet.(magnet).ModelVal = val;
% save data
setappdata(handles.figure1,'AOmagnet',AOmagnet)

%--------------------------------------------------------------------------
function handles = setATmagnet(handles,magnet,val)
% function handles = setATmagnet(handles,magnet,val)
% set  val as new setvalue of element 'magnet' 
% Replot current graph

AOmagnet= getappdata(handles.figure1,'AOmagnet'); % get magnet AO

% set value to AT model
setsp(common2family(magnet), val, common2dev(magnet),'Model');

% Recompute twiss parameters
handles = computeTwiss(handles);
% Replot everything
plot_axes(handles,handles.ytype);
%mat
%ylim([0 130]);

%--------------------------------------------------------------------------
function handles = setedit(handles)
% function setedit(handles)
% generic callback for an edit box

AOmagnet= getappdata(handles.figure1,'AOmagnet'); % get magnet AO

%% construction automatique du nom du slider
val = str2double(get(gcbo,'String'));
tagstring = get(gcbo,'Tag');
num = tagstring(regexp(tagstring,'\d'));
magnet0=['QP' num2str(num)];
name = handles.(['slider' magnet0]);
%% Cherche le nom de l'aimant
h = handles.(['popupmenu_bar' num]);
contents = get(h,'String');
magnet = contents{get(h,'Value')};

%%% Test si dans les limites
if val<get(name,'Max') && val> get(name,'Min')
  set(name,'Value',val);
  handles = setATmagnet(handles,magnet,val);
  AOmagnet.(magnet(1:2)).ModelVal(str2double(magnet(end))) = val;
else % message d'erreur
  warndlg('Wrong value for K','Edit Box','Modal')
  set(hObject,'String',num2str(get(name,'Value')));
end

% Save data
setappdata(handles.figure1,'AOmagnet',AOmagnet); 

%---------------------------------
function mutual_exclude(off)
% function mutual_exclude(off)
% fonction pour faire des radioboutons
set(off,'Value',0);

% --- Executes during object creation, after setting all properties.
function popupmenu_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in popupmenu_y.
function popupmenu_y_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_y contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_y
contents = get(hObject,'String');
plot_axes(handles, contents{get(hObject,'Value')});
%mat
     %ylim([0 130]);
handles.ytype = contents{get(hObject,'Value')};       
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on selection change in popupmenu_x.
function popupmenu_x_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_x contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_x
contents = get(hObject,'String');        
handles.xtype = contents{get(hObject,'Value')};       
guidata(hObject, handles);
plot_axes(handles, handles.ytype);
%mat
      %ylim([0 130]);

% --- Executes during object creation, after setting all properties.
function popupmenu_plane_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_plane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in popupmenu_plane.
function popupmenu_plane_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_plane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_plane contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_plane


% --- Executes on button press in pushbutton_reload.
function pushbutton_reload_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = restart(handles);
guidata(hObject,handles);

%--------------------------------------------------------
function handles = restart(handles)
% function handles = restart(handles)
% Reinitialise la maille et l'IHM

AD = getad;
run(AD.ATModel); %% Load lattice
global THERING
% MAT ET LAURENT : TEMPORAIRE
%warning('66 MeV');
%setenergymodel(0.066);

%

setappdata(handles.figure1, 'TL', THERING);

handles.restart = 1;
handles         = computeTwiss(handles);

plot_axes(handles,handles.ytype);
%mat
   
%ylim([0 130]);

handles.modelMagnetVal  = {'chModelVal', 'cvModelVal', ...
    'quadrupoleModelVal', 'dipoleModelVal'};

store_model_values(handles);

% Relaod Accelerator Object
AO  = getao; 

%% Initialise les sliders et editboxes
for k = 1:handles.sliderNumber
    name = ['popupmenu_bar' num2str(k)];
    contents = get(handles.(name),'String');
    magnet = contents{get(handles.(name),'Value')};
    
    Qname = ['QP' num2str(k),'L'];   
    
    % Read AT values
    val  = getam(common2family(magnet),common2dev(magnet),'Model');
    
    set(handles.(['slider' Qname]),'Value', val);
    set(handles.(['edit' Qname]),'string', num2str(val));
end


% --- Executes during object creation, after setting all properties.
function popupmenu_bar1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in popupmenu_bar1.
function popupmenu_bar1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_bar1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_bar1

setbar(handles);

%----------------------------------------------------------
function setbar(handles)
%% aimant selectionne
contents = get(gcbo,'String');
magnet = contents{get(gcbo,'Value')}

%% mets a jour l'IHM pour cet aimant
tagstring = get(gcbo,'Tag');
num = tagstring(regexp(tagstring,'\d'));
slidername = ['sliderQP' num, 'L']; 
editboxname = ['editQP' num, 'L']; 

AOmagnet  = getappdata(handles.figure1,'AOmagnet'); 

switch magnet
    case AOmagnet.HCOR.CommonNames
%         val_max = getmaxsp('HCOR');
%         for k = 1:7
%             name = strcat('sliderQP',num2str(k),'L')
%             set(handles.(name),'Max',val_max(1));
%         end
        val = AOmagnet.HCOR.ModelVal(str2double(magnet(end)));
    case AOmagnet.VCOR.CommonNames
        val = AOmagnet.VCOR.ModelVal(str2double(magnet(end)));
    case AOmagnet.QP1L.CommonNames
        val = AOmagnet.QP1L.ModelVal;
    case AOmagnet.QP2L.CommonNames
        val = AOmagnet.QP2L.ModelVal;
    case AOmagnet.QP3L.CommonNames
        val = AOmagnet.QP3L.ModelVal;
    case AOmagnet.QP4L.CommonNames
        val = AOmagnet.QP4L.ModelVal;
    case AOmagnet.QP5L.CommonNames
        val = AOmagnet.QP5L.ModelVal;
    case AOmagnet.QP6L.CommonNames
        val = AOmagnet.QP6L.ModelVal;
    case AOmagnet.QP7L.CommonNames
        val = AOmagnet.QP7L.ModelVal;
    case AOmagnet.BEND1.CommonNames
        val = AOmagnet.BEND1.ModelVal(str2double(magnet(end)));
    case AOmagnet.BEND2.CommonNames
        val = AOmagnet.BEND2.ModelVal(str2double(magnet(end)));
end

str = num2str(val);
set(handles.(slidername),'Value',val); % writes slider
set(handles.(editboxname),'String',str); % writes editbox

% --- Executes during object creation, after setting all properties.
function popupmenu_bar2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on selection change in popupmenu_bar2.
function popupmenu_bar2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_bar2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_bar2
setbar(handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_bar3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on selection change in popupmenu_bar3.
function popupmenu_bar3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_bar3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_bar3
setbar(handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_bar4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on selection change in popupmenu_bar4.
function popupmenu_bar4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_bar4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_bar4
setbar(handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_bar5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on selection change in popupmenu_bar5.
function popupmenu_bar5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_bar5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_bar5
setbar(handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_bar6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in popupmenu_bar6.
function popupmenu_bar6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_bar6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_bar6
setbar(handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_bar7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on selection change in popupmenu_bar7.
function popupmenu_bar7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_bar7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_bar7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_bar7
setbar(handles);


% --- Executes on button press in pushbutton_refresh.
function pushbutton_refresh_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%--------------------------------------------------------------------------
function read_tango(handles)
% Reads Tango values for LT1.

% Get magnet AO
AOmagnet = getappdata(handles.figure1,'AOmagnet');
FamilyName = fieldnames(AOmagnet); 

for k1 = 1:length(FamilyName)
        % get attribute readback value
        magnet = AOmagnet.(FamilyName{k1});
        AOmagnet.(FamilyName{k1}).TangoVal = ...
            getam(FamilyName{k1},'Online');
end

% save data
setappdata(handles.figure1,'AOmagnet',AOmagnet)

%--------------------------------------------------------------------------
function write_tango(handles);
%-- Writes Tango values
%% Ecriture courant aimant sur les devices serveurs

% Get magnet AO
AOmagnet = getappdata(handles.figure1,'AOmagnet');

FamilyName = fieldnames(AOmagnet); 
for k1 = 1:length(FamilyName)
    magnet = AOmagnet.(FamilyName{k1});
    setsp(magnet, magnet.ModelVal,'Online');
end

%--------------------------------------------------------------------------
function devicelist = get_device_name(machine,property,magnet)
% get device list from mapping read in tango database

map        = tango_get_db_property(machine,property);
sep        = cell2mat(regexpi(map,'::','once'))-1;
devicelist = regexprep(map,[magnet '\d*::'],'')';

% --- Executes during object creation, after setting all properties.
function pushbutton_reload_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_reload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in pushbutton_model2online.
function pushbutton_model2online_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_model2online (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AOmagnet      = getappdata(handles.figure1,'AOmagnet'); %% get LT1 structure

user_response = questdlg('Do you want to write setvalues to LT1?');
switch user_response
    case{'No','Cancel'}
        return;
    case{'Yes'}
        FamilyName = fieldnames(AOmagnet);
        for k1 = 1:length(FamilyName)
            AOmagnet.(FamilyName{k1}).TangoVal = ...
                AOmagnet.(FamilyName{k1}).ModelVal;
        end
        write_tango(handles);
end

% save data
setappdata(handles.figure1,'AOmagnet',AOmagnet)

% --- Executes on button press in pushbutton_online2model.
function pushbutton_online2model_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_online2model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Online values stored in model values except dipoles
user_response = questdlg('Do you want to read TANGO setvalues from LT1?');
switch user_response
    case{'No','Cancel'}
        return;
    case{'Yes'}
        read_tango(handles);
end

AOmagnet    = getappdata(handles.figure1,'AOmagnet'); %% get LT1 structure

FamilyName = fieldnames(AOmagnet); 
for k1 = 1:length(FamilyName)    
        AOmagnet.(FamilyName{k1}).ModelVal = AOmagnet.(FamilyName{k1}).TangoVal;
end
        
%% Initialise les sliders et editboxes
for k = 1:handles.sliderNumber
    name = ['popupmenu_bar' num2str(k)];
    contents = get(handles.(name),'String');
    magnet = contents{get(handles.(name),'Value')};
    
    Qname = ['QP' num2str(k)];   
    
    switch magnet
        case AOmagnet.QP.CommonNames            
            val = AOmagnet.QP.TangoVal(str2double(magnet(end)));
        case AOmagnet.CH.CommonNames
            val = AOmagnet.CH.TangoVal(str2double(magnet(end)));
        case AOmagnet.CV.CommonNames
            val = AOmagnet.CV.TangoVal(str2double(magnet(end)));
    end
    
    set(handles.(['slider' Qname]),'Value', val);
    set(handles.(['edit' Qname]),'string', num2str(val));
end

set_model_values(handles);

handles = computeTwiss(handles);
plot_axes(handles,handles.ytype);
%mat
        %ylim([0 130]);
% Update handles structure
guidata(hObject, handles);

%% Update date
set(handles.text_date,'String',datestr(now,0));

%save data
setappdata(handles.figure1,'AOmagnet',AOmagnet);

%--------------------------------------------------------------------------
function handles = init_handles(handles)
%% Inits structure storing all the magnet data

%% AT model used
% global THERING;

A1 = getao; % Load AO for the first time
AOmagnet = [];
list = findmemberof('Magnet');
for k = 1:length(list)
    AOmagnet.(list{k}) = A1.(list{k});
end
clear A1;

%save data
setappdata(handles.figure1,'AOmagnet',AOmagnet);

store_model_values(handles);

%% Update time
set(handles.text_date,'String',datestr(now,0));

%--------------------------------------------------------------------------
function store_model_values(handles)
%% Stores model values in AOmagnet 

AOmagnet = getappdata(handles.figure1,'AOmagnet'); % get AOmagnet structure

% Loop over magnet types
FamilyName = fieldnames(AOmagnet);

for k1 = 1:length(FamilyName)
    AOmagnet.(FamilyName{k1}).ModelVal = getam(FamilyName{k1},'Model');
end

setappdata(handles.figure1,'AOmagnet',AOmagnet);

%--------------------------------------------------------------------------
function set_model_values(handles)
% Set Modelvalue into LT1 AT model

AOmagnet = getappdata(handles.figure1,'AOmagnet'); % get AOmagnet structure

%% Set model values to AT
FamilyName = fieldnames(AOmagnet); 

for k1 = 1:length(FamilyName)
    magnet = AOmagnet.(FamilyName{k1});
    setsp(FamilyName{k1}, magnet.ModelVal,'Model');
end


%--------------------------------------------------------------------------
function submenu_print_setpoint_Callback(hObject, eventdata, handles)
% hObject    handle to submenu_print_setpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%--------------------------------------------------------------------------
function submenu_print_model_Callback(hObject, eventdata, handles)
% hObject    handle to submenu_print_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% -------------------------------------------------------------------------
function submenu_save_setpoint_Callback(hObject, eventdata, handles)
% hObject    handle to submenu_save_setpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% -------------------------------------------------------------------------
function submenu_save_model_Callback(hObject, eventdata, handles)
% hObject    handle to submenu_save_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% -------------------------------------------------------------------------
function submenu_load_setpoint_Callback(hObject, eventdata, handles)
% hObject    handle to submenu_load_setpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%--------------------------------------------------------------------------
function submenu_load_model_Callback(hObject, eventdata, handles)
% hObject    handle to submenu_load_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%--------------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%--------------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%--------------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function submenu_dump_model_Callback(hObject, eventdata, handles)
% hObject    handle to submenu_dump_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get magnet AO
AOmagnet = getappdata(handles.figure1,'AOmagnet');

fprintf('  DeviceName     Model   s(m)   phasex betax(m) etax(m) xcod(mm) phasez betaz(m) etaz(m) zcod(mm)\n')

FamilyName = fieldnames(AOmagnet); 
for k1 = 1:length(FamilyName)
    alias = AOmagnet.(FamilyName{k1});
    for k2 = 1 : length(AOmagnet.(FamilyName{k1}).CommonNames)
        fprintf('%15s %6.2f %6.2f  %6.2f  %6.2f  %6.2f  %6.2f  %6.2f  %6.2f  %6.2f  %6.2f \n', ...
            alias.DeviceName{k2}, alias.ModelVal(k2), ... 
            handles.spos(alias.AT.ATIndex(k2),1), handles.phase(alias.AT.ATIndex(k2),1), ...
            handles.beta(alias.AT.ATIndex(k2),1), handles.eta(alias.AT.ATIndex(k2),1), ...
            handles.cod(alias.AT.ATIndex(k2),1), ...
            handles.phase(alias.AT.ATIndex(k2),2), ...
            handles.beta(alias.AT.ATIndex(k2),2), handles.eta(alias.AT.ATIndex(k2),2), ...
            handles.cod(alias.AT.ATIndex(k2),2));
    end
end


%--------------------------------------------------------------------------
function submenu_dump_setpoint_Callback(hObject, eventdata, handles)
% hObject    handle to submenu_dump_setpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get magnet AO
AOmagnet = getappdata(handles.figure1,'AOmagnet');

fprintf('\n\n  DeviceName     TANGO\n')

FamilyName = fieldnames(AOmagnet); 
for k1 = 1:length(FamilyName)
    for k2 = 1 : length(AOmagnet.(FamilyName{k1}).CommonNames)
        alias = AOmagnet.(FamilyName{k1});
        fprintf('%15s %6.2f \n', alias.DeviceName{k2}, ...
            alias.TangoVal(k2));
    end
end


%--------------------------------------------------------------------------
function submenu_dump_soleil_setpoint_Callback(hObject, eventdata, handles)
% hObject    handle to submenu_dump_soleil_setpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fprintf('\n\n  DeviceName     Model  TANGO\n')

% Get magnet AO
AOmagnet = getappdata(handles.figure1,'AOmagnet');

FamilyName = fieldnames(AOmagnet); 
for k1 = 1:length(FamilyName)
    for k2 = 1 : length(AOmagnet.(FamilyName{k1}).CommonNames)
        alias = AOmagnet.(FamilyName{k1});
        fprintf('%15s %6.2f %6.2f\n', alias.DeviceName{k2}, ...
            alias.ModelVal(k2), alias.TangoVal(k2));
    end
end


% --------------------------------------------------------------------
function twiss_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to twiss_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function submenu_twissparameters_entry_Callback(hObject, eventdata, handles)
% hObject    handle to submenu_twissparameters_entry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

twiss_parameters_entry(handles)


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object deletion, before destroying properties.
function sliderQP1L_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP1L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over sliderQP1L.
function sliderQP1L_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP1L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on sliderQP1L and none of its controls.
function sliderQP1L_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP1L (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function sliderQP2L_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP2L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over sliderQP2L.
function sliderQP2L_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP2L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on sliderQP2L and none of its controls.
function sliderQP2L_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP2L (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function sliderQP3L_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP3L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over sliderQP3L.
function sliderQP3L_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP3L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on sliderQP3L and none of its controls.
function sliderQP3L_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP3L (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function sliderQP4L_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP4L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over sliderQP4L.
function sliderQP4L_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP4L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on sliderQP4L and none of its controls.
function sliderQP4L_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP4L (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function sliderQP5L_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP5L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over sliderQP5L.
function sliderQP5L_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP5L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on sliderQP5L and none of its controls.
function sliderQP5L_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP5L (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function sliderQP6L_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP6L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over sliderQP6L.
function sliderQP6L_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP6L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on sliderQP6L and none of its controls.
function sliderQP6L_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP6L (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function sliderQP7L_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP7L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over sliderQP7L.
function sliderQP7L_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP7L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on sliderQP7L and none of its controls.
function sliderQP7L_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to sliderQP7L (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function editQP1L_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to editQP1L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over editQP1L.
function editQP1L_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to editQP1L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on editQP1L and none of its controls.
function editQP1L_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to editQP1L (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function editQP2L_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to editQP2L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over editQP2L.
function editQP2L_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to editQP2L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on editQP2L and none of its controls.
function editQP2L_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to editQP2L (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function editQP3L_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to editQP3L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over editQP3L.
function editQP3L_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to editQP3L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on editQP3L and none of its controls.
function editQP3L_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to editQP3L (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
