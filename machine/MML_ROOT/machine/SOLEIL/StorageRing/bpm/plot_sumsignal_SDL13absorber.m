function plot_sumsignal_SDL13absorber
% plot sum signal along the machine for several turns
% Absorber inserted and -6mm H and 2 mm V, the beam is lost at injection in
% 2 turns

spos = getspos('BPMx');
[X Z Sum ] = getbpmrawdata;
figure(99);
clf

ax(1) = subplot(5,1,1:4);
plot(spos, Sum(:,9:11));
title('Sum signal along the ring')

xlabel('s-position');
ylabel('Sum signal');
ax(2) = subplot(5,1,5);
drawlattice;
linkaxes(ax, 'x')


%plot(Sum(:,8:11))
%plot(Sum(:,1:17))