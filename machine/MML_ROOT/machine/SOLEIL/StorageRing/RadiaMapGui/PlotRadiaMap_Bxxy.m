function  PlotRadiaMap_Bxxy(x,Bx,forder,funit)
% 2D (mesh) plot field map
   figure(3);
   mesh(x,Bx(:,1),Bx(:,2:end));
    xlabel('x[m]');
    ylabel('y[m]');
    zlabel([forder, ' Bx ',funit]);
  title([forder,' vertical kick/horizontal field map ',funit]);
