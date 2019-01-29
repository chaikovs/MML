xdata=[-440 -400 -300 -200 -100 0 100 200 300 400 440]
Xrms = [197 174 115 63 18 0 18 68 87 133 152 ]
Zrms = [124 115 94 72 46 0 40 58 98 124 134]
xdatabis = [0]
Xrmsbis = [73] ;Zrmsbis = [25]
figure(3)
plot(xdata,Xrms,'ro-',xdata,Zrms,'bo-')
legend('rms orbite horizontale','rms orbite verticale')
xlabel('courant alimentation PS2');ylabel('rms en µm')
hold on
plot(xdatabis,Xrmsbis,'rs-',xdatabis,Zrmsbis,'bs-')
%legend('rms orbite horizontale','rms orbite verticale')