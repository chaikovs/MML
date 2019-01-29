function BXApMatrix=HU256_GetBX2CurrentMatrixForAperiodic(HU256Cell)
    BXApMatrix=-1;
    % WARNING : The BXApMatrices should be BX1 rising sorted!
    if (HU256Cell==4)
        BXApMatrix= [0	0.000;
                    25	20.103;
                    50	40.339;
                    75	60.791;
                    100	81.339;
                    125	101.852;
                    150	122.339;
                    175	142.836;
                    200	163.339;
                    225	183.840;
                    250	204.339;
                    275	224.839];
    elseif (HU256Cell==12)
        BXApMatrix= [0	0.000;
                    25	20.103;
                    50	40.339;
                    75	60.791;
                    100	81.339;
                    125	101.852;
                    150	122.339;
                    175	142.836;
                    200	163.339;
                    225	183.840;
                    250	204.339;
                    275	224.839];
    elseif (HU256Cell==15)
        BXApMatrix= [0	0.000;
                    25	20.103;
                    50	40.339;
                    75	60.791;
                    100	81.339;
                    125	101.852;
                    150	122.339;
                    175	142.836;
                    200	163.339;
                    225	183.840;
                    250	204.339;
                    275	224.839];
    else
        fprintf('Problem in HU256_GetBX2CurrentForAperiodic -> HU256Cell must be :\n    4 (PLEIADES)\n    12 (ANTARES)\nor  15 (CASSIOPEE)\n')
        return
    end
end
