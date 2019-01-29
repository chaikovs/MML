function pass = remeztest

% Nick Trefethen, 27 March 2009

% Test remez:
x = chebfun('x',[-1 1]);
f = abs(x) + x;
pexact = .5+x;
pbest = remez(f,1);
err = norm(pbest-pexact);
pass(1) = (err<1e-10);

% Test remez and cf:
f = exp(sin(exp(x)));
pcf = cf(f,7);
pbest = remez(f,7);
pass(2) = (norm(pcf-pbest)<0.0003);

pass = all(pass);
