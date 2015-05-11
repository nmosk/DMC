close all

R = 1.987; % cal/mol/K

k1 = @(T)((1.4 * 10^11) * exp(-24000./(R*(T+273))))
k2 = @(T)(5.6 * 10^12 * exp(-22700./R./(T+273)))

temps = 80:130;

plot(temps,100*k1(temps),temps,k2(temps))
xlabel('T (celcius)')
ylabel('k (concentrations/s)')

legend('k1 * 100','k2')
