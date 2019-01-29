function varargout = Noise_source_GUI_v3(varargin)
% NOISE_SOURCE_GUI_V3 M-file for Noise_source_GUI_v3.fig
%      NOISE_SOURCE_GUI_V3, by itself, creates a new NOISE_SOURCE_GUI_V3 or raises the existing
%      singleton*.
%
%      H = NOISE_SOURCE_GUI_V3 returns the handle to a new NOISE_SOURCE_GUI_V3 or the handle to
%      the existing singleton*.
%
%      NOISE_SOURCE_GUI_V3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOISE_SOURCE_GUI_V3.M with the given input arguments.
%
%      NOISE_SOURCE_GUI_V3('Property','Value',...) creates a new NOISE_SOURCE_GUI_V3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Noise_source_GUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Noise_source_GUI_v3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Noise_source_GUI_v3

% Last Modified by GUIDE v2.5 11-Jul-2016 16:59:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Noise_source_GUI_v3_OpeningFcn, ...
                   'gui_OutputFcn',  @Noise_source_GUI_v3_OutputFcn, ...
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


% --- Executes just before Noise_source_GUI_v3 is made visible.
function Noise_source_GUI_v3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Noise_source_GUI_v3 (see VARARGIN)

% Choose default command line output for Noise_source_GUI_v3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Noise_source_GUI_v3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%Draw lattice
L = getfamilydata('Circumference');
set(handles.Xorbit,'XLim', [0 L]);
set(handles.Zorbit,'XLim', [0 L]);
xlabel(handles.Zorbit,'Distance (m)');

try
    drawlattice(0, 1.1, handles.LatticeAxes);
catch ErrRecord
    set(get(handles.LatticeAxes,'Children'), 'Visible' , 'Off');
end

try
    set(handles.LatticeAxes,'Visible','Off');
    set(handles.LatticeAxes,'Color','None');
    set(handles.LatticeAxes,'XMinorTick','Off');
    set(handles.LatticeAxes,'XMinorGrid','Off');
    set(handles.LatticeAxes,'YMinorTick','Off');
    set(handles.LatticeAxes,'YMinorGrid','Off');
    set(handles.LatticeAxes,'XTickLabel',[]);
    set(handles.LatticeAxes,'YTickLabel',[]);
    set(handles.LatticeAxes,'XLim', [0 L]);
    set(handles.LatticeAxes,'YLim', [-1.5 1.5]);
catch
end

%Initialize time_domain variable
value=get(handles.time_domain,'value');
setappdata(handles.figure1,'time_domain',value);


% --- Outputs from this function are returned to the command line.
function varargout = Noise_source_GUI_v3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

selection=get(handles.listbox1,'value');
ylX=ylim(handles.X_raw_data);
ylZ=ylim(handles.Z_raw_data);
is_time_domain=get(handles.time_domain,'value');
cursor1X=getappdata(handles.figure1,'cursor1X');
cursor1Z=getappdata(handles.figure1,'cursor1Z');
try delete(cursor1X);delete(cursor1Z);
catch
end
if is_time_domain
    time_domain_abscisse=getappdata(handles.figure1, 'time_domain_abscisse');
    cursor1X=plot(handles.X_raw_data,[time_domain_abscisse(selection) time_domain_abscisse(selection)],ylX,'r','LineWidth',3);
    cursor1Z=plot(handles.Z_raw_data,[time_domain_abscisse(selection) time_domain_abscisse(selection)],ylZ,'b','LineWidth',3);
else
    f_bpm=getappdata(handles.figure1, 'f_bpm');
    cursor1X=plot(handles.X_raw_data,[f_bpm(selection) f_bpm(selection)],ylX,'r','LineWidth',3);
    cursor1Z=plot(handles.Z_raw_data,[f_bpm(selection) f_bpm(selection)],ylZ,'b','LineWidth',3);
end
setappdata(handles.figure1,'cursor1X',cursor1X);
setappdata(handles.figure1,'cursor1Z',cursor1Z);
setappdata(handles.figure1,'cursor1_index',selection);

getDefault_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
selection=get(handles.listbox2,'value');
ylX=ylim(handles.X_raw_data);
ylZ=ylim(handles.Z_raw_data);
is_time_domain=get(handles.time_domain,'value');
cursor2X=getappdata(handles.figure1,'cursor2X');
cursor2Z=getappdata(handles.figure1,'cursor2Z');
try delete(cursor2X);delete(cursor2Z);
catch
end
if is_time_domain
    time_domain_abscisse=getappdata(handles.figure1, 'time_domain_abscisse');
    cursor2X=plot(handles.X_raw_data,[time_domain_abscisse(selection) time_domain_abscisse(selection)],ylX,'--r','LineWidth',3);
    cursor2Z=plot(handles.Z_raw_data,[time_domain_abscisse(selection) time_domain_abscisse(selection)],ylZ,'--b','LineWidth',3);
end
setappdata(handles.figure1,'cursor2X',cursor2X);
setappdata(handles.figure1,'cursor2Z',cursor2Z);
setappdata(handles.figure1,'cursor2_index',selection);

getDefault_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in aquisition.
function aquisition_Callback(hObject, eventdata, handles)
% hObject    handle to aquisition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FA_source=get(handles.FA_source,'value');
SA_source=get(handles.SA_source,'value');
DD_source=get(handles.DD_source,'value');

if FA_source
    data_source='FA';
    else if SA_source
        data_source='SA';
        else if DD_source
               data_source='DD';
            else
               data_source='unknown';
            end
        end
end

setappdata(handles.figure1,'data_source',data_source);



%Acquire data
data_aquisition(hObject, eventdata, handles);

%Calculate fft
getfft(hObject, eventdata, handles)

% Display data
data_display(hObject, eventdata, handles)

%remove filename information
set(handles.filename,'visible','off');
set(handles.filename_text,'visible','off');



function data_display(hObject, eventdata, handles)
% hObject    handle to display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.X_raw_data);
cla(handles.Z_raw_data);
cla(handles.Xorbit);
cla(handles.Zorbit);
hold(handles.X_raw_data,'off');
hold(handles.Z_raw_data,'off');

is_time_domain=getappdata(handles.figure1,'time_domain');
fech=getappdata(handles.figure1,'fech');
data_source=getappdata(handles.figure1,'data_source');

current=getappdata(handles.figure1,'current');
set(handles.current_value,'string',num2str(current));

fmin_display=0;

if is_time_domain
    bufferX=getappdata(handles.figure1,'bufferX');
    bufferZ=getappdata(handles.figure1,'bufferZ');
    time_domain_abscisse=getappdata(handles.figure1,'time_domain_abscisse');
    remove_average=get(handles.remove_average,'value');
    

    %remove average
    if remove_average
        for i=1:size(bufferX,1)
            bufferX(i,:)=bufferX(i,:)-mean(bufferX(i,:));
            bufferZ(i,:)=bufferZ(i,:)-mean(bufferZ(i,:));
        end
    end
    
    %plot bufferX
    plot(handles.X_raw_data,time_domain_abscisse,bufferX);
    xlabel(handles.X_raw_data,'Duration (s)','fontsize',10,'fontangle','italic')
    ylabel(handles.X_raw_data,'Position (mm)','fontsize',10,'fontangle','italic')
    title(handles.X_raw_data,'Horizontal position','FontWeight','Bold');
    set(handles.X_raw_data,'XGrid','on','YGrid','on');

    %plot bufferZ
    plot(handles.Z_raw_data,time_domain_abscisse,bufferZ);
    xlabel(handles.Z_raw_data,'Duration (s)','fontsize',10,'fontangle','italic')
    ylabel(handles.Z_raw_data,'Position (mm)','fontsize',10,'fontangle','italic')
    title(handles.Z_raw_data,'Vertical position','FontWeight','Bold');
    set(handles.Z_raw_data,'XGrid','on','YGrid','on');


    for i=1:size(time_domain_abscisse,2)
        list{i}=[num2str(time_domain_abscisse(i),'%10.4f'),' s'];
    end

    %update listbox
    set(handles.listbox1,'value',1);
    set(handles.listbox2,'value',1);
    set(handles.listbox1,'string',list);
    set(handles.listbox2,'string',list);
    
    set(handles.listbox2,'visible','on');
    set(handles.text_listbox2,'visible','on');
    set(handles.text_listbox1,'string','First index selection');
 

else %frequency domain
    f_bpm=getappdata(handles.figure1,'f_bpm');
    mean_xfftamp=getappdata(handles.figure1,'mean_xfftamp');
    mean_zfftamp=getappdata(handles.figure1,'mean_zfftamp');

    switch data_source
        case 'FA'
            fmin_display=0;
            fmax_display=fech/2;
        case 'DD'
            fmin_display=0;
            fmax_display=fech/2;
        case 'SA'
            fmin_display=0;
            fmax_display=fech/2;
    end

    %plot Horizontal averaged spectrum
    semilogy(handles.X_raw_data,f_bpm,mean_xfftamp,'r');
    xlim(handles.X_raw_data,[fmin_display fmax_display]);
    xlabel(handles.X_raw_data,'frequency (Hz)','fontsize',8,'fontangle','italic')
    ylabel(handles.X_raw_data,'Amplitude (mm2/Hz)','fontsize',10,'fontangle','italic')
    title(handles.X_raw_data,'Averaged fft amplitude','FontWeight','Bold');
    set(handles.X_raw_data,'XGrid','on','YGrid','on');

    %plot Vertical averaged spectrum
    semilogy(handles.Z_raw_data,f_bpm,mean_zfftamp,'b');
    xlim(handles.Z_raw_data,[fmin_display fmax_display]);
    xlabel(handles.Z_raw_data,'frequency (Hz)','fontsize',8,'fontangle','italic')
    ylabel(handles.Z_raw_data,'Amplitude (mm2/Hz)','fontsize',10,'fontangle','italic')
    title(handles.Z_raw_data,'Averaged fft amplitude','FontWeight','Bold');
    set(handles.Z_raw_data,'XGrid','on','YGrid','on');

    %update listbox
    for i=1:size(f_bpm,2)
        list{i}=[num2str(f_bpm(i),'%10.2f'),' Hz    X=',num2str(mean_xfftamp(i),'%10.5f'),'    Z=',num2str(mean_zfftamp(i),'%10.5f')];
    end
    set(handles.listbox1,'value',1);
    set(handles.listbox1,'string',list);
    set(handles.listbox2,'visible','off');
    set(handles.text_listbox2,'visible','off');
    set(handles.text_listbox1,'string','Frequency selection');

end

hold(handles.X_raw_data,'on');
hold(handles.Z_raw_data,'on');


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pathname='/home/data/DG/matlab';
[filename, pathname, filterindex] = uigetfile('Noise_source_data*.mat', 'Pick an MAT-file',pathname);
if isequal(filename,0) || isequal(pathname,0)
       disp('Loading cancelled by user')
else
load([pathname filename]);
end

if ~exist('bpm_data')
    %to be compatible with v1
     if exist('decimation')
        %to be compatible with fa_zommer data (sniffer archiever)
        bpm_data.BPM_list=num2str(ids);
        bpm_data.bufferX=squeeze(data(1,:,:));
        bpm_data.bufferZ=squeeze(data(2,:,:));
        bpm_data.fech=abs(f_s);
        bpm_data.current='';
        bpm_data.data_source='FA';
     else
        if ~exist('fech')
        fech=10079;
        end
        %to be compatible with v2
        bpm_data.BPM_list=BPM_list;
        bpm_data.bufferX=bufferX;
        bpm_data.bufferZ=bufferZ;
        bpm_data.fech=fech;
        bpm_data.current='';
        switch fech
            case 10079;
                bpm_data.data_source='FA';
            otherwise
                bpm_data.data_source='DD';
        end
     end 
    bpm_data.cursor1_index=1;
    bpm_data.cursor2_index=1;
    bpm_data.time_domain=1;
   
end

%update app variables
setappdata(handles.figure1,'bufferX',bpm_data.bufferX);
setappdata(handles.figure1,'bufferZ',bpm_data.bufferZ);
% setappdata(handles.figure1,'orbitX',bpm_data.orbitX);
% setappdata(handles.figure1,'orbitZ',bpm_data.orbitZ);
setappdata(handles.figure1,'fech',bpm_data.fech);
setappdata(handles.figure1,'data_source',bpm_data.data_source);
setappdata(handles.figure1,'cursor1_index',bpm_data.cursor1_index);
setappdata(handles.figure1,'cursor2_index',bpm_data.cursor2_index);
setappdata(handles.figure1,'time_domain',bpm_data.time_domain);
setappdata(handles.figure1,'current',bpm_data.current);
time_domain_abscisse=[1:length(bpm_data.bufferX)]./bpm_data.fech;
setappdata(handles.figure1,'time_domain_abscisse',time_domain_abscisse);

%update GUI
switch bpm_data.data_source
    case 'FA';
        set(handles.FA_source,'value',1);
        set(handles.DD_source,'value',0);
        set(handles.SA_source,'value',0);
    case 'DD';
        set(handles.FA_source,'value',0);
        set(handles.DD_source,'value',1);
        set(handles.SA_source,'value',0);
    case 'SA';
        set(handles.FA_source,'value',0);
        set(handles.DD_source,'value',0);
        set(handles.SA_source,'value',1);
end

set(handles.time_domain,'value',bpm_data.time_domain);
set(handles.frequency_domain,'value',not(bpm_data.time_domain));

set(handles.current_value,'string',num2str(bpm_data.current));

%restore filename information
set(handles.filename,'visible','on');
set(handles.filename_text,'visible','on');
set(handles.filename,'string',filename);


%Calculate fft
getfft(hObject, eventdata, handles)

% Display data
data_display(hObject, eventdata, handles)

%apply cursor after data display
set(handles.listbox1,'value',bpm_data.cursor1_index);
set(handles.listbox2,'value',bpm_data.cursor2_index);

% get default to be corrected (defined by cursor(s) position
getDefault_Callback(hObject, eventdata, handles)






% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bpm_data.BPM_list=dev2tangodev('BPMx',family2dev('BPMx'));
bpm_data.bufferX=getappdata(handles.figure1,'bufferX');
bpm_data.bufferZ=getappdata(handles.figure1,'bufferZ');
bpm_data.orbitX=getappdata(handles.figure1,'orbitX');
bpm_data.orbitZ=getappdata(handles.figure1,'orbitZ');
bpm_data.fech=getappdata(handles.figure1,'fech');
bpm_data.data_source=getappdata(handles.figure1,'data_source');
bpm_data.cursor1_index=getappdata(handles.figure1,'cursor1_index');
bpm_data.cursor2_index=getappdata(handles.figure1,'cursor2_index');
bpm_data.time_domain=getappdata(handles.figure1,'time_domain');
bpm_data.current=getappdata(handles.figure1,'current');



clk=clock;
year=num2str(clk(1));
month=num2str(clk(2),'%.2d');
day=num2str(clk(3),'%.2d');
hour=[num2str(clk(4),'%.2d'),'h'];
min=[num2str(clk(5),'%.2d'),'mn'];
date=['_',year,'_',month,'_',day,'_',hour,'_',min];
filename=['/home/data/DG/matlab/Noise_source_data',date,'.mat'];

uisave('bpm_data',filename)

%restore filename information
set(handles.filename,'visible','on');
set(handles.filename_text,'visible','on');
set(handles.filename,'string',filename);
        

% --- Executes on button press in frequency_domain.
function frequency_domain_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_domain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frequency_domain
value=get(handles.frequency_domain,'value');
set(handles.time_domain,'value',not(value));
setappdata(handles.figure1,'time_domain',not(value));
if value
    set(handles.listbox2,'visible','off');
    set(handles.text_listbox2,'visible','off');
    set(handles.text_listbox1,'string','Frequency selection');
    set(handles.remove_average,'visible','off');
else
    set(handles.listbox2,'visible','on');
    set(handles.text_listbox2,'visible','on');
    set(handles.text_listbox1,'string','First index selection');
    set(handles.remove_average,'visible','on');
end

data_display(hObject, eventdata, handles);


% --- Executes on button press in time_domain.
function time_domain_Callback(hObject, eventdata, handles)
% hObject    handle to time_domain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of time_domain
value=get(handles.time_domain,'value');
set(handles.frequency_domain,'value',not(value));
setappdata(handles.figure1,'time_domain',value);
if value
    set(handles.listbox2,'visible','on');
    set(handles.text_listbox2,'visible','on');
    set(handles.text_listbox1,'string','First index selection');
    set(handles.remove_average,'visible','on');
else
    set(handles.listbox2,'visible','off');
    set(handles.text_listbox2,'visible','off');
    set(handles.text_listbox1,'string','Frequency selection');
    set(handles.remove_average,'visible','off');
end
data_display(hObject, eventdata, handles);

function data_aquisition(hObject, eventdata, handles)
% hObject    handle to aquisition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_source=getappdata(handles.figure1,'data_source')
switch data_source
    case 'FA'
         BPM_list=dev2tangodev('BPMx',family2dev('BPMx'));
         Nbpm=size(BPM_list,1);

        dev='ANS/DG/fofb-sniffer.2';
        fech=10079;
        
        buff_length = INPUTDLG('Enter FA buffer length to record in seconds','FA Acquisition',1,{'1'}); 
        if isempty(buff_length)
            fprintf('FA Acquisition cancelled by user')
            return
        else
            buffer_length=str2num(buff_length{1});
        end

        tic
        h1=waitbar(0,'please wait...');
        tango_write_attribute2(dev,'recordLengthInSecs',buffer_length)
        pause(1)
        record_length=tango_read_attribute2(dev,'recordLengthInSecs');
        for i=1:buffer_length+2
            pause(1)
            waitbar(i/buffer_length,h1);
        end
        data_record_time=toc;
        fprintf('data record time = %f seconds\n',toc)

        tic
        for j=1:1:Nbpm
            bufferX(j,:)=double(tango_command_inout2(dev,'GetXPosData',uint16((j))))./1e6;%FA raw data are in nm
            bufferZ(j,:)=double(tango_command_inout2(dev,'GetZPosData',uint16((j))))./1e6;
         end
        data_reading_time=toc;
        fprintf('data download time = %f seconds\n',toc)
        close(h1)


    case 'DD'
        h=warndlg(sprintf('Avez-vous vérifiez la configuration des BPMs? \n - switching OFF (position3) \n - DDBufferLenght identique sur tous les BPMs \n\n Le programme va relire les données DD actuellement présentes sur les BPMs\n OK pour continuer'));
        uiwait(h); 
        fech=getrf/416*1e6

        result=getbpmrawdata([],'bpm_data');
        Nbpm=size(result.DeviceList,1);

        bufferX=result.Data.X;%DD raw data are in mm
        bufferZ=result.Data.Z;

    case 'SA'
        h=warndlg(sprintf('Le programme va relire les 2 dernières minutes de données SA actuellement présentes sur les BPMs\n OK pour continuer'));
        uiwait(h); 
        fech=10

        result=getbpmgroupSAhistory;
        Nbpm=size(result.Data.X,1);
 
        bufferX=result.Data.X;%SA raw data are in mm
        bufferZ=result.Data.Z;
      
end
result=tango_read_attribute2('ANS/DG/DCCT-CTRL','current');
setappdata(handles.figure1,'current',result.value);
time_domain_abscisse=[1:length(bufferX)]./fech;
setappdata(handles.figure1,'time_domain_abscisse',time_domain_abscisse);
setappdata(handles.figure1,'fech',fech);
setappdata(handles.figure1,'bufferX',bufferX);
setappdata(handles.figure1,'bufferZ',bufferZ);


% --- Executes on button press in FA_source.
function FA_source_Callback(hObject, eventdata, handles)
% hObject    handle to FA_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FA_source
value=get(handles.FA_source,'value');
set(handles.DD_source,'value',not(value));
set(handles.SA_source,'value',not(value));


% --- Executes on button press in DD_source.
function DD_source_Callback(hObject, eventdata, handles)
% hObject    handle to DD_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DD_source
value=get(handles.DD_source,'value');
set(handles.FA_source,'value',not(value));
set(handles.SA_source,'value',not(value));

% --- Executes on button press in SA_source.
function SA_source_Callback(hObject, eventdata, handles)
% hObject    handle to SA_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SA_source
value=get(handles.SA_source,'value');
set(handles.FA_source,'value',not(value));
set(handles.DD_source,'value',not(value));


% --- Executes on button press in MEC_calculation.
function MEC_calculation_Callback(hObject, eventdata, handles)
% hObject    handle to MEC_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hwait=waitbar(0,'processing...');

FHCORspos = getspos('FHCOR',family2dev('FHCOR'));
FVCORspos = getspos('FVCOR',family2dev('FVCOR'));
HCORspos = getspos('HCOR',family2dev('HCOR'));
VCORspos = getspos('VCOR',family2dev('VCOR'));
BPMspos = getspos('BPMx',family2dev('BPMx'));
BPM_list=dev2tangodev('BPMx',family2dev('BPMx'));
Nbpm=size(BPM_list,1);
RF=1;

selection=get(handles.listbox1,'value')

orbitX=getappdata(handles.figure1,'orbitX');
orbitZ=getappdata(handles.figure1,'orbitZ');


waitbar(1/5,hwait);
[strength_SX,corr_orbit_SX,idx_sx,eff_SX]=mosteffectivecorrector2(orbitX,'HCOR',RF);
waitbar(2/5,hwait);
[strength_SZ,corr_orbit_SZ,idx_sz,eff_SZ]=mosteffectivecorrector2(orbitZ,'VCOR',RF);
waitbar(3/5,hwait);
[strength_FX,corr_orbit_FX,idx_fx,eff_FX]=mosteffectivecorrector2(orbitX,'FHCOR',RF);
waitbar(4/5,hwait);
[strength_FZ,corr_orbit_FZ,idx_fz,eff_FZ]=mosteffectivecorrector2(orbitZ,'FVCOR',RF);
waitbar(5/5,hwait);

max_fast_X=max(abs(strength_FX));
max_fast_Z=max(abs(strength_FZ));
max_slow_X=max(abs(strength_SX));
max_slow_Z=max(abs(strength_SZ));

%Normalize to 1
strength_SX=strength_SX./max_slow_X;
strength_SZ=strength_SZ./max_slow_Z;
strength_FX=strength_FX./max_fast_X;
strength_FZ=strength_FZ./max_fast_Z;

hfigX=figure
set(hfigX,'Position',[0 800 800 600])
h1=subplot(3,1,1)
plot(BPMspos,orbitX,'r','Linewidth',3)
set(h1,'XGrid','on','YGrid','on');
hold(h1,'on')
plot(BPMspos,corr_orbit_SX,'k','Linewidth',2)
plot(BPMspos,corr_orbit_FX,'Color',[0 0.6 0],'Linewidth',2)
hold(h1,'off')
xlabel('position (meters)','fontsize',10,'fontangle','italic')
title('Horizontal orbit default to be corrected','FontWeight','Bold');
legend2=['HCOR [',num2str(idx_sx),']'];
legend3=['FHCOR [',num2str(idx_fx),']'];
legend('Xorbit',legend2,legend3);

h2=subplot(3,1,2)
bar(HCORspos,eff_SX(1:size(eff_SX,2)-1),1,'k')
hold(h2,'on')
bar(FHCORspos,eff_FX(1:size(eff_FX,2)-1),0.6,'FaceColor',[0 0.6 0])
plot([HCORspos(1) HCORspos(length(HCORspos))],[eff_SX(size(eff_SX,2)) eff_SX(size(eff_SX,2))],'m')
ylim([0 100]);
title('Horizontal correctors efficiency to correct selected default','FontWeight','Bold');
set(h2,'XGrid','on','YGrid','on');
xlabel('position (meters)','fontsize',10,'fontangle','italic')
ylabel('reduction efficyency (%)','fontsize',10,'fontangle','italic')
text1=['HCOR [MEC=',num2str(idx_sx),']'];
text2=['FHCOR [MEC=',num2str(idx_fx),']'];
text3=['RF'];
legend(text1,text2,text3);
hold(h2,'off')

h3=subplot(3,1,3)
bar(HCORspos,strength_SX(1:size(strength_SX,1)-1),1,'k')
hold(h3,'on')
bar(FHCORspos,strength_FX(1:size(strength_FX,1)-1),0.6,'FaceColor',[0 0.6 0])
hold(h3,'off')
ylim([-1 1]);
title('Horizontal correctors strength to correct selected default','FontWeight','Bold');
set(h3,'XGrid','on','YGrid','on');
xlabel('position (meters)','fontsize',10,'fontangle','italic')
ylabel('strength (normalized to 1)','fontsize',10,'fontangle','italic')
text2=['FHCOR [',num2str(idx_fx),']'];
text1=['HCOR [',num2str(idx_sx),']'];
legend(text1,text2);


% bar(handles.RFCOR,1,strength_SX(size(strength_SX,2)),'g')
% ylim(handles.RFCOR,[-1 1]);
% xlim(handles.RFCOR,[0 2]);
% set(handles.RFCOR,'XGrid','on','YGrid','on');
% legend(handles.RFCOR,'RF');

hfigZ=figure
set(hfigZ,'Position',[500 40 800 600])
h1=subplot(3,1,1)
plot(BPMspos,orbitZ,'r','Linewidth',3)
set(h1,'XGrid','on','YGrid','on');
hold(h1,'on')
plot(BPMspos,corr_orbit_SZ,'k','Linewidth',2)
plot(BPMspos,corr_orbit_FZ,'Color',[0 0.6 0],'Linewidth',2)
hold(h1,'off')
xlabel('position (meters)','fontsize',10,'fontangle','italic')
title('Vertical orbit default to be corrected','FontWeight','Bold');
legend2=['HCOR [',num2str(idx_sz),']'];
legend3=['FHCOR [',num2str(idx_fz),']'];
legend('Xorbit',legend2,legend3);

h2=subplot(3,1,2)
bar(VCORspos,eff_SZ,1,'k')
hold(h2,'on')
bar(FVCORspos,eff_FZ,0.6,'FaceColor',[0 0.6 0])
ylim([0 100]);
title('Vertical correctors efficiency to correct selected default','FontWeight','Bold');
set(h2,'XGrid','on','YGrid','on');
xlabel('position (meters)','fontsize',10,'fontangle','italic')
ylabel('reduction efficyency (%)','fontsize',10,'fontangle','italic')
text1=['HCOR [MEC=',num2str(idx_sz),']'];
text2=['FHCOR [MEC=',num2str(idx_fz),']'];
legend(text1,text2);
hold(h2,'off')

h3=subplot(3,1,3)
bar(VCORspos,strength_SZ,1,'k')
hold(h3,'on')
bar(FVCORspos,strength_FZ,0.6,'FaceColor',[0 0.6 0])
hold(h3,'off')
ylim([-1 1]);
title('Vertical correctors strength to correct selected default','FontWeight','Bold');
set(h3,'XGrid','on','YGrid','on');
xlabel('position (meters)','fontsize',10,'fontangle','italic')
ylabel('strength (normalized to 1)','fontsize',10,'fontangle','italic')
text2=['FHCOR [',num2str(idx_fz),']'];
text1=['HCOR [',num2str(idx_sz),']'];
legend(text1,text2);



% plot(handles.Zorbit,BPMspos,orbitZ,'k','Linewidth',2)
% set(handles.Zorbit,'XGrid','on','YGrid','on');
% hold(handles.Zorbit,'on')
% plot(handles.Zorbit,BPMspos,corr_orbit_SZ,'b')
% plot(handles.Zorbit,BPMspos,corr_orbit_FZ,'r')
% hold(handles.Zorbit,'off')
% xlabel(handles.Zorbit,'position (meters)','fontsize',8,'fontangle','italic')
% title(handles.Zorbit,'Vertical orbit at selected frequency','FontWeight','Bold');
% legend2=['VCOR [',num2str(idx_sz),']'];
% legend3=['FVCOR [',num2str(idx_fz),']'];
% legend(handles.Zorbit,'Zorbit',legend2,legend3);
% 
% % bar(VCORspos,eff_SZ,1,'b')
% set('XGrid','on','YGrid','on');
% hold('on')
% bar(FVCORspos,eff_FZ,0.6,'r')
% hold('off')
% ylim([0 100]);
% xlabel('position (meters)','fontsize',8,'fontangle','italic')
% title('Vertical correctors response to correct selected frequency','FontWeight','Bold');
% legend2=['FVCOR [',num2str(idx_fz),']'];
% legend1=['VCOR [',num2str(idx_sz),']'];
% legend(legend1,legend2);

% bar(VCORspos,strength_SZ,1,'b')
% set('XGrid','on','YGrid','on');
% hold('on')
% bar(FVCORspos,strength_FZ,0.6,'r')
% hold('off')
% ylim([-1 1]);
% xlabel('position (meters)','fontsize',8,'fontangle','italic')
% title('Vertical correctors response to correct selected frequency','FontWeight','Bold');
% legend2=['FVCOR [',num2str(idx_fz),']'];
% legend1=['VCOR [',num2str(idx_sz),']'];
% legend(legend1,legend2); 

% x_scale=get(handles.X_raw_data,'xlim');
% 
% 
% setappdata(handles.figure1,'strength_SX',strength_SX)
% setappdata(handles.figure1,'strength_SZ',strength_SZ)
% setappdata(handles.figure1,'strength_FX',strength_FX)
% setappdata(handles.figure1,'strength_FZ',strength_FZ)
% setappdata(handles.figure1,'eff_SX',eff_SX)
% setappdata(handles.figure1,'eff_FX',eff_FX)
% setappdata(handles.figure1,'eff_SZ',eff_SZ)
% setappdata(handles.figure1,'eff_FZ',eff_FZ)
% setappdata(handles.figure1,'idx_sx',idx_sx)
% setappdata(handles.figure1,'idx_fx',idx_fx)
% setappdata(handles.figure1,'idx_sz',idx_sz)
% setappdata(handles.figure1,'idx_fz',idx_fz)
% setappdata(handles.figure1,'orbitX',orbitX)
% setappdata(handles.figure1,'orbitZ',orbitZ)
% setappdata(handles.figure1,'BPM_list',BPM_list)
% 
% set(handles.save_orbit,'Enable','on');

close(hwait)



% --- Executes on button press in remove_average.
function remove_average_Callback(hObject, eventdata, handles)
% hObject    handle to remove_average (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of remove_average

data_display(hObject, eventdata, handles);


% --- Executes on button press in getDefault.
function getDefault_Callback(hObject, eventdata, handles)
% hObject    handle to getDefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

is_time_domain=get(handles.time_domain,'value');

if is_time_domain
    selection1=get(handles.listbox1,'value');
    selection2=get(handles.listbox2,'value');
    bufferX=getappdata(handles.figure1,'bufferX');
    bufferZ=getappdata(handles.figure1,'bufferZ');
    orbitX=bufferX(:,selection2)-bufferX(:,selection1);
    orbitZ=bufferZ(:,selection2)-bufferZ(:,selection1);  
    ylabeltext='amplitude(mm)';
else
    selection=get(handles.listbox1,'value');
    xfftamp=getappdata(handles.figure1,'xfftamp');
    xfftphase=getappdata(handles.figure1,'xfftphase');
    zfftamp=getappdata(handles.figure1,'zfftamp');
    zfftphase=getappdata(handles.figure1,'zfftphase');
    f_bpm=getappdata(handles.figure1,'f_bpm');
    mean_xfftamp=getappdata(handles.figure1,'mean_xfftamp');
    mean_zfftamp=getappdata(handles.figure1,'mean_zfftamp');
    orbitX=xfftamp(:,selection).*sign(xfftphase(:,selection));
    orbitZ=zfftamp(:,selection).*sign(zfftphase(:,selection));  
    ylabeltext='amplitude (arbitrary)';
end

plot(handles.Xorbit,getspos('BPMx'),orbitX,'r','Linewidth',3);
ylabel(handles.Xorbit,ylabeltext,'fontsize',10,'fontangle','italic')
title(handles.Xorbit,'Horizontal Default','FontWeight','Bold');
set(handles.Xorbit,'XGrid','on','YGrid','on');

plot(handles.Zorbit,getspos('BPMz'),orbitZ,'b','Linewidth',3);
xlabel(handles.Zorbit,'Position (m)','fontsize',10,'fontangle','italic')
ylabel(handles.Zorbit,ylabeltext,'fontsize',10,'fontangle','italic')
title(handles.Zorbit,'Vertical Default','FontWeight','Bold');
set(handles.Zorbit,'XGrid','on','YGrid','on');

setappdata(handles.figure1,'orbitX',orbitX);
setappdata(handles.figure1,'orbitZ',orbitZ);


% --- calculate fft
function getfft(hObject, eventdata, handles)

fech=getappdata(handles.figure1,'fech');
bufferX=getappdata(handles.figure1,'bufferX');
bufferZ=getappdata(handles.figure1,'bufferZ');

tic
[xfftamp,zfftamp,xfftphase,zfftphase,f_bpm]=fft_amp_phase_calcul(bufferX,bufferZ,fech);
fft_computation_time=toc;
fprintf('fft computation time = %f seconds\n',toc)

setappdata(handles.figure1,'xfftamp',xfftamp);
setappdata(handles.figure1,'xfftphase',xfftphase);
setappdata(handles.figure1,'zfftamp',zfftamp);
setappdata(handles.figure1,'zfftphase',zfftphase);
setappdata(handles.figure1,'f_bpm',f_bpm);
setappdata(handles.figure1,'mean_xfftamp',mean(xfftamp(:,:)));
setappdata(handles.figure1,'mean_zfftamp',mean(zfftamp(:,:)));



function filename_Callback(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename as text
%        str2double(get(hObject,'String')) returns contents of filename as a double


% --- Executes during object creation, after setting all properties.
function filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function current_value_Callback(hObject, eventdata, handles)
% hObject    handle to current_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of current_value as text
%        str2double(get(hObject,'String')) returns contents of current_value as a double


% --- Executes during object creation, after setting all properties.
function current_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to current_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
