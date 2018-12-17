function [C, Leff, MagnetType, A] = magnetcoefficients(MagnetCoreType, Amps, InputType)
%MAGNETCOEFFICIENTS - Retrieves coefficient for conversion between Physics and Hardware units
% 
% Based on the measured integrated field strength BL.
% 
%
%[C, Leff, MagnetType, A] = magnetcoefficients(MagnetCoreType)
%
%
%
% INPUTS
% 1. MagnetCoreType - Family name or type of magnet
%
% OUTPUTS
% 1. C vector coefficients for the polynomial expansion of the magnet field
%    based on magnet measurements; for non-dipole magnets
% 2. Leff - Effective length ie, which is used in AT
% 3. MagnetType
% 4. A - vector coefficients for the polynomial expansion of the curviline 
%        integral of the magnet field based on magnet measurements
%
% C and A are vector coefficients for the polynomial expansion of the magnet field
% based on magnet measurements.
%
% The amp2k and k2amp functions convert between the two types of units.
%   amp2k returns BLeff, B'Leff, or B"Leff scaled by Brho if A-coefficients are used.
%   amp2k returns B    , B'    , or B"     scaled by Brho if C-coefficients are used.
%
% The A coefficients are direct from magnet measurements with a DC term:
%   a8*I^8+a7*I^7+a6*I^6+a5*I^5+a4*I^4+a3*I^3+a2*I^2+a1*I+a0 = B*Leff or B'*Leff or B"*Leff
%   A = [a8 a7 a6 a5 a4 a3 a2 a1 a0]
%
% C coefficients have been scaled to field (AT units, except correctors) and includes a DC term:
%   c8 * I^8+ c7 * I^7+ c6 * I^6 + c5 * I^5 + c4 * I^4 + c3 * I^3 + c2 * I^2 + c1*I + c0 = B or B' or B"
%   C = A/Leff
%
% For dipole:      k = B / Brho      (for AT: KickAngle = BLeff / Brho)
% For quadrupole:  k = B'/ Brho
% For sextupole:   k = B"/ Brho / 2  (to be compatible with AT)
%                  (all coefficients all divided by 2 for sextupoles)
%
% MagnetCoreType is the magnet measurements name for the magnet core (string, string matrix, or cell)
%   For SOLEIL:   BEND
%                 Q1 - Q10 S1 - S10,
%                 QT, HCOR, VCOR, FHCOR, FVCOR
%
% Leff is the effective length of the magnet
%
% See Also amp2k, k2amp

%
% Written by M. Yoon 4/8/03
% Adapted By Laurent S. Nadolski354.09672
%
% Partie Anneau modifi???e par P. Brunelle et A. Nadji le 31/03/06
%
% Add a switch on accelerator 

% NOTE: Make sure the sign on the 'C' coefficients is reversed where positive current generates negative K-values
% Or use Tango K value set to -1
%
%
% Customized by Jianfeng Zhang for ThomX @ LAL 21/06/2013
%
%



if nargin < 1
    error('MagnetCoreType input required');
end

if nargin < 2
    Amps = 159.2996;  % not sure!!!
end

if nargin < 3
    InputType = 'Amps';
end



% For a string matrix
if iscell(MagnetCoreType)
    for i = 1:size(MagnetCoreType,1)
        for j = 1:size(MagnetCoreType,2)
            [C{i,j}, Leff{i,j}, MagnetType{i,j}, A{i,j}] = magnetcoefficients(MagnetCoreType{i});
        end
    end
    return
end

% For a string matrix
if size(MagnetCoreType,1) > 1
    C=[]; Leff=[]; MagnetType=[]; A=[];
    for i = 1:size(MagnetCoreType,1)
        [C1, Leff1, MagnetType1, A1] = magnetcoefficients(MagnetCoreType(i,:));
        C(i,:) = C1;
        Leff(i,:) = Leff1;
        MagnetType = strvcat(MagnetType, MagnetType1);
        A(i,:) = A1;
    end
    return
end

%% get accelerator name
AcceleratorName = getfamilydata('SubMachine');

%need to be upgraded in the future after the magnet measurement
switch AcceleratorName
    %%
    case {'TL','TL_SL','TL_OC','TL_SST2'}
        %%%%
        switch upper(deblank(MagnetCoreType))

            case {'BEND1'}    
                Leff =  0.27646; % same as the dipole in the ring
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  0.0;
                a3 =  0.0;
                a2 =  0.0;
                a1 =  1*0.1685*Leff;
                a0 =  0.0; 
                
            A = [a7 a6 a5 a4 a3 a2 a1 a0];
                
                MagnetType = 'BEND';
                
                case {'BEND2'}    
                Leff = 0.2009579; % small dipole to kick the beam inside the ring                   
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  0.0;
                a3 =  0.0;
                a2 =  0.0;
                a1 =  1*0.1685*Leff;
                a0 =  0.0; 
                
            A = [a7 a6 a5 a4 a3 a2 a1 a0];

                MagnetType = 'BEND';

            case {'QP1L', 'QP2L','QP3L','QP4L','QP5L','QP6L','QP7L'}   
                % Find the current from the given polynomial for B'Leff
                Leff=0.150; % 150 mm;
                a8 =  0.0;
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  0.0;
                a3 =  0.0;
                a2 =  0.0;
                a1 =  1*0.1685*Leff;
                a0 =  0.0;              
                
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                MagnetType = 'QUAD';
                
            case {'SEP'}
                % Septum 
                Leff = .251072;
                vmax = 547; % tension de mesure V
                SBDL = 263e-3; % somme de Bdl mesur??e
                MagnetType = 'SEP';
                A = [0 SBDL/vmax 0]*Leff;   

            case {'HCOR','VCOR'}    % 16 cm horizontal corrector
                % Magnet Spec: Theta = 0.8e-3 radians @ 2.75 GeV and 10 amps
                % Theta = BLeff / Brho    [radians]
                % Therefore,
                %       Theta = ((BLeff/Amp)/ Brho) * I
                %       BLeff/Amp = 0.8e-3 * getbrho(2.75) / 10
                %       B*Leff = a0 * I   => a0 = 0.8e-3 * getbrho(2.75) / 10
                %
                % The C coefficients are w.r.t B
                %       B = c0 + c1*I = (0 + a0*I)/Leff
                % However, AT uses Theta in radians so the A coefficients
                % must be used for correctors with the middle layer with
                % the addition of the DC term

                % Find the current from the given polynomial for BLeff and B
                % NOTE: AT used BLeff (A) for correctors
                MagnetType = 'COR';
                
                Leff = 1e-6; % thin or thick???
                a8 =  0.0;
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  0.0;
                a3 =  0.0;
                a2 =  0.0;
                a1 =  1*0.1685*Leff;
                a0 =  0;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                
            otherwise
                error(sprintf('MagnetCoreType %s is not unknown', MagnetCoreType));
                %k = 0;
                %MagnetType = '';
                %return
        end

        % compute B-field = int(Bdl)/Leff
        C = A/ Leff;

        MagnetType = upper(MagnetType);
    
    case 'StorageRing'
        %%%%
        switch upper(deblank(MagnetCoreType))

            case 'BEND'
                 % B = 0.45 T for I = 159.2995 A  Int Field 0.1323 T.m
                
                 if Amps < 130.820469
                     
                Leff = 0.296233;%0.27646;
                a7= 0.0;
                a6= 0.0;
                a5= 0.0;
                a4= 0.0;
                a3= 0.0;
                a2= 0.0;
%                 a1= 0.844123142591815e-3; %(for AT: KickAngle = BLeff / Brho)  
%                 a0= 0.803154051822182e-3;
                a1= 0.843006776926561e-3; %(for AT: KickAngle = BLeff / Brho)  
                a0= 0.845100722350169e-3;
                     
                     elseif Amps >= 130.820469
                         
                Leff = 0.296233;%0.27646;

%                 a7= 0.0;
%                 a6= 0.0;
%                 a5= 0.000000000000039;
%                 a4= -0.000000000071392;
%                 a3= 0.000000046967286;
%                 a2= -0.000015338474531; 
%                 a1= 0.003024513947454;  
%                 a0= -0.108101059161908;

                a7= 0.0;
                a6= 0.0;
                a5= 0.000000000000021;
                a4= -0.000000000053215;
                a3= 0.000000039635341;
                a2= -0.000013890014033; 
                a1= 0.002884328135855;  
                a0= -0.102781596475691;     
                
                 end
                A = [a7 a6 a5 a4 a3 a2 a1 a0];

                MagnetType = 'BEND';

         case {'QP1', 'QP2','QP3','QP4','QP31','QP41'}   
                         
                %Defocusing quad k < 0.Coeff a0, a2, a4,...to be multiply by -1.
                        
                
                % Find the current from the given polynomial for B'Leff
%                 Leff=0.15; 
%                 a7=  0.0;
%                 a6=  0.0;
%                 a5=  0.0;
%                 a4=  0.0;
%                 a3=  0.0;
%                 a2=  0;
%                 a1=  1*0.1685*Leff; % brho of THomX is 0.1685
%                 a0=  0;
                
                Leff=0.15731;%0.150; % 
                a7=  0.0;
                a6=  0.0;
                a5=  -0.000000297907379;
                a4=  0.000006617832544;
                a3=  -0.000055050541525;
                a2=  0.000114371606428;
                a1=  0.074914375225616; % kL/I*Brho
                a0=  0.007959570093829;
                
                
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                
                MagnetType = 'quad';
                
             case {'SX1','SX2','SX3'}    
                Leff=0.07316;%0.06;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  0.0;
                a1=  1*0.1685*Leff;
                a0=  0.0;
                A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
                MagnetType = 'SEXT';
                
                            
            case {'HCOR'}    
                Leff = 73.25e-3;
                a7= 0.0;
                a6= 0.0;
                a5= 0.0;
                a4= 0.0;
                a3= 0.0;
                a2= 0.0;
                a1= -8.8900e-05;
                a0= -2.1732e-05 ;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                
                MagnetType = 'COR';
                
         case {'VCOR'}    
                Leff = 73.25e-3;
                a7= 0.0;
                a6= 0.0;
                a5= 0.0;
                a4= 0.0;  
                a3= 0.0;
                a2= 0.0;
                a1=  -4.9945e-05;%1*0.1685*Leff;
                a0= -3.7622e-06 ;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                
                MagnetType = 'COR';
                
                case {'HCORT'}    
                Leff = 1e-6;
                a7= 0.0;
                a6= 0.0;
                a5= 0.0;
                a4= 0.0;
                a3= 0.0;
                a2= 0.0;
                a1= 1*0.1685*Leff;
                a0= 0.0;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                
                MagnetType = 'COR';
                
         case {'VCORT'}    
                Leff = 1e-6;
                a7= 0.0;
                a6= 0.0;
                a5= 0.0;
                a4= 0.0;
                a3= 0.0;
                a2= 0.0;
                a1= 1*0.1685*Leff;
                a0= 0.0;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                
                MagnetType = 'COR';

            case {'K_INJ'}
                % Kicker d'injection
                % ??talonnage provisoire
                % attention l'element n'etant pas dans le modele,definition
                % de A ambigue
                Leff = 0.2;
                vmax = 8000;
                alphamax = 8e-3 ; % 8 mrad pour 8000 V
                MagnetType = 'K_INJ';
                A = [0 alphamax*getbrho(50e-3)/vmax 0]*Leff; 
                
                case {'SEP'}
                % Septum
                Leff = .251072;
                vmax = 547; % tension de mesure V
                SBDL = 263e-3; % somme de Bdl mesur??e
                MagnetType = 'SEP';
                A = [0 SBDL/vmax 0]*Leff;   
                
                case 'QT'    % Not present in ThomX lattice but used to see the possibility of coupling, vert dispersion correction if needed
                Leff = 1e-8;
                a7= 0.0;
                a6= 0.0;
                a5= 0.0;
                a4= 0.0;
                a3= 0.0;
                a2= 0.0;
                a1= 93.83E-4;
                a0= 0.0;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];

                MagnetType = 'QT';

            otherwise
                error(sprintf('MagnetCoreType %s is not unknown', MagnetCoreType));
                k = 0;
                MagnetType = '';
                return
        end

        % compute B-field = int(Bdl)/Leff
        C = A / Leff;

        MagnetType = upper(MagnetType);


        % Power Series Denominator (Factoral) be AT compatible
        if strcmpi(MagnetType,'SEXT')
            C = C / 2;
        end
        if strcmpi(MagnetType,'OCTO')
            C = C / 6;
        end
        return;

    case 'EL'
        %%%%
        switch upper(deblank(MagnetCoreType))


        end

        % compute B-field = int(Bdl)/Leff
        C = A/ Leff;

        MagnetType = upper(MagnetType);

    otherwise
        error('Unknown accelerator name %s', AcceleratorName);
end
