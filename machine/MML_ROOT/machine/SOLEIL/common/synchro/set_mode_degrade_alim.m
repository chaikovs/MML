function set_mode_degrade_alim
% set 66 MeV

E1=110;
E2=110;

%save start value
% %to comment after
% HCOR=getsp('HCOR');
% VCOR=getsp('VCOR');
% temp=tango_read_attribute2('BOO-C01/EP/AL_K.Inj','voltage');kicker=temp.value(2);
% temp=tango_read_attribute2('BOO-C22/EP/AL_SEP_P.Inj','voltage');septum=temp.value(2);
% temp=tango_read_attribute('LT1/AE/CV.2', 'current');cv2=temp.value(2);
% temp=tango_read_attribute('LT1/AE/CV.3', 'current');cv3=temp.value(2);
% save data_110MeV.mat HCOR VCOR kicker septum cv2 cv3
% 
% return 

load data_110MeV.mat


% Make scaling
r=E2/E1;
kicker1  =kicker*r;
septum1  =septum*r;
HCOR1    =HCOR*r;
VCOR1    =VCOR*r;
cv21     =cv2*r;
cv31     =cv3*r;

% write new values
tango_write_attribute2('BOO-C01/EP/AL_K.Inj','voltage',kicker1)
tango_write_attribute2('BOO-C22/EP/AL_SEP_P.Inj','voltage',septum1)

% setam('HCOR', HCOR1);
% setam('VCOR', VCOR1);

tango_write_attribute('LT1/AE/CV.2', 'current',  cv21 );
tango_write_attribute('LT1/AE/CV.3', 'current',  cv31 );

fprintf('Scaling off booster HVCOR, Kicker, Septum and LT2 CV2,3 done from %5.1f to %5.1f MeV \n',E1,E2)

return
