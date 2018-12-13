function plot_6D_long_profile_surfLWFA_transmision(phasespace0,phasespace1,qm,Ef,nbin,fignum)
% Plot profile in LWFA fashion : Divergence vs Energy

num=100;
if (nargin==6);num=fignum;end

nsige=3;
%nsigd=6;

% phasespace0
[gs0,~, ~, ~,cur0]=bunch_statistics_slice(phasespace0,qm,nbin,nsige,6);
[gs1,~, ~, ~,cur1]=bunch_statistics_slice(phasespace1,qm,nbin,nsige,6);

figure(num)
set(gca,'FontSize',16)
set(gcf,'color','w')
plot((gs0*Ef+Ef), cur0,'-b','linewidth',2) ; hold on
plot((gs1*Ef+Ef), cur1,'-r','linewidth',2) ; hold off
set(gca,'yticklabel','')
xlabel('E (MeV)');ylabel('u. a.');
legend('In','Out')
grid on





