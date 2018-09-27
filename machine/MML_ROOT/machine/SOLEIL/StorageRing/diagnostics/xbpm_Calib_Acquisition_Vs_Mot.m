%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Acquisition des données pour la calibration d'un XBPM
%       à partir d'un scan moteur 
%               Groupe diagnostics - mai 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function filename_data = xbpm_Calib_Acquisition_Vs_Mot(devXbpm_m,devXbpm,gap,rep)

% Device settings
attr_list_XBPM      =   {'current1','current2','current3','current4','xPos','zPos','State'};
attr_list_motXBPM   =   {'position','State'};
C                   =   strcmp(strcat(devXbpm,'-M_X'),devXbpm_m);
if (C==1) axe='X';
else axe='Z';
end

gap_str         =   num2str(gap);
pat             =   '/';
filename_temp   =   regexprep(devXbpm_m, pat, '-');
filename_data   =   strcat(rep,'Table-Calib-',gap_str,'mm-',filename_temp,appendtimestamp(''));

% Calibration parameters
pos_step        =   0.05;
xtol            =   0.005;                                      % Tolerance for reaching set value [mm]
pos_mot_read    =   0;                                  
sleep_xbpm      =   0.5;                                 % Time to wait before reading XBPM
    % 1: Calibration between pos_min and pos_max
pos_min         =   -0.25;                                  % Range
pos_max         =   0.25;                                   % Range
    % 2: Calibration around initial position within given range
pos_range       =   0.25;
    % Choose option:
cal_opt         =   2;

% Switch on XBPM motor
tango_command_inout2(devXbpm_m,'MotorON');

% Read initial position
attr_val_list_motXBPM   =   tango_read_attributes2(devXbpm_m,attr_list_motXBPM(1));
pos_init                =   attr_val_list_motXBPM.value(1);
if (cal_opt==1) 
    pos_min=pos_min;
    pos_max=pos_max;
elseif (cal_opt==2) 
    pos_min=pos_init-pos_range;
    pos_max=pos_init+pos_range;
else
    fprintf('Troubles in calibration range option...\n');
end
NbPts=floor((pos_max-pos_min)/pos_step)         % Nb of points for calibration
    
% Start motor scan
for i=0:NbPts
pos_mot     =   pos_min+i*pos_step
    % Set xbpm motor 
tango_write_attribute2(devXbpm_m,'position', pos_mot);
attr_val_list_motXBPM = tango_read_attributes2(devXbpm_m,attr_list_motXBPM(1));
while(abs(pos_mot-pos_mot_read) > xtol)
    attr_val_list_motXBPM = tango_read_attributes2(devXbpm_m,attr_list_motXBPM(1));
    pos_mot_read=attr_val_list_motXBPM.value(1);
    pause(1);
    fprintf('Waiting motor arrival...\n');
end
pause(2);
% Check XBPM device
attr_val_list_XBPM      =   tango_read_attributes2(devXbpm,attr_list_XBPM(7));
state_xbpm              =   attr_val_list_XBPM.quality_str
pos_mot_read            =   attr_val_list_motXBPM.value(1)

    % Read blade currents
pause(sleep_xbpm);    
attr_val_list_XBPM  =   tango_read_attributes2(devXbpm,attr_list_XBPM);
I1_xbpm             =   attr_val_list_XBPM(1).value;            % [µA]
I2_xbpm             =   attr_val_list_XBPM(2).value;            % [µA]
I3_xbpm             =   attr_val_list_XBPM(3).value;            % [µA]
I4_xbpm             =   attr_val_list_XBPM(4).value;            % [µA]
xPos_xbpm           =   attr_val_list_XBPM(5).value;          % [mm]
zPos_xbpm           =   attr_val_list_XBPM(6).value;          % [mm]    
    
    % Store results
Data_xbpm           =   [gap,pos_mot_read,I1_xbpm,I2_xbpm,I3_xbpm,I4_xbpm,xPos_xbpm,zPos_xbpm];
dlmwrite(filename_data,Data_xbpm,'-append','delimiter',' ');

    % Plot current results
Data_xbpmR          =   dlmread(filename_data);    
figure(101)
subplot(2,1,1)
plot(Data_xbpmR(:,3),'-.r*');
hold on;
plot(Data_xbpmR(:,4),'-.b*');
plot(Data_xbpmR(:,5),'-.k*');
plot(Data_xbpmR(:,6),'-.g*');
hold off;
title('XBPM');
legend('I1','I2','I3','I4');
ylabel('Blade current [µA]');
xlabel('Acquisition point');
subplot(2,1,2)
plot(Data_xbpmR(:,2),'-.r*');
legend(axe);
ylabel('Motor position [mm]');
xlabel('Acquisition point');

end

% % Put back motor at initial position
tango_write_attribute2(devXbpm_m,'position', pos_init);
attr_val_list_motXBPM = tango_read_attributes2(devXbpm_m,attr_list_motXBPM(1));
while(abs(pos_init-pos_mot_read) > xtol)
    attr_val_list_motXBPM = tango_read_attributes2(devXbpm_m,attr_list_motXBPM(1));
    pos_mot_read=attr_val_list_motXBPM.value(1);
    pause(0.5);
    fprintf('Waiting motor arrival...\n');
end

% Switch off XBPM motor
tango_command_inout2(devXbpm_m,'MotorOFF');

return

% End of motor scan