function set_bump_test6_2009

% deuxième optimisation du bump

% standard run 2
tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay'); % 5621670
tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay'); % 5621673
tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay'); % 5621674
tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay'); % 5621670

tango_read_attribute2('ANS-C01/EP/AL_K.1', 'voltage' ); % 5.8064e+03
tango_read_attribute2('ANS-C01/EP/AL_K.2', 'voltage');  % 5.8685e+03
tango_read_attribute2('ANS-C01/EP/AL_K.3', 'voltage');  % 5.8153e+03
tango_read_attribute2('ANS-C01/EP/AL_K.4', 'voltage');  % 5.8034e+03


%delai0 =31522246;  
delai0 =5621670-40;
voltage0=3000;  
r=1.02;    % ratio global
r1=1.0 ; % ratio 2 derniers kicker

k=-0;

tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay',delai0 -1    + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay',delai0 +6    + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay',delai0 -2    + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay',delai0 +2    + k);


tango_write_attribute2('ANS-C01/EP/AL_K.1', 'voltage',(5566)*r);
tango_write_attribute2('ANS-C01/EP/AL_K.2', 'voltage',(5644 )*r); 
tango_write_attribute2('ANS-C01/EP/AL_K.3', 'voltage',(5543 )*r);
tango_write_attribute2('ANS-C01/EP/AL_K.4', 'voltage',(5619)*r); 



return



