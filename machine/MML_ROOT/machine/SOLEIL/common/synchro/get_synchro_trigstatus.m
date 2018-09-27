function get_synchro_trigstatus(handles)

n=1;

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSprTimeDelay');
set(handles.central_spare,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TInjTimeDelay');
set(handles.central_inj,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftTimeDelay');
%set(handles.central_soft,'String',num2str(temp.value(n)));

temp=tango_read_attribute('ANS/SY/CENTRAL', 'ExtractionOffsetTimeValue');
set(handles.central_ext,'String',num2str(temp.value(n)));



temp=tango_read_attribute2('ANS/SY/LOCAL.SDC.1', 'oscTrigStatus');
set(handles.sdc1,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmTrigStatus');
set(handles.lin_canon_lpm,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.DG.1', 'bpm-bta.trigTrigStatus');
set(handles.boo_bpm,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'emittanceTrigStatus');
set(handles.lt1_emittance,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'mc.1TrigStatus');
set(handles.lt1_MC1,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'mc.2TrigStatus');
set(handles.lt1_MC2,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'oscTrigStatus');
set(handles.lt1_osc,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'dcct-booTrigStatus');
set(handles.boo_dcct,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.DG.3', 'bpm-onde.trigTrigStatus');
set(handles.boo_nod,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.Binj.1', 'sep-p.trigTrigStatus');
set(handles.boo_inj_septum,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.Binj.1', 'k.trigTrigStatus');
set(handles.boo_inj_kicker,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'dpTrigStatus');
set(handles.boo_alim_dipole,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'qfTrigStatus');
set(handles.boo_alim_qf,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'qdTrigStatus');
set(handles.boo_alim_qd,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'sfTrigStatus');
set(handles.boo_alim_sf,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'sdTrigStatus');
set(handles.boo_alim_sd,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.RF.1', 'rfTrigStatus');
set(handles.boo_rf,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'compTrigStatus');
set(handles.boo_alim_cp,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'spareTrigStatus');
set(handles.lin_modulateur,'String',num2str(temp.value(n)));





temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'dof.trigTrigStatus');
set(handles.boo_ext_dof,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-p.trigTrigStatus');
set(handles.boo_ext_sept_p,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigTrigStatus');
set(handles.boo_ext_sept_a,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'k.trigTrigStatus');
set(handles.boo_ext_kicker,'String',num2str(temp.value(n)));



temp=tango_read_attribute2('ANS/SY/LOCAL.SDC.1', 'spareTrigStatus');
set(handles.sdc2,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('LT2/SY/LOCAL.DG.1', 'mrsvTrigStatus');
set(handles.lt2_emittance,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('LT2/SY/LOCAL.DG.1', 'osc-fctTrigStatus');
set(handles.lt2_osc,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('LT2/SY/LOCAL.DG.2', 'bpm.trigTrigStatus');
set(handles.lt2_bpm,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigTrigStatus');
set(handles.ans_inj_k1,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigTrigStatus');
set(handles.ans_inj_k2,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigTrigStatus');
set(handles.ans_inj_k3,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigTrigStatus');
set(handles.ans_inj_k4,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-p.trigTrigStatus');
set(handles.ans_inj_sept_p,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigTrigStatus');
set(handles.ans_inj_sept_a,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS-C14/SY/LOCAL.DG.1', 'perteTrigStatus');
set(handles.ans_dcct,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS-C09/SY/LOCAL.DG.1', 'fbt.TrigStatus');
set(handles.ans_fbt,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.pmTrigStatus');
set(handles.ans_nod,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.DG.2', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c01,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C02/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c02,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C03/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c03,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C04/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c04,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C05/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c05,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C06/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c06,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C07/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c07,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c08,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C09/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c09,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C10/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c10,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C11/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c11,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C12/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c12,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C13/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c13,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C14/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c14,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C15/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c15,'String',num2str(temp.value(n)));
temp=tango_read_attribute2('ANS-C16/SY/LOCAL.DG.1', 'bpm.trigTrigStatus');
set(handles.ans_bpm_c16,'String',num2str(temp.value(n)));