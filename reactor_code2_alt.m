close all
clc;
clear;

% global r R P y0 KH_O2 KH_CO KH_C2 dens_me dens_w dens_dmc T k_1 k_2 n_DMC tau
r = 1.987; % cal/mol/K
R = 0.08314; % bar L / mol K
P = 10; %Bar
y0 = 0.04; % O2 concentration at inlet

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
T = 90;
k_1 = k1(T);
k_2 = k2(T);

% flowrate DMC production [mol/hr]
n_DMC = 198000;

x0 = [10^7;10^7;10^7;      % flow rates    G,L,E
        0.02;0.88;0.10;      %vapor composition O2, CO,CO2
        0.1;0.8;        % liquid comp       DMC, me
        1;1;        % rates of reaction mol/l/hr, r1,r2
        30]          % molar density

MR = 3; % molar ratio of meOH to O2

selectivity = [];
conversion = [];
res_time_min = [];

for V = 100:200:4000

f = @(x)design_system_alt(x,P,y0,KH_O2,dens_me,dens_w,dens_dmc,k_1,k_2,n_DMC,V,MR)

options = optimoptions('fsolve','Display','iter','TolX',10^-10,...
    'MaxFunEvals',10000)
[x,should_be_zero] = fsolve(f,x0,options)

x = real(x);
solved_DMC_mol_per_hr = x(2)*x(7);
yO2_comps = x(4);
vol = (x(2)*(x(8)/dens_me + x(7)*(1/dens_dmc + 1/dens_w))/3600/V)^-1/60;

conv = (x(1) * y0 - x(3) * x(4)) / ( x(1) * y0 );
sel = (x(2) * x(7)) /(2 * (x(1)* y0 - x(3) * x(4)));

res_time_min = [res_time_min;vol];

conversion = [conversion;conv];
selectivity = [selectivity;sel];

end

res_time_min

plot(conversion,selectivity,'-o')
xlabel('conversion, x'); ylabel('selectivity, s')

