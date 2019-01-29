function Gap = U9_HW(Angle,Index)
Energy = getenergy;
Brho = getbrho(Energy);
U9.Parameter = [18 19 20 21 22 24 26 28 30 32 34 36 38 42 46 50 54 60 70 ...
                80 100 220 230]; % Gap
U9.PeakField = [1.28021151 1.280211500 1.21708700 1.15863990 1.10385940 ...
                1.00499390 0.91819627 0.84152641 0.77290514 0.71158841 ...
		0.65633119 0.60639290 0.56080759 0.48108067 0.41400438 ...
		0.35693640 0.30817691 0.24765390 0.17248560 0.12025689 ...
		0.05841128 0.00077322 0.00000000];

% U9.Field = interp1(U9.Parameter,U9.PeakField,Gap,'linear');
% % [NE P1 N2 PN NN P2 N1 PE] = [-2147/12802 8855/12802 -125/128 1 -1 125/128 -8855/12802 2147/12802]
% U9B0 = U9.Field;
% U9PEB0 = U9B0*(2147/12802); % U9NEB0 = -U9PEB0;
% U9P1B0 = U9B0*(8855/12802); % U9N1B0 = -U9P1B0;
% U9P2B0 = U9B0*(125/128); % U9N2B0 = -U9P2B0;
% U9K = U9B0/Brho;
% U9PEK = U9PEB0/Brho;
% U9P1K = U9P1B0/Brho;
% U9P2K = U9P2B0/Brho;
% U9P = [0.309*U9K*0.009 0.809*U9K*0.009 U9K*0.0045];
% U9PEP = [0.309*U9PEK*0.009 0.809*U9PEK*0.009 U9PEK*0.0045];
% U9P1P = [0.309*U9P1K*0.009 0.809*U9P1K*0.009 U9P1K*0.0045];
% U9P2P = [0.309*U9P2K*0.009 0.809*U9P2K*0.009 U9P2K*0.0045];
% U9N = -U9P;
% U9NEP = -U9PEP;
% U9N1P = -U9P1P;
% U9N2P = -U9P2P;

X = family2atindex('U9');
U9PEA = [ X(595) X(600) ];
U9PEB = [ X(596) X(599) ];
U9PEC = [ X(597) X(598) ];
U9NEA = [ X(1) X(6) ];
U9NEB = [ X(2) X(5) ];
U9NEC = [ X(3) X(4) ];
U9P1A = [ X(7) X(12) ];
U9P1B = [ X(8) X(11) ];
U9P1C = [ X(9) X(10) ];
U9N1A = [ X(589) X(594) ];
U9N1B = [ X(590) X(593) ];
U9N1C = [ X(591) X(592) ];
U9P2A = [ X(583) X(588) ];
U9P2B = [ X(584) X(587) ];
U9P2C = [ X(585) X(586) ];
U9N2A = [ X(13) X(18) ];
U9N2B = [ X(14) X(17) ];
U9N2C = [ X(15) X(16) ];

for k = 1:47
    U9PNA(k) = struct('A', X(19)+12*(k-1),'B', X(24)+12*(k-1));
    U9PNB(k) = struct('A', X(20)+12*(k-1),'B', X(23)+12*(k-1));
    U9PNC(k) = struct('A', X(21)+12*(k-1),'B', X(22)+12*(k-1));
    U9NNA(k) = struct('A', X(25)+12*(k-1),'B', X(30)+12*(k-1));
    U9NNB(k) = struct('A', X(26)+12*(k-1),'B', X(29)+12*(k-1));
    U9NNC(k) = struct('A', X(27)+12*(k-1),'B', X(28)+12*(k-1));
end


for i = 1:47
    if i < 3
        if Index == U9PEA(i) 
            Angle = Angle / 0.309 / 0.009 * Brho / (2147/12802);
            break;
        elseif Index == U9PEB(i)
            Angle = Angle / 0.809 / 0.009 * Brho / (2147/12802);
            break;
        elseif Index == U9PEC(i)
            Angle = Angle / 0.0045 * Brho / (2147/12802);
            break;
            
        elseif Index == U9NEA(i)
            Angle = -Angle / 0.309 / 0.009 * Brho / (2147/12802);
            break;
        elseif Index == U9NEB(i)
            Angle = -Angle / 0.809 / 0.009 * Brho / (2147/12802);
            break;
        elseif Index == U9NEC(i)
            Angle = -Angle / 0.0045 * Brho / (2147/12802);
            break;
            
        elseif Index == U9P1A(i)
            Angle = Angle / 0.309 / 0.009 * Brho / (8855/12802);
            break;
        elseif Index == U9P1B(i)
            Angle = Angle / 0.809 / 0.009 * Brho / (8855/12802);
            break;
        elseif Index == U9P1C(i)
            Angle = Angle / 0.0045 * Brho / (8855/12802);
            break;
            
        elseif Index == U9N1A(i)
            Angle = -Angle / 0.309 / 0.009 * Brho / (8855/12802);
            break;
        elseif Index == U9N1B(i)
            Angle = -Angle / 0.809 / 0.009 * Brho / (8855/12802);
            break;
        elseif Index == U9N1C(i)
            Angle = -Angle / 0.0045 * Brho / (8855/12802);
            break;
            
        elseif Index == U9P2A(i)
            Angle = Angle / 0.309 / 0.009 * Brho / (125/128);
            break;
        elseif Index == U9P2B(i)
            Angle = Angle / 0.809 / 0.009 * Brho / (125/128);
            break;
        elseif Index == U9P2C(i)
            Angle = Angle / 0.0045 * Brho / (125/128);
            break;
            
        elseif Index == U9N2A(i)
            Angle = -Angle / 0.309 / 0.009 * Brho / (125/128);
            break;
        elseif Index == U9N2B(i)
            Angle = -Angle / 0.809 / 0.009 * Brho / (125/128);
            break;
        elseif Index == U9N2C(i)
            Angle = -Angle / 0.0045 * Brho / (125/128);
            break;
            
        end
    end
     
    if (Index == U9PNA(i).A || Index == U9PNA(i).B)
        Angle = Angle / 0.309 / 0.009 * Brho;
        break;
    elseif (Index == U9PNB(i).A || Index == U9PNB(i).B)
        Angle = Angle / 0.809 / 0.009 * Brho;
        break;
    elseif (Index == U9PNC(i).A || Index == U9PNC(i).B)
        Angle = Angle / 0.0045 * Brho;
        break;
        
    elseif (Index == U9NNA(i).A || Index == U9NNA(i).B)
        Angle = -Angle / 0.309 / 0.009 * Brho;
        break;
    elseif (Index == U9NNB(i).A || Index == U9NNB(i).B)
        Angle = -Angle / 0.809 / 0.009 * Brho;
        break;
    elseif (Index == U9NNC(i).A || Index == U9NNC(i).B)
        Angle = -Angle / 0.0045 * Brho;
        break;
    end

             
end
Gap = interp1(U9.PeakField,U9.Parameter,Angle,'linear');
return


    