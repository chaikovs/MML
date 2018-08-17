function varargout = Ringcycling(varargin)
% RINGCYCLING M-file for Ringcycling.fig
%      RINGCYCLING, by itself, creates a new RINGCYCLING or raises the existing
%      singleton*.
%
%      H = RINGCYCLING returns the handle to a new RINGCYCLING or the handle to
%      the existing singleton*.
%
%      RINGCYCLING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RINGCYCLING.M with the given input arguments.
%
%      RINGCYCLING('Property','Value',...) creates a new RINGCYCLING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ringcycling_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ringcycling_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: getcyclecurve, magnetcycle, LT1cycling, setcyclecurve, cyclingcommand

% Edit the above text to modify the response to help Ringcycling

% Last Modified by GUIDE v2.5 22-Oct-2013 11:25:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Ringcycling_OpeningFcn, ...
                   'gui_OutputFcn',  @Ringcycling_OutputFcn, ...
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


% --- Executes just before Ringcycling is made visible.
function Ringcycling_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Ringcycling (see VARARGIN)

% Choose default command line output for Ringcycling
handles.output = hObject;

% A MODIFIER ULTERIEUREMENT : INACTIVATION DES FONCTIONS
% CYCLAGE CORRECTEURS / ALL 
set(handles.checkbox_HCOR,'Value',0);
set(handles.checkbox_VCOR,'Value',0);
set(handles.checkbox_all,'Value',0);
set(handles.checkbox_all,'Enable','On');

%set([handles.checkbox_all,handles.checkbox_HCOR,handles.checkbox_VCOR],...
%    'Enable','off');

% par defaut type cyclage sur 'full'
set(handles.popupmenu_type,'Value',2);

% button group sur switch mode simulation ou online 
h = uibuttongroup('visible','off','Position',[0.56 0.46 .18 .10],...
    'Title','','TitlePosition','centertop',...
    'BackgroundColor',[0.696 1.0 0.924]);
u1 = uicontrol('Style','Radio','String','premier element','Tag','radiobutton1',...
    'pos',[10 25 120 25],'parent',h,'HandleVisibility','off',...
    'BackgroundColor',[0.696 1.0 0.924]);
u2 = uicontrol('Style','Radio','String','toute la famille','Tag','radiobutton2',...
    'pos',[10 0.95 120 25],'parent',h,'HandleVisibility','off',...
    'BackgroundColor',[0.696 1.0 0.924]);

set(h,'SelectionChangeFcn',...
    {@uibuttongroup_SelectionChangeFcn,handles});

set(h,'SelectedObject',u1);  % No selection
set(h,'Visible','on');

% mode de plot
handles.mode = '1element';
handles.configmode = 'confignominal';

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Ringcycling wait for user response (see UIRESUME)
% uiwait(handles.figure1);
list = {'Present', 'Golden', 'UserSelect'};
set(handles.popupmenu_file,'String',list);

list = {'Simple', 'Full', 'startup'};
set(handles.popupmenu_type,'String',list);

list = {'Load cycling curve','Start', 'StartOnly', 'Stop', 'Init', 'Pause', 'Resume'};
set(handles.popupmenu_command,'String',list);

% --- Outputs from this function are returned to the command line.
function varargout = Ringcycling_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in checkbox_none.
function checkbox_none_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_none (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_none
val = get(hObject,'Value');

if val
    set(handles.checkbox_BEND,'Value',0);
    set(handles.checkbox_HCOR,'Value',0);
    set(handles.checkbox_VCOR,'Value',0);
    %set(handles.checkbox_QT,'Value',0);
    
    % Quads    
    for k =1:(length(findmemberof('QUAD'))-2), 
        Name = strcat('QP',num2str(k));
        set(handles.(['checkbox_',Name]),'Value',0)
    end
    set(handles.(['checkbox_','QP31']),'Value',0)
    set(handles.(['checkbox_','QP41']),'Value',0)
    
    % Sextu
    set(handles.checkbox_SX1,'Value',0);
    set(handles.checkbox_SX2,'Value',0);
    set(handles.checkbox_SX3,'Value',0);
  

    set(handles.checkbox_all,'Value',0);
    set(handles.checkbox_AllQuad,'Value',0);
    set(handles.checkbox_AllSextu,'Value',0);
    set(handles.checkbox_noneQuad,'Value',1);
    set(handles.checkbox_NoneSextu,'Value',1);

else
    set(handles.checkbox_noneQuad,'Value',0);
    set(handles.checkbox_NoneSextu,'Value',0);
end

% --- Executes on button press in checkbox_all.
function checkbox_all_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_all

% not used
%disp('checkbox_all_Callback: Not used');
%return;
val = get(hObject,'Value');

if val
    set(handles.checkbox_BEND,'Value',1);
    
    % Quad
    
    for k =1:4, %length(findmemberof('QUAD')), 
        Name = strcat('QP',num2str(k));
        set(handles.(['checkbox_',Name]),'Value',1)
    end
     set(handles.(['checkbox_','QP31']),'Value',1)
     set(handles.(['checkbox_','QP41']),'Value',1)
      
    % Sextu        
    set(handles.checkbox_SX1,'Value',1);
    set(handles.checkbox_SX2,'Value',1);
    set(handles.checkbox_SX3,'Value',1);
   
    % Correctors
    set(handles.checkbox_HCOR,'Value',1);
    set(handles.checkbox_VCOR,'Value',1);

    set(handles.checkbox_all,'Value',1);
    set(handles.checkbox_AllQuad,'Value',1);
    set(handles.checkbox_AllSextu,'Value',1);
    set(handles.checkbox_noneQuad,'Value',0);
    set(handles.checkbox_NoneSextu,'Value',0);
    % none
    set(handles.checkbox_none,'Value',0);
else
    set(handles.checkbox_BEND,'Value',0);
    
    % Quad
    
    for k =1:4, %length(findmemberof('QUAD')),
        Name = strcat('QP',num2str(k));
        set(handles.(['checkbox_',Name]),'Value',0)
    end
     set(handles.(['checkbox_','QP31']),'Value',0)
     set(handles.(['checkbox_','QP41']),'Value',0)
      
    % Sextu        
    set(handles.checkbox_SX1,'Value',0);
    set(handles.checkbox_SX2,'Value',0);
    set(handles.checkbox_SX3,'Value',0);
   
    % Correctors
    set(handles.checkbox_HCOR,'Value',0);
    set(handles.checkbox_VCOR,'Value',0);

    set(handles.checkbox_all,'Value',0);
    set(handles.checkbox_AllQuad,'Value',0);
    set(handles.checkbox_AllSextu,'Value',0);
    set(handles.checkbox_noneQuad,'Value',0);
    set(handles.checkbox_NoneSextu,'Value',0);
    % none
    set(handles.checkbox_none,'Value',0);
end


% --- Executes on button press in checkbox_BEND.
function checkbox_BEND_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_BEND (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_BEND

set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);
val = get(handles.checkbox_BEND,'Value');
valQP1 = get(handles.checkbox_QP1,'Value');valQP2 = get(handles.checkbox_QP2,'Value');
valQP3 = get(handles.checkbox_QP3,'Value');valQP4 = get(handles.checkbox_QP4,'Value');
valQP31 = get(handles.checkbox_QP31,'Value');valQP41 = get(handles.checkbox_QP41,'Value');

valQtous = get(handles.checkbox_AllQuad,'Value');
valeurs = [valQP1 valQP2 valQP3 valQP4 valQP31 valQP41 valQtous];
test = ones(7,1)'*0;

if val    
    if ~isequal(valeurs,test)
        errordlg('conflit entre Quad et Dipole !','Erreur');
        set(handles.checkbox_BEND,'Value',0);
        return
    end
    
    % Disable cycling quadrupole and sextupoles
    for k = 1:4%length(findmemberof('QUAD')) 
        Name = strcat('QP',num2str(k));
        set(handles.(['checkbox_',Name]),'Enable','off')
    end
    
    set(handles.(['checkbox_','QP31']),'Enable','off');
    set(handles.(['checkbox_','QP41']),'Enable','off');
    
    set(handles.checkbox_AllQuad,'Enable','off');

    set(handles.checkbox_AllSextu,'Enable','off')
    for k = 1:length(findmemberof('SEXT'))
        Name = strcat('SX',num2str(k));
        set(handles.(['checkbox_',Name]),'Enable','off')
    end    

else
    val2 = get(handles.checkbox_AllQuad,'Value');
    if val2==0
        
        % Enable cyling of quad and sextu
        for k = 1:4%length(findmemberof('QUAD')) 
            Name = strcat('QP',num2str(k));
            set(handles.(['checkbox_',Name]),'Enable','on')
        end
         set(handles.(['checkbox_','QP31']),'Enable','on');
         set(handles.(['checkbox_','QP41']),'Enable','on');
        set(handles.checkbox_AllQuad,'Enable','on');

        set(handles.checkbox_AllSextu,'Enable','on')
        for k = 1:length(findmemberof('SEXT'))
            Name = strcat('SX',num2str(k));
            set(handles.(['checkbox_',Name]),'Enable','on')
        end

    end
end


% --- Executes on button press in checkbox_QP1.
function checkbox_QP1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_QP1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_QP1


set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);

% --- Executes on button press in checkbox_HCOR.
function checkbox_HCOR_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_HCOR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_HCOR

set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);

% --- Executes on button press in checkbox_VCOR.
function checkbox_VCOR_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_VCOR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_VCOR

set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);

% --- Executes on button press in pushbutton_apply.
function pushbutton_apply_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = get(handles.popupmenu_command,'String');
command = contents{get(handles.popupmenu_command,'Value')};

switch command
    case {'Load cycling curve','Start', 'StartOnly', 'Stop','Init','Pause','Resume'}
        cyclemagnet_local(command,handles);
    otherwise
        error('Unknown command name: %s ', command);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 function cyclemagnet_local(command,handles)

%     [CycleIndex, CycleAO] = isfamily(CycleFamily);
% 
%     rep = tango_group_command_inout2(CycleAO.GroupId,'State',1,0);

Family={'BEND',...
        'QP1','QP2','QP3','QP4','QP31','QP41'...
        'SX1','SX2','SX3',...
        'HCOR','VCOR'};    
    
Families = {};
for k =1:length(Family)
    if get(handles.(['checkbox_',Family{k}]),'Value')
        Families = {Families{:}, Family{k}};
    end
end

% Check if quad ie magnets with offsets used for FFWD on tunes
quadFlag = 0;
for k=1:length(Families),
    if ismemberof(Families{k}, 'QUAD') 
        quadFlag = 1;
    end
end


if quadFlag
    % Disable undulator tune FFWD
    % tango_write_attribute2('ans/ei/nuffwd', 'booleanResult', uint8(0))
    % Should give back 0
    % temp = tango_read_attribute2('ans/ei/nuffwd', 'booleanResult')
%     FFWDFlag = readattribute('ans/ei/nuffwd/booleanResult');
%     if FFWDFlag ~=0
%         errordlg(sprintf('Tune FFWD still active\n Cycling aborted'));
%         return;
%     else
%         Answer = questdlg('Forcing Offsets of quadrupoles to zero (no: cancel)', 'Confirmation box','Yes','No','No');
%         if strcmpi(Answer, 'No')
%             %
%         else
%             setquadoffset2zero
%             pause(1);
%         end
%         % Check Offsets before any cycling
%         % Set offsets to zero
%         lineStr = sprintf('Offsets non zero\n\n');
%         NonZeroOffsetFlag =0; Str1={'yes', 'no'};
%         for k=1:length(Families),
%             if ismemberof(Families{k}, 'QUAD')
%                  % Check offset null
%                  lineStr = [lineStr sprintf('Family % 4s  Offset null ? %s \n', Families{k}, ...
%                      Str1{any(getpv(Families{k}, 'SumOffset') ~= 0)})];
%                  NonZeroOffsetFlag =any(getpv(Families{k}, 'SumOffset') ~= 0) | NonZeroOffsetFlag;
%             end
%         end
%         
%         % Popup menu if nonzero offsets
%         if NonZeroOffsetFlag
%             lineStr = [lineStr sprintf('\n\n Continue ?\n');];
%             Answer = questdlg(lineStr, 'Cycling','Yes','No','No');
%             if strcmpi(Answer, 'No')
%                 return;
%             end
%         end
%         % ANS-C10/EI/C-U20_OFFF/nuffCorrectionOuputEnabled
%     end
end

switch command
    case {'Start'}
        % get cycling file
        contents = get(handles.popupmenu_file,'String');
        file = contents{get(handles.popupmenu_file,'Value')};

        % get cycling type
        contents = get(handles.popupmenu_type,'String');
        type = contents{get(handles.popupmenu_type,'Value')};

        % cycle magnets
        magnetcycle(type,file,Families,'NoDisplay','Config');
        
    case {'StartOnly'}
        % get cycling file
        contents = get(handles.popupmenu_file,'String');
        file = contents{get(handles.popupmenu_file,'Value')};

        % get cycling type
        contents = get(handles.popupmenu_type,'String');
        type = contents{get(handles.popupmenu_type,'Value')};

        % Cycle magnet
        magnetcycle(type,file,Families,'NoDisplay','NoConfig');

    case {'Load cycling curve'}
        
        contents = get(handles.popupmenu_file,'String');
        file = contents{get(handles.popupmenu_file,'Value')};

        % get cycling file
        contents = get(handles.popupmenu_type,'String');
        type = contents{get(handles.popupmenu_type,'Value')};

        % Config magnet
        magnetcycle(type,file,Families,'NoDisplay','Config','NoApply');
        
        
    case {'Stop','Init','Pause','Resume'}
        for k =1:length(Families)
            CycleFamily = ['Cycle' Families{k}];
            cyclingcommand(CycleFamily,command);
        end
end

% --- Executes on selection change in popupmenu_command.
function popupmenu_command_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_command (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_command contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_command

% --- Executes during object creation, after setting all properties.
function popupmenu_command_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_command (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_type.
function popupmenu_type_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_type


% --- Executes during object creation, after setting all properties.
function popupmenu_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_file.
function popupmenu_file_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_file contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_file


% --- Executes during object creation, after setting all properties.
function popupmenu_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_QP2.
function checkbox_QP2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_QP2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_QP2


set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);


% --- Executes on button press in checkbox_QP3.
function checkbox_QP3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_QP3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_QP3
set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);


% --- Executes on button press in checkbox_QP4.
function checkbox_QP4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_QP4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_QP4

set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);

% --- Executes on button press in checkbox_QP31.
function checkbox_QP31_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_QP31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_QP31
set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);


% --- Executes on button press in checkbox_QP41.
function checkbox_QP41_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_QP41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_QP41
set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);


% --- Executes on button press in checkbox_SX1.
function checkbox_SX1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_SX1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_SX1


set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);


% --- Executes on button press in checkbox_SX2.
function checkbox_SX2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_SX2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_SX2

set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);


% --- Executes on button press in checkbox_SX3.
function checkbox_SX3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_SX3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_SX3

set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);

% --- Executes on button press in checkbox_AllQuad.
function checkbox_AllQuad_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_AllQuad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_AllQuad

set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);
val = get(handles.checkbox_AllQuad,'Value');

% Selection of number for families depending on the config
switch handles.configmode
    case 'confignominal'
        kQmax = 6;
        kSmax = 3;  
end

if val
    set(handles.checkbox_noneQuad,'Value',0);      
    for k = 1:(kQmax-2), 
        Name = strcat('QP',num2str(k));
        set(handles.(['checkbox_',Name]),'Enable','on')
        set(handles.(['checkbox_',Name]),'Value',1)
    end
        set(handles.(['checkbox_','QP31']),'Enable','on');
        set(handles.(['checkbox_','QP31']),'Value',1);
        set(handles.(['checkbox_','QP41']),'Enable','on');
        set(handles.(['checkbox_','QP41']),'Value',1);
        
    % exclure la montee des dipoles et sextus
    for k = 1:kSmax
        Name = strcat('SX',num2str(k));
        set(handles.(['checkbox_',Name]),'Enable','off')
    end
    set(handles.checkbox_AllSextu,'Enable','off');
    set(handles.checkbox_BEND,'Enable','off');

end

% --- Executes on button press in checkbox_AllSextu.
function checkbox_AllSextu_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_AllSextu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_AllSextu

set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);
val = get(handles.checkbox_AllSextu,'Value');

% Selection of number for families depending on the config
switch handles.configmode
    case 'confignominal'
        kQmax = 6;
        kSmax = 3;
end

if val
    set(handles.checkbox_NoneSextu,'Value',0);    
      
    for k = 1:kSmax,
        Name = strcat('SX',num2str(k));
        set(handles.(['checkbox_',Name]),'Enable','off');
        set(handles.(['checkbox_',Name]),'Value',1)
    end
    % Disable cycling on quad and dipole
    for k = 1:(kQmax-2),
        Name = strcat('QP',num2str(k));
        set(handles.(['checkbox_',Name]),'Enable','off')
    end
    set(handles.(['checkbox_','QP31']),'Enable','off')
    set(handles.(['checkbox_','QP41']),'Enable','off')
    
    set(handles.checkbox_AllQuad,'Enable','off');
    set(handles.checkbox_BEND,'Enable','off');

else
    
    for k = 1:kSmax,
        Name = strcat('SX',num2str(k));
        set(handles.(['checkbox_',Name]),'Enable','on')
    end
    % rendre possible la montee des dipoles et quad
    for k = 1:(kQmax-2),
        Name = strcat('QP',num2str(k));
        set(handles.(['checkbox_',Name]),'Enable','on')
    end
    set(handles.(['checkbox_','QP31']),'Enable','on')
    set(handles.(['checkbox_','QP41']),'Enable','on')
    set(handles.checkbox_AllQuad,'Enable','on');
    set(handles.checkbox_BEND,'Enable','on');
end



% --- Executes on button press in courbe_pushbutton.
function courbe_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to courbe_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% valBEND = get(handles.checkbox_BEND,'Value');
% valQ1 = get(handles.checkbox_QP1,'Value');valQ2 = get(handles.checkbox_QP2,'Value');
% valQ3 = get(handles.checkbox_QP3,'Value');valQ4 = get(handles.checkbox_QP4,'Value');
% valQ5 = get(handles.checkbox_QP31,'Value');valQ6 = get(handles.checkbox_QP41,'Value');
% valQtous = get(handles.checkbox_AllQuad,'Value');
% valS1 = get(handles.checkbox_SX1,'Value');valS2 = get(handles.checkbox_SX2,'Value');
% valQ3 = get(handles.checkbox_SX3,'Value');valS4 = get(handles.checkbox_S4,'Value');
% valStous = get(handles.checkbox_AllSextu,'Value');
% %valeurs = [valQ1 valQ2 valQ3 valQ4 valQ5 valQ6 valQtous];
% test = ones(7,1)'*0;

%  for i = 1:10
%       name = strcat('valQ',num2str(i))
%        if eval(name)

name=['axes' num2str(1)];
axes(handles.(name));

Family={'BEND', 'HCOR', 'VCOR',...
    'QP1','QP2','QP3','QP4','QP31','QP41'...
    'SX1','SX2','SX3'};    
    
hold off;

for k =1:length(Family)
    if get(handles.(['checkbox_',Family{k}]),'Value')
        Name = strcat('Cycle',Family{k});
        %Name = Family{k};

        %vect = getfamilydata(Name,'DeviceName');
        vect = family2tangodev(Name);
        if ~iscell(vect)
            vect = {vect};
        end
        if strcmp(handles.mode,'1element')
            jend = 1;
        elseif strcmp(handles.mode,'lafamille')
            jend = length(vect);
        end

        % plot de la courbe de cyclage du premier element magnetique de la
        % famille)
        for j = 1:jend
            curve = getcyclecurve(vect{j});

            if iscell(curve)
                for k=1:length(curve),
                    n = size(curve{k}.Data,1);
                    % time vector
                    cums = cumsum(curve{k}.Data(:,2))';
                    x = [cums; cums];
                    x = reshape(x,1,2*n);
                    x = [0 x(1:end-1)];

                    % amplitude vector
                    y = [curve{k}.Data(:,1),curve{k}.Data(:,1)]';
                    y = reshape(y,1,2*n);
                    
                    plot(x,y,'b.-');
                    xlabel('Temps (s)');
                    ylabel('Courant [A]');
                    ylim([min(y) max(y)*1.05]);
                    title(['Cycling curve for ' curve{k}.DeviceName]);
                    grid on
                end
            else
                n = size(curve,1);
                % time vector
                cums = cumsum(curve(:,2))';
                x = [cums; cums];
                x = reshape(x,1,2*n);
                x = [0 x(1:end-1)];

                % amplitude vector
                y = [curve(:,1),curve(:,1)]';
                y = reshape(y,1,2*n);


                plot(x,y,'b.-');
                xlabel('Temps (s)');
                ylabel('Courant [A]');
                ylim([min(y)*1.1 max(y)*1.1]);
                title('Courbe de cyclage');
                grid on
            end
            hold on
        end
        hold on
    end
end

% --- Executes on button press in pushbutton_singledevice.
function pushbutton_singledevice_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_singledevice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function uibuttongroup_SelectionChangeFcn(hObject,eventdata,handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch get(get(hObject,'SelectedObject'),'Tag')  % Get Tag of selected object
    case 'radiobutton1'
        % code piece when radiobutton1 is selected goes here
        % 'Mode' = 'Simulation';
        handles.mode = '1element';
       
    case 'radiobutton2'
        % code piece when radiobutton_configS11 is selected goes here 
        % '.Mode' = 'Machine';
        handles.mode = 'lafamille';
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in checkbox_noneQuad.
function checkbox_noneQuad_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_noneQuad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_noneQuad

set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);
val = get(handles.checkbox_noneQuad,'Value');

if val
    set(handles.checkbox_AllQuad,'Value',0);
    for k = 1:(length(findmemberof('QUAD'))-2)
        Name = strcat('QP',num2str(k));
        set(handles.(['checkbox_',Name]),'Enable','on')
        set(handles.(['checkbox_',Name]),'Value',0)
    end
       set(handles.(['checkbox_','QP31']),'Enable','on')
        set(handles.(['checkbox_','QP31']),'Value',0) 
        set(handles.(['checkbox_','QP41']),'Enable','on')
        set(handles.(['checkbox_','QP41']),'Value',0)
    
    % rendre possible la montee des dipoles et sextus
    for k = 1:length(findmemberof('SEXT'))
        Name = strcat('SX',num2str(k));
        set(handles.(['checkbox_',Name]),'Enable','on')
    end
    set(handles.checkbox_AllSextu,'Enable','on');
    set(handles.checkbox_BEND,'Enable','on');
end


% --- Executes on button press in checkbox_NoneSextu.
function checkbox_NoneSextu_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_NoneSextu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_NoneSextu

set(handles.checkbox_all,'Value',0);
set(handles.checkbox_none,'Value',0);
val = get(handles.checkbox_NoneSextu,'Value');

if val
    set(handles.checkbox_AllSextu,'Value',0);    
    for k = 1:length(findmemberof('SEXT'))
        Name = strcat('SX',num2str(k));
        set(handles.(['checkbox_',Name]),'Enable','on')
        set(handles.(['checkbox_',Name]),'Value',0)
    end

    % Enable cycling of quads abd dipole
    for k = 1:(length(findmemberof('QUAD'))-2)
        Name = strcat('QP',num2str(k));
        set(handles.(['checkbox_',Name]),'Enable','on')
    end
    set(handles.(['checkbox_','QP31']),'Enable','on')
    set(handles.(['checkbox_','QP41']),'Enable','on')
    
    set(handles.checkbox_AllQuad,'Enable','on');
    set(handles.checkbox_BEND,'Enable','on');
end

% --- Executes on button press in pushbutton_CyclingStatus.
function pushbutton_CyclingStatus_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_CyclingStatus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Families={'BEND', 'HCOR', 'VCOR', ...
    'QP1','QP2','QP3','QP4','QP31','QP41'...
    'SX1','SX2','SX3'};    

FamilyNumber = length(Families);

totalProgression = zeros(1, FamilyNumber);

for k1=1:FamilyNumber,
    CycleFamily = ['Cycle' Families{k1}];
    [CycleIndex, CycleAO] = isfamily(CycleFamily);   
    totalProgression(k1) =  mean(tango_group_read_attribute2(CycleAO.GroupId,'totalProgression'));
end
%
fprintf('\nCycling state, %s\n',datestr(now))
for k1=1:FamilyNumber,
    fprintf('Family %s, cycling state: %03.0f %%\t', Families{k1}, totalProgression(k1))
    if k1~=1 && mod(k1+1,2) , 
        fprintf('\n')
    end
end



% --- Executes during object creation, after setting all properties.
function popupmenu_singledevice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_singledevice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', family2tangodev('Qall'));


% --- Executes on button press in pushbutton_FFWD_ON.
function pushbutton_FFWD_ON_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FFWD_ON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
writeattribute('ans/ei/nuffwd/booleanResult', uint8(1));
pushbutton_FFWDStatus_Callback(hObject, eventdata, handles);

% --- Executes on button press in pushbutton_FFWD_OFF.
function pushbutton_FFWD_OFF_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FFWD_OFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
writeattribute('ans/ei/nuffwd/booleanResult', uint8(0));
pushbutton_FFWDStatus_Callback(hObject, eventdata, handles);

% --- Executes on button press in pushbutton_FFWDStatus.
function pushbutton_FFWDStatus_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FFWDStatus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.checkbox_FFWD_STATUS, 'Enable', 'Off');
pause(3)
FFWDFlag = readattribute('ans/ei/nuffwd/booleanResult');
% any(getpv({'Q1','Q2', 'Q3', 'Q4', 'Q5', ...
%     'Q6','Q7', 'Q8', 'Q9', 'Q10'}, 'SumOffset') ~= 0)
set(handles.checkbox_FFWD_STATUS, 'Value', FFWDFlag);
set(handles.checkbox_FFWD_STATUS, 'Enable', 'On');


% --- Executes on button press in pushbutton_offset2zero.
function pushbutton_offset2zero_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_offset2zero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Answer = questdlg('Forcing Offsets of quadrupole magnets to zero (no: cancel)', 'Confirmation box','Yes','No','No');
if strcmpi(Answer, 'No')
    %
else
    setquadoffset2zero
end
        
% --- Executes on button press in pushbutton_plotoffset.
function pushbutton_plotoffset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plotoffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

plotquad('Offset1','NoMean')

% --- Executes on button press in pushbutton_plotcurrentPM.
function pushbutton_plotcurrentPM_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plotcurrentPM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

plotquad('Setpoint','NoMean')


% --- Executes on button press in pushbutton_current.
function pushbutton_current_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

plotquad('Mean')
plotquad('NoMean')


% --- Executes when selected object is changed in uipanel_gestionConfig.
function uipanel_gestionConfig_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_gestionConfig 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

switch get(hObject,'Tag')  % Get Tag of selected object
    case 'radiobutton_confignominal'
        % code piece when radiobutton1 is selected goes here
        handles.configmode = 'confignominal';
        
end
% Update handles structure
guidata(hObject, handles);
