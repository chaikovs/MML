%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               XBPM configuration file
%                   Groupe Diagnostics - mai 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function XBPM_config=XBPM_config(xbpm_param)

XBPM_config.name                =   xbpm_param.ID;
XBPM_config.xbpm_nb             =   xbpm_param.xbpm_nb;
XBPM_config.comment             =   xbpm_param.comment;
XBPM_config.rep                 =   xbpm_param.rep;

    % U20 CRISTAL
if (strcmp(XBPM_config.name,'cristal')==1)
XBPM_config.cell                =   '06';
XBPM_config.ID                  =   'U20';
XBPM_config.ID_type             =   'Und';
XBPM_config.section             =   'C';
XBPM_config.gap_min             =   5.5;
XBPM_config.gap_max             =   30;
XBPM_config.gap_scan            =   [5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 11 12 13 14 16 20 25 30];  

    % U20 GALAXIES
elseif (strcmp(XBPM_config.name,'galaxies')==1)
XBPM_config.cell                =   '07';
XBPM_config.ID                  =   'U20';
XBPM_config.ID_type             =   'Und';
XBPM_config.section             =   'C';
XBPM_config.gap_min             =   5.5;
XBPM_config.gap_max             =   30;
XBPM_config.gap_scan            =   [5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 11 12 13 14 16 20 25 30];

    % U20 PX1
elseif (strcmp(XBPM_config.name,'px1')==1)
XBPM_config.cell                =   '10';
XBPM_config.ID                  =   'U20';
XBPM_config.ID_type             =   'Und';
XBPM_config.section             =   'C';
XBPM_config.gap_min             =   5.5;
XBPM_config.gap_max             =   30;
XBPM_config.gap_scan            =   [5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 11 12 13 14 16 20 25 30];

    % U20 SWING
elseif (strcmp(XBPM_config.name,'swing')==1)
XBPM_config.cell                =   '11';
XBPM_config.ID                  =   'U20';
XBPM_config.ID_type             =   'Und';
XBPM_config.section             =   'C';
XBPM_config.gap_min             =   5.5;
XBPM_config.gap_max             =   30;
XBPM_config.gap_scan            =   [5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 11 12 13 14 16 20 25 30];

    % U20 PIX2
elseif (strcmp(XBPM_config.name,'px2')==1)
XBPM_config.cell                =   '11';
XBPM_config.ID                  =   'U24';
XBPM_config.ID_type             =   'Und';
XBPM_config.section             =   'M';
XBPM_config.gap_min             =   7.8;
XBPM_config.gap_max             =   30;
XBPM_config.gap_scan            =   [7.8 8 8.5 9 9.5 10 11 12 13 14 16 20 25 30];

    % U20 SIWS
elseif (strcmp(XBPM_config.name,'sixs')==1)
XBPM_config.cell                =   '14';
XBPM_config.ID                  =   'U20';
XBPM_config.ID_type             =   'Und';
XBPM_config.section             =   'C';
XBPM_config.gap_min             =   5.5;
XBPM_config.gap_max             =   30;
XBPM_config.gap_scan            =   [5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 11 12 13 14 16 20 25 30];

end

% Generate associate devices
cell                                    =   XBPM_config.cell;
section                                 =   XBPM_config.section;
ID                                      =   XBPM_config.ID; 
    % ID
XBPM_config.devID                       =   ['ANS-C',cell,'/EI/',section,'-',ID];
XBPM_config.attr_list_ID                =   {'gap'};
XBPM_config.gtol                        =   0.05;
    % XBPMs
XBPM_config.devXbpm                     =   ['TDL-I',cell,'-',section,'/DG/XBPM.',num2str(XBPM_config.xbpm_nb)];
XBPM_config.devXbpm_base                =   ['TDL-I',cell,'-',section,'/DG/XBPM.',num2str(XBPM_config.xbpm_nb),'-base'];
XBPM_config.attr_list_XBPM              =   {'current1','current2','current3','current4','xPos','zPos','State'};
XBPM_config.config_files_path           =   '/usr/Local/configFiles/DIAG/XBPM/';%TDL-I06-C_DG_XBPM.1
    % XBPM MOTs
XBPM_config.devXbpm_mx                  =   ['TDL-I',cell,'-',section,'/DG/XBPM.',num2str(XBPM_config.xbpm_nb),'-M_X'];
XBPM_config.devXbpm_mz                  =   ['TDL-I',cell,'-',section,'/DG/XBPM.',num2str(XBPM_config.xbpm_nb),'-M_Z'];
XBPM_config.attr_list_motXBPM           =   {'position','State'};


end