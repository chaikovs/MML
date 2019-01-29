function [C, Leff, MagnetType, A] = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m(MagnetCoreType, Amps, InputType)
%magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m - Retrieves coefficient for conversion between Physics and Hardware units
%[C, Leff, MagnetType, A] = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m(MagnetCoreType)
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
% Partie Anneau modifiee par P. Brunelle et A. Nadji le 31/03/06
%
% Add a switch on accelerator 

% NOTE: Make sure the sign on the 'C' coefficients is reversed where positive current generates negative K-values
% Or use Tango K value set to -1

% 21 octobre 2008 - P. Brunelle - Qpoles anneau - introduction des coefficents deduits de
% l'etalonnage en courant utilisant les vraies valeurs des courants. Les anciens
% coefficients sont commentes.

% 7 mai 2009 - P. Brunelle - Spoles anneau - introduction des coefficents deduits de
% l'etalonnage en courant utilisant les vraies valeurs des courants + repartition par intervalle de courant.

% 12 juin 2009 - P. Brunelle - Qpoles anneau - repartition par intervalle de courant.

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
            [C{i,j}, Leff{i,j}, MagnetType{i,j}, A{i,j}] = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m(MagnetCoreType{i});
        end
    end
    return
end

% For a string matrix
if size(MagnetCoreType,1) > 1
    C=[]; Leff=[]; MagnetType=[]; A=[];
    for i = 1:size(MagnetCoreType,1)
        [C1, Leff1, MagnetType1, A1] = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m(MagnetCoreType(i,:));
        C(i,:) = C1;
        Leff(i,:) = Leff1;
        MagnetType = strvcat(MagnetType, MagnetType1);
        A(i,:) = A1;
    end
    return
end

%% get accelerator name
AcceleratorName = getfamilydata('SubMachine');

switch AcceleratorName
    %% LT1
    case 'LT1'
        %%%%
        switch upper(deblank(MagnetCoreType))

            case 'BEND'    
                Leff = 0.30; % 300 mm
                % B = 1e-4 * (0.0004 I^2 + 16.334 I + 1.7202)
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
                a4 =  -1.49e-6;
                a3 =  2.59e-5;
                a2 =  -1.93e-4;
                a1 =  4.98e-2;
                a0 =  8.13e-4;              
                
                A = [a8 a7 a6 a5 a4 a3 a2 a1 a0];
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
                A = [a8 a7 a6 a5 a4 a3 a2 a1 a0];
                
            otherwise
                error('MagnetCoreType %s is not unknown', MagnetCoreType);
        end

        % compute B-field = int(Bdl)/Leff
        C = A/ Leff;

        MagnetType = upper(MagnetType);
    %% StorageRing
    case 'StorageRing'
        % longueur des quadrupoles ajustee a Lintermediaire ente Lmag et Lcalc
        coeffQ =    0e-3   ;  %0e-3  ;  %  0e-3     %  0e-3 ;   %  0e-3      ;  %  8e-3  ;   % applique sur le premier faisceau
        LtotQC = 0.3602  ; % 0.3602 ; %0.3539 ;%  0.3696   % 0.3539;   %  0.3695814 ;  % 0.320 ;   % longueur effective Qpole court
        LtotQL = 0.4962  ; % 0.4962 ; %0.4917 ; %  0.5028   % 0.4917;   %  0.5027758 ;  %  0.460 ;   % longueur effective Qpole long
        %correction offset capteur BMS -2.310-3 (P. Brunelle 30/05/06) 
        bob=0.9977*(1-coeffQ);
        % longueur des sextupoles
        LtotSX = 1E-08;
        
        switch upper(deblank(MagnetCoreType))
                      
            case 'BEND'   
                % Moyenne des longueurs magnetiques mesurees = 1055.548mm
                % Decalage en champ entre le dipole de reference et les
                % dipoles de l'Anneau = DB/B= +1.8e-03.
                % On part de l'etalonnage B(I) effectue sur le dipole de
                % reference dans la zone de courant 516 - 558 A 
                % les coefficients du fit doivent etre affectes du facteur
                % (1-1.8e-3) pour passer du dipole de reference a l'Anneau
                % et du facteur Leff pour passer a l'integrale de champ.
                               
                % B=1.7063474 T correspond a 2.75 GeV 
                % longueur magnetique du modele : Leff = 1.052433;              
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

  % QUADRUPOLES COURTS
  % Correction des coefficients des QC de + 3 10-3 (manque de longueur du capteur BMS)
                
          
%                 % CAS DU QUADRUPOLE COURT DONT LE COURANT EST COMPRIS ENTRE 0 et 50A
%                 % POLARITE -
%                 Leff=LtotQC;
%                 a7=  0.0;
%                 a6=  0.0;
%                 a5=  0.0;
%                 a4=  0.0;
%                 a3=  0.0;
%                 a2=  1.19203E-6*(-1)*(1.003)*bob;
%                 a1=  2.74719E-2*(1.003)*bob;
%                 a0=  2.04817E-2*(-1)*(1.003)*bob;        
%                 A = [a7 a6 a5 a4 a3 a2 a1 a0];                
%                 MagnetType = 'quad';
    
                case {'Q3'}  
                % CAS DU QUADRUPOLE COURT DONT LE COURANT EST COMPRIS ENTRE 50 et 100A
                % POLARITE -
                Leff=LtotQC;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  -1.78428E-7*(-1)*(1.003)*bob;
                a1=  2.75663E-2*(1.003)*bob;
                a0=  1.90367E-2*(-1)*(1.003)*bob;        
                A = [a7 a6 a5 a4 a3 a2 a1 a0];                
                MagnetType = 'quad';  
                
                case {'Q1','Q4','Q6'} 
                % CAS DU QUADRUPOLE COURT DONT LE COURANT EST COMPRIS ENTRE 100 et 150A
                % POLARITE -
                Leff=LtotQC;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  -1.72242E-6*(-1)*(1.003)*bob;
                a1=   2.78608E-2*(1.003)*bob;
                a0=   4.86245E-3*(-1)*(1.003)*bob;        
                A = [a7 a6 a5 a4 a3 a2 a1 a0];                
                MagnetType = 'quad';
                
                case {'Q8','Q9'} 
                % CAS DU QUADRUPOLE COURT DONT LE COURANT EST COMPRIS ENTRE 150 et 200A
                % POLARITE -
                Leff=LtotQC;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  -9.77342E-6*(-1)*(1.003)*bob;
                a1=   3.03524E-2*(1.003)*bob;
                a0=  -1.88248E-1*(-1)*(1.003)*bob;        
                A = [a7 a6 a5 a4 a3 a2 a1 a0];                
                MagnetType = 'quad';
                
                case {'Q5','Q10'}
                % CAS DU QUADRUPOLE COURT DONT LE COURANT EST COMPRIS ENTRE 200 et 230A
                % POLARITE +
                Leff=LtotQC;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  -5.40235E-5*(1.003)*bob;
                a1=   4.82385E-2*(1.003)*bob;
                a0=  -1.99661*(1.003)*bob;        
                A = [a7 a6 a5 a4 a3 a2 a1 a0];                
                MagnetType = 'quad';

                case {'Q11'}
                % CAS DU QUADRUPOLE COURT DONT LE COURANT EST COMPRIS ENTRE 200 et 230A
                % POLARITE -
                Leff=LtotQC;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=   5.40235E-5*(1.003)*bob;
                a1=   4.82385E-2*(1.003)*bob;
                a0=   1.99661*(1.003)*bob;        
                A = [a7 a6 a5 a4 a3 a2 a1 a0];                
                MagnetType = 'quad';
                
%                 % CAS DU QUADRUPOLE COURT DONT LE COURANT EST COMPRIS ENTRE 230 et 250A
%                 % POLARITE +
%                 Leff=LtotQC;
%                 a7=  0.0;
%                 a6=  0.0;
%                 a5=  0.0;
%                 a4=  0.0;
%                 a3=  0.0;
%                 a2=  -1.51646E-4*(1.003)*bob;
%                 a1=  9.16800E-2*(1.003)*bob;
%                 a0=  -6.82533*(1.003)*bob;        
%                 A = [a7 a6 a5 a4 a3 a2 a1 a0];                
%                 MagnetType = 'quad';
                
   
% QUADRUPOLES LONGS
%Correction des coefficients des QL de + 1.55 10-2 (manque de longueur du capteur BMS)
            
%                 % CAS DU QUADRUPOLE LONG DONT LE COURANT EST COMPRIS ENTRE 0 et 50A
%                 % POLARITE +
%                 Leff=LtotQL;
%                 a7=  0.0;
%                 a6=  0.0;
%                 a5=  0.0;
%                 a4=  0.0;
%                 a3=  0.0;
%                 a2=  2.08013E-6*(1.0155)*bob;
%                 a1=  4.44797E-2*(1.0155)*bob;
%                 a0=  2.79903E-2*(1.0155)*bob;        
%                 A = [a7 a6 a5 a4 a3 a2 a1 a0];                
%                 MagnetType = 'quad';
%                 
%                 % CAS DU QUADRUPOLE LONG DONT LE COURANT EST COMPRIS ENTRE 50 et 100A
%                 % POLARITE +
%                 Leff=LtotQL;
%                 a7=  0.0;
%                 a6=  0.0;
%                 a5=  0.0;
%                 a4=  0.0;
%                 a3=  0.0;
%                 a2=  -3.60748E-7*(1.0155)*bob;
%                 a1=  4.46626E-2*(1.0155)*bob;
%                 a0=  2.47397E-2*(1.0155)*bob;        
%                 A = [a7 a6 a5 a4 a3 a2 a1 a0];                
%                 MagnetType = 'quad';
%                 
%                 % CAS DU QUADRUPOLE LONG DONT LE COURANT EST COMPRIS ENTRE 100 et 150A
%                 % POLARITE +
%                 Leff=LtotQL;
%                 a7=  0.0;
%                 a6=  0.0;
%                 a5=  0.0;
%                 a4=  0.0;
%                 a3=  0.0;
%                 a2=  -4.70168E-6*(1.0155)*bob;
%                 a1=  4.55728E-2*(1.0155)*bob;
%                 a0=  -2.30870E-2*(1.0155)*bob;        
%                 A = [a7 a6 a5 a4 a3 a2 a1 a0];                
%                 MagnetType = 'quad';
                
                case {'Q2'} 
                % CAS DU QUADRUPOLE LONG DONT LE COURANT EST COMPRIS ENTRE 150 et 180A
                % POLARITE +
                Leff=LtotQL;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  -1.92014E-5*(1.0155)*bob;
                a1=   4.99176E-2*(1.0155)*bob;
                a0=  -3.48990E-1*(1.0155)*bob;        
                A = [a7 a6 a5 a4 a3 a2 a1 a0];                
                MagnetType = 'quad';
              
                case {'Q7', 'Q12'} 
                % CAS DU QUADRUPOLE LONG DONT LE COURANT EST COMPRIS ENTRE 180 et 220A
                % POLARITE +
                Leff=LtotQL;
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  -2.41754E-8*(1.0155)*bob;
                a3=   1.69646E-5*(1.0155)*bob;
                a2=  -4.49256E-3*(1.0155)*bob;
                a1=   5.75113E-1*(1.0155)*bob;
                a0=  -2.35068E+1*(1.0155)*bob;        
                A = [a7 a6 a5 a4 a3 a2 a1 a0];                
                MagnetType = 'quad';
                
%                 % CAS DU QUADRUPOLE LONG DONT LE COURANT EST COMPRIS ENTRE 220 et 250A
%                 % POLARITE +
%                 Leff=LtotQL;
%                 a7=  0.0;
%                 a6=  0.0;
%                 a5=  0.0;
%                 a4=  0.0;
%                 a3=  1.34349E-6*(1.0155)*bob;
%                 a2=  -1.13030E-3*(1.0155)*bob;
%                 a1=  3.35009E-1*(1.0155)*bob;
%                 a0=  -2.37155E+1*(1.0155)*bob;        
%                 A = [a7 a6 a5 a4 a3 a2 a1 a0];                
%                 MagnetType = 'quad';

 % SEXTUPOLES : on multiplie les coefficients par 2 car ils sont exprimes en B"L et non B"L/2
                % REPARTITION par intervalle de courant.
                % les intervalles de courant non utilises sont commentes.
          
%                % CAS DU SEXTUPOLE DONT LE COURANT EST COMPRIS ENTRE 0 et 60A
%                 Leff=LtotSX; 
%                 a7=  0.0;
%                 a6=  0.0;
%                 a5=  0.0;
%                 a4=  0.0;
%                 a3=  0.0;
%                 a2=  -5.7905804E-6;
%                 a1=   1.5465642E-1;
%                 a0=   2.4064497E-1;
%                 A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
%                 MagnetType = 'SEXT';
             case{'S1', 'S11'}
                % CAS DU SEXTUPOLE DONT LE COURANT EST COMPRIS ENTRE 60 et 100A
                % POLARITE +
                Leff=LtotSX; 
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  -2.8698688E-6;
                a1=   1.5442027E-1;
                a0=   2.4480159E-1;
                A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
                MagnetType = 'SEXT';
 
            case{'S3', 'S12'}
                % CAS DU SEXTUPOLE DONT LE COURANT EST COMPRIS ENTRE 100 et 150A
                % POLARITE -
                Leff=LtotSX; 
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  -4.8549355E-6*(-1);
                a1=   1.5483805E-1;
                a0=   2.2290378E-1*(-1);
                A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
                MagnetType = 'SEXT';

            case{'S10'}
                % CAS DU SEXTUPOLE DONT LE COURANT EST COMPRIS ENTRE 100 et 150A
                % POLARITE +
                Leff=LtotSX; 
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  -4.8549355E-6;
                a1=   1.5483805E-1;
                a0=   2.2290378E-1;
                A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
                MagnetType = 'SEXT';
                
            case{'S6'}
                % CAS DU SEXTUPOLE DONT LE COURANT EST COMPRIS ENTRE 150 et 200A
                % POLARITE +
                Leff=LtotSX; 
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  -6.1567262E-6;
                a1=   1.5520734E-1;
                a0=   1.9694261E-1;
                A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
                MagnetType = 'SEXT';

            case{'S2','S5','S9'}
                % CAS DU SEXTUPOLE DONT LE COURANT EST COMPRIS ENTRE 200 et 250A
                % POLARITE -
                Leff=LtotSX; 
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  -1.3881816E-5*(-1);
                a1=   1.5827135E-1;
                a0=  -1.0713717E-1*(-1);
                A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
                MagnetType = 'SEXT';
                
            case{'S4','S8'}
                % CAS DU SEXTUPOLE DONT LE COURANT EST COMPRIS ENTRE 200 et 250A
                % POLARITE +
                Leff=LtotSX; 
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  -1.3881816E-5;
                a1=   1.5827135E-1;
                a0=  -1.0713717E-1;
                A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
                MagnetType = 'SEXT';
                
            case{'S7'}
                % CAS DU SEXTUPOLE DONT LE COURANT EST COMPRIS ENTRE 250 et 300A
                % POLARITE -
                Leff=LtotSX; 
                a7=  0.0;
                a6=  0.0;
                a5=  0.0;
                a4=  0.0;
                a3=  0.0;
                a2=  -4.0540578E-5*(-1);
                a1=   1.7188604E-1;
                a0=  -1.8459591E+0*(-1);
                A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
                MagnetType = 'SEXT';

%                 % CAS DU SEXTUPOLE DONT LE COURANT EST COMPRIS ENTRE 300 et 350A
%                 Leff=LtotSX;
%                 a7=  0.0;
%                 a6=  0.0;
%                 a5=  0.0;
%                 a4=  0.0;
%                 a3=  -4.4295939E-6;
%                 a2=  -4.0682266E-3;
%                 a1=  -1.0997217E+0;
%                 a0=   1.2944731E+2;
%                 A = [a7 a6 a5 a4 a3 a2 a1 a0]*2;
%                 MagnetType = 'SEXT';
%                
                
            case 'QT'    % 160 mm dans sextupole
                % Etalonnage: moyenne sur les 32 sextupoles incluant un QT.
                % Efficacite = 3 G.m/A @ R=32mm; soit 93.83 G/A
                % Le signe du courant est donne par le DeviceServer (Tango)
                % Find the currAO.(ifam).Monitor.HW2PhysicsParams{1}(1,:) = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m(AO.(ifam).FamilyName );
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

             case 'SQ'   % 160 mm dans sextupole
                % Etalonnage: moyenne sur les 32 sextupoles incluant un QT.
                % Efficacitee = 3 G.m/A @ R=32mm; soit 93.83 G/A
                % Le signe du courant est donnee par le DeviceServer (Tango)
                % Find the currAO.(ifam).Monitor.HW2PhysicsParams{1}(1,:) = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m(AO.(ifam).FamilyName );
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
                
            case {'HCOR'}    % 16 cm horizontal corrector
                % Etalonnage: moyenne sur les 56 sextupoles incluant un CORH.
                % Efficacite = 8.143 G.m/A 
                % Le signe du courant est donnee par le DeviceServer (Tango)
                % Find the currAO.(ifam).Monitor.HW2PhysicsParams{1}(1,:) = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m(AO.(ifam).FamilyName );
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
                % Efficacite = 4.642 G.m/A 
                % Le signe du courant est donne par le DeviceServer (Tango)
                % Find the currAO.(ifam).Monitor.HW2PhysicsParams{1}(1,:) = magnetcoefficients_new_calib_new_modele_juin2009_nano_20_30_5m(AO.(ifam).FamilyName );
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
                error('MagnetCoreType %s is not unknown', MagnetCoreType);
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
    %% Booster    
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
                
                A = [a8 a7 a6 a5 a4 a3 a2 a1 a0]; %*getbrho(0.1);
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
                
                A = [a8 a7 a6 a5 a4 a3 a2 a1 a0]; %*getbrho(0.1);
                MagnetType = 'QUAD';

            case {'SF', 'SD'}   % 150 mm sextupole
                % Find the current from the given polynomial for B'Leff
                % HL [T/m] = 0.2 I [A] (deja integre)
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
                
                A = [a8 a7 a6 a5 a4 a3 a2 a1 a0];
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
                A = [a8 a7 a6 a5 a4 a3 a2 a1 a0];
                
            otherwise
                error('MagnetCoreType %s is not unknown', MagnetCoreType);
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
    %% LT2
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
                % le remanent est + fort que pour les quad Booster car les
                % courants max sont + eleves
                Leff=0.400; 
                
                a8 =  0.0;
                a7 =  0.0;
                a6 =  0.0;
                a5 =  0.0;
                a4 =  -1.3345e-10;
                a3 =  8.1746e-8;
                a2 =  -1.6548e-5;
                a1 =  2.197e-2;
                a0 =  2.73e-2;
                A = [a8 a7 a6 a5 a4 a3 a2 a1 a0]; 
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
                % Efficacite = 11.06 G.m/A 
                % Le signe du courant est donne par le DeviceServer (Tango)
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
                A = [a8 a7 a6 a5 a4 a3 a2 a1 a0];
                
            otherwise
                error('MagnetCoreType %s is not unknown', MagnetCoreType);
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
