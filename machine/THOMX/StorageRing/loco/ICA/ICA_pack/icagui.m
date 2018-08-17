function varargout = icagui(varargin)
% ICAGUI Application M-file for icagui.fig
%    FIG = ICAGUI launch icagui GUI.
%    ICAGUI('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.0 29-Apr-2004 16:01:14

if nargin == 0  % LAUNCH GUI

  fig = openfig(mfilename,'reuse');

  % Use system color scheme for figure:
  set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

  % Generate a structure of handles to pass to callbacks, and store it. 
  
  handles = guihandles(fig);
  handles.data.x = [];
  handles.data.y = [];
  handles.srclist.cat = {'SPEAR3','APS','FNAL Booster','RHIC','SPEAR Orbit','NSLS2'}; %category
  %handles.srclist.names{1} = {'pt2kV_a2','pt2kV_a10','pt78kV_2','pt78kV_10','track'};
  handles.srclist.names{1} = {'spear_case1','spear_case2'};
  handles.srclist.names{2} = {'APS_2003'};
  handles.srclist.names{3} = {'data1'};
  handles.srclist.names{4} = {'RHIC_2005'};
  handles.srclist.names{5} = {'sp3_orbitdata'};
  handles.srclist.names{6} = {'NSLS2_data1','NSLS2_data2','NSLS2_data3'};
  
  set(handles.popupmenu_srccategory,'String',handles.srclist.cat);
  
  handles.srclist.catsel = 1;
  set(handles.popupmenu_srccategory,'Value',handles.srclist.catsel);
  set(handles.popupmenu_srcname,'String',handles.srclist.names{handles.srclist.catsel});
  handles.srclist.namesel = 1;
  set(handles.popupmenu_srcname,'Value',handles.srclist.namesel);
  
  handles.methodlist = {'ICA','PCA'};
  handles.preprocess_list = {'zero mean'};
  
  set(handles.popupmenu_analysis,'String',handles.methodlist);
  set(handles.popupmenu_preprocess,'String',handles.preprocess_list);
  handles.para.method = 1;
  handles.para.preprocess = 1;
  
  handles.para.st = 1;
  handles.para.wid = 1000;
  handles.para.el  = .0;
  handles.para.action = 5; %sobi by default
  handles.para.usedata = 'xy'; %'y' 'xy'
  handles.para.dataset = '';
  handles.para.tao = [1 2 3 0];
  handles.dout = [];
  handles.opt.icom = 0;
  handles.opt.pickup = [];
  

figpos = get(handles.figure1,'Position');
panelpos = get(handles.frame1,'Position');
axeswidth = (figpos(3) - panelpos(3))/2 - 18;
axesheight = figpos(4)/2 - 6;

set(handles.axes3,'Position',[ 15, 4,axeswidth,axesheight]); 
set(handles.axes4,'Position',[ axeswidth+30, 4,axeswidth,axesheight]);
set(handles.axes1,'Position',[ 15, axesheight+9,axeswidth,axesheight]);
set(handles.axes2,'Position',[ axeswidth+30, axesheight+9,axeswidth,axesheight]);
set(handles.axes1,'Visible','on');
set(handles.axes2,'Visible','on');
set(handles.axes3,'Visible','on');
set(handles.axes4,'Visible','on');
  guidata(fig, handles);
	
%   fHandle = figure('HandleVisibility','off','IntegerHandle','off',...
% 'Visible','off');
% aHandle = axes('Parent',fHandle);
% pHandles = plot(PlotData,'Parent',aHandle);
% set(fHandle,'Visible','on')
  
  if nargout > 0
    varargout{1} = fig;
  end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK
	%disp(varargin{1})
  try
    [varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
  catch
    disp(lasterr);
  end

end
% -------------------------- end icagui ------------------------------


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| SUBFUNCTION_NAME(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| ICAGUI('SUBFUNCTION_NAME', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.
function pushbutton_run_Callback(h,eventdata,handles,varargin)
%
names = get(handles.popupmenu_srcname,'String');
sel   = get(handles.popupmenu_srcname,'Value');

if ~strcmp(names{sel}, handles.para.dataset) | strcmp(names{sel}, 'Tracking') | strcmp(names{sel},'LC Model')
	[datax,datay]=icaloaddata(names{sel});
	size(datax)
	handles.para.dataset = names{sel};
	handles.data.x = datax;
	handles.data.y = datay;
end

% listsel = get(handles.listbox_choosedata,'Value');
% if 1    %listsel ~= handles.para.dataset | isempty(handles.data.x) | isempty(handles.data.y)
% 	liststring = get(handles.listbox_choosedata,'String');
% 	[datax,datay]=icaloaddata(liststring{listsel});
% 	handles.para.dataset = listsel;
% 	handles.data.x = datax;
% 	handles.data.y = datay;
% end

switch handles.para.usedata
case {'x'}
	data = 	handles.data.x;	
case {'y'}
	data = 	handles.data.y;	
case {'xy'}
	data = 	[handles.data.x;	handles.data.y];
end

set(handles.figure1,'HandleVisibility','on');
% edit_turn_st_Callback(handles.edit_turn_st,[],handles);
% edit_turn_wid_Callback(handles.edit_turn_wid,[],handles);
% edit_cutoff_el_Callback(handles.edit_cutoff_el, [], handles);

switch handles.methodlist{handles.para.method}
case 'ICA'
	handles.para.action = 5; %4 = jg amuse, 5=sobi, 6=seons,, 7 = ac-dc, 8= PCA, 9=ICAtest
case 'PCA'
	handles.para.action = 8;
end

action = handles.para.action; 
st = handles.para.st;
wid = handles.para.wid;
tao = handles.para.tao;
el =  handles.para.el;
preprocess =  handles.preprocess_list{handles.para.preprocess};
%disp(handles.para);

if st + wid + max(tao) -1 > size(data,2) | st<1
	msgdlg('exceeding data limits');
	return
end

ndata = icapreprocess(data, st,wid,tao,preprocess);
%dout = icatbtrun(data(:,st:(st+wid+max(tao)-1)),action,st,wid,tao,el,preprocess);
dout = icatbtrun(ndata,action,st,wid,tao,el,preprocess);

handles.dout = dout;
%handles.dout.tao
%disp('xxxxx\n')
dout.datasrc = handles.para.usedata;
handles.opt.pickup = [];

%for temporal use
% tmp.st =dout.st;
% tmp.wid = dout.wid;
% tmp.el = dout.el;
% tmp.datasrc = dout.datasrc;
% tmp.tao = dout.tao;
% tmp.action = dout.action;
% disp(tmp)

set(handles.pushbutton_mode_forward,'Enable','on');
set(handles.pushbutton_mode_backward,'Enable','on');
set(handles.pushbutton_print,'Enable','on');
set(handles.checkbox_pickup,'Enable','on','Value',0);

haxes = [handles.axes1,handles.axes2,handles.axes3,handles.axes4];

icom = 1;
viewmodes(dout,icom,haxes);
handles.opt.icom = icom;

set(handles.figure1,'HandleVisibility','off');
guidata(handles.figure1,handles);

function checkbox_plane_x_Callback(h,eventdata,handles,varargin)
%
if findstr(handles.para.usedata,'y')
	if get(h,'value')==1
		handles.para.usedata = 'xy';
	else
		handles.para.usedata = 'y';
	end
else
	if get(h,'value')==1
		handles.para.usedata = 'x';
	else
		handles.para.usedata = '';
	end
	
end
handles.para.usedata
guidata(handles.figure1, handles);

function checkbox_plane_y_Callback(h,eventdata,handles,varargin)
%
if findstr(handles.para.usedata,'x')
	if get(h,'value')==1
		handles.para.usedata = 'xy';
	else
		handles.para.usedata = 'x';
	end
else
	if get(h,'value')==1
		handles.para.usedata = 'y';
	else
		handles.para.usedata = '';
	end
	
end
handles.para.usedata
guidata(handles.figure1, handles);

function edit_turn_st_Callback(h,eventdata,handles,varargin)
%
st = floor(str2num(get(handles.edit_turn_st,'String')));
if isnan(st)
	disp('must be an interger number')
	return
end
handles.para.st = st;
guidata(handles.figure1, handles);

function edit_turn_wid_Callback(h,eventdata,handles,varargin)
%
wid = floor(str2num(get(handles.edit_turn_wid,'String')));
if isnan(wid)
	disp('must be an interger number')
	return
end
handles.para.wid = wid;
guidata(handles.figure1, handles);

function MenuItem_Quit_Callback(h,eventdata,handles,varargin)
%delete(handles.figure1)
disp('to be implemented 2')


function varargout = edit_tao_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.edit_tao.
tao = eval(['[' get(h,'String') ']' ])
handles.para.tao = tao;
guidata(handles.figure1, handles);
% -------------------- end edit_tao_Callback -------------------------


function varargout = edit_cutoff_el_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.edit_cutoff_el.
el = eval(get(handles.edit_cutoff_el,'String'));
if isnan(el)
	disp('must be an real number')
	return
end
handles.para.el = el;
guidata(handles.figure1, handles);
% ----------------- end edit_cutoff_el_Callback ----------------------


function varargout = pushbutton_mode_forward_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_mode_forwad.
if isempty(handles.dout)
	return
end
set(handles.figure1,'HandleVisibility','on');

dout = handles.dout;
dout.datasrc = handles.para.usedata;
nmode = size(dout.s,1);

icom = mod(handles.opt.icom,nmode) + 1;
haxes = [handles.axes1,handles.axes2,handles.axes3,handles.axes4];
viewmodes( dout,icom,haxes);
handles.opt.icom = icom;

if ~isempty(handles.opt.pickup) & find(handles.opt.pickup==icom)
    set(handles.checkbox_pickup,'Value',1);
else
    set(handles.checkbox_pickup,'Value',0);    
end

set(handles.figure1,'HandleVisibility','off');
guidata(handles.figure1,handles);
% ------------- end pushbutton_mode_forwad_Callback ------------------


function varargout = pushbutton_mode_backward_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_mode_backward.
if isempty(handles.dout)
	return
end

set(handles.figure1,'HandleVisibility','on');

dout = handles.dout;
dout.datasrc = handles.para.usedata;
nmode = size(dout.s,1);

icom = mod(handles.opt.icom-2,nmode) + 1;
haxes = [handles.axes1,handles.axes2,handles.axes3,handles.axes4];
viewmodes( dout,icom,haxes);
handles.opt.icom = icom;

if ~isempty(handles.opt.pickup) & find(handles.opt.pickup==icom)
    set(handles.checkbox_pickup,'Value',1);
else
    set(handles.checkbox_pickup,'Value',0);    
end
set(handles.figure1,'HandleVisibility','off');
guidata(handles.figure1,handles);
% ------------ end pushbutton_mode_backward_Callback -----------------


function varargout = axes2_ButtondownFcn(h, eventdata, handles, varargin)
% Stub for ButtondownFcn of the axes handles.axes2.
axesdlg(h);
% ------------------- end axes2_ButtondownFcn ------------------------


function varargout = axes3_ButtondownFcn(h, eventdata, handles, varargin)
% Stub for ButtondownFcn of the axes handles.axes3.
axesdlg(h);
% ------------------- end axes3_ButtondownFcn ------------------------


function varargout = axes4_ButtondownFcn(h, eventdata, handles, varargin)
% Stub for ButtondownFcn of the axes handles.axes4.

% ------------------- end axes4_ButtondownFcn ------------------------

function varargout = MenuItem_OpenData_Callback(h, eventdata, handles, varargin)
% 

% ------------------- end  ------------------------


function varargout = MenuItem_Para_Callback(h, eventdata, handles, varargin)
% 
disp('Not implemented,use panel')
% ------------------- end  ------------------------

function varargout = MenuItem_Option_Callback(h, eventdata, handles, varargin)
% 
axesdlg(handles.axes4);
%set(handles.axes4,'XLim',[0.7,0.8]);
% ------------------- end  ------------------------

function varargout = MenuItem_About_Callback(h, eventdata, handles, varargin)
% 
disp('ICA applied to TBT data')
% ------------------- end  ------------------------

% --------------------------------------------------------------------
function varargout = pushbutton_Quit_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_Quit.
yesno = 'yes'; %quitdlg;
if strcmp(yesno ,'yes')
    delete(handles.figure1); 
end



% --------------------------------------------------------------------
function varargout = pushbutton_print_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_print.
%print figures to EPS format and refer them in a latex file

liststr = get(handles.popupmenu_srcname,'String');
listval = get(handles.popupmenu_srcname,'Value');
datasrc = liststr(listval);

prelist = {'zm','p5','p10','m5','m10','m20'};
filename = sprintf('%s_%s_%d_%d_%s_%d',datasrc{1},handles.para.usedata,handles.para.st,...
    handles.para.wid,prelist{handles.para.preprocess},handles.opt.icom);
tindx = find(filename==' ');
filename(tindx)=[];

hf = figure;
set(hf,'Visible','off');
ha = axes;%('position',[0,0,.8,.8]);

dout = handles.dout;
dout.datasrc = handles.para.usedata;
icom = handles.opt.icom;

for i=1:4
    viewmodes( dout,icom,ha,i);
    set(hf,'Visible','off','PaperUnits','inch');
    exportfig(hf,[filename,'_',num2str(i),'.eps'],'Color','rgb','Width',10.5,'Height',8.0,...
		'FontMode','fixed','FontSize',20,'LineWidth',4);
%    exportfig(hf,[filename,'_',num2str(i),'.eps'],'Color','rgb',...
%        'Width',8.0,'Height',10.5,'FontMode','fixed','FontSize',24);
end
delete(hf)
    



% --------------------------------------------------------------------
function varargout = checkbox_pickup_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.checkbox_pickup.

icom = handles.opt.icom;
indx = [];
if ~isempty(handles.opt.pickup)
	indx = find(handles.opt.pickup == icom);
end
npick = length(handles.opt.pickup);

if isempty(indx)
    handles.opt.pickup(npick+1) = icom;
%	pt = detectpinger_std(handles.dout.s(icom,:))
else
    handles.opt.pickup(indx) = [];
end
guidata(handles.figure1,handles);

% ---------------- end pushbutton_optics_Callback --------------------
function varargout = popupmenu_srcname_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.popupmenu_srcname.
  val  = get(handles.popupmenu_srcname,'Value');
  handles.srclist.namesel = val;
  guidata(handles.figure1, handles);

function varargout = popupmenu_srccategory_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.popupmenu_srccategory.

  val  = get(handles.popupmenu_srccategory,'Value');
  handles.srclist.catsel = val;
  set(handles.popupmenu_srcname,'String',handles.srclist.names{handles.srclist.catsel});
  handles.srclist.namesel = 1;
  set(handles.popupmenu_srcname,'Value',handles.srclist.namesel);
  guidata(handles.figure1, handles);


function varargout = popupmenu_analysis_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.popupmenu_analysis.
val  = get(handles.popupmenu_analysis,'Value');
handles.para.method = val;
guidata(handles.figure1, handles);


function varargout = popupmenu_preprocess_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.popupmenu_preprocess.
val  = get(handles.popupmenu_preprocess,'Value');
handles.para.preprocess = val;
guidata(handles.figure1, handles);
 
function varargout = pushbutton_viewtbt_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_viewtbt.
if 1    %call viewbpmdlg.m
	pickup = handles.opt.pickup;
	if isempty(handles.opt.pickup)
%	msgdlg('pick up modes first!')
%	return
	pickup = 1:size(handles.dout.s,1);
	end
data.s = handles.dout.s(pickup,:);
data.A = handles.dout.A(:,pickup);
data.usedata = handles.para.usedata;

%specify a file name for possible printout
%liststr = get(handles.listbox_choosedata,'String');
%listval = get(handles.listbox_choosedata,'Value');
liststr = get(handles.popupmenu_srcname,'String');
listval = get(handles.popupmenu_srcname,'Value');
datasrc = liststr(listval);

filename = sprintf('%s_%s_%d_%d',datasrc{1},handles.para.usedata,handles.para.st,...
    handles.para.wid);
tindx = find(filename==' ');
filename(tindx)=[];
data.filename = filename;

%save temp data
viewbpmdlg(data);

elseif 0 %calc ISR and print

rnorder =  handles.opt.pickup;%[1,2,3,4];%[3,4,1,2];%[1,3,2,4];%[3,4,1,2];%[2,4,1,3];%
ISR = calcISR3(handles.dout.A(:,rnorder),handles);

elseif 0 %RHIC 
	data.s = handles.dout.s(handles.opt.pickup,:);
	data.A = handles.dout.A(:,handles.opt.pickup);
	data.usedata = handles.para.usedata;
	%size(data.A)
	amp2 = data.A(:,1).^2 + data.A(:,2).^2;
	psi = atan2(data.A(:,1),data.A(:,2));
	cpsi = mappsi(psi);
	save temp data amp2 psi cpsi
else %save to temp file
	pickup = handles.opt.pickup; %1:4; %
   	data.s = handles.dout.s(pickup,:);
	data.A = handles.dout.A(:,pickup);
	data.usedata = handles.para.usedata;%for temporal use

	para.st = handles.dout.st;
	para.wid = handles.dout.wid;
	para.el = handles.dout.el;
	para.datasrc = handles.dout.datasrc;
	para.tao = handles.dout.tao;
	para.action = handles.dout.action;
	%disp(tmp)
	
	
	%size(data.A)
	save tempmix data para pickup%amp2 psi cpsi
end


function varargout = pushbutton_export_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton_export.
	pickup = handles.opt.pickup;
	if isempty(handles.opt.pickup)
		pickup = 1:size(handles.dout.s,1);
	end
	data.s = handles.dout.s(pickup,:);
	data.A = handles.dout.A(:,pickup);
	data.usedata = handles.para.usedata;

	para.st = handles.dout.st;
	para.wid = handles.dout.wid;
	para.el = handles.dout.el;
	para.datasrc = handles.dout.datasrc;
	para.tao = handles.dout.tao;
	para.action = handles.dout.action;
	save tempmodes data para pickup
	
%=====================================================================
%for test use
function ISR = calcISR(A1,handles)
%This function calculate ISR as defined in SOBI paper
%It takes permutatation into account but not phase shift
%And this prevents it from being used to compare betatron modes.

logfile = ['..' filesep 'simul' filesep 'simulstudy.log'];
fid = fopen(logfile,'a');
fprintf(fid,'-----  %s  ------------------------\n',datestr(now));

fprintf(fid,'Test Data\nTau  = ');
for i=1:length(handles.dout.tao)
    fprintf(fid,' %d\t',handles.dout.tao(i));
end
fprintf(fid,'\noffF = ');
for i=1:length(handles.para.tao)
    fprintf(fid,' %f\t',handles.dout.offF(i));
end
fprintf(fid,'\nel = %f \t   action = %d (5 & not indicated =sobi,4=jg amuse)\n',handles.dout.el,handles.para.action);
fclose(fid);

eval(['load ..' filesep 'simul' filesep 'baseA'])
A = data.A(:,1:5);  %actual mixing matrix

for i=1:size(A,2)
	cv=[];
	for j=i:size(A1,2)
		tmp = A(:,i)' * A1(:,j)/norm(A(:,i))/norm(A1(:,j));
		cv = [cv;j, tmp];
	end
	cv
	if isempty(cv)
		i
	end
	[tmp,mdx] = max(cv(:,2));
	if cv(mdx,1)~= i
		[cv(mdx,1),i]
		
		tmpA = A1(:,i);
		A1(:,i) = A1(:,cv(mdx,1));
		A1(:,cv(mdx,1))=tmpA;
	end
end

[u,s,v] = svd(A1(:,1:5));
%size(u),size(s),size(v)
ds = diag(s);
%size(ds)
dss = 1./ds;
ss = zeros(size(s'));
ss(1:length(ds),1:length(ds)) = diag(dss);

Am1 = v*ss*u';

ISR = Am1*A;

amat(logfile,ISR);
ISR


function ISR = calcISR2(A1,handles)
%This function calculate ISR as defined in SOBI paper
%It takes permutatation into account but not phase shift
%And this prevents it from being used to compare betatron modes.

logfile = ['..' filesep 'simul' filesep 'simulstudy.log'];
fid = fopen(logfile,'a');
fprintf(fid,'-calcISR2----  %s  ------------------------\n',datestr(now));

fprintf(fid,'Test Data\nTau  = ');
for i=1:length(handles.dout.tao)
    fprintf(fid,' %d\t',handles.dout.tao(i));
end
fprintf(fid,'\noffF = ');
for i=1:length(handles.para.tao)
    fprintf(fid,' %f\t',handles.dout.offF(i));
end
fprintf(fid,'\nel = %f \t   action = %d (5 & not indicated =sobi,4=jg amuse)\n',handles.dout.el,handles.para.action);


eval(['load ..' filesep 'simul' filesep 'baseAtmp A'])
%A = data.A(:,1:5);  %actual mixing matrix
A = A(:,1:5);

% dd1 = handles.dout.dd(1,1:5);
% [tmp,mdx] = min(abs(dd1(3:5) - dd1(2)));

	%mindx = [3,1,2,4,5]; %dispersion, bx1,bx2,by1,by2
	mindx = [1,2,3,4,5];
	%mindx = [5,1,4,2,3];
	
	eval(['load ..' filesep 'simul' filesep 'modnewdog bx ux by uy dx xtune ytune'])
	[ampx,mpsix] = calc_amp_psi(A1(:,mindx(2:3)),ux*2.*pi,'x');
	[ampy,mpsiy] = calc_amp_psi(A1(:,mindx(4:5)),uy*2.*pi,'y');

	newA1(:,1) = A1(:,mindx(1));
	newA1(:,2) = ampx.*cos(mpsix);
	newA1(:,3) = ampx.*sin(mpsix);
	newA1(:,4) = ampy.*cos(mpsiy);
	newA1(:,5) = ampy.*sin(mpsiy);

	[ampx,mpsix] = calc_amp_psi(A(:,2:3),ux*2.*pi,'x');
	[ampy,mpsiy] = calc_amp_psi(A(:,4:5),uy*2.*pi,'y');

	newA(:,1) = A(:,1);
	newA(:,2) = ampx.*cos(mpsix);
	newA(:,3) = ampx.*sin(mpsix);
	newA(:,4) = ampy.*cos(mpsiy);
	newA(:,5) = ampy.*sin(mpsiy);

%	[mean(A1(:,mindx(1))./A(:,1)),std(A1(:,mindx(1))./A(:,1)), norm(handles.dout.s(1,:))]
	
[u,s,v] = svd(newA1(:,1:5));
ds = diag(s);
dss = 1./ds;
ss = zeros(size(s'));
ss(1:length(ds),1:length(ds)) = diag(dss);

Am1 = v*ss*u';

ISR = Am1*newA;
offISR = sum(sum(ISR.^2)) - sum(diag(ISR).^2);
fprintf(fid,'offISR = %f\n',offISR);
fclose(fid);

amat(logfile,ISR);
ISR
offISR


function [amp,mpsi] = calc_amp_psi(A,psi,opt)

amp = sqrt(A(:,1).^2 + A(:,2).^2);
mpsi  = atan(A(:,2)./A(:,1));

if opt == 'x'
    dpsi_s = diff(mpsi(2:2:48))/2./pi;
    dux_s = diff(psi(2:2:48))/2./pi;
elseif opt == 'y'
    dpsi_s = diff(mpsi(1:2:48))/2./pi;
    dux_s = diff(psi(1:2:48))/2./pi;
end
for i=1:length(dpsi_s)
    while dpsi_s(i) < 0
          dpsi_s(i) = dpsi_s(i) + 0.5;
    end
    while dpsi_s(i) > 0.5
          dpsi_s(i) = dpsi_s(i) - 0.5;
    end
end
        
        
if mean(dpsi_s*360.) <90.
     dpsi_s = 0.5 - dpsi_s;
     mpsi = pi - mpsi;
end
mpsi = mpsi - mpsi(2);

spsi = zeros(size(mpsi));
kadd = zeros(size(mpsi))-2;
if opt == 'x'
	for i=2:2:48
 	   spsi(i) = sum(dpsi_s(1:i/2-1))*2.*pi;
  	   while mpsi(i)<spsi(i)-0.1*pi;
    	    mpsi(i) = mpsi(i)+pi;
     	   kadd(i) = kadd(i)+1;
    	end
	end
	for i=1:2:48
 	    while mpsi(i)<mpsi(i+1)-pi
  	      mpsi(i) = mpsi(i) + pi;
   		end
    	while mpsi(i)>mpsi(i+1)
     	   mpsi(i) = mpsi(i) - pi;
    	end
	end
elseif opt == 'y'
	for i=1:2:48
 	   spsi(i) = sum(dpsi_s(1:(i-1)/2))*2.*pi;
  	   while mpsi(i)<spsi(i)-0.1*pi;
    	    mpsi(i) = mpsi(i)+pi;
     	    kadd(i) = kadd(i)+1;
    	end
	end
	for i=2:2:48
 	    while mpsi(i)<mpsi(i-1)
  	      mpsi(i) = mpsi(i) + pi;
   		end
    	while mpsi(i)>mpsi(i-1)+pi
     	   mpsi(i) = mpsi(i) - pi;
    	end
	end
end
mpsi = mpsi - mpsi(1);


function ISR = calcISR3(A1, handles)
%
logfile = ['..' filesep 'simul' filesep 'simulstudy.log'];
fid = fopen(logfile,'a');
fprintf(fid,'-calcISR3----  %s  ------------------------\n',datestr(now));


fprintf(fid,'Test Data\nTau  = ');
if length(handles.dout.tao) > 0
for i=1:length(handles.dout.tao)
    fprintf(fid,' %d\t',handles.dout.tao(i));
end
fprintf(fid,'\noffF = ');
for i=1:length(handles.para.tao)
    fprintf(fid,' %f\t',handles.dout.offF(i));
end
end
fprintf(fid,'\nel = %f \t   action = %d (5 & not indicated =sobi,4=jg amuse)\n',handles.dout.el,handles.para.action);


eval(['load ..' filesep 'simul' filesep 'baseAtmp A'])
%A = data.A(:,1:4);  %actual mixing matrix
A = A(:,1:4);

[nA,ampx,psix,ampy,psiy] = couplemodes(A1);
[u,s,v] = svd(nA);
ds = diag(s);
dss = 1./ds;
ss = zeros(size(s'));
ss(1:length(ds),1:length(ds)) = diag(dss);

Am1 = v*ss*u';
ISR = Am1*A;

offISR = sum(sum(ISR.^2)) - sum(diag(ISR).^2);
fprintf(fid,'offISR = %f\n',offISR);
fclose(fid);

amat(logfile,ISR);
ISR
offISR

function [nA,ampx,psix,ampy,psiy] = couplemodes(A)
%
%A(1:(N/2),:)	Horizontal
%A(N/2+1:N,:) 	Vertical
%(1,2), (3,4)
%
global ampx psix ampy psiy difpsix difpsiy
N = size(A,1);
N_2 = N/2;
ampx(:,1) = A(1:N_2,1).^2 + A(1:N_2,2).^2;
psix(:,1) = atan2(A(1:N_2,1),A(1:N_2,2) );
ampx(:,2) = A(1:N_2,3).^2 + A(1:N_2,4).^2;
psix(:,2) = atan2(A(1:N_2,3),A(1:N_2,4) );
ampx = sqrt(ampx);

ampy(:,1) = A(N_2+1:N,1).^2 + A(N_2+1:N,2).^2;
psiy(:,1) = atan2(A(N_2+1:N,1),A(N_2+1:N,2) );
ampy(:,2) = A(N_2+1:N,3).^2 + A(N_2+1:N,4).^2;
psiy(:,2) = atan2(A(N_2+1:N,3),A(N_2+1:N,4) );
ampy = sqrt(ampy);

psix(:,1) = mappsi(psix(:,1));
psix(:,2) = mappsi(psix(:,2));
psiy(:,1) = mappsi(psiy(:,1));
psiy(:,2) = mappsi(psiy(:,2));

Ax(:,1) = ampx(:,1).*cos(psix(:,1));
Ax(:,2) = -ampx(:,1).*sin(psix(:,1));
Ax(:,3) = ampx(:,2).*cos(psix(:,2));
Ax(:,4) = -ampx(:,2).*sin(psix(:,2));

Ay(:,1) = ampy(:,1).*cos(psiy(:,1));
Ay(:,2) = -ampy(:,1).*sin(psiy(:,1));
Ay(:,3) = -ampy(:,2).*cos(psiy(:,2));
Ay(:,4) = ampy(:,2).*sin(psiy(:,2));


nA = [Ax;Ay];

%print result here
mean_amp = mean([ampx,ampy],1)
std_amp  =std([ampx,ampy],1)

difpsix = diff(psix);
difpsiy = diff(psiy);

mean_phase_advance = mean([difpsix,difpsiy],1)
std_phase_advance  = std([difpsix,difpsiy],1)

disp('Ax+\tAx-\tAy+\tAy-')
amplitude=[ampx,ampy]

disp('Px+\tPx-\tPy+\tPy-')
phase = [psix,psiy]



