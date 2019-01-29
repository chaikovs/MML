function Angle = SW6(Amps,Index)
Energy = getenergy;
Brho = getbrho(Energy);
SW6.Parameter = [0 10 20 30 40 50 60 70 80 90 105 125 145 165 185 205 225 ...
                 245 265 285.05]; % Current
SW6.PeakField = [0 0.448 0.699 0.848 0.976 1.091 1.202 1.303 1.402 1.499 ...
                 1.64 1.823 2.002 2.179 2.355 2.529 2.702 2.875 3.046 3.216];

SW6.Field = interp1(SW6.Parameter,SW6.PeakField,Amps,'linear');
SW6B0 = SW6.Field;
SW6EB0 = SW6B0*(57/448);
SW62B0 = SW6B0*(270/448);
SW6K = SW6B0/Brho;
SW6EK = SW6EB0/Brho;
SW62K = SW62B0/Brho;
SW6P = [0.309*SW6K*0.006 0.809*SW6K*0.006 SW6K*0.003];
SW6EP = [0.309*SW6EK*0.006 0.809*SW6EK*0.006 SW6EK*0.003];
SW62P = [0.309*SW62K*0.006 0.809*SW62K*0.006 SW62K*0.003];
SW6N = -SW6P;
SW6EN = -SW6EP;
SW62N = -SW62P;

X = family2atindex('SW6');
SW6PEA = [ X(1) X(6) ];
SW6PEB = [ X(2) X(5) ];
SW6PEC = [ X(3) X(4) ];
SW6NEA = [ X(187) X(192) ];
SW6NEB = [ X(188) X(191) ];
SW6NEC = [ X(189) X(190) ];
SW6P2A = [ X(181) X(186) ];
SW6P2B = [ X(182) X(185) ];
SW6P2C = [ X(183) X(184) ];
SW6N2A = [ X(7) X(12) ];
SW6N2B = [ X(8) X(11) ];
SW6N2C = [ X(9) X(10) ];
for k = 1:14
    SW6PA(k) = struct('A', X(13)+12*(k-1),'B', X(18)+12*(k-1));
    SW6PB(k) = struct('A', X(14)+12*(k-1),'B', X(17)+12*(k-1));
    SW6PC(k) = struct('A', X(15)+12*(k-1),'B', X(16)+12*(k-1));
    SW6NA(k) = struct('A', X(19)+12*(k-1),'B', X(24)+12*(k-1));
    SW6NB(k) = struct('A', X(20)+12*(k-1),'B', X(23)+12*(k-1));
    SW6NC(k) = struct('A', X(21)+12*(k-1),'B', X(22)+12*(k-1));
end


for i = 1:14
    if i < 3
        if Index == SW6PEA(i) 
            Angle = SW6EP(1);
            break;
        elseif Index == SW6PEB(i)
            Angle = SW6EP(2);
            break;
        elseif Index == SW6PEC(i)
            Angle = SW6EP(3);
            break;
            
        elseif Index == SW6NEA(i)
            Angle = SW6EN(1);
            break;
        elseif Index == SW6NEB(i)
            Angle = SW6EN(2);
            break;
        elseif Index == SW6NEC(i)
            Angle = SW6EN(3);
            break;
            
        elseif Index == SW6P2A(i)
            Angle = SW62P(1);
            break;
        elseif Index == SW6P2B(i)
            Angle = SW62P(2);
            break;
        elseif Index == SW6P2C(i)
            Angle = SW62P(3);
            break;
            
        elseif Index == SW6N2A(i)
            Angle = SW62N(1);
            break;
        elseif Index == SW6N2B(i)
            Angle = SW62N(2);
            break;
        elseif Index == SW6N2C(i)
            Angle = SW62N(3);
            break;
        end
    end
     
    if (Index == SW6PA(i).A || Index == SW6PA(i).B)
        Angle = SW6P(1);
        break;
    elseif (Index == SW6PB(i).A || Index == SW6PB(i).B)
        Angle = SW6P(2);
        break;
    elseif (Index == SW6PC(i).A || Index == SW6PC(i).B)
        Angle = SW6P(3);
        break;
        
    elseif (Index == SW6NA(i).A || Index == SW6NA(i).B)
        Angle = SW6N(1);
        break;
    elseif (Index == SW6NB(i).A || Index == SW6NB(i).B)
        Angle = SW6N(2);
        break;
    elseif (Index == SW6NC(i).A || Index == SW6NC(i).B)
        Angle = SW6N(3);
        break;
    end

             
end
return


    