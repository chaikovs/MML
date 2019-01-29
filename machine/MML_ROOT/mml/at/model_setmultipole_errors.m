function THERING=model_setmultipole_errors(THERING, varargin)
% MODEL_SETMULTIPOLE - add mutipole to a lattice
%  Set measured multipole errors to dipoles, quadrupoles, skew quadrupoles,
%  sextupoles, horizontal and vertical correctors oin the SOLEIL storage ring.
%
%  NOTES
%  1. This is machine dependent (name of the families) and type of errors
%  2. This is MML depend,  could be rewrite to be only AT depend
%
%  EXAMPLES
%  1. model_setmultipole(THERING,'BEND') only for bend
%  2. model_setmultipole(THERING,'BEND', 'QUAD', 'SEXTU', 'HCOR', 'VCOR', 'QT')

%
% Version 1 by J. Zhang see /home/zhang/codes/mlab/at for reference

% Assume the lattice has multipole for correctors
updateatindex;      %update AT index, since multipole errors was added to correctors


if nargin == 0
    warning('First argument should be the AT structure\n');
        eval(sprintf('help %s', mfilename'));
    return;
else
    if ~iscell(THERING)
        error('First argument is not a AT structure\n')
    end
end


bendFlag = 0;
quadFlag = 0;
sextuFlag = 0;
hcorFlag = 0;
vcorFlag = 0;
qtFlag = 0;
exceptionFlag = 0;
exceptionList = {};

for ik = length(varargin):-1:1,
    if strcmpi(varargin{ik},'BEND')
        bendFlag = 1;
        varargin(ik) = []; % +++++++++++++++++++++++++++++++++++++++++++++++
    elseif strcmpi(varargin{ik},'QUAD')
        quadFlag = 1;
        varargin(ik) = []; % +++++++++++++++++++++++++++++++++++++++++++++++
    elseif strcmpi(varargin{ik},'SEXTU')
        sextuFlag = 1;
        varargin(ik) = []; % +++++++++++++++++++++++++++++++++++++++++++++++
    elseif strcmpi(varargin{ik}, 'HCOR')
        hcorFlag = 1;
        varargin(ik) = []; % +++++++++++++++++++++++++++++++++++++++++++++++
    elseif strcmpi(varargin{ik}, 'VCOR')
        vcorFlag = 1;
        varargin(ik) = []; % +++++++++++++++++++++++++++++++++++++++++++++++
    elseif strcmpi(varargin{ik}, 'QT')
        qtFlag = 1;
        varargin(ik) = []; % +++++++++++++++++++++++++++++++++++++++++++++++
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %        ,...,'Execption', { 'HCOR' [hcorrList] ;
        %                            'VCOR' [vcorrList] ;
        %                            'QT'   [qtList]      } )
        
    elseif strcmpi(varargin{ik}, 'Exception')
        if length(varargin) > ik
            % Look for a cell as the next input
            if iscell(varargin{ik+1})
                if size(varargin{ik+1},2) ~= 2
                    error('Error:SizeOfexceptionList','exceptionList must be must have 2 columns')
                end
                exceptionList = varargin{ik+1};
                exceptionFlag = 1;
                varargin(ik+1) = [];
            else
                fprintf('# Problem detected after the field ''%s''. \n',varargin{ik});
            end
        else
            fprintf('# Problem detected after the field ''%s''. \n',varargin{ik});
        end
        varargin(ik) = [];
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- If unidentified paramter(s) remain(s) ---
if ~isempty(varargin)
    disp('Parameter(s) not recognised :')
    for p = 1:length(varargin)
        disp(varargin(p))
    end
    error('Unknown parameter(s) detected')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% find index

if bendFlag
    % dipole index
    fprintf('Setting multipole errors for BEND \n');

    BIndex  = family2atindex('BEND');
    
    %% assign multipole errors to dipole
    x0i   = 1.0/20e-3; % 1/radius
    x02i  = x0i*x0i;
    x03i  = x02i*x0i;
    x04i  = x02i*x02i;
    x05i  = x04i*x0i;
    x06i  = x03i*x03i;
    x07i  = x06i*x0i;
    
    % dBoB2 =  2.2e-4*0;  % gradient, used for curve trajectory simulation
    % already assign in the definition of dipole as "K"
    dBoB3 = -3.0e-4*1;  % hexapole
    dBoB4 =  2.0e-5*1;  % octupole
    dBoB5 = -1.0e-4*1;  % decapole
    dBoB6 = -6.0e-5*1;  % 12-poles
    dBoB7 = -1.0e-4*1;  % 14-poles
    rhoi  = THERING{BIndex(1)}.BendingAngle/THERING{BIndex(1)}.Length;
    
    Berr{1}.order = 3;
    Berr{2}.order = 4;
    Berr{3}.order = 5;
    Berr{4}.order = 6;
    Berr{5}.order = 7;
    
    Berr{1}.xi = x02i;
    Berr{2}.xi = x03i;
    Berr{3}.xi = x04i;
    Berr{4}.xi = x05i;
    Berr{5}.xi = x06i;
    
    Berr{1}.dBoBn = dBoB3;
    Berr{2}.dBoBn = dBoB4;
    Berr{3}.dBoBn = dBoB5;
    Berr{4}.dBoBn = dBoB6;
    Berr{5}.dBoBn = dBoB7;
    
    MaxOrder   = Berr{end}.order;
    
    for ik = 1:length(BIndex),      
        THERING{BIndex(ik)}.MaxOrder= MaxOrder-1;        
        THERING{BIndex(ik)}.PolynomA(MaxOrder) = 0.0;
        THERING{BIndex(ik)}.PolynomB(MaxOrder) = 0.0;
        for j = 1:length(Berr)            
            k     = Berr{j}.order;
            xi    = Berr{j}.xi;
            dBoBn = Berr{j}.dBoBn;            
            if  k==2
                THERING{BIndex(ik)}.PolynomB(k) = THERING{BIndex(ik)}.PolynomB(k)+rhoi*dBoBn*xi;                
            else
                THERING{BIndex(ik)}.PolynomB(k) = rhoi*dBoBn*xi;
            end
        end
    end    
end

if quadFlag
    fprintf('Setting multipole errors for QUAD \n');
    % quadrupole index
    Q1Index = family2atindex('Q1');
    Q2Index = family2atindex('Q2');
    Q3Index = family2atindex('Q3');
    Q4Index = family2atindex('Q4');
    Q5Index = family2atindex('Q5');
    Q6Index = family2atindex('Q6');
    Q7Index = family2atindex('Q7');
    Q8Index = family2atindex('Q8');
    Q9Index = family2atindex('Q9');
    Q10Index= family2atindex('Q10');
    Q11Index= family2atindex('Q11');
    Q12Index= family2atindex('Q12');
    % merge long and short quadrupole index
    QSIndex = [Q1Index;Q3Index;Q4Index;Q5Index;...
        Q6Index;Q8Index;Q9Index;Q10Index; ...
        Q11Index;Q12Index];
    QLIndex = [Q2Index;Q7Index];    
    
    %% assign multipole errors to long quadrupole
    x1i  = 1.0/30e-3;    % rayon reference = 30 mm pour mesure sextupole et octupole
    x0i  = 1.0/30e-3;       % 1/Radius in meters
    x02i = x0i*x0i;
    x04i = x02i*x02i;       % 10-poles
    x08i = x04i*x04i;       % 20-poles
    x012i= x08i*x04i;       % 28-poles
    
    dBoB6L  =  0.7e-4*1;
    dBoB10L =  1.9e-4*1;
    dBoB14L =  1.0e-4*1;
    
    dBoB3L  =  2.9e-4*1;    % sextupole qpole long
    dBoB4L  = -8.6e-4*1;    % octupole qpole long
    
    QLerr{1}.order = 3;
    QLerr{2}.order = 4;
    QLerr{3}.order = 6;
    QLerr{4}.order = 10;
    QLerr{5}.order = 14;
    
    QLerr{1}.xi = x1i;
    QLerr{2}.xi = x1i*x1i;
    QLerr{3}.xi = x04i;
    QLerr{4}.xi = x08i;
    QLerr{5}.xi = x012i;
    
    QLerr{1}.dBoBn = dBoB3L;
    QLerr{2}.dBoBn = dBoB4L;
    QLerr{3}.dBoBn = dBoB6L;
    QLerr{4}.dBoBn = dBoB10L;
    QLerr{5}.dBoBn = dBoB14L;
    
    MaxOrder   = QLerr{end}.order;
    
    for ik = 1:length(QLIndex),
        THERING{QLIndex(ik)}.MaxOrder= MaxOrder-1;
        THERING{QLIndex(ik)}.PolynomA(MaxOrder) = 0.0;
        THERING{QLIndex(ik)}.PolynomB(MaxOrder) = 0.0;
        for j = 1:length(QLerr)
            k     = QLerr{j}.order;
            xi    = QLerr{j}.xi;
            dBoBn = QLerr{j}.dBoBn;
            THERING{QLIndex(ik)}.PolynomB(k) = THERING{QLIndex(ik)}.PolynomB(2)*dBoBn*xi;
        end
    end
    
    % %% assign multipole errors to short quadrupole
    x1i  = 1.0/30e-3;    % rayon reference = 30 mm pour mesure sextupole et octupole
    x0i  = 1.0/30e-3;       % 1/Radius in meters
    x02i = x0i*x0i;
    x04i = x02i*x02i;       % 10-poles
    x08i = x04i*x04i;       % 20-poles
    x012i= x08i*x04i;       % 28-poles
    
    dBoB6S  =  2.4e-4*1;
    dBoB10S =  0.7e-4*1;
    dBoB14S =  0.9e-4*1;
    
    dBoB3S  =  -1.6e-4*1;   % sextupole qpole court
    dBoB4S  =  -3.4e-4*1;   % octupole qpole court
    QSerr{1}.order = 3;
    QSerr{2}.order = 4;
    QSerr{3}.order = 6;
    QSerr{4}.order = 10;
    QSerr{5}.order = 14;
    
    QSerr{1}.xi = x1i;
    QSerr{2}.xi = x1i*x1i;
    QSerr{3}.xi = x04i;
    QSerr{4}.xi = x08i;
    QSerr{5}.xi = x012i;
    
    QSerr{1}.dBoBn = dBoB3S;
    QSerr{2}.dBoBn = dBoB4S;
    QSerr{3}.dBoBn = dBoB6S;
    QSerr{4}.dBoBn = dBoB10S;
    QSerr{5}.dBoBn = dBoB14S;
    
    lenQSIndex = length(QSIndex);
    lenQSerr   = length(QSerr);
    MaxOrder   = QSerr{end}.order;
    
    for ik = 1:lenQSIndex,
        THERING{QSIndex(ik)}.MaxOrder = MaxOrder-1;
        THERING{QSIndex(ik)}.PolynomA(MaxOrder) = 0.0;
        THERING{QSIndex(ik)}.PolynomB(MaxOrder) = 0.0;
        for j = 1:lenQSerr
            k     = QSerr{j}.order;
            xi    = QSerr{j}.xi;
            dBoBn = QSerr{j}.dBoBn;    
            THERING{QSIndex(ik)}.PolynomB(k) = THERING{QSIndex(ik)}.PolynomB(2)*dBoBn*xi;
        end
    end
    
end

if qtFlag
    fprintf('Setting multipole errors for QT \n');
    % skew quadrupoles
    SKQIndex=family2atindex('QT',family2dev('QT'));
    %% assign multipole errors to skew quadrupole
    x0i   = 1.0/35e-3;  % 1/radius
    x02i  = x0i*x0i;
    dBoB4 = -0.680*1;   % Octupole
    brho  = getbrho;
    conv  = hw2physics('QT','Setpoint',1,SKQIndex(1));  %convert the hw unit to physics unit

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % each skew quadrupole has different error, and is written from a file
    %     fid     = fopen('corqt.txt','r');
    %     skqcorr = fscanf(fid,'%f');
    %     fclose(fid);
    
    if exceptionFlag
        for ik = 1:size(exceptionList,1),
            if strcmp(exceptionList{ik,1},'QT')
                skqcorr = exceptionList{ik,2};
                break
            end
        end
    else
        fid     = fopen('corqt.txt','r');
        skqcorr = fscanf(fid,'%f');
        fclose(fid);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    SKQerr{1}.order = 4;
    
    MaxOrder   =  SKQerr{end}.order;
    k          =  SKQerr{1}.order;
    
    for ik = 1:length(SKQIndex),
        THERING{SKQIndex(ik)}.MaxOrder= MaxOrder-1;
        THERING{SKQIndex(ik)}.PolynomA(MaxOrder) = 0.0;
        THERING{SKQIndex(ik)}.PolynomB(MaxOrder) = 0.0;
        THERING{SKQIndex(ik)}.PolynomB(k) = dBoB4*skqcorr(ik)*conv/brho*x02i;
    end
    
    %
end

if sextuFlag
    % sextupole index
    S1Index = family2atindex('S1');
    S2Index = family2atindex('S2');
    S3Index = family2atindex('S3');
    S4Index = family2atindex('S4');
    S5Index = family2atindex('S5');
    S6Index = family2atindex('S6');
    S7Index = family2atindex('S7');
    S8Index = family2atindex('S8');
    S9Index = family2atindex('S9');
    S10Index= family2atindex('S10');
    S11Index= family2atindex('S11');
    S12Index= family2atindex('S12');
    %merge sextupole index
    SIndex  = [S1Index,S2Index,S3Index,S4Index,S5Index,S6Index,...
        S7Index,S8Index,S9Index,S10Index,S11Index,S12Index];
    %% assign multipole errors to sextupoles
    %  x0i   = 1.0/32e-3;
    %  x02i  = x0i*x0i;
    %  x04i  = x02i*x02i;
    x06i  = x04i*x02i;   % 18-poles
    x012i = x06i*x06i;   % 30-poles
    x018i = x012i*x06i;  % 42-poles
    x024i = x012i*x012i; % 54-poles
    
    %assign multipoles from dipolar unallowed component
    % no dB0B5 and dB0B7 in thick lens lattice of Soleil used in TRACY II
    % dBoB5     =   5.4e-4*0;
    % dBoB7     =   3.3e-4*0;
    % dBoB5rms  =   4.7e-4*0;
    % dBoB7rms  =   2.1e-4*0;
    
    % allowed multipole errors
    dBoB9  =   -4.7e-4*1;
    dBoB15 =   -9.0e-4*1;
    dBoB21 =  -20.9e-4*1;
    dBoB27 =    0.8e-4*1;
    
    %Serr{1}.order = 5;
    %Serr{2}.order = 7;
    Serr{1}.order = 9;
    Serr{2}.order = 15;
    Serr{3}.order = 21;
    Serr{4}.order = 27;
    
    %Serr{1}.xi = x02i;
    %Serr{2}.xi = x04i;
    Serr{1}.xi = x06i;
    Serr{2}.xi = x012i;
    Serr{3}.xi = x018i;
    Serr{4}.xi = x024i;
    
    % Serr{1}.dBoBn = dBoB5;
    % Serr{2}.dBoBn = dBoB7;
    Serr{1}.dBoBn = dBoB9;
    Serr{2}.dBoBn = dBoB15;
    Serr{3}.dBoBn = dBoB21;
    Serr{4}.dBoBn = dBoB27;
    
    MaxOrder      =  Serr{end}.order;
    
    for ik = 1:length(SIndex),
        THERING{SIndex(ik)}.MaxOrder= MaxOrder-1;
        THERING{SIndex(ik)}.PolynomA(MaxOrder) = 0.0;
        THERING{SIndex(ik)}.PolynomB(MaxOrder) = 0.0;
        for j = 1:length(Serr),
            k     = Serr{j}.order;
            xi    = Serr{j}.xi;
            dBoBn = Serr{j}.dBoBn;
            THERING{SIndex(ik)}.PolynomB(k) = THERING{SIndex(ik)}.PolynomB(3)*dBoBn*xi;
        end
    end
end

if hcorFlag
    fprintf('Setting multipole errors for HCOR \n');

    % horizontal corrector index; in fact, this is multipole index to add
    % errors
    ATi=atindex;
    devList=family2dev('HCOR',0);
    devList(31:32,:) = [];
    
    if ~isfield(ATi, 'HMulCorr'),
        warning('Multipole not set for H-correctors');
        [THERING,ATi ] = local_add_multipole4COR(THERING, ATi);
    end
    HCIndex=ATi.HMulCorr(find(family2status('HCOR', devList)'==1));
    
    %% assign multipole errors to horizontal correctors
    x0i   = 1.0/35e-3;  % 1/radius
    x02i  =  x0i*x0i;
    x03i  = x02i*x0i;
    x04i  = x02i*x02i;
    x05i  = x04i*x0i;
    x06i  = x03i*x03i;
    x010i = x05i*x05i;
    
    dBoB5  = 0.430*1;  % decapole
    dBoB7  = 0.063*1;  % 14-poles
    dBoB11 =-0.037*1;  % 22-poles
    brho   = getbrho;
    conv   = hw2physics('HCOR','Setpoint',1,HCIndex(1)); % convert Ams en T.m
    % warning thin element with no zero length
    conv = conv/THERING{HCIndex(1)}.Length;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if exceptionFlag
        for ik = 1:size(exceptionList,1)
            if strcmp(exceptionList{ik,1},'HCOR')
                hcorr = exceptionList{ik,2};
                break
            end
        end
    else
        fid   = fopen('corh57.txt','r');
        hcorr = fscanf(fid,'%f');
        fclose(fid);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    hcorr_strength = hcorr*conv/brho;   %assign error to each corrector
    
    HCerr{1}.order = 5;
    HCerr{2}.order = 7;
    HCerr{3}.order = 11;
    
    HCerr{1}.xi = x04i;
    HCerr{2}.xi = x06i;
    HCerr{3}.xi = x010i;
    
    HCerr{1}.dBoBn = dBoB5;
    HCerr{2}.dBoBn = dBoB7;
    HCerr{3}.dBoBn = dBoB11;
    
    MaxOrder = HCerr{end}.order;
    
    for ik = 1:length(HCIndex),
        THERING{HCIndex(ik)}.MaxOrder= MaxOrder-1;
        THERING{HCIndex(ik)}.PolynomA(MaxOrder) = 0; % avoid memory leaks
        THERING{HCIndex(ik)}.PolynomB(MaxOrder) = 0;
        for j = 1:length(HCerr),
            k     = HCerr{j}.order;
            xi    = HCerr{j}.xi;
            dBoBn = HCerr{j}.dBoBn;
            THERING{HCIndex(ik)}.PolynomB(k) = dBoBn*(hcorr_strength(ik)+THERING{ATi.COR(ik)}.KickAngle(1))*xi;
        end
    end    
end

if vcorFlag
    fprintf('Setting multipole errors for VCOR \n');
    % vertical corrector index
    if ~isfield(ATi, 'HMulCorr'),
        warning('Multipole not set for V-correctors');
        [THERING,ATi ] = local_add_multipole4COR(THERING, ATi);
    end
    VCIndex=ATi.VMulCorr(find(family2status('VCOR', devList)'==1)) ;
    
    %% assign multipole errors in vertical corrector
    x0i   = 1.0/35e-3;  % 1/radius
    x02i  = x0i*x0i;
    x03i  = x02i*x0i;
    x04i  = x02i*x02i;
    x05i  = x04i*x0i;
    x06i  = x03i*x03i;
    x010i = x05i*x05i;
    
    dBoB5  = -0.430*1;  % decapole
    dBoB7  =  0.063*1;  % 14-poles
    dBoB11 =  0.037*1;  % 22-poles
    
    brho = getbrho; % magnetic rigidity
    conv = hw2physics('VCOR','Setpoint',1,VCIndex(1));  % convert Amps to T.m
    conv = conv/THERING{VCIndex(1)}.Length; % non zero multipole length

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %     fid   = fopen('corv57.txt','r');
    %     vcorr = fscanf(fid,'%f');
    %     vcorr_strength = vcorr*conv/brho;   %assign error to each corrector
    %     fclose(fid);
    
    if exceptionFlag
        for ik = 1:size(exceptionList,1)
            if strcmp(exceptionList{ik,1},'VCOR')
                vcorr = exceptionList{ik,2};
                break
            end
        end
    else
        fid   = fopen('corv57.txt','r');
        vcorr = fscanf(fid,'%f');
        fclose(fid);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    vcorr_strength = vcorr*conv/brho;   %assign error to each corrector
    
    VCerr{1}.order = 5;
    VCerr{2}.order = 7;
    VCerr{3}.order = 11;
    
    VCerr{1}.xi = x04i;
    VCerr{2}.xi = x06i;
    VCerr{3}.xi = x010i;
    
    VCerr{1}.dBoBn = dBoB5;
    VCerr{2}.dBoBn = dBoB7;
    VCerr{3}.dBoBn = dBoB11;
    
    MaxOrder = VCerr{end}.order;
    
    for ik = 1:length(VCIndex),
        THERING{VCIndex(ik)}.MaxOrder= MaxOrder-1;
        THERING{VCIndex(ik)}.PolynomA(MaxOrder) = 0; % avoid memory leaks
        THERING{VCIndex(ik)}.PolynomB(MaxOrder) = 0;
        for j = 1:length(VCerr),
            k     = VCerr{j}.order;
            xi    = VCerr{j}.xi;
            dBoBn = VCerr{j}.dBoBn;
            THERING{VCIndex(ik)}.PolynomB(k) = dBoBn*vcorr_strength(ik)*xi;
        end        
    end
end

%%%
function [THERING,ATi ] = local_add_multipole4COR(THERING, ATi)
% Add mutipole for family COR (HCOR and VCOR) as thin element
fprintf('Adding multipole for HCOR and VCOR ...\n');
HMulCorr =  atmultipole('HMulCorr',1e-18, 0.0, 0.0,'StrMPoleSymplectic4Pass');
VMulCorr =  atmultipole('VMulCorr',1e-18, 0.0, 0.0,'StrMPoleSymplectic4Pass');

for k=length(ATi.COR):-1:1,
    THERING = [THERING(1:ATi.COR(k)),{HMulCorr, VMulCorr}, THERING(ATi.COR(k)+1:end)];
end

updateatindex(THERING);
ATi = atindex(THERING);
