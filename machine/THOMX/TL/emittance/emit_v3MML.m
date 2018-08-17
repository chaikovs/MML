

function varargout = emit_v3MML(varargin)
%EMIT_V3MML M-file for emit_v3MML.fig
%      EMIT_V3MML, by itself, creates a new EMIT_V3MML or raises the existing
%      singleton*.
%
%      H = EMIT_V3MML returns the handle to a new EMIT_V3MML or the handle to
%      the existing singleton*.
%
%      EMIT_V3MML('Property','Value',...) creates a new EMIT_V3MML using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to emit_v3MML_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      EMIT_V3MML('CALLBACK') and EMIT_V3MML('CALLBACK',hObject,...) call the
%      local function named CALLBACK in EMIT_V3MML.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help emit_v3MML

% Last Modified by GUIDE v2.5 12-Dec-2014 15:30:32

% Begin initialization code - DO NOT EDIT

global THERING
global dossier


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @emit_v3MML_OpeningFcn, ...
                   'gui_OutputFcn',  @emit_v3MML_OutputFcn, ...
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


function emit_v3MML_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for emit_v3MML
handles.output = hObject;
 cla(handles.lattice_graf)
 axes(handles.lattice_graf)
 drawlattice
 drawnow
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes emit_v3MML wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function varargout = emit_v3MML_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;


function QP1_min_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
setpv('QP1L',input);
if (isempty(input))
     set(hObject,'String',num2str(5))
end


function QP1_min_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function QP1_max_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(8))
end


function QP1_max_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function QP3_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
setpv('QP3L',input);
if (isempty(input))
     set(hObject,'String',num2str(-13.29655))
end

function QP3_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function scan_Callback(hObject, eventdata, handles)
global dossier
%% parametres
%%%%%%%%%%%%%Emittance%%%%%%%%%%%
gamma=50/0.511;
emit_x=5e-6/gamma;
emit_y=5e-6/gamma;

%%% twiss initial %%%
%   B_x=34.46;
%   A_x= 4.24 ; 
%  
%   B_y=33.94;
%   A_y=4.34  ;

%%%Lecture des valeurs de quad
  
 QP2k=str2num(get(handles.QP2,'String'));
 QP3k=str2num(get(handles.QP3,'String'));
 Q_min=str2num(get(handles.QP1_min,'String'));
 Q_max=str2num(get(handles.QP1_max,'String'));
 n_pas = str2num(get(handles.pas_scan,'String'));
 paramk=linspace(Q_min,Q_max,n_pas);

%% calcul%%%%%%%%

dimensions=dim_theo_MML(Q_min,Q_max,n_pas, emit_x, emit_y, dossier);

%% Plot des dimensions
  
%   figure,
    
  handles=guidata(hObject); 
  cla(handles.dimension_graf);
  axes(handles.dimension_graf);
  errorbar(paramk, dimensions(:,1), - dimensions(:,2), dimensions(:,2),'-k','parent',handles.dimension_graf);
  hold on,
  errorbar(paramk, dimensions(:,3), - dimensions(:,4),  dimensions(:,4),'-r.','parent',handles.dimension_graf);
  drawnow
  legend('horizontal','vertical');
  xlabel('QP strength k (m^-^2)'), ylabel('transverse dimensions (m)') 
  set(gcf,'Color','white');
  
  guidata(hObject,handles); 
  

function pas_scan_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
if (isempty(input))
     set(hObject,'String',num2str(31))
end


function pas_scan_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function defaut_Callback(hObject, eventdata, handles)
defaultQP2=-13.29655;
defaultQP3=7.905337;
defaultQP1min=5;
set(handles.QP2,'String',num2str(defaultQP2));
set(handles.QP3,'String',num2str(defaultQP3));
set(handles.QP1_min,'String',num2str(defaultQP1min));
set(handles.QP1_max,'String',num2str(8));
set(handles.pas_scan,'String',num2str(31));
setpv('QP1L',defaultQP1min);
setpv('QP2L',defaultQP2);
setpv('QP3L',defaultQP3);



function QP2_Callback(hObject, eventdata, handles)
input = str2num(get(hObject,'String'));
setpv('QP2L',input);
if (isempty(input))
     set(hObject,'String',num2str(-13.29655));
end

function QP2_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pondere_Callback(hObject, eventdata, handles)
global THERING
global dossier

%% Paramètres 
    n_MC=10000 % nombre de pas pour le calcul d'incertitude par Monte carlo

%% Lecture fichier dimensions et incertitude

%%%%%%%%%%% Cas simulé %%%%%%%%%%%%

file=[dossier '/dimension.txt'];

fid = fopen(file);
dim = fscanf(fid,'%e \t %e\t %e\t %e ',[4 Inf]);
dim=dim';

%% Transport faisceau
  
 %% paramètres transport

 QP2k=str2num(get(handles.QP2,'String'));
 QP3k=str2num(get(handles.QP3,'String'));
 Q_min=str2num(get(handles.QP1_min,'String'));
 Q_max=str2num(get(handles.QP1_max,'String'));
 n_pas = str2num(get(handles.pas_scan,'String'));
 paramk=linspace(Q_min,Q_max,n_pas);
  

%% Matrice faisceau

    MfaisceauX=dim(:,1).^2;
    MDelta_faisceauX=diag(2*dim(:,1).*dim(:,2));
    MfaisceauY=dim(:,3).^2;
    MDelta_faisceauY=diag(2*dim(:,3).*dim(:,4));
    
%% matrice de i mesures T11^2 2T11T12 T12^2 %%%%% a inclure directement dans le scan des dimension si camera.
    for i=1:length(paramk)
        setpv('QP1L',paramk(i));
        TD1=twissline(THERING,0,THERING{1}.TwissData,1:(length(THERING)+1)); %%%%% Attention mettre end quand maille bien défiie avec bend intégré
        Mat=cat(1,TD1.M44);
        Mtot=Mat(end-3:end,:);
    
    %Mtot= SD(SD_diag)*SD(SD31_L)*QP(QP_L,QP3k)*SD(SD2_L)*QP(QP_L,QP2k)*SD(SD2_L)*QP(QP_L,paramk(i))*SD(SD1_L);                               
        if i==1
            MtransportX=[Mtot(1,1).^2 2*Mtot(1,2).*Mtot(1,1) Mtot(1,2).^2];
            MtransportY=[Mtot(3,3).^2 2*Mtot(3,4).*Mtot(3,3) Mtot(3,4).^2];
        else
            MtransportX=[MtransportX ; Mtot(1,1).^2 2*Mtot(1,2).*Mtot(1,1) Mtot(1,2).^2];
            MtransportY=[MtransportY ; Mtot(3,3).^2 2*Mtot(3,4).*Mtot(3,3) Mtot(3,4).^2];
        end
    end    
    

%% Moindre carré pondéré (ou pas) 
   
    % Moindre carré ordinaire
    % MTwissinit=(inv(Mtransport'*Mtransport)*Mtransport')*Mfaisceau;
   
    % Moindre carré pondéré avec la matrice des variances/covariances
    MTwissinitX=inv(MtransportX'*inv(MDelta_faisceauX)*MtransportX)*MtransportX'*inv(MDelta_faisceauX)*MfaisceauX;
    MTwissinitY=inv(MtransportY'*inv(MDelta_faisceauY)*MtransportY)*MtransportY'*inv(MDelta_faisceauY)*MfaisceauY;

%% Erreur par monte carlo
    
    %Création de la matrice faisceau contenant n_MC fois la valeur d'une dimension pour chauqe valeur de k 
    for i=1:length(paramk)
       Mfaisceau2X=(dim(i,1)+dim(i,2)*randn(n_MC,1)).^2;
       Mfaisceau2Y=(dim(i,3)+dim(i,4)*randn(n_MC,1)).^2;
       if i==1
            MfaisceauMCX=Mfaisceau2X;
            MfaisceauMCY=Mfaisceau2Y;
      else
           MfaisceauMCX=[MfaisceauMCX Mfaisceau2X];
           MfaisceauMCY=[MfaisceauMCY Mfaisceau2Y];
       end
    end
    
    disp('Calcul en cours, attendre SVP....')
    %Résolution par Moindre carré pondéré pour chaque tirage
    for i=1:n_MC
        MTwissX=inv(MtransportX'*inv(MDelta_faisceauX)*MtransportX)*MtransportX'*inv(MDelta_faisceauX)*MfaisceauMCX(i,:)';
        MTwissY=inv(MtransportY'*inv(MDelta_faisceauY)*MtransportY)*MtransportY'*inv(MDelta_faisceauY)*MfaisceauMCY(i,:)';
        if i==1
            MTwissMCX=MTwissX;
            MTwissMCY=MTwissY;
       else
           MTwissMCX=[MTwissMCX MTwissX];
           MTwissMCY=[MTwissMCY MTwissY];

       end
    end
    

%% Emittance et paramètres de twiss reconstruits

%%%%%%

emitMCX = mean(sqrt(MTwissMCX(1,:).*MTwissMCX(3,:)-MTwissMCX(2,:).^2))
emitMCtotX = sqrt(MTwissMCX(1,:).*MTwissMCX(3,:)-MTwissMCX(2,:).^2);
Twiss_betaMCX  = mean(MTwissMCX(1,:))/emitMCX
Twiss_alphaMCX = mean(MTwissMCX(2,:))/emitMCX
Twiss_gammaMCX = mean(MTwissMCX(3,:))/emitMCX

emitMCY = mean(sqrt(MTwissMCY(1,:).*MTwissMCY(3,:)-MTwissMCY(2,:).^2))
emitMCtotY = sqrt(MTwissMCY(1,:).*MTwissMCY(3,:)-MTwissMCY(2,:).^2);
Twiss_betaMCY  = mean(MTwissMCY(1,:))/emitMCY
Twiss_alphaMCY = mean(MTwissMCY(2,:))/emitMCY
Twiss_gammaMCY = mean(MTwissMCY(3,:))/emitMCY
%% affichage des valeurs   
 
set(handles.emit,'String',num2str(emitMCX*1e9));
set(handles.beta,'String',num2str(Twiss_betaMCX));
set(handles.alpha,'String',num2str(Twiss_alphaMCX));
set(handles.gamma,'String',num2str(Twiss_gammaMCX));


%%calcul des erreurs
set(handles.emit_er,'String',num2str(std(emitMCtotX)*1e9));
set(handles.beta_er,'String',num2str(std(MTwissMCX(1,:))/emitMCX));
set(handles.alpha_er,'String',num2str(std(MTwissMCX(2,:))/emitMCX));
set(handles.gamma_er,'String',num2str(std(MTwissMCX(3,:))/emitMCX))


%% plot des ellipses d'emittance 
handles=guidata(hObject); 
  cla(handles.twiss_graf);
  ellipseX=@(x,xp) Twiss_gammaMCX*x.^2+2*Twiss_alphaMCX*x.*xp+Twiss_betaMCX*xp.^2-emitMCX;
  ellipseY=@(x,xp) Twiss_gammaMCY*x.^2+2*Twiss_alphaMCY*x.*xp+Twiss_betaMCY*xp.^2-emitMCY;

  bornemax1=max([2*sqrt(Twiss_betaMCX*emitMCX) 2*sqrt(Twiss_betaMCY*emitMCY)]);
  bornemax2=max([2*sqrt(Twiss_gammaMCY*emitMCY)  2*sqrt(Twiss_gammaMCY*emitMCY)]);
    %subplot(1,2,1) 
    hold on,
    ezplot(ellipseX,[-bornemax1, bornemax1,- bornemax2, bornemax2],'parent',handles.twiss_graf);
    %set(ellgaussX,'Color','blue');
    hold on,
    pause
   
    ezplot(ellipseY,[-bornemax1, bornemax1,- bornemax2, bornemax2],'parent',handles.twiss_graf);
    %set(ellgaussY,'Color','red');
    set(gcf,'Color','white');
    legend('horizontal','vertical')
  
  guidata(hObject,handles); 

function Variance_Callback(hObject, eventdata, handles)
global THERING
global dossier

%% dimensions file
file=[dossier '/dimension.txt'];

fid = fopen(file);
dim = fscanf(fid,'%e \t %e\t %e\t %e ',[4 Inf]);
dim=dim';
%% paramètres transport

 QP2k=str2num(get(handles.QP2,'String'));
 QP3k=str2num(get(handles.QP3,'String'));
 Q_min=str2num(get(handles.QP1_min,'String'));
 Q_max=str2num(get(handles.QP1_max,'String'));
 n_pas = str2num(get(handles.pas_scan,'String'));
 paramk=linspace(Q_min,Q_max,n_pas);
 
%% Matrice faisceau

    Mfaisceau=dim(:,1).^2;
    MDelta_faisceau=diag(2*dim(:,1).*dim(:,2));

%% matrice de i mesures T11^2 2T11T12 T12^2 %%%%% a inclure directement dans le scan des dimension si camera.
    for i=1:length(paramk)
        setpv('QP1L',paramk(i));
        TD1=twissline(THERING,0,THERING{1}.TwissData,1:(length(THERING)+1)); %%%%% Attention mettre end quand maille bien défiie avec bend intégré
        Mat=cat(1,TD1.M44);
        Mtot=Mat(end-3:end,:);
    
    %Mtot= SD(SD_diag)*SD(SD31_L)*QP(QP_L,QP3k)*SD(SD2_L)*QP(QP_L,QP2k)*SD(SD2_L)*QP(QP_L,paramk(i))*SD(SD1_L);                               
        if i==1
            Mtransport=[Mtot(1,1).^2 2*Mtot(1,2).*Mtot(1,1) Mtot(1,2).^2];
        else
            Mtransport=[Mtransport ; Mtot(1,1).^2 2*Mtot(1,2).*Mtot(1,1) Mtot(1,2).^2];
        end
    end
 %% Moindre carré ordinaire
     MTwissinit=(inv(Mtransport'*Mtransport)*Mtransport')*Mfaisceau;
     emit = sqrt(MTwissinit(1,1)*MTwissinit(3,1)-MTwissinit(2,1)^2)
     Twiss_beta  = MTwissinit(1,1)/emit
     Twiss_alpha = MTwissinit(2,1)/emit
     Twiss_gamma = MTwissinit(3,1)/emit
     
 
set(handles.emit,'String',num2str(emit*1e9));
set(handles.beta,'String',num2str(Twiss_beta));
set(handles.alpha,'String',num2str(Twiss_alpha));
set(handles.gamma,'String',num2str(Twiss_gamma));

%% erreur variance

Mvartwiss = inv(Mtransport'*Mtransport)*Mtransport'*MDelta_faisceau*Mtransport*inv(Mtransport'*Mtransport)
%set(handles.QP2,'String',num2str(test));
%emit_error=1/(2*emit)*(Twiss_gamma*Mvartwiss(1,1)+Twiss_beta*Mvartwiss(3,3)+2*Twiss_alpha*Mvartwiss(2,2));
emitvardep=(1/(4*emit^2))*(MTwissinit(3,1)^2*Mvartwiss(1,1)+4*MTwissinit(2,1)^2*Mvartwiss(2,2)+MTwissinit(1,1)^2*Mvartwiss(3,3)); 
emitvar1dep=emitvardep+(1/(4*emit^2))*(2*MTwissinit(1,1)*MTwissinit(3,1)*Mvartwiss(1,3)-4*MTwissinit(2,1)*MTwissinit(3,1)*Mvartwiss(1,2)-4*MTwissinit(2,1)*MTwissinit(1,1)*Mvartwiss(2,3))
set(handles.emit_er,'String',num2str(emitvar1dep*1e9));
set(handles.beta_er,'String',num2str(Mvartwiss(1,1)/emit));
set(handles.alpha_er,'String',num2str(Mvartwiss(2,2)/emit));
set(handles.gamma_er,'String',num2str(Mvartwiss(3,3)/emit))

%% affichage des valeurs   
 
set(handles.emit,'String',num2str(emit*1e9));
set(handles.beta,'String',num2str(Twiss_beta));
set(handles.alpha,'String',num2str(Twiss_alpha));
set(handles.gamma,'String',num2str(Twiss_gamma));

%% plot des ellipses d'emittance 
handles=guidata(hObject); 
  cla(handles.twiss_graf);
  ellipse=@(x,xp) Twiss_gamma*x.^2+2*Twiss_alpha*x.*xp+Twiss_beta*xp.^2-emit;
  bornemax=max([2*sqrt(Twiss_beta*emit) 2*sqrt(Twiss_gamma*emit)]);

    ellgauss=ezplot(ellipse,[-2*sqrt(Twiss_beta*emit),2*sqrt(Twiss_beta*emit),-2*sqrt(Twiss_gamma*emit),2*sqrt(Twiss_gamma*emit)],'parent',handles.twiss_graf);
    set(ellgauss,'Color','black');
  set(gcf,'Color','white');
  
  guidata(hObject,handles); 


function radiobutton1_Callback(hObject, eventdata, handles)


function Untitled_1_Callback(hObject, eventdata, handles)


function Untitled_2_Callback(hObject, eventdata, handles)


function Untitled_3_Callback(hObject, eventdata, handles)


function choix_dossier_Callback(hObject, eventdata, handles)
global dossier
dossier=uigetdir


function AT_Callback(hObject, eventdata, handles)


function Tango_Callback(hObject, eventdata, handles)


function Analyse_image_Callback(hObject, eventdata, handles)
global dossier
[a, b]=analyse_image(dossier)


function scanTango_Callback(hObject, eventdata, handles)


function SST1_Callback(hObject, eventdata, handles)


function SST2_Callback(hObject, eventdata, handles)


function SST3_Callback(hObject, eventdata, handles)
