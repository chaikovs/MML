%%
addpath addpath c:\USPAS\BBDiag\Release\mml
setpathspear3

%% precise tune determination
nu = pi-3;
nturn = 100;
x = sin(2*pi*nu*(1:nturn));

[nu1, amp1] = naff(x');
nu1 - nu

[nu2]=findfreq(x',x');

%[tmp, nu3]=ipfaw(x);

fprintf('Naff  findfreq ipfaw:  %d turns\n', nturn)
[nu1; nu2] - nu
%% add noise

x = x + 0.02*randn(size(x));
[nu1, amp1] = naff(x');

[nu2]=findfreq(x',x');

%[tmp, nu3]=ipfaw(x);

[nu1; nu2] - nu

%% repeat with more turns
nu = pi-3;
nturn = 500;
x = sin(2*pi*nu*(1:nturn));

[nu1, amp1] = naff(x');

[nu2]=findfreq(x',x');

%[tmp, nu3]=ipfaw(x);

fprintf('Naff  findfreq ipfaw:  %d turns\n', nturn)
[nu1; nu2] - nu

%% add noise

x = x + 0.02*randn(size(x));
[nu1, amp1] = naff(x');

[nu2]=findfreq(x',x');

%[tmp, nu3]=ipfaw(x);

[nu1; nu2] - nu
