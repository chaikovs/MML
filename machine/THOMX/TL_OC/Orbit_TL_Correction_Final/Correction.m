stepsp('HCOR',DeltaAmps1,'Model');
stepsp('VCOR',DeltaAmps2,'Model');
a2=linepass(THERING,Rin,1:length(THERING)+1);
plot(S1,a2(1,:)*1e3,'b-o',S1,a(1,:)*1e3,'g-*');
figure(2);
plot(S1,a2(3,:)*1e3,'b-o',S1,a(3,:)*1e3,'g-*');