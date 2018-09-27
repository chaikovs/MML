function getEzSigmaEoverE(varargin)
% get the horizontal emittance Ex and relative dispersion in energy of the beam
% SigmaEoverE from measured horizontal beam sizes at PHINHOLE 1 and PINHOLE
% 3
% INPUT
%   'Display' affiche l'image enregistrée (par défaut)
%   'NoDisplay' le contraire..
%   'Archive' sauvegarde la structure matlab (par défaut)
%   'NoArchive' le contraire..
%
% OUTPUT
%   1 - Eps_x - Horizontal emittance
%   2 - SigmaEoverE
% January 2016

%clear all
deconvolution = 1 ; % deconvolution from diffraction and visible optical system resolution @ convertor
DisplayFlag = 1;
ScriptFlag  = 0; % no message to be used within script
ArchiveFlag = 1;
Ez_simple_computation = 0 ; %  0 = specific Ex computation taking into account radiation opening angle @ source point
MEASURE = 1 ; METIS = 0 ;
%METIS = 1 ; MEASURE = 0 ; Ez_simple_computation = 1 ;%  without Device Servers

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

%% Device settings

% pinhole 1
% subscript for "first pinhol" is 1
%
devName         = 'ANS-C02/DG/' ;
dev1            = [devName 'PHC-VG'];
devAna1         = [devName 'PHC-IMAGEANALYZER'];
devatt1         = [devName 'PHC-ATT'];
devemit1        = [devName 'PHC-EMIT'];
devMatt1        = [devName 'PHC-M.ATT'];

%
% pinhole 3
% carefull subscript for "second pinhol" is 2
%
devName         = 'ANS-C16/DG/' ;
dev2            = [devName 'PHC-VG'];
devAna2         = [devName 'PHC-IMAGEANALYZER'];
devatt2         = [devName 'PHC-ATT'];
devemit2        = [devName 'PHC-EMIT'];
devMatt2        = [devName 'PHC-M.ATT'];

disp('____________________________________________________________________________________________')
%% get measured values from first and second PHC
if MEASURE
    tmp             = tango_get_property(devemit1,'DistPinholeV2Convert')	; %5.730
    tmp2 = tmp.value{1} ; D2_1 = str2num(tmp2);
    tmp             = tango_get_property(devemit1,'DistSource2PinholeV')	; %	4.338
    tmp2 = tmp.value{1} ; D1_1 = str2num(tmp2);
    sigmaz_1          = readattribute([devAna1 '/YProjFitSigma']); % µm
    
    tmp             = tango_get_property(devemit2,'DistPinholeV2Convert')	; % 5.716
    tmp2 = tmp.value{1} ; D2_2 = str2num(tmp2);
    tmp             = tango_get_property(devemit2,'DistSource2PinholeV')	; %	4.335
    tmp2 = tmp.value{1} ; D1_2 = str2num(tmp2);
    sigmaz_2          = readattribute([devAna2 '/YProjFitSigma']); % µm
    
    %%%
    betaZ_1         = readattribute([devemit1 '/BetaZ']);
    betaZ_2         = readattribute([devemit2 '/BetaZ']);
    
    etaZ_1          = readattribute([devemit1 '/EtaZ']);
    etaZ_2          = readattribute([devemit2 '/EtaZ']);
    
    etapZ_1          = readattribute([devemit1 '/EtaPZ']);
    etapZ_2          = readattribute([devemit2 '/EtaPZ']);
    
    alphaZ_1          = readattribute([devemit1 '/AlphaZ']);
    alphaZ_2          = readattribute([devemit2 '/AlphaZ']);
    
    sigmae             = readattribute([devemit1 '/SigmaEnergy']); % hypothèse : on a bien écrit la meme valeur dans les  2 phc !!
    
    %%%
    if deconvolution
        
        disp('You use deconvolution from diffraction and visible optical system resolution @ convertor')
        
        tmp             = tango_get_property(devAna1,'OpticalMagnification')	; 
        tmp2 = tmp.value{1} ; OpticalMagnification = str2num(tmp2);
        tmp             = tango_get_property(devAna1,'PixelSizeY')	; 
        tmp2 = tmp.value{1} ; PixelSize = str2num(tmp2);
        tmp             = tango_get_property(devemit1,'CameraPixelRes'); % visible optical system resolution at CCD in pixel
        tmp2 = tmp.value{1} ; sigma_camera1  = str2num(tmp2)*PixelSize/OpticalMagnification; % visible optical system resolution at convertor in µm
        
        tmp             = tango_get_property(devAna2,'OpticalMagnification')	; 
        tmp2 = tmp.value{1} ; OpticalMagnification = str2num(tmp2);
        tmp             = tango_get_property(devAna2,'PixelSizeY')	; 
        tmp2 = tmp.value{1} ; PixelSize = str2num(tmp2);
        tmp             = tango_get_property(devemit2,'CameraPixelRes');
        tmp2 = tmp.value{1} ; sigma_camera2  = str2num(tmp2)*PixelSize/OpticalMagnification;
        
        sigma_diff1            = readattribute([devatt1 '/SigmaDiffractionV']);
        sigma_diff2            = readattribute([devatt2 '/SigmaDiffractionV'])   ;
      
        % test
%         sigma_diff1 = 4.55;
%         sigma_diff2= 4.55;

        
        sigmaz_1 = sqrt(sigmaz_1.*sigmaz_1 - sigma_camera1.*sigma_camera1 - sigma_diff1.*sigma_diff1)
        sigmaz_2 = sqrt(sigmaz_2.*sigmaz_2 - sigma_camera2.*sigma_camera2 - sigma_diff2.*sigma_diff2)
        
    end
    
    %%% get sizes at convertor in meter
    sigmaz_1        = 1e-6 *sigmaz_1;
    sigmaz_2        = 1e-6 *sigmaz_2;
    
    %%% compute separated emittances (normaly you should recover emittances
    %%% from Device EMIT)
    
    if Ez_simple_computation
        
        Ez1_reconstructed  =  Ereconstructed(sigmaz_1, D1_1,D2_1,etaZ_1,sigmae, betaZ_1)
        Ez2_reconstructed  =  Ereconstructed(sigmaz_2, D1_2,D2_2,etaZ_2,sigmae, betaZ_2)
        
        
    else % takes into account hidden part of beam at source point because of small radiation angle
        
        disp('You use specific Ex computation taking into account radiation opening angle @ source point')
        
        % typical photon angle in vertical
        tmp             = tango_get_property(devemit1,'EnergyRest')	;   
        tmp2 = tmp.value{1} ; EnergyRest = str2num(tmp2);
        tmp             = tango_get_property(devemit1,'EnergyTotal')	; 
        tmp2 = tmp.value{1} ; EnergyTotal = str2num(tmp2);
        EkeV_ref          = 8.5 ;                                       % critical energy
        EkeV_1            = readattribute([devatt1 '/Energy']) * 1e-3;  % mean energy of photons going through ph
        EkeV_2            = readattribute([devatt2 '/Energy']) * 1e-3;

        % tes
        EkeV_1 = 21 ;
        EkeV_2 = 21 ;
        
        sigma_yp_photonY_1 =  1/( EnergyTotal / EnergyRest)*(EkeV_ref / EkeV_1 )^(1/2) 
        sigma_yp_photonY_2 =  1/( EnergyTotal / EnergyRest)*(EkeV_ref / EkeV_2 )^(1/2) 
%         test = 0.015e-3 ;
%         sigma_yp_photonY_1 = test ;
%         sigma_yp_photonY_2 = test ;
%         
        % typical photon angle in horizontal
        %sigma_yp_photonX = 0.5e-3            % 0.5e-3 in DS ; % rad
        
        Ez1_reconstructed = Ereconstructed_specific(sigma_yp_photonY_1, sigmaz_1,D1_1,D2_1,etaZ_1,etapZ_1, sigmae,alphaZ_1, betaZ_1)
        Ez2_reconstructed = Ereconstructed_specific(sigma_yp_photonY_2, sigmaz_2,D1_2,D2_2,etaZ_2,etapZ_2, sigmae,alphaZ_2, betaZ_2)

        % deduce real size at source point from Ex reconstructed, taking
        % into account this specific correction
        sigmaz_1        = sqrt(betaZ_1 * Ez1_reconstructed + sigmae*sigmae*etaZ_1*etaZ_1);
        sigmaz_2        = sqrt(betaZ_2 * Ez2_reconstructed + sigmae*sigmae*etaZ_2*etaZ_2);
        % at convertor
        sigmaz_1        = sigmaz_1*(D2_1/D1_1);
        sigmaz_2        = sigmaz_2*(D2_2/D1_2);
        
    end
    
    %%% transport sizes back to source point (meter)
    sigmaz_1        = sigmaz_1*(D1_1/D2_1);
    sigmaz_2        = sigmaz_2*(D1_2/D2_2);
    
    %%% prepare Ex sigmaE/E computation
    s2_1            = sigmaz_1.*sigmaz_1 ;
    s2_2            = sigmaz_2.*sigmaz_2 ;
    s2              = [s2_1 s2_2]' ; % (m) square sizes at source point in a matrix
    
    %% check computation
else  %(MODEL)
    % AT code
    % BeamLineName	Long_Position (m)	RMS_H_Size (µm)	RMS_V_Size (µm)	RMS_H_div (µm)	RMS_V_div (µm)	betaX (m)	betaZ (m)	etax (m)	etaxp (-)	etaz (m)	etazp (m)	alphax (-)	alphaz (-)
    AT_PHC1	= [ 37.3625	44.9	24.6	96.6	1.5	0.444	15.5915	0.0154	-0.0236	0.0139	-0.0001	-0.0082	0.4055 ] ;
    AT_PHC3 = [	343.8681	62.9	18	129.1	2.1	0.6037	10.7415	0.0398	-0.078	0.0042	0.0012	0.7861	-0.1356 ] ;
    
    sigmaz_1          = AT_PHC1(3) ;
    sigmaz_2          = AT_PHC3(3) ;
    betaZ_1         = AT_PHC1(7) ;
    betaZ_2         = AT_PHC3(7) ;
    etaZ_1          = AT_PHC1(10) ;
    etaZ_2          = AT_PHC3(10) ;
    s2_1            = sigmaz_1.*sigmaz_1 ;
    s2_2            = sigmaz_2.*sigmaz_2 ;
    s2              = 1e-6 *1e-6 * [s2_1 s2_2]' ; % m square
    disp('Theoretical computation')
end

%% compute Ex and sigmaEoverE

M               = [ betaZ_1  etaZ_1.*etaZ_1 ;  betaZ_2  etaZ_2.*etaZ_2] ;

Res             = inv(M) * s2 ;
Eps_z           = Res(1);
SigmaEoverE     = sqrt(Res(2));

%% save other parameters

Ez1_DS       = readattribute([devemit1 '/EmittanceV']);
Ez2_DS       = readattribute([devemit2 '/EmittanceV']);

struct.Ez_pm               = Eps_z*1e12 ;
struct.SigmaEoverE      = SigmaEoverE ;
struct.Ez_DS_PHC1_pm       = Ez1_DS ;
struct.Ez_DS_PHC3_pm       = Ez2_DS ;
struct.SigmaEoverE_DS      = sigmae ;

struct.deconvolution    = deconvolution ;
struct.MEASURE          = MEASURE ;

if MEASURE
    struct.current          = getdcct;
    pos_att1                =  readattribute([devMatt1 '/position']);
    pos_att2                =  readattribute([devMatt2 '/position']);
    struct.pos_att1         = pos_att1    ;
    struct.pos_att2         = pos_att2    ;
end

%% plot images and results

if DisplayFlag
    fh = figure('Position',[780 600 500 400]);
    
    date1 = datestr(now,0);
    addlabel(1,0,sprintf('%s', date1));
    %
    h1 = subplot(2,2,1);
    if METIS
        load mandrill
        image(X)
        colormap(map)
    else
        temp=tango_read_attribute2(dev1,'image');
        ImagePHC = temp.value';
        image(ImagePHC,'CDataMapping','scaled','Parent',gca)
    end
    
    h2 = subplot(2,2,2);
    if METIS
        rgb = imread('ngc6543a.jpg');
        image(rgb);
    else
        temp=tango_read_attribute2(dev2,'image');
        ImagePHC = temp.value';
        image(ImagePHC,'CDataMapping','scaled','Parent',gca)
    end
    
    texte = [ 'sigmax = ' num2str(sigmaz_1) 'µm'];
    MyTitle= uicontrol(fh,'Position',[100 180 80 20],...
        'Style','text',...
        'FontSize',16,...
        'HorizontalAlignment','center',...
        'BackgroundColor',[0.702,0.78,1],...
        'String','PHC1');
    MyTitle= uicontrol(fh,'Position',[100+230 180 80 20],...
        'Style','text',...
        'FontSize',16,...
        'HorizontalAlignment','center',...
        'BackgroundColor',[0.702,0.78,1],...
        'String','PHC3');
    MyTitle= uicontrol(fh,'Position',[70 150 180 20],...
        'Style','text',...
        'FontSize',16,...
        'HorizontalAlignment','center',...
        'BackgroundColor',[0.702,0.78,1],...
        'String',[ 'sigmaz = ' num2str(sigmaz_1*1e6,3) ' µm']);
    MyTitle= uicontrol(fh,'Position',[70+230 150 180 20],...
        'Style','text',...
        'FontSize',16,...
        'HorizontalAlignment','center',...
        'BackgroundColor',[0.702,0.78,1],...
        'String',[ 'sigmaz = ' num2str(sigmaz_2*1e6,3) ' µm']   );
    
    if ~METIS
        MyTitle= uicontrol(fh,'Position',[70-10 150-20 180+20 20],...
            'Style','text',...
            'FontSize',16,...
            'HorizontalAlignment','center',...
            'BackgroundColor',[0.702,0.78,0.8],...
            'String',[ 'Ez reconstr. = ' num2str(Ez1_reconstructed* 1e12,3) ' pm']);
        MyTitle= uicontrol(fh,'Position',[70+230-10 150-20 180+20 20],...
            'Style','text',...
            'FontSize',16,...
            'HorizontalAlignment','center',...
            'BackgroundColor',[0.702,0.78,0.8],...
            'String',[ 'Ez reconstr. = ' num2str(Ez2_reconstructed* 1e12,3) ' pm']   );
                
        MyTitle= uicontrol(fh,'Position',[70-10 150-40 180+20 20],...
            'Style','text',...
            'FontSize',16,...
            'HorizontalAlignment','center',...
            'BackgroundColor',[0.702,0.78,0.8],...
            'String',[ 'Ez DS EMIT = ' num2str(Ez1_DS,3) ' pm']);
        MyTitle= uicontrol(fh,'Position',[70+230-10 150-40 180+10 20],...
            'Style','text',...
            'FontSize',16,...
            'HorizontalAlignment','center',...
            'BackgroundColor',[0.702,0.78,0.8],...
            'String',[ 'Ez DS EMIT = ' num2str(Ez2_DS,3) ' pm']   );
        
    end
    
    MyTitle= uicontrol(fh,'Position',[150 100-20 180 20],...
        'Style','text',...
        'FontSize',16,...
        'HorizontalAlignment','center',...
        'BackgroundColor',[0.702,0.78,1],...
        'String',[ 'Epsx = ' num2str(Eps_x * 1e9,3) ' nm']   );
    
    MyTitle= uicontrol(fh,'Position',[100 60-20 280 20],...
        'Style','text',...
        'FontSize',16,...
        'HorizontalAlignment','center',...
        'BackgroundColor',[0.702,0.78,1],...
        'String',[ 'SigmaE/E = ' num2str(SigmaEoverE,3)]   );
end

if ArchiveFlag
    t0 = clock;
    FileName = '';
    flag = 0;
    if isempty(FileName)
        %FileName = appendtimestamp(getfamilydata('Default', 'PINHOLEArchiveFile'));
        FileName = appendtimestamp('Ez'); % a completer les fonctions par defaut dans soleilinit
        DirectoryName = getfamilydata('Directory', 'PINHOLE');
        if isempty(DirectoryName)
            DirectoryName = [getfamilydata('Directory','DataRoot'), 'Response', filesep, 'BPM', filesep];
        else
            % Make sure default directory e('l''image est saturée - modifier l''atténuateur')xists
            DirStart = pwd;
            [DirectoryName, ErrorFlag] = gotodirectory(DirectoryName);
            cd(DirStart);
        end
        [FileName, DirectoryName] = uiputfile('*.mat', 'Select a Ex File ("Save" starts measurement)', [DirectoryName FileName]);
        if FileName == 0
            ArchiveFlag = 0;
            disp('   Ez registration canceled.');
            flag = 1;
            %return
        else
            FileName = [DirectoryName, FileName];
        end
        
    elseif FileName == -1
        FileName = appendtimestamp(getfamilydata('Default', 'QUADArchiveFile'));
        DirectoryName = getfamilydata('Directory', 'QUAD');
        FileName = [DirectoryName, FileName];
    end
    
    struct.CreatedBy = 'getEzSigmaEoverE';
    struct.t         = t0;
    struct.tout      = etime(clock,t0);
    struct.TimeStamp = datestr(clock);

    save(FileName,'struct');

    fprintf('Data save in filename %s \n', FileName);
    %fprintf('***************************************************************** \n');
    
end

%for debug
if ~Ez_simple_computation
    fprintf('%8.6f %8.6f %6.4f  %6.4f  %6.4f  %6.4f \n', sigma_yp_photonY_1,sigma_yp_photonY_2, Ez1_reconstructed*1e12, Ez1_DS,Ez2_reconstructed*1e12, Ez2_DS)
    % fprintf('%8.6f  %6.4f  %6.4f  %6.4f  %6.4f \n', sigma_yp_photonX, Ex1_reconstructed*1e9, Ex1_reconstructed1*1e9,Ex2_reconstructed*1e9, Ex2_reconstructed1*1e9)
end

end

%
function E_reconstructed  = Ereconstructed(sigmax,D1,D2,etaX,sigmae,betaX)
% comput standard formulation of emittance
E_reconstructed  = (sigmax.*sigmax*(D1/D2)*(D1/D2)  - etaX.*etaX.*sigmae*sigmae)./betaX;
end

function E_reconstructed = Ereconstructed_specific(sigma_yp_photon, sigma,D1,D2,eta,etap, sigmae,alpha, beta)

gammaPM = (1 + alpha)/beta  ;						% fonction optique gamma à ne pas confondre avec le gamma de la caméra (PM pour physique machine)

a = sigmae*sigmae*(eta*eta*gammaPM + etap*etap*beta + 2*eta*etap*alpha) + beta * sigma_yp_photon * sigma_yp_photon;
b = sigmae*sigmae * eta*eta * sigma_yp_photon * sigma_yp_photon;
c = (sigma * sigma./ (D2*D2)) * (beta + 2 * alpha * D1 + gammaPM * D1 *D1);
e = (sigma * sigma./ (D2*D2)) * ((eta - etap*D1)*(eta - etap*D1) * sigmae * sigmae + D1*D1 * sigma_yp_photon * sigma_yp_photon);

E_reconstructed = (c - a + sqrt((c - a).*(c - a) - 4*(b - e)))./2;
end













