function varargout = Comparaison_enregistrements(varargin)
% COMPARAISON_ENREGISTREMENTS M-file for Comparaison_enregistrements.fig
%      COMPARAISON_ENREGISTREMENTS, by itself, creates a new COMPARAISON_ENREGISTREMENTS or raises the existing
%      singleton*.
%
%      H = COMPARAISON_ENREGISTREMENTS returns the handle to a new COMPARAISON_ENREGISTREMENTS or the handle to
%      the existing singleton*.
%
%      COMPARAISON_ENREGISTREMENTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPARAISON_ENREGISTREMENTS.M with the given input arguments.
%
%      COMPARAISON_ENREGISTREMENTS('Property','Value',...) creates a new COMPARAISON_ENREGISTREMENTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Comparaison_enregistrements_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Comparaison_enregistrements_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Comparaison_enregistrements

% Last Modified by GUIDE v2.5 15-Nov-2012 09:10:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Comparaison_enregistrements_OpeningFcn, ...
                   'gui_OutputFcn',  @Comparaison_enregistrements_OutputFcn, ...
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


% --- Executes just before Comparaison_enregistrements is made visible.
function Comparaison_enregistrements_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Comparaison_enregistrements (see VARARGIN)

% Choose default command line output for Comparaison_enregistrements
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Comparaison_enregistrements wait for user response (see UIRESUME)
% uiwait(handles.figure1);
pathname= getfamilydata('Directory', 'DG');
setappdata(handles.figure1,'pathname',pathname);

% --- Outputs from this function are returned to the command line.
function varargout = Comparaison_enregistrements_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load1.
function load1_Callback(hObject, eventdata, handles)
% hObject    handle to load1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathname=getappdata(handles.figure1,'pathname');
[filename, pathname, filterindex] = uigetfile('*.mat', 'Pick an MAT-file',pathname);
if isequal(filename,0) || isequal(pathname,0)
       disp('Loading cancelled by user')
else
    setappdata(handles.figure1,'pathname',pathname);
    set(handles.courbe1,'string',[pathname filename]);
    load([pathname filename],'bufferX','bufferZ','BPM_list');
    
        
    [selection ok]=listdlg('liststring',BPM_list,'Name','Select BPM(s)');
    if ok
        amplitude=max(bufferX(selection(1),:))-min(bufferX(selection(1),:))
        if amplitude<500
            figure
            subplot(2,1,1)
            plot(bufferX(selection(1),:));
            subplot(2,1,2)
            plot(bufferZ(selection(1),:));
            ButtonName = questdlg('Data loaded seems to be in µm and must be converted to nm', ...
                         'Warning', ...
                         'Convert', 'Ignore','Convert');
            switch ButtonName,
            case 'Convert',
                bufferX=bufferX.*1000;
                bufferZ=bufferZ.*1000;
            case 'Ignore',
  

            end % switch
        end
        N_BPM=size(BPM_list,1);
        %Nsamples=size(bufferX(j,:),2);
        fech=10079;
        index=regexp(filename,'_');
        filename(index)=' ';
        struct1.filename=filename;
        struct1.pathname=pathname;
        struct1.BPM_list=BPM_list(selection);
        tic
        [pxfftaff_all,pzfftaff_all,Xintegrale_all,Zintegrale_all,f_bpm]=fft_and_noise_calcul_group(bufferX,bufferZ,fech);
        toc
        struct1.f_bpm=f_bpm;
        struct1.Xintegrale_all=Xintegrale_all(selection,2:size(Xintegrale_all,2));
        struct1.Zintegrale_all=Zintegrale_all(selection,2:size(Zintegrale_all,2));
        struct1.pxfftaff_all=pxfftaff_all(selection,2:size(pxfftaff_all,2));
        struct1.pzfftaff_all=pzfftaff_all(selection,2:size(pzfftaff_all,2));
          if size(selection,2)==1
            struct1.Xintegrale_mean=(struct1.Xintegrale_all(:,:));
            struct1.Zintegrale_mean=(struct1.Zintegrale_all(:,:));
            struct1.pxfftaff_mean=(struct1.pxfftaff_all(:,:));
            struct1.pzfftaff_mean=(struct1.pzfftaff_all(:,:));
          else
            struct1.Xintegrale_mean=mean(struct1.Xintegrale_all(:,:));
            struct1.Zintegrale_mean=mean(struct1.Zintegrale_all(:,:));
            struct1.pxfftaff_mean=mean(struct1.pxfftaff_all(:,:));
            struct1.pzfftaff_mean=mean(struct1.pzfftaff_all(:,:));
          end
        setappdata(handles.figure1,'struct1',struct1);
        struct2=getappdata(handles.figure1,'struct2');

        affichage(hObject, eventdata, handles);
    end
end



    
% --- Executes on button press in load2.
function load2_Callback(hObject, eventdata, handles)
% hObject    handle to load2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathname=getappdata(handles.figure1,'pathname');
[filename, pathname, filterindex] = uigetfile('*.mat', 'Pick an MAT-file',pathname);
if isequal(filename,0) || isequal(pathname,0)
       disp('Loading cancelled by user')
else
    setappdata(handles.figure1,'pathname',pathname);
    set(handles.courbe2,'string',[pathname filename]);
    load([pathname filename],'bufferX','bufferZ','BPM_list');
    
        
    [selection ok]=listdlg('liststring',BPM_list,'Name','Select BPM(s)');
    if ok
        N_BPM=size(BPM_list,1);
        %Nsamples=size(bufferX(j,:),2);
        fech=10079;
        index=regexp(filename,'_');
        filename(index)=' ';
        struct2.filename=filename;
        struct2.pathname=pathname;
        struct2.BPM_list=BPM_list(selection);
        tic
        [pxfftaff_all,pzfftaff_all,Xintegrale_all,Zintegrale_all,f_bpm]=fft_and_noise_calcul_group(bufferX,bufferZ,fech);
        toc
        struct2.f_bpm=f_bpm;
        struct2.Xintegrale_all=Xintegrale_all(selection,2:size(Xintegrale_all,2));
        struct2.Zintegrale_all=Zintegrale_all(selection,2:size(Zintegrale_all,2));
        struct2.pxfftaff_all=pxfftaff_all(selection,2:size(pxfftaff_all,2));
        struct2.pzfftaff_all=pzfftaff_all(selection,2:size(pzfftaff_all,2));
        if size(selection)==1
            struct2.Xintegrale_mean=(struct2.Xintegrale_all(:,:));
            struct2.Zintegrale_mean=(struct2.Zintegrale_all(:,:));
            struct2.pxfftaff_mean=(struct2.pxfftaff_all(:,:));
            struct2.pzfftaff_mean=(struct2.pzfftaff_all(:,:));
        else
            struct2.Xintegrale_mean=mean(struct2.Xintegrale_all(:,:));
            struct2.Zintegrale_mean=mean(struct2.Zintegrale_all(:,:));
            struct2.pxfftaff_mean=mean(struct2.pxfftaff_all(:,:));
            struct2.pzfftaff_mean=mean(struct2.pzfftaff_all(:,:));
        end
        setappdata(handles.figure1,'struct2',struct2);
        struct1=getappdata(handles.figure1,'struct1');

        affichage(hObject, eventdata, handles);
    end
end

% --- Executes on selection change in plan.
function plan_Callback(hObject, eventdata, handles)
% hObject    handle to plan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plan contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plan
affichage(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function plan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fstart_Callback(hObject, eventdata, handles)
% hObject    handle to fstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fstart as text
%        str2double(get(hObject,'String')) returns contents of fstart as a double
affichage(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function fstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fstop_Callback(hObject, eventdata, handles)
% hObject    handle to fstop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fstop as text
%        str2double(get(hObject,'String')) returns contents of fstop as a double
affichage(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function fstop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fstop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function affichage(hObject, eventdata, handles)


struct1=getappdata(handles.figure1,'struct1');
struct2=getappdata(handles.figure1,'struct2');

plan=get(handles.plan,'value');
fstart=str2num(get(handles.fstart,'string'));
fstop=str2num(get(handles.fstop,'string'));
bruit_integre1=0;
bruit_integre2=0;
filename1='';
filename2='';
log_x_axis=get(handles.log_x_axis,'value');
autoscale_y_axis=get(handles.autoscale_y_axis,'value');

if plan==1
    if isempty(struct1)==0
        set(handles.courbe1,'string',[struct1.pathname struct1.filename]);
        if log_x_axis
            loglog(handles.spectre,struct1.f_bpm,struct1.pxfftaff_mean,'b','LineWidth',2);
            loglog(handles.bruit,struct1.f_bpm,struct1.Xintegrale_mean,'b','LineWidth',3);
        else
            semilogy(handles.spectre,struct1.f_bpm,struct1.pxfftaff_mean,'b','LineWidth',2);
            semilogy(handles.bruit,struct1.f_bpm,struct1.Xintegrale_mean,'b','LineWidth',3);
        end 
        hold(handles.spectre,'on');             
        hold(handles.bruit,'on');
        filename1=struct1.filename;
        index=find(struct1.f_bpm>fstop);
        bruit_integre1=struct1.Xintegrale_mean(index(1));
    end
    if isempty(struct2)==0
        set(handles.courbe2,'string',[struct2.pathname struct2.filename]);
    if  log_x_axis
        loglog(handles.spectre,struct2.f_bpm,struct2.pxfftaff_mean,'r','LineWidth',2);
        loglog(handles.bruit,struct2.f_bpm,struct2.Xintegrale_mean,'r','LineWidth',3);
    else
        semilogy(handles.spectre,struct2.f_bpm,struct2.pxfftaff_mean,'r','LineWidth',2);
        semilogy(handles.bruit,struct2.f_bpm,struct2.Xintegrale_mean,'r','LineWidth',3);
    end
        filename2=struct2.filename;
        index=find(struct2.f_bpm>fstop);
        bruit_integre2=struct2.Xintegrale_mean(index(1));
     end
else
    if isempty(struct1)==0
        if log_x_axis
            loglog(handles.spectre,struct1.f_bpm,struct1.pzfftaff_mean,'b','LineWidth',2);
            loglog(handles.bruit,struct1.f_bpm,struct1.Zintegrale_mean,'b','LineWidth',3);
        else
            semilogy(handles.spectre,struct1.f_bpm,struct1.pzfftaff_mean,'b','LineWidth',2);
            semilogy(handles.bruit,struct1.f_bpm,struct1.Zintegrale_mean,'b','LineWidth',3);
        end
        hold(handles.spectre,'on');
        hold(handles.bruit,'on');
        filename1=struct1.filename;
        index=find(struct1.f_bpm>fstop);
        bruit_integre1=struct1.Zintegrale_mean(index(1));
     end
    if isempty(struct2)==0
        if log_x_axis
            loglog(handles.spectre,struct2.f_bpm,struct2.pzfftaff_mean,'r','LineWidth',2);
            loglog(handles.bruit,struct2.f_bpm,struct2.Zintegrale_mean,'r','LineWidth',3);
        else
            semilogy(handles.spectre,struct2.f_bpm,struct2.pzfftaff_mean,'r','LineWidth',2);
            semilogy(handles.bruit,struct2.f_bpm,struct2.Zintegrale_mean,'r','LineWidth',3);
        
        end
        filename2=struct2.filename;
        index=find(struct2.f_bpm>fstop);
        bruit_integre2=struct2.Zintegrale_mean(index(1));
     end
end
%x axis
xlim(handles.spectre,[fstart fstop]);
xlim(handles.bruit,[fstart fstop]);
xlabel(handles.spectre,'frequency (Hz)','fontsize',16,'fontangle','italic','FontWeight','Bold');
xlabel(handles.bruit,'frequency (Hz)','fontsize',16,'fontangle','italic','FontWeight','Bold');

%y axis
if ~autoscale_y_axis
    ylim(handles.spectre,[10^-3 10^3]);
    ylim(handles.bruit,[2*10^-3 10^2]);
end
ylabel(handles.spectre,'µm/sqrt(Hz)','FontWeight','Bold');
ylabel(handles.bruit,'µm','FontWeight','Bold');

title(handles.spectre,'Averaged fft amplitude','FontWeight','Bold');
legend(handles.spectre,filename1,filename2);
set(handles.spectre,'XGrid','on','YGrid','on');
hold(handles.spectre,'off');

title(handles.bruit,'Averaged noise','FontWeight','Bold');
legend(handles.bruit,[num2str(bruit_integre1),' µm'],[num2str(bruit_integre2),' µm'],'Location','SouthEast');
set(handles.bruit,'XGrid','on','YGrid','on');
hold(handles.bruit,'off');

% figure
% loglog(struct1.f_bpm,struct1.pxfftaff_mean,'r--','LineWidth',2);
% hold on; 
% loglog(struct2.f_bpm,struct2.pxfftaff_mean,'r','LineWidth',2);      
% loglog(struct1.f_bpm,struct1.pzfftaff_mean,'b--','LineWidth',2);
% loglog(struct1.f_bpm,struct2.pzfftaff_mean,'b','LineWidth',2);
%   
% figure
% loglog(struct1.f_bpm,struct1.Xintegrale_mean,'r--','LineWidth',3);
% hold on;
% loglog(struct2.f_bpm,struct2.Xintegrale_mean,'r','LineWidth',3);
% loglog(struct1.f_bpm,struct1.Zintegrale_mean,'b--','LineWidth',3);
% loglog(struct1.f_bpm,struct2.Zintegrale_mean,'b','LineWidth',3);



        
% --- Executes on button press in measure.
function measure_Callback(hObject, eventdata, handles)
% hObject    handle to measure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%spectres_GUI
record_length=str2num(get(handles.record_length,'string'));
save2xls=0;
fmin=str2num(get(handles.fstart,'string'));
fmax=str2num(get(handles.fstop,'string'));
source=get(handles.source,'value');
switch source
    case 1
       [BPM_list bufferX bufferZ pxfftaff_all pzfftaff_all Xintegrale_all Zintegrale_all f_bpm]=Compute_FFT_on_FA_data(record_length,fmin,fmax,save2xls);
    case 2
        %Compute_FFT_on_XBPM_data(fmin,fmax,save2xls);
        warndlg('Record on XBPM disabled at the moment', 'Warning');
    case 3  
        %Compute_FFT_on_Libera_Photon_FA_data(fmin,fmax,save2xls);
        warndlg('Record on Libera Photon disabled at the moment', 'Warning');
end
ButtonName = questdlg('Do you want to display this measurement?', 'Display', 'Plot1', 'Plot2','No', 'No');
switch ButtonName
    case 'Plot1'
        N_BPM=size(BPM_list,1);
        %index=regexp(filename,'_');
        %filename(index)=' ';
        %struct1.filename=filename;
        %struct1.pathname=pathname;
        struct1.filename='unknown';
        struct1.pathname='unknown';
        struct1.BPM_list=BPM_list;
        struct1.f_bpm=f_bpm;
        struct1.Xintegrale_all=Xintegrale_all(:,2:size(Xintegrale_all,2));
        struct1.Zintegrale_all=Zintegrale_all(:,2:size(Zintegrale_all,2));
        struct1.pxfftaff_all=pxfftaff_all(:,2:size(pxfftaff_all,2));
        struct1.pzfftaff_all=pzfftaff_all(:,2:size(pzfftaff_all,2));
          if N_BPM==1
            struct1.Xintegrale_mean=(struct1.Xintegrale_all(:,:));
            struct1.Zintegrale_mean=(struct1.Zintegrale_all(:,:));
            struct1.pxfftaff_mean=(struct1.pxfftaff_all(:,:));
            struct1.pzfftaff_mean=(struct1.pzfftaff_all(:,:));
          else
            struct1.Xintegrale_mean=mean(struct1.Xintegrale_all(:,:));
            struct1.Zintegrale_mean=mean(struct1.Zintegrale_all(:,:));
            struct1.pxfftaff_mean=mean(struct1.pxfftaff_all(:,:));
            struct1.pzfftaff_mean=mean(struct1.pzfftaff_all(:,:));
          end
            setappdata(handles.figure1,'struct1',struct1);
    case 'Plot2'
        N_BPM=size(BPM_list,1);
        %index=regexp(filename,'_');
        %filename(index)=' ';
        %struct2.filename=filename;
        %struct2.pathname=pathname;
        struct2.filename='unknown';
        struct2.pathname='unknown';
        struct2.BPM_list=BPM_list;
        struct2.f_bpm=f_bpm;
        struct2.Xintegrale_all=Xintegrale_all(:,2:size(Xintegrale_all,2));
        struct2.Zintegrale_all=Zintegrale_all(:,2:size(Zintegrale_all,2));
        struct2.pxfftaff_all=pxfftaff_all(:,2:size(pxfftaff_all,2));
        struct2.pzfftaff_all=pzfftaff_all(:,2:size(pzfftaff_all,2));
          if N_BPM==1
            struct2.Xintegrale_mean=(struct2.Xintegrale_all(:,:));
            struct2.Zintegrale_mean=(struct2.Zintegrale_all(:,:));
            struct2.pxfftaff_mean=(struct2.pxfftaff_all(:,:));
            struct2.pzfftaff_mean=(struct2.pzfftaff_all(:,:));
          else
            struct2.Xintegrale_mean=mean(struct2.Xintegrale_all(:,:));
            struct2.Zintegrale_mean=mean(struct2.Zintegrale_all(:,:));
            struct2.pxfftaff_mean=mean(struct2.pxfftaff_all(:,:));
            struct2.pzfftaff_mean=mean(struct2.pzfftaff_all(:,:));
          end
            setappdata(handles.figure1,'struct2',struct2);
    case 'No'
end
affichage(hObject, eventdata, handles);

% --- Executes on button press in switch_plots.
function switch_plots_Callback(hObject, eventdata, handles)
% hObject    handle to switch_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
struct1=getappdata(handles.figure1,'struct1');
struct2=getappdata(handles.figure1,'struct2');

setappdata(handles.figure1,'struct2',struct1);
setappdata(handles.figure1,'struct1',struct2);

affichage(hObject, eventdata, handles);



function record_length_Callback(hObject, eventdata, handles)
% hObject    handle to record_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of record_length as text
%        str2double(get(hObject,'String')) returns contents of record_length as a double
record_length=str2num(get(handles.record_length,'string'));
% if record_length>10
%     f = warndlg('Record Length is limited to 10s', 'Warning');
%     set(handles.record_length,'string',num2str(10));
% end

% --- Executes during object creation, after setting all properties.
function record_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to record_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in source.
function source_Callback(hObject, eventdata, handles)
% hObject    handle to source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns source contents as cell array
%        contents{get(hObject,'Value')} returns selected item from source


% --- Executes during object creation, after setting all properties.
function source_CreateFcn(hObject, eventdata, handles)
% hObject    handle to source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in log_x_axis.
function log_x_axis_Callback(hObject, eventdata, handles)
% hObject    handle to log_x_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of log_x_axis
affichage(hObject, eventdata, handles);

% --- Executes on button press in autoscale_y_axis.
function autoscale_y_axis_Callback(hObject, eventdata, handles)
% hObject    handle to autoscale_y_axis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of autoscale_y_axis
affichage(hObject, eventdata, handles);


% --- Executes on button press in extract_figure.
function extract_figure_Callback(hObject, eventdata, handles)
% hObject    handle to extract_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig=figure();
struct1=getappdata(handles.figure1,'struct1');
struct2=getappdata(handles.figure1,'struct2');

plan=get(handles.plan,'value');
fstart=str2num(get(handles.fstart,'string'));
fstop=str2num(get(handles.fstop,'string'));
bruit_integre1=0;
bruit_integre2=0;
filename1='';
filename2='';
log_x_axis=get(handles.log_x_axis,'value');
autoscale_y_axis=get(handles.autoscale_y_axis,'value');


if isempty(struct1)==0
    set(handles.courbe1,'string',[struct1.pathname struct1.filename]);
    if log_x_axis
        subplot(2,1,1)
        loglog(struct1.f_bpm,struct1.pxfftaff_mean,'r','LineWidth',2);
        hold('on'); 
        loglog(struct1.f_bpm,struct1.pzfftaff_mean,'b','LineWidth',2);
        subplot(2,1,2)
        loglog(struct1.f_bpm,struct1.Xintegrale_mean,'r','LineWidth',3);
        hold('on'); 
        loglog(struct1.f_bpm,struct1.Zintegrale_mean,'b','LineWidth',3);        
       
    else
        subplot(2,1,1)
        semilogy(struct1.f_bpm,struct1.pxfftaff_mean,'r','LineWidth',2);
        hold('on'); 
        semilogy(struct1.f_bpm,struct1.pzfftaff_mean,'b','LineWidth',2);
        subplot(2,1,2)
        semilogy(struct1.f_bpm,struct1.Xintegrale_mean,'r','LineWidth',3);
        hold('on'); 
        semilogy(struct1.f_bpm,struct1.Zintegrale_mean,'b','LineWidth',3);
    end
    index=find(struct1.f_bpm>fstop);
    bruit_integreX1=struct1.Xintegrale_mean(index(1));
    bruit_integreZ1=struct1.Zintegrale_mean(index(1));
end
if isempty(struct2)==0
    set(handles.courbe2,'string',[struct2.pathname struct1.filename]);
    if log_x_axis
        subplot(2,1,1)
        loglog(struct2.f_bpm,struct2.pxfftaff_mean,'r--','LineWidth',2);
        hold('on'); 
        loglog(struct2.f_bpm,struct2.pzfftaff_mean,'b--','LineWidth',2);
        subplot(2,1,2)
        loglog(struct2.f_bpm,struct2.Xintegrale_mean,'r--','LineWidth',3);
        hold('on'); 
        loglog(struct2.f_bpm,struct2.Zintegrale_mean,'b--','LineWidth',3);

    else
        subplot(2,1,1)
        semilogy(struct2.f_bpm,struct2.pxfftaff_mean,'r--','LineWidth',2);
        hold('on'); 
        semilogy(struct2.f_bpm,struct2.pzfftaff_mean,'b--','LineWidth',2);
        subplot(2,1,2)
        semilogy(struct2.f_bpm,struct2.Xintegrale_mean,'r--','LineWidth',3);
        hold('on'); 
        semilogy(struct2.f_bpm,struct2.Zintegrale_mean,'b--','LineWidth',3);
       
    end
    index=find(struct2.f_bpm>fstop);
    bruit_integreX2=struct2.Xintegrale_mean(index(1));
    bruit_integreZ2=struct2.Zintegrale_mean(index(1));
end


%x axis

%y axis


subplot(2,1,1)
title('Averaged fft amplitude','FontWeight','Bold');
legend('X1','Z1','X2','Z2');
Grid on;
hold('off');
xlim([fstart fstop]);
xlabel('frequency (Hz)','fontsize',16,'fontangle','italic','FontWeight','Bold');
if ~autoscale_y_axis
    ylim([10^-3 10^3]);
end
ylabel('µm/sqrt(Hz)','FontWeight','Bold');


subplot(2,1,2)
title('Averaged noise','FontWeight','Bold');
%legend([num2str(bruit_integreX1),' µm'],[num2str(bruit_integreZ1),' µm'],[num2str(bruit_integreX2),' µm'],[num2str(bruit_integreZ2),' µm'],'Location','SouthEast');
legend([num2str(bruit_integreX1),' µm'],[num2str(bruit_integreZ1),' µm'],'Location','SouthEast');
Grid on;
hold('off');
xlim([fstart fstop]);
xlabel('frequency (Hz)','fontsize',16,'fontangle','italic','FontWeight','Bold');
if ~autoscale_y_axis
    ylim([2*10^-3 10^2]);
end
ylabel('µm/sqrt(Hz)','FontWeight','Bold');
ylabel('µm','FontWeight','Bold');