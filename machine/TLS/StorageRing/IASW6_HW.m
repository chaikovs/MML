function Amps = IASW6_HW(Angle,Index)
Energy = getenergy;
Brho = getbrho(Energy);
IASW6.Parameter = [0 10.0406 11.9611 12.7613 13.7216 14.8418 15.9621 16.4422 ...
                   17.8826 18.6828 19.483 20.4432 49.8906 100.463 200.328 ...
		   250.412 262.904 276.187 288.83]; % Current
IASW6.PeakField = [0 0.5013 0.5577 0.5768 0.5998 0.6234 0.6461 0.6553 0.6812 ...
                   0.695 0.708 0.7214 1.0981 1.6089 2.5348 2.9927 3.1 3.22 ...
		   3.3397];

% IASW6.Field = interp1(IASW6.Parameter,IASW6.PeakField,Amps,'linear');
% IASW6B0 = IASW6.Field;
% IASW6EB0 = IASW6B0*(125325/501300);
% IASW62B0 = IASW6B0*(375975/501300);
% IASW6K = IASW6B0/Brho;
% IASW6EK = IASW6EB0/Brho;
% IASW62K = IASW62B0/Brho;
% IASW6P = [0.309*IASW6K*0.0061 0.809*IASW6K*0.0061 IASW6K*0.00305];
% IASW6EP = [0.309*IASW6EK*0.0061 0.809*IASW6EK*0.0061 IASW6EK*0.00305];
% IASW62P = [0.309*IASW62K*0.0061 0.809*IASW62K*0.0061 IASW62K*0.00305];
% IASW6N = -IASW6P;
% IASW6EN = -IASW6EP;
% IASW62N = -IASW62P;

X = family2atindex('IASW6');
IASW6PEA = [ X(1) X(6) ];
IASW6PEB = [ X(2) X(5) ];
IASW6PEC = [ X(3) X(4) ];
IASW6NEA = [ X(91) X(96) ];
IASW6NEB = [ X(92) X(95) ];
IASW6NEC = [ X(93) X(94) ];
IASW6P2A = [ X(85) X(90) ];
IASW6P2B = [ X(86) X(89) ];
IASW6P2C = [ X(87) X(88) ];
IASW6N2A = [ X(7) X(12) ];
IASW6N2B = [ X(8) X(11) ];
IASW6N2C = [ X(9) X(10) ];
IASW6PA  = [ X(13) X(18) X(25) X(30) X(37) X(42) X(49) X(54) X(61) X(66) X(73) X(78) ];
IASW6PB  = [ X(14) X(17) X(26) X(29) X(38) X(41) X(50) X(53) X(62) X(65) X(74) X(77) ];
IASW6PC  = [ X(15) X(16) X(27) X(28) X(39) X(40) X(51) X(52) X(63) X(64) X(75) X(76) ];
IASW6NA  = [ X(19) X(24) X(31) X(36) X(43) X(48) X(55) X(60) X(67) X(72) X(79) X(84) ];
IASW6NB  = [ X(20) X(23) X(32) X(35) X(44) X(47) X(56) X(59) X(68) X(71) X(80) X(83) ];
IASW6NC  = [ X(21) X(22) X(33) X(34) X(45) X(46) X(57) X(58) X(69) X(70) X(81) X(82) ];


for i = 1:12
    j = rem(i,2) + 1;
    
    if Index == IASW6PEA(j)
         Angle = Angle / 0.309 /0.0061 * Brho / (125325/501300);
         break;
     elseif Index == IASW6PEB(j)
         Angle = Angle / 0.809 /0.0061 * Brho / (125325/501300);
         break;
     elseif Index == IASW6PEC(j)
         Angle = Angle / 0.00305 * Brho / (125325/501300);
         break;
         
     elseif Index == IASW6NEA(j)
         Angle = -Angle / 0.309 /0.0061 * Brho / (125325/501300);
         break;
     elseif Index == IASW6NEB(j)
         Angle = -Angle / 0.809 /0.0061 * Brho / (125325/501300);
         break;
     elseif Index == IASW6NEC(j)
         Angle = -Angle / 0.00305 * Brho / (125325/501300);
         break;
         
     elseif Index == IASW6P2A(j)
         Angle = Angle / 0.309 /0.0061 * Brho / (375975/501300);
         break;
     elseif Index == IASW6P2B(j)
         Angle = Angle / 0.809 /0.0061 * Brho / (375975/501300);
         break;
     elseif Index == IASW6P2C(j)
         Angle = Angle / 0.00305 * Brho / (375975/501300);
         break;
         
     elseif Index == IASW6N2A(j)
         Angle = -Angle / 0.309 /0.0061 * Brho / (375975/501300);
         break;
     elseif Index == IASW6N2B(j)
         Angle = -Angle / 0.809 /0.0061 * Brho / (375975/501300);
         break;
     elseif Index == IASW6N2C(j)
         Angle = -Angle / 0.00305 * Brho / (375975/501300);
         break;
    
     elseif Index == IASW6PA(i)
         Angle = Angle / 0.309 /0.0061 * Brho;
         break;
     elseif Index == IASW6PB(i)
         Angle = Angle / 0.809 /0.0061 * Brho;
         break;
     elseif Index == IASW6PC(i)
         Angle = Angle / 0.00305 * Brho;
         break;

     elseif Index == IASW6NA(i)
         Angle = -Angle / 0.309 /0.0061 * Brho;
         break;
     elseif Index == IASW6NB(i)
         Angle = -Angle / 0.809 /0.0061 * Brho;
         break;
     elseif Index == IASW6NC(i)
         Angle = -Angle / 0.00305 * Brho;
         break;
         
    end    
end
Amps = interp1(IASW6.PeakField,IASW6.Parameter,Angle,'linear');
return


    