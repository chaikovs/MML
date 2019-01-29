function varargout = check_sdl13(varargin)
% CHECK_SDL13 M-file for check_sdl13.fig
%      CHECK_SDL13, by itself, creates a new CHECK_SDL13 or raises the existing
%      singleton*.
%
%      H = CHECK_SDL13 returns the handle to a new CHECK_SDL13 or the handle to
%      the existing singleton*.
%
%      CHECK_SDL13('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHECK_SDL13.M with the given input arguments.
%
%      CHECK_SDL13('Property','Value',...) creates a new CHECK_SDL13 or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before check_sdl13_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to check_sdl13_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help check_sdl13

% Last Modified by GUIDE v2.5 05-Sep-2016 08:59:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @check_sdl13_OpeningFcn, ...
                   'gui_OutputFcn',  @check_sdl13_OutputFcn, ...
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

% --- Executes just before check_sdl13 is made visible.
function check_sdl13_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to check_sdl13 (see VARARGIN)

% Choose default command line output for check_sdl13
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);

% UIWAIT makes check_sdl13 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = check_sdl13_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.


% Update handles structure
guidata(handles.figure1, handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Panel ATX XBPM response vs nano gap
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in push_vs_nano_gap.
function push_vs_nano_gap_Callback(hObject, eventdata, handles)
% hObject    handle to push_vs_nano_gap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

measure_atx_diags_vs_gap_nano


% --- Executes on button press in get_reference_data.
function get_reference_data_Callback(hObject, eventdata, handles)
% hObject    handle to get_reference_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
measure_xbpm_response_reference


% --- Executes on button press in plot_XBPM_response_evolution.
function plot_XBPM_response_evolution_Callback(hObject, eventdata, handles)
% hObject    handle to plot_XBPM_response_evolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_XBPM_response_evolution


% --- Executes on button press in push_expert.
function push_expert_Callback(hObject, eventdata, handles)
% hObject    handle to push_expert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
check_sdl13_expert


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
