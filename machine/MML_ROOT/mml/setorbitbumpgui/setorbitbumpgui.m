function varargout = setorbitbumpgui(varargin)
%SETORBITBUMPGUI M-file for setorbitbumpgui.fig
%      SETORBITBUMPGUI, by itself, creates a new SETORBITBUMPGUI or raises the existing
%      singleton*.
%
%      H = SETORBITBUMPGUI returns the handle to a new SETORBITBUMPGUI or the handle to
%      the existing singleton*.
%
%      SETORBITBUMPGUI('Property','Value',...) creates a new SETORBITBUMPGUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to setorbitbumpgui_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SETORBITBUMPGUI('CALLBACK') and SETORBITBUMPGUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SETORBITBUMPGUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setorbitbumpgui

% Last Modified by GUIDE v2.5 04-Feb-2015 23:55:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @setorbitbumpgui_OpeningFcn, ...
    'gui_OutputFcn',  @setorbitbumpgui_OutputFcn, ...
    'gui_LayoutFcn',  [], ...
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


% --- Executes just before setorbitbumpgui is made visible.
function setorbitbumpgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for setorbitbumpgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% Horizontal BPM device list
Family = gethbpmfamily;
BPMDeviceList = family2dev(Family);

BPMDeviceListString = '';
for i = 1:size(BPMDeviceList,1)
    BPMDeviceListString = strvcat(BPMDeviceListString, sprintf('%s[%d, %d]', 'BPM', BPMDeviceList(i,:)));
end

set(handles.HBPM1DevList, 'String', BPMDeviceListString);
set(handles.HBPM2DevList, 'String', BPMDeviceListString);
set(handles.HBPM1DevList, 'Value', 1);
set(handles.HBPM2DevList, 'Value', 1);
set(handles.HBPM1DevList, 'UserData', BPMDeviceList);
set(handles.SetAngleH,'Enable','off');
set(handles.Edt_H_Angle,'Enable','off');

% Vertical BPM device list
Family = getvbpmfamily;
BPMDeviceList = family2dev(Family);

BPMDeviceListString = '';
for i = 1:size(BPMDeviceList,1)
    BPMDeviceListString = strvcat(BPMDeviceListString, sprintf('%s[%d, %d]', 'BPM', BPMDeviceList(i,:)));
end

set(handles.VBPM1DevList, 'String', BPMDeviceListString);
set(handles.VBPM2DevList, 'String', BPMDeviceListString);
set(handles.VBPM1DevList, 'Value', 1);
set(handles.VBPM2DevList, 'Value', 1);
set(handles.VBPM1DevList, 'UserData', BPMDeviceList);
set(handles.SetAngleV,'Enable','off');
set(handles.Edt_V_Angle,'Enable','off');


% Zero the remove correction cell
set(handles.Remove, 'UserData', {});

CMIncrementListString = [
    '      -2 -1 1 2                             '
    '      -3 -1 1 3                             '
    '      -3 -2 2 3                             '
    '      -4 -1 1 4                             '
    '      -4 -3 3 4                             '
    '      -3 -1 2 3                             '
    '      -3 -2 1 3                             '
    '      -2 -1 1                               '
    '      -3 -1 1                               '
    '         -1 1 2                             '
    '         -1 1 3                             '
    '   -3 -2 -1 1 2 3                           '
    '-4 -3 -2 -1 1 2 3 4                         '
    '-7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7          '
    '-8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8     '
    '-9 -8 -7 -6 -5 -4 -3 -2 -1 1 2 3 4 5 6 7 8 9'
    '   Modify List                              '
    ];


for i = 1:size(CMIncrementListString,1)-1
    CMIncrementListCell{i,1} = str2num(CMIncrementListString(i,:))';
end
CMIncrementListCell{size(CMIncrementListString,1),1} = [];


% Short bumps in the ALS can casue trouble
if strcmpi(getfamilydata('Machine'), 'ALS')
    iInit = 2;
else
    iInit = 1;
end
set(handles.HCMGroup, 'Value', iInit);
set(handles.VCMGroup, 'Value', iInit);
CMIncrementListCell{end} = CMIncrementListCell{iInit};

set(handles.HCMGroup, 'String',   CMIncrementListString);
set(handles.VCMGroup, 'String',   CMIncrementListString);
set(handles.HCMGroup, 'UserData', CMIncrementListCell);
set(handles.VCMGroup, 'UserData', CMIncrementListCell);


% UIWAIT makes setorbitbumpgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = setorbitbumpgui_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;


function HBPM1_Callback(hObject, eventdata, handles)

% Get the inputs and strip commas
BPMString = get(handles.HBPM1,'String');
BPMString(find(BPMString==',')) = '.';
BPMnew = sscanf(BPMString,'%f');
BPMString=strcat(num2str(BPMnew),' mm');
set(handles.HBPM1,'String',BPMString);
 
% Check for 1 BPM
BPM1n = get(handles.HBPM1DevList, 'Value');
BPM2n = get(handles.HBPM2DevList, 'Value');
BPM1v = sscanf(get(handles.HBPM1, 'String'),'%f');
BPM2v = sscanf(get(handles.HBPM2, 'String'),'%f');
NumberBPM = length(get(handles.HBPM1DevList, 'String'));
if BPM1n == BPM2n
    set(handles.HBPM2,'String',get(handles.HBPM1,'String'));
    set(handles.Edt_H_Angle, 'Enable', 'Off');
    set(handles.Edt_H_Angle, 'String', '0.00 mrad');    
    set(handles.SetAngleH,'Enable','off');
    set(handles.SetAngleH,'Value',0);
    set(handles.HBPM1, 'Enable', 'On');
    set(handles.HBPM2, 'Enable', 'On');
elseif abs(BPM1n-BPM2n)==1 
    set(handles.SetAngleH,'Enable','on');
    BPM_DistanceH=diff(getspos('BPMx',[BPM1n ;BPM2n]));    
    DeltaV=BPM2v-BPM1v;
    AngleH=DeltaV/BPM_DistanceH;
    AngleH=strcat(num2str(AngleH),' mrad')
    set(handles.Edt_H_Angle, 'String', AngleH);
elseif abs(BPM1n-BPM2n)==(NumberBPM-1) % Special case of First and Last BPM
    set(handles.SetAngleH,'Enable','on');
    circumference=getcircumference;
    BPM_DistanceH=diff(getspos('BPMx',[BPM1n ;BPM2n]));
    BPM_DistanceH=(circumference-abs(BPM_DistanceH))*sign(BPM_DistanceH)*-1;
    DeltaV=BPM2v-BPM1v;
    AngleH=DeltaV/BPM_DistanceH;
    AngleH=strcat(num2str(AngleH),' mrad')
    set(handles.Edt_H_Angle, 'String', AngleH);
else   
    set(handles.Edt_H_Angle, 'Enable', 'Off');
    set(handles.Edt_H_Angle, 'String', '0.00 mrad');
    set(handles.SetAngleH,'Enable','off');
    set(handles.SetAngleH,'Value',0);
    set(handles.HBPM1, 'Enable', 'On');
    set(handles.HBPM2, 'Enable', 'On');

end

if isempty(BPMnew) || isnan(BPMnew) || ~isreal(BPMnew)
    set(handles.BottomText, 'String', 'Upstream Horizontal BPM Input Error');
else
    % Clear an old error
    if strcmp(get(handles.BottomText, 'String'), 'Upstream Horizontal BPM Input Error')
        set(handles.BottomText, 'String', '');
        HBPM2_Callback(handles.HBPM2, eventdata, handles);
    end

    if BPM1n == BPM2n
        if strcmp(get(handles.BottomText, 'String'), 'Downstream Horizontal BPM Input Error')
            set(handles.BottomText, 'String', '');
        end
    end
end


function HBPM2_Callback(hObject, eventdata, handles)
% Get the inputs and strip commas
BPMString = get(handles.HBPM2,'String');
BPMString(find(BPMString==',')) = '.';
BPMnew = sscanf(BPMString,'%f');
BPMString=strcat(num2str(BPMnew),' mm');
set(handles.HBPM2,'String',BPMString);


% Check for 1 BPM
BPM1n = get(handles.HBPM1DevList, 'Value');
BPM2n = get(handles.HBPM2DevList, 'Value');
BPM1v = sscanf(get(handles.HBPM1, 'String'),'%f');
BPM2v = sscanf(get(handles.HBPM2, 'String'),'%f');
NumberBPM = length(get(handles.HBPM2DevList, 'String'));
if BPM1n == BPM2n
    set(handles.HBPM1,'String',get(handles.HBPM2,'String'));
    set(handles.Edt_H_Angle, 'Enable', 'Off');
    set(handles.Edt_H_Angle, 'String', '0.00 mrad');
    set(handles.SetAngleH,'Enable','off');
    set(handles.SetAngleH,'Value',0);
    set(handles.HBPM1, 'Enable', 'On');
    set(handles.HBPM2, 'Enable', 'On');
elseif abs(BPM1n-BPM2n)==1
    set(handles.SetAngleH,'Enable','on');
    BPM_DistanceH=diff(getspos('BPMx',[BPM1n ;BPM2n]));    
    DeltaV=BPM2v-BPM1v;
    AngleH=DeltaV/BPM_DistanceH;
    AngleH=strcat(num2str(AngleH),' mrad')
    set(handles.Edt_H_Angle, 'String', AngleH);
elseif abs(BPM1n-BPM2n)==(NumberBPM-1) % Special case of First and Last BPM
    set(handles.SetAngleH,'Enable','on');
    circumference=getcircumference;
    BPM_DistanceH=diff(getspos('BPMx',[BPM1n ;BPM2n]));
    BPM_DistanceH=(circumference-abs(BPM_DistanceH))*sign(BPM_DistanceH)*-1;
    DeltaV=BPM2v-BPM1v;
    AngleH=DeltaV/BPM_DistanceH;
    AngleH=strcat(num2str(AngleH),' mrad')
    set(handles.Edt_H_Angle, 'String', AngleH); 
else   
    set(handles.Edt_H_Angle, 'Enable', 'Off');
    set(handles.Edt_H_Angle, 'String', '0.00 mrad');
    set(handles.SetAngleH,'Enable','off');
    set(handles.SetAngleH,'Value',0);
    set(handles.HBPM1, 'Enable', 'On');
    set(handles.HBPM2, 'Enable', 'On');
end

if isempty(BPMnew) || isnan(BPMnew) || ~isreal(BPMnew)
    set(handles.BottomText, 'String', 'Downstream Horizontal BPM Input Error');
else
    % Clear an old error
    if strcmp(get(handles.BottomText, 'String'), 'Downstream Horizontal BPM Input Error')
        set(handles.BottomText, 'String', '');
        HBPM1_Callback(handles.HBPM1, eventdata, handles);
    end

    if BPM1n == BPM2n
        if strcmp(get(handles.BottomText, 'String'), 'Upstream Horizontal BPM Input Error')
            set(handles.BottomText, 'String', '');
        end
    end
end


function VBPM1_Callback(hObject, eventdata, handles)
% Get the inputs and strip commas
BPMString = get(handles.VBPM1,'String');
BPMString(find(BPMString==',')) = '.';
BPMnew = sscanf(BPMString,'%f');
BPMString=strcat(num2str(BPMnew),' mm');
set(handles.VBPM1,'String',BPMString);


% Check for 1 BPM
BPM1n = get(handles.VBPM1DevList, 'Value');
BPM2n = get(handles.VBPM2DevList, 'Value');
BPM1v = sscanf(get(handles.VBPM1, 'String'),'%f');
BPM2v = sscanf(get(handles.VBPM2, 'String'),'%f');
NumberBPM = length(get(handles.VBPM1DevList, 'String'));
if BPM1n == BPM2n
    set(handles.VBPM2,'String',get(handles.VBPM1,'String'));
    set(handles.Edt_V_Angle, 'Enable', 'Off');
    set(handles.Edt_V_Angle, 'String', '0.00 mrad');
    set(handles.SetAngleV,'Enable','off');
    set(handles.SetAngleV,'Value',0);
    set(handles.VBPM1, 'Enable', 'On');
    set(handles.VBPM2, 'Enable', 'On');
elseif abs(BPM1n-BPM2n)==1
    set(handles.SetAngleV,'Enable','on');
    BPM_DistanceV=diff(getspos('BPMz',[BPM1n ;BPM2n]));    
    DeltaV=BPM2v-BPM1v;
    AngleV=DeltaV/BPM_DistanceV;
    AngleV=strcat(num2str(AngleV),' mrad')
    set(handles.Edt_V_Angle, 'String', AngleV);
elseif abs(BPM1n-BPM2n)==(NumberBPM-1) % Special case of First and Last BPM
    set(handles.SetAngleV,'Enable','on');
    circumference=getcircumference;
    BPM_DistanceV=diff(getspos('BPMz',[BPM1n ;BPM2n]));
    BPM_DistanceV=(circumference-abs(BPM_DistanceV))*sign(BPM_DistanceV)*-1;
    DeltaV=BPM2v-BPM1v;
    AngleV=DeltaV/BPM_DistanceV;
    AngleV=strcat(num2str(AngleV),' mrad')
    set(handles.Edt_V_Angle, 'String', AngleV);
else   
    set(handles.Edt_V_Angle, 'Enable', 'Off');
    set(handles.Edt_V_Angle, 'String', '0.00 mrad');
    set(handles.SetAngleV,'Enable','off');
    set(handles.SetAngleV,'Value',0);
    set(handles.VBPM1, 'Enable', 'On');
    set(handles.VBPM2, 'Enable', 'On');    
    

end

if isempty(BPMnew) || isnan(BPMnew) || ~isreal(BPMnew)
    set(handles.BottomText, 'String', 'Upstream Vertical BPM Input Error');
else
    % Clear an old error
    if strcmp(get(handles.BottomText, 'String'), 'Upstream Vertical BPM Input Error')
        set(handles.BottomText, 'String', '');
        VBPM2_Callback(handles.HBPM1, eventdata, handles);
    end

    % Clear an old error
    if BPM1n == BPM2n
        if strcmp(get(handles.BottomText, 'String'), 'Downstream Vertical BPM Input Error')
            set(handles.BottomText, 'String', '');
        end
    end
end


function VBPM2_Callback(hObject, eventdata, handles)
% Get the inputs and strip commas
BPMString = get(handles.VBPM2,'String');
BPMString(find(BPMString==',')) = '.';
BPMnew = sscanf(BPMString,'%f');
BPMString=strcat(num2str(BPMnew),' mm');
set(handles.VBPM2,'String',BPMString);

% Check for 1 BPM
BPM1n = get(handles.VBPM1DevList, 'Value');
BPM2n = get(handles.VBPM2DevList, 'Value');
BPM1v = sscanf(get(handles.VBPM1, 'String'),'%f');
BPM2v = sscanf(get(handles.VBPM2, 'String'),'%f');
NumberBPM = length(get(handles.VBPM1DevList, 'String'));
if BPM1n == BPM2n
    set(handles.VBPM1,'String',get(handles.VBPM2,'String'));
    set(handles.Edt_V_Angle, 'Enable', 'Off');
    set(handles.Edt_V_Angle, 'String', '0.00 mrad');
    set(handles.SetAngleV,'Enable','off');
    set(handles.SetAngleV,'Value',0);
    set(handles.VBPM1, 'Enable', 'On');
    set(handles.VBPM2, 'Enable', 'On');
elseif abs(BPM1n-BPM2n)==1
    set(handles.SetAngleV,'Enable','on');
    BPM_DistanceV=diff(getspos('BPMz',[BPM1n ;BPM2n]));    
    DeltaV=BPM2v-BPM1v;
    AngleV=DeltaV/BPM_DistanceV;
    AngleV=strcat(num2str(AngleV),' mrad')
    set(handles.Edt_V_Angle, 'String',AngleV);
elseif abs(BPM1n-BPM2n)==(NumberBPM-1) % Special case of First and Last BPM
    set(handles.SetAngleV,'Enable','on');
    circumference=getcircumference;
    BPM_DistanceV=diff(getspos('BPMz',[BPM1n ;BPM2n]));
    BPM_DistanceV=(circumference-abs(BPM_DistanceV))*sign(BPM_DistanceV)*-1;
    DeltaV=BPM2v-BPM1v;
    AngleV=DeltaV/BPM_DistanceV;
    AngleV=strcat(num2str(AngleV),' mrad')
    set(handles.Edt_V_Angle, 'String', AngleV);
else   
    set(handles.Edt_V_Angle, 'Enable', 'Off');
    set(handles.Edt_V_Angle, 'String', '0.00 mrad');
    set(handles.SetAngleV,'Enable','off');
    set(handles.SetAngleV,'Value',0);
    set(handles.VBPM1, 'Enable', 'On');
    set(handles.VBPM2, 'Enable', 'On');    

end

if isempty(BPMnew) || isnan(BPMnew) || ~isreal(BPMnew)
    set(handles.BottomText, 'String', 'Downstream Vertical BPM Input Error');
else
    % Clear an old error
    if strcmp(get(handles.BottomText, 'String'), 'Downstream Vertical BPM Input Error')
        set(handles.BottomText, 'String', '');
        VBPM1_Callback(handles.HBPM1, eventdata, handles);
    end

    if BPM1n == BPM2n
        if strcmp(get(handles.BottomText, 'String'), 'Upstream Vertical BPM Input Error')
            set(handles.BottomText, 'String', '');
        end
    end
end


% --- Executes on button press in HRadioButton.
function HRadioButton_Callback(hObject, eventdata, handles)
if get(handles.HRadioButton, 'Value')
    set(handles.HBPM1, 'Enable', 'On');
    set(handles.HBPM2, 'Enable', 'On');
    set(handles.HBPM1DevList, 'Enable', 'On');
    set(handles.HBPM2DevList, 'Enable', 'On');
    set(handles.HCMGroup, 'Enable', 'On');
    set(handles.HText1, 'Enable', 'On');
    set(handles.HText2, 'Enable', 'On');
    set(handles.HText3, 'Enable', 'On');
    if get(handles.SetAngleH, 'Value');
        set(handles.HBPM1, 'Enable', 'Off');
        set(handles.HBPM2, 'Enable', 'Off');
        set(handles.Edt_H_Angle, 'Enable', 'On');
        set(handles.SetAngleH, 'Enable', 'on');
    else
        set(handles.HBPM1, 'Enable', 'On');
        set(handles.HBPM2, 'Enable', 'On');
        set(handles.Edt_H_Angle, 'Enable', 'Off');
        set(handles.SetAngleH, 'Enable', 'off');
    end    
   
else
    set(handles.HBPM1, 'Enable', 'Off');
    set(handles.HBPM2, 'Enable', 'Off');
    set(handles.HBPM1DevList, 'Enable', 'Off');
    set(handles.HBPM2DevList, 'Enable', 'Off');
    set(handles.HCMGroup, 'Enable', 'Off');
    set(handles.HText1, 'Enable', 'Off');
    set(handles.HText2, 'Enable', 'Off');
    set(handles.HText3, 'Enable', 'Off');
    set(handles.SetAngleH, 'Enable', 'off');
    set(handles.Edt_H_Angle, 'Enable', 'Off');
 
end


% --- Executes on button press in VRadioButton.
function VRadioButton_Callback(hObject, eventdata, handles)
if get(handles.VRadioButton, 'Value')
    set(handles.VBPM1, 'Enable', 'On');
    set(handles.VBPM2, 'Enable', 'On');
    set(handles.VBPM1DevList, 'Enable', 'On');
    set(handles.VBPM2DevList, 'Enable', 'On');
    set(handles.VCMGroup, 'Enable', 'On');
    set(handles.VText1, 'Enable', 'On');
    set(handles.VText2, 'Enable', 'On');
    set(handles.VText3, 'Enable', 'On');
    if get(handles.SetAngleV, 'Value');
        set(handles.VBPM1, 'Enable', 'Off');
        set(handles.VBPM2, 'Enable', 'Off');
        set(handles.Edt_V_Angle, 'Enable', 'On');
        set(handles.SetAngleV, 'Enable', 'On');
    else
        set(handles.VBPM1, 'Enable', 'On');
        set(handles.VBPM2, 'Enable', 'On');
        set(handles.Edt_V_Angle, 'Enable', 'Off');
        set(handles.SetAngleV, 'Enable', 'Off');
    end    
    
else
    set(handles.VBPM1, 'Enable', 'Off');
    set(handles.VBPM2, 'Enable', 'Off');
    set(handles.VBPM1DevList, 'Enable', 'Off');
    set(handles.VBPM2DevList, 'Enable', 'Off');
    set(handles.VCMGroup, 'Enable', 'Off');
    set(handles.VText1, 'Enable', 'Off');
    set(handles.VText2, 'Enable', 'Off');
    set(handles.VText3, 'Enable', 'Off');
    set(handles.SetAngleV, 'Enable', 'Off');
    set(handles.Edt_V_Angle, 'Enable', 'Off');
end


%% --- Executes on button press in Apply.
function Apply_Callback(hObject, eventdata, handles)

NIter = get(handles.Iterations,'Value')-1;

i = 0;
if get(handles.HRadioButton, 'Value')
    i = i + 1;

    % Horizontal BPMs
    BPMFamily = gethbpmfamily;
    BPMDeviceList = get(handles.HBPM1DevList, 'UserData');
    BPM1n = get(handles.HBPM1DevList, 'Value');
    BPM2n = get(handles.HBPM2DevList, 'Value');
    if BPM1n == BPM2n
        BPMDevBump = BPMDeviceList(BPM1n,:);
    else
        BPMDevBump = BPMDeviceList([BPM1n BPM2n],:);
    end
    
    BPMnew = sscanf(get(handles.HBPM1,'String'),'%f');
    if isempty(BPMnew) || isnan(BPMnew) || ~isreal(BPMnew)
        set(handles.BottomText, 'String', 'Upstream Horizontal BPM Input Error');
        return;
    else
        GoalOrbit = BPMnew;
    end
    if BPM1n ~= BPM2n
        BPMnew = sscanf(get(handles.HBPM2,'String'),'%f');
        if isempty(BPMnew) || isnan(BPMnew) || ~isreal(BPMnew)
            set(handles.BottomText, 'String', 'Downstream Horizontal BPM Input Error');
            return;
        else
            GoalOrbit = [GoalOrbit; BPMnew];
        end
    end

    % Correct
    CMFamily  = gethcmfamily;
    CMIncrementListCell = get(handles.HCMGroup,'UserData');
    %CMIncrementList = CMIncrementListCell{get(handles.HCMGroup,'value')};
    CMIncrementList = CMIncrementListCell{end};
    if size(CMIncrementList,2) == 1
        CMIncrementList = CMIncrementList';
    end
    
    ReferenceOrbitFlag = get(handles.ReferenceOrbit, 'Value');
    if ReferenceOrbitFlag == 1
        OCSFlags = {'Incremental'};
    elseif ReferenceOrbitFlag == 2
        % Reference at the golden orbit
        GoalOrbit = GoalOrbit + getgolden(BPMFamily, BPMDevBump);
        OCSFlags = {'Absolute'};
    elseif ReferenceOrbitFlag == 3
        % Reference at the offset orbit
        GoalOrbit = GoalOrbit + getoffset(BPMFamily, BPMDevBump);
        OCSFlags = {'Absolute'};
    elseif ReferenceOrbitFlag == 4
        % Absolute change without a reference orbit
        OCSFlags = {'Absolute'};
    end

    % RF Flag
    if get(handles.RF, 'Value')
        OCSFlags = [OCSFlags, {'FitRF'}];
    end


%     % Leakage Correction Flag
%     if get(handles.LeakageCorrection, 'Value')
%         OCSFlags = [OCSFlags, {'LeakageCorrection'}];
%     end

    % Ramping Steps
    RampSteps = get(handles.RampSteps, 'Value');
    OCSFlags = [OCSFlags, {'RampSteps'}, {RampSteps}];


    % Apply the bump
    if size(GoalOrbit,1) == size(BPMDevBump,1) && ~any(isnan(GoalOrbit)) && isreal(GoalOrbit)
        try
            set(handles.BottomText, 'String', 'Applying Local Bump ...')
            drawnow;
            [OCSbuild{i}, OCS0, V, S, ErrorFlag] = setorbitbump(BPMFamily, BPMDevBump, GoalOrbit, CMFamily, CMIncrementList, NIter, 'NoSetPV', OCSFlags{:});
%             if ErrorFlag
%                 set(handles.BottomText, 'String', 'Error Setting Bump!!!');
%             else
%                 set(handles.BottomText, 'String', sprintf('Bump Complete (%s)',datestr(OCS{i}.CM.TimeStamp,14)));
%             end
        catch
            fprintf('\n%s\n', lasterr);
            set(handles.BottomText, 'String', 'Errored Just Thinking About This Bump!');
            return;
        end
    else
        set(handles.BottomText, 'String', 'Goal Orbit Input Error');
        return;
    end
end


if get(handles.VRadioButton, 'Value')
    i = i + 1;

    % Vertical BPMs
    BPMFamily = getvbpmfamily;
    CMFamily  = getvcmfamily;

    BPMDeviceList = get(handles.VBPM1DevList, 'UserData');

    CMIncrementListCell = get(handles.VCMGroup,'UserData');
    %CMIncrementList = CMIncrementListCell{get(handles.VCMGroup,'value')};
    CMIncrementList = CMIncrementListCell{end};
    if size(CMIncrementList,2) == 1
        CMIncrementList = CMIncrementList';
    end
    
    BPM1n = get(handles.VBPM1DevList, 'Value');
    BPM2n = get(handles.VBPM2DevList, 'Value');
    if BPM1n == BPM2n
        BPMDevBump = BPMDeviceList(BPM1n,:);
    else
        BPMDevBump = BPMDeviceList([BPM1n BPM2n],:);
    end
    BPMnew = sscanf(get(handles.VBPM1,'String'),'%f');
    if isempty(BPMnew) || isnan(BPMnew) || ~isreal(BPMnew)
        set(handles.BottomText, 'String', 'Upstream Vertical BPM Input Error');
        return;
    else
        GoalOrbit = BPMnew;
    end
    if BPM1n ~= BPM2n
        BPMnew = sscanf(get(handles.VBPM2,'String'),'%f');
        if isempty(BPMnew) || isnan(BPMnew) || ~isreal(BPMnew)
            set(handles.BottomText, 'String', 'Downstream Vertical BPM Input Error');
            return;
        else
            GoalOrbit = [GoalOrbit; BPMnew];
        end
    end


    ReferenceOrbitFlag = get(handles.ReferenceOrbit, 'Value');
    if ReferenceOrbitFlag == 1
        OCSFlags = {'Incremental'};
    elseif ReferenceOrbitFlag == 2
        % Reference at the golden orbit
        GoalOrbit = GoalOrbit + getgolden(BPMFamily, BPMDevBump);
        OCSFlags = {'Absolute'};
    elseif ReferenceOrbitFlag == 3
        % Reference at the offset orbit
        GoalOrbit = GoalOrbit + getoffset(BPMFamily, BPMDevBump);
        OCSFlags = {'Absolute'};
    elseif ReferenceOrbitFlag == 4
        % Absolute change without a reference orbit
        OCSFlags = {'Absolute'};
    end

    % RF Flag
    if get(handles.RF, 'Value')
        OCSFlags = [OCSFlags, {'FitRF'}];
    end


%     % Leakage Correction Flag
%     if get(handles.LeakageCorrection, 'Value')
%         OCSFlags = [OCSFlags, {'LeakageCorrection'}];
%     end

    % Ramping Steps
    RampSteps = get(handles.RampSteps, 'Value');
    OCSFlags = [OCSFlags, {'RampSteps'}, {RampSteps}];


    % Apply the bump
    if size(GoalOrbit,1) == size(BPMDevBump,1) && ~any(isnan(GoalOrbit)) && isreal(GoalOrbit)
        try
            [OCSbuild{i}, OCS0, V, S, ErrorFlag] = setorbitbump(BPMFamily, BPMDevBump, GoalOrbit, CMFamily, CMIncrementList, NIter, 'NoSetPV', OCSFlags{:});
            %if ErrorFlag
            %    set(handles.BottomText, 'String', 'Error Setting Bump!!!');
            %else
            %    set(handles.BottomText, 'String', sprintf('Bump Complete (%s)',datestr(OCS{i}.CM.TimeStamp,14)));
            %end
        catch
            fprintf('\n%s\n', lasterr);
            set(handles.BottomText, 'String', 'Errored Just Thinking About This Bump!');
            return;
        end
    else
        set(handles.BottomText, 'String', 'Goal Orbit Input Error');
        return;
    end

end

    
if i==0
    return;
end


OCS = OCSbuild{1};
OCS = rmfield(OCS, 'CM');
OCS = rmfield(OCS, 'BPM');
OCS = rmfield(OCS, 'GoalOrbit');
OCS = rmfield(OCS, 'BPMWeight');
OCS = rmfield(OCS, 'CMWeight');
OCS.SVDIndex = 1e-4; 
for j = 1:i
    OCS.CM{j}        = OCSbuild{j}.CM;
    OCS.BPM{j}       = OCSbuild{j}.BPM;
    OCS.GoalOrbit{j} = OCSbuild{j}.GoalOrbit;
    OCS.BPMWeight{j} = OCSbuild{j}.BPMWeight;
    OCS.CMWeight{j}  = OCSbuild{j}.CMWeight;
end


% Make the setpoint change
set(handles.BottomText, 'String', 'Applying Local Bump ...')
drawnow;
[OCS, OCS0, V, S, ErrorFlag] = setorbit(OCS);

if ErrorFlag
    set(handles.BottomText, 'String', 'Error Setting Bump!');
else
    set(handles.BottomText, 'String', sprintf('Bump Complete (%s)',datestr(clock,14)));
end


if ~ErrorFlag
    OCScell = get(handles.Remove, 'UserData');
    OCScell{length(OCScell)+1} = OCS0;
    set(handles.Remove, 'UserData', OCScell);
    set(handles.Remove, 'Enable', 'On');
    set(handles.Remove, 'String', sprintf('Remove Bump #%d', length(OCScell)));
end



%% --- Executes on button press in Remove.
function Remove_Callback(hObject, eventdata, handles)

OCScell = get(handles.Remove, 'UserData');

% Since power supplies get out of sync, it can be useful
% to set the power supplies in smaller steps.
RampSteps = get(handles.RampSteps, 'Value');

if RampSteps == 1
    % Apply correction in 1 step
    set(handles.BottomText, 'String', sprintf('Removing Bump #%d in %d step', length(OCScell), RampSteps));

    % Correctors
    setpv(OCScell{end}.CM, -1);

    % RF
    if OCScell{end}.FitRF
        setpv(OCScell{end}.RF);
    end
else
    % Apply correction slowly
    set(handles.BottomText, 'String', sprintf('Removing Bump #%d in %d steps', length(OCScell), RampSteps));
    CM  = OCScell{end}.CM;
    CM1 = getpv(OCScell{end}.CM, 'Struct');
    CM2 = OCScell{end}.CM;

    if OCScell{end}.FitRF
        dRF = OCScell{end}.DeltaRF / RampSteps;
    end

    for j = 1:RampSteps
        WaitFlag = -1;

        if OCScell{end}.FitRF
            steprf(dRF, -1, CM{1}.Mode);
        end

        for i = 1:length(CM)
            CM{i}.Data = CM1{i}.Data + (CM2{i}.Data - CM1{i}.Data)*(j/RampSteps);
            setpv(CM{i}, WaitFlag);
        end
    end
end


%set(handles.BottomText, 'String', sprintf('Removed Bump #%d set at %s', length(OCScell), datestr(OCScell{end}.CM.TimeStamp,14)));
set(handles.BottomText, 'String', sprintf('Removed Bump #%d', length(OCScell)));

OCScell(end) = [];
set(handles.Remove, 'UserData', OCScell);

if isempty(OCScell)
    set(handles.Remove, 'String', sprintf('Remove Bump'));
    set(handles.Remove, 'Enable', 'Off');
else
    set(handles.Remove, 'String', sprintf('Remove Bump #%d', length(OCScell)));
end

drawnow;



%% --- Executes on selection change in HBPM1DevList.
function HBPM1DevList_Callback(hObject, eventdata, handles)

HBPM1_Callback(hObject, eventdata, handles);


%% --- Executes on selection change in HBPM2DevList.
function HBPM2DevList_Callback(hObject, eventdata, handles)

HBPM2_Callback(hObject, eventdata, handles);


%% --- Executes on selection change in VBPM1DevList.
function VBPM1DevList_Callback(hObject, eventdata, handles)

VBPM1_Callback(hObject, eventdata, handles);


%% --- Executes on selection change in VBPM2DevList.
function VBPM2DevList_Callback(hObject, eventdata, handles)

VBPM2_Callback(hObject, eventdata, handles);


% --- Executes on button press in RF.
function RF_Callback(hObject, eventdata, handles)


% --- Executes on button press in LeakageCorrection.
function LeakageCorrection_Callback(hObject, eventdata, handles)


% --- Executes on selection change in RampSteps.
function RampSteps_Callback(hObject, eventdata, handles)



% --- Executes on selection change in ReferenceOrbit.
function ReferenceOrbit_Callback(hObject, eventdata, handles)


% --- Executes on selection change in VCMGroup.
function HCMGroup_Callback(hObject, eventdata, handles)
CMIncrementListCell = get(handles.HCMGroup, 'UserData');
i = get(handles.HCMGroup, 'Value');
N = length(CMIncrementListCell);
if i == N
    % Edit the list
    BPMFamily = gethbpmfamily;
    CMFamily = gethcmfamily;
    CMDeviceList = family2dev(CMFamily, 1);
    CMIncrementList = CMIncrementListCell{end};
    
    BPMFamily = gethbpmfamily;
    BPMDeviceList = get(handles.HBPM1DevList, 'UserData');
    BPM1n = get(handles.HBPM1DevList, 'Value');
    BPM2n = get(handles.HBPM2DevList, 'Value');
    if BPM1n == BPM2n
        BPMDeviceList = BPMDeviceList(BPM1n,:);
    else
        BPMDeviceList = BPMDeviceList([BPM1n BPM2n],:);
    end

    BumpDeviceList = inc2dev(BPMFamily, BPMDeviceList, CMFamily, CMIncrementList);
    iCM = findrowindex(BumpDeviceList, CMDeviceList);
    CheckList = zeros(size(CMDeviceList,1),1);
    CheckList(iCM) = 1;

    CMspos1 = getspos(CMFamily, BumpDeviceList);

    BumpDeviceList = editlist(CMDeviceList, CMFamily, CheckList);
    
    % If the bump spanned the last to first sectors, than the order needs to be fixed
    if CMspos1(1) > CMspos1(end)
        L = getcircumference;
        CMspos2 = getspos(CMFamily, BumpDeviceList);
        StartingSectors = [];
        EndingSectors = [];
        for i = 1:size(BumpDeviceList,1)
            if CMspos2(i) < L/2
                StartingSectors = [StartingSectors; BumpDeviceList(i,:);];
            else
                EndingSectors = [EndingSectors; BumpDeviceList(i,:);];
            end
        end
        BumpDeviceList = [EndingSectors; StartingSectors];
    end
    CMIncrementListCell{end} = BumpDeviceList;
else
    % Put the requested list in the active/edit cell
    CMIncrementListCell{end} = CMIncrementListCell{i};
end
set(handles.HCMGroup, 'UserData', CMIncrementListCell);


% --- Executes on selection change in VCMGroup.
function VCMGroup_Callback(hObject, eventdata, handles)
CMIncrementListCell = get(handles.VCMGroup, 'UserData');
i = get(handles.VCMGroup, 'Value');
N = length(CMIncrementListCell);
if i == N
    % Edit the list
    BPMFamily = getvbpmfamily;
    CMFamily  = getvcmfamily;
    CMDeviceList = family2dev(CMFamily, 1);
    CMIncrementList = CMIncrementListCell{end};
    
    BPMFamily = getvbpmfamily;
    BPMDeviceList = get(handles.VBPM1DevList, 'UserData');
    BPM1n = get(handles.VBPM1DevList, 'Value');
    BPM2n = get(handles.VBPM2DevList, 'Value');
    if BPM1n == BPM2n
        BPMDeviceList = BPMDeviceList(BPM1n,:);
    else
        BPMDeviceList = BPMDeviceList([BPM1n BPM2n],:);
    end

    BumpDeviceList = inc2dev(BPMFamily, BPMDeviceList, CMFamily, CMIncrementList);
    iCM = findrowindex(BumpDeviceList, CMDeviceList);
    CheckList = zeros(size(CMDeviceList,1),1);
    CheckList(iCM) = 1;

    BumpDeviceList = editlist(CMDeviceList, CMFamily, CheckList);
    CMIncrementListCell{end} = BumpDeviceList;
else
    % Put the requested list in the active/edit cell
    CMIncrementListCell{end} = CMIncrementListCell{i};
end
set(handles.VCMGroup, 'UserData', CMIncrementListCell);

%CMIncrementListString = get(handles.HCMGroup, 'String');
%CMIncrementListString(end,:) = '   Edit CM List    ';
%set(handles.HCMGroup, 'String', CMIncrementListString);


function DeviceList = inc2dev(BPMFamily, BPMDeviceList, CMFamily, CMIncrementList)

% Check for a device list input
if ~(size(CMIncrementList,2) == 2 && size(CMIncrementList,1) > 1)
    CMIncrementList = CMIncrementList(:);
    CMIncrementList = sort(CMIncrementList);
    CMIncrementList(find(CMIncrementList==0)) = [];
    CMIncrementList(find(diff(CMIncrementList)==0)) = [];
end

% Get BPM positions 
BPMListTotal = family2dev(BPMFamily, 1);
BPMsposTotal = getspos(BPMFamily, BPMListTotal);
BPMspos      = getspos(BPMFamily, BPMDeviceList);


% Stack 3 rings so you you don't have to worry about the L to 0 transition 
L = getfamilydata('Circumference');
CMListTotal = family2dev(CMFamily, 1);
CMsposTotal = getspos(CMFamily, CMListTotal);
CMListTotal = [CMListTotal;   CMListTotal; CMListTotal];
CMsposTotal = [CMsposTotal-L; CMsposTotal; CMsposTotal+L];


% Find the correctors
% Check for a device list input
if size(CMIncrementList,2) == 2 && size(CMIncrementList,1) > 1
    % DeviceList
    DeviceList = CMIncrementList;
else
    for i = 1:length(CMIncrementList)
        if CMIncrementList(i) <= 0
            j = find(CMsposTotal <= BPMspos(1));
            DeviceList(i,:) = CMListTotal(j(end)+CMIncrementList(i)+1,:);
        else
            j = find(CMsposTotal >= BPMspos(end));
            DeviceList(i,:) = CMListTotal(j(1)+CMIncrementList(i)-1,:);
        end
    end
end


% --- Executes on button press in SetAngleH.
function SetAngleH_Callback(hObject, eventdata, handles)
% hObject    handle to SetAngleH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'value')
    set(handles.Edt_H_Angle,'Enable','on');
    set(handles.HBPM1,'Enable','off');
    set(handles.HBPM2,'Enable','off');
    
else
    set(handles.Edt_H_Angle,'Enable','off');
    set(handles.HBPM1,'Enable','on');
    set(handles.HBPM2,'Enable','on');
end
% Hint: get(hObject,'Value') returns toggle state of SetAngleH


% --- Executes on button press in SetAngleV.
function SetAngleV_Callback(hObject, eventdata, handles)
% hObject    handle to SetAngleV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'value')
    set(handles.Edt_V_Angle,'Enable','on');
    set(handles.VBPM1,'Enable','off');
    set(handles.VBPM2,'Enable','off');
    
else
    set(handles.Edt_V_Angle,'Enable','off');
    set(handles.VBPM1,'Enable','on');
    set(handles.VBPM2,'Enable','on');
end
% Hint: get(hObject,'Value') returns toggle state of SetAngleV



function Edt_H_Angle_Callback(hObject, eventdata, handles)
% hObject    handle to Edt_H_Angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AngleH = sscanf(get(hObject,'String'),'%f');
AngleHStr = strcat(num2str(AngleH),' mrad');
set(handles.Edt_H_Angle, 'String', AngleHStr);
BPM1n = get(handles.HBPM1DevList, 'Value');
BPM2n = get(handles.HBPM2DevList, 'Value');
if abs(BPM1n-BPM2n)==121   
    circumference=getcircumference;
    BPM_DistanceH=diff(getspos('BPMx',[BPM1n ;BPM2n]));
    BPM_DistanceH=(circumference-abs(BPM_DistanceH))*sign(BPM_DistanceH)*-1;
else    
    BPM_DistanceH=diff(getspos('BPMx',[BPM1n ;BPM2n]));
end    
DeltaH=AngleH*BPM_DistanceH;
if sign(AngleH)
    set(handles.HBPM1, 'String',strcat(num2str(-DeltaH/2),' mm'));
    set(handles.HBPM2, 'String',strcat(num2str(DeltaH/2),' mm'));
else
    set(handles.HBPM1, 'String',strcat(num2str(DeltaH/2),' mm'));
    set(handles.HBPM2, 'String',strcat(num2str(-DeltaH/2),' mm'));    
end    

% Hints: get(hObject,'String') returns contents of Edt_H_Angle as text
%        str2double(get(hObject,'String')) returns contents of Edt_H_Angle as a double






function Edt_V_Angle_Callback(hObject, eventdata, handles)
% hObject    handle to Edt_V_Angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AngleV = str2num(get(hObject,'String'));
AngleVStr = strcat(num2str(AngleV),' mrad');
set(handles.Edt_V_Angle, 'String', AngleVStr);
BPM1n = get(handles.VBPM1DevList, 'Value');
BPM2n = get(handles.VBPM2DevList, 'Value');
if abs(BPM1n-BPM2n)==121   
    circumference=getcircumference;
    BPM_DistanceV=diff(getspos('BPMz',[BPM1n ;BPM2n]));
    BPM_DistanceV=(circumference-abs(BPM_DistanceV))*sign(BPM_DistanceV)*-1;
else    
    BPM_DistanceV=diff(getspos('BPMz',[BPM1n ;BPM2n]));
end    
DeltaV=AngleV*BPM_DistanceV;
if sign(AngleV)
    set(handles.VBPM1, 'String',strcat(num2str(-DeltaV/2),' mm'));
    set(handles.VBPM2, 'String',strcat(num2str(DeltaV/2),' mm'));
else
    set(handles.VBPM1, 'String',strcat(num2str(DeltaV/2),' mm'));
    set(handles.VBPM2, 'String',strcat(num2str(-DeltaV/2),' mm'));    
end    
% Hints: get(hObject,'String') returns contents of Edt_V_Angle as text
%        str2double(get(hObject,'String')) returns contents of Edt_V_Angle as a double


% --- Executes during object creation, after setting all properties.
function Edt_H_Angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edt_H_Angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Edt_V_Angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edt_V_Angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on Edt_H_Angle and none of its controls.
function Edt_H_Angle_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Edt_H_Angle (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on Edt_V_Angle and none of its controls.
function Edt_V_Angle_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Edt_V_Angle (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in Iterations.
function Iterations_Callback(hObject, eventdata, handles)
% hObject    handle to Iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Iterations contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Iterations
