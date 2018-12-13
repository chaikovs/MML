function plot_screen_image_vol(g1,g6,g3,CXZE,fignum)
% 3d volumic plot from vol3d

num=201;
if (nargin==5);num=fignum;end

figure(num)
clf(num)
h = vol3d('cdata',CXZE,'xdata',g6*100,'ydata',g1*1e3,'zdata',g3*1e3,'texture','3D');
view(3)
axis tight;
set(gcf, 'color', 'w');
set(gca, 'Xgrid', 'on');
set(gca, 'Zgrid', 'on');
set(gca, 'Ygrid', 'on');
xlabel('dE (%)')
ylabel('X (mm)')
zlabel('Y (mm)')

return