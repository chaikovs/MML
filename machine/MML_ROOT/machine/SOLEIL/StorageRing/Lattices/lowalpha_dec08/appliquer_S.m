function appliquer_S(IS)
for iS = 1:10
    iS
    Name = ['S' num2str(iS)];
    A = IS(iS);
    %s = getfamilydata((Name));
    %B = A * ones(length(s.DeviceList),1);
    setsp((Name),A);
end