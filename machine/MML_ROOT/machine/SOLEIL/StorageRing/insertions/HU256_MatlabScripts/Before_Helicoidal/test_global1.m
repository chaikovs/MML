function test_global1()
    global SENSEOFCURRENT;
    global PRESENTCURRENT;
    SENSEOFCURRENT=-1;
    PRESENTCURRENT=151;
    fprintf('SENSEOFCURRENT : %f\n', SENSEOFCURRENT)
    fprintf('PRESENTCURRENT : %f\n', PRESENTCURRENT)
end