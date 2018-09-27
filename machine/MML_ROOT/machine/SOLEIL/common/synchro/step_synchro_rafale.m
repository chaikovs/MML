function step_synchro_rafale(DirName)
% step central and delay on address 3 only

 n=1;
% % central
% temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TPcStepDelay');
% timing.central_pc=temp.value(n);
% 
% temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TInjStepDelay');
% timing.central_inj=temp.value(n);
% 
% temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSoftStepDelay');
% timing.central_soft=temp.value(n);
% 
% temp=tango_read_attribute2('ANS/SY/CENTRAL', 'TSprStepDelay');
% timing.central_spare=temp.value(n);
% 
% temp=tango_read_attribute2('ANS/SY/CENTRAL', 'ExtractionOffsetClkStepValue');
% timing.central_ext=temp.value(n);

offsettime=70000;
offset=176*offsettime;


% ext on add 3

temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'dof.trigStepDelay');
tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'dof.trigStepDelay',temp.value(1)+offset);


temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-p.trigStepDelay');
tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-p.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigStepDelay');
tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'sep-a.trigStepDelay',temp.value(1)+offset);


temp=tango_read_attribute2('BOO/SY/LOCAL.Bext.1', 'k.trigStepDelay');
tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'k.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS/SY/LOCAL.SDC.1', 'spareStepDelay');
tango_write_attribute2('ANS/SY/LOCAL.SDC.1', 'spareStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('BOO/SY/LOCAL.DG.3', 'emittanceTimeDelay');
tango_write_attribute2('BOO/SY/LOCAL.DG.3', 'emittanceTimeDelay',temp.value(1)+offset);

% LT2
temp=tango_read_attribute2('LT2/SY/LOCAL.DG.1', 'mrsvStepDelay');
tango_write_attribute2('LT2/SY/LOCAL.DG.1', 'mrsvStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('LT2/SY/LOCAL.DG.1', 'osc-fctStepDelay');
tango_write_attribute2('LT2/SY/LOCAL.DG.1', 'osc-fctStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('LT2/SY/LOCAL.DG.2', 'bpm.trigStepDelay');
tango_write_attribute2('LT2/SY/LOCAL.DG.2', 'bpm.trigStepDelay',temp.value(1)+offset);

% ANS
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay');
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k1.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay');
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k2.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay');
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k3.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay');
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.1', 'k4.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-p.trigStepDelay');
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-p.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigStepDelay');
tango_write_attribute2('ANS-C01/SY/LOCAL.Ainj.2', 'sep-a.trigStepDelay',temp.value(1)+offset);


temp=tango_read_attribute2('ANS-C01/SY/LOCAL.DG.2', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C01/SY/LOCAL.DG.2', 'bpm.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C02/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C02/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C03/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C03/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C04/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C04/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C05/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C05/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C06/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C06/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);


temp=tango_read_attribute2('ANS-C07/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C07/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C08/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C09/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C09/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C10/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C10/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C11/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C11/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C12/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C12/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C13/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C13/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C14/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C14/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C15/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C15/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);


temp=tango_read_attribute2('ANS-C16/SY/LOCAL.DG.1', 'bpm.trigStepDelay');
tango_write_attribute2('ANS-C16/SY/LOCAL.DG.1', 'bpm.trigStepDelay',temp.value(1)+offset);

%
temp=tango_read_attribute2('ANS-C13/SY/LOCAL.DG.1', 'dcctStepDelay');
tango_write_attribute2('ANS-C13/SY/LOCAL.DG.1', 'dcctStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C14/SY/LOCAL.DG.1', 'perteTimeDelay');
tango_write_attribute2('ANS-C14/SY/LOCAL.DG.1', 'perteTimeDelay',temp.value(1)+offset);

% kicker machine
temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-hv.pcStepDelay');
tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-hv.pcStepDelay',temp.value(1)+offset);


temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-v.trigStepDelay');
tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-v.trigStepDelay',temp.value(1)+offset);

temp=tango_read_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigStepDelay');
tango_write_attribute2('ANS-C01/SY/LOCAL.EP.1', 'k-h.trigStepDelay',temp.value(1)+offset);


% offset
FileName = [DirName 'synchro_offset_lin'];
load(FileName, 'inj_offset' , 'ext_offset', 'lin_fin');
ext_offset=ext_offset+offsettime;
save(FileName, 'inj_offset' , 'ext_offset', 'lin_fin');


