r=1.01;

% get the DOF
temp=tango_read_attribute2('BOO-C10/EP/AL_DOF.1', 'voltagePeakValue');
dof1=temp.value(2)

temp=tango_read_attribute2('BOO-C11/EP/AL_DOF.2', 'voltagePeakValue');
dof2=temp.value(2)

temp=tango_read_attribute2('BOO-C12/EP/AL_DOF.3', 'voltagePeakValue');
dof3=temp.value(2)

% scale the DOF
tango_write_attribute2('BOO-C10/EP/AL_DOF.1', 'voltagePeakValue',dof1*r );
tango_write_attribute2('BOO-C11/EP/AL_DOF.2', 'voltagePeakValue',dof2*r);
tango_write_attribute2('BOO-C12/EP/AL_DOF.3', 'voltagePeakValue',dof3*r);















