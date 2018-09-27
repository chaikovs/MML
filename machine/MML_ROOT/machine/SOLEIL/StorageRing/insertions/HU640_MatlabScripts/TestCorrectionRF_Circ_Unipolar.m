function Result=TestCorrectionRF_Circ_Unipolar(SESSION,File,temp)
% Indicate the location of the Device Servers %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idDevServMainPS1=['ans-c05/ei/l-hu640_PS1'];
idDevServMainPS2=['ans-c05/ei/l-hu640_PS2'];
idDevServMainPS3=['ans-c05/ei/l-hu640_PS3'];
idDevServCHE=['ans-c05/ei/l-hu640_corr2'];
idDevServCHS=['ans-c05/ei/l-hu640_corr1'];
idDevServCVE=['ans-c05/ei/l-hu640_corr4'];
idDevServCVS=['ans-c05/ei/l-hu640_corr3'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PathAndDataCircPolarCurrents=['/home/operateur/GrpGMI/HU640_DESIRS/' SESSION '/' File];
fident=fopen(PathAndDataCircPolarCurrents,'r');
A=fscanf(fident,'%g %g %g %g %g %g %g %g',[8 inf]);
N=length(A);
for i=1:N
    fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n',A(1,i),A(2,i),A(3,i),1E6*A(4,i),A(5,i),A(6,i),A(7,i),A(8,i));
    idSetCurrentSync(idDevServMainPS1, A(1,i), 0.1);
    idSetCurrentSync(idDevServMainPS2, A(2,i), 0.1);
    idSetCurrentSync(idDevServMainPS2, A(3,i), 0.1);
    if abs(A(4,i))<20e-6
    stepRF(A(4,i));
    end
    idSetCurrentSync(idDevServMainCHE, A(5,i), 0.002);
    idSetCurrentSync(idDevServMainCHS, A(6,i), 0.002);
    idSetCurrentSync(idDevServMainCVE, A(7,i), 0.002);
    idSetCurrentSync(idDevServMainCVS, A(8,i), 0.002);
    pause(temp)
end
