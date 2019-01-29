function Analyse_Bump_InVac(IDName,SESSION,Xmin,Xmax,Step,gap,gapmax,BPMtoSkip)
% Calculate the field Integrals (Ix and Iz) for Horizontal Bumps inside the ID from the orbits previously stored
% in the folder SESSION. The data in the folder SESSION must be saved in the following format: "BUMP_Xmm_GY.mat"
% IDName: Name of the ID including the name of the BL
% SESSION: Folder where the orbit data are saved
% Xmin, Xmax, Step: extrema values and step of the Bumps in X (mm)
% gap: gap of the ID 
% gapmax: maximum gap of the ID (Background gap) 
% BPMtoSkip: BPMs to  be skipped: ex: '[19,20]' or '[]' (default)
% Example: Analyse_Bump_InVac('U20_GALAXIES','SESSION_27_06_10/BUMP_Gap55_Neg',-22,0,2,5.5,30, '[49,50]')
% Analyse_Bump_InVac('WSV50_PSICHE','SESSION_28_06_10/BUMP_Gap55',-20,13,1,5.5,70,'[9,11,12,16,17,18,19,20,21,22,23,26,27,29,30,49,50,59,79,80,89,109,112]')

fprintf ('%s\n','----------------------------------------------')
fprintf ('%s\n','Entrefer[mm]      Bump[mm]         IX[G.m]         IZ[G.m]')
i=1;
Path=['/home/data/GMI/' IDName '/' SESSION];
fid= fopen([Path '/RESULTS_INTEGRALS_G' Num2Str(10*gap) '.txt'], 'w');
fprintf (fid,'%s\n','Entrefer[mm]      Bump[mm]         IX[G.m]         IZ[G.m]')
for X=Xmin:Step:Xmax
    FileName=['BUMP_' Num2Str(X) 'mm_G' Num2Str(10*gap)];
    Bckg=['BUMP_' Num2Str(X) 'mm_G' Num2Str(10*gapmax)];
    PathAndFileName=[Path '/' FileName];
    PathAndBckg=[Path '/' Bckg];
    st =idCalcFldIntFromElecBeamMeasForUndSOLEIL_1(IDName,Path,PathAndFileName,PathAndBckg,'',BPMtoSkip,0,0);
    IntegralX=st.I1X;
    IntegralZ=st.I1Z;
    XBump(i)=X;
    IX(i)=IntegralX;
    IZ(i)=IntegralZ;
    fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\n',gap,X,IntegralX,IntegralZ);
    fprintf(fid,'%8.4f\t %8.4f\t %8.4f\t %8.4f\n',gap,X,IntegralX,IntegralZ);
    i=i+1;
end
fprintf ('%s\n','----------------------------------------------')
plot(XBump,IX,'-or',XBump,IZ,'-ob');
Xlabel('VALEUR DU BUMP [mm]')
Ylabel('INTEGRALE DE CHAMP [G.m]')
grid on
legend('IX','IZ')
fclose(fid)
end
