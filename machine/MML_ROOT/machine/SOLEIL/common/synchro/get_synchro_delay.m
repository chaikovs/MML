function get_synchro_delay(handles)
bug_device='Bug device';
n=1;

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSprTimeDelay');
set(handles.central_spare,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TInjTimeDelay');
set(handles.central_inj,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftTimeDelay');
set(handles.central_soft,'String',num2str(temp.value(n)));
%set(handles.central_soft1,'String',num2str(temp.value(n)));

temp=tango_read_attribute2('ANS/SY/CENTRAL', 'ExtractionOffsetTimeValue');
set(handles.central_ext,'String',num2str(temp.value(n)));



inj_offset=str2double(get(handles.inj_offset,'String'));

temp=tango_read_attribute2('ANS/SY/LOCAL.SDC.1', 'oscTimeDelay');
try ;txt=num2str(temp.value(n)-inj_offset); catch txt=bug_device ; end
set(handles.sdc1,'String',txt);

temp=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'spareTimeDelay');
try ;txt=num2str(temp.value(n)-inj_offset); catch txt=bug_device ; end
set(handles.lin_modulateur,'String',txt);


temp=tango_read_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmTimeDelay');
try ;txt=num2str(temp.value(n)-inj_offset); catch txt=bug_device ; end
set(handles.lin_canon_lpm,'String',txt);


temp=tango_read_attribute2('LIN/SY/LOCAL.SPM.1', 'spmLinacTimeDelay');
try ;txt=num2str(temp.value(n)-inj_offset); catch txt=bug_device ; end
set(handles.lin_canon_spm,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.DG.1', 'bpm-bta.trigTimeDelay');
try ;txt=num2str(temp.value(n)-inj_offset); catch txt=bug_device ; end
set(handles.boo_bpm,'String',txt);

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'emittanceTimeDelay');
try ;txt=num2str(temp.value(n)-inj_offset); catch txt=bug_device ; end
set(handles.lt1_emittance,'String',txt);

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'mc.1TimeDelay');
try ;txt=num2str(temp.value(n)-inj_offset); catch txt=bug_device ; end
set(handles.lt1_MC1,'String',txt);

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'mc.2TimeDelay');
try ;txt=num2str(temp.value(n)-inj_offset); catch txt=bug_device ; end
set(handles.lt1_MC2,'String',txt);

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'oscTimeDelay');
try ;txt=num2str(temp.value(n)-inj_offset); catch txt=bug_device ; end
set(handles.lt1_osc,'String',txt);

temp=tango_read_attribute2('LT1/SY/LOCAL.DG.1', 'dcct-booTimeDelay');
try ;txt=num2str(temp.value(n)-inj_offset); catch txt=bug_device ; end
set(handles.boo_dcct,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.DG.3', 'bpm-onde.trigTimeDelay');
try ;txt=num2str(temp.value(n)-inj_offset); catch txt=bug_device ; end
set(handles.boo_nod,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.Binj.1', 'sep-p.trigTimeDelay');
try ;txt=num2str(temp.value(n)-inj_offset); catch txt=bug_device ; end
set(handles.boo_inj_septum,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.Binj.1', 'k.trigTimeDelay');
try ;txt=num2str(temp.value(n)-inj_offset); catch txt=bug_device ; end
set(handles.boo_inj_kicker,'String',txt);




temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'dpTimeDelay');
try ;txt=num2str(temp.value(n)); catch txt=bug_device ; end
set(handles.boo_alim_dipole,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'qfTimeDelay');
try ;txt=num2str(temp.value(n)); catch txt=bug_device ; end
set(handles.boo_alim_qf,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'qdTimeDelay');
try ;txt=num2str(temp.value(n)); catch txt=bug_device ; end
set(handles.boo_alim_qd,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'sfTimeDelay');
try ;txt=num2str(temp.value(n)); catch txt=bug_device ; end
set(handles.boo_alim_sf,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'sdTimeDelay');
try ;txt=num2str(temp.value(n)); catch txt=bug_device ; end
set(handles.boo_alim_sd,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.RF.1', 'rfTimeDelay');
try ;txt=num2str(temp.value(n)); catch txt=bug_device ; end
set(handles.boo_rf,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.ALIM.1', 'compTimeDelay');
try ;txt=num2str(temp.value(n)); catch txt=bug_device ; end
set(handles.boo_alim_cp,'String',txt);

ext_offset=str2double(get(handles.ext_offset,'String'));


temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'dof.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.boo_ext_dof,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-p.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.boo_ext_sept_p,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.boo_ext_sept_a,'String',txt);

temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'k.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.boo_ext_kicker,'String',txt);

temp=tango_read_attribute2('ANS/SY/LOCAL.SDC.1', 'spareTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.sdc2,'String',txt);
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
temp=tango_read_attribute2('LT2/SY/LOCAL.DG.1', 'mrsvTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.lt2_emittance,'String',txt);
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
temp=tango_read_attribute2('LT2/SY/LOCAL.DG.1', 'osc-fctTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.lt2_osc,'String',txt);
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
temp=tango_read_attribute2('LT2/SY/LOCAL.DG.2', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.lt2_bpm,'String',txt);


temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_inj_k1,'String',txt);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_inj_k2,'String',txt);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_inj_k3,'String',txt);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_inj_k4,'String',txt);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-p.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_inj_sept_p,'String',txt);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_inj_sept_a,'String',txt);

temp=tango_read_attribute2('ANS-C14/SY/LOCAL.DG.1', 'perteTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_dcct,'String',txt);

temp=tango_read_attribute2('ANS-C09/SY/LOCAL.DG.1', 'fbt.TimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_fbt,'String',txt);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.DG.2', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c01,'String',txt);
temp=tango_read_attribute2('ANS-C02/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c02,'String',txt);
temp=tango_read_attribute2('ANS-C03/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c03,'String',txt);
temp=tango_read_attribute2('ANS-C04/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c04,'String',txt);
temp=tango_read_attribute2('ANS-C05/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c05,'String',txt);
temp=tango_read_attribute2('ANS-C06/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c06,'String',txt);
temp=tango_read_attribute2('ANS-C07/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c07,'String',txt);
temp=tango_read_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c08,'String',txt);
temp=tango_read_attribute2('ANS-C09/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c09,'String',txt);
temp=tango_read_attribute2('ANS-C10/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c10,'String',txt);
temp=tango_read_attribute2('ANS-C11/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c11,'String',txt);
temp=tango_read_attribute2('ANS-C12/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c12,'String',txt);
temp=tango_read_attribute2('ANS-C13/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c13,'String',txt);
temp=tango_read_attribute2('ANS-C14/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c14,'String',txt);
temp=tango_read_attribute2('ANS-C15/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c15,'String',txt);
temp=tango_read_attribute2('ANS-C16/SY/LOCAL.DG.1', 'bpm.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_bpm_c16,'String',txt);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_k_h,'String',txt);
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-v.trigTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_k_v,'String',txt);
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-hv.pcTimeDelay');
try ;txt=num2str(temp.value(n)-ext_offset); catch txt=bug_device ; end
set(handles.ans_k_pc,'String',txt);