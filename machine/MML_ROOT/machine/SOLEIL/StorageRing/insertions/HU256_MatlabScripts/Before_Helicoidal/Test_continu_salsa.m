function Test_continu_salsa(courant_debut, courant_fin, pas, waiting_time)
    step_of_time=1;
    max_time=300;   %5min
    debug=0;
    
    device='ans-c15/ei/m-hu256.2';
    attrib_courant='/currentBZP';
    attrib_running='/State';
    for (i=courant_debut:pas:courant_fin)
        if (debug==1)
            fprintf('courant actuel: %f\n', readattribute([device attrib_courant]));
            fprintf('courant consigne: %f\n', i);
        end
        writeattribute([device attrib_courant], i);
        t=0;
        while (readattribute([device attrib_running])==10)&&(t<=max_time)
            pause (step_of_time);
            t=t+step_of_time;
        end
        
        pause (waiting_time);
    end
    fprintf('%s\n', 'Finished');