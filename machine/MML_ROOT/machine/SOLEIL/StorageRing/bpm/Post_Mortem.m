function varargout = Post_Mortem(varargin)
% POST_MORTEM M-file for Post_Mortem.fig
%      POST_MORTEM, by itself, creates a new POST_MORTEM or raises the existing
%      singleton*.
%
%      H = POST_MORTEM returns the handle to a new POST_MORTEM or the handle to
%      the existing singleton*.
%
%      POST_MORTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POST_MORTEM.M with the given input arguments.
%
%      POST_MORTEM('Property','Value',...) creates a new POST_MORTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Post_Mortem_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Post_Mortem_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Post_Mortem

% Last Modified by GUIDE v2.5 20-Nov-2007 16:03:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Post_Mortem_OpeningFcn, ...
                   'gui_OutputFcn',  @Post_Mortem_OutputFcn, ...
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


% --- Executes just before Post_Mortem is made visible.
function Post_Mortem_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Post_Mortem (see VARARGIN)
% Choose default command line output for Post_Mortem
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Post_Mortem wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Post_Mortem_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiopen(getfamilydata('Directory','BPMPostmortem'));

%X=[start:1:Endaff];
 for i=1:1:16000 
    handles.toto.value(i)=0; 
 end
handles.res1=res;
handles.zoomx=0;
handles.zoomz=0;
handles.limitex=10;
handles.limitez=5;
handles.start=1;
handles.Endaff=15000;
handles.cellule=1;
guidata(hObject, handles);
pushbutton3_Callback(hObject, eventdata, handles);
set(handles.pushbutton19,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton20,'BackgroundColor',[0.831,0.816,0.784]);
readnotification(handles)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cellule=1;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(handles.pushbutton3,'BackgroundColor','green');


function affiche(handles);

res=handles.res1;
cellule = handles.cellule;   
switch (cellule);
    case 1
        affbpm=0;
    case 2
        affbpm=7;
    case 3 
        affbpm=15;
    case 4
        affbpm=23;
    case 5
        affbpm=30;
    case 6
        affbpm=37;
    case 7
        affbpm=45;
    case 8
        affbpm=53;
    case 9
        affbpm=60;
    case 10
        affbpm=67;
    case 11
        affbpm=75;
    case 12
        affbpm=83;
    case 13 
        affbpm=90;
    case 14
        affbpm=97;
    case 15
        affbpm=105;
    case 16
        affbpm=113;
    otherwise
        affbpm=0;

end

% cellule 1 (120,1-6), C02 (7-14), C03(15-22), C04 (23-29), C05(30-36), C06(37-44), C07(45-52), C08(53-59)
% C09 (60-66), C10(67-74), C11 (75-82), C12(83-89), C13(90-96), C14(97-104), C15(105-112), C16(113-119)

X=[1:1:16000];
toto=0;

axes(handles.axes1);
if affbpm==0
  set(handles.text2,'string','BPM.1 (120)');
  if res.dev_replies(120).attr_values(1).value | toto;
   [A1,h1,g1]=plotyy(X,res.dev_replies(120).attr_values(2).value,X,res.dev_replies(120).attr_values(4).value);
   ylim([-handles.limitex handles.limitex])
   xLim([handles.start handles.Endaff])
   set(g1,'Color','red');
   set(A1(2),'YColor','r');
   xLim(A1(2),[handles.start handles.Endaff]);
   axes(handles.axes9);
   [A1,h1,g1]=plotyy(X,res.dev_replies(120).attr_values(3).value,X,res.dev_replies(120).attr_values(4).value);
   ylim([-handles.limitez handles.limitez])
   xLim([handles.start handles.Endaff])
   set(g1,'Color','red');
   set(A1(2),'YColor','r');
   xLim(A1(2),[handles.start handles.Endaff]);
  else
   plot(handles.toto.value);
   axes(handles.axes9);
   plot(handles.toto.value);
  end    
else
  set(handles.text2,'string',['BPM.1 (' num2str(affbpm) ')']);
  if res.dev_replies(affbpm).attr_values(1).value | toto;
   [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm).attr_values(2).value,X,res.dev_replies(affbpm).attr_values(4).value);
   ylim([-handles.limitex handles.limitex])
   xLim([handles.start handles.Endaff])
   set(g1,'Color','red');
   set(A1(2),'YColor','r');
   xLim(A1(2),[handles.start handles.Endaff]);
   axes(handles.axes9);
   if res.dev_replies(affbpm).attr_values(1).value | toto;
   [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm).attr_values(3).value,X,res.dev_replies(affbpm).attr_values(4).value);
    ylim([-handles.limitez handles.limitez])
   xLim([handles.start handles.Endaff])
   set(g1,'Color','red');
   set(A1(2),'YColor','r');
   xLim(A1(2),[handles.start handles.Endaff]);
  end
  else
   plot(handles.toto.value);
   axes(handles.axes9);
   plot(handles.toto.value);
  end    
end
axes(handles.axes2);
set(handles.text3,'string',['BPM.2 (' num2str(affbpm+1) ')']);
if res.dev_replies(affbpm+1).attr_values(1).value | toto;
 [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+1).attr_values(2).value,X,res.dev_replies(affbpm+1).attr_values(4).value);
 ylim([-handles.limitex handles.limitex])
 xLim([handles.start handles.Endaff])
 set(g1,'Color','red');
 set(A1(2),'YColor','r');
 xLim(A1(2),[handles.start handles.Endaff]);
 axes(handles.axes10);
 if res.dev_replies(affbpm+1).attr_values(1).value | toto;
  [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+1).attr_values(3).value,X,res.dev_replies(affbpm+1).attr_values(4).value);
  ylim([-handles.limitez handles.limitez])
  xLim([handles.start handles.Endaff])
  set(g1,'Color','red');
  set(A1(2),'YColor','r');
  xLim(A1(2),[handles.start handles.Endaff]);
 end
else
 plot(handles.toto.value);
 axes(handles.axes10);
 plot(handles.toto.value);
end    
axes(handles.axes3);
set(handles.text4,'string',['BPM.3 (' num2str(affbpm+2) ')']);
if res.dev_replies(affbpm+2).attr_values(1).value | toto;
 [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+2).attr_values(2).value,X,res.dev_replies(affbpm+2).attr_values(4).value);
 ylim([-handles.limitex handles.limitex])
 xLim([handles.start handles.Endaff])
 set(g1,'Color','red');
 set(A1(2),'YColor','r');
 xLim(A1(2),[handles.start handles.Endaff]);
 axes(handles.axes11);
 if res.dev_replies(affbpm+2).attr_values(1).value | toto;
  [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+2).attr_values(3).value,X,res.dev_replies(affbpm+2).attr_values(4).value);
  ylim([-handles.limitez handles.limitez])
  xLim([handles.start handles.Endaff])
  set(g1,'Color','red');
  set(A1(2),'YColor','r');
  xLim(A1(2),[handles.start handles.Endaff]);
 end    
else
  plot(handles.toto.value);
  axes(handles.axes11);
  plot(handles.toto.value);
end    
axes(handles.axes4);
set(handles.text5,'string',['BPM.4 (' num2str(affbpm+3) ')']);
if res.dev_replies(affbpm+3).attr_values(1).value | toto;
 [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+3).attr_values(2).value,X,res.dev_replies(affbpm+3).attr_values(4).value);
 ylim([-handles.limitex handles.limitex])
 xLim([handles.start handles.Endaff])
 set(g1,'Color','red');
 set(A1(2),'YColor','r');
 xLim(A1(2),[handles.start handles.Endaff]);
 axes(handles.axes12);
 if res.dev_replies(affbpm+3).attr_values(1).value | toto;
  [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+3).attr_values(3).value,X,res.dev_replies(affbpm+3).attr_values(4).value);
  ylim([-handles.limitez handles.limitez])
  xLim([handles.start handles.Endaff])
  set(g1,'Color','red');
  set(A1(2),'YColor','r');
  xLim(A1(2),[handles.start handles.Endaff]);
 end    
else
 plot(handles.toto.value);
 axes(handles.axes12);
 plot(handles.toto.value);
end    
axes(handles.axes5);
set(handles.text6,'string',['BPM.5 (' num2str(affbpm+4) ')']);
if res.dev_replies(affbpm+4).attr_values(1).value | toto;
 [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+4).attr_values(2).value,X,res.dev_replies(affbpm+4).attr_values(4).value);
 ylim([-handles.limitex handles.limitex])
 xLim([handles.start handles.Endaff])
 set(g1,'Color','red');
 set(A1(2),'YColor','r');
 xLim(A1(2),[handles.start handles.Endaff]);
 axes(handles.axes13);
 if res.dev_replies(affbpm+4).attr_values(1).value | toto;
  [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+4).attr_values(3).value,X,res.dev_replies(affbpm+4).attr_values(4).value);
  ylim([-handles.limitez handles.limitez])
  xLim([handles.start handles.Endaff])
  set(g1,'Color','red');
  set(A1(2),'YColor','r');
  xLim(A1(2),[handles.start handles.Endaff]);
 end    
else
 plot(handles.toto.value);
 axes(handles.axes13);
 plot(handles.toto.value);
end    
axes(handles.axes6);
set(handles.text7,'string',['BPM.6 (' num2str(affbpm+5) ')']);
if res.dev_replies(affbpm+5).attr_values(1).value | toto;
 [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+5).attr_values(2).value,X,res.dev_replies(affbpm+5).attr_values(4).value);
 ylim([-handles.limitex handles.limitex])
 xLim([handles.start handles.Endaff])
 set(g1,'Color','red');
 set(A1(2),'YColor','r');
 xLim(A1(2),[handles.start handles.Endaff]);
 axes(handles.axes14);
 if res.dev_replies(affbpm+5).attr_values(1).value | toto;
  [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+5).attr_values(3).value,X,res.dev_replies(affbpm+5).attr_values(4).value);
  ylim([-handles.limitez handles.limitez])
  xLim([handles.start handles.Endaff])
  set(g1,'Color','red');
  set(A1(2),'YColor','r');
  xLim(A1(2),[handles.start handles.Endaff]);
 end    
else
 plot(handles.toto.value);
 axes(handles.axes14);
 plot(handles.toto.value);
end    
axes(handles.axes7);
set(handles.text8,'string',['BPM.7 (' num2str(affbpm+6) ')']);
if res.dev_replies(affbpm+6).attr_values(1).value | toto;
 [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+6).attr_values(2).value,X,res.dev_replies(affbpm+6).attr_values(4).value);
 ylim([-handles.limitex handles.limitex])
 xLim([handles.start handles.Endaff])
 set(g1,'Color','red');
 set(A1(2),'YColor','r');
 xLim(A1(2),[handles.start handles.Endaff]);
 axes(handles.axes15);
 if res.dev_replies(affbpm+6).attr_values(1).value | toto;
  [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+6).attr_values(3).value,X,res.dev_replies(affbpm+6).attr_values(4).value);
  ylim([-handles.limitez handles.limitez])
  xLim([handles.start handles.Endaff])
  set(g1,'Color','red');
  set(A1(2),'YColor','r');
  xLim(A1(2),[handles.start handles.Endaff]);
 end    
else
 plot(handles.toto.value);
 axes(handles.axes15);
 plot(handles.toto.value);
end    
if ((affbpm==7) | (affbpm==15) | (affbpm==37) | (affbpm==45) | (affbpm==67) | (affbpm==75) | (affbpm==97) | (affbpm==105))
 axes(handles.axes8);
 set(handles.text9,'string',['BPM.8 (' num2str(affbpm+7) ')']);
 if res.dev_replies(affbpm+7).attr_values(1).value | toto;
  [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+7).attr_values(2).value,X,res.dev_replies(affbpm+7).attr_values(4).value);
  ylim([-handles.limitex handles.limitex])
  xLim([handles.start handles.Endaff])
  set(g1,'Color','red');
  set(A1(2),'YColor','r');
  xLim(A1(2),[handles.start handles.Endaff]);
  axes(handles.axes16);
  [A1,h1,g1]=plotyy(X,res.dev_replies(affbpm+7).attr_values(3).value,X,res.dev_replies(affbpm+7).attr_values(4).value);
  ylim([-handles.limitez handles.limitez])
  xLim([handles.start handles.Endaff])
  set(g1,'Color','red');
  set(A1(2),'YColor','r');
  xLim(A1(2),[handles.start handles.Endaff]);
 else
  plot(handles.toto.value);
 end
else
   set(handles.text9,'string',' ');
   axes(handles.axes8);
   plot(handles.toto.value);
   axes(handles.axes16);
   plot(handles.toto.value);
 end
if cellule < 10
  set(handles.text1,'string',['C0' num2str(cellule)]);
else
set(handles.text1,'string',['C' num2str(cellule)]);
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=2;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(handles.pushbutton4,'BackgroundColor','green');


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=3;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=4;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=5;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=6;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=7;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=8;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=9;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=10;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');


% --- Executes on 0button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=11;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=12;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=13;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reservedx - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=14;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=15;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cellule=16;
guidata(hObject, handles);
affiche(handles);
efface_bouton(handles);
set(hObject,'BackgroundColor','green');


function efface_bouton(handles);

set(handles.pushbutton3,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton4,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton5,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton6,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton7,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton8,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton9,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton10,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton11,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton12,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton13,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton14,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton15,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton16,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton17,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton18,'BackgroundColor',[0.831,0.816,0.784]);


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


zoom=handles.zoomx;
if zoom==0;
   handles.zoomx=1; 
   handles.start=13000;
   handles.Endaff=15000;
   set(hObject,'BackgroundColor','green');
else
   handles.zoomx=0;
   handles.start=1;
   handles.Endaff=15000;
   set(hObject,'BackgroundColor',[0.831,0.816,0.784]);
end
guidata(hObject, handles);
affiche(handles)

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

zoom=handles.zoomz;
if handles.zoomz==0;
   handles.zoomz=1; 
   handles.limitex=5;
   handles.limitez=2;
   set(hObject,'BackgroundColor','green');
else
   handles.zoomz=0;
   handles.limitex=10;
   handles.limitez=5;
   set(hObject,'BackgroundColor',[0.831,0.816,0.784]);
end
guidata(hObject, handles);
affiche(handles);


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N=16000
start=13000;
stop=14000;
orbite=0;
groupe=tango_group_create2('BPMs_ans');
for i=1:1:16
    list=getbpmbyrack(i);
    dev_list=dev2tango ('BPMx','Monitor',list);
    for j=1:1:size(dev_list,1)
        dev_list{j}=dev_list{j}(1:16);
        tango_group_add(groupe,dev_list{j});
    end
    

end
tango_group_dump(groupe)
attr_list={'PMNotified','XPosPM','ZPosPM','SumPM'}
res=tango_group_read_attributes(groupe,attr_list,3)
filename = [getfamilydata('Directory','BPMPostmortem') 'PM_data_',date];
uisave('res',filename);
tango_group_kill(groupe);
for i=1:1:16000 
    handles.toto.value(i)=0; 
end
handles.res1=res;
handles.zoomx=0;
handles.zoomz=0;
handles.limitex=10;
handles.limitez=5;
handles.start=1;
handles.Endaff=15000;
handles.cellule=1;
guidata(hObject, handles);
pushbutton3_Callback(hObject, eventdata, handles);
set(handles.pushbutton19,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton20,'BackgroundColor',[0.831,0.816,0.784]);
readnotification(handles)

% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N=16000
start=13000;
stop=14000;
orbite=0;
groupe=tango_group_create2('BPMs_ans');
for i=1:1:16
    list=getbpmbyrack(i);
    dev_list=dev2tango ('BPMx','Monitor',list);
    for j=1:1:size(dev_list,1)
        dev_list{j}=dev_list{j}(1:16);
        tango_group_add(groupe,dev_list{j});
    end
    

end
tango_group_dump(groupe)
attr_list={'PMNotified','XPosPM','ZPosPM','SumPM'}
res=tango_group_read_attributes(groupe,attr_list,3)
tango_group_kill(groupe);
for i=1:1:16000 
    handles.toto.value(i)=0; 
end
handles.res1=res;
handles.zoomx=0;
handles.zoomz=0;
handles.limitex=10;
handles.limitez=5;
handles.start=1;
handles.Endaff=15000;
handles.cellule=1;
guidata(hObject, handles);
pushbutton3_Callback(hObject, eventdata, handles);
set(handles.pushbutton19,'BackgroundColor',[0.831,0.816,0.784]);
set(handles.pushbutton20,'BackgroundColor',[0.831,0.816,0.784]);
readnotification(handles)
% readinterlocknotification(handles)

% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% tango_command_inout2('ans/dg/state-bpm','ResetPMNotificationAll');
groupe=tango_group_create2('BPMs_ans');
for i=1:1:16
    list=getbpmbyrack(i);
    dev_list=dev2tango ('BPMx','Monitor',list);
    for j=1:1:size(dev_list,1)
        dev_list{j}=dev_list{j}(1:16);
        tango_group_add(groupe,dev_list{j});
    end
end
tango_group_dump(groupe);
tango_group_command_inout(groupe,'ResetPMNotification',1)
pause(1);
attr_list={'PMNotified'};
res2=tango_group_read_attributes(groupe,attr_list,3)
tango_group_kill(groupe);
a=0;
for b=1:1:120
  if res2.dev_replies(b).attr_values.value;
     a=1+a;
  end
end
set(handles.text14,'String',num2str(a));


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tango_command_inout2('ans/dg/state-bpm','ResetInterlockNotification');


function readnotification(handles)

res2=handles.res1;
a=0;
for b=1:1:120
  if res2.dev_replies(b).attr_values(1).value;
    a=a+1;
  end
end
set(handles.text14,'String',num2str(a));



function readinterlocknotification(handles)

cellule=handles.cellule;
tango_command_inout2('ans/dg/state-bpm','ResetPMNotificationAll');
groupe=tango_group_create2('BPMs_ans');
for i=1:1:16
    list=getbpmbyrack(i);
    dev_list=dev2tango ('BPMx','Monitor',list);
    for j=1:1:size(dev_list,1)
        dev_list{j}=dev_list{j}(1:16);
        tango_group_add(groupe,dev_list{j});
    end
end
tango_group_dump(groupe)
attr_list={'InterlockXNotified','InterlockZNotified','InterlockADCPostFilterNotified'}
res2=tango_group_read_attributes(groupe,attr_list,3)
switch (cellule);
    case 1
        affbpm=0;
    case 2
        affbpm=7;
    case 3 
        affbpm=15;
    case 4
        affbpm=23;
    case 5
        affbpm=30;
    case 6
        affbpm=37;
    case 7
        affbpm=45;
    case 8
        affbpm=53;
    case 9
        affbpm=60;
    case 10
        affbpm=67;
    case 11
        affbpm=75;
    case 12
        affbpm=83;
    case 13 
        affbpm=90;
    case 14
        affbpm=97;
    case 15
        affbpm=105;
    case 16
        affbpm=113;
    otherwise
        affbpm=0;

end
if affbpm==0;
    affbpm=120;
end
if res2.dev_replies(affbpm).attr_values(1).value;
   set(handles.text16,'String','InterlockXNotified');
 else
    if res2.dev_replies(affbpm).attr_values(2).value;
     set(handles.text16,'String','InterlockZNotified'); 
    else
      if res2.dev_replies(affbpm).attr_values(3).value;
      set(handles.text16,'String','InterlockADCNotified'); 
      else
          set(handles.text16,'String',' '); 
      end
    end
end
if affbpm==120;
    affbpm=0;
end
if res2.dev_replies(affbpm+1).attr_values(1).value;
   set(handles.text17,'String','InterlockXNotified');
 else
    if res2.dev_replies(affbpm+1).attr_values(2).value;
     set(handles.text17,'String','InterlockZNotified'); 
    else
      if res2.dev_replies(affbpm+1).attr_values(3).value;
      set(handles.text17,'String','InterlockADCNotified'); 
      else
          set(handles.text17,'String',' '); 
      end
    end
end
if res2.dev_replies(affbpm+1).attr_values(1).value;
   set(handles.text18,'String','InterlockXNotified');
 else
    if res2.dev_replies(affbpm+1).attr_values(2).value;
     set(handles.text18,'String','InterlockZNotified'); 
    else
      if res2.dev_replies(affbpm+1).attr_values(3).value;
      set(handles.text18,'String','InterlockADCNotified'); 
      else
          set(handles.text18,'String',' '); 
      end
    end
end
if res2.dev_replies(affbpm+1).attr_values(1).value;
   set(handles.text19,'String','InterlockXNotified');
 else
    if res2.dev_replies(affbpm+1).attr_values(2).value;
     set(handles.text19,'String','InterlockZNotified'); 
    else
      if res2.dev_replies(affbpm+1).attr_values(3).value;
      set(handles.text19,'String','InterlockADCNotified'); 
      else
          set(handles.text19,'String',' '); 
      end
    end
end
if res2.dev_replies(affbpm+1).attr_values(1).value;
   set(handles.text20,'String','InterlockXNotified');
 else
    if res2.dev_replies(affbpm+1).attr_values(2).value;
     set(handles.text20,'String','InterlockZNotified'); 
    else
      if res2.dev_replies(affbpm+1).attr_values(3).value;
      set(handles.text20,'String','InterlockADCNotified'); 
      else
          set(handles.text20,'String',' '); 
      end
    end
end
if res2.dev_replies(affbpm+1).attr_values(1).value;
   set(handles.text21,'String','InterlockXNotified');
 else
    if res2.dev_replies(affbpm+1).attr_values(2).value;
     set(handles.text21,'String','InterlockZNotified'); 
    else
      if res2.dev_replies(affbpm+1).attr_values(3).value;
      set(handles.text21,'String','InterlockADCNotified'); 
      else
          set(handles.text21,'String',' '); 
      end
    end
end
if res2.dev_replies(affbpm+1).attr_values(1).value;
   set(handles.text22,'String','InterlockXNotified');
 else
    if res2.dev_replies(affbpm+1).attr_values(2).value;
     set(handles.text22,'String','InterlockZNotified'); 
    else
      if res2.dev_replies(affbpm+1).attr_values(3).value;
      set(handles.text22,'String','InterlockADCNotified'); 
      else
          set(handles.text22,'String',' '); 
      end
    end
end
if res2.dev_replies(affbpm+1).attr_values(1).value;
   set(handles.text23,'String','InterlockXNotified');
 else
    if res2.dev_replies(affbpm+1).attr_values(2).value;
     set(handles.text23,'String','InterlockZNotified'); 
    else
      if res2.dev_replies(affbpm+1).attr_values(3).value;
      set(handles.text23,'String','InterlockADCNotified'); 
      else
          set(handles.text23,'String',' '); 
      end
    end
end
