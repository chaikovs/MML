function k = tls2at(Family, Field, Amps, DeviceList, Energy)
%TLS2AT - Converts amperes to simulator values
%  K = tls2at(Family, Field, Amps, DeviceList, Energy)
%
%  INPUTS
%  1. Family - Family name
%  2. Field - Sub-field (like 'Setpoint')
%  3. Amps - Ampere
%  4. DeviceList - Device list (Amps and DeviceList must have the same number of rows)
%  5. Energy - Energy in GeV {Default: getenergy}
%              If Energy is a vector, each output column will correspond to that energy.
%              Energy can be anything getenergy accepts, like 'Model' or 'Online'.
%              (Note: If Energy is a vector, then Amps can only have 1 column)
%
%  OUTPUTS
%  1. K - "K-value" (AT convention)
%     For dipole:      K = B / Brho
%     For quadrupole:  K = B'/ Brho
%     For sextupole:   K = B"/ Brho / 2
%
%  See also at2tls, hw2physics, physics2hw


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


if size(Amps,1) == 1 && length(DeviceList) > 1
    Amps = ones(size(DeviceList,1),1) * Amps;
elseif size(Amps,1) ~= size(DeviceList,1)
    error('Rows in Amps must equal rows in DeviceList or be a scalar');
end


if all(isnan(Amps))
    k = Amps;
    return
end


% Force Energy and Amps to have the same number of columns
if all(size(Energy) > 1)
    error('Energy can only be a scalar or vector');
end
Energy = Energy(:)';

if length(Energy) > 1
    if size(Amps,2) == size(Energy,2)
        % OK
    elseif size(Amps,2) > 1
        error('If Energy is a vector, then Amps can only have 1 column.');
    else
        % Amps has one column, expand to the size of Energy
        Amps = Amps * ones(1,size(Energy,2));
    end
else
    Energy = Energy * ones(1,size(Amps,2));
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setpoint and Monitor Fields %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if any(strcmpi(Field, {'Setpoint','Monitor'}))
    if strcmpi(Family, 'HCM')
        % HCM
        % Rad = BLeff / Brho
        Brho = getbrho(Energy);
        % BLeffPerI = 0.001;   % ????
        % k = BLeffPerI .* Amps ./ Brho;

        HCMlist=[
             1 1
             1 2
             1 4
             1 5
             1 6
             ];
         
        THCMlist=[
             1 3
             1 7
             ];


        for i = 1:size(DeviceList,1)
            for j = 1:size(HCMlist,1)
                if all(DeviceList(i,:) == HCMlist(j,:))
                    BLeffPerI =  8.20433636e-4;  %  (Tesla-meters)
                    k(i,:) = BLeffPerI .* Amps(i,:) ./ Brho;
                end
            end
            for j = 1:size(THCMlist,1)
                if all(DeviceList(i,:) == THCMlist(j,:))
                    BLeffPerI =  2.074500272e-3;  %  (Tesla-meters)
                    k(i,:) = BLeffPerI .* Amps(i,:) ./ Brho;
                end
            end
         
        end
        return


    elseif strcmpi(Family, 'VCM')
        % VCM
        % Rad = BLeff / Brho
        Brho = getbrho(Energy);
        %BLeffPerI = 0.001;   % ????
        %k = BLeffPerI .* Amps ./ Brho;

        VCMlist=[
             1 1
             1 2
             1 3
             1 4
             1 5
             1 8
             1 9
             ];
         TVCMlist=[
             1 6
             1 7
             ];
         
        for i = 1:size(DeviceList,1)
            for j = 1:size(VCMlist,1)
                if all(DeviceList(i,:) == VCMlist(j,:))
                    BLeffPerI =  -8.20433636e-4;  %  (Tesla-meters)
                    k(i,:) = BLeffPerI .* Amps(i,:) ./ Brho;
                end
            end
            for j = 1:size(TVCMlist,1)
                if all(DeviceList(i,:) == TVCMlist(j,:))
                    BLeffPerI =  -3.172892661e-3;  %  (Tesla-meters)
                    k(i,:) = BLeffPerI .* Amps(i,:) ./ Brho;
                end
            end
        end
        return

    elseif strcmpi(Family, 'BM')
    
        A = [0 1200]; % Power supply (Amp) 952.752304
        B = [0 -2];
        C = [0 3];    
%         A = A / 1000;
        Brho = getbrho(Energy);
        BLeff = interp1(A,C,Amps);
        k = -BLeff  / Brho / 1.0;
        return
        
        
        
    elseif strcmpi(Family, 'QM')
        QM.PS = [0 80];
        QM.B1L = [0 5.3846/50*80]; 
        Brho = getbrho(Energy);
        BLeff = interp1(QM.PS,QM.B1L,Amps);
        QMlist=[
             1 1
             1 3
             1 5
             1 7
             1 9
             1 11
             1 13
             ];
        for i = 1:size(DeviceList,1)
            k(i,:) = BLeff(i,:)  / Brho / 0.21;
            for j = 1:size(QMlist,1)
                if all(DeviceList(i,:) == QMlist(j,:))
                    k(i,:) = -BLeff(i,:)  / Brho / 0.21;
                end
            end
            if all(DeviceList(i,:) == [1 14])
                QM.PS = [0 15.012 24.978 38.037 50.006 62.580 74.9895 85.0000 92.96 99.95 100];
                QM.B1L = [0 0.85402 1.4146 2.1551 2.8299 3.5293 4.1863 4.6463 4.9596 5.2005 5.202223176];
                BLeff(i,:) = interp1(QM.PS,QM.B1L,Amps(i,:));
                k(i,:) = BLeff(i,:)  / Brho / 0.21;
            end
            if all(DeviceList(i,:) == [1 15])
                QM.PS = [0 15.012 24.978 38.037 50.006 62.580 74.9895 85.0000 92.96 99.95 100];
                QM.B1L = [0 0.85402 1.4146 2.1551 2.8299 3.5293 4.1863 4.6463 4.9596 5.2005 5.202223176];
                BLeff(i,:) = interp1(QM.PS,QM.B1L,Amps(i,:));
                k(i,:) = -BLeff(i,:)  / Brho / 0.21;
            end
            if all(DeviceList(i,:) == [1 16])
                QM.PS = [0 100];
                QM.B1L = [0 10.7692];
                BLeff(i,:) = interp1(QM.PS,QM.B1L,Amps(i,:));
                k(i,:) = BLeff(i,:)  / Brho / 0.21;
            end
        end
        
        return
       
    elseif strcmpi(Family, 'SQ')
        SQ.PS = [0 50];
        SQ.B1L = [0 5.3846]; 
        Brho = getbrho(Energy);
        BLeff = interp1(SQ.PS,SQ.B1L,Amps);
        k = BLeff  / Brho / 0.1;
        return
        
    else   
        k = Amps;
    end
    return
end


% If you made it to here, I don't know how to convert it
k = Amps;
return

