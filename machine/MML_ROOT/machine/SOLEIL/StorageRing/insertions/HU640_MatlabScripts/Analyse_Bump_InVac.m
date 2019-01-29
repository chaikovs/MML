function Analyse_Bump_InVac(IDName,SESSION,Xmin,Xmax,Step,gap,gapmax)
% IDName: Name of the ID including the name of the BL
% SESSION: Folder where the orbit data are saved
% Xmin, Xmax, Step: extrema values and step of the Bumps in X (mm)
% gap: gap of the ID 
% gapmax: maximum gap of the ID (Background gap) 

% The data in the folder SESSION must be saved in the following format: "BUMP_XXmm_GYY.mat"

% Example:Analyse_Bump_InVac('U20_SWING','SESSION_22_03_2010',-3,3,1,5.5,30)
fprintf ('%s\n','----------------------------------------------')
fprintf ('%s\n','Entrefer[mm]      Bump[mm]         IX[G.m]         IZ[G.m]')
for X=Xmin:Step:Xmax
    FileName=['BUMP_' Num2Str(X) 'mm_G' Num2Str(10*gap)];
    Bckg=['BUMP_' Num2Str(X) 'mm_G' Num2Str(10*gapmax)];
    Path=['/home/operateur/GrpGMI/' IDName '/' SESSION];
    PathAndFileName=[Path '/' FileName];
    PathAndBckg=[Path '/' Bckg];
    st =idCalcFldIntFromElecBeamMeasForUndSOLEIL_1(IDName,Path,PathAndFileName,PathAndBckg,'',-1);
    IntegralX=st.I1X;
    IntegralZ=st.I1Z;

    fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\n',gap,X,IntegralX,IntegralZ);
end
fprintf ('%s\n','----------------------------------------------')
end