function d = distance(inputcities)
% DISTANCE
% d = DISTANCE(inputcities) calculates the distance between n cities as
% required in a Traveling Salesman Problem. The input argument has two rows
% and n columns, where n is the number of cities and each column represent
% the coordinate of the corresponding city. 

% d = 0;
% for n = 1 : length(inputcities)
%     if n == length(inputcities)
%         d = d + norm(inputcities(:,n) - inputcities(:,1));
%     else    
%         d = d + norm(inputcities(:,n) - inputcities(:,n+1));
%     end

%dx_pions_m = TruncatedGaussian(100e-6, [20e-6 110e-6], 1, num_ring);

% dx_pions = 1.0e6 * 1.0e-03 *[0.1083    0.1021    0.0650    0.0243    0.0825    0.0267    0.0679    0.0768    0.0962    0.0761    0.0268    0.0470    0.0995    0.0860    0.0732    0.0765];
% cities =  1.0e6 * 1.0e-03 *[ -0.0353   -0.0755   -0.0923   -0.0639   -0.0850   -0.1007   -0.0929   -0.0983   -0.0883   -0.0593   -0.0445 ...
%     -0.0419   -0.0968   -0.0991   -0.0950   -0.0705   -0.0833   -0.0612   -0.0268   -0.0873...
%     -0.0560   -0.0883   -0.0795   -0.0502   -0.1049   -0.0210   -0.0286   -0.0385   -0.1024   -0.0265   -0.0599   -0.0837   -0.1089   -0.0724];

dx_pions = [84.7764   45.7139  120.8345   63.9237  131.3659   95.1043  123.7000  129.3086  110.2734   61.3599   83.2120   90.9556   56.6501   29.0558   42.5475   79.6442];
cities =  [-17.2938  -81.6613 -109.2960  -70.5810 -104.1821  -91.4106  -10.5543  -41.6296 -112.5468  -51.8421 ...
    -49.0235 -123.7255  -63.8511  -65.9240 -135.5756  -72.3196  -17.4613  -44.8338  -40.1657 -129.1990...
    -71.6363  -59.9986  -15.7693  -51.8125 -144.0951 -124.5435  -52.8554  -93.1982 -125.2211 -109.7143  -53.6465  -11.3039 -106.9006  -74.3405];


d1 = cities(inputcities) + dx_pions;
d = sum(abs(d1));

end
