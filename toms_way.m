close all
clc;
clear;

r = 1.987; % cal/mol/K
R = 0.08314; % bar L / mol K
P = 10; %Bar
y0 = 0.03; % O2 concentration at gas inlet (MR of CO to O2)

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
T = 80;
k_1 = k1(T);
k_2 = k2(T);

% flowrate DMC production [mol/hr]
n_DMC = 198000;

x0 = [6*10^5;6*10^6;        % L, F_gas_in   [mol/hr]
    100;5*10^6;100;     % F_o2, F_co, F_co2   [mol/hr]
    5*10^5;198000;        % F_me, F_dmc   [mol/hr]
    5;5;              % r1, r2    [mol/L/hr] (converted from s to hr in function code)
    20]                 % density [mol/L]
    
MR = 4; % molar ratio of meOH to O2

selectivity = [];
conversion = [];

for V = 12000:1000:50000

f = @(x)toms_syst(x,P,y0,KH_O2,dens_me,dens_w,dens_dmc,k_1,k_2,n_DMC,V,MR)

%options = optimoptions('fsolve','Display','iter','TolX',10^-10,'MaxIter',1000,'MaxFunEvals',10000)
[x,should_be_zero] = fsolve(f,x0)

solved_DMC_mol_per_hr = x(7);

conv = (x(2) * y0 - x(3)) / ( x(2) * y0 );
sel = x(7) /(2 * (x(2)* y0 - x(3)));

conversion = [conversion;conv];
selectivity = [selectivity;sel];

end

plot(conversion,selectivity,'-o')
xlabel('conversion, x'); ylabel('selectivity, s')

