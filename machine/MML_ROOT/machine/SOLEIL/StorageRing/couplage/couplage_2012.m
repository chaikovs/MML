function varargout = couplage_2012(varargin)
% COUPLAGE_2012 M-file for couplage_2012.fig
%      COUPLAGE_2012, by itself, creates a new COUPLAGE_2012 or raises the existing
%      singleton*.
%
%      H = COUPLAGE_2012 returns the handle to a new COUPLAGE_2012 or the handle to
%      the existing singleton*.
%
%      COUPLAGE_2012('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COUPLAGE_2012.M with the given input arguments.
%
%      COUPLAGE_2012('Property','Value',...) creates a new COUPLAGE_2012 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before couplage_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to couplage_2012_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help couplage_2012

% Last Modified by GUIDE v2.5 13-Dec-2011 10:09:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @couplage_2012_OpeningFcn, ...
                   'gui_OutputFcn',  @couplage_2012_OutputFcn, ...
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


% --- Executes just before couplage_2012 is made visible.
function couplage_2012_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to couplage_2012 (see VARARGIN)

% Choose default command line output for couplage_2012
handles.output = hObject;

%%%%%%%%%%%%%%%%%%%%%%%%%
k0 = uibuttongroup('visible','on','Position',[0.01 0.62 .98 .16],...
    'Title','','TitlePosition','lefttop','FontSize',14,...
    'BackgroundColor',[.651 0.855 0.924]);

%%%%%%%%%%%%%%%%%%%%%%%%%
%[.651 0.855 0.924]); % couleur bleu layette
k1 = uibuttongroup('visible','on','Position',[0.01 0.01 .98 .60],...
    'Title','','TitlePosition','lefttop','FontSize',14,...
    'BackgroundColor',[.5 0.5 1]);

%%%%%%%%%%%%%%%%%%%%%%%%%
% %[0.03 0.05 .95 .48]
% g0 = uibuttongroup('visible','on','Position',[0.03 0.02 .95 .21],...
%     'Title','','TitlePosition','lefttop','FontSize',14,...
%     'BackgroundColor',[.5 0.5 1]);
% 
% h1 = uicontrol('Style','Radio','String','  diaphonie DIAG','Tag','radiobutton1',...
%     'pos',[50 80 150 20],'parent',g0,'HandleVisibility','off','FontSize',14,...
%     'BackgroundColor',[.5 0.5 1]);
% h2 = uicontrol('Style','Radio','String','  diaphonie LOCO','Tag','radiobutton2','FontSize',14,...
%     'pos',[300. 80 150 20],'parent',g0,'HandleVisibility','off',...
%     'BackgroundColor',[.5 0.5 1]);
% set(g0,'SelectedObject',h2);  % No selection
% set(g0,'Visible','on');
% set(g0,'SelectionChangeFcn',...
%     {@uibuttongroup_SelectionChangeFcn_diaphonie,handles});
% setappdata(handles.figure1,'Diaphonie','LOCO'); % LOCO par défaut

%%%%%%%%%%%%%%%%%%%%%%%%%
%[0.03 0.05 .45 .18]
g2 = uibuttongroup('visible','on','Position',[0.04 0.05 .90 .42],...
    'Title','','TitlePosition','lefttop','FontSize',14,...
    'BackgroundColor',[.5 0.5 1]);


q2 = uicontrol('Style','Radio','String','  à partir d''une mesure de couplage','Tag','radiobutton1','FontSize',14,...
    'pos',[15. 190 280 20],'parent',g2,'HandleVisibility','off',...
    'BackgroundColor',[.5 0.5 1]);
q3 = uicontrol('Style','Radio','String','  par un jeu de correcteurs QT connu','Tag','radiobutton2','FontSize',14,...
    'pos',[15 75 350 20],'parent',g2,'HandleVisibility','off',...
    'BackgroundColor',[.5 0.5 1]);
q1 = uicontrol('Style','Radio','String','  en superposant un jeu de correcteurs QT connu','Tag','radiobutton3',...
     'pos',[15 16 380 20],'parent',g2,'HandleVisibility','off','FontSize',14,...
     'BackgroundColor',[.5 0.5 1]);
set(g2,'SelectedObject',q3);  % No selection
set(handles.edit_poids,'Enable','Off')
set(handles.edit_nbvp,'Enable','Off')
set(g2,'Visible','on');
set(g2,'SelectionChangeFcn',...
    {@uibuttongroup_SelectionChangeFcn_correction,handles});
setappdata(handles.figure1,'Correction','jeu'); % un jeu connu par défaut

%%%%%%%%%%%%%%%%%%%%%%%%%
g = uibuttongroup('visible','off','Position',[0.658 0.8 .32 .17],...
    'Title','Sélection mode','TitlePosition','centertop','FontSize',14,...
    'BackgroundColor',[.651 0.855 0.924]);
v1 = uicontrol('Style','Radio','String','  Online','Tag','radiobutton1',...
    'pos',[10 30 80 20],'parent',g,'HandleVisibility','off','FontSize',14,...
    'BackgroundColor',[.651 0.855 0.924]);
v2 = uicontrol('Style','Radio','String','  Model','Tag','radiobutton2','FontSize',14,...
    'pos',[110. 30 80 20],'parent',g,'HandleVisibility','off',...
    'BackgroundColor',[.651 0.855 0.924]);
set(g,'SelectedObject',v2);  % No selection
set(g,'Visible','on');
set(g,'SelectionChangeFcn',...
    {@uibuttongroup_SelectionChangeFcn,handles});
setappdata(handles.figure1,'Mode','Model'); % Model par défaut

%% paramètres par défaut de la mesure et de la correction du couplage_2012

M.Param1 = 0.2;  % Delta I corr H = 0.2 A : ne sera utile que pour tester les orbites ferm�es crois�es apr�s correction
M.Param2 = 4;    % Pause après consigne delta I = 4 secondes
setappdata(handles.figure1,'M',M);

S.Param1 = 3e4;  % changement 3 janvier 2012 % avant 3 janv 2012 : 1e3;
S.Param2 = 32;
S.Param3 = 100 ; % Paramètres par défaut de la correction
% Param1 : poids Dz
% Param2 : nb de valeurs propres de la matrice efficacite QT
% Param3 : pourcentage de correction appliqué
setappdata(handles.figure1,'S',S);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes couplage_2012 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = couplage_2012_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_mesure.
function pushbutton_mesure_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mesure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

M = getappdata(handles.figure1,'M');
Mode = getappdata(handles.figure1,'Mode');
setskewcorrection_2012(Mode,'Archive','Measurement','NoCorrection',handles) %[M.Param1 M.Param2])

% --- Executes on button press in pushbutton_correction.
function pushbutton_correction_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_correction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

type_corr = getappdata(handles.figure1,'Correction');
Mode = getappdata(handles.figure1,'Mode');

if strcmp(type_corr,'fichier')
    
    S = getappdata(handles.figure1,'S');
    
    setskewcorrection_2012(Mode,'Archive','NoMeasurement','Correction',handles) %[S.Param1 S.Param2 S.Param3])
    
else
    
    DirectoryName = getfamilydata('Directory', 'Coupling');
    if isempty(DirectoryName)
        %             DirectoryName = [getfamilydata('Directory','DataRoot'), 'Response', filesep, 'BPM', filesep];
    else
        % Make sure default directory exists
        DirStart = pwd;
        [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
        cd(DirStart);
    end
        %[FileName, DirectoryName] = uigetfile('*.mat', 'Select a Skew corrector list ("Save" starts measurement)', [DirectoryName FileName]);

    [FileName, DirectoryName] = uigetfile('*.mat', 'Select a Skew corrector list ("Save" starts measurement)',DirectoryName);
    if FileName == 0
        ArchiveFlag = 0;
        disp('   Skew correction canceled.');
        return
    end
    FileName = [DirectoryName, FileName];
    
    S = load(FileName);
    Sparam = getappdata(handles.figure1,'S'); % on va cherche le pourcentage d'aplication
    pourcentage = Sparam.Param3;

    if strcmp(type_corr,'jeu')
        setsp('QT',pourcentage*1e-2*S.Deltaskewquad,Mode);
    elseif strcmp(type_corr,'superposition')
        stepsp('QT',pourcentage*1e-2*S.Deltaskewquad,Mode);
    else
        disp('pb avec les options !')
    end
    disp('Skew correction applied');
    disp(FileName)
    disp(['Pourcentage applied = ' num2str(pourcentage) '%' ])
end

function edit_poids_Callback(hObject, eventdata, handles)
% hObject    handle to edit_poids (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_poids as text
%        str2double(get(hObject,'String')) returns contents of edit_poids as a double

S.Param1 = str2double(get(hObject,'String'));
S.Param2 = str2double(get(handles.edit_nbvp,'String'));
S.Param3 = str2double(get(handles.edit_pourcentage,'String'));
%% sauvegarde de la structure S
setappdata(handles.figure1,'S',S);

% --- Executes during object creation, after setting all properties.
function edit_poids_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_poids (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nbvp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nbvp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nbvp as text
%        str2double(get(hObject,'String')) returns contents of edit_nbvp as a double

S.Param1 = str2double(get(handles.edit_poids,'String'));
S.Param2 = str2double(get(hObject,'String'));
S.Param3 = str2double(get(handles.edit_pourcentage,'String'));
%% sauvegarde de la structure S
setappdata(handles.figure1,'S',S);

% --- Executes during object creation, after setting all properties.
function edit_nbvp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nbvp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pourcentage_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pourcentage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pourcentage as text
%        str2double(get(hObject,'String')) returns contents of edit_pourcentage as a double
S.Param1 = str2double(get(handles.edit_poids,'String'));
S.Param2 = str2double(get(handles.edit_nbvp,'String'));
S.Param3 = str2double(get(hObject,'String'));
%% sauvegarde de la structure S
setappdata(handles.figure1,'S',S);

% --- Executes during object creation, after setting all properties.
function edit_pourcentage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pourcentage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_nbvp.
function pushbutton_nbvp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_nbvp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function uibuttongroup_SelectionChangeFcn(hObject,eventdata,handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch get(get(hObject,'SelectedObject'),'Tag')  % Get Tag of selected object
    case 'radiobutton1'
        % code piece when radiobutton1 is selected goes here
        %handles.energie = 'min';
        setappdata(handles.figure1,'Mode','Online'); %


    case 'radiobutton2'
        % code piece when radiobutton2 is selected goes here
        %handles.energie = 'max';
        setappdata(handles.figure1,'Mode','Model'); %
end

% function uibuttongroup_SelectionChangeFcn_diaphonie(hObject,eventdata,handles)
% % hObject    handle to uipanel1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% switch get(get(hObject,'SelectedObject'),'Tag')  % Get Tag of selected object
%     case 'radiobutton1'
%         % code piece when radiobutton1 is selected goes here
%         %handles.energie = 'min';
%         setappdata(handles.figure1,'Diaphonie','DIAG'); %
% 
% 
%     case 'radiobutton2'
%         % code piece when radiobutton2 is selected goes here
%         %handles.energie = 'max';
%         setappdata(handles.figure1,'Diaphonie','LOCO'); %
% end

function uibuttongroup_SelectionChangeFcn_correction(hObject,eventdata,handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch get(get(hObject,'SelectedObject'),'Tag')  % Get Tag of selected object
%     case 'radiobutton1'
%         % code piece when radiobutton1 is selected goes here
%         %handles.energie = 'min';
%         setappdata(handles.figure1,'Correction','actuel'); %       

    case 'radiobutton1'
        % code piece when radiobutton1 is selected goes here
        setappdata(handles.figure1,'Correction','fichier'); %
        set(handles.edit_poids,'Enable','On')
        set(handles.edit_nbvp,'Enable','On')

    case 'radiobutton2'
        % code piece when radiobutton2 is selected goes here
        %handles.energie = 'max';
        setappdata(handles.figure1,'Correction','jeu'); %
        set(handles.edit_poids,'Enable','Off')
        set(handles.edit_nbvp,'Enable','Off')
        
    case 'radiobutton3'
        % code piece when radiobutton2 is selected goes here
        %handles.energie = 'max';
        setappdata(handles.figure1,'Correction','superposition'); %
        set(handles.edit_poids,'Enable','Off')
        set(handles.edit_nbvp,'Enable','Off')
        
end

% function edit_deltaIcorr_Callback(hObject, eventdata, handles)
% % hObject    handle to edit_deltaIcorr (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edit_deltaIcorr as text
% %        str2double(get(hObject,'String')) returns contents of edit_deltaIcorr as a double
% M.Param1 = str2double(get(handles.edit_deltaIcorr,'String'));
% M.Param2 = str2double(get(handles.edit_pause,'String'));
% %% sauvegarde de la structure M
% setappdata(handles.figure1,'M',M);

% --- Executes during object creation, after setting all properties.
% function edit_deltaIcorr_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit_deltaIcorr (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



% function edit_pause_Callback(hObject, eventdata, handles)
% % hObject    handle to edit_pause (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of edit_pause as text
% %        str2double(get(hObject,'String')) returns contents of edit_pause as a double
% 
% M.Param1 = str2double(get(handles.edit_deltaIcorr,'String'));
% M.Param2 = str2double(get(handles.edit_pause,'String'));
% %% sauvegarde de la structure M
% setappdata(handles.figure1,'M',M);
% 
% 
% % --- Executes during object creation, after setting all properties.
% function edit_pause_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit_pause (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end


% --- Executes on button press in pushbutton_RAZ_QT.
function pushbutton_RAZ_QT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_RAZ_QT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setsp('QT',0,'ModeFlag')
