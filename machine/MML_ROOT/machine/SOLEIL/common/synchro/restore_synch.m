function restore_synch

tango_write_attribute2('BOO/SY/LOCAL.Bext.1', 'k.trigStepDelay',31522105);


FileName = fullfile(getfamilydata('Directory', 'Synchro'), 'synchro_offset_lin');
load(FileName, 'inj_offset' , 'ext_offset', 'lin_fin');
ext_offset=179000;
save(FileName, 'inj_offset' , 'ext_offset', 'lin_fin');