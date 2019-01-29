function Amps = at2tls(Family, Field, k, DeviceList, Energy)
%AT2TLS - Converts simulator values to amperes
%  Amps = at2tls(Family, Field, K, DeviceList, Energy)
%
%  INPUTS
%  1. Family - Family name
%  2. Field - Sub-field (like 'Setpoint')
%  3. K - "K-value" (AT convention)
%          For dipole:      K = B / Brho
%          For quadrupole:  K = B'/ Brho
%          For sextupole:   K = B"/ Brho / 2
%  4. DeviceList - Device list (Amps and DeviceList must have the same number of rows)
%  5. Energy - Energy in GeV {Default: getenergy}
%              If Energy is a vector, each output column will correspond to that energy.
%              Energy can be anything getenergy accepts, like 'Model' or 'Online'.
%              (Note: If Energy is a vector, then Amps can only have 1 column)
%
%  OUTPUTS
%  1. Amps - Ampere (or real hardware units)
%
%  See also tls2at, hw2physics, physics2hw


if nargin < 3
    error('At least 3 input required');
end

if isempty(Field)
    Field = 'Setpoint';
end

if nargin < 4
    DeviceList = [];
end
if isempty(DeviceList)
    DeviceList = family2dev(Family);
end

if nargin < 5
    Energy = [];
end
if isempty(Energy)
    Energy = getenergy;
elseif ischar(Energy)
    Energy = getenergy(Energy);
end


if size(k,1) == 1 && length(DeviceList) > 1
    k = ones(size(DeviceList,1),1) * k;
elseif size(k,1) ~= size(DeviceList,1)
    error('Rows in K must equal rows in DeviceList or be a scalar');
end


if all(isnan(k))
    Amps = k;
    B = k;
    return
end


% Force Energy and K to have the same number of columns
if all(size(Energy) > 1)
    error('Energy can only be a scalar or vector');
end
Energy = Energy(:)';

if length(Energy) > 1
    if size(k,2) == size(Energy,2)
        % OK
    elseif size(k,2) > 1
        error('If Energy is a vector, then K can only have 1 column.');
    else
        % K has one column, expand to the size of Energy
        k = k * ones(1,size(Energy,2));
    end
else
    Energy = Energy * ones(1,size(k,2));
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setpoint and Monitor Fields %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if any(strcmpi(Field, {'Setpoint','Monitor'}))
    if strcmpi(Family, 'HCM')
        % HCM
        % Rad = BLeff / Brho
        Brho = getbrho(Energy);
        %BLeffPerI = 0.001;   % ????
        %Amps = k .* Brho / BLeffPerI;

        HCM_C=[
             1 1
             1 2
             1 3
             1 4
             1 5
             1 6
             1 7
             1 8
             1 9
             1 10
             1 11
             1 12];

         
        for i = 1:size(DeviceList,1)
            for j = 1:size(HCM_C,1)
                if all(DeviceList(i,:) == HCM_C(j,:))
                    BLeffPerI =  6.04484402e-4;  %  (Tesla-meters)
                    %                Leff = .5;
                    Amps(i,:) = k(i,:) .* Brho ./ BLeffPerI;
                end
            end
            
            if nargout >= 2
                Leff = 1;
                B(i,:) = BLeffPerI .* Amps(i,:) ./ Leff;
            end
        end
        return

    elseif strcmpi(Family, 'VCM')
        % VCM
        % Rad = BLeff / Brho
        Brho = getbrho(Energy);
        %BLeffPerI = 0.001;   % ????
        %Amps = k .* Brho / BLeffPerI;

        VCM_B=[
             1 1
             1 2
             1 3
             1 4
             1 5
             1 6
             1 7
             1 8
             1 9
             1 10
             1 11
             1 12];



        for i = 1:size(DeviceList,1)
            for j = 1:size(VCM_B,1)
                if all(DeviceList(i,:) == VCM_B(j,:))
                    BLeffPerI =  3.58180858e-4;  %  (Tesla-meters)
                    %                Leff = .5;
                    Amps(i,:) = k(i,:) .* Brho ./ BLeffPerI;
                end
            end
           

            if nargout >= 2
                Leff = 1;
                B(i,:) = BLeffPerI .* Amps(i,:) ./ Leff;
            end
        end
        return

        
    elseif strcmpi(Family, 'BD')
    
        A = [0 1200]; % Power supply (Amp) 952.752304
        B = [0 -2];
        C = [0 3];  
        A = A / 1000;
        Brho = getbrho(Energy);
        Amps = interp1(C,A,-k*Brho*1.6); % Unit = KAmps
        return
           
    elseif strcmpi(Family, 'QF')
        QF.PS = [0 250];
        QF.B1L = [0 5.64333]; 
        Brho = getbrho(Energy);
        BLeff = k * Brho * 0.3;
        Amps = interp1(QF.B1L,QF.PS,BLeff);
        return

    elseif strcmpi(Family, 'QD')
        QD.PS = [0 250];
        QD.B1L = [0 -5.64333]; 
        Brho = getbrho(Energy);
        BLeff = k * Brho * 0.3;
        Amps = interp1(QD.B1L,QD.PS,BLeff);
        return
        
    elseif strcmpi(Family, 'SFQ')
        SFQ.PS = [0 250];
        SFQ.B1L = [0 5.64333]; 
        Brho = getbrho(Energy);
        BLeff = k * Brho * 0.05;
        Amps = interp1(SFQ.B1L,SFQ.PS,BLeff);
        return

    elseif strcmpi(Family, 'SDQ')
        SDQ.PS = [0 250];
        SDQ.B1L = [0 -5.64333]; 
        Brho = getbrho(Energy);
        BLeff = k * Brho * 0.05;
        Amps = interp1(SDQ.B1L,SDQ.PS,BLeff);
        return
        
    else
        Amps = k;
    end
    return
end


% If you made it to here, I don't know how to convert it
Amps = k;
return
