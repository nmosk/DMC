close all
clc;
clear;

% Main controls
P = 40; %Bar
y0 = 0.035; % O2 concentration at gas inlet (MR of CO to O2)
T = 130; % C
MR = 15; % MeOH to O2 ratio

% flowrate DMC production [mol/hr]
n_DMC = 198000;

% Gas constants
r = 1.987; % cal/mol/K
R = 0.08314; % bar L / mol K

% Henry's constant [bar]
KH_O2 = 3179;
KH_CO = 3107;
KH_C2 = 158;

% molar density [mol/L]
dens_me = 24.7;
dens_w = 55.5; 
dens_dmc = 11.9;

% rate constant expressions
k1 = @(T)((1.4 * 10^11) * exp(-24000./(r*(T+273))))
k2 = @(T)(5.6 * 10^12 * exp(-22700./(r*(T+273))))

% Temperature [C] and rate constants [L/mol/s]-ish
k_1 = k1(T);
k_2 = k2(T);

x0 = [6*10^5;6*10^6;        % L, F_gas_in   [mol/hr]
    100;5*10^6;100;     % F_o2, F_co, F_co2   [mol/hr]
    5*10^5;198000;        % F_me, F_dmc   [mol/hr]
    5;5;              % r1, r2    [mol/L/hr] (converted from s to hr in function code)
    20]                 % density [mol/L]
    
selectivity1 = [];
conversion1 = [];
V = logspace(1.8,3);
for i = 1:50
f = @(x)toms_syst(x,P,y0,KH_O2,dens_me,dens_w,dens_dmc,k_1,k_2,n_DMC,V(i),MR);
%options = optimoptions('fsolve','Display','iter','TolX',10^-10,'MaxIter',1000,'MaxFunEvals',10000)
[x,should_be_zero] = fsolve(f,x0);
solved_DMC_mol_per_hr = x(7);
conv = (x(2) * y0 - x(3)) / ( x(2) * y0 );
sel = x(7) /(2 * (x(2)* y0 - x(3)));
conversion1 = [conversion1;conv];
selectivity1 = [selectivity1;sel];
end


plot(conversion1,selectivity1,'-o')
xlabel('conversion, x'); ylabel('selectivity, s')
title('T = 130, P = 40 bar, y0 = 0.035')
