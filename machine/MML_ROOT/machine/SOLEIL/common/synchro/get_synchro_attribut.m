function [timing]=get_synchro_attribut
% make a timing structure 
% timing.name
% timing.list (table de 4 attributs par n delais)

n1=21 ; % skip n1 first  attribut not relevant
n2=2  ; % skip last n2 attribut not relevant

% get liste des cartestiming(i).name=name;
[list_carte_synchro]=get_list_carte_synchro;
nc=length(list_carte_synchro);

timing=[];
for k=2:nc
    
    name=list_carte_synchro{k};
    list_at=tango_get_attribute_list(name);
    n=length(list_at)-n2;list_at=list_at(n1:n);
    %fprintf('%s\n',name)
    list=[];
    for i=1:4:length(list_at)
        %fprintf('   %s  %s   %s  %s\n',list_at{i:i+3})
        list=[list ; [list_at(i:i+3)]];
    end
    
    % make stucture
    timing(k).name=name;
    timing(k).list=list;
    
end

return
