function measbpmphaseadvance(varargin)
% BPMPHASEADVANCE - Measure bpmphase advance either from model or from data
%
%
%  EXAMPLES
%  1. measbpmphaseadvance('file', 'BPMTurnByTurn_2009-03-16_reboot_2kV_4kV.mat')
%
%
%  See Also
%  anabetaturnbyturn, getbpmrawdata



%
%% Written by Laurent S. Nadolski

ModelFlag = 0;
DisplayFlag = 1;
FileFlag = 0;
RadianFlag = 0; % 1 - for angle in radians 0 - for angle in degrees

for i = length(varargin):-1:1
    if strcmpi(varargin{i},'struct')
        StructOutputFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'numeric')
        NumericOutputFlag = 1;
        StructOutputFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'archive')
        ArchiveFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'noarchive')
        ArchiveFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Display')
        DisplayFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'NoDisplay')
        DisplayFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Simulator') | strcmpi(varargin{i},'Model')
        ModelFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Online')
        ModelFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'manual')
        ModeFlag = varargin(i);
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Degree')
        RadianFlag = 0;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'Radian')
        RadianFlag = 1;
        varargin(i) = [];
    elseif strcmpi(varargin{i},'File')
        FileFlag = 1;
        ModelFlag = 0;
        if length(varargin) > i
            % Look for a filename as the next input
            if ischar(varargin{i+1})
                FileName = varargin{i+1};
                [a a ext] = fileparts(FileName);
                if isempty(ext)
                    FileName = [FileName, '.mat'];
                end
                varargin(i+1) = [];
            end
        end
        varargin(i) = [];
    end
end

if ModelFlag
    global THERING
    %%
    BPMindex = family2atindex('BPMx');
    spos = getspos('BPMx');

    %%
    clear X01;
    X0 = [1e-3 0 0*1e-3 0 0 0]';

    nb = 1000; % turn number for tracking
    X01 = zeros(nb, 6, length(THERING)+1);

    for k=1:nb,
        X01(k,:,:) = linepass(THERING, X0, 1:length(THERING)+1);
        X0 = X01(k,:,end)';
    end

    % get positions
    X = squeeze(X01(:,1,BPMindex))';
    Z = squeeze(X01(:,3,BPMindex))';

    % get tunes
    nu = modeltune;

    cosmmux = ones(length(BPMindex),1)*cos((1:nb)*2*pi*nu(1));
    sinmmux = ones(length(BPMindex),1)*sin((1:nb)*2*pi*nu(1));
    cosmmuz = ones(length(BPMindex),1)*cos((1:nb)*2*pi*nu(2));
    sinmmuz = ones(length(BPMindex),1)*sin((1:nb)*2*pi*nu(2));

    Ckx = sum(X.*cosmmux,2);
    Skx = sum(X.*sinmmux,2);
    Ckz = sum(Z.*cosmmuz,2);
    Skz = sum(Z.*sinmmuz,2);

else %Online
    if FileFlag
        if ~isempty(FileName) && exist(FileName, 'file')
            a = load(FileName);
            AM = getfield(a, 'AM');
            bpmdevlist = dev2elem('BPMx',AM.DeviceList);
        else
            DirectoryName = getfamilydata('Directory','BPMData');
            DirStart = pwd;
            cd(DirectoryName);
            FileName     = uigetfile('BPMTurnByTurn*.mat',DirectoryName);
            cd(DirStart);
            if  isequal(FileName,0)
                disp('User pressed cancel')
                return;
            else
                a = load(fullfile(DirectoryName, FileName));
                AM = getfield(a, 'AM');
                bpmdevlist = dev2elem('BPMx',AM.DeviceList);
            end
        end
    else
        AM = getbpmrawdata([],'Struct');
    end
    i1 = 50; i2 = 1000;
    X = AM.Data.X(:,i1:i2);
    Z = AM.Data.Z(:,i1:i2);

    %nux = (calcnaff(X(1,:),X(1,:)*0,1,4))/2/pi
    %nuz = (calcnaff(Z(1,:),Z(1,:)*0,1,4))/2/pi
    [nux,nuz,ampx,ampz] = findfreq(X(1,:)',Z(1,:)')
    
    nu = [nux; nuz];
    nu = [0.2018; 0.3167];
    fprintf('Warning tunes used nux=%5.4f nuz=%5.4f\n', nu);
    
    nb = i2-i1+1;
    len = size(X,1);
    cosmmux = ones(len,1)*cos((1:nb)*2*pi*nu(1));
    sinmmux = ones(len,1)*sin((1:nb)*2*pi*nu(1));
    cosmmuz = ones(len,1)*cos((1:nb)*2*pi*nu(2));
    sinmmuz = ones(len,1)*sin((1:nb)*2*pi*nu(2));

    Ckx = sum(X.*cosmmux,2);
    Skx = sum(X.*sinmmux,2);
    Ckz = sum(Z.*cosmmuz,2);
    Skz = sum(Z.*sinmmuz,2);

end

nb = length(Skx);

% computes phases
phikxfull = atan2(Skx,Ckx);
phikzfull = atan2(Skz,Ckz);

% Compute betatron amplitude
Akx = 2*hypot(Ckx,Skx)/nb;
Akz = 2*hypot(Ckz,Skz)/nb;

fprintf('Horizontal betatron amplitude estimation Ak= %f mm +/- %f mm\n', ...
    mean(Akx)*1e3, std(Akx)*1e3);

fprintf('Vertical betatron amplitude estimation Ak= %f mm +/- %f mm\n', ...
    mean(Akz)*1e3, std(Akz)*1e3);

%% Display part
if DisplayFlag
    
    if ~RadianFlag
        rad2degree = 180/pi;
        str1 = 'BPM phase advance [degree]';
        str2 = 'BPM phase Error [degree]';
    else
        str1 = 'BPM phase advance [rad]';
        str2 = 'BPM phase Error [rad]';
    end

    if ModelFlag
        datestring = [datestr(clock,0) '(Model)'];
    else
        datestring = datestr(AM.TimeStamp,0);
    end

    posvect = getspos('BPMx');
    posvect = posvect(2:end);
    
    figure
    h1 = subplot(7,1,[1 3]);
    [phiT dphikx] = phi_local(phikxfull);

    plot(posvect, dphikx*rad2degree, 'r.-');hold on
    [phix phiz] = modelphase('BPMx');

    
    dphix = diff(phix);
    plot(posvect, dphix*rad2degree,'b.-')
    legend('Measure','Theory')
    ylabel(str1)

    h2 = subplot(7,1,4);
    drawlattice;

    h3 = subplot(7,1,[5 7]);
    plot(posvect, (dphikx-dphix)*rad2degree,'r.-')
    ylabel(str2)
    xlabel('BPM number')
    %yaxis([20 40])
    suptitle('Horizontal plane')

    linkaxes([h1,h2,h3],'x');

    addlabel(1,0,sprintf('%s', datestring));

    figure
    h1 = subplot(7,1,[1 3]);
    [phiT dphikz] = phi_local(phikzfull);

    plot(posvect, dphikz*rad2degree, 'r.-');hold on

    dphiz = diff(phiz);
    plot(posvect, dphiz*rad2degree,'b.-')
    legend('Measure','Theory')
    ylabel(str1)

    h2 = subplot(7,1,4);
    drawlattice;

    h3 = subplot(7,1,[5 7]);
    plot(posvect, (dphikz-dphiz)*rad2degree,'r.-')
    ylabel(str2)
    xlabel('BPM number')
    suptitle('Vertical plane')
    linkaxes([h1,h2,h3],'x');

    addlabel(1,0,sprintf('%s', datestring));
end


%%subfunction
function [phiT dphiT] = phi_local(phikxfull)

phiT = 0;
dphiT = [];
for k = 2:length(phikxfull)
    if phikxfull(k)*phikxfull(k-1) > 0
        dphi = abs(phikxfull(k)-phikxfull(k-1));
    else
        dphi = abs(mod(phikxfull(k-1)-phikxfull(k),2*pi));
    end
    phiT = phiT + dphi;
    dphiT(k-1) = dphi;
end

dphiT = dphiT(:);
phiT  = phiT(:);