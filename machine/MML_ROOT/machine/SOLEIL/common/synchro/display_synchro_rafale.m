function display_synchro_rafale(file)


Directory =  [getfamilydata('Directory','DataRoot') 'Datatemp']
pwdold = pwd;
cd(Directory);
load(file)
cd(pwdold);

timing.ans_bpm01(1)
timing.ans_k_v(1)
    
    timing.ans_k_v(1)-timing.ans_bpm01(1)


    
    
display('OK')


