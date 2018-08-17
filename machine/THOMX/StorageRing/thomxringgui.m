function varargout = thomxringgui(varargin)
% OPERATIONGUI M-file for thomxringgui.fig
%      OPERATIONGUI, by itself, creates a new OPERATIONGUI or raises the existing
%      singleton*.
%
%
%      H = OPERATIONGUI returns the handle to a new OPERATIONGUI or the handle to
%      the existing singleton*.
%
%      OPERATIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPERATIONGUI.M with the given input arguments.
%
%      OPERATIONGUI('Property','Value',...) creates a new OPERATIONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before operationgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to operationgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help operationgui

% Last Modified by GUIDE v2.5 25-Feb-2014 14:59:25

% Begin initialization code - DO NOT EDIT
%
%  Modified by Jianfeng Zhang @ LAL, 01/10/2013
%  See also operationgui.
%  
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @operationgui_OpeningFcn, ...
                   'gui_OutputFcn',  @operationgui_OutputFcn, ...
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


% --- Executes just before operationgui is made visible.
function operationgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to operationgui (see VARARGIN)

% Choose default command line output for operationgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes operationgui wait for user response (see UIRESUME)
% uiwait(handles.FigMenuGui);


% --- Outputs from this function are returned to the command line.
function varargout = operationgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_plotfamily.
function pushbutton_plotfamily_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plotfamily (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plotfamily;

% --- Executes on button press in pushbutton_empty.
function pushbutton_empty_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_empty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% place holder.....

% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Variation_points_source;


% --- Executes on button press in pushbutton_measbeta.
function pushbutton_measbeta_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_measbeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

measbeta;

% --- Executes on button press in pushbutton_meas.
function pushbutton_meas_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_meas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% to be updated for ThomX
measmcf;

% --- Executes on button press in pushbutton_setoperationalmode.
function pushbutton_setoperationalmode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_setoperationalmode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setoperationalmode

% --- Executes on button press in pushbutton_cyclage.
function pushbutton_cyclage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cyclage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ringcycling;

% --- Executes on button press in pushbutton_configgui.
function pushbutton_configgui_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_configgui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
configgui;

% --- Executes on button press in pushbutton_setchrogolden.
function pushbutton_setchrogolden_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_setchrogolden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% need to change back to the online model 'setchro('Physics')' when the ThomX machine is ready
setchro('Physics','Simulator');

% --- Executes on button press in pushbuttonstepchro.
function pushbuttonstepchro_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonstepchro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% Need to change back to the 'online' model in the future for the ThomX...
%pop up a dialog window to input the tune change range
    answer = inputdlg({'Change the horizontal chromaticity by', 'Change the vertical chromaticity by'},'STEPCHRO',1,{'0','0'});
    if isempty(answer)
            return
    end

    DeltaChrom(1,1) = str2num(answer{1});
    DeltaChrom(2,1) = str2num(answer{2}); 
    
    if (abs(DeltaChrom(1,1)) >= 1.0 || abs(DeltaChrom(2,1))>=1.0)
        errordlg('Chromaticity change should be less than 1.0','Chromaticity change error');
        return;
    end
    %InitialChrom = measchro;
    InitialChrom = measchro('Model');  
    FinalChrom = InitialChrom + DeltaChrom;
    
    while (abs(DeltaChrom(1)) > 1e-3 || abs(DeltaChrom(2)) > 1e-3)
        stepchro(DeltaChrom, 'Physics');
        %stepchro('Physics');
        DeltaChrom = FinalChrom-measchro('Model');
        %DeltaChrom = FinalChrom-measchro;
    end




% --- Executes on button press in pushbutton_measchro.
function pushbutton_measchro_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_measchro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% need to change back to  'measchro('Physics','Display')' when the ThomX ring is ready...
%% by Jianfeng Zhang @ LAL, 11/2013
measchro('Simulator','Physics','Display');
%measchro('Physics','Display');

% --- Executes on button press in pushbutton_settunegolden.
function pushbutton_settunegolden_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_settunegolden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
settune;

% --- Executes on button press in pushbutton_steptune.
function pushbutton_steptune_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_steptune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%pop up a dialog window to input the tune change range
    answer = inputdlg({'Change the horizontal tune by', 'Change the vertical tune by'},'STEPTUNE',1,{'0','0'});
    if isempty(answer)
            return
    end
     DeltaTune(1,1) = str2num(answer{1});
    DeltaTune(2,1) = str2num(answer{2});
   
    if (abs(DeltaTune(1,1)) >= 0.1 || abs(DeltaTune(2,1))>=0.1)
        errordlg('Tune change should be less than 0.1','Tune change error');
        return;
    end
        
    InitialTune = gettune;
    FinalTune = InitialTune + DeltaTune;
    
    while (abs(DeltaTune(1)) > 1e-4 || abs(DeltaTune(2)) > 1e-4)
        steptune(DeltaTune);
        DeltaTune = FinalTune-gettune;
    end

    
% --- Executes on button press in pushbutton_measchroFBT.
function pushbutton_measchroFBT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_measchroFBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% to be updated for ThomX
% measchroFBT('Physics')

% --- Executes on button press in pushbutton_stepchroFBT.
function pushbutton_stepchroFBT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_stepchroFBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stepchro('Physics');

% --- Executes on button press in pushbutton_setchroGoldenFBT.
function pushbutton_setchroGoldenFBT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_setchroGoldenFBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setchro('Physics','FBT');

% --- Executes on button press in pushbutton_settuneGoldenFBT.
function pushbutton_settuneGoldenFBT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_settuneGoldenFBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% to be updated for ThomX
% settune('FBT');

% --- Executes on button press in pushbutton_steptuneFBT.
function pushbutton_steptuneFBT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_steptuneFBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% to be updated for ThomX
%steptune;

% --- Executes on button press in pushbutton_getpinhole.
function pushbutton_getpinhole_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_getpinhole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
getpinhole('NoArchive')

% --- Executes on button press in pushbutton_lifetime.
function pushbutton_lifetime_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
measlifetime(30,'Display');

% --- Executes on button press in pushbutton_monbpm.
function pushbutton_monbpm_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_monbpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
monbpm(60);

% --- Executes on button press in pushbutton_BBA.
function pushbutton_BBA_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_BBA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bbacentergui

% --- Executes on button press in pushbutton_checklibera.
function pushbutton_checklibera_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_checklibera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Check_Libera_config

% --- Executes on button press in pushbutton_findrf.
function pushbutton_findrf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_findrf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
findrf;

% --- Executes on button press in pushbutton_firstturn.
function pushbutton_firstturn_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_firstturn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
getbpmsum;


% --- Executes on button press in pushbutton_gettune.
function pushbutton_gettune_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_gettune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gettune

% --- Executes on button press in pushbutton_gettuneFBT.
function pushbutton_gettuneFBT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_gettuneFBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% to be updated for ThomX
%gettuneFBT


% --- Executes on button press in pushbutton_steprf.
function pushbutton_steprf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_steprf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Step_RF_Progressive;


% --- Executes on button press in pushbutton_BeamsizeTunette.
function pushbutton_BeamsizeTunette_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_BeamsizeTunette (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BeamSizeTunette





% --- Executes on button press in pushbutton_measdisp.
function pushbutton_measdisp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_measdisp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

measdisp;
