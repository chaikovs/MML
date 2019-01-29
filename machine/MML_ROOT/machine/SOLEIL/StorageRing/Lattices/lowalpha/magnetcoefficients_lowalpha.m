function [C, Leff, MagnetType, A] = magnetcoefficients(MagnetCoreType, Amps, InputType)
%MAGNETCOEFFICIENTS - Retrieves coefficient for conversion between Physics and Hardware units
%[C, Leff, MagnetType, A] = magnetcoefficients(MagnetCoreType)
%
% INPUTS
% 1. MagnetCoreType - Family name or type of magnet
%
% OUTPUTS
% 1. C vector coefficients for the polynomial expansion of the magnet field
%    based on magnet measurements
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
% Partie Anneau modifioe par P. Brunelle et A. Nadji le 31/03/06
%
% Add a switch on accelerator 

% NOTE: Make sure the sign on the 'C' coefficients is reversed where positive current generates negative K-values
% Or use Tango K value set to -1


if nargin < 1
    error('MagnetCoreType input required');
end

if nargin < 2
    Amps = 230;  % not sure!!!
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
AcceleratorName = getfamilydata('Machine');

switch AcceleratorName
    case 'LT1'
        %%%%
        switch upper(deblank(MagnetCoreType))

            case 'BEND'    
                Leff = 0.30; % 300 mm
                % B = 1e-4 * (0.0004 Io + 16.334 I + 1.7202)
                a8 =  0.0;
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  0.0;
                a3 =  0.0;
                a2 =  0.0;
                a1 =  4.8861e-4;
                a0 =  1.19e-4;

                A = [a8 a7 a6 a5 a4 a3 a2 a1 a0];
                MagnetType = 'BEND';

            case {'QP'}   % 150 mm quadrupole
                % Find the current from the given polynomial for B'Leff
                Leff=0.150; % 162 mm;
                a8 =  0.0;
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
%                 a4 =  1.49e-6;
%                 a3 =  2.59e-5;
%                 a2 =  1.93e-4;
%                 a1 =  4.98e-2;
%                 a0 =  0.0;
                a4 =  -1.49e-6;
                a3 =  2.59e-5;
                a2 =  -1.93e-4;
                a1 =  4.98e-2;
                a0 =  8.13e-4;              
                
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                MagnetType = 'QUAD';

            case {'CH','CV'}    % 16 cm horizontal corrector
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
                
                Leff = 1e-6; % 0.1577 m
                a8 =  0.0;
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  0.0;
                a3 =  0.0;
                a2 =  0.0;
                a1 =  4.49e-4;
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
    
    case 'Ring'
        %%%%
        switch upper(deblank(MagnetCoreType))

            case 'BEND'   
                % Moyenne des longueurs magnotiques mesuroes = 1055.548mm
                % Decalage en champ entre le dipole de référence et les
                % dipoles de l'Anneau = DB/B= +1.8e-03.
                % On part de l'otalonnage B(I) effectuo sur le dipole de
                % reference dans la zone de courant 516 - 558 A 
                % les coefficients du fit doivent otre affectos du facteur
                % (1-1.8e-3) pour passer du dipole de roforence o l'Anneau
                % et du facteur Leff pour passer o l'intograle de champ.
                % 
                
                % B=1.7063474 T correspond o 2.75 GeV 
                % ?  longueur magnétique du model : Leff = 1.052433;
                
                Leff=1.052433;
                a7= 0.0;
                a6=-0.0;
                a5= 0.0;
                a4=-0.0;
                a3= 0.0;
                a2=-9.7816E-6*(1-1.8e-3)*Leff*(1.055548/1.052433);
                a1= 1.26066E-02*(1-1.8E-3)*Leff*(1.055548/1.052433);
                a0= -2.24944*(1-1.8E-3)*Leff*(1.055548/1.052433);
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                

                MagnetType = 'BEND';

            case {'Q1','Q3'}  
                % Familles Q1 et Q6 l= 320 mm 
                % Etalonnage GL(I) sur 70-130 A quadrupole court 
                % le courant remonto est nogatif car Q1 et Q6 dofocalisants
                % il faut donc un k < 0. Les coefficients du fit a0, a2,
                % a4,...sont multiplios par -1.
                
                % Correction des coefficients des QC de + 3 10-3 (manque
                % capteur BMS)
                
                %correction offset capteur BMS -2.310-3 P. Brunelle 30/05/06 
                bob=0.9977*(1-8e-3);
                % Find the current from the given polynomial for B'Leff
                Leff=0.320;

                
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  -5.461E-7*(-1)*(1.003)*bob;
                a1=  2.759E-2*(1.003)*bob;
                a0=  5.797E-4*(-1)*(1.003)*bob;
         
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                
                MagnetType = 'quad';
                
             case {'Q8'}  
                % Familles Q8 et Q9 l= 320 mm 
                % Etalonnage GL(I) sur 70-130 A quadrupole court 
                % QUADRUPOLE INVERSE PAR RAPPORT A NOMINAL I>0
                
                % Correction des coefficients des QC de + 3 10-3 (manque
                % capteur BMS)
                
                %correction offset capteur BMS -2.310-3 P. Brunelle 30/05/06 
                bob=0.9977*(1-8e-3);

                % Find the current from the given polynomial for B'Leff
                Leff=0.320;

                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2= -5.461E-7*(1.003)*bob;
                a1=  2.759E-2*(1.003)*bob;
                a0=  5.797E-4*(1.003)*bob;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                
                MagnetType = 'quad';  
                
            case {'Q4', 'Q9'}  
                % Famille Q3 l= 320 mm 
                % Etalonnage GL(I) sur 110-170 A quadrupole court 
                % le courant remonto est nogatif car Q3 est dofocalisant
                % il faut donc un k < 0. Les coefficients du fit a0, a2,
                % a4,...sont multiplios par -1.
                
                %Correction des coefficients des QC de + 3 10-3 (manque
                % capteur BMS)
                
                %correction offset capteur BMS -2.310-3 P. Brunelle 30/05/06 
                bob=0.9977*(1-8e-3);

                % Find the current from the given polynomial for B'Leff
                Leff=0.320;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3= -4.537E-8*(1.003)*bob;
                a2=  1.637E-5*(-1)*(1.003)*bob;
                a1=  2.549E-2*(1.003)*bob;
                a0=  8.715E-2*(-1)*(1.003)*bob;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                
                MagnetType = 'quad'; 
                
             case {'Q6'}  
                % Famille Q4 l= 320 mm 
                % Etalonnage GL(I) sur 150-190 A quadrupole court 
                % le courant remonto est nogatif car Q4 est dofocalisant
                % il faut donc un k < 0. Les coefficients du fit a0, a2,
                % a4,...sont multiplios par -1.
                
                %Correction des coefficients des QC de + 3 10-3 (manque
                % capteur BMS)
                
                %correction offset capteur BMS -2.310-3 P. Brunelle 30/05/06 
                bob=0.9977*(1-8e-3);
                
                % Find the current from the given polynomial for B'Leff
                Leff=0.320;

                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3= -1.694E-7*(1.003)*bob;
                a2=  7.896E-5*(-1)*(1.003)*bob;
                a1=  1.499E-2*(1.003)*bob;
                a0=  6.722E-1*(-1)*(1.003)*bob;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                
                MagnetType = 'quad'; 
                
            case {'Q5'}   % 320 mm quadrupole
                 % Familles Q5 et Q10 l= 320 mm 
                % Etalonnage GL(I) sur 180 - 220 A quadrupole court 
                % le courant remonto est nogatif car Q5 et Q10 sont
                % focalisants
                
                %Correction des coefficients des QC de + 3 10-3 (manque
                % capteur BMS)
                
                %correction offset capteur BMS -2.310-3 P. Brunelle 30/05/06 
                bob=0.9977*(1-8e-3);
                
                % Find the current from the given polynomial for B'Leff
                Leff=0.320;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4= -1.143E-8*(1.003)*bob;
                a3=  8.693E-06*(1.003)*bob;
                a2= -2.491E-03*(1.003)*bob;
                a1=  3.456E-01*(1.003)*bob;
                a0= -1.524E+01*(1.003)*bob;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];

                MagnetType = 'quad';    
                    
                case {'Q10'}   % 320 mm quadrupole
                 % Familles Q5 et Q10 l= 320 mm 
                % Etalonnage GL(I) sur 200-240 A quadrupole court 
                % le courant remonto est nogatif car Q5 et Q10 sont
                % focalisants
                
                %Correction des coefficients des QC de + 3 10-3 (manque
                % capteur BMS)
                
                %correction offset capteur BMS -2.310-3 P. Brunelle 30/05/06 
                bob=0.9977*(1-8e-3);
                
                % Find the current from the given polynomial for B'Leff
                Leff=0.320;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4= -1.105E-7*(1.003)*bob;
                a3=  9.504E-5*(1.003)*bob;
                a2= -3.069E-2*(1.003)*bob;
                a1=  4.435*(1.003)*bob;
                a0= -2.375E+2*(1.003)*bob;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];

                MagnetType = 'quad';    
                
            case {'Q2'}   % l= 460 mm 
                % quadrupole focalisant
                % Etalonnage GL(I) sur 130-170 A quadrupole long
                
                
                %Correction des coefficients des QL de + 1.55 10-2 (manque
                % capteur BMS)
                
                %correction offset capteur BMS -2.310-3 P. Brunelle 30/05/06 
                bob=0.9977*(1-8e-3);

                % Find the current from the given polynomial for B'Leff
                Leff=0.460;
                a7=  0.0;
                a6=  0.0;
                a5= -0.0;
                a4=  0.0;
                a3= -1.618E-7*(1.0155)*bob;
                a2=  6.22E-5*(1.0155)*bob;
                a1=  3.645E-2*(1.0155)*bob;
                a0=  3.624E-1*(1.0155)*bob;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                MagnetType = 'quad';

            case {'Q7'}   % l= 460 mm 
                % quadrupole focalisant
                % Etalonnage GL(I) sur 90-130 A quadrupole long
                
                %Correction des coefficients des QL de + 1.55 10-2 (manque
                % capteur BMS)
                
                %correction offset capteur BMS -2.310-3 P. Brunelle 30/05/06 
                bob=0.9977*(1-8e-3);

                % Find the current from the given polynomial for B'Leff
                Leff=0.460;

                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2= -2.118E-6*(1.0155)*bob;
                a1=  4.502E-2*(1.0155)*bob;
                a0= -1.980E-2*(1.0155)*bob;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                MagnetType = 'quad';

                % Sextupoles : on multiplie les coefficients par 2 car ils
                % sont exprimes en B"L et non B"L/2
                
            case {'S1'}    
                % l= 160 mm focalisants
                % Etalonnage HL(I) sur 40 - 160 A
                % Find the current from the given polynomial for B''Leff
                Leff=1e-8; % modeled as thin length;

                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2= -3.773E-6*(-1);
                a1=  1.5476E-1;
                a0=  2.36991E-1*(-1);
                A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
                MagnetType = 'SEXT';
                
                
            case {'S2','S7','S5'}    
                % l= 160 mm dofocalisants
                % Etalonnage HL(I) sur 80 - 250 A
                % Find the current from the given polynomial for B''Leff
                Leff=1e-8; % modeled as thin length;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  -2.6735E-8;
                a2=  5.8793E-6*(-1);
                a1=  1.5364E-1;
                a0=  2.7867E-1*(-1);
                A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
                MagnetType = 'SEXT';
                
             case {'S6', 'S8'}    
                % l= 160 mm focalisant
                % Etalonnage HL(I) sur 80 - 250 A
                % Find the current from the given polynomial for B''Leff
                Leff=1e-8; % modeled as thin length;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3= -2.6735E-8;
                a2=  5.8793E-6;
                a1=  1.5364E-1;
                a0=  2.7867E-1;
                A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
                MagnetType = 'SEXT';

                
              case {'S4','S10'}    
                % l= 160 mm focalisants
                % Etalonnage HL(I) sur 170 - 300 A
                % Find the current from the given polynomial for B''Leff
                Leff=1e-8; % modeled as thin length;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4= -8.8836E-10;
                a3=  7.1089E-7;
                a2= -2.2277E-4;
                a1=  1.8501E-1;
                a0= -1.329;
                A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
                MagnetType = 'SEXT';

             case {'S3','S9'}    
                % l= 160 mm dofocalisants
                % Etalonnage HL(I) sur 170 - 300 A
                % Find the current from the given polynomial for B''Leff
                Leff=1e-8; % modeled as thin length;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4= -8.8836E-10*(-1);
                a3=  7.1089E-7;
                a2= -2.2277E-4*(-1);
                a1=  1.8501E-1;
                a0= -1.329*(-1);
                A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
                MagnetType = 'SEXT';    
        
            case 'QT'    % 160 mm dans sextupole
                % Etalonnage: moyenne sur les 32 sextupoles incluant un QT.
                % Efficacito = 3 G.m/A @ R=32mm; soit 93.83 G/A
                % Le signe du courant est donno par le DeviceServer (Tango)
                % Find the currAO.(ifam).Monitor.HW2PhysicsParams{1}(1,:) = magnetcoefficients(AO.(ifam).FamilyName );
                Leff = 0.16;
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

            case {'HCOR'}    % 16 cm horizontal corrector
                % Etalonnage: moyenne sur les 56 sextupoles incluant un CORH.
                % Efficacito = 8.143 G.m/A 
                % Le signe du courant est donno par le DeviceServer (Tango)
                % Find the currAO.(ifam).Monitor.HW2PhysicsParams{1}(1,:) = magnetcoefficients(AO.(ifam).FamilyName );
                Leff = 0.16;
                a7= 0.0;
                a6= 0.0;
                a5= 0.0;
                a4= 0.0;
                a3= 0.0;
                a2= 0.0;
                a1= 8.143E-4;
                a0= 0.0;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];

                MagnetType = 'COR';
                

            case {'FHCOR'}    % 10 cm horizontal corrector
                % Magnet Spec: Theta = 280e-6 radians @ 2.75 GeV and 10 amps
                % Theta = BLeff / Brho    [radians]
                % Therefore,
                %       Theta = ((BLeff/Amp)/ Brho) * I
                %       BLeff/Amp = 280e-6 * getbrho(2.75) / 10
                %       B*Leff = a0 * I   => a0 = 0.8e-3 * getbrho(2.75) / 10
                %
                % The C coefficients are w.r.t B
                %       B = c0 + c1*I = (0 + a0*I)/Leff
                % However, AT uses Theta in radians so the A coefficients
                % must be used for correctors with the middle layer with
                % the addition of the DC term

                % Find the current from the given polynomial for BLeff and B
                % NOTE: AT used BLeff (A) for correctors
                Leff = .10;
                imax = 10;
                cormax = 28e-6 ; % 28 urad for imax = 10 A
                MagnetType = 'COR';
                A = [0 cormax*getbrho(2.75)/imax 0];

            case {'VCOR'}    % 16 cm vertical corrector
                % Etalonnage: moyenne sur les 56 sextupoles incluant un CORV.
                % Efficacito = 4.642 G.m/A 
                % Le signe du courant est donno par le DeviceServer (Tango)
                % Find the currAO.(ifam).Monitor.HW2PhysicsParams{1}(1,:) = magnetcoefficients(AO.(ifam).FamilyName );
                Leff = 0.16;
                a7= 0.0;
                a6= 0.0;
                a5= 0.0;
                a4= 0.0;
                a3= 0.0;
                a2= 0.0;
                a1= 4.642E-4;
                a0= 0.0;
                A = [a7 a6 a5 a4 a3 a2 a1 a0];

                MagnetType = 'COR';

            case {'FVCOR'}    % 10 cm vertical corrector
                % Find the current from the given polynomial for BLeff and B
                Leff = .10;
                imax = 10;
                cormax = 23e-6 ; % 23 urad for imax = 10 A
                MagnetType = 'COR';
                A = [0 cormax*getbrho(2.75)/imax 0];

            case {'K_INJ'}
                % Kicker d'injection
                % étalonnage provisoire
                % attention l'element n'etant pas dans le modele,definition
                % de A ambigue
                Leff = .6;
                vmax = 8000;
                alphamax = 8e-3 ; % 8 mrad pour 8000 V
                MagnetType = 'K_INJ';
                A = [0 alphamax*getbrho(2.75)/vmax 0]*Leff;
                
             case {'K_INJ1'}
                % Kickers d'injection 1 et 4
                Leff = .6;
                vmax = 7500; % tension de mesure
                SBDL = 75.230e-3 ; % somme de Bdl mesurée
                MagnetType = 'K_INJ1';
                A = [0 -SBDL/vmax 0]*Leff; 
                
             case {'K_INJ2'}
                % Kickers d'injection 2 et 3
                Leff = .6;
                vmax = 7500;% tension de mesure
                SBDL = 74.800e-3 ; % somme de Bdl mesurée
                MagnetType = 'K_INJ2';  
                A = [0 SBDL/vmax 0]*Leff; 
                
            case {'SEP_P'}
                % Septum passif d'injection
                Leff = .6;
                vmax = 547; % tension de mesure V
                SBDL = 263e-3; % somme de Bdl mesurée
                MagnetType = 'SEP_P';
                A = [0 SBDL/vmax 0]*Leff; 
                
             case {'SEP_A'}
                % Septum actif d'injection
                Leff = 1.;
                vmax = 111;
                MagnetType = 'SEP_A';
                SBDL = 1147.8e-3 ; % Somme de Bdl mesurée à 111 V
                A = [0 SBDL/vmax 0]*Leff; 

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
    case 'Booster'
        %%%%
        switch upper(deblank(MagnetCoreType))

            case 'BEND'    
                % B[T] = 0.00020 + 0.0013516 I[A]
                % B[T] = 0.00020 + (0.0013051 + 0.00005/540 I) I[A] Alex
                Leff = 2.160; % 2160 mm                
                a8 =  0.0;
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  0.0;
                a3 =  0.0;
                a2 =  9.2e-8*Leff;
                a1 =  0.0013051*Leff;
                a0 =  2.0e-3*Leff;

                A = [a8 a7 a6 a5 a4 a3 a2 a1 a0];
                MagnetType = 'BEND';

            case {'QF'}   % 400 mm quadrupole
                % Find the current from the given polynomial for B'Leff
                % G[T/m] = 0.0465 + 0.0516 I[A] Alex
                Leff=0.400; 
                a8 =  0.0;
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  0.0;
                a3 =  0.0;
                a2 =  0.0;
                a1 =  0.0516*Leff;
                a0 =  0.0465*Leff;
                
                A = [a7 a6 a5 a4 a3 a2 a1 a0]; %*getbrho(0.1);
                MagnetType = 'QUAD';

            case {'QD'}   % 400 mm quadrupole
                % Find the current from the given polynomial for B'Leff
                % G[T/m] = 0.0485 + 0.0518 I[A] Alex
                Leff=0.400; 
                a8 =  0.0;
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  0.0;
                a3 =  0.0;
                a2 =  0.0;
                a1 =  -0.0518*Leff;
                a0 =  -0.0485*Leff;
                
                A = [a7 a6 a5 a4 a3 a2 a1 a0]; %*getbrho(0.1);
                MagnetType = 'QUAD';

            case {'SF', 'SD'}   % 150 mm sextupole
                % Find the current from the given polynomial for B'Leff
                % HL [T/m] = 0.2 I [A] (deja intogro)
                Leff=1.e-8; % thin lens;
                a8 =  0.0;
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  0.0;
                a3 =  0.0;
                a2 =  0.0;
                a1 =  0.2*2;
                a0 =  0.0;
                
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                MagnetType = 'SEXT';
                
            case {'HCOR','VCOR'}    % ?? cm horizontal corrector
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
                % theta [mrad] = 1.34 I[A] @ 0.1 GeV
                Leff = 1e-6;
                a8 =  0.0;
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  0.0;
                a3 =  0.0;
                a2 =  0.0;
                a1 =  1.34e-3*getbrho(0.1);
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
 
        % Power Series Denominator (Factoral) be AT compatible
        if strcmpi(MagnetType,'SEXT')
            C = C / 2;
        end
 
        MagnetType = upper(MagnetType);

    case 'LT2'
        %%%%
        switch upper(deblank(MagnetCoreType))

            case 'BEND'    
                % les coefficients et longueur magnétique sont recopiés de l'anneau
                Leff=1.052433;
                a7= 0.0;
                a6=-0.0;
                a5= 0.0;
                a4=-0.0;
                a3= 0.0;
                a2=-9.7816E-6*(1-1.8e-3)*Leff*(1.055548/1.052433);
                a1= 1.26066E-02*(1-1.8E-3)*Leff*(1.055548/1.052433);
                a0= -2.24944*(1-1.8E-3)*Leff*(1.055548/1.052433);
                A = [a7 a6 a5 a4 a3 a2 a1 a0];
                

                MagnetType = 'BEND';

            case {'QP'}   % 400 mm quadrupole
                % Find the current from the given polynomial for B'Leff
                
                % G[T/m] = 0.1175 + 0.0517 I[A]
                % le rémanent est + fort que pour les quad Booster car les
                % courants max sont + eleves
                Leff=0.400; 
%                 a8 =  0.0;
%                 a7 =  0.0;
%                 a6 =  0.0;
%                 a5 =  0.0;
%                 a4 =  0.0;
%                 a3 =  0.0;
%                 a2 =  0.0;
%                 a1 =  0.0517*Leff;
%                 a0 =  0.1175*Leff;
                
                a8 =  0.0;
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  -1.3345e-10;
                a3 =  8.1746e-8;
                a2 =  -1.6548e-5;
                a1 =  2.197e-2;
                a0 =  2.73e-2;
                A = [a7 a6 a5 a4 a3 a2 a1 a0]; 
                MagnetType = 'QUAD';

            case {'CH','CV'}    % 16 cm horizontal corrector
                

                
                % Magnet Spec: Theta = environ 1 mradians @ 2.75 GeV and 10 amps
                % Theta = BLeff / Brho    [radians]
                % Therefore,
                %       Theta = ((BLeff/Amp)/ Brho) * I
                %       BLeff/Amp = 1.e-3 * getbrho(2.75) / 10
                %       B*Leff = a1 * I   => a1 = 1.e-3 * getbrho(2.75) / 10
                %
                % The C coefficients are w.r.t B
                %       B = c0 + c1*I = (0 + a0*I)/Leff
                % However, AT uses Theta in radians so the A coefficients
                % must be used for correctors with the middle layer with
                % the addition of the DC term

                % Find the current from the given polynomial for BLeff and B
                % NOTE: AT used BLeff (A) for correctors
                
                % environ 32 cm  corrector
                % Efficacito = 11.06 G.m/A 
                % Le signe du courant est donno par le DeviceServer (Tango)
                % Find the currAO.(ifam).Monitor.HW2PhysicsParams{1}(1,:) =
                % magnetcoefficien
                
                MagnetType = 'COR';
                
                Leff = 1e-6; % 0.1577 m
                a8 =  0.0;
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  0.0;
                a3 =  0.0;
                a2 =  0.0;
                a1 =  110.6e-4/10;
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

    otherwise
        error('Unknown accelerator name %s', AcceleratorName);
end
