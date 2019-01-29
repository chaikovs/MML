function varargout = RFPostMortem(varargin)
%RFPOSTMORTEM121007 M-file for RFPostMortem121007.fig
%      RFPOSTMORTEM121007, by itself, creates a new RFPOSTMORTEM121007 or raises the existing
%      singleton*.
%
%      H = RFPOSTMORTEM121007 returns the handle to a new RFPOSTMORTEM121007 or the handle to
%      the existing singleton*.
%
%      RFPOSTMORTEM121007('Property','Value',...) creates a new RFPOSTMORTEM121007 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to RFPostMortem121007_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      RFPOSTMORTEM121007('CALLBACK') and RFPOSTMORTEM121007('CALLBACK',hObject,...) call the
%      local function named CALLBACK in RFPOSTMORTEM121007.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RFPostMortem121007

% Last Modified by G+1UIDE v2.5 29-Feb-2008 13:41:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RFPostMortem_OpeningFcn, ...
                   'gui_OutputFcn',  @RFPostMortem_OutputFcn, ...
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

% --- Executes just before RFPostMortem121007 is made visible.
function RFPostMortem_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for RFPostMortem121007
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RFPostMortem121007 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RFPostMortem_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                       CAVITE 1                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton1_ACQUISITION.
function pushbutton1_ACQUISITION_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_ACQUISITION (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

statusAcquisition_cav1=tango_read_attribute2('ANS-C03/RF/PM.1','Status');
text=statusAcquisition_cav1.value;
if findstr(text, 'running')
    msgbox('Fonctionnement Normal: pas d''acquisition à faire','Info','warn');
    return;
    
else

    set(handles.text4_PR1,'String','Pr1');
    set(handles.text_PR2,'String','Pr2');
    set(handles.text_PR3,'String','Pr3');
    set(handles.text_PR4,'String','Pr4');

    rep = tango_read_attributes2('ANS-C03/RF/AMP.1-DATA', {'reflectedPowerSecurityT1','reflectedPowerSecurityT2',...
        'reflectedPowerSecurityT3','reflectedPowerSecurityT4'});

    Data.AMP1.reflectedPowerSecurityT1 = rep(1).value;
    Data.AMP1.reflectedPowerSecurityT2 = rep(2).value;
    Data.AMP1.reflectedPowerSecurityT3 = rep(3).value;
    Data.AMP1.reflectedPowerSecurityT4 = rep(4).value;
   
    
    if Data.AMP1.reflectedPowerSecurityT1
     set(handles.text4_PR1,'BackgroundColor', [0 1 0]); %green
    else 
     set(handles.text4_PR1,'BackgroundColor', [1 0 0]); %red
    end
    
    if Data.AMP1.reflectedPowerSecurityT2
     set(handles.text_PR2,'BackgroundColor', [0 1 0]); %green
    else 
     set(handles.text_PR2,'BackgroundColor', [1 0 0]); %red
    end

    if Data.AMP1.reflectedPowerSecurityT3
     set(handles.text_PR3,'BackgroundColor', [0 1 0]); %green
    else 
     set(handles.text_PR3,'BackgroundColor', [1 0 0]); %red
    end
    
    if Data.AMP1.reflectedPowerSecurityT4
     set(handles.text_PR4,'BackgroundColor', [0 1 0]); %green
    else 
     set(handles.text_PR4,'BackgroundColor', [1 0 0]); %red
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    set(handles.text_Pi,'String','Pi');
    set(handles.text_PSS,'String','PSS Sec');
    set(handles.text_uC,'String','uC');
    
    repPSS = tango_read_attribute2('ANS-C03/RF/LLE.1','pssSecurity');
    %rep = tango_read_attributes2('ANS-C03/RF/AMP.1-DATA', {'incidentPowerSecurity','pssSecurity','microcontrollerSecurity'});
    rep = tango_read_attributes2('ANS-C03/RF/AMP.1-DATA', {'incidentPowerSecurity','microcontrollerSecurity'});
    
    Data.AMP1.incidentPowerSecurity = rep(1).value;
    Data.AMP1.pssSecurity = repPSS.value;
    Data.AMP1.microcontrollerSecurity=rep(2).value;
    
    if Data.AMP1.incidentPowerSecurity
      set(handles.text_Pi,'BackgroundColor', [0 1 0]); %green
    else 
      set(handles.text_Pi,'BackgroundColor', [1 0 0]); %red
    end
    
    if Data.AMP1.pssSecurity
      set(handles.text_PSS,'BackgroundColor', [0 1 0]); %green
    else 
      set(handles.text_PSS,'BackgroundColor', [1 0 0]); %red
    end
    
    if Data.AMP1.microcontrollerSecurity
      set(handles.text_uC,'BackgroundColor', [0 1 0]); %green
    else 
      set(handles.text_uC,'BackgroundColor', [1 0 0]); %red
    end
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    
    set(handles.text_InterLCKmach,'String','Interlck MACH');
    set(handles.text_VAC,'String','VAC');
    set(handles.text_CRYO,'String','CRYO');
    
    
    repINTER = tango_read_attribute2('ANS-C03/RF/LLE.1','machineSecurity');
    %rep = tango_read_attributes2('ANS-C03/RF/CAV.1', {'interlock','vacuumSecurity','cryomoduleSecurity'});
    rep = tango_read_attributes2('ANS-C03/RF/CAV.1', {'vacuumSecurity','cryomoduleSecurity'});
    
    Data.CAV1.interlock = repINTER.value;
    %Data.CAV1.interlock = rep(1).value;
    Data.CAV1.vacuum    = rep(1).value;
    Data.CAV1.cryo = rep(2).value;

    if Data.CAV1.interlock
      set(handles.text_InterLCKmach,'BackgroundColor', [0 1 0]); %green
    else 
        %disp (Data.CAV1.interlock);
      set(handles.text_InterLCKmach,'BackgroundColor', [1 0 0]); %red
    end
    
    if Data.CAV1.vacuum
        %disp (Data.CAV1.vacuum);
      set(handles.text_VAC,'BackgroundColor', [0 1 0]); %green
    else 
        %disp (Data.CAV1.vacuum)
      set(handles.text_VAC,'BackgroundColor', [1 0 0]); %red
    end
    
    if Data.CAV1.cryo
        %disp (Data.CAV1.cryo);
      set(handles.text_CRYO,'BackgroundColor', [0 1 0]); %green
    else 
        %disp (Data.CAV1.vacuum)
      set(handles.text_CRYO,'BackgroundColor', [1 0 0]); %red
    end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

rep = tango_read_attributes2('ANS-C03/RF/PM.1', {'acqHighResolutionCh1', 'acqHighResolutionCh2', 'acqHighResolutionCh3', ...
    'acqHighResolutionCh4'});
Data.PM1.DataHR1 = rep(1).value;
Data.PM1.DataHR2 = rep(2).value;
Data.PM1.DataHR3 = rep(3).value;
Data.PM1.DataHR4 = rep(4).value;

Data.PM1.TimestampHR = tango_shift_time(rep(1).time);

reptrig1 = tango_read_attribute2('ANS-C03/RF/PM.1','triggerTimestamp');
Data.PM1.triggerTimestamp = reptrig1.value;

[NbrColumn,NbrPoint1] = size (Data.PM1.DataHR1);

axes(handles.graph1);
    
    name1='_AcRAPIDE'
   
    %pnt=1:10000;
    pnt=1:NbrPoint1;


    hold off;
    plot(pnt, Data.PM1.DataHR1,'b'); hold on; grid on;
    plot(pnt, Data.PM1.DataHR2,'r');
    plot(pnt, Data.PM1.DataHR3,'g');
    plot(pnt, Data.PM1.DataHR4,'k');
    legend('Ac. Rapide CH1: Vcav', 'Ac. Rapide CH2: Pi','Ac. Rapide CH3: Pr','Ac. Rapide CH4: Ib');
    %text(Data.PM1.triggerTimestamp);
    xlabel('nombre de points (temps: 1 us par point)');
    ylabel('Signal');



%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%

DirectoryName = getfamilydata('Directory', 'RFPostmortem');
%FileName = appendtimestamp('RFdata_CAV1', Data.PM1.TimestampHR);
%COMMENT% FileName = appendtimestamp('RFdata_CAV1', Data.PM1.triggerTimestamp);
%FileName = appendtimestamp('RFdata_CAV1', Data.PM1.triggerTimestamp);
FileName =['RFdata_CAV1_', Data.PM1.triggerTimestamp];
%FileName = strcat(FileName,name1);
%button group

[token,remain]=strtok(FileName);
res=datevec(remain);
resp1=num2str(res(1));
resp2=num2str(res(2));
resp3=num2str(res(3));
resp4=num2str(res(4));
resp5=num2str(res(5));
resp6=num2str(res(6));
FileNameLAST=strcat('RFdata_CAV1','_',resp1,'-',resp2,'-',resp3,'_',resp4,'h',resp5,'mn',resp6,'s');
disp (FileNameLAST);

[FileNameLAST, DirectoryName] = uiputfile('*.mat', 'Select File (Cancel to not save to a file)', [DirectoryName FileNameLAST, '.mat']);
if FileNameLAST == 0
    disp('   No data saved');
    return;
    %RFdata_2007-10-10_13-48-23.mat
end

DirStart = pwd;
[DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
save(FileNameLAST, 'Data');
cd(DirStart);
fprintf('   Data saved to %s\n', [DirectoryName FileNameLAST]);

setappdata(handles.figure1, 'RFdata_CAV1', Data);

end
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%



% --- Executes on button press in pushbutton2_CLEA*.matR.
function pushbutton2_CLEAR_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2_CLEAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure*.mat with handles and user data (see GUIDATA)

axes(handles.graph1);
hold off;
plot(NaN);


set(handles.text4_PR1,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_PR2,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_PR3,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_PR4,'BackgroundColor', [0.702 0.702 0.702]); %gray
    
set(handles.text_Pi,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_PSS,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_uC,'BackgroundColor', [0.702 0.702 0.702]); %gray
  
set(handles.text_InterLCKmach,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_VAC,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_CRYO,'BackgroundColor', [0.702 0.702 0.702]); %gray
    

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton_Open.
function pushbutton_Open_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

DirectoryName = getfamilydata('Directory', 'RFPostmortem');
DirStart = pwd;
DirectoryName = gotodirectory(DirectoryName);
[FileName, DirectoryName] = uigetfile('*.mat', 'Select File (Cancel to not save to a file)','RFdata_CAV1*');
disp (FileName);

global DirectoryNameGlobal;
DirectoryNameGlobal=DirectoryName;
global FileNameGlobal;
FileNameGlobal=FileName;

if FileName == 0
    msgbox('No file chosen','Info','warn');
    %disp('   No file chosen');
    return;
else
    load(FileName, 'Data');
end
cd(DirStart);

setappdata(handles.figure1, 'RFdata_CAV1', Data);



if Data.AMP1.reflectedPowerSecurityT1
    set(handles.text4_PR1,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text4_PR1,'BackgroundColor', [1 0 0]); %red
end 

if Data.AMP1.reflectedPowerSecurityT2
    set(handles.text_PR2,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_PR2,'BackgroundColor', [1 0 0]); %red
end   

if Data.AMP1.reflectedPowerSecurityT3
    set(handles.text_PR3,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_PR3,'BackgroundColor', [1 0 0]); %red
end

if Data.AMP1.reflectedPowerSecurityT4
    set(handles.text_PR4,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_PR4,'BackgroundColor', [1 0 0]); %red
end


if Data.AMP1.incidentPowerSecurity
    set(handles.text_Pi,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_Pi,'BackgroundColor', [1 0 0]); %red
end
    
if Data.AMP1.pssSecurity
    set(handles.text_PSS,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_PSS,'BackgroundColor', [1 0 0]); %red
end
    
if Data.AMP1.microcontrollerSecurity
    set(handles.text_uC,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_uC,'BackgroundColor', [1 0 0]); %red
end

if Data.CAV1.interlock
    set(handles.text_InterLCKmach,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_InterLCKmach,'BackgroundColor', [1 0 0]); %red
end
    
if Data.CAV1.vacuum
    set(handles.text_VAC,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_VAC,'BackgroundColor', [1 0 0]); %red
end
    
if Data.CAV1.cryo
    set(handles.text_CRYO,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_CRYO,'BackgroundColor', [1 0 0]); %red
end

axes(handles.graph1);

[NbrColumn,NbrPoint2] = size (Data.PM1.DataHR1);

    %%Data.PM1.DataHR1 = -(Data.PM1.DataHR1/5)*10^6;  
    %disp (Data.PM1.DataHR1(2));
    %%Data.PM1.DataHR2 = ((0.0361 + 0.2542*Data.PM1.DataHR2 - 0.0112*Data.PM1.DataHR2.^2 + 0.0011*Data.PM1.DataHR2.^3).^2/50)*2.74*10^7; 
    %%Data.PM1.DataHR3 = ((0.0361 + 0.2542*Data.PM1.DataHR3 - 0.0112*Data.PM1.DataHR3.^2 + 0.0011*Data.PM1.DataHR3.^3).^2/50)*8.2*10^5;
    %%Data.PM1.DataHR4 = (Data.PM1.DataHR4)*10^4; 

    %global NbrPoint
    %[NbrColumn,NbrPoint2] = size (Data.PM1.DataHR1);
    %NbrPoint2=10000;

hold off;
pnt=[1:NbrPoint2];

    %pnt=1:NbrPoint2;

    %hold on; grid on;
    %//pnt1=1:200000;
    %//pnt2=1:200000;
        %[haxes,hline1,hline2,hline3]=plotyy(pnt,Data.PM1.DataHR1,pnt,Data.PM1.DataHR2,pnt,Data.PM1.DataHR3);
    %[haxes,hline1,hline2]=plotyy(pnt,Data.PM1.DataHR1,pnt,Data.PM1.DataHR2);
    %//[haxes,hline1,hline2]=plotyy(pnt1,Data.PM1.DataHR1,pnt2,Data.PM1.DataHR2,'plot');
    %//set(hline1,'Color','b');
    %//set(hline2,'Color','r');
    %//axes(haxes(1));%110108%
    %110108%axis([valmin valmax minHR1app maxHR1app]);%110108%
    %110108%set(gca,'YTick',minHR1app:((maxHR1app-minHR1app)/10):maxHR1app);%110108%
        %[haxes,hline3,hline4]=plotyy(pnt,Data.PM1.DataHR3,pnt,Data.PM1.DataHR4);
plot(pnt, Data.PM1.DataHR1,'b'); hold on; grid on;
plot(pnt, Data.PM1.DataHR2,'r');
plot(pnt, Data.PM1.DataHR3,'g');
plot(pnt, Data.PM1.DataHR4,'k');
legend('Ac. Rapide CH1: Vcav', 'Ac. Rapide CH2: Pi','Ac. Rapide CH3: Pr','Ac. Rapide CH4: Ib');
%%legend('Ac. Rapide CH1: Vcav', 'Ac. Rapide CH2: Pi');
xlabel('nombre de points (temps: 1 us par point)');
 
    %zoom on; 
    %//ylabel('Vcav [V]','Color','b');
ylabel('Signal');
    %//ylabel('Vcav [V]');
    %LegVcav=legend('Ac. Rapide CH1: Vcav');
    %121108 set(LegVcav,'Location','NorthWest');
    %set(LegVcav,'background','g');
    %//axes(haxes(2));
    %110108%axis([valmin valmax minapp1 maxapp1]);%110108%
    %110108%set(gca,'YTick',minapp1:((maxapp1-minapp1)/10):maxapp1);%110108%
    %//axis auto;
    %axes(h,'Color','b');
    %//ylabel('Power [Watts]');
    %//hold on; grid on;
    %//plot(pnt2,Data.PM1.DataHR3,'y');

    %hold on; grid on;
    %//plot(pnt2, Data.PM1.DataHR4,'k');
    %//LegPuissance=legend('Ac. Rapide CH2: Pi','Ac. Rapide CH3: Pr','Ac. Rapide CH4: Ib');
    %legend('Ac. Rapide CH4: Ib');
    %ylabel('Signal');
text(1000,0.5,Data.PM1.triggerTimestamp);

   







% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

valmax=1;
valmin=0;

valminINIT=get(handles.edit2,'String');
valmin=str2num(valminINIT{1});
valmaxINIT=get(handles.edit3,'String');
valmax=str2num(valmaxINIT{1});

n=valmax-valmin+1;
i=1;

global DirectoryNameGlobal;
disp ('DirectoryNameGlobal');
gotodirectory(DirectoryNameGlobal);

global FileNameGlobal;
load(FileNameGlobal, 'Data');   

for i=1:n
    %matAbscisse(i)=valmin+i-1;
    %matHR1(i)=Data.PM1.DataHR1(i);
    %matHR1(i)=-(Data.PM1.DataHR1(valmin+i-1)/5)*10^6;
    Data.PM1.DataHR1(valmin+i-1)=-((Data.PM1.DataHR1(valmin+i-1))/5)*10^2;
    %Data.PM1.DataHR1=-Data.PM1.DataHR1(1,valmin:valmax)*10;
    %matHR2(i)=Data.PM1.DataHR2(i);
    %matHR2(i)=((0.0361 + 0.2542*Data.PM1.DataHR2(valmin+i-1) - 0.0112*Data.PM1.DataHR2(valmin+i-1).^2 + 0.0011*Data.PM1.DataHR2(valmin+i-1).^3).^2/50)*2.74*10^7;
    Data.PM1.DataHR2(valmin+i-1)=((0.0361 + 0.2542*Data.PM1.DataHR2(valmin+i-1) - 0.0112*Data.PM1.DataHR2(valmin+i-1).^2 + 0.0011*Data.PM1.DataHR2(valmin+i-1).^3).^2/50)*2.74*10^4;
    %%Data.PM1.DataHR2=Data.PM1.DataHR2*12;
    %matHR3(i)=Data.PM1.DataHR3(i);
    %matHR3(i)=((0.0361 + 0.2542*Data.PM1.DataHR3(valmin+i-1) - 0.0112*Data.PM1.DataHR3(valmin+i-1).^2 + 0.0011*Data.PM1.DataHR3(valmin+i-1).^3).^2/50)*8.2*10^5;
    Data.PM1.DataHR3(valmin+i-1)=((0.0361 + 0.2542*Data.PM1.DataHR3(valmin+i-1) - 0.0112*Data.PM1.DataHR3(valmin+i-1).^2 + 0.0011*Data.PM1.DataHR3(valmin+i-1).^3).^2/50)*8.2*10^2;
    %%Data.PM1.DataHR3=Data.PM1.DataHR3*14;
    %matHR4(i)=Data.PM1.DataHR4(i);
    %matHR4(i)=(Data.PM1.DataHR4(valmin+i-1))*10^3;
    Data.PM1.DataHR4(valmin+i-1)=(Data.PM1.DataHR4(valmin+i-1))*10^2;
    %%Data.PM1.DataHR4=Data.PM1.DataHR4*16;
end

maxHR1=max(Data.PM1.DataHR1);
maxHR2=max(Data.PM1.DataHR2);
maxHR3=max(Data.PM1.DataHR3);
maxHR4=max(Data.PM1.DataHR4);
minHR1=min(Data.PM1.DataHR1);
minHR2=min(Data.PM1.DataHR2);
minHR3=min(Data.PM1.DataHR3);
minHR4=min(Data.PM1.DataHR4);

if (maxHR2(1)>maxHR3(1))
    max1=maxHR2(1)
else max1=maxHR3(1);
end
if (max1<maxHR4(1))
    max1=maxHR4(1);
end

if (minHR2(1)<minHR3(1))
   min1=minHR2(1)
else min1=minHR3(1);
end
if (min1>minHR4(1))
    min1=minHR4(1);
end

%minapp1=min1;
%maxapp1=max1;
minHR1app=minHR1(1);
maxHR1app=maxHR1(1);

if (minHR1app<min1)
    mini=minHR1
else
    mini=min1
end

if (maxHR1app>max1)
    maxi=maxHR1
else
    maxi=max1
end

axes(handles.graph1);


hold off;
pnt=[valmin:valmax];
axis([valmin valmax mini maxi]);
set(gca,'XTick',[valmin valmax]);
plot(Data.PM1.DataHR1,'b'); hold on; grid on;
axis([valmin valmax mini maxi])
plot(Data.PM1.DataHR2,'r');
plot(Data.PM1.DataHR3,'g');
plot(Data.PM1.DataHR4,'k');
legend('Ac. Rapide CH1: Vcav', 'Ac. Rapide CH2: Pi','Ac. Rapide CH3: Pr','Ac. Rapide CH4: Ib');
xlabel('nombre de points (temps: 1 us par point)');
ylabel('Signal');
text(1000,0.5,Data.PM1.triggerTimestamp);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton_RESET_cav1.
function pushbutton_RESET_cav1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_RESET_cav1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%DirectoryNameESP='/home/operateur/GrpRF/Nicolas';
%DirectoryNameESP = gotodirectory(DirectoryNameESP);
%FilenameESP='ESP';
%load(Filename);

statusAcquisition_cav1=tango_read_attribute2('ANS-C03/RF/PM.1','Status');
text=statusAcquisition_cav1.value;
if findstr(text, 'running')
    msgbox('Un reset a déjà été fait, le device fonctionne Normalement','Info','warn');
    return;
else
    set(handles.pushbutton_RESET_cav1,'Tag','pushbutton_RESET_cav1');
    %set(handles.pushbutton_RESET_cav1,'String','RESET');
    %tango_command_inout2('ANS-C03/RF/PM.1','Init');
    tango_command_inout2('ANS-C03/RF/PM.1','Start');
    
    fid=0;
    filenameRES='/home/operateur/GrpRF/Nicolas/SUIVIreset';
    %filenameRES='TESTres';
    fid=fopen(filenameRES,'a+');
    %disp (fid);
    %disp ('2');
    %valeurTEST='test11111';
    valeurTEST=datestr(clock,0);
    
    fprintf(fid,'Reset CAV1 at: %s \n',valeurTEST);
    fclose(fid);
    %DateReset = clock;
end 

%tango_command_inout2('ANS-C03/RF/PM.1','Stop'); %NE PAS OUBLIER D'ENLEVER CETTE LIGNE APRES TEST 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                       CAVITE 2                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton_cav2_Acquisition.
function pushbutton_cav2_Acquisition_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cav2_Acquisition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

statusAcquisition_cav2=tango_read_attribute2('ANS-C03/RF/PM.2','Status');
text=statusAcquisition_cav2.value;
if findstr(text, 'running')
    msgbox('Fonctionnement Normal: pas d''acquisition à faire','Info','warn');
    return;
    
else

set(handles.text_cav2_PR1,'String','Pr1');
set(handles.text_cav2_PR2,'String','Pr2');
set(handles.text_cav2_PR3,'String','Pr3');
set(handles.text_cav2_PR4,'String','Pr4');

rep = tango_read_attributes2('ANS-C03/RF/AMP.2-DATA', {'reflectedPowerSecurityT1','reflectedPowerSecurityT2',...
        'reflectedPowerSecurityT3','reflectedPowerSecurityT4'});

%%rep = tango_read_attribute2('ANS-C03/RF/AMP.2-DATA','reflectedPowerSecurityT1')

%%Data.AMP2.reflectedPowerSecurityT1 = rep.value;    
Data.AMP2.reflectedPowerSecurityT1 = rep(1).value;
Data.AMP2.reflectedPowerSecurityT2 = rep(2).value;
Data.AMP2.reflectedPowerSecurityT3 = rep(3).value;
Data.AMP2.reflectedPowerSecurityT4 = rep(4).value;
    
if Data.AMP2.reflectedPowerSecurityT1
    set(handles.text_cav2_PR1,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_PR1,'BackgroundColor', [1 0 0]); %red
end
    
if Data.AMP2.reflectedPowerSecurityT2
    set(handles.text_cav2_PR2,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_PR2,'BackgroundColor', [1 0 0]); %red
end

if Data.AMP2.reflectedPowerSecurityT3
    set(handles.text_cav2_PR3,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_PR3,'BackgroundColor', [1 0 0]); %red
end
    
if Data.AMP2.reflectedPowerSecurityT4
    set(handles.text_cav2_PR4,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_PR4,'BackgroundColor', [1 0 0]); %red
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rep = tango_read_attributes2('ANS-C03/RF/PM.2', {'acqHighResolutionCh1', 'acqHighResolutionCh2', 'acqHighResolutionCh3', ...
    'acqHighResolutionCh4'});
Data.PM2.DataHR1 = rep(1).value;
Data.PM2.DataHR2 = rep(2).value;
Data.PM2.DataHR3 = rep(3).value;
Data.PM2.DataHR4 = rep(4).value;

Data.PM2.TimestampHR = tango_shift_time(rep(1).time);

reptrig2 = tango_read_attribute2('ANS-C03/RF/PM.2','triggerTimestamp');
Data.PM2.triggerTimestamp = reptrig2.value;

[NbrColumn,NbrPoint3] = size (Data.PM2.DataHR1);

axes(handles.graph2);
   
    name2='_AcRAPIDE'
    
    %pnt=1:10000;
    pnt=1:NbrPoint3;

    hold off;
    plot(pnt, Data.PM2.DataHR1,'b'); hold on; grid on;
    plot(pnt, Data.PM2.DataHR2,'r');
    plot(pnt, Data.PM2.DataHR3,'g');
    plot(pnt, Data.PM2.DataHR4,'k');
    legend('Ac. Rapide CH1: Vcav', 'Ac. Rapide CH2: Pi','Ac. Rapide CH3: Pr','Ac. Rapide CH4: Ib');
    xlabel('nombre de points (temps: 1 us par point)');
    ylabel('Signal');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.text_cav2_PI,'String','Pi');
set(handles.text_cav2_PSS,'String','PSS Sec');
set(handles.text_cav2_uC,'String','uC');
    
repPSS = tango_read_attribute2('ANS-C03/RF/LLE.2','pssSecurity');
    %rep = tango_read_attributes2('ANS-C03/RF/AMP.2-DATA', {'incidentPowerSecurity','pssSecurity','microcontrollerSecurity'});
    rep = tango_read_attributes2('ANS-C03/RF/AMP.2-DATA', {'incidentPowerSecurity','microcontrollerSecurity'});
    
    Data.AMP2.incidentPowerSecurity = rep(1).value;
    Data.AMP2.pssSecurity = repPSS.value;
    Data.AMP2.microcontrollerSecurity=rep(2).value;
    
    if Data.AMP2.incidentPowerSecurity
      set(handles.text_cav2_PI,'BackgroundColor', [0 1 0]); %green
    else 
      set(handles.text_cav2_PI,'BackgroundColor', [1 0 0]); %red
    end
    
    if Data.AMP2.pssSecurity
      set(handles.text_cav2_PSS,'BackgroundColor', [0 1 0]); %green
    else 
      set(handles.text_cav2_PSS,'BackgroundColor', [1 0 0]); %red
    end
    
    if Data.AMP2.microcontrollerSecurity
      set(handles.text_cav2_uC,'BackgroundColor', [0 1 0]); %green
    else 
      set(handles.text_cav2_uC,'BackgroundColor', [1 0 0]); %red
    end
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 set(handles.text_cav2_InterLCKmach,'String','Interlck MACH');
 set(handles.text_cav2_VAC,'String','VAC');
 set(handles.text_cav2_CRYO,'String','CRYO');
    
 repINTER = tango_read_attribute2('ANS-C03/RF/LLE.2','machineSecurity');
    %rep = tango_read_attributes2('ANS-C03/RF/CAV.2', {'interlock','vacuumSecurity','cryomoduleSecurity'});
    rep = tango_read_attributes2('ANS-C03/RF/CAV.2', {'vacuumSecurity','cryomoduleSecurity'});
    
    Data.CAV2.interlock = repINTER.value;
    %Data.CAV2.interlock = rep(1).value;
    Data.CAV2.vacuum    = rep(1).value;
    Data.CAV2.cryo = rep(2).value;

    if Data.CAV2.interlock
      set(handles.text_cav2_InterLCKmach,'BackgroundColor', [0 1 0]); %green
    else 
        %disp (Data.CAV2.interlock);
      set(handles.text_cav2_InterLCKmach,'BackgroundColor', [1 0 0]); %red
    end
    
    if Data.CAV2.vacuum
        %disp (Data.CAV2.vacuum);
      set(handles.text_cav2_VAC,'BackgroundColor', [0 1 0]); %green
    else 
        %disp (Data.CAV2.vacuum)
      set(handles.text_cav2_VAC,'BackgroundColor', [1 0 0]); %red
    end
    
    if Data.CAV2.cryo
        %disp (Data.CAV2.cryo);
      set(handles.text_cav2_CRYO,'BackgroundColor', [0 1 0]); %green
    else 
        %disp (Data.CAV2.vacuum)
      set(handles.text_cav2_CRYO,'BackgroundColor', [1 0 0]); %red
    end
    
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%    

DirectoryName = getfamilydata('Directory', 'RFPostmortem');
%FileName = appendtimestamp('RFdata_CAV2', Data.PM2.TimestampHR);
%comment% FileName = appendtimestamp('RFdata_CAV2', Data.PM2.triggerTimestamp);
%disp (Data.PM2.triggerTimestamp);
%disp (datevec(Data.PM2.triggerTimestamp));
%FileName = appendtimestamp('RFdata_CAV2', Data.PM2.triggerTimestamp);
FileName =['RFdata_CAV2_', Data.PM2.triggerTimestamp];

[token,remain]=strtok(FileName);
res=datevec(remain);
resp1=num2str(res(1));
resp2=num2str(res(2));
resp3=num2str(res(3));
resp4=num2str(res(4));
resp5=num2str(res(5));
resp6=num2str(res(6));
FileNameLAST2=strcat('RFdata_CAV2','_',resp1,'-',resp2,'-',resp3,'_',resp4,'h',resp5,'mn',resp6,'s');
disp (FileNameLAST2);

%FileName = strcat(FileName,name2);
%button group
[FileNameLAST2, DirectoryName] = uiputfile('*.mat', 'Select File (Cancel to not save to a file)', [DirectoryName FileNameLAST2, '.mat']);
if FileNameLAST2 == 0
    disp('   No data saved');
    return;
    %RFdata_2007-10-10_13-48-23.mat
end

DirStart = pwd;
[DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
save(FileNameLAST2, 'Data');
cd(DirStart);
fprintf('   Data saved to %s\n', [DirectoryName FileNameLAST2]);

setappdata(handles.figure1, 'RFdata_CAV2', Data);    


end
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% --- Executes on button press in pushbutton_cav2_OPEN.
function pushbutton_cav2_OPEN_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cav2_OPEN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
DirectoryName = getfamilydata('Directory', 'RFPostmortem');

DirStart = pwd;
DirectoryName = gotodirectory(DirectoryName);
[FileName, DirectoryName] = uigetfile('*.mat', 'Select File (Cancel to not save to a file)','RFdata_CAV2*');

global DirectoryNameGlobal;
DirectoryNameGlobal=DirectoryName;
global FileNameGlobal;
FileNameGlobal=FileName;

if FileName == 0
    msgbox('No file chosen','Info','warn');
    %disp('   No file chosen');
    return;
else
    load(FileName, 'Data');
end
cd(DirStart);

setappdata(handles.figure1, 'RFdata_CAV2', Data);

%disp (Data.PM2.DataLR);



if Data.AMP2.reflectedPowerSecurityT1
    set(handles.text_cav2_PR1,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_PR1,'BackgroundColor', [1 0 0]); %red
end 

if Data.AMP2.reflectedPowerSecurityT2
    set(handles.text_cav2_PR2,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_PR2,'BackgroundColor', [1 0 0]); %red
end   

if Data.AMP2.reflectedPowerSecurityT3
    set(handles.text_cav2_PR3,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_PR3,'BackgroundColor', [1 0 0]); %red
end

if Data.AMP2.reflectedPowerSecurityT4
    set(handles.text_cav2_PR4,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_PR4,'BackgroundColor', [1 0 0]); %red
end



if Data.AMP2.incidentPowerSecurity
    set(handles.text_cav2_PI,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_PI,'BackgroundColor', [1 0 0]); %red
end
    
if Data.AMP2.pssSecurity
    set(handles.text_cav2_PSS,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_PSS,'BackgroundColor', [1 0 0]); %red
end
    
if Data.AMP2.microcontrollerSecurity
    set(handles.text_cav2_uC,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_uC,'BackgroundColor', [1 0 0]); %red
end

if Data.CAV2.interlock
    set(handles.text_cav2_InterLCKmach,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_InterLCKmach,'BackgroundColor', [1 0 0]); %red
end
    
if Data.CAV2.vacuum
    set(handles.text_cav2_VAC,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_VAC,'BackgroundColor', [1 0 0]); %red
end
    
if Data.CAV2.cryo
    set(handles.text_cav2_CRYO,'BackgroundColor', [0 1 0]); %green
else 
    set(handles.text_cav2_CRYO,'BackgroundColor', [1 0 0]); %red
end

axes(handles.graph2);


[NbrColumn,NbrPoint4] = size (Data.PM2.DataHR1);

%//Data.PM2.DataHR1 = -(Data.PM2.DataHR1/5)*10^6;    
%//Data.PM2.DataHR2 = ((0.0361 + 0.2542*Data.PM2.DataHR2 - 0.0112*Data.PM2.DataHR2.^2 + 0.0011*Data.PM2.DataHR2.^3).^2/50)*3.0*10^7; 
%//Data.PM2.DataHR3 = ((0.0361 + 0.2542*Data.PM2.DataHR3 - 0.0112*Data.PM2.DataHR3.^2 + 0.0011*Data.PM2.DataHR3.^3).^2/50)*10.5*10^5;
%//Data.PM2.DataHR4 = (Data.PM2.DataHR4)*10^4;     

hold off;
%hold on; grid on;

pnt=[1:NbrPoint4];

%//pnt1=1:10000;
%//pnt2=1:10000;
        %[haxes,hline1,hline2,hline3]=plotyy(pnt,Data.PM2.DataHR1,pnt,Data.PM2.DataHR2,pnt,Data.PM2.DataHR3);
%[haxes,hline1,hline2]=plotyy(pnt,Data.PM2.DataHR1,pnt,Data.PM2.DataHR2);
%//[haxes,hline1,hline2]=plotyy(pnt1,Data.PM2.DataHR1,pnt2,Data.PM2.DataHR2,'plot');
%//set(hline1,'Color','b');
%//set(hline2,'Color','r');
        %[haxes,hline3,hline4]=plotyy(pnt,Data.PM2.DataHR3,pnt,Data.PM2.DataHR4);
plot(pnt, Data.PM2.DataHR1,'b'); hold on; grid on;
plot(pnt, Data.PM2.DataHR2,'r');
plot(pnt, Data.PM2.DataHR3,'g');
plot(pnt, Data.PM2.DataHR4,'k');
legend('Ac. Rapide CH1: Vcav', 'Ac. Rapide CH2: Pi','Ac. Rapide CH3: Pr','Ac. Rapide CH4: Ib');
    %%legend('Ac. Rapide CH1: Vcav', 'Ac. Rapide CH2: Pi');
xlabel('nombre de points (temps: 1 us par point)');
    %//axes(haxes(1));
    %//axis auto;
    %zoom on; 
    %ylabel('Vcav [V]','Color','b');
    %//ylabel('Vcav [V]');
ylabel('Signal');
    %//LegVcav=legend('Ac. Rapide CH1: Vcav');
    %//set(LegVcav,'Location','NorthWest');
    %set(LegVcav,'background','g');
    %//axes(haxes(2));
    %//axis auto;
    %axes(h,'Color','b');
    %//ylabel('Power [Watts]');
    %//hold on; grid on;
    %//plot(pnt2,Data.PM2.DataHR3,'y');

    %hold on; grid on;
    %//plot(pnt2, Data.PM2.DataHR4,'k');
    %//LegPuissance=legend('Ac. Rapide CH2: Pi','Ac. Rapide CH3: Pr','Ac. Rapide CH4: Ib');
    %legend('Ac. Rapide CH4: Ib');
    %ylabel('Signal');
text(1000,0.5,Data.PM2.triggerTimestamp);
    
    
    %SAVED
    %hold off;
    %pnt=1:10000;
    %plot(pnt, Data.PM2.DataHR1,'b'); hold on; grid on;
    %plot(pnt, Data.PM2.DataHR2,'r');
    %plot(pnt, Data.PM2.DataHR3,'g');
    %plot(pnt, Data.PM2.DataHR4,'k');
    %legend('Ac. Rapide CH1: Vcav', 'Ac. Rapide CH2: Pi','Ac. Rapide CH3: Pr','Ac. Rapide CH4: Ib');
    %text(1000,0.5,Data.PM2.triggerTimestamp);
    %xlabel('nombre de points (temps: 1 us par point)');
    %ylabel('Signal');






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton_cav2_clear.
function pushbutton_cav2_clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cav2_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.graph2);
hold off;
plot(NaN);

set(handles.text_cav2_PR1,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_cav2_PR2,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_cav2_PR3,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_cav2_PR4,'BackgroundColor', [0.702 0.702 0.702]); %gray
    
set(handles.text_cav2_PI,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_cav2_PSS,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_cav2_uC,'BackgroundColor', [0.702 0.702 0.702]); %gray
  
set(handles.text_cav2_InterLCKmach,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_cav2_VAC,'BackgroundColor', [0.702 0.702 0.702]); %gray
set(handles.text_cav2_CRYO,'BackgroundColor', [0.702 0.702 0.702]); %gray

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton_RESET_cav2.
function pushbutton_RESET_cav2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_RESET_cav2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

statusAcquisition_cav2=tango_read_attribute2('ANS-C03/RF/PM.2','Status');
text=statusAcquisition_cav2.value;
if findstr(text, 'running')
    %%set(handles.pushbutton_RESET_cav2,'String','NO need reset, Device is Running');
    msgbox('Un reset a déjà été fait, le device fonctionne Normalement','Info','warn');
    return;
else
    set(handles.pushbutton_RESET_cav2,'Tag','pushbutton_RESET_cav2');
    %tango_command_inout2('ANS-C03/RF/PM.2','Init');
    tango_command_inout2('ANS-C03/RF/PM.2','Start');
    
    fid=0;
    filenameRES='/home/operateur/GrpRF/Nicolas/SUIVIreset';
    %filenameRES='TESTres';
    fid=fopen(filenameRES,'a+');
    %disp (fid);
    %disp ('2');
    %valeurTEST='test11111';
    valeurTEST=datestr(clock,0);
    
    fprintf(fid,'Reset CAV2 at: %s \n',valeurTEST);
    fclose(fid);
end 

%tango_command_inout2('ANS-C03/RF/PM.2','Stop'); %NE PAS OUBLIER D'ENLEVER CETTE LIGNE APRES TEST


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
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



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

valmax=1;
valmin=0;

valminINIT=get(handles.edit5,'String');
valmin=str2num(valminINIT{1});
valmaxINIT=get(handles.edit6,'String');
valmax=str2num(valmaxINIT{1});

n=valmax-valmin+1;
i=1;

global DirectoryNameGlobal;
disp ('DirectoryNameGlobal');
gotodirectory(DirectoryNameGlobal);

global FileNameGlobal;
load(FileNameGlobal, 'Data');   

%//Data.PM2.DataHR1 = -(Data.PM2.DataHR1/5)*10^6;    
%//Data.PM2.DataHR2 = ((0.0361 + 0.2542*Data.PM2.DataHR2 - 0.0112*Data.PM2.DataHR2.^2 + 0.0011*Data.PM2.DataHR2.^3).^2/50)*3.0*10^7; 
%//Data.PM2.DataHR3 = ((0.0361 + 0.2542*Data.PM2.DataHR3 - 0.0112*Data.PM2.DataHR3.^2 + 0.0011*Data.PM2.DataHR3.^3).^2/50)*10.5*10^5;
%//Data.PM2.DataHR4 = (Data.PM2.DataHR4)*10^4;  

for i=1:n
    Data.PM2.DataHR1(valmin+i-1)=-((Data.PM2.DataHR1(valmin+i-1))/5)*10^2;
    Data.PM2.DataHR2(valmin+i-1)=((0.0361 + 0.2542*Data.PM2.DataHR2(valmin+i-1) - 0.0112*Data.PM2.DataHR2(valmin+i-1).^2 + 0.0011*Data.PM2.DataHR2(valmin+i-1).^3).^2/50)*3.0*10^4;
    Data.PM2.DataHR3(valmin+i-1)=((0.0361 + 0.2542*Data.PM2.DataHR3(valmin+i-1) - 0.0112*Data.PM2.DataHR3(valmin+i-1).^2 + 0.0011*Data.PM2.DataHR3(valmin+i-1).^3).^2/50)*10.5*10^2;
    Data.PM2.DataHR4(valmin+i-1)=(Data.PM2.DataHR4(valmin+i-1))*10^2;
end

maxHR1=max(Data.PM2.DataHR1);
maxHR2=max(Data.PM2.DataHR2);
maxHR3=max(Data.PM2.DataHR3);
maxHR4=max(Data.PM2.DataHR4);
minHR1=min(Data.PM2.DataHR1);
minHR2=min(Data.PM2.DataHR2);
minHR3=min(Data.PM2.DataHR3);
minHR4=min(Data.PM2.DataHR4);

if (maxHR2(1)>maxHR3(1))
    max1=maxHR2(1)
else max1=maxHR3(1);
end
if (max1<maxHR4(1))
    max1=maxHR4(1);
end

if (minHR2(1)<minHR3(1))
   min1=minHR2(1)
else min1=minHR3(1);
end
if (min1>minHR4(1))
    min1=minHR4(1);
end

minHR1app=minHR1(1);
maxHR1app=maxHR1(1);

if (minHR1app<min1)
    mini=minHR1
else
    mini=min1
end

if (maxHR1app>max1)
    maxi=maxHR1
else
    maxi=max1
end

axes(handles.graph2);

hold off;
pnt=[valmin:valmax];
axis([valmin valmax mini maxi])
plot(Data.PM2.DataHR1,'b'); hold on; grid on;
axis([valmin valmax mini maxi])
plot(Data.PM2.DataHR2,'r');
plot(Data.PM2.DataHR3,'g');
plot(Data.PM2.DataHR4,'k');
legend('Ac. Rapide CH1: Vcav', 'Ac. Rapide CH2: Pi','Ac. Rapide CH3: Pr','Ac. Rapide CH4: Ib');
xlabel('nombre de points (temps: 1 us par point)');
ylabel('Signal');
text(1000,0.5,Data.PM2.triggerTimestamp);
