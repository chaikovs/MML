load locoin.mat  

quadscales = FitParameters(1).Values(1:end-14)./FitParameters(end).Values(1:end-14);
figure
plot(quadscales)
title('Quadrupole scaling factors for correction')

pause

QFscale(1:2) = quadscales(1:2);%FitParameters(1).Values(1:2)./FitParameters(le).Values(1:2);
QFscale(3:6) = quadscales(3);%FitParameters(1).Values(3)/FitParameters(le).Values(3);
QFscale(7:28) = quadscales(4:25);%FitParameters(1).Values(4:25)./FitParameters(le).Values(4:25); 
QDscale(1:2) = quadscales(26:27);%FitParameters(1).Values(26:27)./FitParameters(le).Values(26:27);
QDscale(3:6) = quadscales(28);%FitParameters(1).Values(28)/FitParameters(le).Values(28);
QDscale(7:28) = quadscales(29:50);%FitParameters(1).Values(29:50)./FitParameters(le).Values(29:50);
QFCscale = quadscales(51);%FitParameters(1).Values(51)/FitParameters(le).Values(51);
QDXscale = quadscales([52 53 54 52]);%FitParameters(1).Values([52 53 54 52])'./FitParameters(le).Values([52 53 54 52])';
QFXscale = quadscales([55 56 57 55]);%FitParameters(1).Values([55 56 57 55])'./FitParameters(le).Values([55 56 57 55])';
QDYscale = quadscales([58 59 60 58]);%FitParameters(1).Values([58 59 60 58])'./FitParameters(le).Values([58 59 60 58])';
QFYscale = quadscales([61 62 63 61]);%FitParameters(1).Values([61 62 63 61])'./FitParameters(le).Values([61 62 63 61])';
QDZscale = quadscales([64 65 66 64]);%FitParameters(1).Values([64 65 66 64])'./FitParameters(le).Values([64 65 66 64])';
QFZscale = quadscales([67 68 69 67]);%FitParameters(1).Values([67 68 69 67])'./FitParameters(le).Values([67 68 69 67])';
Q9Sscale = quadscales(70:72);%FitParameters(1).Values(70:72)'./FitParameters(le).Values(70:72)';

QFold = getsp('QF');
QDold = getsp('QD');
QFCold = getsp('QFC');
QDXold = getsp('QDX');
QFXold = getsp('QFX');
QDYold = getsp('QDY');
QFYold = getsp('QFY');
QDZold = getsp('QDZ');
QFZold = getsp('QFZ');
Q9Sold = getsp('Q9S');

QFnew = QFscale'.*getsp('QF');
QDnew = QDscale'.*getsp('QD');
QFCnew = QFCscale*getsp('QFC');
QDXnew = QDXscale.*getsp('QDX');
QFXnew = QFXscale.*getsp('QFX');
QDYnew = QDYscale.*getsp('QDY');
QFYnew = QFYscale.*getsp('QFY');
QDZnew = QDZscale.*getsp('QDZ');
QFZnew = QFZscale.*getsp('QFZ');
Q9Snew = Q9Sscale.*getsp('Q9S');

for loop=1:10
    setsp('QF',QFold+loop*(QFnew-QFold)/10,[],0);
    setsp('QD',QDold+loop*(QDnew-QDold)/10,[],0);
    setsp('QFC',QFCold+loop*(QFCnew-QFCold)/10,[],0);
    setsp('QDX',QDXold+loop*(QDXnew-QDXold)/10,[],0);
    setsp('QFX',QFXold+loop*(QFXnew-QFXold)/10,[],0);
    setsp('QDY',QDYold+loop*(QDYnew-QDYold)/10,[],0);
    setsp('QFY',QFYold+loop*(QFYnew-QFYold)/10,[],0);
    setsp('QDZ',QDZold+loop*(QDZnew-QDZold)/10,[],0);
    setsp('QFZ',QFZold+loop*(QFZnew-QFZold)/10,[],0);    
    setsp('Q9S',Q9Sold+loop*(Q9Snew-Q9Sold)/10,[],0);    
    pause(1);
end

setsp('QF',QFnew,[],0);
setsp('QD',QDnew,[],0);
setsp('QFC',QFCnew,[],0);
setsp('QDX',QDXnew,[],0);
setsp('QFX',QFXnew,[],0);
setsp('QDY',QDYnew,[],0);
setsp('QFY',QFYnew,[],0);
setsp('QDZ',QDZnew,[],0);
setsp('QFZ',QFZnew,[],0);
setsp('Q9S',Q9Snew,[],0);

%% Correct coupling

SkewK_LOCO = -FitParameters(end).Values(73:end);

% According the Jacky's fit (Q:\Groups\Accel\Controls\matlab\spear3data\Loco\2004-01-07\Jacky) 
% K/I = 0.00245246 1/(m^2*A)
%current = SkewK_LOCO/0.00245246;

figure
plot(SkewK_LOCO)
title('Skew quadrupole setpoint changes')

pause 

SQList = [     1     4
     2     3
     3     3
     5     3
     7     2
     8     2
     9     1
    10     4
    11     3
    12     3
    14     2
    16     2
    17     2
    18     1];
%     3     3 ;...  % 2008-03-10 removed skew quadrupole under kicker bump
%     from the list.
stepsp('SkewQuad',SkewK_LOCO,SQList)
