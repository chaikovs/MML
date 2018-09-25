% track
xl = [0:0.001:0.02]+1.0e-4;
X0 = zeros(6,length(xl));
X0(1,:)  = xl;
X0(3,:) = 1.0e-4;
Nturn = 256;
X1=ringpass(THERING,X0,1);
X1=ringpass(THERING,X0,256,'reuse');
BPMx=reshape(X1(1,:),length(xl),Nturn);
BPMy=reshape(X1(3,:),length(xl),Nturn);

nuxl = zeros(size(xl));
nuyl = zeros(size(xl));

for ii=1:length(xl)
   [nuxl(ii)] = naff(BPMx(ii,:)');
   [nuyl(ii)] = naff(BPMy(ii,:)');
end

%% plot
figure(11)
reson_plot(1,6,3,1,0.,0.5, 0.0, 0.50);
plot(nuxl, nuyl,'.')

figure(12)
subplot(2,1,1)
plot(xl.^2*1e6, nuxl,'s')
xlabel('x^2 (mm^2'); ylabel('nux')

subplot(2,1,2)
plot(xl.^2*1e6, nuyl,'s')
xlabel('x^2 (mm^2'); ylabel('nuy')

%% fit
[betx0,bety0] = modelbeta('RF');
nfit = 17;
[p,s] = polyfit(xl(1:nfit).^2/betx0, nuxl(1:nfit),1);
dnuxdJx = p(1);
figure(12)
subplot(2,1,1); hold on
plot(xl(1:nfit).^2*1e6, polyval(p,xl(1:nfit).^2/betx0),'r')

[p,s] = polyfit(xl(1:nfit).^2/betx0, nuyl(1:nfit),1);
dnuydJx = p(1);
figure(12)
subplot(2,1,2); hold on
plot(xl(1:nfit).^2*1e6, polyval(p,xl(1:nfit).^2/betx0),'r')

fprintf('[dnux/dJx, dnuy/dJx]=[%5.1f, %5.1f]\n', dnuxdJx, dnuydJx)

%% Now calculate dnudJy

% track
yl = [0:0.0005:0.005]+1.0e-4;
X0 = zeros(6,length(yl));
X0(1,:)  = 1.0e-4;
X0(3,:)  = yl;
Nturn = 256;
X1=ringpass(THERING,X0,1);
X1=ringpass(THERING,X0,256,'reuse');
BPMx=reshape(X1(1,:),length(yl),Nturn);
BPMy=reshape(X1(3,:),length(yl),Nturn);

nuxl = zeros(size(yl));
nuyl = zeros(size(yl));

for ii=1:length(dl)
   [nuxl(ii)] = naff(BPMx(ii,:)');
   [nuyl(ii)] = naff(BPMy(ii,:)');
end

%% plot
figure(21)
reson_plot(1,6,3,1,0.08,0.3, 0.18, 0.30);
plot(nuxl, nuyl,'.')

figure(22)
subplot(2,1,1)
plot(yl.^2*1e6, nuxl,'s')
xlabel('y^2 (mm^2'); ylabel('nux')

subplot(2,1,2)
plot(yl.^2*1e6, nuyl,'s')
xlabel('y^2 (mm^2'); ylabel('nuy')

%% fit

nfit = 10;
[p,s] = polyfit(yl(1:nfit).^2/bety0, nuxl(1:nfit),1);
dnuxdJy = p(1);
figure(22)
subplot(2,1,1); hold on
plot(yl(1:nfit).^2*1e6, polyval(p,yl(1:nfit).^2/bety0),'r')

[p,s] = polyfit(yl(1:nfit).^2/betx0, nuyl(1:nfit),1);
dnuydJy = p(1);
figure(22)
subplot(2,1,2); hold on
plot(yl(1:nfit).^2*1e6, polyval(p,yl(1:nfit).^2/bety0),'r')

fprintf('[dnux/dJy, dnuy/dJy]=[%5.1f, %5.1f]\n', dnuxdJy, dnuydJy)

%% nonlinear chromaticity
global THERING
sp3v82;
rf0 = getrf;
cspeed=299792458;
harm = 372;
rf = harm*cspeed/findspos(THERING,1+length(THERING))/1e6
steprf(rf-rf0);  %or setrf(rf)

%track
mcf = getmcf;
rf0 = getrf;

setcavity off;
%dpl = [-0.03:0.001:0.03];
rfl = [-0.02:0.001:0.02];
dpl = -rfl/rf0/mcf;

X0 = zeros(6,1);
X0(1,:)  = 1.0e-4;
X0(3,:)  = 1.0e-4;

nuxl = zeros(size(rfl));
nuyl = zeros(size(rfl));

Nturn = 256;
for ii=1:length(rfl)
    X0(1,:)  =  1.0e-4;
    X0(3,:)  =  1.0e-4;
    X0(5,:)  =  dpl(ii);
    
    X1=ringpass(THERING,X0,1);
    cnt = 0;
    X1a=ringpass(THERING,X0,32,'reuse');
    X1=X1a;
    cnt = cnt+32;
    while cnt<256
        X1a=ringpass(THERING,X1a(:,end),32,'reuse');

        X1(:,cnt+(1:32)) = X1a;
        X1a(6,end)=0;
        cnt = cnt+32;        
    end
    BPMx=X1(1,:);
    BPMy=X1(3,:);
   [nuxl(ii)] = naff(BPMx',[0.05,0.2]);
   [nuyl(ii)] = naff(BPMy');
end


%% plot
figure(31)
reson_plot(1,6,3,1,0.08,0.3, 0.18, 0.30);
plot(nuxl, nuyl,'.')

figure(32); clf
subplot(2,1,1)
plot(dpl, nuxl,'s')
xlabel('\Delta p/p'); ylabel('nux')

subplot(2,1,2)
plot(dpl, nuyl,'s')
xlabel('\Delta p/p'); ylabel('nuy')

%% fit

nremove = 0;
nfit = length(dpl)-2*nremove;
[p,s] = polyfit(dpl((1:nfit)+nremove), nuxl((1:nfit)+nremove),3);
dnuxdp = p
figure(32)
subplot(2,1,1); hold on
plot(dpl((1:nfit)+nremove), polyval(p,dpl((1:nfit)+nremove)),'r')

[p,s] = polyfit(dpl((1:nfit)+nremove), nuyl((1:nfit)+nremove),3);
dnuydp = p
figure(32)
subplot(2,1,2); hold on
plot(dpl((1:nfit)+nremove), polyval(p,dpl((1:nfit)+nremove)),'r')

fprintf('[dnux/dp, dnuy/dpp]=[%5.1f, %5.1f]\n', dnuxdp(end-1), dnuydp(end-1))
