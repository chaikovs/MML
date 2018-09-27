function varargout = naffgui(varargin)
% NAFFGUI M-file for naffgui.fig
%      NAFFGUI, by itself, creates a new NAFFGUI or raises the existing
%      singleton*.
%
%      H = NAFFGUI returns the handle to a new NAFFGUI or the handle to
%      the existing singleton*.
%
%      NAFFGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NAFFGUI.M with the given input arguments.
%
%      NAFFGUI('Property','Value',...) creates a new NAFFGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before naffgui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to naffgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help naffgui

% Last Modified by GUIDE v2.5 23-Sep-2015 11:52:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @naffgui_OpeningFcn, ...
                   'gui_OutputFcn',  @naffgui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before naffgui is made visible.
function naffgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to naffgui (see VARARGIN)

% Choose default command line output for naffgui
handles.output = hObject;
handles.a = 3;
handles.b = 1;
handles.c = 65;
handles.periodicity = 4;
handles.order = 4;
handles.fen=[18 19 10 11];

reson(handles.order,handles.periodicity,handles.fen);
set(handles.periodicityvalue,'String',num2str(handles.periodicity));
set(handles.ordervalue,'String',num2str(handles.order));
set(handles.avalue,'String',num2str(handles.a));
set(handles.bvalue,'String',num2str(handles.b));
set(handles.cvalue,'String',num2str(handles.c));
set(handles.eq1,'String',[num2str(handles.a) ' nux + ' num2str(handles.b) ...
        ' nuz = ' num2str(handles.c)]); 

reson(handles.order,handles.periodicity,handles.fen);
hold on
reson(3,handles.periodicity,handles.fen);
reson(5,handles.periodicity,handles.fen);
reson(7,handles.periodicity,handles.fen);
axis(handles.fen);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes naffgui wait for user response (see UIRESUME)
% uiwait(handles.main);


% --- Outputs from this function are returned to the command line.
function varargout = naffgui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_colsefigure.
function pushbutton_colsefigure_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_colsefigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Ferme toutes les fenetres sauf le gui !
figs=findobj('Type','Figure');
close(figs(figs~=gcbf));

% --- Executes on button press in pushbutton_fmap.
function pushbutton_fmap_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fileName = 'fmapn.out';

if get(handles.checkbox_file_fmap, 'Value') == 1,
    fileName = '';
end

if isempty(fileName) || ~exist(fullfile(pwd,fileName), 'file')  
    % try another name
    fileName = uigetfile('*.out','Select the file for ploting frequency map');
end

var = {};
if  get(handles.checkbox_fmap_loss, 'Value') == 1,
    var = {'Loss'};
end
if  get(handles.checkbox_fmap_sym, 'Value') == 1,
    var = {var{:}, 'FullMap'};
end

tracy_plot_fmap(fileName, var{:});

% ces 2 autres versions permettent de superposer des résultats TRACY en
% couleurs et les mesures on-momentum en noir sur la figure(1000)
% prérequis : fmap.out de TRACY -> fmap_simulation.out
%             fmap.out des mesures -> fmap_mesure.out
%plot_fmap_version_mat_simulation('fmap_simulation.out')
%plot_fmap_version_mat_mesure('fmap_mesure.out')

% --- Executes on button press in pushbutton_tuneshift_amp.
function pushbutton_tuneshift_amp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_tuneshift_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tracy_plotnudx

% --- Executes on button press in pushbutton_nudp.
function pushbutton_nudp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_nudp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tracy_plot_nudp

% --- Executes on button press in pushbutton_chamber.
function pushbutton_chamber_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_chamber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

inputStruct = {};

if get(handles.checkbox_fullChamber, 'Value') == 1
    inputStruct={'Full'};
end

if get(handles.checkbox_tracy3,'Value') == 1
    inputStruct = {inputStruct{:}, 'tracy3'};
end

tracy_chamber(inputStruct{:});
    

% --- Executes on button press in pushbutton_fmapdp.
function pushbutton_fmapdp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fmapdp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fileName = 'fmapdpp.out',
if get(handles.checkbox_file_fmapdp, 'Value') == 1
    fileName = '';
end

if isempty(fileName) || ~exist(fullfile(pwd,fileName), 'file')  
    % try another name
    fileName = uigetfile('*.out','Select the file for ploting frequency map');
end

var = {};
if  get(handles.checkbox_fmap_loss, 'Value') == 1,
    var = {'Loss'};
end
if  get(handles.checkbox_fmap_sym, 'Value') == 1,
    var = {var{:}, 'FullMap'};
end

tracy_plot_fmapdp(fileName, var{:});

% --- Executes during object creation, after setting all properties.
function cvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function cvalue_Callback(hObject, eventdata, handles)
% hObject    handle to cvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cvalue as text
%        str2double(get(hObject,'String')) returns contents of cvalue as a double

val = str2double(get(hObject,'String'));
handles.c = val;
guidata(hObject, handles);
set(handles.eq1,'String',[num2str(handles.a) ' nux + ' num2str(handles.b) ...
        ' nuz = ' num2str(handles.c)]); 
plot_reson(handles.a,handles.b,handles.c,handles.fen)

% --- Executes during object creation, after setting all properties.
function avalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to avalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function avalue_Callback(hObject, eventdata, handles)
% hObject    handle to avalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of avalue as text
%        str2double(get(hObject,'String')) returns contents of avalue as a double
val = str2double(get(hObject,'String'));
handles.a = val;
guidata(hObject, handles);
set(handles.eq1,'String',[num2str(handles.a) ' nux + ' num2str(handles.b) ...
        ' nuz = ' num2str(handles.c)]); 
plot_reson(handles.a,handles.b,handles.c,handles.fen)


% --- Executes during object creation, after setting all properties.
function bvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function bvalue_Callback(hObject, eventdata, handles)
% hObject    handle to bvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bvalue as text
%        str2double(get(hObject,'String')) returns contents of bvalue as a double
val = str2double(get(hObject,'String'));
handles.b = val;
guidata(hObject, handles);
set(handles.eq1,'String',[num2str(handles.a) ' nux + ' num2str(handles.b) ...
        ' nuz = ' num2str(handles.c)]); 
plot_reson(handles.a,handles.b,handles.c,handles.fen)


% --- Executes during object creation, after setting all properties.
function periodicityvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to periodicityvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function periodicityvalue_Callback(hObject, eventdata, handles)
% hObject    handle to periodicityvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of periodicityvalue as text
%        str2double(get(hObject,'String')) returns contents of periodicityvalue as a double
val = str2double(get(hObject,'String'));
handles.periodicity = val;
guidata(hObject, handles);
reson(handles.order,handles.periodicity,handles.fen);


% --- Executes during object creation, after setting all properties.
function ordervalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ordervalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function ordervalue_Callback(hObject, eventdata, handles)
% hObject    handle to ordervalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ordervalue as text
%        str2double(get(hObject,'String')) returns contents of ordervalue as a double
val = str2double(get(hObject,'String'));
handles.order = val;
guidata(hObject, handles);
reson(handles.order,handles.periodicity,handles.fen);


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
reson(handles.order,handles.periodicity,handles.fen);


% --- Executes on button press in pushbutton_cla.
function pushbutton_cla_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla


% --- Executes on button press in pushbutton_reson.
function pushbutton_reson_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resongui

% --- Executes on button press in pushbutton_touschek.
function pushbutton_touschek_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_touschek (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prompt = {...
    'Tracy output filename', ...
    'Tracy linear optics ouput filename',...
    'RMS H-emittance value (nm.rad):', ...
    'RMS bunch length (m):', ...
    'Bunch current (mA):' , ...
    'Coupling value:' , ...
    'Energy value (GeV):',  ...
    'Full Machine (0/1)'};
dlg_title = 'Input for Touscheck lifetime computation';
num_lines = 1;
def = {'momentumacceptance_112981.out','linlat.out', '3.87E-9', ...
    '5.8E-3', '1.4', '1E-2',  '2.739', '1'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

if get(handles.checkbox_pivinski, 'Value') == 1,
    Equation = 'PivinskiVersion';
else
    Equation = 'APDVersion';
end

if ~isempty(answer)
    if strcmp(answer{length(def)}, '1'),
        Type = 'FullMachine';
    else
        Type = 'SuperPeriod';
    end
    
    fprintf('Computing ...');
    [T, Tp, Tn] = tracy_lma_touschek( ...
        answer{1}, answer{2}, ...
        str2double(answer{3}), str2double(answer{4}),...
        str2double(answer{5}), str2double(answer{6}),...
        str2double(answer{7}), ...
        Type, Equation);
    fprintf('Touschek lifetime T=%4.2f h Tp=%4.2f h Tn=%4.2f h\n', T, Tp, Tn);
end

% --- Executes on button press in pushbutton_beta.
function pushbutton_beta_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.checkbox_fullChamber, 'Value') == 1
    tracy_readtwiss('Display', 'linlat.out', 1);
else
    tracy_readtwiss('Display');
end


% --- Executes on button press in pushbutton_dispersion.
function pushbutton_dispersion_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dispersion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tracy_plot_fmapdp6D('fmapdp.out');

% --- Executes on button press in pushbutton_twiss.
function pushbutton_twiss_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_twiss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox_tracy3.
function checkbox_tracy3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_tracy3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_tracy3


% --- Executes on button press in checkbox_fullChamber.
function checkbox_fullChamber_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_fullChamber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_fullChamber


% --- Executes on button press in checkbox_file_fmapdp.
function checkbox_file_fmapdp_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_file_fmapdp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_file_fmapdp


% --- Executes on button press in checkbox_file_fmap.
function checkbox_file_fmap_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_file_fmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_file_fmap


% --- Executes on button press in pushbutton_MA.
function pushbutton_MA_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_MA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


prompt = {...
    'Tracy output filename', ...
    'Tracy linear optics ouput filename',...
    'RMS H-emittance value (nm.rad):', ...
    'RMS bunch length (mm):', ...
    'Bunch current (mA):' , ...
    'Coupling value:' , ...
    'Energy value (GeV):',  ...
    'Full Machine (0/1)'};
dlg_title = 'Input for Touscheck lifetime computation';
num_lines = 1;
def = {'momentumacceptance.out','linlat.out', '3.7E-9', ...
    '6E-3', '1', '1E-2',  '2.739', '1'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

if ~isempty(answer)
    if strcmp(answer{length(def)}, '1'),
        Type = 'FullMachine';
    else
        Type = 'SuperPeriod';
    end
    
    tracy_lma_touschek( ...
        answer{1}, answer{2}, ...
        str2double(answer{3}), str2double(answer{4}),...
        str2double(answer{5}), str2double(answer{6}),...
        str2double(answer{7}), ...
        Type, 'LMAonly');
end


% --- Executes on button press in pushbutton_cod.
function pushbutton_cod_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tracy_plot_cod


% --- Executes on button press in checkbox_fmap_sym.
function checkbox_fmap_sym_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_fmap_sym (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_fmap_sym


% --- Executes on button press in checkbox_fmap_loss.
function checkbox_fmap_loss_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_fmap_loss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_fmap_loss


% --------------------------------------------------------------------
function menu_options_Callback(hObject, eventdata, handles)
% hObject    handle to menu_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_popup_Callback(hObject, eventdata, handles)
% hObject    handle to menu_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a = figure;
b = copyobj(handles.axes1, a);
set(b, 'Position',[0.13 0.11 0.775 0.815]);
set(b, 'ButtonDownFcn','');
set(b, 'XAxisLocation','Bottom');
Axis1 = axis;
xlabel('Horizontal tune')
ylabel('Vertical tune')


% --- Executes on button press in checkbox_pivinski.
function checkbox_pivinski_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_pivinski (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_pivinski
