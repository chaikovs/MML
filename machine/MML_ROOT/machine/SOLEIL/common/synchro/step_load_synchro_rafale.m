function load_synchro_rafale(Directory,file,DirName)
%

pwdold = pwd;
cd(Directory);
load(file)
cd(pwdold);


tout=0.;

    display('off set')
    if isfield(timing,'inj_offset');inj_offset=timing.inj_offset;
       if isfield(timing,'ext_offset');ext_offset=timing.ext_offset;
           if isfield(timing,'lin_fin'   );
               
              lin_fin   =timing.lin_fin;
              FileName = [DirName 'synchro_offset_lin'];
              save(FileName, 'inj_offset' , 'ext_offset', 'lin_fin');
              
           end
       end
    end
    display('Clk')
    % set address to value never used (prevent collision when swap adress)
    tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'dof.trigStepDelay',timing.boo_dof_ext(1));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-p.trigStepDelay',timing.boo_sep_p_ext(1));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigStepDelay',timing.boo_sep_a_ext(1));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'k.trigStepDelay',timing.boo_k_ext(1));pause(tout);
    if isfield(timing,'boo_mrsv');tango_write_attribute2('BOO/SY/LOCAL.DG.3', 'emittanceStepDelay',timing.boo_mrsv(1));pause(tout);end
    tango_write_attribute2('LT2/SY/LOCAL.DG.2', 'bpm.trigStepDelay',timing.lt2_bpm(1));pause(tout);
    tango_write_attribute2('LT2/SY/LOCAL.DG.1', 'osc-fctStepDelay',timing.lt2_osc(1));pause(tout);
    tango_write_attribute2('LT2/SY/LOCAL.DG.1', 'mrsvStepDelay',timing.lt2_emittance(1));pause(tout);
    
    tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay',timing.ans_k1_inj(1));pause(tout);
    tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay',timing.ans_k2_inj(1));pause(tout);
    tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay',timing.ans_k3_inj(1));pause(tout);
    tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay',timing.ans_k4_inj(1));pause(tout);
    tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-p.trigStepDelay',timing.ans_sep_p_inj(1));pause(tout);
    tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigStepDelay',timing.ans_sep_a_inj(1));pause(tout);
    tango_write_attribute2('ANS-C01/SY/LOCAL.DG.2', 'bpm.trigStepDelay',timing.ans_bpm01(1));pause(tout);
    tango_write_attribute2('ANS-C02/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm02(1));pause(tout);
    tango_write_attribute2('ANS-C03/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm03(1));pause(tout);
    tango_write_attribute2('ANS-C04/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm04(1));pause(tout);
    tango_write_attribute2('ANS-C05/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm05(1));pause(tout);
    tango_write_attribute2('ANS-C06/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm06(1));pause(tout);
    tango_write_attribute2('ANS-C07/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm07(1));pause(tout);
    tango_write_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm08(1));pause(tout);
    tango_write_attribute2('ANS-C09/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm09(1));pause(tout);
    tango_write_attribute2('ANS-C10/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm10(1));pause(tout);  
    tango_write_attribute2('ANS-C11/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm11(1));pause(tout);  
    tango_write_attribute2('ANS-C12/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm12(1));pause(tout);  
    tango_write_attribute2('ANS-C13/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm13(1));pause(tout);  
    tango_write_attribute2('ANS-C14/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm14(1));pause(tout);  
    tango_write_attribute2('ANS-C15/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm15(1));pause(tout);  
    tango_write_attribute2('ANS-C16/SY/LOCAL.DG.1', 'bpm.trigStepDelay',timing.ans_bpm16(1));pause(tout);   
    tango_write_attribute2('ANS-C13/SY/LOCAL.DG.1', 'dcctStepDelay',timing.ans_dcct(1));pause(tout);  
    if isfield(timing,'ans_nod') ;tango_write_attribute2('ANS-C14/SY/LOCAL.DG.1', 'perteStepDelay',timing.ans_nod(1));pause(tout);end  
   
    
    if isfield(timing,'ans_k_hv_pc') ;tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-hv.pcStepDelay',timing.ans_k_hv_pc(1));pause(tout);end  
    if isfield(timing,'ans_k_v') ;tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-v.trigStepDelay',timing.ans_k_v(1));pause(tout);end  
    if isfield(timing,'ans_k_h') ;tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigStepDelay',timing.ans_k_h(1));pause(tout);end  

    display('Event')
    tango_write_attribute2('ANS/SY/LOCAL.SDC.1', 'oscEvent',int32(timing.sdc1(2)));pause(tout);
    tango_write_attribute2('LIN/SY/LOCAL.LPM.1', 'lpmEvent',int32(timing.lin_lpm(2)));pause(tout);
    tango_write_attribute2('LIN/SY/LOCAL.LPM.1', 'spareEvent',int32(timing.lin_modulateur(2)));
    if isfield(timing,'lin_spm');tango_write_attribute2('LIN/SY/LOCAL.SPM.1', 'spmLinacEvent',int32(timing.lin_spm(2)));pause(tout);end
    if isfield(timing,'lin_alim');tango_write_attribute2('LIN/SY/LOCAL.LPM.1', 'spareEvent',int32(timing.lin_alim(2)));pause(tout);end
    tango_write_attribute2('BOO/SY/LOCAL.DG.1', 'bpm-bta.trigEvent',int32(timing.boo_bpm(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.DG.1', 'bpm-btd.trigEvent',int32(timing.boo_bpm(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.DG.2', 'bpm-btb.trigEvent',int32(timing.boo_bpm(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.DG.3', 'bpm-btc.trigEvent',int32(timing.boo_bpm(2)));pause(tout);     
    tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'emittanceEvent',int32(timing.lt1_emittance(2)));pause(tout);
    tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'mc.1Event',int32(timing.lt1_mc1(2)));pause(tout);
    tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'mc.2Event',int32(timing.lt1_mc2(2)));pause(tout);
    tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'oscEvent',int32(timing.lt1_osc(2)));pause(tout);
    tango_write_attribute2('LT1/SY/LOCAL.DG.1', 'dcct-booEvent',int32(timing.boo_dcct(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.DG.3', 'bpm-onde.trigEvent',int32(timing.boo_nod(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.Binj.1', 'sep-p.trigEvent',int32(timing.boo_sep_p_inj(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.Binj.1', 'k.trigEvent',int32(timing.boo_k_inj(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.ALIM.1', 'dpEvent',int32(timing.boo_dp(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.ALIM.1', 'qfEvent',int32(timing.boo_qf(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.ALIM.1', 'qdEvent',int32(timing.boo_qd(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.ALIM.1', 'sfEvent',int32(timing.boo_sf(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.ALIM.1', 'sdEvent',int32(timing.boo_sd(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.RF.1', 'rfEvent',int32(timing.boo_rf(2)));pause(tout);
    tango_write_attribute2('ANS/SY/LOCAL.SDC.1', 'spareEvent',int32(timing.sdc2(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'dof.trigEvent',int32(timing.boo_dof_ext(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-p.trigEvent',int32(timing.boo_sep_p_ext(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigEvent',int32(timing.boo_sep_a_ext(2)));pause(tout);
    tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'k.trigEvent',int32(timing.boo_k_ext(2)));pause(tout);
    tango_write_attribute2('LT2/SY/LOCAL.DG.2', 'bpm.trigEvent',int32(timing.lt2_bpm(2)));pause(tout);
    tango_write_attribute2('LT2/SY/LOCAL.DG.1', 'osc-fctEvent',int32(timing.lt2_osc(2)));pause(tout);
    tango_write_attribute2('LT2/SY/LOCAL.DG.1', 'mrsvEvent',int32(timing.lt2_emittance(2)));pause(tout);
    if isfield(timing,'boo_mrsv');tango_write_attribute2('BOO/SY/LOCAL.DG.3', 'emittanceEvent',int32(timing.boo_mrsv(2)));pause(tout);end
    arg.svalue={'k1.trig','k2.trig','k3.trig','k4.trig'}; 
    arg.lvalue=int32([timing.ans_k1_inj(2) timing.ans_k2_inj(2) timing.ans_k3_inj(2) timing.ans_k4_inj(2)]); 
    tango_command_inout2('ANS-C01/SY/LOCAL.Ainj.1','SetEventsNumbers',arg);% chagement groupÃ© address sans update
    tango_command_inout2('ANS-C01/SY/LOCAL.Ainj.1', 'Update');pause(tout);
    
    arg.svalue={'sep-p.trig','sep-a.trig'};
    arg.lvalue=int32([timing.ans_sep_p_inj(2) timing.ans_sep_a_inj(2)]);
    tango_command_inout2('ANS-C01/SY/LOCAL.Ainj.2','SetEventsNumbers',arg);% chagement groupÃ© address sans update
    tango_command_inout2('ANS-C01/SY/LOCAL.Ainj.2', 'Update');pause(tout);
   
    
    tango_write_attribute2('ANS-C01/SY/LOCAL.DG.2', 'bpm.trigEvent',int32(timing.ans_bpm01(2)));pause(tout);
    tango_write_attribute2('ANS-C02/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm02(2)));pause(tout);
    tango_write_attribute2('ANS-C03/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm03(2)));pause(tout);
    tango_write_attribute2('ANS-C04/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm04(2)));pause(tout);
    tango_write_attribute2('ANS-C05/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm05(2)));pause(tout);
    tango_write_attribute2('ANS-C06/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm06(2)));pause(tout);
    tango_write_attribute2('ANS-C07/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm07(2)));pause(tout);
    tango_write_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm08(2)));pause(tout);
    tango_write_attribute2('ANS-C09/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm09(2)));pause(tout);
    tango_write_attribute2('ANS-C10/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm10(2)));pause(tout);  
    tango_write_attribute2('ANS-C11/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm11(2)));pause(tout);  
    tango_write_attribute2('ANS-C12/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm12(2)));pause(tout);  
    tango_write_attribute2('ANS-C13/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm13(2)));pause(tout);  
    tango_write_attribute2('ANS-C14/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm14(2)));pause(tout);  
    tango_write_attribute2('ANS-C15/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm15(2)));pause(tout);  
    tango_write_attribute2('ANS-C16/SY/LOCAL.DG.1', 'bpm.trigEvent',int32(timing.ans_bpm16(2)));pause(tout);   
    tango_write_attribute2('ANS-C13/SY/LOCAL.DG.1', 'dcctEvent',int32(timing.ans_dcct(2)));pause(tout);
    if isfield(timing,'ans_nod') ;tango_write_attribute2('ANS-C14/SY/LOCAL.DG.1', 'perteEvent',int32(timing.ans_nod(2)));pause(tout);end  
    
    if isfield(timing,'ans_k_hv_pc') ;tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-hv.pcEvent',int32(timing.ans_k_hv_pc(2)));pause(tout);end  
    if isfield(timing,'ans_k_v') ;tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-v.trigEvent',int32(timing.ans_k_v(2)));pause(tout);end  
    if isfield(timing,'ans_k_h') ;tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigEvent',int32(timing.ans_k_h(2)));pause(tout);end  
    
    % apply good value
    tango_write_attribute2('ANS/SY/CENTRAL', 'TPcStepDelay',timing.central_pc);
    tango_write_attribute2('ANS/SY/CENTRAL', 'TInjStepDelay',timing.central_inj);
    tango_write_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay',timing.central_soft);
    tango_write_attribute2('ANS/SY/CENTRAL', 'TSprStepDelay',timing.central_spare);
    tango_write_attribute2('ANS/SY/CENTRAL', 'ExtractionOffsetClkStepValue',timing.central_ext);
 
    
display('OK')


