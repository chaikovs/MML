function do_update

fprintf('*****Update des 16 cartes locales******\n')

r=tango_command_inout2('ANS/SY/LOCAL.SDC.1','Update');  retour_update('ANS/SY/LOCAL.SDC.1',r);
r=tango_command_inout2('LT1/SY/LOCAL.DG.1','Update');  retour_update('LT1/SY/LOCAL.DG.1',r);
r=tango_command_inout2('LIN/SY/LOCAL.SPM.1','Update');  retour_update('LIN/SY/LOCAL.SPM.1',r);

r=tango_command_inout2('BOO/SY/LOCAL.Binj.1','Update'); retour_update('BOO/SY/LOCAL.Binj.1',r);
r=tango_command_inout2('BOO/SY/LOCAL.Alim.1','Update'); retour_update('BOO/SY/LOCAL.Alim.1',r);
r=tango_command_inout2('BOO/SY/LOCAL.DG.3',  'Update'); retour_update('BOO/SY/LOCAL.DG.3',r);
r=tango_command_inout2('BOO/SY/LOCAL.Bext.1','Update'); retour_update('BOO/SY/LOCAL.Bext.1',r);

r=tango_command_inout2('ANS-C01/SY/LOCAL.Ainj.1','Update'); retour_update('ANS-C01/SY/LOCAL.Ainj.1',r);
r=tango_command_inout2('ANS-C01/SY/LOCAL.Ainj.2','Update'); retour_update('ANS-C01/SY/LOCAL.Ainj.2',r);
r=tango_command_inout2('ANS-C02/SY/LOCAL.DG.1',  'Update'); retour_update('ANS-C02/SY/LOCAL.DG.1',r);
r=tango_command_inout2('ANS-C04/SY/LOCAL.DG.1',  'Update'); retour_update('ANS-C04/SY/LOCAL.DG.1',r);
r=tango_command_inout2('ANS-C06/SY/LOCAL.DG.1',  'Update'); retour_update('ANS-C06/SY/LOCAL.DG.1',r);
r=tango_command_inout2('ANS-C08/SY/LOCAL.DG.1',  'Update'); retour_update('ANS-C08/SY/LOCAL.DG.1',r);
r=tango_command_inout2('ANS-C10/SY/LOCAL.DG.1',  'Update'); retour_update('ANS-C10/SY/LOCAL.DG.1',r);
r=tango_command_inout2('ANS-C12/SY/LOCAL.DG.1',  'Update'); retour_update('ANS-C12/SY/LOCAL.DG.1',r);
r=tango_command_inout2('ANS-C14/SY/LOCAL.DG.1',  'Update'); retour_update('ANS-C14/SY/LOCAL.DG.1',r);
r=tango_command_inout2('ANS-C16/SY/LOCAL.DG.1',  'Update'); retour_update('ANS-C16/SY/LOCAL.DG.1',r);

fprintf('**************************************\n')