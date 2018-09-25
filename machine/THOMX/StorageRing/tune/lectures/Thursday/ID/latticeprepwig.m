global THERING GLOBVAL;

sp3v82


% GLOBVAL.E0 = 3e9;
% cavityoff;
tune = tunechrom(THERING,0)

ATI = atindex(THERING); % Reindex

    
%Insert BL11 with magic fingers
BL11i = ATI.AP(13);
BL11.FamName        = 'BL11';  % add check for identical family names
BL11.Length		= 2.2;
BL11.Nslice    	= 3;
BL11.PassMethod 	= 'WigTablePass2';
load('BL11table');
BL11.xtable = x;
BL11.ytable = y;
BL11.xkick = xkick;
BL11.ykick = ykick;
MF11mult

THERING = [THERING(1:BL11i-1),THERING(BL11i),THERING(BL11i),THERING(BL11i:end)];
THERING{BL11i} = MF11;
THERING{BL11i+1} = BL11;
THERING{BL11i+2} = MF11;
% Reduce length of upstream and downstream drifts to accomodate BL11
DC11.FamName = 'DC11';
DC11.Length = THERING{ATI.DC1A(1)}.Length-BL11.Length/2;
DC11.PassMethod = 'DriftPass';
THERING{BL11i-1} = DC11;
THERING{BL11i+3} = DC11;
ATI = atindex(THERING); % Reindex

tune = tunechrom(THERING,0)

ATI = atindex(THERING); % Reindex

save latticeprepwig THERING