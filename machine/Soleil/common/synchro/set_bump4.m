function set_bump4

% deuxième optimisation du bump

delai0 =31522246;  
voltage0=3000;  
r=1.

k=0;

tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay',delai0-0  + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay',delai0+4  + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay',delai0+4  + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay',delai0+3 + k);


return
tango_write_attribute2('ANS-C01/EP/AL_K.1', 'voltage',(5670*r));
tango_write_attribute2('ANS-C01/EP/AL_K.2', 'voltage',(5637*r));
tango_write_attribute2('ANS-C01/EP/AL_K.3', 'voltage',(5434*r));
tango_write_attribute2('ANS-C01/EP/AL_K.4', 'voltage',(5567*r));




