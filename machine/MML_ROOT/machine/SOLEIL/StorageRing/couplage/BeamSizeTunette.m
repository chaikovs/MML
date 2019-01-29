function varargout = BeamSizeTunette(varargin)
% BEAMSIZETUNETTE M-file for BeamSizeTunette.fig
%      BEAMSIZETUNETTE, by itself, creates a new BEAMSIZETUNETTE or raises the existing
%      singleton*.
%
%      H = BEAMSIZETUNETTE returns the handle to a new BEAMSIZETUNETTE or the handle to
%      the existing singleton*.
%
%      BEAMSIZETUNETTE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAMSIZETUNETTE.M with the given input arguments.
%
%      BEAMSIZETUNETTE('Property','Value',...) creates a new BEAMSIZETUNETTE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BeamSizeTunette_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BeamSizeTunette_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BeamSizeTunette

% Last Modified by GUIDE v2.5 22-Jun-2015 22:02:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BeamSizeTunette_OpeningFcn, ...
                   'gui_OutputFcn',  @BeamSizeTunette_OutputFcn, ...
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


% --- Executes just before BeamSizeTunette is made visible.
function BeamSizeTunette_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BeamSizeTunette (see VARARGIN)


TESTFLAG = 0 ; % ATTENTION !!
ModeFlag = 'Online'; % DANGER !!
%ModeFlag = 'Simulator'; % DANGER !!


% Choose default command line output for BeamSizeTunette
handles.output = hObject;

%%%%%%%%%%%%%%%%%%%%%%%%%

k0 = uibuttongroup('visible','on','Position',[0.05 0.13 .90 .50],...
    'Title','','TitlePosition','lefttop','FontSize',14,...
    'BackgroundColor',[.651 0.855 0.924]);

v1 = uicontrol('Style','Radio','String','  Non expert','Tag','radiobutton1',...
    'pos',[70 185 200 20],'parent',k0,'HandleVisibility','off','FontSize',14,...
    'BackgroundColor',[.651 0.855 0.924]);
v2 = uicontrol('Style','Radio','String','  Expert','Tag','radiobutton2','FontSize',14,...
    'pos',[250. 185 150 20],'parent',k0,'HandleVisibility','off',...
    'BackgroundColor',[.651 0.855 0.924]);

set(k0,'SelectedObject',v1);  % Non expert par défaut
set(handles.pourcentage,'Enable','Off')
set(handles.dispersion_verticale,'Enable','Off')
set(handles.fichier,'Enable','Off')
set(k0,'Visible','on');
set(k0,'SelectionChangeFcn',...
    {@uibuttongroup_SelectionChangeFcn_expert,handles});
pourcentage = 5;
DirName = getfamilydata('Directory','OpsData');
FileName = fullfile(DirName,'QT_Golden_Nano24oct13_partieDz.mat');
setappdata(handles.figure1,'pourcentage','pourcentage');
setappdata(handles.figure1,'fichier','FileName');
set(handles.fichier,'String',FileName); 
setappdata(handles.figure1,'ModeFlag',ModeFlag);
setappdata(handles.figure1,'QTList0',family2dev('QT')); 
setappdata(handles.figure1,'IndexQToff',[ ]);
setappdata(handles.figure1,'QTList',family2dev('QT'));
setappdata(handles.figure1,'TESTFLAG',TESTFLAG);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BeamSizeTunette wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = BeamSizeTunette_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Augmenter.
function Augmenter_Callback(hObject, eventdata, handles)
% hObject    handle to Augmenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

QTList = getappdata(handles.figure1,'QTList'); 
IndexQToff = getappdata(handles.figure1,'IndexQToff');
pourcentage = str2double(get(handles.pourcentage,'String'));
FileName = get(handles.fichier,'String');  % fichier de dispersion verticale
ModeFlag = getappdata(handles.figure1,'ModeFlag'); 
TESTFLAG = getappdata(handles.figure1,'TESTFLAG');
if TESTFLAG
    FileName = fullfile(getfamilydata('Directory', 'Coupling'), filesep, 'Nanoscopium', filesep, '2012-07-23_couplage', filesep,'QT_Dipersion_verticale_pure_Nanoscopium.mat');
end
S = load(FileName);
S.Deltaskewquad(IndexQToff) = [ ] ;
stepsp('QT',pourcentage*1e-2*S.Deltaskewquad,QTList,ModeFlag); % SUPERPOSITION du jeu de QT
if TESTFLAG
    QTvalue = getam('QT',QTList);
    figure(56) ; hold all ; plot(QTvalue);
end
h = waitbar(0,'Please wait...');
steps = 3;
for step = 1:steps
    pause(1) ; % pause 1 seconde
    waitbar(step / steps)
end
close(h) 



% --- Executes on button press in Diminuer.
function Diminuer_Callback(hObject, eventdata, handles)
% hObject    handle to Diminuer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

QTList = getappdata(handles.figure1,'QTList'); 
IndexQToff = getappdata(handles.figure1,'IndexQToff');
pourcentage = str2double(get(handles.pourcentage,'String'));
FileName = get(handles.fichier,'String');  % fichier de dispersion verticale
ModeFlag = getappdata(handles.figure1,'ModeFlag'); 
TESTFLAG = getappdata(handles.figure1,'TESTFLAG');
if TESTFLAG
    FileName = fullfile(getfamilydata('Directory', 'Coupling'), filesep, 'Nanoscopium', filesep, '2012-07-23_couplage', filesep,'QT_Dipersion_verticale_pure_Nanoscopium.mat');
end
S = load(FileName);
S.Deltaskewquad(IndexQToff) = [ ] ;
stepsp('QT',-pourcentage*1e-2*S.Deltaskewquad,QTList,ModeFlag); % SUPERPOSITION du jeu de QT
if TESTFLAG
    QTvalue = getam('QT',QTList);
    figure(56) ; hold all ; plot(QTvalue);
end
h = waitbar(0,'Please wait...');
steps = 3;
for step = 1:steps
    pause(1) ; % pause 1 seconde
    waitbar(step / steps)
end
close(h) 
%
%

function Titre_Callback(hObject, eventdata, handles)
% hObject    handle to Titre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Titre as text
%        str2double(get(hObject,'String')) returns contents of Titre as a double


% --- Executes during object creation, after setting all properties.
function Titre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Titre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pourcentage_Callback(hObject, eventdata, handles)
% hObject    handle to pourcentage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pourcentage as text
%        str2double(get(hObject,'String')) returns contents of pourcentage as a double
pourcentage = str2double(get(hObject,'String'));
setappdata(handles.figure1,'pourcentage','pourcentage');


% --- Executes during object creation, after setting all properties.
function pourcentage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pourcentage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in dispersion_verticale.
function dispersion_verticale_Callback(hObject, eventdata, handles)
% hObject    handle to dispersion_verticale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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

[FileName, DirectoryName] = uigetfile('*.mat', 'Select a new Dispersion Wave ("Save" starts measurement)',DirectoryName);
if FileName == 0
    ArchiveFlag = 0;
    disp('   Skew correction canceled.');
    return
end
FileName = [DirectoryName, FileName];
%[DirectoryName, FileName, Ext] = fileparts(FileName);
set(handles.fichier,'String',FileName)



function uibuttongroup_SelectionChangeFcn_expert(hObject,eventdata,handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch get(get(hObject,'SelectedObject'),'Tag')  % Get Tag of selected object

    case 'radiobutton2'
        % code piece when radiobutton2 is selected goes here
        %setappdata(handles.figure1,'Correction','fichier'); %
        set(handles.pourcentage,'Enable','On')
        set(handles.dispersion_verticale,'Enable','On')
        set(handles.fichier,'Enable','Off')

    case 'radiobutton1'
        % code piece when radiobutton1 is selected goes here
        set(handles.pourcentage,'Enable','Off')
        set(handles.dispersion_verticale,'Enable','Off')
        set(handles.fichier,'Enable','Off')
        
end



function fichier_Callback(hObject, eventdata, handles)
% hObject    handle to fichier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fichier as text
%        str2double(get(hObject,'String')) returns contents of fichier as a double


% --- Executes during object creation, after setting all properties.
function fichier_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fichier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_EditQTList.
function pushbutton_EditQTList_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_EditQTList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

QTList = getappdata(handles.figure1,'QTList0'); 

       ListOld = QTList;
        
        % Get full QT list
        List = family2dev('QT');
        
        % Check QT already in the list CheckList(i) = 1
        %       QT not in the list CheckList(i) = 0
        CheckList = zeros(size(List,1),1);
        if ~isempty(QTList)
            for i = 1:size(List,1)
                k = find(List(i,1) == QTList(:,1));
                l = find(List(i,2) == QTList(k,2));
                if isempty(k) || isempty(l)
                    % Item not in list
                else
                    CheckList(i) = 1;
                end
            end
        end
        
        % User edition of the QT list
        newList = editlist(List, 'QT', CheckList);
        if isempty(newList)
            fprintf('   QT list cannot be empty.  No change made.\n');
        else
            QTList = newList;
        end
        
        % identify QT that have been substracted        
        CheckList = zeros(size(List,1),1);
        if ~isempty(QTList)
            for i = 1:size(List,1)
                k = find(List(i,1) == QTList(:,1));
                l = find(List(i,2) == QTList(k,2));
                if isempty(k) || isempty(l)
                    % Item not in list
                else
                    CheckList(i) = 1;
                end
            end
        end   
        IndexQToff = find(CheckList==0) ;
        
        % save
       % couplingFB = get(findobj(gcbf,'Tag','couplingFBguiButtoncouplingFBSetup'),'Userdata');
setappdata(handles.figure1,'IndexQToff',IndexQToff);
setappdata(handles.figure1,'QTList',QTList);

  
