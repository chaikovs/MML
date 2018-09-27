function get_alpha_bucket_data
% just get setpoint and MRSV and pinhole

% ans setpoint
for iQ = 1:10
    Name = ['Q' num2str(iQ)];
    A = getam((Name),'Online');
    IQ(iQ) = A(1);
end
for iS = 1:10
    Name = ['S' num2str(iS)];
    A = getam((Name),'Online');
    IS(iS) = A(1);
end
IHCOR=getam('HCOR');
IVCOR=getam('VCOR');
machine.QP=IQ;
machine.SX=IS;
machine.CH=IHCOR;
machine.CV=IVCOR;


% ans data
cur=getdcct;
tune=gettune;
Frf =getrf;
X=getx;
Z=getz;
beam.cur=cur;
beam.tune=tune;
beam.Frf=Frf;
beam.X=X;
beam.Z=Z;


% MRSV
temp=tango_read_attribute2('ANS-C01/DG/MRSV-IMAGEANALYZER ','XProj');MRSV_XProj=temp.value;
temp=tango_read_attribute2('ANS-C01/DG/MRSV-IMAGEANALYZER ','InputImage');MRSV_Image=temp.value;
MRSV.Xproj=MRSV_XProj;
MRSV.image=MRSV_Image;


%save data
file=[appendtimestamp('alpha') '.mat'];
save(file, 'machine' ,'beam' ,'MRSV')




