% special tension septum actif boo et ans

% valeur de tension a basse cadence (soft)
boo=99.239224886870645;
ans=93.536955102247219;
r=(1+0.002); % ratio
try
    %temp=tango_read_attribute2('BOO-C12/EP/AL_SEP_A.Ext','voltage');boo=temp.value(2)*r
    tango_write_attribute2('BOO-C12/EP/AL_SEP_A.Ext','voltage',boo*r);
    %temp=tango_read_attribute2('ANS-C01/EP/AL_SEP_A','voltage');    ans=temp.value(2)*r
    tango_write_attribute2('ANS-C01/EP/AL_SEP_A','voltage',ans*r);
catch
    display('Erreur ajustement tension septa passif')
end
temp=tango_read_attribute2('BOO-C12/EP/AL_SEP_A.Ext','voltage');temp.value(2)
temp=tango_read_attribute2('ANS-C01/EP/AL_SEP_A','voltage');    temp.value(2)
    

return
% start value

tango_write_attribute2('BOO-C12/EP/AL_SEP_A.Ext','voltage',boo);
tango_write_attribute2('ANS-C01/EP/AL_SEP_A','voltage',ans);