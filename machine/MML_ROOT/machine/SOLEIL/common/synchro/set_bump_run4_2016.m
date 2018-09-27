function set_bump_run4_2016

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
%delai0 =5621670-40 -34 -6; standart
delai0 =5621587 - 50 + 50 ;
r=1.0;    % ratio global


tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay',delai0 +0  +0   );
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay',delai0 +11 -1   );
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay',delai0 +8  +1   );
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay',delai0 +5  +0   );

%
tango_write_attribute2('ANS-C01/EP/AL_K.1', 'voltage',(5454.67+10)*r);
tango_write_attribute2('ANS-C01/EP/AL_K.2', 'voltage',(5507.87+0)*r); 
tango_write_attribute2('ANS-C01/EP/AL_K.3', 'voltage',(5452.77+0)*r);
tango_write_attribute2('ANS-C01/EP/AL_K.4', 'voltage',(5455.45+15)*r); 
% 




