%%
%[x, ATIndex, LostBeam] = getturns([.0 0, 0.0, 0, 0.01681, 0.0]', 1000, [1]);
%[x, ATIndex, LostBeam] = getturns([.0 0, 0.0, 0, 0.01677, 0.0]', 1000, [1]);
%[x, ATIndex, LostBeam] = getturns([.0, 0, 0.0, 0, 0.01661, 0.0]', 2000, [1]);
[x, ATIndex, LostBeam] = getturns([1e-6, 0, 1e-6, 0, 0.02571, 0.0]', 1000, [1]);

if LostBeam
    ATIndex
else

figure(11)
plot(x(1,:,6),x(1,:,5)*100,'k'); grid on; hold on
xlabel('ctau')
ylabel('delta (%)')

figure(2)
subplot(2,2,1)
plot(x(1,:,1)*1e3); grid on
xlabel('turn number')
ylabel('x (mm)')

subplot(2,2,2)
plot(x(1,:,3)*1e3); grid on
xlabel('turn number')
ylabel('z (mm)')

subplot(2,2,3)
plot(x(1,:,5)*100); grid on
xlabel('turn number')
ylabel('delta (%)')

subplot(2,2,4)
plot(x(1,:,1)*1e3, x(1,:,2)*1e3,'.'); grid on
xlabel('x (mm)')
ylabel('px (mrad)')

end

%% Compute alpha to all order
physics_mcf;

