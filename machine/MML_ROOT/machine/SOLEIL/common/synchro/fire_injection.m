function [r1,r2]=fire_injection(handles)

set(handles.button_injection_soft,'Enable','inactive');

offset_linac=10*str2double(get(handles.lin_canon_spm_fin,'String'));     % dÃ©lai fin de rÃ©glage en pas de 100 ps
%modeinj=get(get(handles.uipanel_mode,'SelectedObject'),'Tag');           % mode soft ou 3Hz
modeinj='togglebutton_3Hz';
modecent=get(get(handles.uipanel_central_mode,'SelectedObject'),'Tag');  % mode rafale ou continu (cas 3Hz)
modefill=get(handles.listbox_fillingmode,'Value');
pattern= get(handles.listbox_fillingmode,'String');                      % mode de remplissage
[clk1,clk2]=get_start_clk_rafale;                                        % get clk spare et soft initiaux
table=handles.table;                                                     % table de dÃ©lais


%FileName = fullfile(getfamilydata('Directory', 'Synchro'), 'table.mat');
FileName = [handles.DirName 'table.mat'];
load(FileName, 'table');     % pour palier aux handles via timer non mis Ã  jour !!!!!!
nb=table(1) ;                % Nombre de paq
dtour=table(2:1+nb);         % delais associÃ©s extraction, tour booster
paq  =table(2+nb:1+2*nb);    % delais associÃ©s linac, saut de paquets


dt=1.5; % dÃ©lais pour acquisitions rendements

%Initialise data pour les rendements
try
    q1=0;q2=0;n=0;
    temp=tango_read_attribute2('ANS/DG/DCCT-CTRL','current');anscur0=temp.value;
    temp=tango_read_attribute2('ANS/DG/DCCT-CTRL','lifeTime');anstau0=temp.value;
    %temp=tango_read_attribute2('ANS-C14/DG/DCCT','current');anscur0=temp.value;
catch
    disp('Erreur lecture DCCT, skipped')
    anscur0=0;
end

boucle=int16(str2double(get(handles.edit_Ncycle,'String')));
Ncoup=str2double(get(handles.edit_Ncoup,'String'));

if strcmp(modeinj,'togglebutton_soft')
    modeinj='Injection soft';
    for k=1:boucle
        for i=1:nb
            clk_spare  =int32(clk1+dtour(i));
            clk_soft=int32(clk2+dtour(i));
            table0=int32([1 0 paq(i)]);
            tango_command_inout2('ANS/SY/CENTRAL','SetTables',table0); pause(0.2)  ;
            tango_write_attribute2('ANS/SY/CENTRAL', 'TSprStepDelay',clk_spare);
            tango_write_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay',clk_soft);
            tango_command_inout2('ANS/SY/CENTRAL','FireSoftEvent');
            pause(dt)
            [q1,q2,n]=getcharge(q1,q2,n);
        end
    end

    % retour dÃ©lais initiaux
    tango_write_attribute2('ANS/SY/CENTRAL', 'TSprStepDelay',clk1);
    tango_write_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay',clk2);

elseif strcmp(modeinj,'togglebutton_3Hz')

    if strcmp(modecent,'continuous_mode')

        %             modelinac=get(get(handles.uipanel_lpm_spm_mode,'SelectedObject'),'Tag');
        %             switch modelinac  % Get Tag of selected object
        %                 case 'no_mode'
        %                     event=[0 0];
        %                 case 'lpm_mode'
        %                     event=[2 0];
        %                 case 'spm_mode'
        %                     event=[0 2];
        %             end
        %
        %             modeinj='Injection 3 Hz';
        %             start_3Hz(event)
        %             pause(Ncoup*0.340 + 0.340)
        %             stop_3Hz

    elseif strcmp(modecent,'burst_mode')

        modeinj='Injection rafale';
        tango_command_inout2('ANS/SY/CENTRAL','FireBurstEvent');
        dtt=Ncoup*boucle*0.340 + 5;
        pause(dtt) % durée rafale + pause lecture DCCT
        [q1,q2,n]=getcharge(q1,q2,n);
    end
end

% Calcul des rendements
%pause(dt);
try
    temp=tango_read_attribute2('ANS/DG/DCCT-CTRL','current');anscur=temp.value;
    %temp=tango_read_attribute2('ANS-C14/DG/DCCT','current');anscur=temp.value;
catch
    disp('Erreur lecture DCCT, skipped')
    anscur=0;
end
%modeinj=get(get(handles.uipanel_mode,'SelectedObject'),'Tag');
modinj='togglebutton_3Hz';
tcur = anscur0*dtt/(anstau0*3600); % correction from lifetime losses
dcur=anscur-anscur0;
if strcmp(modeinj,'togglebutton_soft')
    % moyenne sur chaque tirs
    r1=0;if (q1~=0);r1=q2/q1*100;end
    r2=0;if (q2~=0);r2=dcur/q2*0.524*416/184*100;end
    if(r1<0);r1=0;elseif(r1>100);r1=100;end
    if(r2<0);r2=0;elseif(r2>100);r2=100;end
    q1=q1/n;q2=q2/n;dcur=dcur/n;
else
    % estime sur dernier tir
    r1=0;if (q1~=0);r1=q2/q1*100;end
    r2=0;if (q2~=0);r2=dcur/Ncoup/double(boucle)/q2*0.524*416/184*100;end
    if(r1<0);r1=0;elseif(r1>100);r1=100;end
    if(r2<0);r2=0;elseif(r2>100);r2=100;end
    q1=q1/n;q2=q2/n;dcur=dcur/n;
end

set(handles.edit_qlt1,'String',num2str(q1,'%5.2f'));
set(handles.edit_iboo,'String',num2str(q2/0.524,'%5.2f'));
set(handles.edit_dians,'String',num2str(dcur,'%5.2f'));
set(handles.edit_rboo,'String',num2str(int16(r1)));
set(handles.edit_rans,'String',num2str(int16(r2)));
set(handles.edit_cycle,'String',num2str(n,'%g'));
set(handles.edit_dians1,'String',num2str(dcur,'%5.2f'));
set(handles.edit_courant_total,'String', num2str(anscur,'%5.2f'));

try
    temp=tango_read_attribute2('ANS/DG/BPM-tunex','Nu'); nux=temp.value;
    temp=tango_read_attribute2('ANS/DG/BPM-tunez','Nu'); nuz=temp.value;
    temp=tango_read_attribute2('ANS-C03/RF/lle.1','voltageRF');v1=temp.value(1);
    temp=tango_read_attribute2('ANS-C03/RF/lle.2','voltageRF');v2=temp.value(1);
    temp=tango_read_attribute2('ANS-C02/RF/lle.3','voltageRF');v3=temp.value(1);
    temp=tango_read_attribute2('ANS-C02/RF/lle.4','voltageRF');v4=temp.value(1);
    vrf=(v1+v2+v3+v4)/1000;
catch
    disp('Erreur lecture tunes voltage : skipped')
    nux = NaN;
    nuz = NaN;
    vrf = NaN;
end

% renseigne les rendements
try
    tango_write_attribute2('ANS/DG/PUB-FillingMode', 'rendement_BOO',r1)
    tango_write_attribute2('ANS/DG/PUB-FillingMode', 'rendement_ANS',r2)
catch

end

txt=modeinj;
txt(1:13)='';
fprintf('%s  /  %s  %d Coups  %s  /  R=%5.2f %5.2f   I=%5.3f A  /  Tunes=%5.3f %5.3f  Vrf=%5.2f MV\n',...
    datestr(clock),txt,Ncoup*boucle,pattern{modefill},r1,r2,anscur, nux,nuz,vrf);


set(handles.button_injection_soft,'Enable','On');

