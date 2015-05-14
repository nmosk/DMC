close all

r = 1.987; % cal/mol/K
R = 0.08314; % bar L / mol K
P = 20; %Bar
y0 = 0.02; % O2 concentration at inlet

% Henry's constant [bar]
KH_O2 = 3179;
KH_CO = 3107;
KH_C2 = 158;

% molar density [mol/L]
dens_me = 24.7;
dens_w = 55.5; 
dens_dmc = 11.9;

k1 = @(T)((1.4 * 10^11) * exp(-24000./(r*(T+273))))
k2 = @(T)(5.6 * 10^12 * exp(-22700./r./(T+273)))

% Temperature [C] and rate constants [L/mol/s]
T = 80;
k_1 = k1(T);
k_2 = k2(T);

% flowrate DMC production [kmol/hr]
n_DMC = 198;



