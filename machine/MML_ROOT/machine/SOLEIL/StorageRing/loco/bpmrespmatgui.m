function varargout = bpmrespmatgui(varargin)
% BPMRESPMATGUI M-file for bpmrespmatgui.fig
%      BPMRESPMATGUI, by itself, creates a new BPMRESPMATGUI or raises the existing
%      singleton*.
%
%      H = BPMRESPMATGUI returns the handle to a new BPMRESPMATGUI or the handle to
%      the existing singleton*.
%
%      BPMRESPMATGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BPMRESPMATGUI.M with the given input arguments.
%
%      BPMRESPMATGUI('Property','Value',...) creates a new BPMRESPMATGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bpmrespmatgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bpmrespmatgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bpmrespmatgui

% Last Modified by GUIDE v2.5 16-Mar-2016 13:46:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bpmrespmatgui_OpeningFcn, ...
                   'gui_OutputFcn',  @bpmrespmatgui_OutputFcn, ...
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


% --- Executes just before bpmrespmatgui is made visible.
function bpmrespmatgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bpmrespmatgui (see VARARGIN)

% Choose default command line output for bpmrespmatgui
handles.output = hObject;

% Directory name for saving data
handles.DirName = '';

%flag for manage if file are present in path and LOCO DATA is load
handles.FileBPMNoise=0;
handles.FileBPMDisp=0;
handles.FileBPMRespF=0;
handles.FileBPMRespS=0;
handles.FileLocoF=0;
handles.FileLocoS=0;
handles.LocoLoaded=0;
handles.StandardLocoFile=fullfile(getfamilydata('Directory','LOCOGolden'),'163Quad_Golden.mat'); %dynamic path for Golden LOCO DATA

initlayout(hObject,handles);

% Update handles structure
guidata(hObject, handles);



% Reading QTs
QTval = sum(abs(getam('QT')));
if QTval > 0.1
    strval = sprintf('QT still delivering current : sum(abs(QT)) =%f A\n switch them off', QTval);
    warndlg(strval)
    set(handles.TXT_QT_Off,'string',['Eteindre QT! ',num2str(QTval),' A']);
    set(handles.TXT_QT_Off,'BackgroundColor',[1 0 0]);
    guidata(hObject, handles);
else
    set(handles.TXT_QT_Off,'string',['QT OK ',num2str(QTval),' A']);
    set(handles.TXT_QT_Off,'BackgroundColor',[0 1 0]);
    guidata(hObject, handles);
end
% Flag for indicate file presence in folder selected

switch getmode('BPMx')
    case 'Online'
        % Reading tunes
        hval = readattribute('ANS-C14/DG/NOE.H/State');
        vval = readattribute('ANS-C14/DG/NOE.V/State');

        if hval == 0 || vval == 0
            strval = sprintf('Tune excitation is still ON, please switch it off');
            warndlg(strval)
        end    

        % Check feedback systems
        devFOFBManager = 'ANS/DG/FOFB-MANAGER';
        xval = readattribute([devFOFBManager '/xFofbRunning']);
        zval = readattribute([devFOFBManager '/zFofbRunning']);
        if xval == 1 || zval == 1
            warndlg('FOFB already running. Stop the application first!')
        end

        devLockName = 'ANS/CA/SERVICE-LOCKER';
        val = readattribute([devLockName '/sofb']);
        if val == 1
            warndlg('SOFB already running. Stop the  application first!')
        end
        AD=getad;
        run(AD.ATModel);
        PXBPM=findcells(THERING, 'FamName','PXBPM');

        val = readattribute([devLockName '/iscouplingfbrunning']);
        if val == 1
            warndlg('Coupling FB already running. Stop the application first!')
        end
    
end

% UIWAIT makes bpmrespmatgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bpmrespmatgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_bruit.
function pushbutton_bruit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bruit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch getmode('BPMx')
    case 'Online'
        [Rx Ry DCCT tout BPMxStd BPMyStd FileName] = monbpm('Archive',180);
    otherwise
        [Rx Ry DCCT tout BPMxStd BPMyStd FileName] = monbpm('Archive',10);
end
system(['mv ' FileName ' ' handles.DirName filesep]);
layout(hObject,handles);





% --- Executes on button press in pushbutton_dispersion.
function pushbutton_dispersion_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dispersion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure
switch get(handles.FBSelector,'Value')
            case {2 , 4 , 5 , 6} % measure dispersion with XBPM
                [Dx, Dy, FileName] = measdisp('BPMx','PBPMz','Archive', 'Display', 'Physics');
            otherwise    
                [Dx, Dy, FileName] = measdisp('Archive', 'Display', 'Physics');
end                
system(['mv ' FileName ' ' handles.DirName filesep]);
layout(hObject,handles);


        
% --- Executes on button press in pushbutton_directory.
function pushbutton_directory_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_directory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

initlayout(hObject,handles);
RootDirectory = fileparts(getfamilydata('Directory', 'LOCOData'));
DirName = RootDirectory;


while ~ischar(DirName) || (strcmpi(DirName, RootDirectory) || exist(DirName, 'dir') ~=7)
    DirName = uigetdir(RootDirectory, 'Select or create a LOC0 directory');
    if strcmpi(DirName, RootDirectory)
        h = warndlg('Abort: Directory is not correct. Choose a subdirectory');
        uiwait(h)
    elseif ischar(DirName) && exist(DirName, 'dir') ~=7
        warndlg('Abort: Directory not selected');
    end
end
cd(DirName); % gotodirectory
ival = regexp(DirName,'/', 'end');
handles.DirName = DirName;
% Update handles structure
guidata(hObject,handles);
layout(hObject,handles);

set(handles.text_directory, 'String', DirName(ival(end)+1:end));





% --- Executes on button press in pushbutton_buildloco.
function pushbutton_buildloco_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_buildloco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FileName = appendtimestamp('163Quad_LOCO');
[Filename, Pathname]=uiputfile('*.mat','create LOCOFile',FileName); 
handles.locoFilename=Filename;
handles.locoPathname=Pathname;
load_Loco(hObject,handles)


% --- Executes on button press in pushbutton_LoadLoco.
function pushbutton_LoadLoco_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_LoadLoco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Filename, Pathname]=uigetfile('*.mat','Choose LOCOFile'); 
handles.locoFilename=Filename;
handles.locoPathname=Pathname;
load_Loco(hObject,handles)


% --- Executes on button press in pushbutton_locogui.
function pushbutton_locogui_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_locogui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
locogui





%--- Executes on button press in pushbutton0A.
function pushbutton0A_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton0A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Put_QT_to_0 = questdlg('Put QT to 0A?','Put QT to 0A?', 'Yes', 'No','No');
if (Put_QT_to_0 == 'Yes')
   setsp('QT',0);
   for i=1:5
       pause(1);
       QTval = sum(abs(getam('QT')));
       if QTval<0.1
           break
       end    
   end   
   if QTval > 0.1
        strval = sprintf('QT still delivering current : sum(abs(QT)) =%f A\n switch them off', QTval);
        warndlg(strval)
        set(handles.TXT_QT_Off,'string',['Eteindre QT! ',num2str(QTval),' A']);
        set(handles.TXT_QT_Off,'BackgroundColor',[1 0 0]);
        guidata(hObject, handles);
    else
        set(handles.TXT_QT_Off,'string',['QT OK ',num2str(QTval),' A']);
        set(handles.TXT_QT_Off,'BackgroundColor',[0 1 0]);
        guidata(hObject, handles);
    end
end
%   
function fexists = fieldexists(thestruct, thefield )

    if ischar(thestruct)
        %could use [ string1 string2 ]; might be faster.
        todo = sprintf('getfield(%s,''%s'');', thestruct, thefield);
        fexists = 1; evalin('caller', todo, 'fexists=0;');
    else
        %another poster suggested this: (seems to work faster when profiled)

        fexists = any( strcmp(fieldnames(thestruct), thefield) );
  
        % i happen to like this

        fexists = 1; eval('getfield(thestruct, thefield);', 'fexists=0;'); 
    end
   

% --- Executes on button press in RespMat_Btn.
function pushbutton_RespMat_Callback(hObject, eventdata, handles)
% hObject    handle to RespMat_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
devLockName = getfamilydata('TANGO', 'SERVICELOCK')
val = readattribute([devLockName '/sofb']);
val=0;
if val == 1
    error('SOFB already running. Stop other application first!')
end
switch getmode('BPMx')
    case 'Online'
        switch get(handles.FBSelector,'Value')
            case 1
                [Rmat, OutputFileName] = measbpmresp4FB('Archive','Slow');
            case 2
                [Rmat, OutputFileName] = measbpmresp4FB('Archive','Slow','PBPMz');
            case 3
                [Rmat, OutputFileName] = measbpmresp4FB('Archive','Fast');
            case 4
                [Rmat, OutputFileName] = measbpmresp4FB('Archive','Fast','PBPMz');
            case 5
                [Rmat, OutputFileName] = measbpmresp4FB('Archive','Slow','XBPM');
            case 6
                [Rmat, OutputFileName] = measbpmresp4FB('Archive','Fast','XBPM');
        end
        if ~isempty(Rmat)
            tango_giveInformationMessage('Fin de mesure Matrice réponse');
        end
    otherwise
        switch get(handles.FBSelector,'Value')
            case 1
                [Rmat, OutputFileName] = measbpmresp4FB('Archive','Slow','Model');
%             case 2
%                 [Rmat, OutputFileName] = measbpmresp4FB('Archive','Slow','PBPMz','Model'); %Not Work no AT index for PBPMz family
            case 3
                [Rmat, OutputFileName] = measbpmresp4FB('Archive','Fast','Model');
%             case 4
%                 [Rmat, OutputFileName] = measbpmresp4FB('Archive','Fast','PBPMz','Model');%Not Work no AT index for PBPMz family
%             case 5
%                 [Rmat, OutputFileName] = measbpmresp4FB('Archive','Slow','XBPM','Model');%Not Work no AT index for PBPMz family
%             case 6
%                 [Rmat, OutputFileName] = measbpmresp4FB('Archive','Fast','XBPM','Model'); %Not Work no AT index for PBPMz family   
            otherwise
                msgbox('this case doesnt work with simulator or model');
        end    

        
end
 
if ~isempty(Rmat)
    system(['mv ' OutputFileName ' ' handles.DirName filesep]);
end
layout(hObject,handles);




% --- Executes during object creation, after setting all properties.
function FBSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FBSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
ModeList={'SOFB','SOFB+XBPM','FOFB','FOFB+XBPM','SOFB just XBPM','FOFB just XBPM'};
set(hObject,'String',ModeList);


% --- Executes on button press in Splitpushbutton.
function Splitpushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Splitpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BPM_RespMat_split_merge('Split')

% --- Executes on button press in Mergepushbutton.
function Mergepushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Mergepushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BPM_RespMat_split_merge('Merge')

% --- Executes on button press in pushbutton_applysym.
function pushbutton_applysym_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_applysym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch questdlg('Please confirm you want apply DK! ;-)', 'Apply Dk')
    case 'Yes'
        k = -1;
        debi=0;
        for i=1:(length(handles.List)-1)
            endi=debi+length(handles.KBefore{i});
            debi=debi+1;    
            setsp(handles.List{i},k*handles.DK(debi:endi)+handles.KBefore{i},handles.mode,'Physics');
            debi=endi;
        end
        msgbox('Operation Completed')
end    



% --- Executes on button press in Undo_Q_pushbutton.
function Undo_Q_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Undo_Q_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch questdlg('Please confirm you want undo DK! ;-)', 'Undo Dk')
    case 'Yes'
        for i=1:(length(handles.List)-1)
            setsp(handles.List{i},handles.KBefore{i},handles.mode,'Physics');
        end
    msgbox('Operation Completed')    
end        

% --- Executes on button press in pushbutton_applysymQT.
function pushbutton_applysymQT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_applysymQT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch questdlg('Please confirm you want apply DK! ;-)', 'Apply Dk')
    case 'Yes'
        k = -1;
        debi=0;
        for i=1:(length(handles.List))
            endi=debi+length(handles.KBefore{i});
            debi=debi+1;
            if strcmp('QT',handles.List{i})
                setsp(handles.List{i},k*handles.DK(debi:endi) +handles.KBefore{i},handles.mode,'Physics');
            end
            debi=endi;
        end
    msgbox('Operation Completed')    
end        

% --- Executes on button press in Undo_QT_pushbutton.
function Undo_QT_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Undo_QT_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch questdlg('Please confirm you want undo DK! ;-)', 'Undo Dk')
    case 'Yes'
        for i=1:(length(handles.List))
            if strcmp('QT',handles.List{i})
                setsp(handles.List{i},handles.KBefore{i},handles.mode,'Physics');
            end
        end
    msgbox('Operation Completed')    
end
%%
function initlayout(hObject,handles)
%flag
handles.FileBPMNoise=0;
handles.FileBPMDisp=0;
handles.FileBPMRespF=0;
handles.FileBPMRespS=0;
handles.FileLocoF=0;
handles.FileLocoS=0;
handles.LocoLoaded=0;

%force some control 
set(handles.pushbutton_bruit,'BackgroundColor',[1 1 0]);
set(handles.pushbutton_dispersion,'BackgroundColor',[1 1 0]);
set(handles.pushbutton_RespMat,'BackgroundColor',[1 1 0]);
set(handles.pushbutton_buildloco,'BackgroundColor',[1 1 0]);
set(handles.pushbutton_LoadLoco,'BackgroundColor',[1 1 0]);
set(handles.pushbutton_applysym,'BackgroundColor',[1 1 0]);
set(handles.pushbutton_applysymQT,'BackgroundColor',[1 1 0]);
set(handles.Undo_Q_pushbutton,'BackgroundColor',[1 1 0]);
set(handles.Undo_QT_pushbutton,'BackgroundColor',[1 1 0]);
set(handles.pushbuttonPlotQuad, 'BackgroundColor',[1 1 0]);
set(handles.pushbuttonPlotQT, 'BackgroundColor',[1 1 0]);
set(handles.pushbuttonBPM_G_C,'BackgroundColor',[1 1 0]);


set(handles.pushbutton_applysym, 'Enable', 'Off');
set(handles.pushbutton_RespMat, 'Enable', 'Off');
set(handles.pushbutton_bruit, 'Enable', 'Off');
set(handles.pushbutton_buildloco,'Enable', 'Off');
set(handles.pushbutton_LoadLoco,'Enable', 'Off');
set(handles.pushbutton_applysym,'Enable', 'Off');
set(handles.pushbutton_applysymQT,'Enable', 'Off');
set(handles.Undo_Q_pushbutton,'Enable', 'Off');
set(handles.Undo_QT_pushbutton,'Enable', 'Off');
set(handles.pushbuttonPlotQuad, 'Enable', 'Off');
set(handles.pushbuttonPlotQT, 'Enable', 'Off');
set(handles.pushbuttonBPM_G_C, 'Enable', 'Off');

set(handles.pushbutton_bruit,'String','Mesure Bruit BPM');
set(handles.pushbutton_dispersion,'String','Mesure Dispersion');
set(handles.pushbutton_RespMat,'String','Matrice réponse');
set(handles.pushbutton_buildloco,'String','Build LOCO File');
guidata(hObject, handles);
%%
function layout(hObject,handles)

DirName=handles.DirName;
listfile=dir(handles.DirName);
for i=1:size(listfile)
    [pathstr,name,ext]=fileparts(listfile(i).name);
    if strcmp(ext,'.mat')
        struct=load(listfile(i).name);
        if  fieldexists(struct, 'BPMxData')
            handles.FileBPMNoise=1;
            set(handles.pushbutton_bruit,'BackgroundColor',[0 1 0]);
            set(handles.pushbutton_bruit,'String','Mesure Bruit BPM:OK');
        elseif fieldexists(struct, 'BPMxDisp')
            handles.FileBPMDisp=1;
            set(handles.pushbutton_dispersion,'BackgroundColor',[0 1 0]);
            set(handles.pushbutton_dispersion,'String','Mesure Dispersion:OK');
        elseif fieldexists(struct, 'Rmat')
            FamActua=struct.Rmat(1,1).Actuator.FamilyName;
            if strcmp(FamActua ,'FHCOR')
                handles.FileBPMRespF=1;
                set(handles.pushbutton_RespMat,'BackgroundColor',[0 1 1]);
                set(handles.pushbutton_RespMat,'String','Matrice réponse:FHCOR');
            elseif strcmp(FamActua ,'HCOR')
                handles.FileBPMRespS=1;
               set(handles.pushbutton_RespMat,'BackgroundColor',[0 1 0]);
               set(handles.pushbutton_RespMat,'String','Matrice réponse:HCOR');
            end
        elseif fieldexists(struct, 'LocoMeasData')
            FamActua=struct.LocoMeasData.HCM.FamilyName;
            if strcmp(FamActua ,'FHCOR')
                 handles.FileBPMLocoF=1;
                 set(handles.pushbutton_LoadLoco,'BackgroundColor',[0 1 1]);
                 set(handles.pushbutton_LoadLoco,'enable','On');
                 %set(handles.pushbutton_buildloco,'String','Fichier LOCO:FHCOR');
                
            elseif strcmp(FamActua ,'HCOR')
                handles.FileBPMLocoS=1;
                set(handles.pushbutton_LoadLoco,'BackgroundColor',[0 1 0]);
                set(handles.pushbutton_LoadLoco,'enable','On');
                %set(handles.pushbutton_buildloco,'String','Fichier LOCO:HCOR');
                
            end   
        end    
    end    
end    



set(handles.pushbutton_bruit, 'Enable', 'On');
set(handles.pushbutton_dispersion, 'Enable', 'On');
set(handles.pushbutton_RespMat, 'Enable', 'On');

if ((handles.FileBPMNoise==1)&&(handles.FileBPMDisp==1))&&(handles.FileBPMRespF==1)
    set(handles.pushbutton_buildloco, 'Enable', 'On');
    
end    
if ((handles.FileBPMNoise==1)&&(handles.FileBPMDisp==1))&&(handles.FileBPMRespS==1)
    set(handles.pushbutton_buildloco, 'Enable', 'On');
    
end
if (handles.LocoLoaded==1)
    set(handles.pushbutton_applysym, 'Enable', 'On');
    set(handles.pushbutton_applysymQT, 'Enable', 'On');
    set(handles.Undo_Q_pushbutton, 'Enable', 'On');
    set(handles.Undo_QT_pushbutton, 'Enable', 'On');
    set(handles.pushbuttonPlotQuad, 'Enable', 'On');
    set(handles.pushbuttonPlotQT, 'Enable', 'On');
    set(handles.pushbuttonBPM_G_C, 'Enable', 'On');
else
    set(handles.pushbutton_applysym, 'Enable', 'Off');
    set(handles.pushbutton_applysymQT, 'Enable', 'Off');
    set(handles.Undo_Q_pushbutton, 'Enable', 'Off');
    set(handles.Undo_QT_pushbutton, 'Enable', 'Off');
    set(handles.pushbuttonPlotQuad, 'Enable', 'Off');
    set(handles.pushbuttonPlotQT, 'Enable', 'Off');
    set(handles.pushbuttonBPM_G_C, 'Enable', 'Off');
end    
guidata(hObject, handles);
%%
function load_Loco(hObject,handles)
Filename=handles.locoFilename;
Pathname=handles.locoPathname;
%get iteration number
iterationLoco=get(handles.Iteration,'Value');
if isequal(Filename,0) || isequal(Pathname,0)
       disp('User pressed cancel')
       handles.LocoLoaded=0;
else
    if ~exist(fullfile(Pathname, Filename), 'file')    % create LocoFile and do Iteration
                
            buildlocoinput(fullfile(Pathname,Filename));
            StartFrom=1;
            %% load LocoVariable in File
            load(Filename);
            for i = StartFrom+1:(StartFrom+1+iterationLoco-1)
                fprintf('   Iteration #%d\n', i-1);

                % Start with the old values
                BPMData(i) = BPMData(i-1);
                CMData(i) = CMData(i-1);
                FitParameters(i) = FitParameters(i-1);
                LocoFlags(i) = LocoFlags(i-1);
                LocoFlags(i).SVmethod=LocoFlags(i).Threshold;
                % Run loco
                [LocoModel(i), BPMData(i), CMData(i), FitParameters(i), LocoFlags(i), RINGData] = loco(LocoMeasData, BPMData(i), CMData(i), FitParameters(i), LocoFlags(i), RINGData);
                save(Filename, 'LocoModel', 'FitParameters', 'BPMData', 'CMData', 'RINGData', 'LocoMeasData', 'LocoFlags');
                load(Filename);
            end    
            set(handles.pushbutton_buildloco,'BackgroundColor',[0 1 0]);
    end
      
   
    [ HBPMgain,VBPMgain,HBPMcoupling,VBPMcoupling ] = locodata(Filename, iterationLoco,'HBPMgain',[],'VBPMgain',[],'HBPMcoupling',[],'VBPMcoupling',[]);
   
    C = zeros(length(HBPMgain),2,2);
    for ik =1:length(C),
        C(ik,:,:)= [ HBPMgain(ik)       HBPMcoupling(ik) 
                     VBPMcoupling(ik)   VBPMgain(ik)      ];
        Cinv(ik,:,:) = inv(squeeze(C(ik,:,:)));
    end
    clear AM;
    BPMDataForIndex=load(Filename,'BPMData');
    HBPMGoodDataIndex=BPMDataForIndex.BPMData(iterationLoco).HBPMGoodDataIndex;
    AM.DeviceList = elem2dev('BPMx',HBPMGoodDataIndex);
    AM.CreatedBy = mfilename;
    AM.Locodata = Filename; % date to be updated 
    for ik=1: size(AM.DeviceList,1),
        AM.Cinv{ik,1} = squeeze(Cinv(ik,:,:));
    end
    AM.Description='Matrix for get true value from each BPM [invHGain invHCoupling; invVCoupling invVGain]';
    handles.AM=AM;
    
    [K1, Tune1] = locodata(Filename, iterationLoco, 'FitValues',[],'Tune',[]);
    [K0, Tune0] = locodata(Filename, 0, 'FitValues',[],'Tune',[]);
    if ~isempty(K1) & ~isempty(K0),
        handles.DKoK = (K1-K0)./K0*100;
        handles.DK = (K1-K0);
        handles.CreatedBy = mfilename;
        handles.TimeStamp = datestr(now)
    else
        warndlg('FitValues is empty please check your LOCO FILE');
    end
    %%
    handles.mode = getmode('BPMx'); % ?
    handles.KBefore=[];
    handles.List={'Q1','Q2','Q3','Q4','Q5','Q6','Q7','Q8','Q9','Q10','Q11','Q12','QT'};
    for i=1:length(handles.List)
        handles.KBefore{i}=getsp(handles.List{i},handles.mode,'Physics');
    end 
    %%
    handles.tune_before = gettune;
    handles.LocoLoaded = 1;    
    layout(hObject,handles);
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Iteration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Iteration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonPlotQuad.
function pushbuttonPlotQuad_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPlotQuad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Filename=handles.locoFilename;
Pathname=handles.locoPathname;
debi=1;
endi=0;
for i=1:(length(handles.List))    
    if ~strcmp('QT',handles.List{i})
        endi=endi+length(handles.KBefore{i});
    end
    
end
plotlocodata(fullfile(Pathname, Filename),handles.StandardLocoFile,'PlotRange',[debi endi],'DK');


% --- Executes on button press in pushbuttonPlotQT.
function pushbuttonPlotQT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPlotQT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Filename=handles.locoFilename;
Pathname=handles.locoPathname;
debi=0;
for i=1:(length(handles.List))
    endi=debi+length(handles.KBefore{i});
    debi=debi+1;    
    if strcmp('QT',handles.List{i})
        plotlocodata(fullfile(Pathname, Filename),handles.StandardLocoFile,'PlotRange',[debi endi],'DK');
    end
    debi=endi;
end


% --- Executes on button press in pushbuttonHelp.
function pushbuttonHelp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbuttonFilesGolden.
function pushbuttonFilesGolden_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonFilesGolden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    switch questdlg('Do you want copy file(s) to the operationalMode Folder?','Question','Yes', 'No', 'No');
    case 'Yes'
        CurrentDir = pwd;
        PathOps=getfamilydata('Directory','OpsData');
        FileName2Copy=uigetfile('*.mat','Please select file to copy');
        if isequal(FileName2Copy,0)
            disp('User selected Cancel');
            return;
        end    
        PathOps=uigetdir(PathOps,'Please Confirm Path');
        if isequal(PathOps,0)
            disp('User selected Cancel');
            return;
        end   
        system(sprintf('cp %s %s', fullfile(CurrentDir,FileName2Copy),PathOps));
        switch questdlg('Do you want to link this file to a SOFB or FOFB BPM Golden File or Golden Dispersion File?','Question','Yes', 'No', 'No');
        case 'Yes'
            cd(PathOps);
            Link2FileName=uigetfile('*.mat','Please select file to replace with the new link');
            if isequal(Link2FileName,0)
                disp('User selected Cancel');
                cd(CurrentDir);
                return;
            end  
            system(sprintf('rm -v %s',  Link2FileName));
            system(sprintf('ln -s -v %s %s', FileName2Copy,  Link2FileName));
            cd(CurrentDir);
        end    
    end    

% --- Executes on button press in pushbuttonBPM_G_C.
function pushbuttonBPM_G_C_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonBPM_G_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AM=handles.AM;
FileNameBPM = appendtimestamp('BPM_gain_coupling_LOCO');
[FileNameBPM, Pathname]=uiputfile('*.mat','create BPM Gain Coupling File',FileNameBPM);
if FileNameBPM == 0
    FileNameBPM = '';
    return
end
save(FileNameBPM, 'AM');
opsDataDirectory=getfamilydata('Directory','OpsData');
copyfile(FileNameBPM,opsDataDirectory); %copy the file to lattice folder

switch questdlg('Do you want to make this file became the DefaultFile of lattice folder?','Question','Yes', 'No', 'No');
    case 'Yes'
        CurrentDir = pwd;
        GoldenName=[getfamilydata('OpsData','BPMGainAndCouplingFile'),'.mat'];
        cd(opsDataDirectory);
        VersionName = FileNameBPM;
        if isempty(VersionName)
            cd(CurrentDir);
            error('Abort: No File')
        end
        [tmp File2deploy ext] = fileparts(VersionName);
        system(sprintf('rm -v %s', GoldenName));
        system(sprintf('ln -s -v %s %s', [File2deploy ext], GoldenName));
        
        d=date;
        fid=fopen('BPMGainAndCouplingFileHistory.txt', 'a');
        fprintf(fid,sprintf('\n%s : %s -->%s \n',d,[File2deploy ext], GoldenName));
        fclose(fid);
        
        cd(CurrentDir);
end


% --- Executes during object creation, after setting all properties.
function text5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
