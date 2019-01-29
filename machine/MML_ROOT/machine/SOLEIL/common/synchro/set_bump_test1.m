function set_bump_test

% deuxième optimisation du bump

%delai0 =31522246;  
delai0 =5621670;
voltage0=3000;  
r=0.9;    % ratio global
r1=1.010 ; % ratio 2 derniers kicker

k=+0;

tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay',delai0-0 + 5   + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay',delai0+3 -  0  + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay',delai0+2 - 0  + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay',delai0-1 + 1   + k);


tango_write_attribute2('ANS-C01/EP/AL_K.1', 'voltage',(5064+0)*r);
tango_write_attribute2('ANS-C01/EP/AL_K.2', 'voltage',(5052-0)*r); 
tango_write_attribute2('ANS-C01/EP/AL_K.3', 'voltage',((5017+0)*r)*r1);
tango_write_attribute2('ANS-C01/EP/AL_K.4', 'voltage',((5031+0)*r)*r1); 



return



