function  PlotRadiaMap_Byxy(x,Bz,forder,funit)
% 2D (mesh) plot field map
   figure(6);
   mesh(x,Bz(:,1),Bz(:,2:end));
    xlabel('x[m]');
    ylabel('y[y]');s
    zlabel([forder, ' By ',funit]);
  title([forder,' horizontal kick/vertical field map ',funit]);
