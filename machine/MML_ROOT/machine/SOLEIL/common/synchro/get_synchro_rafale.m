function [timing]=get_synchro_rafale(DirName)
% step and address

n=1;
% central
temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TPcStepDelay');
timing.central_pc=temp.value(n);

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TInjStepDelay');
timing.central_inj=temp.value(n);

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay');
timing.central_soft=temp.value(n);

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSprStepDelay');
timing.central_spare=temp.value(n);

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'ExtractionOffsetClkStepValue');
timing.central_ext=temp.value(n);



% continu
% alim
temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'dpStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'dpEvent');
timing.boo_dp=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'qfStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'qfEvent');
timing.boo_qf=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'qdStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'qdEvent');
timing.boo_qd=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'sfStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'sfEvent');
timing.boo_sf=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'sdStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'sdEvent');
timing.boo_sd=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'compStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'compEvent');
timing.boo_cp=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.RF.1', 'rfStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.RF.1', 'rfEvent');
timing.boo_rf=[temp.value(n) double(temp1.value(n))];

% modulateur/alim linac
temp=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'spareStepDelay');
temp1=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'spareEvent');
timing.lin_modulateur=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'libre.1StepDelay');
temp1=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'libre.1Event');
timing.lin_alim=[temp.value(n) double(temp1.value(n))];

% Linac
temp=tango_read_attribute2('ANS/SY/LOCAL.SDC.1', 'oscStepDelay');
temp1=tango_read_attribute2('ANS/SY/LOCAL.SDC.1', 'oscEvent');
timing.sdc1=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmStepDelay');
temp1=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmEvent');
timing.lin_lpm=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('LIN/SY/LOCAL.SPM.1', 'spmLinacStepDelay');
temp1=tango_read_attribute2('LIN/SY/LOCAL.SPM.1', 'spmLinacEvent');
timing.lin_spm=[temp.value(n) double(temp1.value(n))];


% LT1
temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'emittanceStepDelay');
temp1=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'emittanceEvent');
timing.lt1_emittance=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'mc.1StepDelay');
temp1=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'mc.1Event');
timing.lt1_mc1=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'mc.2StepDelay');
temp1=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'mc.2Event');
timing.lt1_mc2=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'oscStepDelay');
temp1=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'oscEvent');
timing.lt1_osc=[temp.value(n) double(temp1.value(n))];



% Boo
temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'dcct-booStepDelay');
temp1=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'dcct-booEvent');
timing.boo_dcct=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.Binj.1', 'sep-p.trigStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.Binj.1', 'sep-p.trigEvent');
timing.boo_sep_p_inj=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.Binj.1', 'k.trigStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.Binj.1', 'k.trigEvent');
timing.boo_k_inj=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.DG.1', 'bpm-bta.trigStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.DG.1', 'bpm-bta.trigEvent');
timing.boo_bpm=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.DG.3', 'bpm-onde.trigStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.DG.3', 'bpm-onde.trigEvent');
timing.boo_nod=[temp.value(n) double(temp1.value(n))];



% ext
temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'dof.trigStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'dof.trigEvent');
timing.boo_dof_ext=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-p.trigStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-p.trigEvent');
timing.boo_sep_p_ext=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigEvent');
timing.boo_sep_a_ext=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'k.trigStepDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'k.trigEvent');
timing.boo_k_ext=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('ANS/SY/LOCAL.SDC.1', 'spareStepDelay');
temp1=tango_read_attribute2('ANS/SY/LOCAL.SDC.1', 'spareEvent');
timing.sdc2=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('BOO/SY/LOCAL.DG.3', 'emittanceTimeDelay');
temp1=tango_read_attribute2('BOO/SY/LOCAL.DG.3', 'emittanceEvent');
timing.boo_mrsv=[temp.value(n) double(temp1.value(n))];


% LT2
temp=tango_read_attribute2('LT2/SY/LOCAL.DG.1', 'mrsvStepDelay');
temp1=tango_read_attribute2('LT2/SY/LOCAL.DG.1', 'mrsvEvent');
timing.lt2_emittance=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('LT2/SY/LOCAL.DG.1', 'osc-fctStepDelay');
temp1=tango_read_attribute2('LT2/SY/LOCAL.DG.1', 'osc-fctEvent');
timing.lt2_osc=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('LT2/SY/LOCAL.DG.2', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('LT2/SY/LOCAL.DG.2', 'bpm.trigEvent');
timing.lt2_bpm=[temp.value(n) double(temp1.value(n))];

% Ajout 2017 ICT sur LT2
temp=tango_read_attribute2('ANS-C16/SY/LOCAL.DG.1', 'mcLT2.trigStepDelay');
temp1=tango_read_attribute2('ANS-C16/SY/LOCAL.DG.1', 'mcLT2.trigEvent');
timing.lt2_ict=[temp.value(n) double(temp1.value(n))];


% ANS
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay');
temp1=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigEvent');
timing.ans_k1_inj=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay');
temp1=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigEvent');
timing.ans_k2_inj=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay');
temp1=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigEvent');
timing.ans_k3_inj=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay');
temp1=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigEvent');
timing.ans_k4_inj=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-p.trigStepDelay');
temp1=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-p.trigEvent');
timing.ans_sep_p_inj=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigStepDelay');
temp1=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigEvent');
timing.ans_sep_a_inj=[temp.value(n) double(temp1.value(n))];




temp=tango_read_attribute2('ANS-C01/SY/LOCAL.DG.2', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C01/SY/LOCAL.DG.2', 'bpm.trigEvent');
timing.ans_bpm01=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C02/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C02/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm02=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C03/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C03/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm03=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C04/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C04/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm04=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C05/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C05/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm05=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C06/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C06/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm06=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C07/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C07/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm07=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm08=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C09/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C09/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm09=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C10/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C10/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm10=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C11/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C11/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm11=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C12/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C12/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm12=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C13/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C13/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm13=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C14/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C14/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm14=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C15/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C15/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm15=[temp.value(n) double(temp1.value(n))];
temp=tango_read_attribute2('ANS-C16/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
temp1=tango_read_attribute2('ANS-C16/SY/LOCAL.DG.1', 'bpm.trigEvent');
timing.ans_bpm16=[temp.value(n) double(temp1.value(n))];


%
temp=tango_read_attribute2('ANS-C14/SY/LOCAL.DG.1', 'perteStepDelay');
temp1=tango_read_attribute2('ANS-C14/SY/LOCAL.DG.1', 'perteEvent');
timing.ans_dcct=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.pmStepDelay');
temp1=tango_read_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.pmEvent');
timing.ans_nod=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('ANS-C09/SY/LOCAL.DG.1', 'bpm.pmStepDelay');
temp1=tango_read_attribute2('ANS-C09/SY/LOCAL.DG.1', 'bpm.pmEvent');
timing.ans_nodC09=[temp.value(n) double(temp1.value(n))];



temp=tango_read_attribute2('ANS-C09/SY/LOCAL.DG.1', 'fbt.StepDelay');
temp1=tango_read_attribute2('ANS-C09/SY/LOCAL.DG.1', 'fbt.Event');
timing.ans_fbt=[temp.value(n) double(temp1.value(n))];


% kicker machine
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-hv.pcStepDelay');
temp1=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-hv.pcEvent');
timing.ans_k_hv_pc=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-v.trigStepDelay');
temp1=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-v.trigEvent');
timing.ans_k_v=[temp.value(n) double(temp1.value(n))];

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigStepDelay');
temp1=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigEvent');
timing.ans_k_h=[temp.value(n) double(temp1.value(n))];



% offset
FileName = [DirName 'synchro_offset_lin'];
load(FileName, 'inj_offset' , 'ext_offset', 'lin_fin');

timing.inj_offset=inj_offset;
timing.ext_offset=ext_offset;
timing.lin_fin   =lin_fin;



