%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul des coefficients de calibrations kx, kz, X0, Z0 
%       à partir d'un fichier de données
%               Groupe diagnostics - mai 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function coefs = xbpm_Calib_Calculation(filename_data,Param)

% Load parameters
axe     =   Param.axe;

% Load data file
Data                =   dlmread(filename_data,' ');
[Nlines,Ncols]      =   size(Data);
gap                 =   Data(:,1);              % ID gap [mm]
pos_mot             =   Data(:,2);          % Stage position in X [mm]
Ii                  =   zeros(Nlines,4);         % Blade current [µA]
Ii(:,1)             =   Data(:,3);
Ii(:,2)             =   Data(:,4);
Ii(:,3)             =   Data(:,5);
Ii(:,4)             =   Data(:,6);
X_xbpm              =   Data(:,7);           % Stage position in X [mm]
Z_xbpm              =   Data(:,8);           % Stage position in Z [mm]

% Compute expected position from stage
pos_xbpm_T          =   zeros(Nlines,1);       
C                   =   strcmp(axe,'X');
if (C==1)
    pos_xbpm_T=-pos_mot;        % [µm]
else
    pos_xbpm_T=-pos_mot;        % [µm]
end

% Compute xbpm position from blade currents W/O calibration coefficients
Sum_I       =   Ii(:,1)+Ii(:,2)+Ii(:,3)+Ii(:,4);
x_xbpm      =   zeros(Nlines,1);
z_xbpm      =   zeros(Nlines,1);
    % For Undulator
 if (strcmp(Param.ID_type,'Und')==1)
    x_xbpm  =   (Ii(:,1)+Ii(:,4)-Ii(:,2)-Ii(:,3))./Sum_I;
    z_xbpm  =   (Ii(:,1)-Ii(:,4)+Ii(:,2)-Ii(:,3))./Sum_I;
    % For BM
 elseif (strcmp(Param.ID_type,'BM')==1)
    x_xbpm  =   (Ii(:,1)-Ii(:,4))./(Ii(:,1)+Ii(:,4));    % Z1
    z_xbpm  =   (Ii(:,2)-Ii(:,3))./(Ii(:,2)+Ii(:,3));    % Z2
 else
     fprintf('Problem with calib_type.\n');
 end
 
if (C==1)
    pos_xbpm=x_xbpm      % [µm]
else
    pos_xbpm=z_xbpm      % [µm]
end

% Fit xbpm position from stage with xbpm position from blade currents
    % Calculate fit parameters
[pp,ErrorEst] = polyfit(pos_xbpm,pos_xbpm_T,1);
    % Get calibration coefficients
K=pp(1)
dPos=pp(2)
if (C==1)
    dPos=-dPos;     % [µm]
else
    dPos=dPos;      % [µm]
end

coefs=[K dPos]

	% Evaluate the fit
pop_fit = polyval(pp,pos_xbpm,ErrorEst);

% Plot results
if (C==1)
figure(201)
subplot(2,1,1)
[AX,H1,H2]=plotyy(pos_xbpm_T,pos_xbpm_T,pos_xbpm_T,pos_xbpm,'plot');
legend('Stage','XBPM');
set(get(AX(1),'Ylabel'),'String','Position from stage','Color','k');
set(get(AX(2),'Ylabel'),'String','Position from XBPM uncal.','Color','k');
set(H1,'Color','b');
set(H1,'Marker','+');
set(H2,'Color','r');
set(H2,'Marker','*');
xlabel('Position from Stage');
grid on;
title('Rough data');
subplot(2,1,2)
plot(pos_xbpm_T,pop_fit,'ro',pos_xbpm_T,pos_xbpm_T,'+');
legend('Fit','Stage');
xlabel('Position from Stage');
ylabel(axe);
title('Calibration');
grid on;            

else
figure(202)
subplot(2,1,1)
[AX,H1,H2]=plotyy(pos_xbpm_T,pos_xbpm_T,pos_xbpm_T,pos_xbpm,'plot');
legend('Stage','XBPM');
set(get(AX(1),'Ylabel'),'String','Position from stage','Color','k');
set(get(AX(2),'Ylabel'),'String','Position from XBPM uncal.','Color','k');
set(H1,'Color','b');
set(H1,'Marker','+');
set(H2,'Color','r');
set(H2,'Marker','*');
xlabel('Position from Stage');
grid on;
title('Rough data');
subplot(2,1,2)
plot(pos_xbpm_T,pop_fit,'ro',pos_xbpm_T,pos_xbpm_T,'+');
legend('Fit','Stage');
xlabel('Position from Stage');
ylabel(axe);
title('Calibration');
grid on; 
end

return

end