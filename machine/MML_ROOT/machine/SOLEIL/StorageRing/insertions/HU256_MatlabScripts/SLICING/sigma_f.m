function [sigma]=sigma_f(data,s,i_T)
emittance=data(4);
Betax0=data(7);
Betaz0=data(8);
Etax=data(9);
Etaz=data(10);
emittance_x=data(11);
emittance_z=data(12);
sigma_gamma=data(13);
if (i_T==1)
    Eta=Etax;
    Beta0=Betax0;
    emittance=emittance_x;
elseif (i_T==2)
    Eta=Etaz;
    Beta0=Betaz0;
    emittance=emittance_z;
else
    printf('error i_T sigma_f');
end

sigma=sqrt(emittance*beta_f(Beta0,s)+Eta^2*sigma_gamma^2);%

function [beta]=beta_f(Beta0,s)
beta=Beta0+s^2/Beta0;
