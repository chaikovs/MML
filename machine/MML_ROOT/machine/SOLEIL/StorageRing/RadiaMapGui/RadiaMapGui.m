function varargout = RadiaMapGui(varargin)
% RADIAMAPGUI M-file for RadiaMapGui.fig
%      RADIAMAPGUI, by itself, creates a new RADIAMAPGUI or raises the existing
%      singleton*.
%
%      H = RADIAMAPGUI returns the handle to a new RADIAMAPGUI or the handle to
%      the existing singleton*.
%
%      RADIAMAPGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RADIAMAPGUI.M with the given input arguments.
%
%      RADIAMAPGUI('Property','Value',...) creates a new RADIAMAPGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RadiaMapGui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RadiaMapGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RadiaMapGui

% Last Modified by GUIDE v2.5 07-Jan-2011 15:24:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RadiaMapGui_OpeningFcn, ...
                   'gui_OutputFcn',  @RadiaMapGui_OutputFcn, ...
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


% --- Executes just before RadiaMapGui is made visible.
function RadiaMapGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RadiaMapGui (see VARARGIN)

% Choose default command line output for RadiaMapGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RadiaMapGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%set default value for the plot StartLn, plot EndLn, plot data after 
% smooth Ln, Length of the undulator when generate 2D map from 1D map data
handles.EndLn = str2double(get(handles.EndLn,'String'));
handles.StartLn= str2double(get(handles.StartLn,'String'));
handles.plotsmoothLn = str2double(get(handles.plotsmoothLn,'String'));
handles.Length = str2double(get(handles.Length,'String'));

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = RadiaMapGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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



% --- Executes on button press in open2Dmap.
function open2Dmap_Callback(hObject, eventdata, handles)
% hObject    handle to open2Dmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%set the 'smooth finish' display window to its initial value
h = handles.smoothfinish;
set(h,'String','finish smooth ???','Foregroundcolor','y');


% select the file name to read
[FileName,PathName,FilterIndex] = uigetfile('*.dat');
%save the whole path
handles.openfilename = [PathName,FileName];
handles.FileName = FileName;
handles.PathName = PathName;



% get the file name and read the file
[x Bx,Bz,Px,Pz,Lu] = ReadRadiaMap(handles.openfilename);
% save the data the all handles
handles.x = x;
handles.Px = Px;
handles.Pz = Pz;
handles.Lu = Lu;
handles.Bx = Bx;
handles.Bz = Bz;
handles.forder = '2nd';
handles.funit = '[T2m2]';
%pass the file name to all the callbacks
guidata(hObject,handles);



%display the open file name in the display text window
h = handles.displayOpenFile;
set(h,'String',handles.openfilename);

%display the horizontal and vertical points in the display text window
h1 = handles.Hpoints;
set(h1,'String',Px);
h2 = handles.Vpoints;
set(h2,'String',Pz);



% --- Executes on button press in displayOpenFile.
function displayOpenFile_Callback(hObject, eventdata, handles)
% hObject    handle to displayOpenFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of displayOpenFile




function StartLn_Callback(hObject, eventdata, handles)
% hObject    handle to StartLn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartLn as text
%        str2double(get(hObject,'String')) returns contents of StartLn as a double

%get the user input start line number
StartLn = str2double(get(hObject,'String'));
%save the start line number to all handles
handles.StartLn = StartLn;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function StartLn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartLn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EndLn_Callback(hObject, eventdata, handles)
% hObject    handle to EndLn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EndLn as text
%        str2double(get(hObject,'String')) returns contents of EndLn as a double

EndLn = str2double(get(hObject,'String'));

%get the user input end line number
EndLn = str2double(get(hObject,'String'));
%save the end line number to all handles
handles.EndLn = EndLn;
guidata(hObject,handles);




% --- Executes during object creation, after setting all properties.
function EndLn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EndLn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in PlotBxx.
function PlotBxx_Callback(hObject, eventdata, handles)
% hObject    handle to PlotBxx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

PlotRadiaMap_Bxx(handles.StartLn,handles.EndLn,handles.x,handles.Bx,handles.forder,handles.funit);


% --- Executes on button press in PlotBxy.
function PlotBxy_Callback(hObject, eventdata, handles)
% hObject    handle to PlotBxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% plot the radia map Bx versus y
PlotRadiaMap_Bxy(handles.StartLn,handles.EndLn,handles.x,handles.Bx,handles.forder,handles.funit);

% --- Executes on button press in PlotBxxy.
function PlotBxxy_Callback(hObject, eventdata, handles)
% hObject    handle to PlotBxxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% plot the 2D mesh of Bx
 PlotRadiaMap_Bxxy(handles.x,handles.Bx,handles.forder,handles.funit);
 
 
 % --- Executes on button press in PlotByx.
function PlotByx_Callback(hObject, eventdata, handles)
% hObject    handle to PlotByx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

PlotRadiaMap_Byx(handles.StartLn,handles.EndLn,handles.x,handles.Bz,handles.forder,handles.funit);

% --- Executes on button press in PlotByy.
function PlotByy_Callback(hObject, eventdata, handles)
% hObject    handle to PlotByy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% plot the radia map By versus y
PlotRadiaMap_Byy(handles.StartLn,handles.EndLn,handles.x,handles.Bz,handles.forder,handles.funit);

% --- Executes on button press in PlotByxy.
function PlotByxy_Callback(hObject, eventdata, handles)
% hObject    handle to PlotByxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% plot the 2D mesh of By
 PlotRadiaMap_Byxy(handles.x,handles.Bz,handles.forder,handles.funit);


% --- Executes on button press in closefigure.
function closefigure_Callback(hObject, eventdata, handles)
% hObject    handle to closefigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%close all figures except figure: GUI
figs=findobj('Type','Figure');
close(figs(figs~=gcbf));



% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Smooth.
function Smooth_Callback(hObject, eventdata, handles)
% hObject    handle to Smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%smooth the data and save the data with the file extension: interpolation
[sx,sBx,sBz] = SmoothRadiaMap(handles.PathName,handles.FileName,handles.x,handles.Bx,handles.Bz,...
               handles.Px,handles.Pz,handles.Lu,handles.forder,handles.funit);

 handles.sx = sx;
 handles.sBx = sBx;
 handles.sBz = sBz;
 guidata(hObject,handles);
 
%display 'the smooth is finished' in the display text window
h = handles.smoothfinish;
set(h,'String','finish smooth !!!','Foregroundcolor','g');


% --- Executes on button press in plotsmooth.
function plotsmooth_Callback(hObject, eventdata, handles)
% hObject    handle to plotsmooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%get the line number to plot
Ln = handles.plotsmoothLn;
% plot the radia map after smooth
PlotSmoothRadiaMap(Ln,handles.x,handles.Bx,handles.Bz,handles.sx,...
                   handles.sBx,handles.sBz,handles.forder,handles.funit);

% --- Executes on button press in smoothfinish.
function smoothfinish_Callback(hObject, eventdata, handles)
% hObject    handle to smoothfinish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of smoothfinish


% --- Executes on button press in open1Dmap.
function open1Dmap_Callback(hObject, eventdata, handles)
% hObject    handle to open1Dmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% select the file name to read
[FileName,PathName,FilterIndex] = uigetfile('*.dat');
setappdata(hObject,'UserFileName',FileName);
setappdata(hObject,'UserPathName',PathName);

% --- Executes on button press in Gen2Dmap.
function Gen2Dmap_Callback(hObject, eventdata, handles)
% hObject    handle to Gen2Dmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%get the user opened path name and file name
PathName = getappdata(handles.open1Dmap,'UserPathName');
FileName = getappdata(handles.open1Dmap,'UserFileName');
% get the undulator Length
Length = handles.Length; 

GenFieldMap(PathName,FileName,Length);



function Length_Callback(hObject, eventdata, handles)
% hObject    handle to Length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Length as text
%        str2double(get(hObject,'String')) returns contents of Length as a double

        handles.Length = str2double(get(hObject,'String'));
        guidata(hObject,handles); %update the data

      %  setappdata(hObject,'Length',Length);

% --- Executes during object creation, after setting all properties.
function Length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function plotsmoothLn_Callback(hObject, eventdata, handles)
% hObject    handle to plotsmoothLn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of plotsmoothLn as text
%        str2double(get(hObject,'String')) returns contents of plotsmoothLn as a double

     handles.plotsmoothLn = str2double(get(hObject,'String'));
     guidata(hObject,handles);

    % setappdata(hObject,'plotsmoothLn',Ln);
     
% --- Executes during object creation, after setting all properties.
function plotsmoothLn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotsmoothLn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in deleteline.
function deleteline_Callback(hObject, eventdata, handles)
% hObject    handle to deleteline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%get the value of str to delete 'horizontal' or 'vertical' line
str= getappdata(handles.popupmenu1,'str');

% get the value of delete line
deleteLnstr= getappdata(handles.deleteLn,'str');

% plot the radia map after smooth
DeleteLineRadiaMap(handles.PathName,handles.FileName,handles.x,handles.Bx,handles.Bz,handles.Lu,...
                   handles.forder,handles.funit,deleteLnstr,str);




% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

            contents = get(hObject,'String');
            val = get(hObject,'Value');
 % Set current data to the selected data set.
             setappdata(hObject,'str',contents{val}); 

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function deleteLn_Callback(hObject, eventdata, handles)
% hObject    handle to deleteLn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of deleteLn as text
%        str2double(get(hObject,'String')) returns contents of deleteLn as a double

 contents = get(hObject,'String');
            val = get(hObject,'Value');
 % Set current data to the selected data set.
             setappdata(hObject,'str',contents{val}); 
     

% --- Executes during object creation, after setting all properties.
function deleteLn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deleteLn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
