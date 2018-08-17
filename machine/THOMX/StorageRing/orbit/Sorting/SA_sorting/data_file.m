function d = data_file()
sigmafielderor = 1e-4;
fielderror = sigmafielderor*randn(1,8);
dBB0 = fielderror; 
%cities = dBB0;

dipIND = [1 2 3 4 5 6 7 8];
save dBB0.mat dBB0 dipIND -V6;
