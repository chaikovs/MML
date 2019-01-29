function varargout = operationgui(varargin)
% OPERATIONGUI M-file for operationgui.fig
%      OPERATIONGUI, by itself, creates a new OPERATIONGUI or raises the existing
%      singleton*.
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

% Last Modified by GUIDE v2.5 14-Nov-2016 08:28:40

% Begin initialization code - DO NOT EDIT
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

% --- Executes on button press in pushbutton_measdisp.
function pushbutton_measdisp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_measdisp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
measdisp('Physics');

% --- Executes on button press in pushbutton_pointsource.
function pushbutton_pointsource_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_pointsource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Variation_points_source;

% --- Executes on button press in pushbutton_SOFB.
function pushbutton_SOFB_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SOFB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
orbitcontrol;

% --- Executes on button press in pushbutton_FOFB.
function pushbutton_FOFB_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FOFB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%setoperationalmode(29); cd(getenv('HOME'))
FOFBguiTango;

% --- Executes on button press in pushbutton_FBNU.
function pushbutton_FBNU_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FBNU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tuneFBgui;

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
setchro('Physics');

% --- Executes on button press in pushbuttonstepchro.
function pushbuttonstepchro_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonstepchro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stepchro('Physics');

% --- Executes on button press in pushbutton_measchro.
function pushbutton_measchro_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_measchro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
measchro('Physics');

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
steptune;

% --- Executes on button press in pushbutton_measchroFBT.
function pushbutton_measchroFBT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_measchroFBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
measchroFBT('Physics');

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
settune('FBT');

% --- Executes on button press in pushbutton_steptuneFBT.
function pushbutton_steptuneFBT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_steptuneFBT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
steptune;

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
gettuneFBT


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


% --- Executes on button press in pushbutton_FBcoupling_oldversion.
function pushbutton_FBcoupling_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FBcoupling_oldversion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% h = waitbar(0,'Please wait...');
% steps = 3;
% for step = 1:steps
%     pause(1) ; % pause 1 seconde
%     waitbar(step / steps)
% end
% close(h)
couplingFBgui

% --- Executes on button press in pushbutton_CheckQTwave.
function pushbutton_CheckQTwave_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_CheckQTwave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkQTwave


% --- Executes on button press in pushbutton_couplage_enreg.
function pushbutton_couplage_enreg_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_couplage_enreg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
getpinhole('Archive')   


% --- Executes on button press in pushbutton_dispersionPHC.
function pushbutton_dispersionPHC_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dispersionPHC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
measdisp4phc


% --- Executes on button press in pushbutton_FBcoupling_size.
function pushbutton_FBcoupling_size_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FBcoupling_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tango_write_attribute2('ANS/FC/PUB-SLICING','isSlicing',uint8(1))
h = waitbar(0,'Please wait...');
steps = 3;
for step = 1:steps
    pause(1) ; % pause 1 seconde
    waitbar(step / steps)
end
close(h)
ButtonName = questdlg('Sur quelle PHC voulez vous lancer le feedback de couplage?', 'PHC ?', 'PHC1 (C02)', 'PHC3 (C16)','PHC1 (C02)');
   switch ButtonName,
     case 'PHC1 (C02)',
      couplingFBgui
     case 'PHC3 (C16)',
      couplingFBgui_PHC3
   end % switch    



% --- Executes on button press in pushbutton_SOFB_XBPM.
function pushbutton_SOFB_XBPM_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SOFB_XBPM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setoperationalmode(49);
%% cd /home/operateur/GrpDiagnostics/matlab/XBPM/XBPM_SOFB/orbitcontrol_v2/
cd /home/production/matlab/DG/XBPM_SOFB/orbitcontrol_v2
orbitcontrol


% --- Executes on button press in pushbutton_FOFB_XBPM.
function pushbutton_FOFB_XBPM_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FOFB_XBPM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setoperationalmode(49);
%cd /home/operateur/GrpDiagnostics/matlab/XBPM/XBPM_SOFB/orbitcontrol_v2/
cd /home/production/matlab/DG/XBPM_SOFB/orbitcontrol_v2/
FOFBguiTango


% --- Executes on button press in pushbutton_panneauExpert.
function pushbutton_panneauExpert_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_panneauExpert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
srsetup


% --- Executes on button press in pushbutton_ATKpanel_PHC.
function pushbutton_ATKpanel_PHC_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ATKpanel_PHC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
system('atkpanel ANS-C02/DG/PHC-EMIT &')
system('atkpanel ANS-C04/DG/PHC-EMIT &')
system('atkpanel ANS-C16/DG/PHC-EMIT &')


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_save_BPMgolden_Callback(hObject, eventdata, handles)
% hObject    handle to menu_save_BPMgolden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
saveorbit2goldenfile


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_plot_print_BPMgolden_Callback(hObject, eventdata, handles)
% hObject    handle to menu_plot_print_BPMgolden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plotgoldenorbit('Print', 'File')


% --------------------------------------------------------------------
function menu_plot_BPMgolden_Callback(hObject, eventdata, handles)
% hObject    handle to menu_plot_BPMgolden (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plotgoldenorbit('File')


% --------------------------------------------------------------------
function menu_Read_HistoryOfChanges_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Read_HistoryOfChanges (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edit ([getfamilydata('Directory', 'BPMGolden'),'HistoryOfChanges.txt'])


% --- Executes on button press in check_metrosdl13.
function check_metrosdl13_Callback(hObject, eventdata, handles)
% hObject    handle to check_metrosdl13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
check_sdl13


% --- Executes on button press in pushbutton_ptsources.
function pushbutton_ptsources_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ptsources (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
getatxnanosourcepoint

% --- Executes on button press in pushbutton_diag.
function pushbutton_diag_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_diag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menu_diag


% --- Executes on button press in pushbutton_chicaneTEMPO.
function pushbutton_chicaneTEMPO_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_chicaneTEMPO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% TEMPOchicane_gui  % commenté le 5-12-2016 par MAT
TEMPOchicane_guiv2
