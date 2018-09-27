function set_bump_test1_2009

% deuxième optimisation du bump

%delai0 =31522246;  
delai0 =5621670;
voltage0=3000;  
r=1.;    % ratio global
r1=1.010 ; % ratio 2 derniers kicker

k=+0;

tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay',delai0-0    + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay',delai0+5    + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay',delai0+7    + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay',delai0+1    + k);


tango_write_attribute2('ANS-C01/EP/AL_K.1', 'voltage',5591*r);
tango_write_attribute2('ANS-C01/EP/AL_K.2', 'voltage',5630*r); 
tango_write_attribute2('ANS-C01/EP/AL_K.3', 'voltage',5592*r);
tango_write_attribute2('ANS-C01/EP/AL_K.4', 'voltage',5566*r); 



return



