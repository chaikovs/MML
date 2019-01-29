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
deconvolution = 1
DisplayFlag = 1;
ScriptFlag  = 0; % no message to be used within script
ArchiveFlag = 0;
MEASURE = 0 ;
METIS = 1 ;
Ex_simple_computation = 1 ;
%MEASURE = 0 ; % MODEL

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

%% get measured values from first and second PHC
if MEASURE
    tmp             = tango_get_property(devemit1,'DistPinholeH2Convert')	; %5.730
    tmp2 = tmp.value{1} ; D2 = str2num(tmp2)
    tmp             = tango_get_property(devemit1,'DistSource2PinholeH')	; %	4.338
    tmp2 = tmp.value{1} ; D1 = str2num(tmp2)
    sigmax_1          = readattribute([devAna1 '/XProjFitSigma']); % µm
    
    tmp             = tango_get_property(devemit2,'DistPinholeH2Convert')	; % 5.716
    tmp2 = tmp.value{1} ; D2 = str2num(tmp2)
    tmp             = tango_get_property(devemit2,'DistSource2PinholeH')	; %	4.335
    tmp2 = tmp.value{1} ; D1 = str2num(tmp2)
    sigmax_2          = readattribute([devAna2 '/XProjFitSigma']); % µm
    
    %%%
    betaX_1         = readattribute([devemit1 '/BetaX']);
    betaX_2         = readattribute([devemit2 '/BetaX']);
    
    etaX_1          = readattribute([devemit1 '/EtaX']);
    etaX_2          = readattribute([devemit2 '/EtaX']);
    
    etapX_1          = readattribute([devemit1 '/EtapX']);
    etapX_2          = readattribute([devemit2 '/EtapX']);
    
    alphaX_1          = readattribute([devemit1 '/AlphaX']);
    alphaX_2          = readattribute([devemit2 '/AlphaX']);
    
    sigmae             = readattribute([devemit1 '/Sigmae']);
    
    %%%
    if deconvolution
        
        % get the magnification of visible system 1 xxx
        % get the pixel size xxxx
        tmp             = tango_get_property(devemit1,'CameraPixelRes'); % visible optical system resolution at CCD in pixel
        tmp2 = tmp.value{1} ; sigma_camera1  = str2num(tmp2)*7.4/2.53; % visible optical system resolution at convertor in µm
        
        % get the magnification of visible system 2 xxx
        tmp             = tango_get_property(devemit2,'CameraPixelRes');
        tmp2 = tmp.value{1} ; sigma_camera2  = str2num(tmp2)*7.4/2.53;
        
        sigma_diff1            = readattribute([devatt1 '/SigmaDiffractionH']);
        sigma_diff2            = readattribute([devatt2 '/SigmaDiffractionH'])   ;
        
        sigmax_1 = sqrt(sigmax_1.*sigmax_1 - sigma_camera1.*sigma_camera1 - sigma_diff1.*sigma_diff1);
        sigmax_2 = sqrt(sigmax_2.*sigmax_2 - sigma_camera2.*sigma_camera2 - sigma_diff2.*sigma_diff2);
        
        
        
        
    end
    
    %%% transport back to source point
    sigmax_1        = sigmax_1*(D1/D2)
    sigmax_2        = sigmax_2*(D1/D2)
    
    %%% prepare computation
    s2_1            = sigmax_1.*sigmax_1 ;
    s2_2            = sigmax_2.*sigmax_2 ;
    s2              = 1e-6 *1e-6 * [s2_1 s2_2]' ; % m sizes to the square and in matrix
    
    %%% compute separated emittances (normaly you should recover emittances
    %%% from Device EMIT
    
    if Ex_simple_computation
        Ex1_reconstructed  = (1e-6 *1e-6 *sigmax_1.*sigmax_1  - etaX_1.*etaX_1.*1.013e-3*1.013e-3)./betaX_1
        Ex2_reconstructed  = (1e-6 *1e-6 *sigmax_2.*sigmax_2  - etaX_2.*etaX_2.*1.013e-3*1.013e-3)./betaX_2
        
    else
        
        % typical photon angle in vertical
        %sigma_yp_photonY = 1/( E_tot_electron / E_repos_electron)*(EkeV_ref / EkeV )^(1/2)
        % typical photon angle in H
        sigma_yp_photonX = 0.5e-3 ; % rad
        %
        gammaPM_1 = (1 + alphaX_1)/betaX_1  						% fonction optique gamma à ne pas confondre avec le gamma de la caméra (PM pour physique machine)
        
        a = sigmae*sigmae*(etaX_1*etaX_1*gammaPM_1 + etapX_1*etapX_1*betaX_1 + 2*etaX_1*etapX_1*alphaX_1) + betaX_1 * sigma_yp_photonX * sigma_yp_photonX;
        b = sigmae*sigmae * etaX_1*etaX_1 * sigma_yp_photonX * sigma_yp_photonX;
        c = (1e-6*1e-6*sigmax_1 * sigmax_1./ (D2*D2)) * (betaX_1 + 2 * alphaX_1 * D1 + gammaPM_1 * D1 *D1);
        e = (1e-6*1e-6*sigmax_1 * sigmax_1./ (D2*D2)) * ((etaX_1 - etapX_1*D1)*(etaX_1 - etapX_1*D1) * sigmae * sigmae + D1*D1 * sigma_yp_photonX * sigma_yp_photonX);
        
        Ex1_reconstructed = (c - a + sqrt((c - a).*(c - a) - 4*(b - e)))./2;
        %
        gammaPM_2 = (1 + alphaX_2)/betaX_2  						% fonction optique gamma à ne pas confondre avec le gamma de la caméra (PM pour physique machine)
        
        a = sigmae*sigmae*(etaX_2*etaX_2*gammaPM_2 + etapX_2*etapX_2*betaX_2 + 2*etaX_2*etapX_2*alphaX_2) + betaX_2 * sigma_yp_photonX * sigma_yp_photonX;
        b = sigmae*sigmae * etaX_2*etaX_2 * sigma_yp_photonX * sigma_yp_photonX;
        c = (1e-6*1e-6*sigmax_2 * sigmax_2./ (D2*D2)) * (betaX_2 + 2 * alphaX_2 * D1 + gammaPM_2 * D1 *D1);
        e = (1e-6*1e-6*sigmax_2 * sigmax_2./ (D2*D2)) * ((etaX_2 - etapX_2*D1)*(etaX_2 - etapX_2*D1) * sigmae * sigmae + D1*D1 * sigma_yp_photonX * sigma_yp_photonX);
        
        Ex2_reconstructed = (c - a + sqrt((c - a).*(c - a) - 4*(b - e)))./2;
        
    end
    %% check computation
else  %(MODEL)
    % AT code
    % BeamLineName	Long_Position (m)	RMS_H_Size (µm)	RMS_V_Size (µm)	RMS_H_div (µm)	RMS_V_div (µm)	betaX (m)	betaZ (m)	etax (m)	etaxp (-)	etaz (m)	etazp (m)	alphax (-)	alphaz (-)
    AT_PHC1	= [ 37.3625	44.9	24.6	96.6	1.5	0.444	15.5915	0.0154	-0.0236	0.0139	-0.0001	-0.0082	0.4055 ] ;
    AT_PHC3 = [	343.8681	62.9	18	129.1	2.1	0.6037	10.7415	0.0398	-0.078	0.0042	0.0012	0.7861	-0.1356 ] ;
    
    sigmax_1          = AT_PHC1(2) ,
    sigmax_2          = AT_PHC3(2) ,
    betaX_1         = AT_PHC1(6) ,
    betaX_2         = AT_PHC3(6) ,
    etaX_1          = AT_PHC1(8) ,
    etaX_2          = AT_PHC3(8) ,
    s2_1            = sigmax_1.*sigmax_1 ;
    s2_2            = sigmax_2.*sigmax_2 ;
    s2              = 1e-6 *1e-6 * [s2_1 s2_2]' ; % m square
    
    alphaX_1          = AT_PHC1(12) ,
    alphaX_2          = AT_PHC3(12) ,
    etapX_1          = AT_PHC1(9) ,
    etapX_2          = AT_PHC3(9) ,
    sigmae             = 1.013e-3 ;
    D2 = 5.730 ;
    D1 = 4.338 ;
    sigma_yp_photonX = 0.5e-3 ; % rad
    %
    gammaPM_1 = (1 + alphaX_1)/betaX_1  						% fonction optique gamma à ne pas confondre avec le gamma de la caméra (PM pour physique machine)
    
    a = sigmae*sigmae*(etaX_1*etaX_1*gammaPM_1 + etapX_1*etapX_1*betaX_1 + 2*etaX_1*etapX_1*alphaX_1) + betaX_1 * sigma_yp_photonX * sigma_yp_photonX;
    b = sigmae*sigmae * etaX_1*etaX_1 * sigma_yp_photonX * sigma_yp_photonX;
    c = (1e-6*1e-6*sigmax_1 * sigmax_1./ (D2*D2)) * (betaX_1 + 2 * alphaX_1 * D1 + gammaPM_1 * D1 *D1);
    e = (1e-6*1e-6*sigmax_1 * sigmax_1./ (D2*D2)) * ((etaX_1 - etapX_1*D1)*(etaX_1 - etapX_1*D1) * sigmae * sigmae + D1*D1 * sigma_yp_photonX * sigma_yp_photonX);
    
    Ex1_reconstructed = (c - a + sqrt((c - a).*(c - a) - 4*(b - e)))./2
    
    sigma_energy  =sigmae;
     eta = etaX_1;
      etap = etapX_1;
    gamma = gammaPM_1 ;
    beta = betaX_1 ;
    alpha = alphaX_1 ;
    sigma_convert_deconv = sigmax_1*1e-6 ;
    sigma_yp_photon = sigma_yp_photonX ;
    D = D2 ;
    d = D1 ; 
    
   a = sigma_energy *sigma_energy * ( eta * eta *gamma +  etap *etap * beta + 2 * eta * etap * alpha)
             + beta * sigma_yp_photon* sigma_yp_photon;
 b = sigma_energy * sigma_energy *eta * eta *sigma_yp_photon*sigma_yp_photon;
  c = sigma_convert_deconv*sigma_convert_deconv / (D*D) * ( beta + 2 * alpha * d + gamma * d * d);
 e = sigma_convert_deconv*sigma_convert_deconv / (D*D) * ( (eta - etap * d) *(eta - etap * d) * sigma_energy* sigma_energy + (d*d) * sigma_yp_photon* sigma_yp_photon );
emittance = ( c - a + sqrt( (c - a)*(c - a) - 4 * (b - e) ) ) / 2
    
    
    
    
    
    
    %
    gammaPM_2 = (1 + alphaX_2)/betaX_2  						% fonction optique gamma à ne pas confondre avec le gamma de la caméra (PM pour physique machine)
    
    a = sigmae*sigmae*(etaX_2*etaX_2*gammaPM_2 + etapX_2*etapX_2*betaX_2 + 2*etaX_2*etapX_2*alphaX_2) + betaX_2 * sigma_yp_photonX * sigma_yp_photonX;
    b = sigmae*sigmae * etaX_2*etaX_2 * sigma_yp_photonX * sigma_yp_photonX;
    c = (1e-6*1e-6*sigmax_2 * sigmax_2./ (D2*D2)) * (betaX_2 + 2 * alphaX_2 * D1 + gammaPM_2 * D1 *D1);
    e = (1e-6*1e-6*sigmax_2 * sigmax_2./ (D2*D2)) * ((etaX_2 - etapX_2*D1)*(etaX_2 - etapX_2*D1) * sigmae * sigmae + D1*D1 * sigma_yp_photonX * sigma_yp_photonX);
    
    Ex2_reconstructed = (c - a + sqrt((c - a).*(c - a) - 4*(b - e)))./2
    
    
    
    
    
end

%% compute Ex and sigmaEoverE

M               = [ betaX_1  etaX_1.*etaX_1 ;  betaX_2  etaX_2.*etaX_2] ;

Res             = inv(M) * s2 ;
Eps_x           = Res(1)
SigmaEoverE     = sqrt(Res(2))

%% save other parameters

struct.Ex               = Eps_x ;
struct.SigmaEoverE      = SigmaEoverE ;
struct.deconvolution    = deconvolution ;
struct.MEASURE          = MEASURE ;
struct.current          = getdcct;
if MEASURE
    pos_att1                =  readattribute([devMatt1 '/position']);
    pos_att2                =  readattribute([devMatt2 '/position']);
    struct.pos_att1         = pos_att1    ;
    struct.pos_att2         = pos_att2    ;
end



%% plot images and results


fh = figure('Position',[20 50 500 400]);

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

texte = [ 'sigmax = ' num2str(sigmax_1) 'µm']
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
    'String',[ 'sigmax = ' num2str(sigmax_1,4) ' µm']);
MyTitle= uicontrol(fh,'Position',[70+230 150 180 20],...
    'Style','text',...
    'FontSize',16,...
    'HorizontalAlignment','center',...
    'BackgroundColor',[0.702,0.78,1],...
    'String',[ 'sigmax = ' num2str(sigmax_2,4) ' µm']   );

if ~METIS
    MyTitle= uicontrol(fh,'Position',[70 150 180 20],...
        'Style','text',...
        'FontSize',16,...
        'HorizontalAlignment','center',...
        'BackgroundColor',[0.702,0.78,1],...
        'String',[ 'Ex reconstr. = ' num2str(Ex1_reconstructed,3) ' nm']);
    MyTitle= uicontrol(fh,'Position',[70+230 150 180 20],...
        'Style','text',...
        'FontSize',16,...
        'HorizontalAlignment','center',...
        'BackgroundColor',[0.702,0.78,1],...
        'String',[ 'Ex reconstr. = ' num2str(Ex1_reconstructed,3) ' nm']   );
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

if ArchiveFlag
    t0 = clock;
    FileName = '';
    toto = 0;
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
    
    rep.CreatedBy = 'getExSigmaEoverE';
    rep.t         = t0;
    rep.tout      = etime(clock,t0);
    rep.TimeStamp = datestr(clock);
    if toto == 0
        save(FileName,'struct');
    end
    fprintf('Data save in filename %s \n', FileName);
    %fprintf('***************************************************************** \n');
    
end
end

%

















