function ID_RegisterBumpParmeters_MV(Created,TxtFileNameWithoutExt,Section,BPM_E,BPM_S,xBPM_E,xBPM_S,Plane,EntPosValue,ExPosValue,NbBPMs,Arg1,Arg2)
%%U20 GALAXIES
%ID_RegisterBumpParmeters_MV(0,'/home/data/GMI/U20_GALAXIES2/SESSION_2013_12_02/U20_G2','07',5,6,1,2,'H',0,0,4,'toto','titi')
% ID_RegisterBumpParmeters_MV(1,'/home/data/GMI/U20_GALAXIES2/SESSI
% ON_2013_12_02/U20_G2',7,5,6,1,2,'H',-1,-1,4,'','')

%%
%%Arg1,Arg2 can be what we want N� of spectrum or diagon or 0
%%Plane must be 'H' or 'V'
%%Section,BPM_E,BPM_S : used to build the BPM Matrix
%%EntPosValue,ExPosValue : used to settle the bump

    %%
%%Chargement et creation du fichier de sauvegarde
    if (strcmp(Plane, 'H')==1)
        Plan = 0;
        BpmStr = 'BPMx';
        CorrStr = 'HCOR';
            BumpZ_Ent = 0;
            BumpZ_Ex = 0;
            BumpX_Ent = EntPosValue;
            BumpX_Ex = ExPosValue;
    elseif (strcmp(Plane, 'V')==1)
        Plan = 1;
        BpmStr = 'BPMz';
        CorrStr = 'VCOR';
            BumpX_Ent = 0;
            BumpX_Ex = 0;
            BumpZ_Ent = EntPosValue;
            BumpZ_Ex = ExPosValue;
    else
        error('Plane must be H or V')
    end
    
   FileName = strcat(TxtFileNameWithoutExt,'.txt');
   ResultMatrix = 0;
   
   if (Created==0)
      %crée le fichier avec l'entete
      %Entete = 'Nb \t BPM1x \t BPM1z \t BPM2x \t BPM2z \t xBPM1x \t xBPM1z \t xBPM2x \t xBPM2z \t BumpX_Ent \t BumpZ_Ent \t BumpX_Ex \t BumpZ_Ex \t Nux \t Nuz \t Ex \t Ez \t I \t LifeTime \t Arg1 \t Arg2';
      save(FileName,'ResultMatrix','-ASCII')
      msgbox('The file were bumps parameters are saved has successfully been created...','This is not an error message !!!!!!!!','help');
      return
   end
         
   ResultMatrix = load(FileName,'-ASCII');
   fprintf('File loaded...')
    PosMatrix = [EntPosValue ExPosValue];
    NbBpmMatrixPos = [1:1:NbBPMs];
    NbBpmMatrixNeg = sort(-NbBpmMatrixPos);
    NbBpmMatrix =  [NbBpmMatrixNeg NbBpmMatrixPos];
    BpmMatrix = [Section BPM_E;Section BPM_S];
    
    SetOrbitBump(BpmStr,BpmMatrix,PosMatrix,CorrStr,NbBpmMatrix,'');
    %SetOrbitBump(BpmStr,BpmMatrix,PosMatrix,CorrStr,NbBpmMatrix,'FitRF');
    sleep(5)

    %%
%%Lecture des BPMs entrée et sortie1
fprintf ('\nBPMs values :')
CellValue = sprintf('%d',Section);
   BumpNb = size(ResultMatrix,1)+1;

   %%
%%Construction des différents parametres pour fabriquer le bump
EntBPMValue = sprintf('%d',BPM_E);
ExBPMValue = sprintf('%d',BPM_S);
%BPM1_DServName = strcat('ans-c0',CellValue,'/dg/bpm.',EntBPMValue);
%BPM2_DServName = strcat('ans-c0',CellValue,'/dg/bpm.',ExBPMValue);
BPM1_DServName = strcat('ans-c',CellValue,'/dg/bpm.',EntBPMValue);
BPM2_DServName = strcat('ans-c',CellValue,'/dg/bpm.',ExBPMValue);
BPM1x = tango_read_attribute(BPM1_DServName, 'XPosSA');
        fprintf('\n\tEntrance X position : %f',BPM1x.value)
    BPM1z = tango_read_attribute(BPM1_DServName, 'ZPosSA');
        fprintf('\n\tEntrance Z position : %f',BPM1z.value)
    BPM2x = tango_read_attribute(BPM2_DServName, 'XPosSA');
        fprintf('\n\tExit X position : %f',BPM2x.value)
    BPM2z = tango_read_attribute(BPM2_DServName, 'ZPosSA');
        fprintf('\n\tExit Z position : %f',BPM2z.value)

    %%
%%Lecture des xBPMs
fprintf ('\nxBPMs values :')
xEntBPMValue = sprintf('%d',xBPM_E);
xExBPMValue = sprintf('%d',xBPM_S);
%xBPM1_DServName = strcat('tdl-i0',CellValue,'-c/dg/xbpm.',xEntBPMValue);
%xBPM2_DServName = strcat('tdl-i0',CellValue,'-c/dg/xbpm.',xExBPMValue);  
xBPM1_DServName = strcat('tdl-i',CellValue,'-ln/dg/xbpm_lib.',xEntBPMValue);
xBPM2_DServName = strcat('tdl-i',CellValue,'-ln/dg/xbpm_lib.',xExBPMValue);   
    xBPM1x = tango_read_attribute(xBPM1_DServName, 'XPosSA');
    %tdl-i07-c/dg/xbpm.1
        fprintf('\n\tEntrance X position : %f',xBPM1x.value)
    xBPM1z = tango_read_attribute(xBPM1_DServName, 'ZPosSA');
        fprintf('\n\tEntrance Z position : %f',xBPM1z.value)
    xBPM2x = 0;%tango_read_attribute(xBPM2_DServName, 'xPossa');
    %    fprintf('\n\tExit X position : %f',xBPM2x.value)
    xBPM2z = 0;%tango_read_attribute(xBPM2_DServName, 'zPossa');
    %    fprintf('\n\tExit Z position : %f',xBPM2z.value)

    %%
%%Lecture des nombres d'onde, courant,...
Nux =      tango_read_attribute('ans/dg/bpm-tunex', 'Nu');
        fprintf('\nNux : %f',Nux.value)
Nuz =      tango_read_attribute('ans/dg/bpm-tunez', 'Nu');
        fprintf('\nNuz : %f',Nuz.value)
I =        tango_read_attribute('ans/dg/dcct-ctrl', 'current');
        fprintf('\nI : %f',I.value)
Lifetime = tango_read_attribute('ans/dg/dcct-ctrl', 'lifeTime');
        fprintf('\nLifeTime : %f',Lifetime.value)
Ex =      tango_read_attribute('ans-c02/dg/phc-emit', 'EmittanceH');  
        fprintf('\nEx : %f',Ex.value)
Ez =      tango_read_attribute('ans-c02/dg/phc-emit', 'EmittanceV');
        fprintf('\nEz : %f',Ez.value)
    %%
%%Sauvegarde des résultats dans le fichier crée
            ResultMatrix(BumpNb,1) = BumpNb;
            ResultMatrix(BumpNb,2) = BPM1x.value;
            ResultMatrix(BumpNb,3) = BPM1z.value;
            ResultMatrix(BumpNb,4) = BPM2x.value;
            ResultMatrix(BumpNb,5) = BPM2z.value;
            ResultMatrix(BumpNb,6) = xBPM1x.value;
            ResultMatrix(BumpNb,7) = xBPM1z.value;
            ResultMatrix(BumpNb,8) = 0;%xBPM2x.value;
            ResultMatrix(BumpNb,9) = 0;%xBPM2z.value;
            ResultMatrix(BumpNb,10) = BumpX_Ent;
            ResultMatrix(BumpNb,11) = BumpZ_Ent;
            ResultMatrix(BumpNb,12) = BumpX_Ex;
            ResultMatrix(BumpNb,13) = BumpZ_Ex;
            ResultMatrix(BumpNb,14) = Nux.value;
            ResultMatrix(BumpNb,15) = Nuz.value;
            ResultMatrix(BumpNb,16) = Ex.value;
            ResultMatrix(BumpNb,17) = Ez.value;
            ResultMatrix(BumpNb,18) = I.value;
            ResultMatrix(BumpNb,19) = Lifetime.value;
    %        ResultMatrix(BumpNb,18) = Arg1;ResultMatrix(BumpNb,19) = Arg2;

    save(FileName,'ResultMatrix','-ASCII');
    fprintf ('\nFile saved...\n')
            
end