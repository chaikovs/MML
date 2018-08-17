global THERING
BENDI = findcells(THERING,'FamName','BEND')

sigmafielderor = 0.0001;
dBB = sigmafielderor*randn(1,length(BENDI)+6);

%P = perms(14);
C = nchoosek(14,8);
%Cwr = combinator(14,8,'c','r');  % Combinations with repetition
Cwor = combinator(14,8,'c');   


for icomb = 1:1
    perm_comb = perms(Cwor(icomb,:));
    
    for iperm = 1:length(perm_comb)
    
    for i = 1:length(BENDI)
        
        THERING{BENDI(i)}.ByError = dBB(i);
        %THERING{BENDI(i)}.ByError = fielderor(perm_comb(iperm,i));
        
    end
    
    [spos, orbit] = get_orbit;
    
    
    sorting_res_spos{icomb}(iperm,:) = spos;
    sorting_res_orbit{icomb}{iperm} = orbit;
    sorting_res_rms{icomb}(iperm) = rms(orbit(1,:));
    sorting_res_perm{icomb}(iperm,:) = perm_comb(iperm,:);
    sorting_res_max{icomb}(iperm) = max(abs(orbit(1,:)));
%     
    
%     sorting_res{1}(icomb,:) = spos;
%     sorting_res{2}{icomb} = orbit;
%     sorting_res{3}(icomb,1) = rms(orbit(1,:));
%     sorting_res{3}(icomb,2) = rms(orbit(3,:));
%     sorting_res{4}(icomb,:) = Cwor(icomb,:);
%     sorting_res{5}(icomb,1) = max(abs(orbit(1,:)));
%     sorting_res{5}(icomb,2) = max(abs(orbit(3,:)));
        
    end
      
end

%THERING{10}.ByError = dBB

 %% Plotting
 
figure(1)
h1 = subplot(2,1,1);
set(gca,'FontSize',14)
plot(1:40320,1e3*sorting_res_rms{1}(:),'.-r', 'Markersize',10)
xlabel('Permutation number')
ylabel('COD RMS [mm]');
title('AT Storage Ring Horizontal Orbit ');
h2 = subplot(2,1,2);
set(gca,'FontSize',14)
plot(1:40320,1e3*sorting_res_max{1}(:),'.-b', 'Markersize',10)
xlabel('Permutation number')
ylabel('COD Max [mm]');


%%
[val1 perm_number1] = min(1e3*sorting_res_rms{1}(:))

[val2 perm_number2] = min(1e3*sorting_res_max{1}(:))



