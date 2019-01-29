function set_bump8_1

% deuxième optimisation du bump

%delai0 =31522246;  
delai0 =5621670;
voltage0=3000;  
r=0.85    % ratio global
r1=1.010  % ratio 2 derniers kicker

k=0;

tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay',delai0-0     + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay',delai0+4 -4  + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay',delai0+5 +0    + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay',delai0+2 +0  + k);


tango_write_attribute2('ANS-C01/EP/AL_K.1', 'voltage',(6240*r          +90));
tango_write_attribute2('ANS-C01/EP/AL_K.2', 'voltage',((6200-0)*r      -90));
tango_write_attribute2('ANS-C01/EP/AL_K.3', 'voltage',((6040+0)*r)*r1  +90);
tango_write_attribute2('ANS-C01/EP/AL_K.4', 'voltage',(6200*r)*r1      -90);



return



