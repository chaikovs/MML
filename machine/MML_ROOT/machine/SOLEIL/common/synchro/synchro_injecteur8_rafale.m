function varargout = synchro_injecteur8_rafale(varargin)
% SYNCHRO_INJECTEUR8_RAFALE M-file for synchro_injecteur8_rafale.fig
%      SYNCHRO_INJECTEUR8_RAFALE, by itself, creates a new SYNCHRO_INJECTEUR8_RAFALE or raises the existing
%      singleton*.
%
%      H = SYNCHRO_INJECTEUR8_RAFALE returns the handle to a new SYNCHRO_INJECTEUR8_RAFALE or the handle to
%      the existing singleton*.
%
%      SYNCHRO_INJECTEUR8_RAFALE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SYNCHRO_INJECTEUR8_RAFALE.M with the given input arguments.
%
%      SYNCHRO_INJECTEUR8_RAFALE('Property','Value',...) creates a new SYNCHRO_INJECTEUR8_RAFALE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before synchro_injecteur8_rafale_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to synchro_injecteur8_rafale_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% For the compiler
%#function aoinit setao setoperationalmode
%#function boosterinit
%#function magnetcoefficients
%

% Edit the above text to modify the response to help synchro_injecteur8_rafale

% Last Modified by GUIDE v2.5 23-Aug-2011 10:05:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @synchro_injecteur8_rafale_OpeningFcn, ...
                   'gui_OutputFcn',  @synchro_injecteur8_rafale_OutputFcn, ...
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


% --- Executes just before synchro_injecteur8_rafale is made visible.
function synchro_injecteur8_rafale_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to synchro_injecteur8_rafale (see VARARGIN)

% Choose default command line output for synchro_injecteur8_rafale
handles.output = hObject;

% list les devices annexe pour etat
fprintf('Liste devices annexes \n');
% name={'ANS-C03/DG/DCCT','LT1/DG/MC','BOO-C01/DG/DCCT',...
%     'ANS/DG/PUB-FillingMode', 'ANS/FC/INJ_COND'};
name={'ANS/DG/DCCT-CTRL','LT1/DG/MC','BOO-C01/DG/DCCT',...
    'ANS/DG/PUB-FillingMode', 'ANS/FC/INJ_COND'};
for i=1:4
    try
        txt=tango_command_inout2(name{2},'State');
        %temp=tango_read_attribute(name{i},'State');
        %temp=tango_read_attribute(name{i},'Status');txt=temp.value;
    catch
        txt='bug_device';
    end
    fprintf('%s   :   %s \n',name{i},txt);
end

% Added by Laurent
if isdeployed
    cd(getenv('MLROOT')); 
    setpathsoleil('Booster'); 
end
% End 

% Directories
%Directory='/home/production/matlab/matlabML/measdata/SOLEIL/Boosterdata/Datatemp'; % ALEX
Directory =  [getfamilydata('Directory','DataRoot') '../Boosterdata/Datatemp']; % Laurent
handles.Directory=Directory;  % for saved data

%FileName = fullfile+31.555cxxccx(getfamilydata('Directory', 'Synchro'), 'synchro_offset_lin_alim');
% DirName ='/home/production/matlab/matlabML/machine/SOLEIL/common/synchro/'; % ALEX
DirName = getfamilydata('Directory', 'Synchro'); % Laurent
handles.DirName=DirName;      % for offset & table

% Charge les offset
FileName = [DirName 'synchro_offset_lin'];
fprintf('Laurent:%s\n', FileName');
load(FileName, 'inj_offset' , 'ext_offset', 'lin_fin');
set(handles.inj_offset,'String',num2str(inj_offset));
set(handles.ext_offset,'String',num2str(ext_offset));
set(handles.lin_canon_spm_fin,'String',num2str(lin_fin));
% Periode linac fin
handles.lin_fin_step=0.090;                   % En ns  (90 ps)
handles.one_bunch=2.84/handles.lin_fin_step;  % Nombre de pas pour sauter un paquet

% Periode du trigger par defaut = 10 s
handles.periode = 10;
set(handles.periode_edit,'String',num2str(handles.periode));
set(handles.edit_Ncycle,'String',num2str(1));
set(handles.edit_Ncoup,'String',1.0);

%Memorise les dÃ©lais spare et soft initiaux
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSprStepDelay');
clk1=temp.value(1);
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay');
clk2=temp.value(1);

%Stocke les sauts pour les 4 quarts mode LPM
jump=int32([0 39 26 13]);
handles.clk_spare  =jump +  int32(clk1);
handles.clk_soft=jump  + int32(clk2);
handles.quart=1;

% Table initiale sur paquet 1
bunch=[1];
[dtour,dpaquet]=bucketnumber(bunch);
offset_linac=lin_fin/handles.lin_fin_step; 
bjump=handles.one_bunch;
dpaquet=dpaquet*bjump+offset_linac;
handles.table=int32([length(bunch) dtour dpaquet]);
handles.table0=handles.table;
handles.bunch=bunch;

handles.mode = 'Mode=???';
set(handles.edit_filling_relecture_tables,'Enable','off');
set(handles.edit_filling_relecture_bunch,'Enable','off');

% Verifie le mode selectionnÃ© en SPM ou LPM
% Verifie le mode central selectionnÃ©  : rafale ou continue
% Verifie le mode selectionnÃ© en SPM : 1 2 ou 3 paquets
% Verifie le mode d'injection selectionnÃ© : soft ou 3Hz
test_modes(handles);


% Choix des events
handles.event0 =int32(0);
handles.event00=int32(100);  %SpÃ©ciale EP

% Cache le tableau des dÃ©lais BPM
set(handles.panel_bpm,'Visible','off');
set(handles.uipanel_kicker_machine,'Visible','off');

% text affichage
handles.txt_inj=  ' INJECTION AUTOMATIQUE EN COURS '; % txt injection auto en cours
handles.txt_noinj=' INJECTION INTERDITE ';            % txt injection non autorise (Grp fonctionnement)

% Publisher - fonctionnement (gere sur injection en boucle)
tango_write_attribute2('ANS/DG/PUB-FillingMode','mode_auto',uint8(0))         % flag injection auto
tango_write_attribute2('ANS/DG/PUB-FillingMode','courant_consigne',uint8(0))  % flag courant consigne atteint
  
% tango parser ANS/FC/INJ_COND
% temp=tango_read_attribute2('ANS/FC/INJ_COND', 'COND_INJ');
% handles.cond_inj=temp.value;   % 0 no injection,  1 injection
% try temp=tango_read_attribute2('ANS/FC/INJ_COND', 'COND_INJ'); % 0 no injection,  1 injection
% val=temp.value; catch val=1 ; end ; if val~=0 ; val=1; end;
% handles.cond_inj=val;


% Fonction timer pour injection en boucle
% Creates timer Infinite loop
timer2=timer('StartDelay',1,...
    'ExecutionMode','fixedRate','Period',3,'TasksToExecute',Inf);
timer2.TimerFcn = {@fonction_alex2, hObject,eventdata, handles};
setappdata(handles.figure1,'Timer2',timer2);

% Creates timer Infinite loop
timer1=timer('StartDelay',1,...
    'ExecutionMode','fixedRate','Period',handles.periode,'TasksToExecute',Inf);
timer1.TimerFcn = {@fonction_alex1, hObject,eventdata, handles};
setappdata(handles.figure1,'Timer1',timer1);

% button group sur on/off timer du trigger
h = uibuttongroup('visible','off','Position',[0.7275 0.72 0.125 0.145],...
    'Title','','TitlePosition','centertop',...
    'BackgroundColor',[1 0.3 0 ]);
u1 = uicontrol('Style','Radio','String',' OFF','Tag','radiobutton1',...
    'pos',[05 85 55 25],'parent',h,'HandleVisibility','off',...
    'BackgroundColor',[1 0.3 0  ]);
u2 = uicontrol('Style','Radio','String',' Laps :','Tag','radiobutton2',...
    'pos',[05 45 55 25],'parent',h,'HandleVisibility','off',...
    'BackgroundColor',[1 0.3 0 ]);
u3 = uicontrol('Style','Radio','String',' Imin :','Tag','radiobutton3',...
    'pos',[05 05 55 25],'parent',h,'HandleVisibility','off',...
    'BackgroundColor',[1 0.3 0 ]);

set(h,'SelectionChangeFcn',...
    {@uibuttongroup_SelectionChangeFcn,handles});

handles.off = u1;
handles.on1 = u2;
handles.on2 = u3;

set(h,'SelectedObject',u1); 
set(h,'Visible','on');

%% Set closing gui function
set(handles.figure1,'CloseRequestFcn',{@Closinggui,timer1,handles.figure1});
set(handles.figure1,'CloseRequestFcn',{@Closinggui,timer2,handles.figure1});


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes synchro_injecteur8_rafale wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = synchro_injecteur8_rafale_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function boo_alim_dipole_Callback(hObject, eventdata, handles)
% hObject    handle to boo_alim_dipole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_alim_dipole as text
%        str2double(get(hObject,'String')) returns contents of boo_alim_dipole as a double
%h=gcf
delay=str2double(get(hObject,'String'));
tango_write_attribute2('BOO/SY/LOCAL.ALIM.1', 'dpTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function boo_alim_dipole_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_alim_dipole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function boo_alim_qf_Callback(hObject, eventdata, handles)
% hObject    handle to boo_alim_qf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_alim_qf as text
%        str2double(get(hObject,'String')) returns contents of boo_alim_qf as a double

delay=str2double(get(hObject,'String'));
tango_write_attribute2('BOO/SY/LOCAL.ALIM.1', 'qfTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function boo_alim_qf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_alim_qf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boo_alim_qd_Callback(hObject, eventdata, handles)
% hObject    handle to boo_alim_qd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_alim_qd as text
%        str2double(get(hObject,'String')) returns contents of boo_alim_qd as a double

delay=str2double(get(hObject,'String'));
tango_write_attribute2('BOO/SY/LOCAL.ALIM.1', 'qdTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function boo_alim_qd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_alim_qd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boo_alim_sf_Callback(hObject, eventdata, handles)
% hObject    handle to boo_alim_sf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_alim_sf as text
%        str2double(get(hObject,'String')) returns contents of boo_alim_sf as a double

delay=str2double(get(hObject,'String'));
tango_write_attribute2('BOO/SY/LOCAL.ALIM.1', 'sfTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function boo_alim_sf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_alim_sf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boo_alim_sd_Callback(hObject, eventdata, handles)
% hObject    handle to boo_alim_sd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_alim_sd as text
%        str2double(get(hObject,'String')) returns contents of boo_alim_sd as a double

delay=str2double(get(hObject,'String'));
tango_write_attribute2('BOO/SY/LOCAL.ALIM.1', 'sdTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function boo_alim_sd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_alim_sd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boo_rf_Callback(hObject, eventdata, handles)
% hObject    handle to boo_rf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_rf as text
%        str2double(get(hObject,'String')) returns contents of boo_rf as a double

delay=str2double(get(hObject,'String'));
tango_write_attribute2('BOO/SY/LOCAL.RF.1', 'rfTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function boo_rf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_rf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lin_canon_lpm_Callback(hObject, eventdata, handles)
% hObject    handle to lin_alim_canon_lpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lin_alim_canon_lpm as text
%        str2double(get(hObject,'String')) returns contents of lin_alim_canon_lpm as a double

inj_offset=str2double(get(handles.inj_offset,'String'));
delay=str2double(get(hObject,'String'))+inj_offset;
tango_write_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function lin_canon_lpm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lin_alim_canon_lpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lt1_emittance_Callback(hObject, eventdata, handles)
% hObject    handle to lt1_emittance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lt1_emittance as text
%        str2double(get(hObject,'String')) returns contents of lt1_emittance as a double
inj_offset=str2double(get(handles.inj_offset,'String'));
delay=str2double(get(hObject,'String'))+inj_offset;
tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'emittanceTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function lt1_emittance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lt1_emittance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lt1_MC1_Callback(hObject, eventdata, handles)
% hObject    handle to lt1_MC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lt1_MC1 as text
%        str2double(get(hObject,'String')) returns contents of lt1_MC1 as a double
inj_offset=str2double(get(handles.inj_offset,'String'));
delay=str2double(get(hObject,'String'))+inj_offset;
tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'mc.1TimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function lt1_MC1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lt1_MC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lt1_MC2_Callback(hObject, eventdata, handles)
% hObject    handle to lt1_MC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lt1_MC2 as text
%        str2double(get(hObject,'String')) returns contents of lt1_MC2 as a double
inj_offset=str2double(get(handles.inj_offset,'String'));
delay=str2double(get(hObject,'String'))+inj_offset;
tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'mc.2TimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function lt1_MC2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lt1_MC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lt1_osc_Callback(hObject, eventdata, handles)
% hObject    handle to lt1_osc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lt1_osc as text
%        str2double(get(hObject,'String')) returns contents of lt1_osc as a double
inj_offset=str2double(get(handles.inj_offset,'String'));
delay=str2double(get(hObject,'String'))+inj_offset;
tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'oscTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function lt1_osc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lt1_osc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sdc1_Callback(hObject, eventdata, handles)
% hObject    handle to sdc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sdc1 as text
%        str2double(get(hObject,'String')) returns contents of sdc1 as a double
inj_offset=str2double(get(handles.inj_offset,'String'));
delay=str2double(get(hObject,'String'))+inj_offset;
tango_write_attribute2('ANS/SY/LOCAL.SDC.1', 'oscTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function sdc1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sdc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boo_inj_septum_Callback(hObject, eventdata, handles)
% hObject    handle to boo_inj_septum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_inj_septum as text
%        str2double(get(hObject,'String')) returns contents of boo_inj_septum as a double
inj_offset=str2double(get(handles.inj_offset,'String'));
delay=str2double(get(hObject,'String'))+inj_offset;
tango_write_attribute2('BOO/SY/LOCAL.Binj.1', 'sep-p.trigTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function boo_inj_septum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_inj_septum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boo_inj_kicker_Callback(hObject, eventdata, handles)
% hObject    handle to boo_inj_kicker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_inj_kicker as text
%        str2double(get(hObject,'String')) returns contents of boo_inj_kicker as a double
inj_offset=str2double(get(handles.inj_offset,'String'));
delay=str2double(get(hObject,'String'))+inj_offset;
tango_write_attribute2('BOO/SY/LOCAL.Binj.1', 'k.trigTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function boo_inj_kicker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_inj_kicker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boo_bpm_Callback(hObject, eventdata, handles)
% hObject    handle to boo_bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_bpm as text
%        str2double(get(hObject,'String')) returns contents of boo_bpm as a double

inj_offset=str2double(get(handles.inj_offset,'String'));
delay=str2double(get(hObject,'String'))+inj_offset;
tango_write_attribute2('BOO/SY/LOCAL.DG.1', 'bpm-bta.trigTimeDelay',delay);
tango_write_attribute2('BOO/SY/LOCAL.DG.1', 'bpm-btd.trigTimeDelay',delay);
tango_write_attribute2('BOO/SY/LOCAL.DG.2', 'bpm-btb.trigTimeDelay',delay);
tango_write_attribute2('BOO/SY/LOCAL.DG.3', 'bpm-btc.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function boo_bpm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boo_nod_Callback(hObject, eventdata, handles)
% hObject    handle to boo_nod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_nod as text
%        str2double(get(hObject,'String')) returns contents of boo_nod as a double
inj_offset=str2double(get(handles.inj_offset,'String'));
delay=str2double(get(hObject,'String'))+inj_offset;
tango_write_attribute2('BOO/SY/LOCAL.DG.3', 'bpm-onde.trigTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function boo_nod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_nod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boo_dcct_Callback(hObject, eventdata, handles)
% hObject    handle to boo_dcct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_dcct as text
%        str2double(get(hObject,'String')) returns contents of boo_dcct as a double
inj_offset=str2double(get(handles.inj_offset,'String'));
delay=str2double(get(hObject,'String'))+inj_offset;
tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'dcct-booTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function boo_dcct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_dcct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lin_canon_spm_fin_Callback(hObject, eventdata, handles)
% hObject    handle to lin_alim_canon_spm_fin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lin_alim_canon_spm_fin as text
%        str2double(get(hObject,'String')) returns contents of lin_alim_canon_spm_fin as a double

inj_offset=str2double(get(handles.inj_offset,'String'));
ext_offset=str2double(get(handles.ext_offset,'String'));
lin_fin   =str2double(get(handles.lin_canon_spm_fin,'String'));

%FileName = fullfile(getfamilydata('Directory', 'Synchro'), 'synchro_offset_lin_alim');
FileName = [handles.DirName 'synchro_offset_lin'];
save(FileName, 'inj_offset' , 'ext_offset', 'lin_fin');

% --- Executes during object creation, after setting all properties.
function lin_canon_spm_fin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lin_alim_canon_spm_fin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function central_spare_Callback(hObject, eventdata, handles)
% hObject    handle to central_spare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of central_spare as text
%        str2double(get(hObject,'String')) returns contents of central_spare as a double

delay=str2double(get(hObject,'String'));
tango_write_attribute2('ANS/SY/CENTRAL', 'TSprTimeDelay',delay);

%status soft checked on linac
temp=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmEvent');
if (temp.value(1)==2)
   %
elseif (temp.value(1)==5)
    dt=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftTimeDelay');
    inj_offset=str2double(get(handles.inj_offset,'String'));
    dt1=tango_read_attribute2('ANS/SY/CENTRAL', 'TSprTimeDelay');
    delay=dt.value(1)-dt1.value(1)+inj_offset;
    tango_write_attribute2('LIN/SY/LOCAL.LPM.1', 'spareTimeDelay',delay);
    temp=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'spareTimeDelay');
    set(handles.lin_modulateur,'String',num2str(temp.value(1)-inj_offset));
end

% --- Executes during object creation, after setting all properties.
function central_spare_CreateFcn(hObject, eventdata, handles)
% hObject    handle to central_spare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function central_inj_Callback(hObject, eventdata, handles)
% hObject    handle to central_inj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of central_inj as text
%        str2double(get(hObject,'String')) returns contents of central_inj as a double

delay=str2double(get(hObject,'String'));
tango_write_attribute2('ANS/SY/CENTRAL', 'TInjTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function central_inj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to central_inj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function central_soft_Callback(hObject, eventdata, handles)
% hObject    handle to central_soft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of central_soft as text
%        str2double(get(hObject,'String')) returns contents of central_soft as a double

delay=str2double(get(hObject,'String'));
tango_write_attribute2('ANS/SY/CENTRAL', 'TSoftTimeDelay',delay);

% temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay');
% clkinj=int32(temp.value(1)+5*52);
% clkext=int32(temp.value(1)/52+10);
% tango_write_attribute2('ANS/SY/CENTRAL', 'TInjStepDelay',clkinj);
% tango_write_attribute2('ANS/SY/CENTRAL', 'ExtractionOffsetClkStepValue',clkext);
% 
% %status soft checked on linac
% temp=tango_read_attribute2('lin_alim/SY/LOCAL.LPM.1', 'spareEvent');
% if (temp.value(1)==2)
%    %
% elseif (temp.value(1)==1)
%     dt=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftTimeDelay');
%     inj_offset=str2double(get(handles.inj_offset,'String'));
%     dt1=tango_read_attribute2('ANS/SY/CENTRAL', 'TSprTimeDelay');
%     delay=dt.value(1)-dt1.value(1)+inj_offset;
%     tango_write_attribute2('lin_alim/SY/LOCAL.LPM.1', 'spareTimeDelay',delay);
%     temp=tango_read_attribute2('lin_alim/SY/LOCAL.LPM.1', 'spareTimeDelay');
%     set(handles.lin_alim_modulateur,'String',num2str(temp.value(1)-inj_offset));
% end

% --- Executes during object creation, after setting all properties.
function central_soft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to central_soft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_acquisition_nooffset.
function button_acquisition_nooffset_Callback(hObject, eventdata, handles)
% hObject    handle to button_acquisition_nooffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

test_modes(handles);


set(handles.inj_offset,'Enable','off');
set(handles.sdc1,'Enable','off');
set(handles.lin_canon_lpm,'Enable','off');
set(handles.lin_canon_spm,'Enable','off');
set(handles.lin_canon_spm_fin,'Enable','off');
set(handles.lin_alim,'Enable','off');
set(handles.boo_bpm,'Enable','off');
set(handles.lt1_emittance,'Enable','off');
set(handles.lt1_MC1,'Enable','off');
set(handles.lt1_MC2,'Enable','off');
set(handles.lt1_osc,'Enable','off');
set(handles.boo_dcct,'Enable','off');
set(handles.boo_nod,'Enable','off');
set(handles.boo_inj_septum,'Enable','off');
set(handles.boo_inj_kicker,'Enable','off');
set(handles.boo_alim_dipole,'Enable','off');
set(handles.boo_alim_qf,'Enable','off');
set(handles.boo_alim_qd,'Enable','off');
set(handles.boo_alim_sf,'Enable','off');
set(handles.boo_alim_sd,'Enable','off');
set(handles.boo_alim_cp,'Enable','off');
set(handles.boo_rf,'Enable','off');
set(handles.boo_mrsv,'Enable','off');
set(handles.lin_modulateur,'Enable','off');
set(handles.ext_offset,'Enable','off');
set(handles.boo_ext_dof,'Enable','off');
set(handles.boo_ext_sept_p,'Enable','off');
set(handles.boo_ext_sept_a,'Enable','off');
set(handles.boo_ext_kicker,'Enable','off');
set(handles.sdc2,'Enable','off');
set(handles.lt2_emittance,'Enable','off');
set(handles.lt2_osc,'Enable','off');
set(handles.lt2_bpm,'Enable','off');
set(handles.ans_inj_k1,'Enable','off');
set(handles.ans_inj_k2,'Enable','off');
set(handles.ans_inj_k3,'Enable','off');
set(handles.ans_inj_k4,'Enable','off');
set(handles.ans_inj_sept_p,'Enable','off');
set(handles.ans_inj_sept_a,'Enable','off');
set(handles.ans_fbt,'Enable','off');
set(handles.ans_dcct,'Enable','off');
set(handles.ans_nod,'Enable','off');
set(handles.ans_bpm_c01,'Enable','off');
set(handles.ans_bpm_c02,'Enable','off');
set(handles.ans_bpm_c03,'Enable','off');
set(handles.ans_bpm_c04,'Enable','off');
set(handles.ans_bpm_c05,'Enable','off');
set(handles.ans_bpm_c06,'Enable','off');
set(handles.ans_bpm_c07,'Enable','off');
set(handles.ans_bpm_c08,'Enable','off');
set(handles.ans_bpm_c09,'Enable','off');
set(handles.ans_bpm_c10,'Enable','off');
set(handles.ans_bpm_c11,'Enable','off');
set(handles.ans_bpm_c12,'Enable','off');
set(handles.ans_bpm_c13,'Enable','off');
set(handles.ans_bpm_c14,'Enable','off');
set(handles.ans_bpm_c15,'Enable','off');
set(handles.ans_bpm_c16,'Enable','off');

get_synchro_delay_nooffset(handles)
n=1;

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'libre.1TimeDelay');
try txt=num2str(temp.value(n)); catch txt='Bug device' ; end
set(handles.lin_alim,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.DG.3', 'emittanceTimeDelay');
try ;txt=num2str(temp.value(n)); catch txt=bug_device ; end
set(handles.boo_mrsv,'String',txt);

temp=tango_read_attribute2('ANS-C14/SY/LOCAL.DG.1', 'perteTimeDelay');
try ;txt=num2str(temp.value(n)); catch txt=bug_device ; end
set(handles.ans_nod,'String',txt);


%status soft checked on linac
temp=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmEvent');
if (temp.value(n)==2)
    %set(handles.soft_button,'Value',0);
elseif (temp.value(n)==5)
    %set(handles.soft_button,'Value',1);
end

%status tables
temp=tango_read_attribute('ANS/SY/CENTRAL', 'ExtractionOffsetClkStepValue');
offset=temp.value(1)*52;
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TablesCurrentDepth');
n=temp.value;
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'ExtractionDelayTable');
table=temp.value(1:n)-offset;
set(handles.edit_filling_relecture_tables,'String',['T=' , num2str(table)]);  



% --- Executes on button press in button_acquisition_delay.
function button_acquisition_delay_Callback(hObject, eventdata, handles)
% hObject    handle to button_acquisition_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bug_device='Bug device';

test_modes(handles);

set(handles.inj_offset,'Enable','on');
set(handles.sdc1,'Enable','on');
set(handles.lin_canon_lpm,'Enable','on');
set(handles.lin_canon_spm,'Enable','on');
set(handles.lin_canon_spm_fin,'Enable','on');
set(handles.lin_alim,'Enable','on');
set(handles.boo_bpm,'Enable','on');
set(handles.lt1_emittance,'Enable','on');
set(handles.lt1_MC1,'Enable','on');
set(handles.lt1_MC2,'Enable','on');
set(handles.lt1_osc,'Enable','on');
set(handles.boo_dcct,'Enable','on');
set(handles.boo_nod,'Enable','on');
set(handles.boo_inj_septum,'Enable','on');
set(handles.boo_inj_kicker,'Enable','on');
set(handles.boo_alim_dipole,'Enable','on');
set(handles.boo_alim_qf,'Enable','on');
set(handles.boo_alim_qd,'Enable','on');
set(handles.boo_alim_sf,'Enable','on');
set(handles.boo_alim_sd,'Enable','on');
set(handles.boo_alim_cp,'Enable','on');
set(handles.boo_rf,'Enable','on');
set(handles.boo_mrsv,'Enable','on');
set(handles.lin_modulateur,'Enable','on');
set(handles.ext_offset,'Enable','on');
set(handles.boo_ext_dof,'Enable','on');
set(handles.boo_ext_sept_p,'Enable','on');
set(handles.boo_ext_sept_a,'Enable','on');
set(handles.boo_ext_kicker,'Enable','on');
set(handles.sdc2,'Enable','on');
set(handles.lt2_emittance,'Enable','on');
set(handles.lt2_osc,'Enable','on');
set(handles.lt2_bpm,'Enable','on');
set(handles.ans_inj_k1,'Enable','on');
set(handles.ans_inj_k2,'Enable','on');
set(handles.ans_inj_k3,'Enable','on');
set(handles.ans_inj_k4,'Enable','on');
set(handles.ans_inj_sept_p,'Enable','on');
set(handles.ans_inj_sept_a,'Enable','on');
set(handles.ans_fbt,'Enable','on');
set(handles.ans_dcct,'Enable','on');
set(handles.ans_nod,'Enable','on');
set(handles.ans_bpm_c01,'Enable','on');
set(handles.ans_bpm_c02,'Enable','on');
set(handles.ans_bpm_c03,'Enable','on');
set(handles.ans_bpm_c04,'Enable','on');
set(handles.ans_bpm_c05,'Enable','on');
set(handles.ans_bpm_c06,'Enable','on');
set(handles.ans_bpm_c07,'Enable','on');
set(handles.ans_bpm_c08,'Enable','on');
set(handles.ans_bpm_c09,'Enable','on');
set(handles.ans_bpm_c10,'Enable','on');
set(handles.ans_bpm_c11,'Enable','on');
set(handles.ans_bpm_c12,'Enable','on');
set(handles.ans_bpm_c13,'Enable','on');
set(handles.ans_bpm_c14,'Enable','on');
set(handles.ans_bpm_c15,'Enable','on');
set(handles.ans_bpm_c16,'Enable','on');
set(handles.ans_k_pc,'Enable','on');
set(handles.ans_k_h,'Enable','on');
set(handles.ans_k_v,'Enable','on');


%FileName = fullfile(getfamilydata('Directory', 'Synchro'), 'synchro_offset_lin_alim');
FileName = [handles.DirName 'synchro_offset_lin'];
load(FileName, 'inj_offset' , 'ext_offset', 'lin_fin');
set(handles.inj_offset,'String',num2str(inj_offset));
set(handles.ext_offset,'String',num2str(ext_offset));
set(handles.lin_canon_spm_fin,'String',num2str(lin_fin));

get_synchro_delay(handles)
n=1;
ext_offset=str2double(get(handles.ext_offset,'String'));
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TPcTimeDelay');
set(handles.central_pc,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'libre.1TimeDelay');
try txt=num2str(temp.value(n)); catch txt='Bug device' ; end
set(handles.lin_alim,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.DG.3', 'emittanceTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.boo_mrsv,'String',txt);

temp=tango_read_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.pmTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_nod,'String',txt);


%status soft checked on linac
temp=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmEvent');
if (temp.value(n)==2)
    %set(handles.soft_button,'Value',0);
elseif (temp.value(n)==5)
    %set(handles.uipanel_mode,'String','Mode Soft');
end

%status tables
%temp=tango_read_attribute('ANS/SY/CENTRAL', 'ExtractionOffsetClkStepValue');
%offset=temp.value(1)*52;
offset_linac=10*lin_fin;
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TablesCurrentDepth');
n=temp.value;
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'ExtractionDelayTable');
table_ext=temp.value(1:n); %-offset_ext;
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'LinacDelayTable');
table_linac=(temp.value(1:n)-offset_linac)/28;
table=[];
for i=1:n
    table=[table ' ' '(' num2str([table_ext(i)])  ' '  num2str([table_linac(i)]) ')'];
end
set(handles.edit_filling_relecture_tables,'String',[num2str(table)]);
set(handles.edit_filling_relecture_bunch, 'String','??');



% --- Executes on button press in button_injection_soft.
function button_injection_soft_Callback(hObject, eventdata, handles)
% hObject    handle to button_injection_soft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% verifie si inj autorisé
% try temp=tango_read_attribute2('ANS/FC/INJ_COND', 'COND_INJ'); % 0 no injection,  1 injection
% val=temp.value; catch val=1 ; end ; if val~=0 ; val=1; end;
% 
% if (val==1)
%     
%     tic
%    [r1,r2]=fire_injection(handles);
%     toc
% else
%     % pas d'injection, tir non autorise
%     fprintf('%s\n','Gap U20  < limite    dans ANS/EI/GAP_U20_SECURITY');
% end

[r1,r2]=fire_injection(handles);

% check synchro booster
%flag=0 : OK
%falg=1 : mauvais delais
[flag]=check_boo_synchro;
if flag==1 && r1> 20
    set(handles.central_inj,'Backgroundcolor', [1 0 0]); % KO
else
    set(handles.central_inj,'Backgroundcolor', [1 1 1]); % OK
end

% % Warning mauvais rendement booster
% if r1 < 90
%     set(handles.edit_rboo,'Backgroundcolor', [1 0 0]); % KO
%     set(handles.edit_rboo,'Foregroundcolor', [0 0 0]); 
% else
%     set(handles.edit_rboo,'Backgroundcolor', [1 1 1]); % OK
%     set(handles.edit_rboo,'Foregroundcolor', [1 0 0]); 
% end

%
test_modes(handles);

function periode_edit_Callback(hObject, eventdata, handles)
% hObject    handle to periode_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of periode_edit as text
%        str2double(get(hObject,'String')) returns contents of periode_edit as a double

val_multishot = get(handles.on1,'Value');

if val_multishot
    errordlg('positionner le trigger a OFF !','Attention');
    return
else
    periode = str2double(get(hObject,'String'));

    % change timer Infinite loop
    timer1=timer('StartDelay',1,...
        'ExecutionMode','fixedRate','Period',periode,'TasksToExecute',Inf);
    timer1.TimerFcn = {@fonction_alex1, hObject,eventdata, handles};
    setappdata(handles.figure1,'Timer1',timer1);

    % Update handles structure
    guidata(hObject, handles);
    
    %getappdata(handles.figure1,'Timer1')
    
end



% --- Executes during object creation, after setting all properties.
function periode_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to periode_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function uibuttongroup_SelectionChangeFcn(hObject,eventdata,handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%handles = guidata(gcbo);
timer1 = getappdata(handles.figure1,'Timer1');
timer2 = getappdata(handles.figure1,'Timer2');

%txt1=' INJECTION EN COURS ';

switch get(get(hObject,'SelectedObject'),'Tag')  % Get Tag of selected object
    case 'radiobutton1'
        % stop du trigger
        stop(timer1);
        stop(timer2);
        set(handles.uipanel6,'Backgroundcolor', [1 0.3 0]);
        test_modes(handles);
        tango_write_attribute2('ANS/DG/PUB-FillingMode','mode_auto',uint8(0))
        tango_write_attribute2('ANS/DG/PUB-FillingMode','courant_consigne',uint8(0))
    case 'radiobutton2'
        % dÃ©marrage  du trigger 1
        start(timer1);
        set(handles.edit_modes,'String',handles.txt_inj);
        tango_write_attribute2('ANS/DG/PUB-FillingMode','mode_auto',uint8(1))
    case 'radiobutton3'
        % dÃ©marrage du trigger 2  
        temp=tango_read_attribute2('ANS/DG/DCCT-CTRL','current');anscur=temp.value;
        if (anscur>1.) 
           start(timer2);      
           set(handles.edit_modes,'String',handles.txt_inj);
           tango_write_attribute2('ANS/DG/PUB-FillingMode','mode_auto',uint8(1)) 
        else
            % ne fait rien, en cas de perte faisceau
        end
end


function fonction_alex1(arg1,arg2,hObject,eventdata,handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)set(handles.boo_alim_sd,'Enable','on');

color=get(handles.uipanel6,'Backgroundcolor');
if color==[1 0.3 0]
    set(handles.uipanel6,'Backgroundcolor', [1 0.3 1]);
elseif color==[1 0.3 1]
    set(handles.uipanel6,'Backgroundcolor', [1 0.3 0]);
end

button_injection_soft_Callback(hObject,eventdata,handles)


function fonction_alex2(arg1,arg2,hObject,eventdata,handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


temp=tango_read_attribute2('ANS/DG/DCCT-CTRL','current');anscur=temp.value;
set(handles.edit_courant_total,'String', num2str(anscur,'%5.2f'));
Imin=str2double(get(handles.edit_Imin,'String'));

color=get(handles.uipanel6,'Backgroundcolor');
if color==[1 0.3 0]
    set(handles.uipanel6,'Backgroundcolor', [1 0.3 1]);
elseif color==[1 0.3 1]
    set(handles.uipanel6,'Backgroundcolor', [1 0.3 0]);
end


if     (anscur>Imin)
    %on attend
    %fprintf('Cur = %g \n',anscur)
    tango_write_attribute2('ANS/DG/PUB-FillingMode','courant_consigne',uint8(1))
else
    %inject le cycle en cours
    %fprintf('Cur = %g : Injection \n',anscur)
    %set(handles.uipanel6,'Backgroundcolor', [1 1 0]);
    button_injection_soft_Callback(hObject, eventdata, handles)
end



%% What to do before closing the application
function Closinggui(obj, event, handles, figure1)

% Get default command line output from handles structure
answer = questdlg('Fermer softsynchro ?',...
    'Exit softsynchro',...
    'Yes','No','Yes');

switch answer
    case 'Yes'           
        delete(handles); %Delete Timer        
        delete(figure1); %Close gui
    otherwise
        disp('Closing aborted')
end



% --- Executes on button press in button_softmoins.
function button_softmoins_Callback(hObject, eventdata, handles)
% hObject    handle to button_softmoins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tt=0.6;

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay');
step=temp.value(1)-52;
tango_write_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay',step);
pause(2*tt)

%status soft checked on linac
temp=tango_read_attribute2('BOO/SY/LOCAL.Binj.1', 'k.trigEvent');
if (temp.value(1)==2)
    pause(tt)
    temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftTimeDelay');
    set(handles.central_soft,'String',num2str(temp.value(1)));
elseif (temp.value(1)==5)
    dt=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftTimeDelay');
    inj_offset=str2double(get(handles.inj_offset,'String'));
    dt1=tango_read_attribute2('ANS/SY/CENTRAL', 'TSprTimeDelay');
    delay=dt.value(1)-dt1.value(1)+inj_offset;
    tango_write_attribute2('LIN/SY/LOCAL.LPM.1', 'spareTimeDelay',delay);

    pause(tt)
    % read again for possible delay
    temp=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'spareTimeDelay');
    set(handles.lin_modulateur,'String',num2str(temp.value(1)-inj_offset));
    temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftTimeDelay');
    set(handles.central_soft,'String',num2str(temp.value(1)));
end



% --- Executes on button press in button_softplus.
function button_softplus_Callback(hObject, eventdata, handles)
% hObject    handle to button_softplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tt=0.6;

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay');
step=temp.value(1)+52;
tango_write_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay',step);
pause(2*tt)

%status soft checked on linac
temp=tango_read_attribute2('BOO/SY/LOCAL.Binj.1', 'k.trigEvent');
if (temp.value(1)==2)
    pause(tt)
    % read again for possible delay
    temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftTimeDelay');
    set(handles.central_soft,'String',num2str(temp.value(1)));
elseif (temp.value(1)==5)
    dt=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftTimeDelay');
    inj_offset=str2double(get(handles.inj_offset,'String'));
    dt1=tango_read_attribute2('ANS/SY/CENTRAL', 'TSprTimeDelay');
    delay=dt.value(1)-dt1.value(1)+inj_offset;
    tango_write_attribute2('LIN/SY/LOCAL.LPM.1', 'spareTimeDelay',delay);

    pause(tt)
    % read again for possible delay
    temp=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'spareTimeDelay');
    set(handles.lin_modulateur,'String',num2str(temp.value(1)-inj_offset));
    temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftTimeDelay');
    set(handles.central_soft,'String',num2str(temp.value(1)));
end



% --- Executes on button press in button_injmoins.
function button_injmoins_Callback(hObject, eventdata, handles)
% hObject    handle to button_injmoins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tt=0.6;

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TInjStepDelay');
step=temp.value(1)-52;
tango_write_attribute2('ANS/SY/CENTRAL', 'TInjStepDelay',step);
pause(2*tt)

%status soft checked on linac
temp=tango_read_attribute2('BOO/SY/LOCAL.Binj.1', 'k.trigEvent');
if (temp.value(1)==5)
    pause(tt)
    % read again for possible delay
    temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TInjTimeDelay');
    set(handles.central_inj,'String',num2str(temp.value(1)));
elseif (temp.value(1)==2)
%    commented With address spare = 2
%     dt=tango_read_attribute2('ANS/SY/CENTRAL', 'TInjTimeDelay');
%     inj_offset=str2double(get(handles.inj_offset,'String'));
%     dt1=tango_read_attribute2('ANS/SY/CENTRAL', 'TSprTimeDelay');
%     delay=dt.value(1)-dt1.value(1)+inj_offset;
%     tango_write_attribute2('lin_alim/SY/LOCAL.LPM.1', 'spareTimeDelay',delay);
% 
%     pause(tt)
%     % read again for possible delay
%     temp=tango_read_attribute2('lin_alim/SY/LOCAL.LPM.1', 'spareTimeDelay');
%     set(handles.lin_alim_modulateur,'String',num2str(temp.value(1)-inj_offset));
     temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TInjTimeDelay');
     set(handles.central_inj,'String',num2str(temp.value(1)));
end


% --- Executes on button press in button_injplus.
function button_injplus_Callback(hObject, eventdata, handles)
% hObject    handle to button_injplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tt=0.6;
set(handles.boo_alim_sd,'Enable','on');
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TInjStepDelay');
step=temp.value(1)+52;
tango_write_attribute2('ANS/SY/CENTRAL', 'TInjStepDelay',step);
pause(2*tt)

%status soft checked on linac
temp=tango_read_attribute2('BOO/SY/LOCAL.Binj.1', 'k.trigEvent');
if (temp.value(1)==5)
    pause(tt)
    % read again for possible delay
    temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TInjTimeDelay');
    set(handles.central_inj,'String',num2str(temp.value(1)));
elseif (temp.value(1)==2)
%    commented With address spare = 2
%     dt=tango_read_attribute2('ANS/SY/CENTRAL', 'TInjTimeDelay');
%     inj_offset=str2double(get(handles.inj_offset,'String'));
%     dt1=tango_read_attribute2('ANS/SY/CENTRAL', 'TSprTimeDelay');
%     delay=dt.value(1)-dt1.value(1)+inj_offset;
%     tango_write_attribute2('lin_alim/SY/LOCAL.LPM.1', 'spareTimeDelay',delay);
% 
%     pause(tt)
%     % read again for possible delay
%     temp=tango_read_attribute2('lin_alim/SY/LOCAL.LPM.1', 'spareTimeDelay');
%     set(handles.lin_alim_modulateur,'String',num2str(temp.value(1)-inj_offset));
     temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TInjTimeDelay');
     set(handles.central_inj,'String',num2str(temp.value(1)));
end






function boo_ext_sept_p_Callback(hObject, eventdata, handles)
% hObject    handle to boo_ext_sept_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_ext_sept_p as text
%        str2double(get(hObject,'String')) returns contents of boo_ext_sept_p as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-p.trigTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function boo_ext_sept_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_ext_sept_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function boo_ext_dof_Callback(hObject, eventdata, handles)
% hObject    handle to boo_ext_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_ext_dof as text
%        str2double(get(hObject,'String')) returns contents of boo_ext_dof as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'dof.trigTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function boo_ext_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_ext_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATset(handles.boo_alim_sd,'Enable','on');LAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function boo_ext_sept_a_Callback(hObject, eventdata, handles)
% hObject    handle to boo_ext_sept_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_ext_sept_a as text
%        str2double(get(hObject,'String')) returns contents of boo_ext_sept_a as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function boo_ext_sept_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_ext_sept_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boo_ext_kicker_Callback(hObject, eventdata, handles)
% hObject    handle to boo_ext_kicker (see GCBO)set(handles.boo_alim_sd,'Enable','on');
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_ext_kicker as text
%        str2double(get(hObject,'String')) returns contents of boo_ext_kicker as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'k.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function boo_ext_kicker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_ext_kicker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_inj_sept_p_Callback(hObject, eventdata, handles)
% hObject    handle to ans_inj_sept_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_inj_sept_p as text
%        str2double(get(hObject,'String')) returns contents of ans_inj_sept_p as a double

ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-p.trigTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function ans_inj_sept_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_inj_sept_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_inj_sept_a_Callback(hObject, eventdata, handles)
% hObject    handle to ans_inj_sept_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_inj_sept_a as text
%        str2double(get(hObject,'String')) returns contents of ans_inj_sept_a as a double

ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function ans_inj_sept_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_inj_sept_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_inj_k1_Callback(hObject, eventdata, handles)
% hObject    handle to ans_inj_k1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_inj_k1 as text
%        str2double(get(hObject,'String')) returns contents of ans_inj_k1 as a double

ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigTimeDelay',delay);



% --- Executes during object creation, after setting all properties.
function ans_inj_k1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_inj_k1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_inj_k2_Callback(hObject, eventdata, handles)
% hObject    handle to ans_inj_k2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_inj_k2 as text
%        str2double(get(hObject,'String')) returns contents of ans_inj_k2 as a double

ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function ans_inj_k2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_inj_k2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATset(handles.boo_alim_sd,'Enable','on');LAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_inj_k3_Callback(hObject, eventdata, handles)
% hObject    handle to ans_inj_k3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_inj_k3 as text
%        str2double(get(hObject,'String')) returns contents of ans_inj_k3 as a double

ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function ans_inj_k3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_inj_k3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_inj_k4_Callback(hObject, eventdata, handles)
% hObject    handle to ans_inj_k4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_inj_k4 as text
%        str2double(get(hObject,'String')) returns contents of ans_inj_k4 as a double

ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function ans_inj_k4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_inj_k4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_dcct_Callback(hObject, eventdata, handles)
% hObject    handle to ans_dcct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_dcct as text
%        str2double(get(hObject,'String')) returns contents of ans_dcct as a double

ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C14/SY/LOCAL.DG.1', 'perteTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_dcct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_dcct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_fbt_Callback(hObject, eventdata, handles)
% hObject    handle to ans_fbt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_fbt as text
%        str2double(get(hObject,'String')) returns contents of ans_fbt as a double

ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C07/SY/LOCAL.DG.1', 'libre.1TimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_fbt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_fbt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function central_ext_Callback(hObject, eventdata, handles)
% hObject    handle to central_ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of central_ext as text
%        str2double(get(hObject,'String')) returns contents of central_ext as a double
%'ANS/SY/CENTRAL', 'ExtractionOffsetTimeValue'

delay=str2double(get(hObject,'String'));
tango_write_attribute2('ANS/SY/CENTRAL', 'ExtractionOffsetTimeValue',delay);

% --- Executes during object creation, after setting all properties.
function central_ext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to central_ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function central_soft1_Callback(hObject, eventdata, handles)
% hObject    handle to central_soft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of central_soft as text
%        str2double(get(hObject,'String')) returns contents of central_soft as a double



% --- Executes during object creation, after setting all properties.
function central_soft1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to central_soft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_extmoins.
function button_extmoins_Callback(hObject, eventdata, handles)
% hObject    handle to button_extmoins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dclk=10;
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'ExtractionOffsetClkStepValue');
step=temp.value(1)-dclk;
tango_write_attribute2('ANS/SY/CENTRAL', 'ExtractionOffsetClkStepValue',int32(step));
temp=tango_read_attribute2('ANS/SY/CENTRAL','ExtractionOffsetTimeValue');
set(handles.central_ext,'String',num2str(temp.value(1)));

% on fait suivre les septa actif
% temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigStepDelay');boo=temp.value(1);
% tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigStepDelay',double(boo-dclk*52*184/2));
% temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigStepDelay');ans=temp.value(1);
% tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigStepDelay',double(ans-dclk*52*184/2))

% --- Executes on button press in button_extplus.
function button_extplus_Callback(hObject, eventdata, handles)
% hObject    handle to button_extplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dclk=10;
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'ExtractionOffsetClkStepValue');
step=temp.value(1)+dclk;
tango_write_attribute2('ANS/SY/CENTRAL', 'ExtractionOffsetClkStepValue',int32(step));
temp=tango_read_attribute2('ANS/SY/CENTRAL','ExtractionOffsetTimeValue');
set(handles.central_ext,'String',num2str(temp.value(1)));

% on fait suivre les septa actif
% temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigStepDelay');boo=temp.value(1);
% tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigStepDelay',double(boo+dclk*52*184/2));
% temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigStepDelay');ans=temp.value(1);
% tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigStepDelay',double(ans+dclk*52*184/2))

function sdc2_Callback(hObject, eventdata, handles)
% hObject    handle to sdc2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sdc2 as text
%        str2double(get(hObject,'String')) returns contents of sdc2 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS/SY/LOCAL.SDC.1', 'spareTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function sdc2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sdc2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lt2_emittance_Callback(hObject, eventdata, handles)
% hObject    handle to lt2_emittance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lt2_emittance as text
%        str2double(get(hObject,'String')) returns contents of lt2_emittance as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('LT2/SY/LOCAL.DG.1', 'mrsvTimeDelay',delay);
tango_write_attribute2('BOO/SY/LOCAL.DG.3', 'emittanceTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function lt2_emittance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lt2_emittance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lt2_bpm_Callback(hObject, eventdata, handles)
% hObject    handle to lt2_bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lt2_bpm as text
%        str2double(get(hObject,'String')) returns contents of lt2_bpm as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('LT2/SY/LOCAL.DG.2', 'bpm.trigTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function lt2_bpm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lt2_bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lt2_osc_Callback(hObject, eventdata, handles)
% hObject    handle to lt2_osc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lt2_osc as text
%        str2double(get(hObject,'String')) returns contents of lt2_osc as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('LT2/SY/LOCAL.DG.1', 'osc-fctTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function lt2_osc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lt2_osc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lin_modulateur_Callback(hObject, eventdata, handles)
% hObject    handle to lin_alim_modulateur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lin_alim_modulateur as text
%        str2double(get(hObject,'String')) returns contents of lin_alim_modulateur as a double
inj_offset=str2double(get(handles.inj_offset,'String'));
delay=str2double(get(hObject,'String'))+inj_offset;
tango_write_attribute2('LIN/SY/LOCAL.LPM.1', 'spareTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function lin_modulateur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lin_alim_modulateur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inj_offset_Callback(hObject, eventdata, handles)
% hObject    handle to inj_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inj_offset as text
%        str2double(get(hObject,'String')) returns contents of inj_offset as a double

inj_offset=str2double(get(hObject,'String'));
ext_offset=str2double(get(handles.ext_offset,'String'));
lin_fin   =str2double(get(handles.lin_canon_spm_fin,'String'));
%FileName = fullfile(getfamilydata('Directory', 'Synchro'), 'synchro_offset_lin_alim');
FileName = [handles.DirName 'synchro_offset_lin'];
save(FileName, 'inj_offset' , 'ext_offset', 'lin_fin')

%lin_alim
delay=str2double(get(handles.lin_canon_lpm,'String'))+inj_offset;
tango_write_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmTimeDelay',delay);

delay=str2double(get(handles.lin_canon_spm,'String'))+inj_offset;
tango_write_attribute2('LIN/SY/LOCAL.SPM.1', 'spmLinacTimeDelay',delay);

delay=str2double(get(handles.lin_modulateur,'String'))+inj_offset;
tango_write_attribute2('LIN/SY/LOCAL.LPM.1', 'spareTimeDelay',delay);

delay=str2double(get(handles.sdc1,'String'))+inj_offset;
tango_write_attribute2('ANS/SY/LOCAL.SDC.1', 'oscTimeDelay',delay);


% LT1
delay=str2double(get(handles.lt1_MC2,'String'))+inj_offset;
tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'mc.2TimeDelay',delay);

delay=str2double(get(handles.lt1_MC1,'String'))+inj_offset;
tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'mc.1TimeDelay',delay);

delay=str2double(get(handles.lt1_emittance,'String'))+inj_offset;
tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'emittanceTimeDelay',delay);

delay=str2double(get(handles.lt1_osc,'String'))+inj_offset;
tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'oscTimeDelay',delay);


% BOO
delay=str2double(get(handles.boo_inj_septum,'String'))+inj_offset;
tango_write_attribute2('BOO/SY/LOCAL.Binj.1', 'sep-p.trigTimeDelay',delay);

delay=str2double(get(handles.boo_inj_kicker,'String'))+inj_offset;
tango_write_attribute2('BOO/SY/LOCAL.Binj.1', 'k.trigTimeDelay',delay);

delay=str2double(get(handles.boo_bpm,'String'))+inj_offset;
tango_write_attribute2('BOO/SY/LOCAL.DG.1', 'bpm-bta.trigTimeDelay',delay);
tango_write_attribute2('BOO/SY/LOCAL.DG.1', 'bpm-btd.trigTimeDelay',delay);
tango_write_attribute2('BOO/SY/LOCAL.DG.2', 'bpm-btb.trigTimeDelay',delay);
tango_write_attribute2('BOO/SY/LOCAL.DG.3', 'bpm-btc.trigTimeDelay',delay);


delay=str2double(get(handles.boo_nod,'String'))+inj_offset;
tango_write_attribute2('BOO/SY/LOCAL.DG.3', 'bpm-onde.trigTimeDelay',delay);

% delay=str2double(get(handles.boo_dcct,'String'))+inj_offset;
% tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'dcct-booTimeDelay',delay);



% --- Executes during object creation, after setting all properties.
function inj_offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inj_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ext_offset_Callback(hObject, eventdata, handles)
% hObject    handle to ext_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ext_offset as text
%        str2double(get(hObject,'String')) returns contents of ext_offset as a double

ext_offset=str2double(get(hObject,'String'));
inj_offset=str2double(get(handles.inj_offset,'String'));
lin_fin   =str2double(get(handles.lin_canon_spm_fin,'String'));

%FileName = fullfile(getfamilydata('Directory', 'Synchro'), 'synchro_offset_lin_alim');
FileName = [handles.DirName 'synchro_offset_lin'];
save(FileName, 'inj_offset' , 'ext_offset', 'lin_fin');


%BOO
delay=str2double(get(handles.boo_ext_dof,'String'))+ext_offset;
tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'dof.trigTimeDelay',delay);

delay=str2double(get(handles.boo_ext_sept_p,'String'))+ext_offset;
tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-p.trigTimeDelay',delay);

delay=str2double(get(handles.boo_ext_sept_a,'String'))+ext_offset;
tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigTimeDelay',delay);

delay=str2double(get(handles.boo_ext_kicker,'String'))+ext_offset;
tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'k.trigTimeDelay',delay);

delay=str2double(get(handles.sdc2,'String'))+ext_offset;
tango_write_attribute2('ANS/SY/LOCAL.SDC.1', 'spareTimeDelay',delay);

%LT2
delay=str2double(get(handles.lt2_bpm,'String'))+ext_offset;
tango_write_attribute2('LT2/SY/LOCAL.DG.2', 'bpm.trigTimeDelay',delay);

delay=str2double(get(handles.lt2_osc,'String'))+ext_offset;
tango_write_attribute2('LT2/SY/LOCAL.DG.1', 'osc-fctTimeDelay',delay);

delay=str2double(get(handles.lt2_emittance,'String'))+ext_offset;
tango_write_attribute2('LT2/SY/LOCAL.DG.1', 'mrsvTimeDelay',delay);

%ANS

delay=str2double(get(handles.ans_inj_sept_a,'String'))+ext_offset;
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigTimeDelay',delay);

delay=str2double(get(handles.ans_inj_sept_p,'String'))+ext_offset;
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-p.trigTimeDelay',delay);

delay=str2double(get(handles.ans_inj_k1,'String'))+ext_offset;
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigTimeDelay',delay);

delay=str2double(get(handles.ans_inj_k2,'String'))+ext_offset;
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigTimeDelay',delay);

delay=str2double(get(handles.ans_inj_k3,'String'))+ext_offset;
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigTimeDelay',delay);

delay=str2double(get(handles.ans_inj_k4,'String'))+ext_offset;
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigTimeDelay',delay);



% --- Executes during object creation, after setting all properties.
function ext_offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ext_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_acquisition_address.
function button_acquisition_address_Callback(hObject, eventdata, handles)
% hObject    handle to button_acquisition_address (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

test_modes(handles);


set(handles.inj_offset,'Enable','off');
set(handles.sdc1,'Enable','off');
set(handles.lin_canon_lpm,'Enable','off');
set(handles.lin_canon_spm,'Enable','off');
set(handles.lin_canon_spm_fin,'Enable','off');
set(handles.lin_alim,'Enable','off');
set(handles.boo_bpm,'Enable','off');
set(handles.lt1_emittance,'Enable','off');
set(handles.lt1_MC1,'Enable','off');
set(handles.lt1_MC2,'Enable','off');
set(handles.lt1_osc,'Enable','off');
set(handles.boo_dcct,'Enable','off');
set(handles.boo_nod,'Enable','off');
set(handles.boo_inj_septum,'Enable','off');
set(handles.boo_inj_kicker,'Enable','off');
set(handles.boo_alim_dipole,'Enable','off');
set(handles.boo_alim_qf,'Enable','off');
set(handles.boo_alim_qd,'Enable','off');
set(handles.boo_alim_sf,'Enable','off');
set(handles.boo_alim_sd,'Enable','off');
set(handles.boo_alim_cp,'Enable','off');
set(handles.boo_rf,'Enable','off');
set(handles.boo_mrsv,'Enable','off');
set(handles.lin_modulateur,'Enable','off');
set(handles.ext_offset,'Enable','off');
set(handles.boo_ext_dof,'Enable','off');
set(handles.boo_ext_sept_p,'Enable','off');
set(handles.boo_ext_sept_a,'Enable','off');
set(handles.boo_ext_kicker,'Enable','off');
set(handles.sdc2,'Enable','off');
set(handles.lt2_emittance,'Enable','off');
set(handles.lt2_osc,'Enable','off');
set(handles.lt2_bpm,'Enable','off');
set(handles.ans_inj_k1,'Enable','off');
set(handles.ans_inj_k2,'Enable','off');
set(handles.ans_inj_k3,'Enable','off');
set(handles.ans_inj_k4,'Enable','off');
set(handles.ans_inj_sept_p,'Enable','off');
set(handles.ans_inj_sept_a,'Enable','off');
set(handles.ans_fbt,'Enable','off');
set(handles.ans_dcct,'Enable','off');
set(handles.ans_nod,'Enable','off');
set(handles.ans_bpm_c01,'Enable','off');
set(handles.ans_bpm_c02,'Enable','off');
set(handles.ans_bpm_c03,'Enable','off');
set(handles.ans_bpm_c04,'Enable','off');
set(handles.ans_bpm_c05,'Enable','off');
set(handles.ans_bpm_c06,'Enable','off');
set(handles.ans_bpm_c07,'Enable','off');
set(handles.ans_bpm_c08,'Enable','off');
set(handles.ans_bpm_c09,'Enable','off');
set(handles.ans_bpm_c10,'Enable','off');
set(handles.ans_bpm_c11,'Enable','off');
set(handles.ans_bpm_c12,'Enable','off');
set(handles.ans_bpm_c13,'Enable','off');
set(handles.ans_bpm_c14,'Enable','off');
set(handles.ans_bpm_c15,'Enable','off');
set(handles.ans_bpm_c16,'Enable','off');


%FileName = fullfile(getfamilydata('Directory', 'Synchro'), 'synchro_offset_lin_alim');
FileName = [handles.DirName 'synchro_offset_lin'];
load(FileName, 'inj_offset' , 'ext_offset', 'lin_fin');
set(handles.inj_offset,'String',num2str(inj_offset));
set(handles.ext_offset,'String',num2str(ext_offset));
set(handles.lin_canon_spm_fin,'String',num2str(lin_fin));

get_synchro_address(handles)
n=1;
temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'libre.1Event');
try txt=num2str(temp.value(n)); catch txt='Bug device' ; end
set(handles.lin_alim,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.DG.3', 'emittanceEvent');
try ;txt=num2str(temp.value(n)); catch txt=bug_device ; end
set(handles.boo_mrsv,'String',txt);

temp=tango_read_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.pmEvent');
try ;txt=num2str(temp.value(n)); catch txt=bug_device ; end
set(handles.ans_nod,'String',txt);
set(handles.boo_alim_sd,'Enable','off');

% --- Executes on button press in button_offinj_moins.
function button_offinj_moins_Callback(hObject, eventdata, handles)
% hObject    handle to button_offinj_moins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

temp=str2double(get(handles.inj_offset,'String'));
step=temp-52*0.52243;
set(handles.inj_offset,'String',step);
inj_offset_Callback(handles.inj_offset, eventdata, handles);

% --- Executes on button press in button_offinj_plus.
function button_offinj_plus_Callback(hObject, eventdata, handles)
% hObject    handle to button_offinj_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

temp=str2double(get(handles.inj_offset,'String'));
step=temp+52*0.52243;
set(handles.inj_offset,'String',step);
inj_offset_Callback(handles.inj_offset, eventdata, handles);

% --- Executes on button press in button_offext_moins.
function button_offext_moins_Callback(hObject, eventdata, handles)
% hObject    handle to button_offext_moins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

temp=str2double(get(handles.ext_offset,'String'));
step=temp-52*0.52243;
set(handles.ext_offset,'String',step);
ext_offset_Callback(handles.ext_offset, eventdata, handles);

% --- Executes on button press in button_offext_plus.
function button_offext_plus_Callback(hObject, eventdata, handles)
% hObject    handle to button_offext_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

temp=str2double(get(handles.ext_offset,'String'));
step=temp+52*0.52243;
set(handles.ext_offset,'String',step);
ext_offset_Callback(handles.ext_offset, eventdata, handles);


% --- Executes on button press in button_bpm.
function button_bpm_Callback(hObject, eventdata, handles)
% hObject    handle to button_bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_bpm

bpm=get(hObject,'Value');

if (bpm==0)
   set(handles.panel_bpm,'Visible','off');
elseif (bpm==1)
    set(handles.panel_bpm,'Visible','on');
end



function ans_bpm_c01_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c01 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c01 as a double

ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C01/SY/LOCAL.DG.2', 'bpm.trigTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function ans_bpm_c01_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ans_bpm_c02_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c02 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c02 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C02/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c02_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c03_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c03 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c03 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C03/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c03_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c03 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c04_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c04 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c04 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c04 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C04/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c04_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c04 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c05_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c05 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c05 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c05 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C05/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c05_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c05 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c06_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c06 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c06 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c06 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C06/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c06_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c06 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c07_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c07 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c07 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c07 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C07/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c07_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c07 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c08_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c08 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c08 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c08 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c08_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c08 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c09_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c09 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c09 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c09 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C09/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c09_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c09 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c10_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c10 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c10 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C10/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c11_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c11 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c11 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C11/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c12_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c12 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c12 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C12/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c13_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c13 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c13 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C13/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c14_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c14 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c14 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C14/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c15_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c15 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c15 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C15/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_bpm_c16_Callback(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_bpm_c16 as text
%        str2double(get(hObject,'String')) returns contents of ans_bpm_c16 as a double
ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C16/SY/LOCAL.DG.1', 'bpm.trigTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_bpm_c16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_bpm_c16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_filling_relecture_tables_Callback(hObject, eventdata, handles)
% hObject    handle to edit_filling_relecture_tables (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_filling_relecture_tables as text
%        str2double(get(hObject,'String')) returns contents of edit_filling_relecture_tables as a double


% --- Executes during object creation, after setting all properties.
function edit_filling_relecture_tables_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_filling_relecture_tables (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_filling_relecture_bunch_Callback(hObject, eventdata, handles)
% hObject    handle to edit_filling_relecture_bunch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_filling_relecture_bunch as text
%        str2double(get(hObject,'String')) returns contents of edit_filling_relecture_bunch as a double


% --- Executes during object creation, after setting all properties.
function edit_filling_relecture_bunch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_filling_relecture_bunch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_filling_entrer_bunch_Callback(hObject, eventdata, handles)
% hObject    handle to edit_filling_entrer_bunch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_filling_entrer_bunch as text
%        str2double(get(hObject,'String')) returns contents of edit_filling_entrer_bunch as a double

%set(handles.listbox_fillingmode,'value',12);
%listbox_fillingmode_Callback;

% --- Executes during object creation, after setting all properties.
function edit_filling_entrer_bunch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_filling_entrer_bunch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_update.
function button_update_Callback(hObject, eventdata, handles)
% hObject    handle to button_update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

do_update

% --- Executes on button press in button_acquisition_trigstatus.
function button_acquisition_trigstatus_Callback(hObject, eventdata, handles)
% hObject    handle to button_acquisition_trigstatus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

test_modes(handles);

set(handles.inj_offset,'Enable','off');
set(handles.sdc1,'Enable','off');
set(handles.lin_canon_lpm,'Enable','off');set(handles.boo_alim_sd,'Enable','off');
set(handles.lin_canon_spm,'Enable','off');
set(handles.lin_canon_spm_fin,'Enable','off');
set(handles.lin_alim,'Enable','off');
set(handles.boo_bpm,'Enable','off');
set(handles.lt1_emittance,'Enable','off');
set(handles.lt1_MC1,'Enable','off');
set(handles.lt1_MC2,'Enable','off');
set(handles.lt1_osc,'Enable','off');
set(handles.boo_dcct,'Enable','off');
set(handles.boo_nod,'Enable','off');
set(handles.boo_inj_septum,'Enable','off');
set(handles.boo_inj_kicker,'Enable','off');
set(handles.boo_alim_dipole,'Enable','off');
set(handles.boo_alim_qf,'Enable','off');
set(handles.boo_alim_qd,'Enable','off');
set(handles.boo_alim_sf,'Enable','off');
set(handles.boo_alim_sd,'Enable','off');
set(handles.boo_alim_cp,'Enable','off');
set(handles.boo_rf,'Enable','off');
set(handles.boo_mrsv,'Enable','off');
set(handles.lin_modulateur,'Enable','off');
set(handles.ext_offset,'Enable','off');
set(handles.boo_ext_dof,'Enable','off');
set(handles.boo_ext_sept_p,'Enable','off');
set(handles.boo_ext_sept_a,'Enable','off');
set(handles.boo_ext_kicker,'Enable','off');
set(handles.sdc2,'Enable','off');
set(handles.lt2_emittance,'Enable','off');
set(handles.lt2_osc,'Enable','off');
set(handles.lt2_bpm,'Enable','off');
set(handles.ans_inj_k1,'Enable','off');
set(handles.ans_inj_k2,'Enable','off');
set(handles.ans_inj_k3,'Enable','off');
set(handles.ans_inj_k4,'Enable','off');
set(handles.ans_inj_sept_p,'Enable','off');
set(handles.ans_inj_sept_a,'Enable','off');
set(handles.ans_fbt,'Enable','off');
set(handles.ans_dcct,'Enable','off');
set(handles.ans_nod,'Enable','off');
set(handles.ans_bpm_c01,'Enable','off');
set(handles.ans_bpm_c02,'Enable','off');
set(handles.ans_bpm_c03,'Enable','off');
set(handles.ans_bpm_c04,'Enable','off');
set(handles.ans_bpm_c05,'Enable','off');
set(handles.ans_bpm_c06,'Enable','off');
set(handles.ans_bpm_c07,'Enable','off');
set(handles.ans_bpm_c08,'Enable','off');
set(handles.ans_bpm_c09,'Enable','off');
set(handles.ans_bpm_c10,'Enable','off');
set(handles.ans_bpm_c11,'Enable','off');
set(handles.ans_bpm_c12,'Enable','off');
set(handles.ans_bpm_c13,'Enable','off');
set(handles.ans_bpm_c14,'Enable','off');
set(handles.ans_bpm_c15,'Enable','off');
set(handles.ans_bpm_c16,'Enable','off');

get_synchro_trigstatus(handles)



% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on selection change in listbox_fillingmode.
function listbox_fillingmode_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fillingmode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox_fillingmode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fillingmode
pattern=get(hObject,'String');
mode=get(hObject,'Value');
fprintf('***************************************************\n')
fprintf('Mode de remplissage sÃ©lectionnÃ© : %s\n',pattern{mode})
fprintf('***************************************************\n')


% PrÃ©pare les tables pour le 3 Hz
quart=[1 105 209 313];
temp=tango_read_attribute('ANS/SY/CENTRAL', 'ExtractionOffsetClkStepValue');
offset_ext=temp.value(1)*52;
offset_linac=str2double(get(handles.lin_canon_spm_fin,'String')) ;% dÃ©lai fin de rÃ©glage en ns
offset_linac=offset_linac/handles.lin_fin_step;                   % dÃ©lai fin de rÃ©glage en pas de handles.lin_fin_step ps
bjump=handles.one_bunch;


if (mode<=4)    %LPM
    bunch=quart(mode);
    fillingmode='1/4';
elseif (mode>4)&&(mode<=7) %LPM
    bunch=quart(1:(mode-3));
    if mode==5 ; fillingmode='1/2'; end
    if mode==6 ; fillingmode='3/4'; end
    if mode==7 ; fillingmode='4/4'; end
elseif (mode==8)    %LPM
    bunch=[365-52];      % SPM hybride
    %bunch=[0 104+32 2*(104+40)]+1; % spÃ©cial 3/4
    fillingmode='3/4';
elseif (mode==9)   % SPM    1 paquet
    bunch=[1];
    fillingmode='1 bunch';
elseif (mode==10)  % SPM    8 paquets
    bunch=[0:7]*52+1;
    fillingmode='8 bunches';
elseif (mode==11)  % SPM    16 paquets
    %bunch=[0:15]*26+1;
    fillingmode='16 bunches';
    % Ludo, tu remplis bunch ici
     bunch=[1:25];
%     
    bunch=[bunch  ([1:25]+1*32)];
    bunch=[bunch  ([1:25]+2*32)];
    bunch=[bunch  ([1:25]+3*32)];
    bunch=[bunch  ([1:25]+4*32)];
    bunch=[bunch  ([1:25]+5*32)];
    bunch=[bunch  ([1:25]+6*32)];
    bunch=[bunch  ([1:25]+7*32)];
    bunch=[bunch  ([1:25]+8*32)];
    bunch=[bunch  ([1:25]+9*32)];
    bunch=[bunch  ([1:25]+10*32)];
    bunch=[bunch  ([1:25]+11*32)];
    bunch=[bunch  ([1:25]+12*32)];
    
elseif (mode==12)  % SPM    n paquets
    bunch=str2num(get(handles.edit_filling_entrer_bunch,'String'));
    if isempty(bunch)
        set(handles.edit_filling_entrer_bunch,'String','Bug format');
    end
    fillingmode='Few bunches';

%     bunch=[0:12]*32+1;
%     fillingmode='3/4';
    
%     bunch=[0 136 272]+1;
%     fillingmode='LPM spaced 3/4';

%     bunch=[0 2 4 6]*52+1;
%     fillingmode='LPM 8 pulses';

%     bunch=[1 105 209 313  1 105 209];
%     fillingmode='3.5/4';

elseif (mode==13)  % SPM    n paquets
    paq=str2num(get(handles.edit_filling_entrer_bunch1,'String'));
    if (length(paq) == 2)
       bunch=paq(1):paq(2);
    else
       set(handles.edit_filling_entrer_bunch1,'String','Bug format')
    end
    fillingmode='Few bunches';

%     bunch=[1 3 5 7]*52+1 + 8;
%     fillingmode='LPM 8 pulses';
end

% Renseigne le filling Mode
tango_write_attribute2('ANS/DG/PUB-FillingMode', 'fillingMode',fillingmode)

% Charge la longueur de la rafale par dÃ©faut sur un cycle
Ncoup=length(bunch);
boucle=int16(str2double(get(handles.edit_Ncycle,'String')));
if Ncoup>=1
    set(handles.edit_Ncoup,'String',num2str(Ncoup));
    tango_write_attribute2('ANS/SY/CENTRAL', 'burstSize',int32(Ncoup*boucle));
end
    
    
[dtour,dpaquet]=bucketnumber(bunch);
dpaquet=dpaquet*bjump+offset_linac;
table=int32([length(bunch) dtour dpaquet]);
handles.table=table;
handles.bunch=bunch;

%FileName = fullfile(getfamilydata('Directory', 'Synchro'), 'table');
FileName = [handles.DirName 'table.mat'];
[stat,mess]=fileattrib(FileName);
if mess.UserWrite ==0
    fileattrib(FileName,'+w', 'u'); % force writtable file
end
save(FileName, 'table'); % pour palier aux handles via timer non mis Ã  jour !!!!!!

modeinj='togglebutton_3Hz';
if strcmp(modeinj,'togglebutton_soft')  % on rempli la table sur paquet 1 par dÃ©faut, pas utilisÃ©e
    table=handles.table0;
    tango_command_inout('ANS/SY/CENTRAL','SetTables',table);
    
elseif strcmp(modeinj,'togglebutton_3Hz') % on rempli la table associÃ©e au remplissage
    tango_command_inout('ANS/SY/CENTRAL','SetTables',table);
    pause(1); % mise a jour table ATK
    temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TablesCurrentDepth');
    n=temp.value;
    temp=tango_read_attribute2('ANS/SY/CENTRAL', 'ExtractionDelayTable');
    table_ext=temp.value(1:n); %-offset_ext;
    temp=tango_read_attribute2('ANS/SY/CENTRAL', 'LinacDelayTable');
    table_linac=(temp.value(1:n)-offset_linac)/bjump;
    table=[];
    for i=1:n
        table=[table ' ' '(' num2str([table_ext(i)])  ' '  num2str([table_linac(i)]) ')'];
    end
end

set(handles.edit_filling_relecture_tables,'String',[num2str(table)]);
set(handles.edit_filling_relecture_bunch, 'String',[num2str(bunch)]);


guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function listbox_fillingmode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_fillingmode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_fix.
function button_fix_Callback(hObject, eventdata, handles)
% hObject    handle to button_fix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[clk_spare,clk_soft]=fix_quart;
handles.clk_spare  =clk_spare;
handles.clk_soft=clk_soft;

% n=1;
% temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSprStepDelay');
% clk1=temp.value(n);
% temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay');
% clk2=temp.value(n);
% 
% jump=int32([0 39 26 13]);
% handles.clk_spare  =jump +  int32(clk1);
% handles.clk_soft=jump  + int32(clk2);

guidata(hObject, handles);



function edit_Ncycle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Ncycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Ncycle as text
%        str2double(get(hObject,'String')) returns contents of edit_Ncycle as a double
boucle=str2double(get(hObject,'String'));
Ncoup=str2double(get(handles.edit_Ncoup,'String'));
tango_write_attribute2('ANS/SY/CENTRAL', 'burstSize',int32(Ncoup*boucle));

% --- Executes during object creation, after setting all properties.
function edit_Ncycle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Ncycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Ncoup_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Ncoup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Ncoup as text
%        str2double(get(hObject,'String')) returns contents of edit_Ncoup as a double
Ncoup=str2double(get(hObject,'String'));
boucle=str2double(get(handles.edit_Ncycle,'String'));
tango_write_attribute2('ANS/SY/CENTRAL', 'burstSize',int32(Ncoup*boucle));

% --- Executes during object creation, after setting all properties.
function edit_Ncoup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Ncoup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_qlt1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_qlt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_qlt1 as text
%        str2double(get(hObject,'String')) returns contents of edit_qlt1 as a double


% --- Executes during object creation, after setting all properties.
function edit_qlt1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_qlt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_iboo_Callback(hObject, eventdata, handles)
% hObject    handle to edit_iboo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_iboo as text
%        str2double(get(hObject,'String')) returns contents of edit_iboo as a double


% --- Executes during object creation, after setting all properties.
function edit_iboo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_iboo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dians_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dians (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dians as text
%        str2double(get(hObject,'String')) returns contents of edit_dians as a double


% --- Executes during object creation, after setting all properties.
function edit_dians_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dians (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rlt1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rlt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rlt1 as text
%        str2double(get(hObject,'String')) returns contents of edit_rlt1 as a double


% --- Executes during object creation, after setting all properties.
function edit_rlt1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rlt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rboo_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rboo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rboo as text
%        str2double(get(hObject,'String')) returns contents of edit_rboo as a double


% --- Executes during object creation, after setting all properties.
function edit_rboo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rboo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rans_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rans as text
%        str2double(get(hObject,'String')) returns contents of edit_rans as a double


% --- Executes during object creation, after setting all properties.
function edit_rans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dians1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dians1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dians1 as text
%        str2double(get(hObject,'String')) returns contents of edit_dians1 as a double


% --- Executes during object creation, after setting all properties.
function edit_dians1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dians1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cycle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cycle as text
%        str2double(get(hObject,'String')) returns contents of edit_cycle as a double


% --- Executes during object creation, after setting all properties.
function edit_cycle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_courant_total_Callback(hObject, eventdata, handles)
% hObject    handle to edit_courant_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_courant_total as text
%        str2double(get(hObject,'String')) returns contents of edit_courant_total as a double


% --- Executes during object creation, after setting all properties.
function edit_courant_total_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_courant_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lin_canon_spm_Callback(hObject, eventdata, handles)
% hObject    handle to lin_alim_canon_spm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lin_alim_canon_spm as text
%        str2double(get(hObject,'String')) returns contents of lin_alim_canon_spm as a double

inj_offset=str2double(get(handles.inj_offset,'String'));
delay=str2double(get(hObject,'String'))+inj_offset;
tango_write_attribute2('LIN/SY/LOCAL.SPM.1', 'spmLinacTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function lin_canon_spm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lin_alim_canon_spm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function  uipanel_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lin_alim_canon_spm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% % % --------------------------------------------------------------------
% function uipanel_mode_SelectionChangeFcn(hObject, eventdata, handles)
% % % hObject    handle to uipanel_mode (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)
% 
% set(handles.button_injection_soft,'Enable','Off')
% set(handles.edit_modes,'String','Please WAIT !!!!')
% mode=get(get(handles.uipanel_mode,'SelectedObject'),'Tag');
% 
% switch mode  % Get Tag of selected object
%     case 'togglebutton_soft'
%         % switch to soft (load golden)
%         
%         Directory=handles.Directory;
%         DirName=handles.DirName;
%         file='golden_rafale_soft.mat';
%         load_synchro_rafale(Directory,file,DirName)
%         
%         
%         % special septum actif boo et ans
%         r=(1-0.0004);
%         try
%             temp=tango_read_attribute2('BOO-C12/EP/AL_SEP_A.Ext','voltage');boo=temp.value(2)*r
%             tango_write_attribute2('BOO-C12/EP/AL_SEP_A.Ext','voltage',boo);
%             temp=tango_read_attribute2('ANS-C01/EP/AL_SEP_A','voltage');ans=temp.value(2)*r
%             tango_write_attribute2('ANS-C01/EP/AL_SEP_A','voltage',ans);
%         catch
%             display('Erreur ajustement tension septa passif')
%         end
%         set(handles.edit_Ncoup,'Enable','off');
%         tango_command_inout('ANS/SY/CENTRAL','SetTables',handles.table0);
% 
%     case 'togglebutton_3Hz'
%         % switch to 3Hz(load golden)
%         
%         Directory=handles.Directory;
%         DirName=handles.DirName;
%         file='golden_rafale_3Hz.mat';
%         load_synchro_rafale(Directory,file,DirName)
%         
%         % special septum actif boo et ans
%         r=(1+0.0004);
%         try
%             temp=tango_read_attribute2('BOO-C12/EP/AL_SEP_A.Ext','voltage');boo=temp.value(2)*r
%             tango_write_attribute2('BOO-C12/EP/AL_SEP_A.Ext','voltage',boo);
%             temp=tango_read_attribute2('ANS-C01/EP/AL_SEP_A','voltage');    ans=temp.value(2)*r
%             tango_write_attribute2('ANS-C01/EP/AL_SEP_A','voltage',ans);
%         catch
%             display('Erreur ajustement tension septa passif')
%         end
%         set(handles.edit_Ncoup,'Enable','on');
%         tango_command_inout('ANS/SY/CENTRAL','SetTables',handles.table);
% end
% 
% set(handles.button_injection_soft,'Enable','On')
% test_modes(handles);
% display('ok change address')



function edit_filling_entrer_bunch1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_filling_entrer_bunch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_filling_entrer_bunch1 as text
%        str2double(get(hObject,'String')) returns contents of edit_filling_entrer_bunch1 as a double




% --- Executes during object creation, after setting all properties.
function edit_filling_entrer_bunch1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_filling_entrer_bunch1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Imin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Imin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Imin as text
%        str2double(get(hObject,'String')) returns contents of edit_Imin as a double


% --- Executes during object creation, after setting all properties.
function edit_Imin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Imin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function uipanel_spm_mode_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel_spm_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%h=get(handles.uipanel_spm_mode);
%get(h.Children)

mode=get(get(handles.uipanel_spm_mode,'SelectedObject'),'Tag');

switch mode  % Get Tag of selected object
    case 'spm_mode_1'
        display('spm_mode_1')     
        tango_write_attribute2('LIN/SY/LOCAL.SPM.1', 'mode',int16(1));
    case 'spm_mode_2'
        display('spm_mode_2')  
        tango_write_attribute2('LIN/SY/LOCAL.SPM.1', 'mode',int16(2));
    case 'spm_mode_2p'
        display('spm_mode_2p')   
        tango_write_attribute2('LIN/SY/LOCAL.SPM.1', 'mode',int16(3));
    case 'spm_mode_3'
        display('spm_mode_3')    
        tango_write_attribute2('LIN/SY/LOCAL.SPM.1', 'mode',int16(4));   
end

test_modes(handles);

% --------------------------------------------------------------------
function uipanel_lpm_spm_mode_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel_lpm_spm_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


mode=get(get(handles.uipanel_lpm_spm_mode,'SelectedObject'),'Tag');
%modeinj=get(get(handles.uipanel_mode,'SelectedObject'),'Tag');
modeinj='togglebutton_3Hz';
event0=int32(0);
if     strcmp(modeinj,'togglebutton_soft')
    event=int32(5);
elseif strcmp(modeinj,'togglebutton_3Hz')
    event=int32(2);
else
    %%%
end

switch mode  % Get Tag of selected object
    case 'no_mode'
        tango_write_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmEvent',event0); 
        tango_write_attribute2('LIN/SY/LOCAL.SPM.1', 'spmLinacEvent',event0); 
        
    case 'lpm_mode'
        tango_write_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmEvent',event); 
        tango_write_attribute2('LIN/SY/LOCAL.SPM.1', 'spmLinacEvent',event0);     
        
%         tango_write_attribute('LT1/AE/CV.2', 'current',  0.058 );
%         tango_write_attribute('LT1/AE/CV.3', 'current', -0.119 );

    case 'spm_mode'
        tango_write_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmEvent',event0); 
        tango_write_attribute2('LIN/SY/LOCAL.SPM.1', 'spmLinacEvent',event);   
        
%         tango_write_attribute('LT1/AE/CV.2', 'current',  0.058 );
%         tango_write_attribute('LT1/AE/CV.3', 'current', -0.119 );
        
end
test_modes(handles);




        

% --------------------------------------------------------------------
function uipanel_central_mode_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel_central_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

mode=get(get(handles.uipanel_central_mode,'SelectedObject'),'Tag');
%modeinj=get(get(handles.uipanel_mode,'SelectedObject'),'Tag');
modeinj='togglebutton_3Hz';

h='Yes';
if strcmp(mode,'continuous_mode')
    if strcmp(modeinj,'togglebutton_3Hz')
        h = questdlg('Attention, déclenchement continu des équipements sur adresses 1 2 3');
    end
end

if strcmp(h,'Yes')
    switch mode  % Get Tag of selected object
        case 'burst_mode'
            tango_command_inout2('ANS/SY/CENTRAL', 'SetBurstMode');
        case 'continuous_mode'
            tango_command_inout2('ANS/SY/CENTRAL', 'SetContinuousMode');
    end
end
pause(1)
test_modes(handles);

% [etat_central]=test_central_mode(handles);
% h='Yes';
% if strcmp(etat_central,'Continu')
%     h = questdlg('Attention, Trigger en mode continu');
% end
% if strcmp(h,'Yes')
%     set(handles.button_injection_soft,'Enable','Off')
%     set(handles.edit_modes,'String','Please WAIT !!!!')
%     file='golden_rafale_3Hz.mat';
%     load_synchro_rafale(file)
%     set(handles.button_injection_soft,'Enable','On')
%     test_modes(handles);
% end


function  [etat]=test_central_mode(handles)
% Verifie le mode central selectionnÃ©  : rafale ou continue
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'currentMode');
mode=temp.value;
h=get(handles.uipanel_central_mode);
switch mode  % Get Tag of selected object
    case 'BURST'
       set(handles.uipanel_central_mode,'SelectedObject',h.Children(2))
       etat='Rafale';
    case 'CONTINUOUS'
       set(handles.uipanel_central_mode,'SelectedObject',h.Children(1))
       etat='Continu';
end

function  [etat]=test_injection_mode(handles)
% Verifie le mode d'injection selectionnÃ© : soft ou 3Hz
%temp=tango_read_attribute2('lin_alim/SY/LOCAL.LPM.1', 'spareEvent');
etat='3Hz';


function  [etat]=test_lpm_spm_mode(handles)
% Verifie le mode selectionnÃ© en SPM ou LPM
temp=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmEvent');
modelpm=temp.value(1);
temp=tango_read_attribute2('LIN/SY/LOCAL.SPM.1', 'spmLinacEvent');
modespm=temp.value(1);
h=get(handles.uipanel_lpm_spm_mode);
if     (modelpm==5)&(modespm==0) | (modelpm==2)&(modespm==0)
    set(handles.uipanel_lpm_spm_mode,'SelectedObject',h.Children(2))
    etat='LPM';
elseif (modelpm==0)&(modespm==5) | (modelpm==0)&(modespm==2)
    set(handles.uipanel_lpm_spm_mode,'SelectedObject',h.Children(1))
    etat='SPM';
else
    set(handles.uipanel_lpm_spm_mode,'SelectedObject',h.Children(3))
    etat='NONE';
end

function  [etat]=test_spm_mode(handles)
% Verifie le mode selectionnÃ© en SPM : 1 2 ou 3 paquets
temp=tango_read_attribute2('LIN/SY/LOCAL.SPM.1', 'mode');
mode=temp.value(1);
h=get(handles.uipanel_spm_mode);
select=h.Children(5-mode);
set(handles.uipanel_spm_mode,'SelectedObject',select)
etat=num2str(5-mode);

function  [etat]=test_cond_inj(handles)
% Verifie si tir autorise  (Grp fonctionnement)
try temp=tango_read_attribute2('ANS/FC/INJ_COND', 'COND_INJ'); % 0 no injection,  1 injection
    val=temp.value; catch val=1 ; end; if val~=0 ; val=1; end;
if (val==1)
    etat='TIR AUTORISE';
else
    etat='TIR NON AUTORISE';
end


function  test_modes(handles)
% Verifie le mode central selectionnÃ©  : rafale ou continue
[etat_central]=test_central_mode(handles);
% Verifie le mode d'injection selectionnÃ© : soft ou 3Hz
[etat_injection]=test_injection_mode(handles);
% Verifie le mode selectionnÃ© en SPM ou LPM
[etat_linac]=test_lpm_spm_mode(handles);
% Verifie le mode selectionnÃ© en SPM : 1 2 ou 3 paquets
[etat_linac_spm]=test_spm_mode(handles);
% Vérifie si injectio autorisee
%[etat_inj]=test_cond_inj(handles);


% txt=[etat_inj,'    ####     ', ...
%      'CENTRAL : ',etat_central,'   #   INJECTION : ',etat_injection,'   #   LINAC : ',etat_linac];
txt=['CENTRAL : ',etat_central,'   #   INJECTION : ',etat_injection,'   #   LINAC : ',etat_linac];
set(handles.edit_modes,'String',txt)



function edit_modes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_modes as text
%        str2double(get(hObject,'String')) returns contents of edit_modes as a double


% --- Executes during object creation, after setting all properties.
function edit_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function ans_k_pc_Callback(hObject, eventdata, handles)
% hObject    handle to ans_k_pc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_k_pc as text
%        str2double(get(hObject,'String')) returns contents of ans_k_pc as a double


% --- Executes during object creation, after setting all properties.
function ans_k_pc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_k_pc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_k_h_Callback(hObject, eventdata, handles)
% hObject    handle to ans_k_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_k_h as text
%        str2double(get(hObject,'String')) returns contents of ans_k_h as a double


% --- Executes during object creation, after setting all properties.
function ans_k_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_k_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_k_v_Callback(hObject, eventdata, handles)
% hObject    handle to ans_k_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_k_v as text
%        str2double(get(hObject,'String')) returns contents of ans_k_v as a double


% --- Executes during object creation, after setting all properties.
function ans_k_v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_k_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_kicker.
function button_kicker_Callback(hObject, eventdata, handles)
% hObject    handle to button_kicker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of button_kicker

bpm=get(hObject,'Value');

if (bpm==0)
   set(handles.uipanel_kicker_machine,'Visible','off');
elseif (bpm==1)
    set(handles.uipanel_kicker_machine,'Visible','on');
end


% --- Executes on button press in button_save_golden_soft.
function button_save_golden_soft_Callback(hObject, eventdata, handles)
% hObject    handle to button_save_golden_soft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = questdlg('Attention, sauvegarde nouvelle golden !!!');

if strcmp(h,'Yes')

    DirName=handles.DirName;
    [timing]=get_synchro_rafale(DirName);
    % sauvegarde
    file='golden_rafale_soft.mat';
    %Directory =  [getfamilydata('Directory','DataRoot') 'Datatemp'];
    Directory=handles.Directory;
    pwdold = pwd;
    cd(Directory);
    save(file, 'timing');
    cd(pwdold);

end


% --- Executes on button press in button_load_golden_soft.
function button_load_golden_soft_Callback(hObject, eventdata, handles)
% hObject    handle to button_load_golden_soft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.button_injection_soft,'Enable','Off')
set(handles.edit_modes,'String','Please WAIT !!!!')
Directory=handles.Directory;
DirName=handles.DirName;
file='golden_rafale_soft.mat';
load_synchro_rafale(Directory,file,DirName)
set(handles.button_injection_soft,'Enable','On')
test_modes(handles);


% --- Executes on button press in button_load_golden_3Hz.
function button_load_golden_3Hz_Callback(hObject, eventdata, handles)
% hObject    handle to button_load_golden_3Hz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[etat_central]=test_central_mode(handles);
h='Yes';
if strcmp(etat_central,'Continu')
    h = questdlg('Attention, Trigger en mode continu');
end
if strcmp(h,'Yes')
    set(handles.button_injection_soft,'Enable','Off')
    set(handles.edit_modes,'String','Please WAIT !!!!')
    Directory=handles.Directory;
    DirName=handles.DirName;
    file='golden_rafale_3Hz.mat';
    load_synchro_rafale(Directory,file,DirName)
    set(handles.button_injection_soft,'Enable','On')
    test_modes(handles);
end

% --- Executes on button press in button_save_golden_3Hz.
function button_save_golden_3Hz_Callback(hObject, eventdata, handles)
% hObject    handle to button_save_golden_3Hz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = questdlg('Attention, sauvegarde nouvelle golden !!!');

if strcmp(h,'Yes')
    
    DirName=handles.DirName;
    [timing]=get_synchro_rafale(DirName);
    % sauvegarde
    file='golden_rafale_3Hz.mat';
    %Directory =  [getfamilydata('Directory','DataRoot') 'Datatemp'];
    Directory=handles.Directory;
    pwdold = pwd;
    cd(Directory);
    save(file, 'timing');
    cd(pwdold);

end

% --- Executes on button press in button_load_golden_3Hz_66MeV.
function button_load_golden_3Hz_66MeV_Callback(hObject, eventdata, handles)
% hObject    handle to button_load_golden_3Hz_66MeV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[etat_central]=test_central_mode(handles);
h='Yes';
if strcmp(etat_central,'Continu')
    h = questdlg('Attention, Trigger en mode continu');
end
if strcmp(h,'Yes')
    set(handles.button_injection_soft,'Enable','Off')
    set(handles.edit_modes,'String','Please WAIT !!!!')
    Directory=handles.Directory;
    DirName=handles.DirName;
    file='golden_rafale_3Hz_66MeV.mat';
    load_synchro_rafale(Directory,file,DirName)
    set(handles.button_injection_soft,'Enable','On')
    test_modes(handles);
end


% --- Executes on button press in button_save_golden_66MeV.
function button_save_golden_66MeV_Callback(hObject, eventdata, handles)
% hObject    handle to button_save_golden_66MeV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = questdlg('Attention, sauvegarde nouvelle golden 66 MeV!!!');

if strcmp(h,'Yes')

    DirName=handles.DirName;
    [timing]=get_synchro_rafale(DirName);
    % sauvegarde
    file='golden_rafale_3Hz_66MeV.mat';
    %Directory =  [getfamilydata('Directory','DataRoot') 'Datatemp'];
    Directory=handles.Directory;
    pwdold = pwd;
    cd(Directory);
    save(file, 'timing');
    cd(pwdold);

end



function boo_mrsv_Callback(hObject, eventdata, handles)
% hObject    handle to boo_mrsv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_mrsv as text
%        str2double(get(hObject,'String')) returns contents of boo_mrsv as a double

ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('BOO/SY/LOCAL.DG.3', 'emittanceTimeDelay',delay);

% --- Executes during object creation, after setting all properties.
function boo_mrsv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_mrsv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function central_pc_Callback(hObject, eventdata, handles)
% hObject    handle to central_pc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of central_pc as text
%        str2double(get(hObject,'String')) returns contents of central_pc as a double


delay=str2double(get(hObject,'String'));
tango_write_attribute2('ANS/SY/CENTRAL', 'TPcTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function central_pc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to central_pc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lin_alim_Callback(hObject, eventdata, handles)
% hObject    handle to lin_alim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lin_alim as text
%        str2double(get(hObject,'String')) returns contents of lin_alim as a double


delay=str2double(get(hObject,'String'));
tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'libre.1TimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function lin_alim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lin_alim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ans_nod_Callback(hObject, eventdata, handles)
% hObject    handle to ans_nod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_nod as text
%        str2double(get(hObject,'String')) returns contents of ans_nod as a double

ext_offset=str2double(get(handles.ext_offset,'String'));
delay=str2double(get(hObject,'String'))+ext_offset;
tango_write_attribute2('ANS-C14/SY/LOCAL.DG.1', 'perteTimeDelay',delay);


% --- Executes during object creation, after setting all properties.
function ans_nod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_nod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function boo_alim_cp_Callback(hObject, eventdata, handles)
% hObject    handle to boo_alim_cp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of boo_alim_cp as text
%        str2double(get(hObject,'String')) returns contents of boo_alim_cp as a double


% --- Executes during object creation, after setting all properties.
function boo_alim_cp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boo_alim_cp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
