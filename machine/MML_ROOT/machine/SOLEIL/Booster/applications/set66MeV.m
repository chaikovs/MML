% scale some setpoint pour le mode linac dégradé MeV

%% 
E1=110; % Nominal
E2=69; % dégradée 


%% save start value only once warning to not over write
HCOR=getsp('HCOR');
VCOR=getsp('VCOR');
temp=tango_read_attribute2('BOO-C01/EP/AL_K.Inj','voltage');kicker=temp.value(2);
temp=tango_read_attribute2('BOO-C22/EP/AL_SEP_P.Inj','voltage');septum=temp.value(2);
temp=tango_read_attribute('LT1/AE/CV.2', 'current');cv2=temp.value(2);
temp=tango_read_attribute('LT1/AE/CV.3', 'current');cv3=temp.value(2);
save data_110MeV.mat HCOR VCOR kicker septum cv2 cv3

return

%% Apply scaling
r=E2/E1
kicker1=6600 *r;
sept1 =194.9*r;
HCOR1=HCOR*r;
VCOR1=VCOR*r;
cv21=cv2*r;
cv31=cv3*r;

writeattribute('BOO-C01/EP/AL_K.Inj/voltage',kicker1);
writeattribute('BOO-C22/EP/AL_SEP_P.Inj/voltage',sept1);
setsp('HCOR', HCOR1);
setsp('VCOR', VCOR1);


tango_write_attribute('LT1/AE/CV.2', 'current',  cv21 );
tango_write_attribute('LT1/AE/CV.3', 'current',  cv31 );

setsp('HCOR', HCOR);
setsp('VCOR', VCOR);


tango_write_attribute('LT1/AE/CV.2', 'current',  cv2 );
tango_write_attribute('LT1/AE/CV.3', 'current',  cv3 );