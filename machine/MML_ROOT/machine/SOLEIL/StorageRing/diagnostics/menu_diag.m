function varargout = menu_diag(varargin)
% MENU_DIAG M-file for menu_diag.fig
%      MENU_DIAG, by itself, creates a new MENU_DIAG or raises the existing
%      singleton*.
%
%      H = MENU_DIAG returns the handle to a new MENU_DIAG or the handle to
%      the existing singleton*.
%
%      MENU_DIAG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MENU_DIAG.M with the given input arguments.
%
%      MENU_DIAG('Property','Value',...) creates a new MENU_DIAG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before menu_diag_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to menu_diag_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help menu_diag

% Last Modified by GUIDE v2.5 21-Sep-2017 16:39:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @menu_diag_OpeningFcn, ...
                   'gui_OutputFcn',  @menu_diag_OutputFcn, ...
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


% --- Executes just before menu_diag is made visible.
function menu_diag_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to menu_diag (see VARARGIN)

% Choose default command line output for menu_diag
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes menu_diag wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = menu_diag_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in sniffer_classique.
function sniffer_classique_Callback(hObject, eventdata, handles)
% hObject    handle to sniffer_classique (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sniffer_interface

% --- Executes on button press in Config_FOFB.
function Config_FOFB_Callback(hObject, eventdata, handles)
% hObject    handle to Config_FOFB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Config_FOFB

% --- Executes on button press in BPMs_GUI.
function BPMs_GUI_Callback(hObject, eventdata, handles)
% hObject    handle to BPMs_GUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Config_Dserver_BPM;

% --- Executes on button press in Check_Libera_Config.
function Check_Libera_Config_Callback(hObject, eventdata, handles)
% hObject    handle to Check_Libera_Config (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Check_Libera_config;

% --- Executes on button press in sniffer_archiver.
function sniffer_archiver_Callback(hObject, eventdata, handles)
% hObject    handle to sniffer_archiver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fa_zoomer;

% --- Executes on button press in spectres.
function spectres_Callback(hObject, eventdata, handles)
% hObject    handle to spectres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Comparaison_enregistrements;

% --- Executes on button press in update_IP_list.
function update_IP_list_Callback(hObject, eventdata, handles)
% hObject    handle to update_IP_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
update_listes_IP_libera;


% --- Executes on button press in lifetime.
function lifetime_Callback(hObject, eventdata, handles)
% hObject    handle to lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Lifetime_with_Liberas;


% --- Executes on button press in localisation_bruit.
function localisation_bruit_Callback(hObject, eventdata, handles)
% hObject    handle to localisation_bruit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Noise_source_GUI_v3;


% --- Executes on button press in sofb_xbpm.
function sofb_xbpm_Callback(hObject, eventdata, handles)
% hObject    handle to sofb_xbpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SOFB_XBPM_initalization_script;



% --- Executes on button press in calibration_xbpm.
function calibration_xbpm_Callback(hObject, eventdata, handles)
% hObject    handle to calibration_xbpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Check that operator is ready
choice          =   questdlg('Is the machine "HOT" (i.e. since more than an hour at I > 450 mA) ?', ...
 'XBPM calibration', ...
 'YES','NO','NO');
    % Handle response
switch choice
    case 'YES'
        disp([choice ' ->> Move to next...  '])
        choice_opt  = 1;  
    case 'NO'
        disp([choice ' ->> Abort.  '])
        choice_opt  = 2;
       return
end

choice          =   questdlg('Are the XBPMs "HOTs" (i.e. IDs of XBPMs of interest closed at gap min since more than 1/2 h at I > 450 mA) ?', ...
 'XBPM calibration', ...
 'YES','NO','NO');
    % Handle response
switch choice
    case 'YES'
        disp([choice ' ->> Move to next...  '])
        choice_opt  = 1;  
    case 'NO'
        disp([choice ' ->> Abort.  '])
        choice_opt  = 2;
       return
end

xbpm_calibration_GUI;


% --- Executes on button press in display_tables.
function display_tables_Callback(hObject, eventdata, handles)
% hObject    handle to display_tables (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xbpm_display_tables_GUI;


% --- Executes on button press in display_correction.
function display_correction_Callback(hObject, eventdata, handles)
% hObject    handle to display_correction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xbpm_display_correction;
