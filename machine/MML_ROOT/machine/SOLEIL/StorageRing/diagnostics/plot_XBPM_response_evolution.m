%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot xbpm response evolution using reference data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all

% Intilize data index
index           =   0;

% Load old data
old_data_file   =   '/home/data/matlab/data4mml/measdata/SOLEIL/StorageRingdata/SDL13/Data-XBPM-Diagon.txt'; 
fid             =   fopen(old_data_file);
data_old        =   textscan(fid,'%s %s %s %f %f %f %f %f %f %f %f %f',[23 inf]); 
date_old        =   [1:1:length(data_old{1})];

% Read old data with DIAGON
for i=1:length(data_old{1})
    index               =   index+1;
    Ia_atx(index)       =   data_old{9}(i)*1e-6;
    Ib_atx(index)       =   data_old{10}(i)*1e-6;
    Ic_atx(index)       =   data_old{11}(i)*1e-6;
    Id_atx(index)       =   data_old{12}(i)*1e-6;
    Isum_atx(index)     =   (data_old{9}(i)+data_old{10}(i)+data_old{11}(i)+data_old{12}(i))*1e-6;
    X_pos_atx(index)    =   (Ia_atx(index)-Ib_atx(index)-Ic_atx(index)+Id_atx(index))./Isum_atx(index);
    Z_pos_atx(index)    =   (Ia_atx(index)+Ib_atx(index)-Ic_atx(index)-Id_atx(index))./Isum_atx(index);  
    atx_XposXBPMproj(index)     =   0;
    atx_ZposXBPMproj(index)     =   0;    
end
date        =   data_old{1};    

% Load reference data since Septembre 2016
dir_name    =   '/home/data/matlab/data4mml/measdata/SOLEIL/StorageRingdata/SDL13/';   
file_list   =   dir(dir_name);

for i=1:length(file_list)
    
file_name       =   file_list(i).name;
find_temp       =   strfind(file_name, 'XBPM_response_reference');
find_temp_2     =   strfind(file_name, '.mat');

if ((find_temp==1)&(find_temp_2==44))
    % Increment
    index               =   index + 1;
    % Extract data
    load(strcat(dir_name,file_name));
    date                =   [date ; data.date];
    Ia_atx(index)       =   data.Ia_atx;
    Ib_atx(index)       =   data.Ib_atx;
    Ic_atx(index)       =   data.Ic_atx;
    Id_atx(index)       =   data.Id_atx;
    Isum_atx(index)     =   data.Isum_atx;
    X_pos_atx(index)    =   (data.Ia_atx-data.Ib_atx-data.Ic_atx+data.Id_atx)/data.Isum_atx;
    Z_pos_atx(index)    =   (data.Ia_atx+data.Ib_atx-data.Ic_atx-data.Id_atx)/data.Isum_atx;
    atx_XposXBPMproj(index)     =   data.atx_XposXBPMproj;
    atx_ZposXBPMproj(index)     =   data.atx_ZposXBPMproj;    
    Ia_nano(index)      =   data.Ia_nano;
    Ib_nano(index)      =   data.Ib_nano;
    Ic_nano(index)      =   data.Ic_nano;
    Id_nano(index)      =   data.Id_nano;
    Isum_nano(index)    =   data.Isum_nano;
    X_pos_nano(index)   =   (data.Ia_nano-data.Ib_nano-data.Ic_nano+data.Id_nano)/data.Isum_nano;
    Z_pos_nano(index)   =   (data.Ia_nano+data.Ib_nano-data.Ic_nano-data.Id_nano)/data.Isum_nano;
    nano_XposXBPMproj(index)    =   data.nano_XposXBPMproj;
    nano_ZposXBPMproj(index)    =   data.nano_ZposXBPMproj;
end
end

% Make date axis
date_index              =   [1:1:index];

% Calibration of 2017
Kx_atx                  =   4.09;
Kz_atx                  =   1.02;
Kx_nano                 =   3.3;
Kz_nano                 =   2.44;

% Plot results for ATX and NANO
h1=figure(1);clf;
set(h1,'Position',[100 100 1000 1000]);  
%
subplot(4,1,1)
% plot(date_index,X_pos_atx,'*r');hold on;
plot(date_index,X_pos_atx.*Kx_atx,'*r');hold on;
plot(date_index,atx_XposXBPMproj,'*k');hold on;
hold off;
grid on
%ylim([-0.5;0.5])
set(gca,'FontSize',8)
ax=gca;
set(ax,'XTick',date_index)
set(ax,'XTickLabel',date)
xlabel('Date')
ylabel('X position [a.u.]')
title('ATX evolution of X position')
legend('ATX meas.','ATX calc.','Location','Best')
%
subplot(4,1,2)
% plot(date_index,Z_pos_atx,'*r');hold on;
plot(date_index,Z_pos_atx.*Kz_atx,'*r');hold on;
plot(date_index,atx_ZposXBPMproj,'*k');hold on;
hold off;
grid on
%ylim([-0.5;0.5])
set(gca,'FontSize',8)
ax=gca;
set(ax,'XTick',date_index)
set(ax,'XTickLabel',date)
xlabel('Date')
ylabel('Z position [a.u.]')
title('ATX evolution of Z position')
legend('ATX meas.','ATX calc.','NANO calc.','Location','Best')
%
subplot(4,1,3)
% plot(date_index,X_pos_nano,'or');hold on;
plot(date_index,X_pos_nano.*Kx_nano,'or');hold on;
plot(date_index,nano_XposXBPMproj,'ok');hold on;
hold off;
grid on
% ylim([-0.5;0.5])
set(gca,'FontSize',8)
ax=gca;
set(ax,'XTick',date_index)
set(ax,'XTickLabel',date)
xlabel('Date')
ylabel('X position [a.u.]')
title('NANO evolution of X position')
legend('NANO meas.','NANO calc.','Location','Best')
%
subplot(4,1,4)
% plot(date_index,Z_pos_nano,'or');hold on;
plot(date_index,Z_pos_nano.*Kz_nano,'or');hold on;
plot(date_index,nano_ZposXBPMproj,'ok');hold on;
hold off;
grid on
% ylim([-0.5;0.5])
set(gca,'FontSize',8)
ax=gca;
set(ax,'XTick',date_index)
set(ax,'XTickLabel',date)
xlabel('Date')
ylabel('Z position [a.u.]')
title('NANO evolution of Z position')
legend('NANO meas.','NANO calc.','Location','Best')


