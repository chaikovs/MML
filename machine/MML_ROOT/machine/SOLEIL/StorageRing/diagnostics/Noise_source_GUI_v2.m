function varargout = Noise_source_GUI_v2(varargin)
% NOISE_SOURCE_GUI_V2 M-file for Noise_source_GUI_v2.fig
%      NOISE_SOURCE_GUI_V2, by itself, creates a new NOISE_SOURCE_GUI_V2 or raises the existing
%      singleton*.
%
%      H = NOISE_SOURCE_GUI_V2 returns the handle to a new NOISE_SOURCE_GUI_V2 or the handle to
%      the existing singleton*.
%
%      NOISE_SOURCE_GUI_V2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOISE_SOURCE_GUI_V2.M with the given input arguments.
%
%      NOISE_SOURCE_GUI_V2('Property','Value',...) creates a new NOISE_SOURCE_GUI_V2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Noise_source_GUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Noise_source_GUI_v2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Noise_source_GUI_v2

% Last Modified by GUIDE v2.5 25-Feb-2014 16:34:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Noise_source_GUI_v2_OpeningFcn, ...
                   'gui_OutputFcn',  @Noise_source_GUI_v2_OutputFcn, ...
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


% --- Executes just before Noise_source_GUI_v2 is made visible.
function Noise_source_GUI_v2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Noise_source_GUI_v2 (see VARARGIN)

% Choose default command line output for Noise_source_GUI_v2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Noise_source_GUI_v2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Noise_source_GUI_v2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in frequency_list.
function frequency_list_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns frequency_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from frequency_list

h2=waitbar(0,'please wait...');

FHCORspos = getspos('FHCOR',family2dev('FHCOR'));
FVCORspos = getspos('FVCOR',family2dev('FVCOR'));
HCORspos = getspos('HCOR',family2dev('HCOR'));
VCORspos = getspos('VCOR',family2dev('VCOR'));
BPMspos = getspos('BPMx',family2dev('BPMx'));
BPM_list=dev2tangodev('BPMx',family2dev('BPMx'));
Nbpm=size(BPM_list,1);
RF=1;

selection=get(handles.frequency_list,'value')

is_frequency_domain=get(handles.frequency_domain,'value');

if is_frequency_domain
    
    xfftamp=getappdata(handles.figure1,'xfftamp');
    xfftphase=getappdata(handles.figure1,'xfftphase');
    zfftamp=getappdata(handles.figure1,'zfftamp');
    zfftphase=getappdata(handles.figure1,'zfftphase');
    f_bpm=getappdata(handles.figure1,'f_bpm');
    mean_xfftamp=getappdata(handles.figure1,'mean_xfftamp');
    mean_zfftamp=getappdata(handles.figure1,'mean_zfftamp');
    orbitX=xfftamp(:,selection).*sign(xfftphase(:,selection));
    orbitZ=zfftamp(:,selection).*sign(zfftphase(:,selection));
else
    bufferX=getappdata(handles.figure1,'bufferX');
    bufferZ=getappdata(handles.figure1,'bufferZ');
    orbitX=bufferX(:,selection);
    orbitZ=bufferZ(:,selection);
   
end

waitbar(1/5,h2);
[strengthX_slow,slow_corr_orbit_x,idx_sx,efficiency_sx]=mosteffectivecorrector2(orbitX,'HCOR',RF);
waitbar(2/5,h2);
[strengthZ_slow,slow_corr_orbit_z,idx_sz,efficiency_sz]=mosteffectivecorrector2(orbitZ,'VCOR',RF);
waitbar(3/5,h2);
[strengthX_fast,fast_corr_orbit_x,idx_fx,efficiency_fx]=mosteffectivecorrector2(orbitX,'FHCOR',RF);
waitbar(4/5,h2);
[strengthZ_fast,fast_corr_orbit_z,idx_fz,efficiency_fz]=mosteffectivecorrector2(orbitZ,'FVCOR',RF);
waitbar(5/5,h2);

max_fast_X=max(abs(strengthX_fast));
max_fast_Z=max(abs(strengthZ_fast));
%max_fast=max(max_fast_X,max_fast_Z);
max_slow_X=max(abs(strengthX_slow));
max_slow_Z=max(abs(strengthZ_slow));
%max_slow=max(max_slow_X,max_slow_Z);


strengthX_slow=strengthX_slow./max_slow_X;
strengthZ_slow=strengthZ_slow./max_slow_Z;
strengthX_fast=strengthX_fast./max_fast_X;
strengthZ_fast=strengthZ_fast./max_fast_Z;


plot(handles.Xorbit,BPMspos,orbitX,'k','Linewidth',2)
set(handles.Xorbit,'XGrid','on','YGrid','on');
hold(handles.Xorbit,'on')
plot(handles.Xorbit,BPMspos,slow_corr_orbit_x,'b')
plot(handles.Xorbit,BPMspos,fast_corr_orbit_x,'r')
hold(handles.Xorbit,'off')
xlabel(handles.Xorbit,'position (meters)','fontsize',8,'fontangle','italic')
title(handles.Xorbit,'Horizontal orbit at selected frequency','FontWeight','Bold');
legend2=['HCOR [',num2str(idx_sx),']'];
legend3=['FHCOR [',num2str(idx_fx),']'];
legend(handles.Xorbit,'Xorbit',legend2,legend3);

disp_corr_strength=get(handles.strength,'value');
disp_orbit_reduction=get(handles.orbit_reduction,'value');

if disp_orbit_reduction
        bar(handles.HCOR,HCORspos,efficiency_sx(1:size(efficiency_sx,2)-1),1,'b')
        hold(handles.HCOR,'on')
        bar(handles.HCOR,FHCORspos,efficiency_fx(1:size(efficiency_fx,2)-1),0.6,'r')
        hold(handles.HCOR,'off')
        ylim(handles.HCOR,[0 100]);
        title(handles.HCOR,'Horizontal correctors response to correct selected frequency','FontWeight','Bold');
        set(handles.HCOR,'XGrid','on','YGrid','on');
        xlabel(handles.HCOR,'position (meters)','fontsize',8,'fontangle','italic')
        text2=['FHCOR [',num2str(idx_fx),']'];
        text1=['HCOR [',num2str(idx_sx),']'];
        legend(handles.HCOR,text1,text2);

        bar(handles.RFCOR,1,efficiency_sx(size(efficiency_sx,2)),'g')
        ylim(handles.RFCOR,[0 100]);
         xlim(handles.RFCOR,[0 2]);
         set(handles.RFCOR,'XGrid','on','YGrid','on');
        legend(handles.RFCOR,'RF');
        
        bar(handles.VCOR,VCORspos,efficiency_sz,1,'b')
        set(handles.VCOR,'XGrid','on','YGrid','on');
        hold(handles.VCOR,'on')
        bar(handles.VCOR,FVCORspos,efficiency_fz,0.6,'r')
        hold(handles.VCOR,'off')
        ylim(handles.VCOR,[0 100]);
        xlabel(handles.VCOR,'position (meters)','fontsize',8,'fontangle','italic')
        title(handles.VCOR,'Vertical correctors response to correct selected frequency','FontWeight','Bold');
        legend2=['FVCOR [',num2str(idx_fz),']'];
        legend1=['VCOR [',num2str(idx_sz),']'];
        legend(handles.VCOR,legend1,legend2);

else if disp_corr_strength
        bar(handles.HCOR,HCORspos,strengthX_slow(1:size(strengthX_slow,1)-1),1,'b')
        hold(handles.HCOR,'on')
        bar(handles.HCOR,FHCORspos,strengthX_fast(1:size(strengthX_fast,1)-1),0.6,'r')
        hold(handles.HCOR,'off')
        ylim(handles.HCOR,[-1 1]);
        title(handles.HCOR,'Horizontal correctors response to correct selected frequency','FontWeight','Bold');
        set(handles.HCOR,'XGrid','on','YGrid','on');
        xlabel(handles.HCOR,'position (meters)','fontsize',8,'fontangle','italic')
        text2=['FHCOR [',num2str(idx_fx),']'];
        text1=['HCOR [',num2str(idx_sx),']'];
        legend(handles.HCOR,text1,text2);

        bar(handles.RFCOR,1,strengthX_slow(size(strengthX_slow,2)),'g')
        ylim(handles.RFCOR,[-1 1]);
        xlim(handles.RFCOR,[0 2]);
        set(handles.RFCOR,'XGrid','on','YGrid','on');
        legend(handles.RFCOR,'RF');
        
        bar(handles.VCOR,VCORspos,strengthZ_slow,1,'b')
        set(handles.VCOR,'XGrid','on','YGrid','on');
        hold(handles.VCOR,'on')
        bar(handles.VCOR,FVCORspos,strengthZ_fast,0.6,'r')
        hold(handles.VCOR,'off')
        ylim(handles.VCOR,[-1 1]);
        xlabel(handles.VCOR,'position (meters)','fontsize',8,'fontangle','italic')
        title(handles.VCOR,'Vertical correctors response to correct selected frequency','FontWeight','Bold');
        legend2=['FVCOR [',num2str(idx_fz),']'];
        legend1=['VCOR [',num2str(idx_sz),']'];
        legend(handles.VCOR,legend1,legend2);

end

end


plot(handles.Zorbit,BPMspos,orbitZ,'k','Linewidth',2)
set(handles.Zorbit,'XGrid','on','YGrid','on');
hold(handles.Zorbit,'on')
plot(handles.Zorbit,BPMspos,slow_corr_orbit_z,'b')
plot(handles.Zorbit,BPMspos,fast_corr_orbit_z,'r')
hold(handles.Zorbit,'off')
xlabel(handles.Zorbit,'position (meters)','fontsize',8,'fontangle','italic')
title(handles.Zorbit,'Vertical orbit at selected frequency','FontWeight','Bold');
legend2=['VCOR [',num2str(idx_sz),']'];
legend3=['FVCOR [',num2str(idx_fz),']'];
legend(handles.Zorbit,'Zorbit',legend2,legend3);



x_scale=get(handles.spectrum,'xlim');

if is_frequency_domain
    semilogy(handles.spectrum,f_bpm,mean(xfftamp(:,:)),'r');
    hold(handles.spectrum,'on');
    semilogy(handles.spectrum,f_bpm,mean(zfftamp(:,:)));
    xlim(handles.spectrum,x_scale);
    %ylim(handles.spectrum,[10^-3 10^1]);
    xlabel(handles.spectrum,'frequency (Hz)','fontsize',8,'fontangle','italic')
    %ylabel(handles.spectrum,'µm/sqrt(Hz)')
    title(handles.spectrum,'Averaged fft amplitude','FontWeight','Bold');
    legend(handles.spectrum,'plan H','plan V');
    set(handles.spectrum,'XGrid','on','YGrid','on');
    plot(handles.spectrum,f_bpm(selection),mean_xfftamp(selection),'ro','LineWidth',3,'MarkerSize',10)
    plot(handles.spectrum,f_bpm(selection),mean_zfftamp(selection),'bo','LineWidth',3,'MarkerSize',10)
    hold(handles.spectrum,'off');

end    

setappdata(handles.figure1,'strengthX_slow',strengthX_slow)
setappdata(handles.figure1,'strengthZ_slow',strengthZ_slow)
setappdata(handles.figure1,'strengthX_fast',strengthX_fast)
setappdata(handles.figure1,'strengthZ_fast',strengthZ_fast)
setappdata(handles.figure1,'efficiency_sx',efficiency_sx)
setappdata(handles.figure1,'efficiency_fx',efficiency_fx)
setappdata(handles.figure1,'efficiency_sz',efficiency_sz)
setappdata(handles.figure1,'efficiency_fz',efficiency_fz)
setappdata(handles.figure1,'idx_sx',idx_sx)
setappdata(handles.figure1,'idx_fx',idx_fx)
setappdata(handles.figure1,'idx_sz',idx_sz)
setappdata(handles.figure1,'idx_fz',idx_fz)
setappdata(handles.figure1,'orbitX',orbitX)
setappdata(handles.figure1,'orbitZ',orbitZ)
setappdata(handles.figure1,'BPM_list',BPM_list)

set(handles.save_orbit,'Enable','on');

close(h2)





% --- Executes during object creation, after setting all properties.
function frequency_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency_list (see GCBO)
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
fa_source=get(handles.fa_source,'value');
if fa_source
    source='FA';
else
    source='DD';
end

handles.source=source;




data_aquisition(hObject, eventdata, handles);
fech=getappdata(handles.figure1,'fech');
bufferX=getappdata(handles.figure1,'bufferX');
bufferZ=getappdata(handles.figure1,'bufferZ');
Nsamples=getappdata(handles.figure1,'Nsamples');

tic
[xfftamp,zfftamp,xfftphase,zfftphase,f_bpm]=fft_amp_phase_calcul(bufferX,bufferZ,fech);
fft_computation_time=toc;
fprintf('fft computation time = %f seconds\n',toc)
 
switch source
    case 'FA'
        fmin_display=0;
        fmax_display=fech/2;
        fmax_memory=2000;
    case 'DD'
        fmin_display=0;
        fmax_display=fech/2;
        fmax_memory=2000;    
end
        


semilogy(handles.spectrum,f_bpm,mean(xfftamp(:,:)),'r');
hold(handles.spectrum,'on');
semilogy(handles.spectrum,f_bpm,mean(zfftamp(:,:)));
xlim(handles.spectrum,[fmin_display fmax_display]);
%ylim(handles.spectrum,[10^-3 10^1]);
xlabel(handles.spectrum,'frequency (Hz)','fontsize',8,'fontangle','italic')
%ylabel(handles.spectrum,'µm/sqrt(Hz)')
title(handles.spectrum,'Averaged fft amplitude','FontWeight','Bold');
legend(handles.spectrum,'plan H','plan V');
set(handles.spectrum,'XGrid','on','YGrid','on');
hold(handles.spectrum,'off');

setappdata(handles.figure1,'bufferX', bufferX);
setappdata(handles.figure1,'bufferZ', bufferZ);
setappdata(handles.figure1,'xfftamp',xfftamp);
setappdata(handles.figure1,'xfftphase',xfftphase);
setappdata(handles.figure1,'zfftamp',zfftamp);
setappdata(handles.figure1,'zfftphase',zfftphase);
setappdata(handles.figure1,'f_bpm',f_bpm);
setappdata(handles.figure1,'mean_xfftamp',mean(xfftamp(:,:)));
setappdata(handles.figure1,'mean_zfftamp',mean(zfftamp(:,:)));

mean_xfftamp=getappdata(handles.figure1,'mean_xfftamp');
mean_zfftamp=getappdata(handles.figure1,'mean_zfftamp');

for i=1:size(f_bpm,2)/2
    list{i}=[num2str(f_bpm(i),'%10.2f'),' Hz    X=',num2str(mean_xfftamp(i),'%10.1f'),'    Z=',num2str(mean_zfftamp(i),'%10.1f')];
end

set(handles.frequency_list,'string',list)

cla(handles.HCOR)
cla(handles.VCOR)
cla(handles.Xorbit)
cla(handles.Zorbit)

set(handles.strength,'Enable','on');
set(handles.orbit_reduction,'Enable','on');
set(handles.save,'Enable','on');



function record_length_Callback(hObject, eventdata, handles)
% hObject    handle to record_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of record_length as text
%        str2double(get(hObject,'String')) returns contents of record_length as a double


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


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




pathname='/home/data/DG/matlab';
[filename, pathname, filterindex] = uigetfile('*.mat', 'Pick an MAT-file',pathname);
if isequal(filename,0) || isequal(pathname,0)
       disp('Loading cancelled by user')
else
load([pathname filename],'BPM_list','bufferX','bufferZ','fech');
end

if ~exist('fech')
    fech=10079;
end

switch fech
    case 10079;
        set(handles.fa_source,'value',1);
        set(handles.TbT_source,'value',0);
    otherwise
        set(handles.fa_source,'value',0);
        set(handles.TbT_source,'value',1);
end


fmin_display=0;
fmax_display=fech/2;

is_frequency_domain=get(handles.frequency_domain,'value');

if is_frequency_domain
    [xfftamp,zfftamp,xfftphase,zfftphase,f_bpm]=fft_amp_phase_calcul(bufferX,bufferZ,fech);

    semilogy(handles.spectrum,f_bpm,mean(xfftamp(:,:)),'r');
    hold(handles.spectrum,'on');
    semilogy(handles.spectrum,f_bpm,mean(zfftamp(:,:)));
    xlim(handles.spectrum,[fmin_display fmax_display]);
    %ylim(handles.spectrum,[10^-3 10^1]);
    xlabel(handles.spectrum,'frequency (Hz)','fontsize',8,'fontangle','italic')
    %ylabel(handles.spectrum,'µm/sqrt(Hz)')
    title(handles.spectrum,'Averaged fft amplitude','FontWeight','Bold');
    legend(handles.spectrum,'plan H','plan V');
    set(handles.spectrum,'XGrid','on','YGrid','on');
    hold(handles.spectrum,'off');

    setappdata(handles.figure1,'xfftamp',xfftamp);
    setappdata(handles.figure1,'xfftphase',xfftphase);
    setappdata(handles.figure1,'zfftamp',zfftamp);
    setappdata(handles.figure1,'zfftphase',zfftphase);
    setappdata(handles.figure1,'f_bpm',f_bpm);
    setappdata(handles.figure1,'mean_xfftamp',mean(xfftamp(:,:)));
    setappdata(handles.figure1,'mean_zfftamp',mean(zfftamp(:,:)));
    setappdata(handles.figure1,'BPM_list',BPM_list)

    mean_xfftamp=getappdata(handles.figure1,'mean_xfftamp');
    mean_zfftamp=getappdata(handles.figure1,'mean_zfftamp');
    for i=1:size(f_bpm,2)/2
        list{i}=[num2str(f_bpm(i),'%10.2f'),' Hz    X=',num2str(mean_xfftamp(i),'%10.1f'),'    Z=',num2str(mean_zfftamp(i),'%10.1f')];
    end
else
    plot(handles.spectrum,bufferX');
    hold(handles.spectrum,'on');
    plot(handles.spectrum,bufferZ');
    xlabel(handles.spectrum,'position (meters)','fontsize',8,'fontangle','italic')
    ylabel(handles.spectrum,'BPM(nm)')
    title(handles.spectrum,'Position','FontWeight','Bold');
    set(handles.spectrum,'XGrid','on','YGrid','on');
    hold(handles.spectrum,'off');

    setappdata(handles.figure1,'bufferX',bufferX);
    setappdata(handles.figure1,'bufferZ',bufferZ);

    for i=1:size(bufferX,2)
       list{i}=[num2str((i),'%10.2f'),'   X=',num2str(std(bufferX(:,i)),'%10.1f'),'    Z=',num2str(std(bufferZ(:,i)),'%10.1f')];
    end
end
set(handles.frequency_list,'string',list)

cla(handles.HCOR)
cla(handles.VCOR)
cla(handles.Xorbit)
cla(handles.Zorbit)

set(handles.strength,'Enable','on');
set(handles.orbit_reduction,'Enable','on');
set(handles.save_orbit,'Enable','off');





% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BPM_list=dev2tangodev('BPMx',family2dev('BPMx'));
bufferX=getappdata(handles.figure1,'bufferX');
bufferZ=getappdata(handles.figure1,'bufferZ');
fech=getappdata(handles.figure1,'fech');

clk=clock;
year=num2str(clk(1));
month=num2str(clk(2),'%.2d');
day=num2str(clk(3),'%.2d');
hour=[num2str(clk(4),'%.2d'),'h'];
min=[num2str(clk(5),'%.2d'),'mn'];
date=['_',year,'_',month,'_',day,'_',hour,'_',min];
filename=['/home/data/DG/matlab/Enregistrement',date,'.mat'];

uisave({'BPM_list','bufferX','bufferZ','fech'},filename)
        


% --- Executes on button press in orbit_reduction.
function orbit_reduction_Callback(hObject, eventdata, handles)
% hObject    handle to orbit_reduction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of orbit_reduction

value=get(handles.strength,'value');
if value
    set(handles.strength,'value',0);
else
    set(handles.strength,'value',1);
end
disp_corr(hObject, eventdata, handles)
%frequency_list_Callback(hObject, eventdata, handles)

% --- Executes on button press in strength.
function strength_Callback(hObject, eventdata, handles)
% hObject    handle to strength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of strength
value=get(handles.orbit_reduction,'value');
if value
    set(handles.orbit_reduction,'value',0);
else
    set(handles.orbit_reduction,'value',1);
end
disp_corr(hObject, eventdata, handles)
%frequency_list_Callback(hObject, eventdata, handles)



function disp_corr(hObject, eventdata, handles)

FHCORspos = getspos('FHCOR',family2dev('FHCOR'));
FVCORspos = getspos('FVCOR',family2dev('FVCOR'));
HCORspos = getspos('HCOR',family2dev('HCOR'));
VCORspos = getspos('VCOR',family2dev('VCOR'));
BPMspos = getspos('BPMx',family2dev('BPMx'));

strengthX_slow=getappdata(handles.figure1,'strengthX_slow');
strengthZ_slow=getappdata(handles.figure1,'strengthZ_slow');
strengthX_fast=getappdata(handles.figure1,'strengthX_fast');
strengthZ_fast=getappdata(handles.figure1,'strengthZ_fast');
efficiency_sx=getappdata(handles.figure1,'efficiency_sx');
efficiency_fx=getappdata(handles.figure1,'efficiency_fx');
efficiency_sz=getappdata(handles.figure1,'efficiency_sz');
efficiency_fz=getappdata(handles.figure1,'efficiency_fz');
idx_sx=getappdata(handles.figure1,'idx_sx');
idx_fx=getappdata(handles.figure1,'idx_fx');
idx_sz=getappdata(handles.figure1,'idx_sz');
idx_fz=getappdata(handles.figure1,'idx_fz');

disp_corr_strength=get(handles.strength,'value')
disp_orbit_reduction=get(handles.orbit_reduction,'value')

if disp_orbit_reduction
        bar(handles.HCOR,HCORspos,efficiency_sx(1:size(efficiency_sx,2)-1),1,'b')
        hold(handles.HCOR,'on')
        bar(handles.HCOR,FHCORspos,efficiency_fx(1:size(efficiency_fx,2)-1),0.6,'r')
        hold(handles.HCOR,'off')
        ylim(handles.HCOR,[0 100]);
        title(handles.HCOR,'Horizontal correctors response to correct selected frequency','FontWeight','Bold');
        set(handles.HCOR,'XGrid','on','YGrid','on');
        xlabel(handles.HCOR,'position (meters)','fontsize',8,'fontangle','italic')
        text2=['FHCOR [',num2str(idx_fx),']'];
        text1=['HCOR [',num2str(idx_sx),']'];
        legend(handles.HCOR,text1,text2);

        bar(handles.RFCOR,1,efficiency_sx(size(efficiency_sx,2)),'g')
        ylim(handles.RFCOR,[0 100]);
         xlim(handles.RFCOR,[0 2]);
         set(handles.RFCOR,'XGrid','on','YGrid','on');
        legend(handles.RFCOR,'RF');
        
        bar(handles.VCOR,VCORspos,efficiency_sz,1,'b')
        set(handles.VCOR,'XGrid','on','YGrid','on');
        hold(handles.VCOR,'on')
        bar(handles.VCOR,FVCORspos,efficiency_fz,0.6,'r')
        hold(handles.VCOR,'off')
        ylim(handles.VCOR,[0 100]);
        xlabel(handles.VCOR,'position (meters)','fontsize',8,'fontangle','italic')
        title(handles.VCOR,'Vertical correctors response to correct selected frequency','FontWeight','Bold');
        legend2=['FVCOR [',num2str(idx_fz),']'];
        legend1=['VCOR [',num2str(idx_sz),']'];
        legend(handles.VCOR,legend1,legend2);

else if disp_corr_strength
        bar(handles.HCOR,HCORspos,strengthX_slow(1:size(strengthX_slow,1)-1),1,'b')
        hold(handles.HCOR,'on')
        bar(handles.HCOR,FHCORspos,strengthX_fast(1:size(strengthX_fast,1)-1),0.6,'r')
        hold(handles.HCOR,'off')
        ylim(handles.HCOR,[-1 1]);
        title(handles.HCOR,'Horizontal correctors response to correct selected frequency','FontWeight','Bold');
        set(handles.HCOR,'XGrid','on','YGrid','on');
        xlabel(handles.HCOR,'position (meters)','fontsize',8,'fontangle','italic')
        text2=['FHCOR [',num2str(idx_fx),']'];
        text1=['HCOR [',num2str(idx_sx),']'];
        legend(handles.HCOR,text1,text2);

        bar(handles.RFCOR,1,strengthX_slow(size(strengthX_slow,2)),'g')
        ylim(handles.RFCOR,[-1 1]);
        xlim(handles.RFCOR,[0 2]);
        set(handles.RFCOR,'XGrid','on','YGrid','on');
        legend(handles.RFCOR,'RF');
        
        bar(handles.VCOR,VCORspos,strengthZ_slow,1,'b')
        set(handles.VCOR,'XGrid','on','YGrid','on');
        hold(handles.VCOR,'on')
        bar(handles.VCOR,FVCORspos,strengthZ_fast,0.6,'r')
        hold(handles.VCOR,'off')
        ylim(handles.VCOR,[-1 1]);
        xlabel(handles.VCOR,'position (meters)','fontsize',8,'fontangle','italic')
        title(handles.VCOR,'Vertical correctors response to correct selected frequency','FontWeight','Bold');
        legend2=['FVCOR [',num2str(idx_fz),']'];
        legend1=['VCOR [',num2str(idx_sz),']'];
        legend(handles.VCOR,legend1,legend2);

end

end


plot(handles.Zorbit,BPMspos,orbitZ,'k','Linewidth',2)
set(handles.Zorbit,'XGrid','on','YGrid','on');
hold(handles.Zorbit,'on')
plot(handles.Zorbit,BPMspos,slow_corr_orbit_z,'b')
plot(handles.Zorbit,BPMspos,fast_corr_orbit_z,'r')
hold(handles.Zorbit,'off')
xlabel(handles.Zorbit,'position (meters)','fontsize',8,'fontangle','italic')
title(handles.Zorbit,'Vertical orbit at selected frequency','FontWeight','Bold');
legend2=['MESC'];
legend3=['MEFC'];
legend(handles.Zorbit,'Zorbit',legend2,legend3);



x_scale=get(handles.spectrum,'xlim');


semilogy(handles.spectrum,f_bpm,mean(xfftamp(:,:)),'r');
hold(handles.spectrum,'on');
semilogy(handles.spectrum,f_bpm,mean(zfftamp(:,:)));
xlim(handles.spectrum,x_scale);
%ylim(handles.spectrum,[10^-3 10^1]);
xlabel(handles.spectrum,'frequency (Hz)','fontsize',8,'fontangle','italic')
%ylabel(handles.spectrum,'µm/sqrt(Hz)')
title(handles.spectrum,'Averaged fft amplitude','FontWeight','Bold');
legend(handles.spectrum,'plan H','plan V');
set(handles.spectrum,'XGrid','on','YGrid','on');
plot(handles.spectrum,f_bpm(selection),mean_xfftamp(selection),'ro','LineWidth',3,'MarkerSize',10)
plot(handles.spectrum,f_bpm(selection),mean_zfftamp(selection),'bo','LineWidth',3,'MarkerSize',10)
hold(handles.spectrum,'off');

setappdata(handles.figure1,'strengthX_slow',strengthX_slow)
setappdata(handles.figure1,'strengthZ_slow',strengthZ_slow)
setappdata(handles.figure1,'strengthX_fast',strengthX_fast)
setappdata(handles.figure1,'strengthZ_fast',strengthZ_fast)
setappdata(handles.figure1,'efficiency_sx',efficiency_sx)
setappdata(handles.figure1,'efficiency_fx',efficiency_fx)
setappdata(handles.figure1,'efficiency_sz',efficiency_sz)
setappdata(handles.figure1,'efficiency_fz',efficiency_fz)
setappdata(handles.figure1,'idx_sx',idx_sx)
setappdata(handles.figure1,'idx_fx',idx_fx)
setappdata(handles.figure1,'idx_sz',idx_sz)
setappdata(handles.figure1,'idx_fz',idx_fz)
setappdata(handles.figure1,'orbitX',orbitX)
setappdata(handles.figure1,'orbitZ',orbitZ)
setappdata(handles.figure1,'BPM_list',BPM_list)

set(handles.save_orbit,'Enable','on');

close(h2)


% --- Executes on button press in save_orbit.
function save_orbit_Callback(hObject, eventdata, handles)
% hObject    handle to save_orbit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
orbitX=getappdata(handles.figure1,'orbitX')
orbitZ=getappdata(handles.figure1,'orbitZ')
BPM_list=dev2tangodev('BPMx',family2dev('BPMx'));

clk=clock;
year=num2str(clk(1));
month=num2str(clk(2),'%.2d');
day=num2str(clk(3),'%.2d');
hour=[num2str(clk(4),'%.2d'),'h'];
min=[num2str(clk(5),'%.2d'),'mn'];
date=['_',year,'_',month,'_',day,'_',hour,'_',min];
filename=['/home/data/DG/matlab/Enregistrement',date,'.mat'];

uisave({'BPM_list','orbitX','orbitZ'},filename)
        


% --- Executes on button press in frequency_domain.
function frequency_domain_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_domain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frequency_domain
value=get(handles.time_domain,'value');
if value
    set(handles.time_domain,'value',0);
else
    set(handles.time_domain,'value',1);
end


% --- Executes on button press in time_domain.
function time_domain_Callback(hObject, eventdata, handles)
% hObject    handle to time_domain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of time_domain
value=get(handles.frequency_domain,'value');
if value
    set(handles.frequency_domain,'value',0);
else
    set(handles.frequency_domain,'value',1);
end


function data_aquisition(hObject, eventdata, handles)
% hObject    handle to aquisition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch handles.source
    case 'FA'
         BPM_list=dev2tangodev('BPMx',family2dev('BPMx'));
         Nbpm=size(BPM_list,1);

        dev='ANS/DG/fofb-sniffer.2';
        fech=10079;
        
        buff_length=(get(handles.record_length,'String'));
        buffer_length=str2num(buff_length);

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
            bufferX(j,:)=tango_command_inout2(dev,'GetXPosData',uint16((j)));
            bufferZ(j,:)=tango_command_inout2(dev,'GetZPosData',uint16((j)));
            Nsamples=size(bufferX(j,:),2);
        end
        data_reading_time=toc;
        fprintf('data download time = %f seconds\n',toc)
        close(h1)


    case 'DD'
        h=warndlg(sprintf('Avez-vous vérifiez la configuration des BPMs? \n - switching OFF (position3) \n - DDBufferLenght identique sur tous les BPMs \n\n Le programme va relire les données DD actuellement présentes sur les BPMs\n OK pour continuer'))
        uiwait(h); 
        fech=getrf/416*1e6

        result=getbpmrawdata([],'struct');
        Nbpm=size(result.DeviceList,1);

        bufferX=result.Data.X;
        bufferZ=result.Data.Z;
        Nsamples=size(bufferX,2);
        
end
setappdata(handles.figure1,'fech',fech);
setappdata(handles.figure1,'bufferX',bufferX);
setappdata(handles.figure1,'bufferZ',bufferZ);
setappdata(handles.figure1,'Nsamples',Nsamples);



%  

 


% --- Executes on button press in fa_source.
function fa_source_Callback(hObject, eventdata, handles)
% hObject    handle to fa_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fa_source
value=get(handles.TbT_source,'value');
if value
    set(handles.TbT_source,'value',0);
    set(handles.buffer_length,'Enable','on');
    set(handles.record_length,'Enable','on');
else
    set(handles.TbT_source,'value',1);
    set(handles.buffer_length,'Enable','off');
    set(handles.record_length,'Enable','off');
end

% --- Executes on button press in TbT_source.
function TbT_source_Callback(hObject, eventdata, handles)
% hObject    handle to TbT_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TbT_source
value=get(handles.fa_source,'value');
if value
    set(handles.fa_source,'value',0);
    set(handles.buffer_length,'Enable','off');
    set(handles.record_length,'Enable','off');
else
    set(handles.fa_source,'value',1);
    set(handles.buffer_length,'Enable','on');
    set(handles.record_length,'Enable','on');
end
