function ReadTrendParam(CellName,SSType,IDName)
% CellName: Name of Cell: ex: 'ANS-C03'
% SSType: Type of Cell: 'C', 'M' or 'L'
% example: ReadTrendParam('ANS-C03','C','WSV50')
File='/home/data/GMI/Trend_InVac.txt';
File1='/home/data/GMI/Trend_InVac_test.txt';
fidread = fopen(File,'r');
fidwrite = fopen(File1,'w');
for j=1:1:116
    A = fgetl(fidread);
    if (j==60)
        A=
    end

    if j=60
    fprintf(fidwrite,'%s\n', A);
end
fclose(fidread);
fclose(fidwrite);


%Trend_param(60)=['dv0_name:'CellName '/EI/' SSType '-' IDName '/gap']
%Trend_param(79)=['dv1_name:' CellName '/DG/CALC-SD' SSType '-POSITION-ANGLE/positionX']
%Trend_param(98)=['dv2_name:'CellName '/DG/CALC-SD' SSType '-POSITION-ANGLE/positionZ']

end
    