function  PlotRadiaMap_Bxy(StartLn,EndLn,x,Bx,forder,funit)

fcolor = ['r','b','g','c','k','m','y'];
figure(2);
for i=StartLn:EndLn
    
       fci = fcolor(rem(i,7));
    if (fci == 0) fci = 1;end
    
    plot(Bx(:,1),Bx(:,i),fci);
    hold on;
end
 xlabel('y[m]');
 ylabel([forder, ' Bx ',funit]);
 title([forder,' vertical kick/horizontal field map',funit,'  for lines: ', num2str(StartLn),' to ',num2str(EndLn)]);
 grid on;