close all

R = 1.987; % cal/mol/K
mol_dens = 24.7; % mol MeOH/ L MeOH
P = 20; %Bar
y_O2 = 0.02; % O2 concentration

KH_O2 = 3179;

k1 = @(T)((1.4 * 10^11) * exp(-24000./(R*(T+273))))
k2 = @(T)(5.6 * 10^12 * exp(-22700./R./(T+273)))

temp = 80;
k_1 = k1(temp)*mol_dens*mol_dens;
k_2 = k2(temp);

CO2_initial = y_O2 * P * mol_dens / KH_O2



