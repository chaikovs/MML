function varargout = PSB_tempogui(varargin)
% PSB_TEMPOGUI M-file for PSB_tempogui.fig
%      PSB_TEMPOGUI, by itself, creates a new PSB_TEMPOGUI or raises the existing
%      singleton*.
%
%      H = PSB_TEMPOGUI returns the handle to a new PSB_TEMPOGUI or the handle to
%      the existing singleton*.
%
%      PSB_TEMPOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PSB_TEMPOGUI.M with the given input arguments.
%
%      PSB_TEMPOGUI('Property','Value',...) creates a new PSB_TEMPOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PSB_tempogui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PSB_tempogui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PSB_tempogui

% Last Modified by GUIDE v2.5 13-Dec-2010 11:49:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PSB_tempogui_OpeningFcn, ...
                   'gui_OutputFcn',  @PSB_tempogui_OutputFcn, ...
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


% --- Executes just before PSB_tempogui is made visible.
function PSB_tempogui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PSB_tempogui (see VARARGIN)

% Choose default command line output for PSB_tempogui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PSB_tempogui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
lat_2020_3170_pseudo1
updateatindex;
handles.ATIndexList = atindex;
handles.thetax = 0;
handles.thetaz = 0;
handles.Turns = 1;

[betax betaz]   = modelbeta('all');
[alphax alphaz] = modeltwiss('alpha', 'all');

handles.alphaT = alphax(handles.ATIndexList.TEMPO);
handles.betaT = betax(handles.ATIndexList.TEMPO);
handles.gammaT=(1+handles.alphaT*handles.alphaT)/handles.betaT;

handles.HCOR = getsp('HCOR', 'Model');

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = PSB_tempogui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_KEMV_Callback(hObject, eventdata, handles)
% hObject    handle to edit_KEMV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_KEMV as text
%        str2double(get(hObject,'String')) returns contents of edit_KEMV as a double
handles.thetaz = str2double(get(hObject,'String'))*1e-6; % rad
% Update handles structure
guidata(hObject, handles);
pushbutton_plot_Callback(handles.pushbutton_plot, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit_KEMV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_KEMV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_KEMH_Callback(hObject, eventdata, handles)
% hObject    handle to edit_KEMH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_KEMH as text
%        str2double(get(hObject,'String')) returns contents of edit_KEMH as a double

handles.thetax = str2double(get(hObject,'String'))*1e-6; % rad
% Update handles structure
guidata(hObject, handles);
pushbutton_plot_Callback(handles.pushbutton_plot, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit_KEMH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_KEMH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_init.
function pushbutton_init_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_init (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lat_2020_3170_pseudo1


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global THERING
handles.Turns = get(handles.popupmenu_Nturn ,'Value');
L = 13.4165; %m Position for point source on diaphragme

if strcmp(get(get(handles.uipanel_plane, 'SelectedObject'), 'Tag'), 'radiobutton_Hplane')
    hplane = 1;
else
    hplane = 0;
end

if hplane % if KEMH
    % construct Line for transport from KEMH to end of the ring
    REFPTS= (handles.ATIndexList.KEMH:length(THERING));
    LINE = THERING(REFPTS);
    % transport
    Rin = [0; handles.thetax; 0; 0; 0; 0];
    Rout = linepass(LINE,Rin,1:(length(LINE)+1));
    % now make n turns
    [x, ATIndex, LostBeam] = getturns(Rout(:,end), handles.Turns, 'All');
    % construct turn 1
    htour1 =  [zeros(6,handles.ATIndexList.KEMH-1), Rout(:,:)]*1e3;
    % purpose ?
    vtour0 =  [zeros(6,handles.ATIndexList.KEMH-1), Rout(:,:)]*1e3;
    vtour1(:,:) =  x(:,1,:)*1e3;vtour1 = vtour1';
    z = x;
else % KEMV activated
    Rin = [0;0;0;handles.thetaz;0; 0];
    LINE = THERING(handles.ATIndexList.KEMV:end);
    % transport the beam from KEMV to end of RING
    Rout = LINEPASS(LINE,Rin,1:(length(LINE)+1));
    % now make n turn by transporting the beam
    [z, ATIndex, LostBeam] = getturns(Rout(:,end), handles.Turns, 'All');
    vtour0 =  [zeros(6,handles.ATIndexList.KEMV-1), Rout(:,:)]*1e3;
    vtour1(:,:) =  z(:,1,:)*1e3;vtour1 = vtour1';
    htour1(:,:) =  z(:,1,:)*1e3;htour1 = htour1';
    x = z;
end

%select low axes
axes(handles.axes1);cla;

% get position for all points
spos = findspos(THERING, 1:(length(THERING)+1));
sposBPM = getspos('BPMx');

if hplane
    plot(spos, htour1(1,:),'b-'); hold on
    % SOURCE POINT
    xTEMPO = htour1(1,handles.ATIndexList.TEMPO);
    xpTEMPO = htour1(2,handles.ATIndexList.TEMPO);
    LxTEMPO = xTEMPO+L*xpTEMPO; % at L meters
else
    plot(spos, vtour0(1,:),'b-'); hold on
end
slegend={'#1'};
if handles.Turns > 1
    plot(spos, x(:,1,1)*1e3,'r');
    xTEMPO  = x(handles.ATIndexList.TEMPO,handles.Turns-1, 1)*1e3;
    xpTEMPO = x(handles.ATIndexList.TEMPO,handles.Turns-1, 2)*1e3;
    LxTEMPO  = xTEMPO+L*xpTEMPO; 
    slegend=[slegend, {'#2'}];
    if handles.Turns > 2
        plot(spos, x(:,2,1)*1e3,'g');
        slegend=[slegend, {'#3'}];
        if handles.Turns > 3
            plot(spos, x(:,3,1)*1e3,'c');
            slegend=[slegend, {'#4'}];
            if handles.Turns > 4
                plot(spos, x(:,4,1)*1e3,'k');
                slegend=[slegend, {'#5'}];
            end
        end
    end
end
legend(slegend)
% Replot BPM position for turn 1
plot(sposBPM, htour1(1,family2atindex('BPMx')),'b.'); 

% plot positions of kickers
plot(spos(handles.ATIndexList.KEMH), 0, 'ks'); hold on;
plot(spos(handles.ATIndexList.KEMV), 0, 'rs');

xlabel('s-position (m)')
ylabel('x-position (mm)')
xlim([0 getcircumference])
% Show position of point TEMPO source
plot(repmat(findspos(THERING, handles.ATIndexList.TEMPO), 2,1), ...
    1.1*[-1 1]*max(x(:,1,1)*1e3),'k');

% compute position at BPM and point sources
%BPMspos = getspos('BPMx', [8 1; 8 2]);
%diff(BPMspos)
%xTempo = x(:,1,1);

% Position first time the beam cross TEMPO BL
fprintf('Turn %d Center SDM08 x = %.3f mm x'' = %.3f mrad  x @ 10m = %.3f mm\n', ...
    handles.Turns, xTEMPO,xpTEMPO, LxTEMPO); 
fprintf('Center SDM08 z = %.3f mm z'' = %.3f mrad z @ 10m = %.3f mm\n',...
    htour1(3,handles.ATIndexList.TEMPO),htour1(4,handles.ATIndexList.TEMPO), ... 
    htour1(3,handles.ATIndexList.TEMPO)+L*htour1(4,handles.ATIndexList.TEMPO)); 

%ylim([-2 2])

% second axis
axes(handles.axes2);cla;
plot(spos, vtour0(3,:)); hold on
if handles.Turns > 1
    plot(spos, z(:,1,3)*1e3,'r');
    if handles.Turns > 2
        plot(spos, z(:,2,3)*1e3,'g');
        if handles.Turns > 3
            plot(spos, z(:,3,3)*1e3,'c');
            if handles.Turns > 4
                plot(spos, z(:,4,3)*1e3,'k');
            end
        end
    end
end

% Compute position at BPM and poitn source first time the beam cross TEMPO
fprintf('Center SDM08 x = %.3f mm x'' = %.3f mrad\n  x @ 10m = %.3f mm\n', ...
    htour1(1,handles.ATIndexList.TEMPO),htour1(2,handles.ATIndexList.TEMPO), ...
    htour1(1,handles.ATIndexList.TEMPO)+L*htour1(2,handles.ATIndexList.TEMPO)); 
set(handles.text_xTEMPO10m, 'String',...
    num2str(LxTEMPO));

fprintf('Center SDM08 z = %.3f mm z'' = %.3f mrad\n z @ 10m = %.3f mm\n',...
    htour1(3,handles.ATIndexList.TEMPO),htour1(4,handles.ATIndexList.TEMPO), ... 
    htour1(3,handles.ATIndexList.TEMPO)+L*htour1(4,handles.ATIndexList.TEMPO)); 
legend(slegend)
xlabel('s-position (m)')
ylabel('z-position (mm)')
xlim([0 getcircumference])
% plot if 2 turn at least
if size(z,2) > 1
    plot(repmat(findspos(THERING, handles.ATIndexList.TEMPO), 2,1), ...
    1.1*[-1 1]*max(z(:,2,3)*1e3),'k');
end
%ylim([-2 2])

BPMid = dev2elem('BPMx', [8 1; 8 2]);

set(handles.text_BPM8_1_hposition,'String',num2str(htour1(1,handles.ATIndexList.BPM(BPMid(1)))))
set(handles.text_BPM8_1_vposition,'String',num2str(vtour1(3,handles.ATIndexList.BPM(BPMid(1)))))
set(handles.text_BPM8_2_hposition,'String',num2str(htour1(1,handles.ATIndexList.BPM(BPMid(2)))))
set(handles.text_BPM8_2_vposition,'String',num2str(vtour1(3,handles.ATIndexList.BPM(BPMid(2)))))

set(handles.text_BPM8_1_hangle,'String',num2str(htour1(2,handles.ATIndexList.BPM(BPMid(1)))))
set(handles.text_BPM8_1_vangle,'String',num2str(vtour1(4,handles.ATIndexList.BPM(BPMid(1)))))
set(handles.text_BPM8_2_hangle,'String',num2str(htour1(2,handles.ATIndexList.BPM(BPMid(2)))))
set(handles.text_BPM8_2_vangle,'String',num2str(vtour1(4,handles.ATIndexList.BPM(BPMid(2)))))

% Source point
set(handles.text_TEMPO_hposition,'String',num2str(htour1(1,handles.ATIndexList.TEMPO)))
set(handles.text_TEMPO_vposition,'String',num2str(vtour1(3,handles.ATIndexList.TEMPO)))
set(handles.text_TEMPO_hangle,'String',num2str(htour1(2,handles.ATIndexList.TEMPO)))
set(handles.text_TEMPO_vangle,'String',num2str(vtour1(4,handles.ATIndexList.TEMPO)))

% Invariant
x  = htour1(1,handles.ATIndexList.TEMPO) *1e-3;
xp = htour1(2,handles.ATIndexList.TEMPO) *1e-3;
A = handles.gammaT*x*x+2*handles.alphaT*x*xp+handles.betaT*xp*xp;
set(handles.text_TEMPO_xmax,'String',num2str(sqrt(A/handles.gammaT)*1e3));

% --- Executes on selection change in popupmenu_Nturn.
function popupmenu_Nturn_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_Nturn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu_Nturn contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_Nturn
pushbutton_plot_Callback(handles.pushbutton_plot, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popupmenu_Nturn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_Nturn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_zoom1.
function radiobutton_zoom1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_zoom1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_zoom1
if get(hObject,'Value')
    dragzoom(handles.axes1)
else
    dragzoom(handles.axes1)
end

% --- Executes on button press in radiobutton_zoom2.
function radiobutton_zoom2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_zoom2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_zoom2

if get(hObject,'Value')
    dragzoom(handles.axes2)
else
    dragzoom(handles.axes2)
end


% --- Executes on button press in pushbutton_SaveHCOR.
function pushbutton_SaveHCOR_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SaveHCOR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.HCOR = getsp('HCOR', 'Model');

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in pushbutton_Restore.
function pushbutton_Restore_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Restore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setsp('HCOR', handles.HCOR, 'Model');
pushbutton_plot_Callback(handles.pushbutton_plot, eventdata, handles)

function edit_angle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_angle as text
%        str2double(get(hObject,'String')) returns contents of edit_angle as a double
angle = str2double(get(hObject,'String'));

% 2 BPMs for TEMPO BL
BPMspos = getspos('BPMx', [8 1; 8 2]);

setorbitbump('BPMx', [8 1; 8 2], [0 diff(BPMspos)*angle],'HCOR', [-2 -1 1 2], 'Model')
pushbutton_plot_Callback(handles.pushbutton_plot, eventdata, handles)
