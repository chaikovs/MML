function setpinhole(varargin)
% GETPINHOLE enregistre les images de la caméra pinhole avec les paramètres
% environnants.
% ATTENTION les devices emittance et Image Analyser doivent etre opérationnels
% et la "Region Of Interest" de l'image analyser optimisée
% INPUTS
% 'Display' affiche l'image enregistrée (par défaut)
% 'NoDisplay' le contraire..
% 'Archive' sauvegarde la structure matlab (par défaut)
% 'NoArchive' le contraire..
%
%  OUTPUTS
%  1. eps_x - Horizontal emittance
%  2. eps_z - Vertical emittance
%  3. rms_x_source - Horizontal beam size at the source point
%  4. rms_z_source - Horizontal beam size at the source point

%
% Written By Marie-Agnes Tordeux and Laurent S. Nadolski
% Modification Laurent S. Nadolski, May 25th, 2007
%   output variable to be used in scripts with no graphical interface.
%   Update new Tango interface for PHC-IMAGEANALYZER

% update 26 avril 2012 : rétro calcul des tailles aux points source

DisplayFlag = 1;
ScriptFlag  = 0; % no message to be used within script

ArchiveFlag = 1;

% for i = length(varargin):-1:1
%     if strcmpi(varargin{i},'Display')
%         DisplayFlag = 1;
%         varargin(i) = [];
%     elseif strcmpi(varargin{i},'NoDisplay')
%         DisplayFlag = 0;
%         varargin(i) = [];
%     elseif strcmpi(varargin{i},'NoArchive')
%         ArchiveFlag = 0;
%         varargin(i) = [];
%     elseif strcmpi(varargin{i},'NoDisplay')
%         DisplayFlag = 0;
%         varargin(i) = [];
%     elseif strcmpi(varargin{i},'Script')
%         ScriptFlag = 1;
%         varargin(i) = [];
%     elseif strcmpi(varargin{i},'NoScript')
%         ScriptFlag = 0;
%         varargin(i) = [];
%     elseif strcmpi(varargin{i},'Archive')
%         ArchiveFlag = 1;
%         varargin(i) = [];
%     end
% end




FileName = [ ];
DirectoryName = getfamilydata('Directory', 'PINHOLE');
if isempty(DirectoryName)
    DirectoryName = [getfamilydata('Directory','DataRoot'), 'Response', filesep, 'BPM', filesep];
else
    % Make sure default directory exists
    DirStart = pwd;
    [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
    cd(DirStart);
end
[FileName, DirectoryName] = uigetfile('*.mat', 'Select a Pinhole File ("Save" starts measurement)', [DirectoryName FileName]);
if FileName == 0
    ArchiveFlag = 0;
    disp('   Pinhole registration canceled.');
    toto = 1;
    %return
else
    FileName = [DirectoryName, FileName];
end

load(FileName)
fprintf('User selected the filename : %s \n', FileName);

if rep.gamma ~= 1
    disp('gamma camera n''est pas à sa valeur correcte') % test sur la valeur de gamma
    return
end

if DisplayFlag
    figure
    image(rep.image,'CDataMapping','scaled','Parent',gca)
    addlabel(1,0,sprintf('%s', rep.TimeStamp));

    figure
    plot(rep.fitX.value,'k') ; hold on ; plot(rep.X.value,'r') ;
    xlabel('numero de pixel')
    plot(rep.fitZ.value,'p') ; hold on ; plot(rep.Z.value,'b') ; legend('fit H de l''ImageAnalyser','Donnees brutes H','fit V de l''ImageAnalyser','Donnees brutes V')
    xlabel('numero de pixel')
    title('Profils H et V projetes dans la region d''interet (ROI)');
    hold off
    addlabel(1,0,sprintf('%s', rep.TimeStamp));
    %%%%%%%%%%%%%%% WARNING

end


%fprintf('***************************************************************** \n');


if ~ScriptFlag
    
    if rep.attenuateur==4100
        pos_attenuateur = '    att<100mA';
    elseif rep.attenuateur==2100
        pos_attenuateur = '    att>100mA';
     elseif rep.attenuateur==6100
        pos_attenuateur = '    att<15mA';   
    else 
        pos_attenuateur = '    unknown';   
    end
    fprintf('*********** parametres instrumentation pinhole **************** \n');
    fprintf('attenuateur (nb pas)                     %10.4f \n',rep.attenuateur);
    fprintf('position H de la pinhole                 %10.4f \n',rep.pos_H_pinhole);
    fprintf('position V de la pinhole                 %10.4f \n',rep.pos_V_pinhole);
    fprintf('position gonio de la pinhole             %10.4f \n',rep.pos_gonio_pinhole);
    fprintf('position rotation de la pinhole          %10.4f \n',rep.pos_rot_pinhole);
    fprintf('position H de la camera                  %10.4f \n',rep.posH);
    fprintf('position V de la camera                  %10.4f \n',rep.posV);
    fprintf('mise au point de la camera               %10.4f \n',rep.point);
    fprintf('Grandissement de la partie visible   %12.2f \n',rep.growth);
    fprintf('Distance Pinhole - Convertisseur plan H :%10.4f \n', rep.DistPinholeH2Convert);
    fprintf('Distance Pinhole - Convertisseur plan V :%10.4f \n', rep.DistPinholeV2Convert);
    fprintf('Distance source - Pinhole plan H :       %10.4f \n', rep.DistSource2PinholeH);
    fprintf('Distance source - Pinhole plan V :       %10.4f \n', rep.DistSource2PinholeV);
    fprintf('Taille des pinholes en microns:        %10.2f  H et %10.2f V\n',rep.pinholesizeH,rep.pinholesizeV);
    
    
    fprintf('*********** parametres faisceau generaux ********************** \n');
    fprintf('courant dcct %20.2f \n', rep.current);
    fprintf('Intensite maximale sur la CCD %14.2f \n',max(max(rep.image)));

    
    fprintf('***** parametres faisceau sur convertisseur X-> visible ******* \n');
    fprintf('sigmax au convertisseur en µm %14.2f \n', rep.sigmax);
    fprintf('sigmaz au convertisseur en µm %14.2f \n', rep.sigmaz);
    
    fprintf('********* parametres faisceau au point source ***************** \n');
    % fprintf('sigmax au point source en µm %14.2f \n', rep.sigmax/(rep.DistPinholeH2Convert/rep.DistSource2PinholeH));
    % fprintf('sigmaz au point source en µm %14.2f \n', rep.sigmaz/(rep.DistPinholeV2Convert/rep.DistSource2PinholeV));
    sigmax_point_source = 1e6*sqrt(rep.emittanceX*1e-9*rep.betaX + rep.etaX*rep.etaX*1.01e-3*1.01e-3);
    sigmaz_point_source = 1e6*sqrt(rep.emittanceZ*1e-12*rep.betaZ + rep.etaZ*rep.etaZ*1.01e-3*1.01e-3);
    
    fprintf('sigmax au point source en µm  %14.2f \n', sigmax_point_source);
    fprintf('sigmaz au point source en µm  %14.2f \n', sigmaz_point_source);
    fprintf('tilt de l''ellipse            %14.2f \n', rep.GaussianFitTilt);
    
    fprintf('******************************************************************************************************* \n');
    if ~isnan(rep.GaussianFitTilt)
        fprintf('---I dcct (mA)---Emittance X(nm)---Emittance Z(pm)----Couplage (10-2)-- Tilt (degre) --- Pos Attenuateur \n')
        %RES = [rep.current  rep.emittanceX rep.emittanceZ (rep.emittanceZ/rep.emittanceX)/10  rep.GaussianFitTilt   pos_attenuateur]; % modif 7 sept 2008 -> == DSERVER EMITTANCE
        %fprintf('   %8.2f      %8.2f         %8.2f            %8.2f    %8.2f    %s   \n',RES)
        fprintf('   %8.2f      %8.2f         %8.2f            %8.2f    %8.2f    %s   \n',rep.current , rep.emittanceX ,rep.emittanceZ ,(rep.emittanceZ/rep.emittanceX)/10 , rep.GaussianFitTilt ,  pos_attenuateur)
    else
        fprintf('---I dcct (mA)---Emittance X(nm)---Emittance Z(pm)----Couplage (10-2)--  Pos Attenuateur \n')
        %RES = [rep.current  rep.emittanceX rep.emittanceZ (rep.emittanceZ/rep.emittanceX)/10  pos_attenuateur]; % modif 7 sept 2008 -> == DSERVER EMITTANCE
        fprintf('   %8.2f      %8.2f         %8.2f            %8.2f     %s   \n',rep.current,  rep.emittanceX, rep.emittanceZ ,(rep.emittanceZ/rep.emittanceX)/10 , pos_attenuateur)

    end
    fprintf('******************************************************************************************************* \n');
    
end

% if warning_intensite == 1
%         disp('   Attention l''illumination de la camera est faible ');
%         disp('   Veillez à recommencer en diminuant l''atténuateur ');
% end


