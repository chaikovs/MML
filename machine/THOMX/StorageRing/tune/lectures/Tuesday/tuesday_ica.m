
addpath(['ICA' filesep 'mfile'])

filename = 'data_noqerr_noise.mat';
[meas_psix,meas_psiy,meas_betx,meas_bety] = icatest(filename);

figure(102);
subplot(2,1,1); hold on;
plot(MuX0, (meas_psix-meas_psix(1)-MuX0+MuX0(1))/2/pi,'m.-');
xlabel('Phase X'); ylabel('\Delta phase X');

subplot(2,1,2); hold on;
plot(MuY0, (meas_psiy-meas_psiy(1)-MuY0+MuY0(1))/2/pi,'m.-');
xlabel('Phase Y'); ylabel('\Delta phase Y');


%% data with quad err and noise
filename = 'data_quaderr_noise.mat';
[meas_psix,meas_psiy,meas_betx,meas_bety] = icatest(filename);

figure(102);
subplot(2,1,1); hold on;
plot(MuX0, (meas_psix-meas_psix(1)-MuX0+MuX0(1))/2/pi,'c.-');
xlabel('Phase X'); ylabel('\Delta phase X');
legend('noise free','with noise','quad err actual','noise+quad error','ica,w/ noise','ica, qerr w/noisi')

subplot(2,1,2); hold on;
plot(MuY0, (meas_psiy-meas_psiy(1)-MuY0+MuY0(1))/2/pi,'c.-');
xlabel('Phase Y'); ylabel('\Delta phase Y');
% legend('noise free','with noise','quad err actual','noise+quad error','ica,w/ noise','ica, qerr w/noisi')