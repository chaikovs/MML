%generate and save structures for impulse response
var_name='Imp_Resp_'
index=10
variable=genvarname([var_name,num2str(index)])

getbpmrawdata('Struct','archive', 'AllData',variable)


%% generate global structure
N=10

for index=1:N
    load([var_name,num2str(index)])
    Imp_Resp_1_10.(genvarname([var_name,num2str(index)]))=AM
end

%% Save global structure

save Imp_Resp_1_10 Imp_Resp_1_10

%% generate filter and save
[ FilterStructure ] = bpm_tbt_filter_generation('FileName', 'Imp_Resp_1_10')
save('Filter-2014-11-04', 'FilterStructure');

