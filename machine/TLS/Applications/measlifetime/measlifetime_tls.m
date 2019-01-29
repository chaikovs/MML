function varargout = measlifetime_tls(varargin)
% MEASLIFETIME_TLS MATLAB code for measlifetime_tls.fig
%      MEASLIFETIME_TLS, by itself, creates a new MEASLIFETIME_TLS or raises the existing
%      singleton*.
%
%      H = MEASLIFETIME_TLS returns the handle to a new MEASLIFETIME_TLS or the handle to
%      the existing singleton*.
%
%      MEASLIFETIME_TLS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MEASLIFETIME_TLS.M with the given input arguments.
%
%      MEASLIFETIME_TLS('Property','Value',...) creates a new MEASLIFETIME_TLS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before measlifetime_tls_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to measlifetime_tls_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help measlifetime_tls

% Last Modified by GUIDE v2.5 06-Jan-2012 15:37:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @measlifetime_tls_OpeningFcn, ...
                   'gui_OutputFcn',  @measlifetime_tls_OutputFcn, ...
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


% --- Executes just before measlifetime_tls is made visible.
function measlifetime_tls_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to measlifetime_tls (see VARARGIN)

% Choose default command line output for measlifetime_tls
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
mode = getmode('DCCT');
if strcmp(mode,'Simulator')
    [Tau, I0, t, DCCT] = lifetime(1, [], 0, [], handles);
else
    switch2sim;
    [Tau, I0, t, DCCT] = lifetime(1, [], 0, [], handles);
    switch2online;
end


% UIWAIT makes measlifetime_tls wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = measlifetime_tls_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t = str2num(get(handles.Time,'String'));
[Tau, I0, t, DCCT] = lifetime(t, [], 0, [], handles);



function [Tau, I0, t, DCCT] = lifetime(t, DCCT, Tmin, Nmin, handles) 
%MEASLIFETIME - Measures the lifetime using an exponential least squares fit to beam current
%  [Tau, I0, t, DCCT] = measlifetime(t, DCCT)
%  [Tau, I0, t, DCCT] = measlifetime(t)
%  [Tau, I0, t, DCCT] = measlifetime
%
%  INPUTS #1 - t is a vector or positive scalar
%  1. t    = a.  If vector, time [seconds] (vector input)
%            b.  If scalar and t > 0, length of time in seconds to measure current
%                Default sample period is .5 seconds.
%  2. DCCT = current vector [mAmps]
%            if the DCCT vector is empty then this function will
%            get the current using getdcct at the times defined in t
%
%     or
%
%  [Tau, I0, t, DCCT] = measlifetime(DCCT_Drop, Tmax, Tmin, Nmin)
%
%  INPUTS #2 - "t" is negative
%  1. DCCT_Drop - If DCCT_Drop is scalar and DCCT_Drop <= 0, then the beam current will be
%                 monitored until the current is DCCT_Drop.  Default sample period is .5 seconds.
%                 Default:  Monitor the beam current until current drops 60 uA
%                           (At Spear sigma(DCCT) = 0.001 mA)
%  2. Tmax - Maximum time to measure DCCT {Default: inf}
%  3. Tmin - Minimum time to measure DCCT {Default: 0}
%  4. Nmin - Minimum number of unique data points when monitoring DCCT drop {Default: 6}
%  
%     The goal is to measure the current until a current drop of DCCT_Drop is achived.  However, the
%     time that takes will never goes above Tmax.  And if DCCT_Drop is achived then the measurement will
%     continue until Tmin or Nmin points is achieved (but not exceeding Tmax).
%
%
%  OUTPUTS
%  DCCTfit = I0 * exp(-t/Tau); 
%  1. Tau  - Computed lifetime   [hours]
%  2. I0   - Computed            [mAmps]
%  3. DCCT - Beam current vector [mAmps]
%  4. t    - Actual time         [Seconds]
%
%
%  NOTE
%  1. If no output exists, the beam current and fit will be plotted to the screen
%     as well as the residual of the DCCT.
%  2. DCCT is assumed to be in mAmps

%  Written by Greg Portmann


T_Seconds = str2num(get(handles.Step,'String'));     % Default sample period [Seconds]
TmaxDefault = inf;  % Maximum time 
TminDefault = 0;    % Minimum time 
NminDefault = 6;    % Minimum number of data points


% Input parsing
Tmax = [];
if nargin == 0
    MonitorFlag = 2;
    deltaDCCT = 60 * 0.001;
    Tmin = TminDefault;
    Tmax = TmaxDefault;
    Nmin = NminDefault;
    
elseif nargin >= 1
    if all(size(t)==[1 1])
        if t > 0
            MonitorFlag = 1;
            t = 0:T_Seconds:t;
            Tmax = TmaxDefault;
        else
            MonitorFlag = 2;
            deltaDCCT = abs(t);
            if nargin >= 2
                Tmax = DCCT;
            else
                Tmax = [];
            end
        end
        if nargin < 3
            Tmin = [];
        end
        if nargin < 4
            Nmin = [];
        end
        if isempty(Tmax)
            Tmax = TmaxDefault;
        end
        if isempty(Tmin)
            Tmin = TminDefault;
        end
        if isempty(Nmin)
            Nmin = NminDefault;
        end
    else
        % Time vector input
        if nargin < 2
            MonitorFlag = 1;
        else
            MonitorFlag = 0;
        end
    end
end


if MonitorFlag == 1
    
    % Get DCCT data at a fix interval determined by the input vector t
    %disp(['   Monitoring beam current for ', num2str(t(length(t))), ' seconds.']);    
    t0 = gettime;
    for j = 1:length(t)
        T = t(j) - (gettime-t0);
        if T > 0
            pause(T);
        end
        tout(j,1) = gettime - t0;    
        DCCT(j,1) = getdcct;
    end
    
elseif MonitorFlag == 2
    
    % Monitor for a fixed DCCT drop
    %disp(['   Monitoring beam current until current drops by more than ', num2str(deltaDCCT), ' mA.']);    
    j = 1;
    n = 1;
    tout(n,1) = 0;
    DCCT(n,1) = getdcct;
    t0 = gettime;
    t0_Display = 0;
    while ((abs(DCCT(end,1)-DCCT(1,1)) < deltaDCCT) && (DCCT(end,1) > 0.1)) || n < Nmin || (gettime-t0) < Tmin
        j = j+1;
        T = (j-1)*T_Seconds - (gettime-t0);
        if T > 0
            pause(T);
        end
        DCCTnew = getdcct;
        if DCCTnew ~= DCCT(n)
            n = n + 1;
            tout(n,1) = gettime - t0;
            DCCT(n,1) = DCCTnew;
        end
        if gettime-t0 > Tmax
            break;
        end
        if gettime-t0_Display > 10    
            fprintf('   Monitoring DCCT for lifetime measurement (%s)\n', datestr(clock,0));
            t0_Display = gettime;
        end
    end
    t = tout;

end


% Column vectors
DCCT = DCCT(:);
t = t(:);


% Lookfor identical data in DCCT.  Some machine don't update at T_Sample and
% having the same reading twice is probably not so good for the LS fit.
iExtra = find(diff(DCCT)==0);
DCCT(iExtra) = [];
t(iExtra) = [];

if length(DCCT) < 2
    Tau = NaN;
    I0 = NaN;
    fprintf('   Only 1 unique DCCT reading, hence Tau is set to NaN.\n');
    %error('There must be at least 2 unique point to fit a lifetime.');
    return
end
    
    
% LS fit
y = log(DCCT);
X = [ones(size(t)) t];


% yfit = exp(B(1))*exp(B(2)*tfit); 
B = inv(X'*X)*X'*y;     % Least squares fit
I0 = exp(B(1));  
Tau = -1/B(2)/60/60;    % In hours


if isnan(Tau)
    fprintf('   Life time measurement is inaccurate!\n');
end

% if nargout == 0
    %disp(['   Lifetime is ', num2str(Tau),' hours.']);
    
    tfit = linspace(t(1),t(size(t,1)),500);
    tfit = t;
    yfit = exp(B(1))*exp(B(2)*tfit); 
    
%     clf reset
%     subplot(2,1,1)
    axes(handles.axes1);
    cla reset
    plot(t,DCCT,'bs', tfit,yfit,'--r','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','b',...
                'MarkerSize',8);
    set(gca,'xlim',[0 t(length(t))]);
    title(['Beam Current vs Time: Lifetime=', num2str(Tau),' hours.'])
    xlabel('Time [seconds]'); 
    ylabel('Beam Current [mAmps]');
    legend('Measured Beam Current','Least Squares Fit',0);

    axes(handles.axes2);
    cla reset
    data = (abs(yfit-DCCT)./DCCT)*100;
    bar(t,data,0.2,'r');
    set(gca,'xlim',[0 t(length(t))]);
    title('Difference between Model and Measurement');
    xlabel('Time [seconds]'); 
    ylabel('| I_f_i_t - I_m_e_a_s | / I_m_e_a_s [%]');
    
%     addlabel(1,0, datestr(clock,0));
% end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Time_Callback(hObject, eventdata, handles)
% hObject    handle to Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time as text
%        str2double(get(hObject,'String')) returns contents of Time as a double


% --- Executes during object creation, after setting all properties.
function Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Step_Callback(hObject, eventdata, handles)
% hObject    handle to Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Step as text
%        str2double(get(hObject,'String')) returns contents of Step as a double


% --- Executes during object creation, after setting all properties.
function Step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
