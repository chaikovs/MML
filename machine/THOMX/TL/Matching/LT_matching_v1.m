function varargout = LT_matching_v1(varargin)
% LT_MATCHING_V1 MATLAB code for LT_matching_v1.fig
%      LT_MATCHING_V1, by itself, creates a new LT_MATCHING_V1 or raises the existing
%      singleton*.
%
%      H = LT_MATCHING_V1 returns the handle to a new LT_MATCHING_V1 or the handle to
%      the existing singleton*.
%
%      LT_MATCHING_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LT_MATCHING_V1.M with the given input arguments.
%
%      LT_MATCHING_V1('Property','Value',...) creates a new LT_MATCHING_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LT_matching_v1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LT_matching_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LT_matching_v1

% Last Modified by GUIDE v2.5 27-Jan-2015 16:13:05

% Begin initialization code - DO NOT EDIT

global THERING
global THERINGold
global QPKold


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LT_matching_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @LT_matching_v1_OutputFcn, ...
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


% --- Executes just before LT_matching_v1 is made visible.
function LT_matching_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LT_matching_v1 (see VARARGIN)

% Choose default command line output for LT_matching_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LT_matching_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LT_matching_v1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function Matching_Callback(hObject, eventdata, handles)
global THERING 
global THERINGout
global QPKold
global THERINGold
THERINGold=THERING;

%%%%%%%%%%%%%%%%lecture des variables selectionn�es%%%%%%%%%%
listVariab={'QP1L','QP2L','QP3L','QP4L','QP5L','QP6L','QP7L'};
clear lisvar_on
kk=1;
for i=1:length(listVariab)
test=get(handles.(listVariab{i}), 'Value');
    if test==1
        lisvar_on{kk}=listVariab{i};
        kk=kk+1;
    end
end
%% Contruction de la structure variable
clear Variab
for vi=1:length(lisvar_on)
    Variab{vi}=struct('PERTURBINDX',[findcells(THERING,'FamName',lisvar_on{vi})],...
    'PVALUE',0,...
    'Fam',1,...
    'LowLim',[],...
    'HighLim',[],...
    'FIELD','PolynomB',...
    'IndxInField',{{1,2}}); % the double braces {{}} are necessary in orded 
    Var_initfit(vi)= getpv(lisvar_on{vi});
end

%Var_initfit
%%  Lecture des CONSTRAINTES s�lectionn�es
listcrt={'betx' 'bety' 'alfx' 'alfy' 'dispx' 'disppx'};
clear listcrt_on
kk=1;
for i=1:length(listcrt)
test=get(handles.(listcrt{i}), 'Value');
    if test==1
        listcrt_on{kk}=listcrt{i};
        kk=kk+1;;
    end
end

loc_list=ones(size(listcrt_on)).*findcells(THERING,'FamName','FIN');
%loc_list={findcells(THERING,'FamName','FIN') findcells(THERING,'FamName','FIN') findcells(THERING,'FamName','FIN') findcells(THERING,'FamName','FIN') findcells(THERING,'FamName','SD32L') findcells(THERING,'FamName','SD32L')};


%% Lectures des valeurs et des poids des contraintes
clear listcrt_value
clear listcrt_weight
%clear listcrt_loc

for j=1:length(listcrt_on)
    listcrt_value{j}=[listcrt_on{j} '_value'];
    listcrt_weight{j}=[listcrt_on{j} '_weight'];
    %listcrt_loc{j}=[listcrt_on{j} '_loc'];
end
%listcrt_value
%listcrt_weight
%listcrt_loc
for i=1:length(listcrt_on)
    if i==1
    Valuemin_list=str2num(get(handles.(listcrt_value{i}),'String'));
    Weight_list=str2num(get(handles.(listcrt_weight{i}),'String'));
    %Loc_list=findcells(THERING,'FamName',get(handles.(listcrt_weight{i}),'String'));
    else
    Valuemin_list=[Valuemin_list str2num(get(handles.(listcrt_value{i}),'String'))];
    Weight_list=[Weight_list str2num(get(handles.(listcrt_weight{i}),'String'))];
    %Loc_list=[Loc_list findcells(THERING,'FamName',get(handles.(listcrt_weight{i}),'String'))];
    end
end
 Valuemax_list = Valuemin_list;
% Weight_list
%Loc_list
%% MATCHING

%% Param�tres MATCHING %%%%%%%%%%%%%
dpp=0.00;
Tolerance=10^-25;
calls=1000;
algo='lsqnonlin' %%%Possible 'fminsearch' (marche pas encore bien), 'lsqnonlin'
%Print=1;% 0 to print, 1 to hide
%Apply=1;% 1 to apply filed change, 0 to not aplly
%%%%%%%%%%%%%%%

clear c;

c{1}.Fun=@(r)atfuntofitoptics(r,dpp,listcrt_on,Valuemin_list,Valuemax_list,Weight_list);
%c{1}.Min=cell2mat(Valuemin_list);
c{1}.Min=Valuemin_list;
c{1}.Max=c{1}.Min;
%c{1}.Weight=cell2mat(Weight_list);
c{1}.Weight=Weight_list;

 options = optimset(...
     'Display','iter',...% 
     'MaxFunEvals',calls*100,...
     'MaxIter',calls,...
     'TolFun',Tolerance,...);%,...'Algorithm',{''},...
     'TolX',Tolerance,...;%,...  %                         
     'Algorithm',{'levenberg-marquardt',1e-6});
%options = optimset(...
%    'Display','iter',...% 
%    'MaxFunEvals',calls*100,...
%    'MaxIter',calls,...
%    'TolFun',Tolerance,...);%,...'Algorithm',{''},...
%    'TolX',Tolerance);

 f = @(d)atEvalConstrRingDif(THERING,Variab,c,d);
% 
% penalty=feval(c{1}.Fun,THERING);
% disp(['f²: ' num2str(penalty.^2)]);
% disp(['Sum of f²: ' num2str(sum(penalty.^2))]);

%% Least Squares
    delta_0 = zeros(size(lisvar_on));  %Var_initfit%point de d�part moindre carr�
    Blow=[];
    Bhigh=[];
   % [~,delta_0,~,Blow,Bhigh]=atApplyVariation(THERING,Variab);

    dmin = lsqnonlin(f,delta_0,Blow,Bhigh,options); %% Blow, Bhigh matrice vide comme stipul� dans le help de lsqnonlin

%% Resultats

delta_0=dmin;
THERINGout=THERING;
for i=1:length(Variab)
oldvalue = ...
                getfield(THERING{Variab{i}.PERTURBINDX},...
                Variab{i}.('FIELD'),...
                Variab{i}.('IndxInField')...
                );
            
            
            THERINGout{Variab{i}.PERTURBINDX} = ...
                setfield(THERINGout{Variab{i}.PERTURBINDX},...
                Variab{i}.('FIELD'),...
                Variab{i}.('IndxInField'),...
                oldvalue+dmin(i));
end


%    penalty=feval(c{1}.Fun,THERINGout);
%% Print modif

for i=1:length(Variab)
varname(i)=getcellstruct(THERING,'FamName',Variab{i}.PERTURBINDX);
    
    valueold(i) = ...
        getfield(THERING{Variab{i}.PERTURBINDX},...
        Variab{i}.('FIELD'),...
        Variab{i}.('IndxInField')...
        );
    
    valueoptim(i) = ...
        getfield(THERINGout{Variab{i}.PERTURBINDX},...
        Variab{i}.('FIELD'),...
        Variab{i}.('IndxInField')...
        );
   
 end   
%    disp([varname '    ' num2str(valueold) '    ' num2str(valueoptim) ]);

if get(handles.Print_result, 'Value')==1 
disp('----------------------------------           ----')
disp('Constraint used:')
disp(listcrt_on)
disp(['Initial constraints values:    ',num2str(feval(c{1}.Fun,THERING))])
disp(['Final constraints values:      ',num2str(feval(c{1}.Fun,THERINGout))])
%disp(['goal constraints values:       ',num2str(Valuemin_list)])
%disp('   ')
disp(['Desired constraints values:    ',num2str(c{1}.Min)])
%disp('   ')

disp('--------------------------------------')
disp('Final variable values:')
disp(varname)
disp(['field before matching   ',num2str(valueold)])
disp(['field after matching    ',num2str(valueoptim)])
disp('--------------------------------------')
end

handles=guidata(hObject); 
cla(handles.Twissmatched_graf);
[lindata]=twissline(THERINGout,0.0,THERING{1}.TwissData,1:length(THERING)+1,'chrom'); %#ok<NASGU,ASGLU>
beta=cat(1,lindata.beta);
s=cat(1,lindata.SPos);
plot(s,beta,'parent',handles.Twissmatched_graf);
set(gcf,'Color','white');
guidata(hObject,handles); 
%THERING{findcells(THERING,'FamName','QP2L')}.K
%THERING=THERINGout

%%  Apply change

if (get(handles.Apply_field, 'Value')==1)
    for vi=1:length(lisvar_on)
        %THERINGout{findcells(THERINGout,'FamName',lisvar_on{vi})}.K
        setpv(lisvar_on{vi},valueoptim(vi),'model');
    end
end
if (get(handles.Apply_field_tango, 'Value')==1)
    for vi=1:length(lisvar_on)
        %THERINGout{findcells(THERINGout,'FamName',lisvar_on{vi})}.K
        setpv(lisvar_on{vi},valueoptim(vi),'online');
    end
end
function Twissnotmatched_Callback(hObject, eventdata, handles)

global THERING

handles=guidata(hObject); 
cla(handles.Twissinit_graf);
axes(handles.Twissinit_graf);

TD1=twissline(THERING,0,THERING{1}.TwissData ,1:length(THERING)+1,'chrom');
S1=cat(1,TD1.SPos);
BETA=cat(1,TD1.beta);
plot(S1,BETA);

set(gcf,'Color','white');
  
  guidata(hObject,handles); 


function edit1_Callback(hObject, eventdata, handles)


function edit1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function listbox3_Callback(hObject, eventdata, handles)


function listbox3_CreateFcn(hObject, eventdata, handles)

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function default_matching_Callback(hObject, eventdata, handles)
defaultQP1=1;
defaultoptics=1;
defaultweight=1;
defaultprint=1;
defaultapply=1;
defaultbetx_value=3.6679;
defaultbety_value=1.8369;
defaultalfx_value=0.0840;
defaultalfy_value=-0.1309;
defaultdispx_value=-0.0109;
defaultdisppx_value=0.17;

set(handles.betx_value,'String',num2str(defaultbetx_value));
set(handles.bety_value,'String',num2str(defaultbety_value));
set(handles.alfx_value,'String',num2str(defaultalfx_value));
set(handles.alfy_value,'String',num2str(defaultalfy_value));
set(handles.dispx_value,'String',num2str(defaultdispx_value));
set(handles.disppx_value,'String',num2str(defaultdisppx_value));
set(handles.betx_weight,'String',num2str(defaultweight));
set(handles.bety_weight,'String',num2str(defaultweight));
set(handles.alfx_weight,'String',num2str(defaultweight));
set(handles.alfy_weight,'String',num2str(defaultweight));
set(handles.dispx_weight,'String',num2str(defaultweight));
set(handles.disppx_weight,'String',num2str(defaultweight));
set(handles.Print_result,'Value',defaultprint);
set(handles.Apply_field,'Value',defaultapply);
set(handles.QP1L,'Value',defaultQP1)
set(handles.QP2L,'Value',defaultQP1)
set(handles.QP3L,'Value',defaultQP1)
set(handles.QP4L,'Value',defaultQP1)
set(handles.QP5L,'Value',defaultQP1)
set(handles.QP6L,'Value',defaultQP1)
set(handles.QP7L,'Value',defaultQP1)
set(handles.betx,'Value',defaultoptics)
set(handles.alfx,'Value',defaultoptics)
set(handles.alfy,'Value',defaultoptics)
set(handles.bety,'Value',defaultoptics)
set(handles.dispx,'Value',defaultoptics)
set(handles.disppx,'Value',defaultoptics)



function QP1L_Callback(hObject, eventdata, handles)
QPname=['QP1L']
v=get(gcbo,'Value')
if v==1,
  set(gcbo,'String',[QPname ' inclus'])
else  set(gcbo,'String',[QPname ' exclus']),
end


function QP2L_Callback(hObject, eventdata, handles)
QPname=['QP2L']
v=get(gcbo,'Value')
if v==1,
  set(gcbo,'String',[QPname ' inclus'])
else  set(gcbo,'String',[QPname ' exclus']),
end


function QP3L_Callback(hObject, eventdata, handles)
QPname=['QP3L']
v=get(gcbo,'Value')
if v==1,
  set(gcbo,'String',[QPname ' inclus'])
else  set(gcbo,'String',[QPname ' exclus']),
end

function QP4L_Callback(hObject, eventdata, handles)
QPname=['QP4L']
v=get(gcbo,'Value')
if v==1,
  set(gcbo,'String',[QPname ' inclus'])
else  set(gcbo,'String',[QPname ' exclus']),
end

function QP5L_Callback(hObject, eventdata, handles)
QPname=['QP5L']
v=get(gcbo,'Value')
if v==1,
  set(gcbo,'String',[QPname ' inclus'])
else  set(gcbo,'String',[QPname ' exclus']),
end

function QP6L_Callback(hObject, eventdata, handles)
QPname=['QP6L']
v=get(gcbo,'Value')
if v==1,
  set(gcbo,'String',[QPname ' inclus'])
else  set(gcbo,'String',[QPname ' exclus']),
end

function QP7L_Callback(hObject, eventdata, handles)
QPname=['QP7L']
v=get(gcbo,'Value')
if v==1,
  set(gcbo,'String',[QPname ' inclus'])
else  set(gcbo,'String',[QPname ' exclus']),
end


function betx_Callback(hObject, eventdata, handles)


function alfx_Callback(hObject, eventdata, handles)


function bety_Callback(hObject, eventdata, handles)


function alfy_Callback(hObject, eventdata, handles)


function dispx_Callback(hObject, eventdata, handles)


function disppx_Callback(hObject, eventdata, handles)


function checkbox8_Callback(hObject, eventdata, handles)


function betx_value_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end

function betx_value_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function alfx_value_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end

function alfx_value_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bety_value_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end

function bety_value_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function alfy_value_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end

function alfy_value_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dispx_value_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end

function dispx_value_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function disppx_value_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end

function disppx_value_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit8_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end

function edit8_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function betx_weight_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end


function betx_weight_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function alfx_weight_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end


function alfx_weight_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bety_weight_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end


function bety_weight_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function alfy_weight_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end


function alfy_weight_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dispx_weight_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end


function dispx_weight_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function disppx_weight_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end

function disppx_weight_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit15_Callback(hObject, eventdata, handles)


function edit15_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function betx_loc_Callback(hObject, eventdata, handles)


function betx_loc_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function alfx_loc_Callback(hObject, eventdata, handles)


function alfx_loc_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bety_loc_Callback(hObject, eventdata, handles)


function bety_loc_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function alfy_loc_Callback(hObject, eventdata, handles)


function alfy_loc_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dispx_loc_Callback(hObject, eventdata, handles)


function dispx_loc_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function disppx_loc_Callback(hObject, eventdata, handles)


function disppx_loc_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit36_Callback(hObject, eventdata, handles)


function edit36_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Qpole_change_Callback(hObject, eventdata, handles)
global THERING THERINGout

THERING=THERINGout;
THERINGout{findcells(THERINGout,'FamName','QP2L')}.K


function Matching_ButtonDownFcn(hObject, eventdata, handles)


function Print_result_Callback(hObject, eventdata, handles)


function Apply_field_Callback(hObject, eventdata, handles)
v=get(gcbo,'Value');
if (v==1 && get(handles.Apply_field_tango, 'Value')==1)
       set(handles.Apply_field_tango,'Value',0);
end

function Apply_field_tango_Callback(hObject, eventdata, handles)
v=get(gcbo,'Value');   
if (v==1 && get(handles.Apply_field, 'Value')==1)
       set(handles.Apply_field,'Value',0);
   end


function UndoMatching_Callback(hObject, eventdata, handles)
global THERING 
global THERINGold

%%%%%%%%%%%%%%%%lecture des variables selectionn�es%%%%%%%%%%
listVariab={'QP1L','QP2L','QP3L','QP4L','QP5L','QP6L','QP7L'};
clear lisvar_on
kk=1;
for i=1:length(listVariab)
test=get(handles.(listVariab{i}), 'Value');
    if test==1
        lisvar_on{kk}=listVariab{i};
        kk=kk+1;
    end
end

clear Variab
for vi=1:length(lisvar_on)
    Variab{vi}=struct('PERTURBINDX',[findcells(THERING,'FamName',lisvar_on{vi})],...
    'PVALUE',0,...
    'Fam',1,...
    'LowLim',[],...
    'HighLim',[],...
    'FIELD','PolynomB',...
    'IndxInField',{{1,2}}); % the double braces {{}} are necessary in orded 
    Var_initfit(vi)= getpv(lisvar_on{vi});
end


for i=1:length(Variab)
    valueold(i) = ...
        getfield(THERINGold{Variab{i}.PERTURBINDX},...
        Variab{i}.('FIELD'),...
        Variab{i}.('IndxInField')...
        );
end
valueold
if (get(handles.Apply_field, 'Value')==1)
    for vi=1:length(lisvar_on)
        setpv(lisvar_on{vi},valueold(vi),'model');
    end
end
if (get(handles.Apply_field_tango, 'Value')==1)
    for vi=1:length(lisvar_on)
        setpv(lisvar_on{vi},valueold(vi),'online');
    end
end


handles=guidata(hObject); 
cla(handles.Twissmatched_graf);
axes(handles.Twissmatched_graf);
TD1=twissline(THERINGold,0,THERINGold{1}.TwissData ,1:length(THERINGold)+1,'chrom');
S1=cat(1,TD1.SPos);
BETA=cat(1,TD1.beta);
plot(S1,BETA);
drawnow
set(gcf,'Color','white');
  
  guidata(hObject,handles); 
