function  [q1,q2,n]=getcharge(q1,q2,n)
% calcul efficacité

temp=tango_read_attribute2('LT1/DG/MC','qIct2');        lt1charge=temp.value;
%temp=tango_read_attribute2('BOO-C01/DG/DCCT','qExt');   boocharge=-temp.value;
temp=tango_read_attribute2('BOO-C01/DG/DCCT','iExtRaw');   boocharge=-temp.value/352*184;
temp=tango_read_attribute2('BOO-C01/DG/DCCT','iOffset');   boooffset=-temp.value/352*184;
q1=q1+lt1charge ;
q2=q2+(boocharge-boooffset);  %  offset 0.15 le 5-5-2008     0.09 avant 
n=n+1;

