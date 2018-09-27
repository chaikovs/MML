function test_global()
    global toto
    toto='';
    isnan(toto)
    isempty(toto)
    fprintf(''''' %f\n', strcmp(toto, ''))
    fprintf('notanumber %f\n', isnan(toto))
    fprintf('num %f\n', isa(toto, 'numeric'))
    fprintf('string %f\n', isa(toto, 'char'))
    size(toto)
    
    
end