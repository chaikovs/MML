%%
df= [-10 -5 0 5 10]/getrf('Physics');
dfs = [860 840 780 750 670];

%getrf/416*1e6*sqrt(416*2e6*0.8856/2/pi/getenergy/1e9)

y = power(dfs,4)/power(1.7518e5,4);


figure(5)
plot(df,y);

an = polyfit(df,y,1);
grid on
%%
fprintf('alpha1 = %3.2e alpha2 = %3.2e \n', sqrt(an(end)), -an(end-1)/4)

