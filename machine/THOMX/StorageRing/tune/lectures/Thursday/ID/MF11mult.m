%Normal multipole field expansion for BL11 magic fingers.

% The magic finger field integrals look like
% Integral(B_y*dz) = SUM_n (a_n*x^n)
% n    a_n( G/cm^(n-1) )
% 1  -6.5845627e+002
% 3  -1.8563540e+000
% 5  -6.5270462e+002
% 7   2.1934256e+002
% 9  -3.3887310e+001
% 11  2.8884377e+000
% 13 -1.3117332e-001
% 15  2.4765093e-003
% 
% Half of the above field should go on each end of the wiggler.  
% Fitting only to order 13 also gives a good fit to Int(By*dz)(x):
% 
% Integral(B_y*dz) = SUM_n (a_n*x^n)
% n    a_n( G/cm^(n-1) )
% 1  -5.8370411e+002
% 3  -2.4088952e+002
% 5  -4.3309594e+002
% 7   1.3087547e+002
% 9  -1.5677599e+001
% 11  8.8899339e-001
% 13 -1.9747485e-002
% 
% The coefficients of the x^13 and x^15 expansions differ significantly.  
% The curve of Int(By*dz)(x) looks about the same for each, so I expect 
% either would give about the same horizontal and off-energy dynamic 
% aperture.  The dynamic aperture with y could be quite different, however, 
% so I think it would be interesting to track both.

%Consistent with MATLAB notation, last term is x^0 (dipole) term.
% polyn=[
%     2.4765093e-003
%     0
%     -1.3117332e-001
%     0
%     2.8884377e+000
%     0
%     -3.3887310e+001
%     0
%     2.1934256e+002
%     0
%     -6.5270462e+002
%     0
%     -1.8563540e+000
%     0
%     -6.5845627e+002
%     0
% ];
polyn=[
    -1.9747485e-002
    0
    8.8899339e-001
    0
    -1.5677599e+001
    0
    1.3087547e+002
    0
    -4.3309594e+002
    0
    -2.4088952e+002
    0
    -5.8370411e+002
    0
];
%Convert from G*cm to T*m
polyn = -1e-6*polyn;
%Convert from x[cm] to x[m]
conv = length(polyn)-1:-1:0;
for i = 1:length(conv)
    conv(i) = 100^conv(i);
end
polyn = polyn.*conv';
polys = zeros(size(polyn));

% %Plot to make sure the conversion is correct
% xplot = -.035:.001:.035;
% BL = 0*xplot;
% for i = 1:length(polyn)
%     BL = BL + polyn(i)*xplot.^(length(polyn)-i);
% end
% figure
% plot(xplot,BL)

%Divide by Brho to convert to multipole definition for AT
Brho = 3/0.299792458;
polyn = polyn/Brho;
%Divide by 2, because half the correction goes on each end of wiggler.
polyn = polyn/2;

% MF11 = multipole('MF11', 0, [0], reverse(polyn), 'StrMPoleSymplectic4Pass');
% function z=multipole(fname,L,PolynomA,PolynomB,method)
MF11.FamName = 'MF11';  % add check for identical family names
MF11.Length = 0;
MF11.PolynomA= reverse(polys);	 
MF11.PolynomB= reverse(polyn);
MF11.MaxOrder = length(polyn)-1;
MF11.PassMethod='ThinMPolePass';