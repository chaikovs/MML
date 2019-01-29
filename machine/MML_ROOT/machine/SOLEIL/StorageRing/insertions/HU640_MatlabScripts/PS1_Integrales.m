function PS1_Integrales(SESSION,PS1,X)
FileName=['BUMP_' Num2Str(10*X) '_PS1_' Num2Str(PS1)];
Bckg=['BUMP_' Num2Str(10*X) '_PS1_0'];
Path=['/home/data/GMI/HU640_DESIRS/' SESSION '/PS1/'];
PathAndFileName=[Path FileName];
PathAndBckg=[Path Bckg];
st =idCalcFldIntFromElecBeamMeasForUndSOLEIL_1('HU640_DESIRS',Path,PathAndFileName,PathAndBckg,'', []);
IntegralXe=st.I1eX;
IntegralXs=st.I1sX;
IntegralZe=st.I1eZ;
IntegralZs=st.I1sZ;


fprintf('%8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\t %8.4f\n',PS1,X,IntegralXe,IntegralXs,IntegralZe,IntegralZs);

end
