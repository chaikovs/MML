function set_bump_test7_2009

% deuxième optimisation du bump

% standard run 2
fprintf('Kicker delay read\n')
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay'); % 5621670
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay'); % 5621673
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay'); % 5621674
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay'); % 5621670

fprintf('Kicker voltage read\n')
temp=tango_read_attribute2('ANS-C01/EP/AL_K.1', 'voltage');  % 5.8064e+03
fprintf('K1=%10.1f\n',temp.value(2))
temp=tango_read_attribute2('ANS-C01/EP/AL_K.2', 'voltage');  % 5.8685e+03
fprintf('K2=%10.1f\n',temp.value(2))
temp=tango_read_attribute2('ANS-C01/EP/AL_K.3', 'voltage');  % 5.8153e+03
fprintf('K3=%10.1f\n',temp.value(2))
temp=tango_read_attribute2('ANS-C01/EP/AL_K.4', 'voltage');  % 5.8034e+03
fprintf('K4=%10.1f\n',temp.value(2))



% New values 
delai0 =5621670-40;
r=1.02;    % ratio global
r1=1.0 ;   % ratio 2 derniers kicker
k=-0;

%
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay',delai0 -1    + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay',delai0 +6    + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay',delai0 -2    + k);
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay',delai0 +2    + k);

%
tango_write_attribute2('ANS-C01/EP/AL_K.1', 'voltage',(5566)*r);
tango_write_attribute2('ANS-C01/EP/AL_K.2', 'voltage',(5644 )*r); 
tango_write_attribute2('ANS-C01/EP/AL_K.3', 'voltage',(5543 )*r);
tango_write_attribute2('ANS-C01/EP/AL_K.4', 'voltage',(5619)*r); 





