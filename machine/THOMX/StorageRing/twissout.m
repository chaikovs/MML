
global THERING
Optics = gettwiss(THERING,0.0);
indx=atindex(THERING);
icor=indx.HCOR;
ibpm=indx.BPMx;
ikick=indx.SEPT;
indx=sort([icor ibpm ikick]);

disp('name    phix   phiy   betax   betay')
for k=1:length(indx)
    j=indx(k);
    phix=num2str(Optics.phix(j));
    phiy=num2str(Optics.phiy(j));
    bx=num2str(Optics.betax(j));
    by=num2str(Optics.betay(j));
    disp([Optics.name(j,:),'  ',phix,'  ', phiy,'  ',bx,'  ',by]);
end
