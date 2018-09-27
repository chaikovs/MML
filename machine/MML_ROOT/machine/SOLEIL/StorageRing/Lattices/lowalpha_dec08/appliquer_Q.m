%% fonction appliquer
function appliquer_Q(IQ)
for iQ = 1:10
    iQ
    Name = ['Q' num2str(iQ)];
    A = IQ(iQ);
    %s = getfamilydata((Name));
    %B = A * ones(length(s.DeviceList),1);
    setsp((Name),A);
end
