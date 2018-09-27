function PlotSmoothRadiaMap(Ln,x,Bx,Bz,sx,sBx,sBz,forder,funit)
% plot the data before and after interpolation

 
  figure(11);
  
      plot(x,Bx(Ln,2:end),'b-');
      hold on;
      plot(sx,sBx(Ln,:),'r-');
  
 xlabel('x[m]');
 ylabel([forder, ' Bx / vertical kick ',funit]);
 legend('before smooth','after smooth');
  
 %title(['spline interpolation, data is amplified by ', num2str(f)]);

  figure(12);
  
      plot(x,Bz(Ln,2:end),'b-');
      hold on;
      plot(sx,sBz(Ln,:),'r-');
  
 xlabel('x[m]');
 ylabel([forder, ' By / horizontal kick ',funit]);
 legend('before smooth','after smooth');
% title(['spline interpolation, data is amplified by ', num2str(f)]);