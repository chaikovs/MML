function set_bump_optim

% deuxième optimisation du bump

%delai0 =31522246;  
delai0 =5621670;
voltage0=3000;  
r=0.90   % ratio global
r1=1.010  % ratio 2 derniers kicker

k=+0;

tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay',delai0-0     + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay',delai0+3    + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay',delai0+2    + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay',delai0-1    + k);


tango_write_attribute2('ANS-C01/EP/AL_K.1', 'voltage',(((6240+0)*r)   +80) );
tango_write_attribute2('ANS-C01/EP/AL_K.2', 'voltage',(((6200-0)*r)   -40  ) ); 
tango_write_attribute2('ANS-C01/EP/AL_K.3', 'voltage',(((6050+0)*r)*r1+90  ) );
tango_write_attribute2('ANS-C01/EP/AL_K.4', 'voltage',(((6200+0)*r)*r1-70  ) ); 



return


