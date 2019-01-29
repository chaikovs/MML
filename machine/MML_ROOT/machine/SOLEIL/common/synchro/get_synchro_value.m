function [timing]=get_synchro_value
% complet timing structure with value
% timing.name
% timing.list    (table de 4 attributs par n delais)
% timing.value   according to list

% get list
[timing]=get_synchro_attribut;
nc=length(timing);



m=1; % valeur lue 
for k=2:nc
    
    name=timing(k).name;
    list=timing(k).list;
    n=size(list);
    ndelais=n(1) ; % nombre de délais
    ndata =n(2);  % nombre d'attribut par délais
    fprintf('%s   %d  délais\n',name,ndelais)
    
    value=[];
    for i=1:ndelais
        val=[];
        for j=1:ndata-1
            temp=tango_read_attribute2(name, list{i,j});
            val=[val double(temp.value(m))];
        end
        value=[value ; val];
    end
    
    
    % complete stucture
    timing(k).value=value;
    
end

return
