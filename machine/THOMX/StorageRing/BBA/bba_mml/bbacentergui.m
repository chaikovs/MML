function varargout = bbacentergui(varargin)
% BBACENTERGUI M-file for bbacentergui.fig
%      BBACENTERGUI, by itself, creates a new BBACENTERGUI or raises the existing
%      singleton*.
%
%      H = BBACENTERGUI returns the handle to a new BBACENTERGUI or the handle to
%      the existing singleton*.
%
%      BBACENTERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BBACENTERGUI.M with the given input arguments.
%
%      BBACENTERGUI('Property','Value',...) creates a new BBACENTERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bbacentergui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bbacentergui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bbacentergui

% Last Modified by GUIDE v2.5 30-Aug-2011 18:35:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @bbacentergui_OpeningFcn, ...
    'gui_OutputFcn',  @bbacentergui_OutputFcn, ...
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


% --- Executes just before bbacentergui is made visible.
function bbacentergui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bbacentergui (see VARARGIN)

% Choose default command line output for bbacentergui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bbacentergui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

initDirectory;

function initDirectory
% selection the direcotry to save the BBA data

RootDirectory = fileparts(getfamilydata('Directory', 'BBA'));
DirName = RootDirectory;
while ~ischar(DirName) || (strcmpi(DirName, RootDirectory) || exist(DirName, 'dir') ~=7)
    DirName = uigetdir(RootDirectory, 'Select or create a BBA directory');
    if strcmpi(DirName, RootDirectory)
        h = warndlg('Abort: Directory is not correct. Choose a subdirectory');
        uiwait(h)
    elseif ischar(DirName) && exist(DirName, 'dir') ~=7
        warndlg('Abort: Directory not selected');
    end
end
cd(DirName); % gotodirectory
quadsetup(DirName);
%cd(DirName);

% --- Outputs from this function are returned to the command line.
function varargout = bbacentergui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox_Q1.
function checkbox_Q1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Q1

% --- Executes on button press in checkbox_Q2.
function checkbox_Q2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Q2


% --- Executes on button press in checkbox_Q3.
function checkbox_Q3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Q3


% --- Executes on button press in checkbox_Q4.
function checkbox_Q4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Q4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Q4


% --- Executes on button press in checkbox_Q5.
function checkbox_Q5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Q5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Q5


% --- Executes on button press in checkbox_Q6.
function checkbox_Q6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Q6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Q6


% --- Executes on button press in checkbox_Q7.
function checkbox_Q7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Q7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Q7


% --- Executes on button press in checkbox_Q8.
function checkbox_Q8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Q8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Q8


% --- Executes on button press in checkbox_Q9.
function checkbox_Q9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Q9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Q9


% --- Executes on button press in checkbox_Q10.
function checkbox_Q10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Q10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Q10


% --- Executes on button press in checkbox_Hplane.
function checkbox_Hplane_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Hplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Hplane

% --- Executes on button press in checkbox_Vplane.
function checkbox_Vplane_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Vplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Vplane


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


% --- Executes on button press in pushbutton_Add.
function pushbutton_Add_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_Remove.
function pushbutton_Remove_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function launchBBA(handles)
% main function for BBA

[tmp WHO] =system('whoami');
if strncmp(WHO, 'operateur',9),
    ControlRoomFlag = 1;
    Mode = 'Online';
else
    ControlRoomFlag = 0;
    Mode = 'Simulator';
end

%initialization
HFlag = 0;
VFlag = 0;
plane = -1;
QuadDev = [];

% get flags for planes
if get(handles.checkbox_Hplane,'Value') == 1
    HFlag = 1;
end

% get flags for planes
if get(handles.checkbox_Vplane,'Value') == 1
    VFlag = 1;
end

if (HFlag == 1) && (VFlag == 1)
    plane = 0;
    StrPlane = sprintf('\nH and V planes\n');
elseif (HFlag == 1)
    plane = 1;
    StrPlane = sprintf('\nH-plane only\n');
elseif (VFlag == 1)
    plane = 2;
    StrPlane = sprintf('\nV-plane only\n');
else
    warndlg('Abort: Select a plane first')
    return;
end


% get BPM for doing BBA

% Quadrupole Family Selection
if get(handles.radiobutton_Quad, 'Val') == 1
    FamilyList = {};
    for k = 1:12,
        if get(eval(['handles.checkbox_Q' num2str(k)]),'Value') == 1
            FamilyList = {FamilyList{:}, ['Q' num2str(k)]};
        end
    end

    if isempty(FamilyList)
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

        
        QuadDev = editlist(getlist(QuadFamily),QuadFamily,zeros(length(getlist(QuadFamily)),1));

        if isempty(QuadDev)
            warndlg('Abort: No quadrupole selected');
            return;
        end

        clear FamilyList;
        FamilyList{1} = QuadFamily;
        StringMessage = sprintf('Do you want to start BBA on quadrupoles ?');
        StringMessage = [StringMessage StrPlane];
        for k=1:size(QuadDev, 1),
            StringMessage = [StringMessage, sprintf('\n %s(%d,%d)', FamilyList{1}, QuadDev(k,:))];
        end

    else
        StringMessage = sprintf('Do you want to start BBA on All quadrupoles of familyname?');
        StringMessage = [StringMessage StrPlane];
        for k=1:size(FamilyList, 2),
            StringMessage = [StringMessage, sprintf('\n %s', FamilyList{k})];
        end

    end
    StartFlag = questdlg(StringMessage, 'BBAgui','Yes','No','No');
    if strcmp(StartFlag,'No')
        disp('   ********************************');
        disp('   **        BBA Aborted         **');
        disp('   ********************************');
        fprintf('\n');
        return
    end
    
    
    if isempty(QuadDev)
    %Fullfamily
    for k = 1:size(FamilyList, 2),
        % get device list
        DevList = family2dev(FamilyList{k});
        % do BBA
        quadcenter(FamilyList{k}, DevList, plane);
    end
    else
        % individual quadrupoles
        for k = 1:size(QuadDev, 1),
            % do BBA
            quadcenter(FamilyList{1}, QuadDev(k,:), plane);
        end
    end
    h = warndlg('BBA measurement done.');    
    if ControlRoomFlag
        tango_giveInformationMessage('BBA fini');
    end
    uiwait(h)
end


% if BPM choice list
% test if BPM list selected
if get(handles.radiobutton_BPM, 'Val') == 1
    % Interface start with all or non BPM selected
    if get(handles.radiobutton_ALLBPM,'Value')
        newList = editlist(getlist('BPMx'), 'BPMx', ones(size(getlist('BPMx'),1)));
    else
        newList = editlist(getlist('BPMx'), 'BPMx', zeros(size(getlist('BPMx'),1)));
    end
    if isempty(newList)
        warndlg('Abort: No BPM selected');
        return;
    end
    Quadstruct = bpm2quad4bba('BPMx', newList );

    StringMessage = sprintf('Do you want to start BBA on all these quadrupoles?');
    StringMessage = [StringMessage StrPlane];
    for k=1:size(newList, 1),
        if rem(k,2) == 1,
            StringMessage = [StringMessage, sprintf('\n BPM(%2d,%2d) %s(%2d, %2d)', newList(k,:), ...
                Quadstruct(k).Family1, Quadstruct(k).DevList1)];
        else
            StringMessage = [StringMessage, sprintf('\t BPM(%2d,%2d) %s(%2d, %2d)', newList(k,:), ...
                Quadstruct(k).Family1, Quadstruct(k).DevList1)];
        end
        if ~isempty(Quadstruct(k).Family2)
            StringMessage = [StringMessage, sprintf(' %s(%d, %d)',  ...
                Quadstruct(k).Family2, Quadstruct(k).DevList2)];
        end
    end
    
    StringMessage = [StringMessage, sprintf('\n \n .')]; 
    StartFlag = questdlg(StringMessage, 'BBAgui','Yes','No','No');
    if strcmp(StartFlag,'No')
        disp('   ********************************');
        disp('   **        BBA Aborted         **');
        disp('   ********************************');
        fprintf('\n');
        return
    end

    for k = 1:length(Quadstruct),
        quadcenter(Quadstruct(k).Family1, Quadstruct(k).DevList1, plane)
        if ~isempty(Quadstruct(k).Family2)
            quadcenter(Quadstruct(k).Family2, Quadstruct(k).DevList2, plane)
        end
    end
    h = warndlg('BBA measurement done.');
    if ControlRoomFlag
        tango_command_inout2(devSpeakerName,'DevTalk','BBA fini');
    end
    uiwait(h)
end

% --- Executes on button press in pushbutton_start.
function pushbutton_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

StartFlag = questdlg(sprintf('Start BBA measurement. First Check\n\nShaker and tune measurement ON\n\nBooster OFF\nFBT OFF\nSOFB & FOFB OFF\n\n Are you sure?'), 'Start Confirmation box','Yes','No','No');
if strcmp(StartFlag,'No')
    disp('   ********************************');
    disp('   **   Start not applied      **');
    disp('   ********************************');
    fprintf('\n');
    return
end

launchBBA(handles)

% --- Executes on button press in pushbutton_plotRawData.
function pushbutton_plotRawData_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plotRawData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Dir0 = pwd;
cd(getfamilydata('Directory', 'BBAcurrent'))
quadplot;
cd(Dir0);

% --- Executes on button press in pushbutton_plotFinalOffset.
function pushbutton_plotFinalOffset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plotFinalOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Dir0 = pwd;
cd(getfamilydata('Directory', 'BBAcurrent'))
quadcalcoffset;
cd(Dir0);

% --- Executes on button press in pushbutton_createFile.
function pushbutton_createFile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_createFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Dir0 = pwd;
cd(getfamilydata('Directory', 'BBAcurrent'))
quadcalcoffset('Write', 'NoDisplay');
cd(Dir0);


% --- Executes on button press in pushbutton_plotAllRawData.
function pushbutton_plotAllRawData_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plotAllRawData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Dir0 = pwd;
cd(getfamilydata('Directory', 'BBAcurrent'))
quadplotall;
cd(Dir0);


% --- Executes on button press in pushbutton_selectDirectory.
function pushbutton_selectDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_selectDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

initDirectory


% --- Executes on button press in pushbutton_applyBBAOffset.
function pushbutton_applyBBAOffset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_applyBBAOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% force computation of offsets

pushbutton_createFile_Callback(handles.pushbutton_createFile, eventdata, handles)

StartFlag = questdlg('Do you want to generate  offset table for jive?', 'Apply Offset','Yes','No','No');
if strcmp(StartFlag,'No')
    disp('   ********************************');
    disp('   **   Offsets not applied      **');
    disp('   ********************************');
    fprintf('\n');
    return
end

% H and V-plane
fileNameH = fullfile(getfamilydata('Directory', 'BBAcurrent'), 'tableBBAH.mat');
fileNameV = fullfile(getfamilydata('Directory', 'BBAcurrent'), 'tableBBAV.mat');
Dir0 = pwd;
cd ('/home/operateur/GrpDiagnostics/matlab/DserverBPM');


% both plane
if exist(fileNameH, 'file') == 2 && exist(fileNameV, 'file') == 2
    Set_BBA_Offsets_planHV('ADD', fileNameH, fileNameV)
elseif exist(fileNameH, 'file') == 2
% Only H-plane
    Set_BBA_Offsets_planH('ADD', fileNameH)
elseif exist(fileNameV, 'file') == 2
% Only V-plane
    Set_BBA_Offsets_planV('ADD', fileNameV)
end

cd(Dir0)

message = sprintf(['Mise en production des offsets mesures\n', ...
    '\n 1. Ouvrir jive-rw', ...
    '\n 2. Remplacer la propriete ''Blockparameters'' dans l''onglet Property/BPM', ...
    '\n 3. Faire une (plus si besoin) commande ''init'' des BPM avec le bouton ''init on all BPMs'' \n']);
uiwait(msgbox(message,'Intructions','modal'));


% --- Executes on button press in pushbutton_InitBPM.
function pushbutton_InitBPM_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_InitBPM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

StartFlag = questdlg('Init on all BPM. Are you sure?', 'Init Confirmation box','Yes','No','No');
if strcmp(StartFlag,'No')
    disp('   ********************************');
    disp('   **   Init not applied      **');
    disp('   ********************************');
    fprintf('\n');
    return
end

commandName = 'Init';
tango_group_command_inout2(getfamilydata('BPMx', 'GroupId'),commandName,0,0);


% --- Executes on button press in checkbox_Q11.
function checkbox_Q11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Q11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Q11


% --- Executes on button press in checkbox_Q12.
function checkbox_Q12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_Q12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_Q12
