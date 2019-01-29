function Gap = EPU56_HW(Angle,Index)
Energy = getenergy;
Brho = getbrho(Energy);
EPU56.Parameter = [17 18 20 23 28 35 50 70 110 160 230]; % Gap (or Phase)
EPU56.PeakField = [0.699150081 0.69915008 0.62564473 0.52931217 0.39986535 ...
                   0.26945240 0.11531039 0.03683968 0.00373228 0.000000001 ...
		   0.00000000];

% EPU56.Field = interp1(EPU56.Parameter,EPU56.PeakField,Gap,'linear');
% EPU56B0 = EPU56.Field;
% EPU56PB0 = EPU56B0/4;
% EPU56NB0 = -EPU56B0*3/4;
% EPU56K = EPU56B0/Brho;
% EPU56PK = EPU56PB0/Brho;
% EPU56NK = EPU56NB0/Brho;
% EPU56P = [0.309*EPU56K*0.0056 0.809*EPU56K*0.0056 EPU56K*0.0028];
% EPU56PP = [0.309*EPU56PK*0.0056 0.809*EPU56PK*0.0056 EPU56PK*0.0028];
% EPU56NP = [0.309*EPU56NK*0.0056 0.809*EPU56NK*0.0056 EPU56NK*0.0028];
% EPU56N = -EPU56P;

X = family2atindex('EPU56');

EPU56PEA = [ X(1) X(6) X(793) X(798) ];
EPU56PEB = [ X(2) X(5) X(794) X(797) ];
EPU56PEC = [ X(3) X(4) X(795) X(796) ];
EPU56NEA = [ X(7) X(12) X(787) X(792) ];
EPU56NEB = [ X(8) X(11) X(788) X(791) ];
EPU56NEC = [ X(9) X(10) X(789) X(790) ];
EPU56P1A = [ X(13) X(18) X(781) X(786) ];
EPU56P1B = [ X(14) X(17) X(782) X(785) ];
EPU56P1C = [ X(15) X(16) X(783) X(784) ];
EPU56N1A = [ X(19) X(24) X(775) X(780) ];
EPU56N1B = [ X(20) X(23) X(776) X(779) ];
EPU56N1C = [ X(21) X(22) X(777) X(778) ];
EPU56P2A = [ X(25) X(30) X(769) X(774) ];
EPU56P2B = [ X(26) X(29) X(770) X(773) ];
EPU56P2C = [ X(27) X(28) X(771) X(772) ];

for k = 1:62
    EPU56NA(k) = struct('A', X(31)+12*(k-1),'B', X(36)+12*(k-1));
    EPU56NB(k) = struct('A', X(32)+12*(k-1),'B', X(35)+12*(k-1));
    EPU56NC(k) = struct('A', X(33)+12*(k-1),'B', X(34)+12*(k-1));
end

for k = 1:61
    EPU56PA(k) = struct('A', X(37)+12*(k-1),'B', X(42)+12*(k-1));
    EPU56PB(k) = struct('A', X(38)+12*(k-1),'B', X(41)+12*(k-1));
    EPU56PC(k) = struct('A', X(39)+12*(k-1),'B', X(40)+12*(k-1));
end

for i = 1:62
    if i < 5
        if Index == EPU56PEA(i) 
            Angle = Angle / 0.309 / 0.0056 * Brho * 4;
            break;
        elseif Index == EPU56PEB(i)
            Angle = Angle / 0.809 / 0.0056 * Brho * 4;
            break;
        elseif Index == EPU56PEC(i)
            Angle = Angle / 0.0028 * Brho * 4;
            break;
            
        elseif Index == EPU56NEA(i)
            Angle = Angle / 0.309 / 0.0056 * Brho * 4 / (-3);
            break;
        elseif Index == EPU56NEB(i)
            Angle = Angle / 0.809 / 0.0056 * Brho * 4 / (-3);
            break;
        elseif Index == EPU56NEC(i)
            Angle = Angle / 0.0028 * Brho * 4 / (-3);
            break;
            
        elseif Index == EPU56P1A(i)
            Angle = Angle / 0.309 / 0.0056 * Brho;
            break;
        elseif Index == EPU56P1B(i)
            Angle = Angle / 0.809 / 0.0056 * Brho;
            break;
        elseif Index == EPU56P1C(i)
            Angle = Angle / 0.0028 * Brho;
            break;
            
        elseif Index == EPU56N1A(i)
            Angle = -Angle / 0.309 / 0.0056 * Brho;
            break;
        elseif Index == EPU56N1B(i)
            Angle = -Angle / 0.809 / 0.0056 * Brho;
            break;
        elseif Index == EPU56N1C(i)
            Angle = -Angle / 0.0028 * Brho;
            break;
            
        elseif Index == EPU56P2A(i)
            Angle = Angle / 0.309 / 0.0056 * Brho;
            break;
        elseif Index == EPU56P2B(i)
            Angle = Angle / 0.809 / 0.0056 * Brho;
            break;
        elseif Index == EPU56P2C(i)
            Angle = Angle / 0.0028 * Brho;
            break;
      
        end
    end
     
    if (Index == EPU56NA(i).A || Index == EPU56NA(i).B)
        Angle = -Angle / 0.309 / 0.0056 * Brho;
        break;
    elseif (Index == EPU56NB(i).A || Index == EPU56NB(i).B)
        Angle = -Angle / 0.809 / 0.0056 * Brho;
        break;
    elseif (Index == EPU56NC(i).A || Index == EPU56NC(i).B)
        Angle = -Angle / 0.0028 * Brho;
        break;
    end
    
    if i < 62
        if (Index == EPU56PA(i).A || Index == EPU56PA(i).B)
            Angle = Angle / 0.309 / 0.0056 * Brho;
            break;
        elseif (Index == EPU56PB(i).A || Index == EPU56PB(i).B)
            Angle = Angle / 0.809 / 0.0056 * Brho;
            break;
        elseif (Index == EPU56PC(i).A || Index == EPU56PC(i).B)
            Angle = Angle / 0.0028 * Brho;
            break;
        end
    end

             
end
Gap = interp1(EPU56.PeakField,EPU56.Parameter,Angle,'linear');
return


    