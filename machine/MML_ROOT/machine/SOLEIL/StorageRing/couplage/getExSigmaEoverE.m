function getExSigmaEoverE(varargin)
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
deconvolution   = 1 ;     
    % 1 = Ex computation takes into account deconvolution from diffraction and visible optical system resolution @ convertor
    % 0 = Ex don't take into account
DisplayFlag     = 1;
ScriptFlag      = 0;        % no message to be used within script (not used)
ArchiveFlag     = 0;
MODEL           = 0 ;           
    % 1 = force to calculate with theoretical values of the lattice (to be used in METIS for example)
    % 0 = from machine
% typical photon angle in horizontal
%sigma_yp_photonX = 0.5e-3 ;           % 0.5e-3 written in DS !!! (rad)
 %sigma_yp_photonX = 50e-3    % test avec grand cone de rayonnement (comme si pas d'algorithme)
 sigma_yp_photonX = 5e-3    % test avec moyen cone de rayonnement (comme si pas d'algorithme)

RadOpeningAngle = 1 ;   
    %  1 =  Ex computation takes into account radiation opening angle @ source point
    %  0 =  Ex don't take into account opening angle @ source point

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

%%

if ~MODEL & ~iscontrolroom
    disp('Oups you are nowhere... put MODEL = 1')
    return
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
if iscontrolroom&~MODEL
    tmp             = tango_get_property(devemit1,'DistPinholeH2Convert')	; %5.730
    tmp2 = tmp.value{1} ; D2_1 = str2num(tmp2);
    tmp             = tango_get_property(devemit1,'DistSource2PinholeH')	; %	4.338
    tmp2 = tmp.value{1} ; D1_1 = str2num(tmp2);
    sigmax_1          = readattribute([devAna1 '/XProjFitSigma']); % µm
 
    tmp             = tango_get_property(devemit2,'DistPinholeH2Convert')	; % 5.716
    tmp2 = tmp.value{1} ; D2_2 = str2num(tmp2);
    tmp             = tango_get_property(devemit2,'DistSource2PinholeH')	; %	4.335
    tmp2 = tmp.value{1} ; D1_2 = str2num(tmp2);
    sigmax_2          = readattribute([devAna2 '/XProjFitSigma']); % µm
 
    %%%
    betaX_1         = readattribute([devemit1 '/BetaX']);
    betaX_2         = readattribute([devemit2 '/BetaX']);
    
    etaX_1          = readattribute([devemit1 '/EtaX']);
    etaX_2          = readattribute([devemit2 '/EtaX']);
    
    etapX_1          = readattribute([devemit1 '/EtaPX']);
    etapX_2          = readattribute([devemit2 '/EtaPX']);
    
    alphaX_1          = readattribute([devemit1 '/AlphaX']);
    alphaX_2          = readattribute([devemit2 '/AlphaX']);
    
    sigmae             = readattribute([devemit1 '/SigmaEnergy']); % hypothèse : on a bien écrit la meme valeur dans les  2 phc !!
    
    %%%
    if deconvolution
        
        disp('You use deconvolution from diffraction and visible optical system resolution @ convertor')
        
        tmp             = tango_get_property(devAna1,'OpticalMagnification')	; %5.730
        tmp2 = tmp.value{1} ; OpticalMagnification = str2num(tmp2);
        tmp             = tango_get_property(devAna1,'PixelSizeX')	; %5.730
        tmp2 = tmp.value{1} ; PixelSize = str2num(tmp2);
        tmp             = tango_get_property(devemit1,'CameraPixelRes'); % visible optical system resolution at CCD in pixel
        tmp2 = tmp.value{1} ; sigma_camera1  = str2num(tmp2)*PixelSize/OpticalMagnification; % visible optical system resolution at convertor in µm
        
        tmp             = tango_get_property(devAna2,'OpticalMagnification')	; %5.730
        tmp2 = tmp.value{1} ; OpticalMagnification = str2num(tmp2);
        tmp             = tango_get_property(devAna2,'PixelSizeX')	; %5.730
        tmp2 = tmp.value{1} ; PixelSize = str2num(tmp2);
        tmp             = tango_get_property(devemit2,'CameraPixelRes');
        tmp2 = tmp.value{1} ; sigma_camera2  = str2num(tmp2)*PixelSize/OpticalMagnification;
        
        sigma_diff1            = readattribute([devatt1 '/SigmaDiffractionH']);
        sigma_diff2            = readattribute([devatt2 '/SigmaDiffractionH'])   ;
        
        % test
%         sigma_diff1 = 12;
%         sigma_diff2= 0;
        
        sigmax_1 = sqrt(sigmax_1.*sigmax_1 - sigma_camera1.*sigma_camera1 - sigma_diff1.*sigma_diff1);
        sigmax_2 = sqrt(sigmax_2.*sigmax_2 - sigma_camera2.*sigma_camera2 - sigma_diff2.*sigma_diff2);
        
    end
    
    %%% get sizes at convertor in meter
    sigmax_1        = 1e-6 *sigmax_1;
    sigmax_2        = 1e-6 *sigmax_2;
    
    %%% compute separated emittances (normaly you should recover emittances
    %%% from Device EMIT)
    
    if ~RadOpeningAngle
        
        Ex1_reconstructed  =  Exreconstructed(sigmax_1, D1_1,D2_1,etaX_1,sigmae, betaX_1)
        Ex2_reconstructed  =  Exreconstructed(sigmax_2, D1_2,D2_2,etaX_2,sigmae, betaX_2)
        
        
    else % takes into account hidden part of beam at source point because of small radiation angle
        
        disp('You use specific Ex computation taking into account radiation opening angle @ source point')
        
        % typical photon angle in vertical
        %sigma_yp_photonY = 1/( E_tot_electron / E_repos_electron)*(EkeV_ref / EkeV )^(1/2)
        
        
        Ex1_reconstructed = Exreconstructed_specific(sigma_yp_photonX, sigmax_1,D1_1,D2_1,etaX_1,etapX_1, sigmae,alphaX_1, betaX_1)
        Ex2_reconstructed = Exreconstructed_specific(sigma_yp_photonX, sigmax_2,D1_2,D2_2,etaX_2,etapX_2, sigmae,alphaX_2, betaX_2)
        
        % deduce real size at source point from Ex reconstructed, taking
        % into account this specific correction
        sigmax_1        = sqrt(betaX_1 * Ex1_reconstructed + sigmae*sigmae*etaX_1*etaX_1);
        sigmax_2        = sqrt(betaX_2 * Ex2_reconstructed + sigmae*sigmae*etaX_2*etaX_2);
        % at convertor
        sigmax_1        = sigmax_1*(D2_1/D1_1)
        sigmax_2        = sigmax_2*(D2_2/D1_2);
        
    end
    
    %%% transport sizes back to source point (meter)
    sigmax_1        = sigmax_1*(D1_1/D2_1);
    sigmax_2        = sigmax_2*(D1_2/D2_2);
    
    %%% prepare Ex sigmaE/E computation
    s2_1            = sigmax_1.*sigmax_1 ;
    s2_2            = sigmax_2.*sigmax_2 ;
    s2              = [s2_1 s2_2]' ; % (m) square sizes at source point in a matrix
    
    %% check computation
else  %(MODEL)
    % AT code
    % BeamLineName	Long_Position (m)	RMS_H_Size (µm)	RMS_V_Size (µm)	RMS_H_div (µm)	RMS_V_div (µm)	betaX (m)	betaZ (m)	etax (m)	etaxp (-)	etaz (m)	etazp (m)	alphax (-)	alphaz (-)
    AT_PHC1	= [ 37.3625	44.9	24.6	96.6	1.5	0.444	15.5915	0.0154	-0.0236	0.0139	-0.0001	-0.0082	0.4055 ] ;
    AT_PHC3 = [	343.8681	62.9	18	129.1	2.1	0.6037	10.7415	0.0398	-0.078	0.0042	0.0012	0.7861	-0.1356 ] ;
    
    sigmax_1          = AT_PHC1(2) ;
    sigmax_2          = AT_PHC3(2) ;
    betaX_1         = AT_PHC1(6) ;
    betaX_2         = AT_PHC3(6) ;
    etaX_1          = AT_PHC1(8) ;
    etaX_2          = AT_PHC3(8) ;
    s2_1            = sigmax_1.*sigmax_1 ;
    s2_2            = sigmax_2.*sigmax_2 ;
    s2              = 1e-6 *1e-6 * [s2_1 s2_2]' ; % m square
    disp('Theoretical computation')
end

%% compute Ex and sigmaEoverE

M               = [ betaX_1  etaX_1.*etaX_1 ;  betaX_2  etaX_2.*etaX_2] ;

Res             = inv(M) * s2 ;
Eps_x           = Res(1);
SigmaEoverE     = sqrt(Res(2));

%% save other parameters

Ex1_DS       = readattribute([devemit1 '/EmittanceH']);
Ex2_DS       = readattribute([devemit2 '/EmittanceH']);

struct.Ex_nm                = Eps_x*1e9 ;
struct.SigmaEoverE          = SigmaEoverE ;
struct.deconvolution         = deconvolution ;
struct.iscontrolroom         = iscontrolroom ;
sctruct.MODEL               = MODEL ; 

if iscontrolroom&~MODEL
    struct.current          = getdcct;
    pos_att1                =  readattribute([devMatt1 '/position']);
    pos_att2                =  readattribute([devMatt2 '/position']);
    struct.pos_att1         = pos_att1    ;
    struct.pos_att2         = pos_att2    ;
    struct.Ex_DS_PHC1_nm        = Ex1_DS ;
    struct.Ex_DS_PHC3_nm          = Ex2_DS ;
    struct.SigmaEoverE_DS         = sigmae ;
    struct.betaX_DS_PHC1_m          =   betaX_1 ;
    struct.betaX_DS_PHC3_m          =   betaX_2 ;
    struct.etaX_DS_PHC1_m           =   etaX_1 ;
    struct.etaX_DS_PHC3_m           =   etaX_2 ;
    struct.etapX_DS_PHC1          =   etapX_1 ;
    struct.etapX_DS_PHC3          =   etapX_2 ;
    struct.alphaX_DS_PHC1         =   alphaX_1 ;
    struct.alphaX_DS_PHC3         =   alphaX_2 ;

end


%% plot images and results

if DisplayFlag
    fh = figure('Position',[780 600 500 400]);
    
    date1 = datestr(now,0);
    addlabel(1,0,sprintf('%s', date1));
    %
    h1 = subplot(2,2,1);
    if MODEL
        load mandrill
        image(X)
        colormap(map)
    else
        temp=tango_read_attribute2(dev1,'image');
        ImagePHC = temp.value';
        image(ImagePHC,'CDataMapping','scaled','Parent',gca)
    end
    
    h2 = subplot(2,2,2);
    if MODEL
        rgb = imread('ngc6543a.jpg');
        image(rgb);
    else
        temp=tango_read_attribute2(dev2,'image');
        ImagePHC = temp.value';
        image(ImagePHC,'CDataMapping','scaled','Parent',gca)
    end
    
    texte = [ 'sigmax = ' num2str(sigmax_1) 'µm'];
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
    MyTitle= uicontrol(fh,'Position',[70-20 150 180+20 20],...
        'Style','text',...
        'FontSize',16,...
        'HorizontalAlignment','center',...
        'BackgroundColor',[0.702,0.78,1],...
        'String',[ 'sigmax = ' num2str(sigmax_1*1e6,3) ' µm']);
    MyTitle= uicontrol(fh,'Position',[70+230-20 150 180+20 20],...
        'Style','text',...
        'FontSize',16,...
        'HorizontalAlignment','center',...
        'BackgroundColor',[0.702,0.78,1],...
        'String',[ 'sigmax = ' num2str(sigmax_2*1e6,3) ' µm']   );
    
    if ~MODEL
        MyTitle= uicontrol(fh,'Position',[70-10 150-20 180+20 20],...
            'Style','text',...
            'FontSize',16,...
            'HorizontalAlignment','center',...
            'BackgroundColor',[0.702,0.78,0.8],...
            'String',[ 'Ex reconstr. = ' num2str(Ex1_reconstructed* 1e9,3) ' nm']);
        MyTitle= uicontrol(fh,'Position',[70+230-10 150-20 180+20 20],...
            'Style','text',...
            'FontSize',16,...
            'HorizontalAlignment','center',...
            'BackgroundColor',[0.702,0.78,0.8],...
            'String',[ 'Ex reconstr. = ' num2str(Ex2_reconstructed* 1e9,3) ' nm']   );
                
        MyTitle= uicontrol(fh,'Position',[70-10 150-40 180+20 20],...
            'Style','text',...
            'FontSize',16,...
            'HorizontalAlignment','center',...
            'BackgroundColor',[0.702,0.78,0.8],...
            'String',[ 'Ex DS EMIT = ' num2str(Ex1_DS,3) ' nm']);
        MyTitle= uicontrol(fh,'Position',[70+230-10 150-40 180+20 20],...
            'Style','text',...
            'FontSize',16,...
            'HorizontalAlignment','center',...
            'BackgroundColor',[0.702,0.78,0.8],...
            'String',[ 'Ex DS EMIT = ' num2str(Ex2_DS,3) ' nm']   );
        
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
        'String',[ 'SigmaE/E = ' num2str(SigmaEoverE*1e3,4) ' 10-3']   );
end

if ArchiveFlag
    t0 = clock;
    FileName = '';
    flag = 0;
    if isempty(FileName)
        %FileName = appendtimestamp(getfamilydata('Default', 'PINHOLEArchiveFile'));
        FileName = appendtimestamp('Ex'); % a completer les fonctionspar defaut dans soleilinit
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
            disp('   Ex registration canceled.');
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
    
    struct.CreatedBy = 'getExSigmaEoverE';
    struct.t         = t0;
    struct.tout      = etime(clock,t0);
    struct.TimeStamp = datestr(clock);

    save(FileName,'struct');

    fprintf('Data save in filename %s \n', FileName);
    %fprintf('***************************************************************** \n');
    
end

% for debug
% fprintf('%8.6f  %6.4f  %6.4f  %6.4f  %6.4f \n', sigma_yp_photonX, Ex1_reconstructed*1e9, Ex1_DS,Ex2_reconstructed*1e9, Ex2_DS)
% fprintf('%8.6f  %6.4f  %6.4f  %6.4f  %6.4f \n', sigma_yp_photonX, Ex1_reconstructed*1e9, Ex1_reconstructed1*1e9,Ex2_reconstructed*1e9, Ex2_reconstructed1*1e9)

end

%
function Ex_reconstructed  = Exreconstructed(sigmax,D1,D2,etaX,sigmae,betaX)
% comput standard formulation of emittance
Ex_reconstructed  = (sigmax.*sigmax*(D1/D2)*(D1/D2)  - etaX.*etaX.*sigmae*sigmae)./betaX;
end

function Ex_reconstructed = Exreconstructed_specific(sigma_yp_photonX, sigmax,D1,D2,etaX,etapX, sigmae,alphaX, betaX)

gammaPM = (1 + alphaX)/betaX  ;						% fonction optique gamma à ne pas confondre avec le gamma de la caméra (PM pour physique machine)

a = sigmae*sigmae*(etaX*etaX*gammaPM + etapX*etapX*betaX + 2*etaX*etapX*alphaX) + betaX * sigma_yp_photonX * sigma_yp_photonX;
b = sigmae*sigmae * etaX*etaX * sigma_yp_photonX * sigma_yp_photonX;
c = (sigmax * sigmax./ (D2*D2)) * (betaX + 2 * alphaX * D1 + gammaPM * D1 *D1);
e = (sigmax * sigmax./ (D2*D2)) * ((etaX - etapX*D1)*(etaX - etapX*D1) * sigmae * sigmae + D1*D1 * sigma_yp_photonX * sigma_yp_photonX);

Ex_reconstructed = (c - a + sqrt((c - a).*(c - a) - 4*(b - e)))./2;
end













