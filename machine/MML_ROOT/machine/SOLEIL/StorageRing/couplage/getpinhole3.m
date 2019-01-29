function [FileName eps_x eps_z rms_x_source rms_z_source rms_x_convavantdec rms_z_convavantdec] = getpinhole3(varargin)
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

for i = length(varargin):-1:1
    if strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoArchive')
        ArchiveFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Script')
        ScriptFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoScript')
        ScriptFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Archive')
        ArchiveFlag = 1;
        varargin(i) = [];
    end
end

% Starting time
t0 = clock;
FileName = '';
devName = 'ANS-C16/DG/' ; 
dev             = [devName 'PHC-VG'];
devAna          = [devName 'PHC-IMAGEANALYZER'];
devatt          = [devName 'PHC-M.ATT'];
devpoint        = [devName 'PHC-M.CAM1.VERT'];
devposH         = [devName 'PHC-M.CAM2_HORZ'];
devposV         = [devName 'PHC-M.CAM2_HORZ2'];
devpinholeH     = [devName 'PHC-M.PH_HORZ'];
devpinholeV     = [devName 'PHC-M.PH_VERT'];
devpinholegonio = [devName 'PHC-M.PH_GONIO'];
devpinholerot   = [devName 'PHC-M.PH_ROT'];
devemit         = [devName 'PHC-EMIT'];

% ANS-C16/DG/PHC-VG/image
temp=tango_read_attribute2(dev,'image');
%temp=tango_read_attribute2(dev,'image'); % MAJ TANGO  RUN4 2014
ImagePHC = temp.value';
rep.image = ImagePHC;
rep.current = getdcct;

rep.growth = readattribute([devAna '/OpticalMagnification']);
a=tango_get_property(devemit,'DistPinholeH2Convert') ; rep.DistPinholeH2Convert = str2num(a.value{:}) ;	
a=tango_get_property(devemit,'DistPinholeV2Convert') ; rep.DistPinholeV2Convert = str2num(a.value{:})	;
a=tango_get_property(devemit,'DistSource2PinholeH') ; rep.DistSource2PinholeH = str2num(a.value{:});
a=tango_get_property(devemit,'DistSource2PinholeV') ; rep.DistSource2PinholeV = str2num(a.value{:});

rep.pixelsizex = readattribute([devAna '/PixelSizeX']);
rep.pixelsizez = readattribute([devAna '/PixelSizeY']);
rep.betaX = readattribute([devemit '/BetaX']);
rep.betaZ = readattribute([devemit '/BetaZ']);
rep.etaX = readattribute([devemit '/EtaX']);
rep.etaZ = readattribute([devemit '/EtaZ']);
rep.gamma = readattribute([devAna '/GammaCorrection']);
rep.sigmax = readattribute([devAna '/XProjFitSigma']);
rep.magnitudex = readattribute([devAna '/XProjFitMag']);
rep.sigmaz = readattribute([devAna '/YProjFitSigma']);
rep.magnitudez = readattribute([devAna '/YProjFitMag']);
rep.attenuateur = readattribute([devatt '/position']);
rep.pos_H_pinhole =  readattribute([devpinholeH '/position']); % position H de la pinhole
rep.pos_V_pinhole =  readattribute([devpinholeV '/position']); % position V de la pinhole
rep.pos_gonio_pinhole = readattribute([devpinholegonio '/position']); % position gonio de la pinhole
rep.pos_rot_pinhole = readattribute([devpinholerot '/position']); % position rotation de la pinhole
rep.point = readattribute([devpoint '/position']); % mise au point camera 2
rep.posH = readattribute([devposH '/position']); % position horizontale camera 2
rep.posV = readattribute([devposV '/position']); % position verticale (vis à vis du convertisseur) camera 2
rep.X = tango_read_attribute2(devAna,'XProj');
rep.Z = tango_read_attribute2(devAna,'YProj');
rep.fitX = tango_read_attribute2(devAna,'XProjFitted');
rep.fitZ = tango_read_attribute2(devAna,'YProjFitted');
rep.GaussianFitTilt = readattribute([devAna '/GaussianFitTilt']);
rep.pinholesizeV = readattribute([devemit '/PinholeSizeV']);
rep.pinholesizeH = readattribute([devemit '/PinholeSizeH']);
rep.emittanceX = readattribute([devemit '/EmittanceH']);
rep.emittanceZ = readattribute([devemit '/EmittanceV']);
%rep.QT1 = getam('QT', [1 1])

if DisplayFlag
    date1 = datestr(now,0);
    %figure(101);
    figure
    image(ImagePHC,'CDataMapping','scaled','Parent',gca)
    %figure(105);
    addlabel(1,0,sprintf('%s', date1));

    figure
    plot(rep.fitX.value,'k') ; hold on ; plot(rep.X.value,'r') ;
    xlabel('numero de pixel')
    plot(rep.fitZ.value,'p') ; hold on ; plot(rep.Z.value,'b') ; legend('fit H de l''ImageAnalyser','Données brutes H','fit V de l''ImageAnalyser','Données brutes V')
    xlabel('numero de pixel')
    title('Profils H et V projetés dans la région d''interet (ROI)');
    hold off
    addlabel(1,0,sprintf('%s', date1));
    %%%%%%%%%%%%%%% WARNING

end

%%% test du gamma
if rep.gamma ~= 1
    disp('gamma caméra n''est pas à sa valeur correcte') % test sur la valeur de gamma
    return
end

%%% pixel intensité max
Max_image_brute = max(max(ImagePHC));
warning_intensite = 0;
if Max_image_brute>4000
    disp('l''image est saturée - modifier l''atténuateur') % test sur la saturation de l'image
    RES = [double(Max_image_brute)];
    fprintf('max pixel =  %13.2f \n',RES )
    %return
elseif Max_image_brute<300
    warning_intensite = 1;
end


if ArchiveFlag
    toto = 0;
    if isempty(FileName)
        %FileName = appendtimestamp(getfamilydata('Default', 'PINHOLEArchiveFile')); % a completer dans soleilinit
        FileName = appendtimestamp('PINHOLE3'); % a completer dans soleilinit

        DirectoryName = getfamilydata('Directory', 'PINHOLE');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot'), 'Response', filesep, 'BPM', filesep];
        else
            % Make sure default directory e('l''image est saturée - modifier l''atténuateur')xists
            DirStart = pwd;
            [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
            cd(DirStart);
        end
        [FileName, DirectoryName] = uiputfile('*.mat', 'Select a Pinhole File ("Save" starts measurement)', [DirectoryName FileName]);
        if FileName == 0
            ArchiveFlag = 0;
            disp('   Pinhole registration canceled.');
            toto = 1;
            %return
        else
            FileName = [DirectoryName, FileName];
        end

    elseif FileName == -1
        FileName = appendtimestamp(getfamilydata('Default', 'QUADArchiveFile'));
        DirectoryName = getfamilydata('Directory', 'QUAD');
        FileName = [DirectoryName, FileName];
    end

    rep.CreatedBy = 'getpinhole';
    rep.t         = t0;
    rep.tout      = etime(clock,t0);
    rep.TimeStamp = datestr(clock);
    if toto == 0
        save(FileName,'rep');
    end
    fprintf('Data save in filename %s \n', FileName);
    %fprintf('***************************************************************** \n');

end

if ~ScriptFlag
    
    if rep.attenuateur==4100
        pos_attenuateur = '    att<100mA';
    elseif rep.attenuateur==15450
        pos_attenuateur = '    att>100mA';
     elseif rep.attenuateur==6100
        pos_attenuateur = '    att<15mA';   
    else 
        pos_attenuateur = '    unknown';   
    end
    fprintf('*********** paramètres instrumentation pinhole **************** \n');
    fprintf('atténuateur (nb pas)                     %10.4f \n',rep.attenuateur);
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
    
    
    fprintf('*********** paramètres faisceau généraux ********************** \n');
    fprintf('courant dcct %20.2f \n', rep.current);
    fprintf('Intensité maximale sur la CCD %14.2f \n',Max_image_brute);
    
    fprintf('***** paramètres faisceau sur convertisseur X-> visible ******* \n');
    fprintf('sigmax au convertisseur en µm %14.2f \n', rep.sigmax);
    fprintf('sigmaz au convertisseur en µm %14.2f \n', rep.sigmaz);
    
    fprintf('********* paramètres faisceau au point source ***************** \n');
    % fprintf('sigmax au point source en µm %14.2f \n', rep.sigmax/(rep.DistPinholeH2Convert/rep.DistSource2PinholeH));
    % fprintf('sigmaz au point source en µm %14.2f \n', rep.sigmaz/(rep.DistPinholeV2Convert/rep.DistSource2PinholeV));
    sigmax_point_source = 1e6*sqrt(rep.emittanceX*1e-9*rep.betaX + rep.etaX*rep.etaX*1.01e-3*1.01e-3);
    sigmaz_point_source = 1e6*sqrt(rep.emittanceZ*1e-12*rep.betaZ + rep.etaZ*rep.etaZ*1.01e-3*1.01e-3);
    
    fprintf('sigmax au point source en µm  %14.2f \n', sigmax_point_source);
    fprintf('sigmaz au point source en µm  %14.2f \n', sigmaz_point_source);
    fprintf('tilt de l''ellipse            %14.2f \n', rep.GaussianFitTilt);
    
    fprintf('******************************************************************************************************* \n');
    if ~isnan(rep.GaussianFitTilt)
        fprintf('PHC3---I dcct (mA)---Emittance X(nm)---Emittance Z(pm)----Couplage (10-2)-- Tilt (°) --- Pos Atténuateur \n')
        %RES = [rep.current  rep.emittanceX rep.emittanceZ (rep.emittanceZ/rep.emittanceX)/10  rep.GaussianFitTilt   pos_attenuateur]; % modif 7 sept 2008 -> == DSERVER EMITTANCE
        %fprintf('   %8.2f      %8.2f         %8.2f            %8.2f    %8.2f    %s   \n',RES)
        fprintf('   %10.2f      %10.2f         %10.2f            %10.2f    %10.2f    %s   \n',rep.current , rep.emittanceX ,rep.emittanceZ ,(rep.emittanceZ/rep.emittanceX)/10 , rep.GaussianFitTilt ,  pos_attenuateur)
    else
        fprintf('PHC3---I dcct (mA)---Emittance X(nm)---Emittance Z(pm)----Couplage (10-2)--  Pos Atténuateur \n')
        %RES = [rep.current  rep.emittanceX rep.emittanceZ (rep.emittanceZ/rep.emittanceX)/10  pos_attenuateur]; % modif 7 sept 2008 -> == DSERVER EMITTANCE
        fprintf('   %10.2f      %10.2f         %10.2f            %10.2f     %s   \n',rep.current,  rep.emittanceX, rep.emittanceZ ,(rep.emittanceZ/rep.emittanceX)/10 , pos_attenuateur)

    end
    fprintf('******************************************************************************************************* \n');
    
end

if warning_intensite == 1
        disp('   Attention l''illumination de la camera est faible ');
        disp('   Veillez à recommencer en diminuant l''atténuateur ');
end


