% special delai septum actif boo et ans
% logée l'extraction sur la crete du septa

septclk=52*184/2; % = 52 tours booster : max delai sur injection
% valeur de tension a basse cadence (soft)
%temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigStepDelay');     boo=temp.value(2)
%temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigStepDelay'); ans=temp.value(2)
boo=31240305;
ans=31240316;

nstep=1
try
    tango_write_attribute2('BOO-C12/EP/AL_SEP_A.Ext','voltage',(boo + nstep*stepclk));
    tango_write_attribute2('ANS-C01/EP/AL_SEP_A','voltage',    (ans + nstep*stepclk));
catch
    display('Erreur ajustement tension septa passif')
end


return
% start value

tango_write_attribute2('BOO-C12/EP/AL_SEP_A.Ext','voltage',boo);
tango_write_attribute2('ANS-C01/EP/AL_SEP_A','voltage',ans);