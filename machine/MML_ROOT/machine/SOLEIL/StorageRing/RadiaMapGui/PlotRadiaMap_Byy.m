function  PlotRadiaMap_Byy(StartLn,EndLn,x,Bz,forder,funit)

fcolor = ['r','b','g','c','k','m','y'];
figure(5);
for i=StartLn:EndLn
    
       fci = fcolor(rem(i,7));
    if (fci == 0) fci = 1;end
    
    plot(Bz(:,1),Bz(:,i),fci);
    hold on;
end
 xlabel('y[m]');
 ylabel([forder, ' By ',funit]);
 title([forder,' horizontal kick/vertical field map',funit,'  for lines: ', num2str(StartLn),' to ',num2str(EndLn)]);
 grid on;