% Calibration des correcteurs
Calibration_Correcteurs()
% Tables de FF Old DS2
PowerSupplyCycleAndBuildTables_LH_Unipolar_DS2_xml('SESSION_20_06_09','FF_LH',20,1)
PowerSupplyCycleAndBuildTables_Unipolar_DS2_xml('SESSION_20_06_09','TR_LH_LV',10,1)
PowerSupplyCycleAndBuildTables_Unipolar_DS2_xml('SESSION_20_06_09','FF_LV',10,1)
PowerSupplyCycleAndBuildTables_LH_Unipolar_DS2_xml('SESSION_20_06_09','TR_LV_LH',20,1)
PowerSupplyCycleAndBuildTables_Circ_DS2_xml('SESSION_20_06_09','Iv_Ib_Ir_Left_Circ_Pol_09_02_09','TR_LH_CI',0)
PowerSupplyCycleAndBuildTables_Circ_DS2_xml('SESSION_20_06_09','Table_CPL_11_05_09','FF_CI',0)
PowerSupplyCycleAndBuildTables_LH_Unipolar_DS2_xml('SESSION_20_06_09','TR_CI_LH',20,1)
% Tables de FF New DS2
PowerSupplyCycleAndBuildTables_3('SESSION_20_06_09','PS1',600,0,5,2)
PowerSupplyCycleAndBuildTables_3('SESSION_20_06_09','PS1',600,0,5,2)
PowerSupplyCycleAndBuildTables_3('SESSION_20_06_09','PS1',600,0,20,2)

PowerSupplyCycleAndBuildTables_3('SESSION_20_06_09','PS2',440,0,5,2)
PowerSupplyCycleAndBuildTables_3('SESSION_20_06_09','PS2',440,0,5,2)
PowerSupplyCycleAndBuildTables_3('SESSION_20_06_09','PS2',440,0,20,2)

PowerSupplyCycleAndBuildTables_3('SESSION_20_06_09','PS3',360,0,5,2)
PowerSupplyCycleAndBuildTables_3('SESSION_20_06_09','PS3',360,0,5,2)
PowerSupplyCycleAndBuildTables_3('SESSION_20_06_09','PS3',360,0,20,2)