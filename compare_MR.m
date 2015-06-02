close all
clc;
clear;

r = 1.987; % cal/mol/K
R = 0.08314; % bar L / mol K
P = 25; %Bar
y0 = 0.01; % O2 concentration at gas inlet (MR of CO to O2)

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
T = 90;
k_1 = k1(T);
k_2 = k2(T);

% flowrate DMC production [mol/hr]
n_DMC = 198000;

x0 = [6*10^5;6*10^6;        % L, F_gas_in   [mol/hr]
    100;5*10^6;100;     % F_o2, F_co, F_co2   [mol/hr]
    5*10^5;198000;        % F_me, F_dmc   [mol/hr]
    5;5;              % r1, r2    [mol/L/hr] (converted from s to hr in function code)
    20]                 % density [mol/L]
    
MR = 20; % molar ratio of meOH to O2
selectivity1 = [];
conversion1 = [];
V = logspace(3.6,5);
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

MR = 2; % molar ratio of meOH to O2
selectivity2 = [];
conversion2 = [];
V = logspace(3.6,5.2);
for i = 1:50
f = @(x)toms_syst(x,P,y0,KH_O2,dens_me,dens_w,dens_dmc,k_1,k_2,n_DMC,V(i),MR);
%options = optimoptions('fsolve','Display','iter','TolX',10^-10,'MaxIter',1000,'MaxFunEvals',10000)
[x,should_be_zero] = fsolve(f,x0);
solved_DMC_mol_per_hr = x(7);
conv = (x(2) * y0 - x(3)) / ( x(2) * y0 );
sel = x(7) /(2 * (x(2)* y0 - x(3)));
conversion2 = [conversion2;conv];
selectivity2 = [selectivity2;sel];
end

MR = 8; % molar ratio of meOH to O2
selectivity3 = [];
conversion3 = [];
V = logspace(3.6,5.2);
for i = 1:50
f = @(x)toms_syst(x,P,y0,KH_O2,dens_me,dens_w,dens_dmc,k_1,k_2,n_DMC,V(i),MR);
%options = optimoptions('fsolve','Display','iter','TolX',10^-10,'MaxIter',1000,'MaxFunEvals',10000)
[x,should_be_zero] = fsolve(f,x0);
solved_DMC_mol_per_hr = x(7);
conv = (x(2) * y0 - x(3)) / ( x(2) * y0 );
sel = x(7) /(2 * (x(2)* y0 - x(3)));
conversion3 = [conversion3;conv];
selectivity3 = [selectivity3;sel];
end

MR = 14; % molar ratio of meOH to O2
selectivity4 = [];
conversion4 = [];
V = logspace(3.6,5.2);
for i = 1:50
f = @(x)toms_syst(x,P,y0,KH_O2,dens_me,dens_w,dens_dmc,k_1,k_2,n_DMC,V(i),MR);
%options = optimoptions('fsolve','Display','iter','TolX',10^-10,'MaxIter',1000,'MaxFunEvals',10000)
[x,should_be_zero] = fsolve(f,x0);
solved_DMC_mol_per_hr = x(7);
conv = (x(2) * y0 - x(3)) / ( x(2) * y0 );
sel = x(7) /(2 * (x(2)* y0 - x(3)));
conversion4 = [conversion4;conv];
selectivity4 = [selectivity4;sel];
end

plot(conversion1,selectivity1,'-o',conversion2,selectivity2,'-d',conversion3,selectivity3,'-v',...
    conversion4,selectivity4,'-s','LineWidth',2)
xlabel('Conversion, X'); ylabel('Selectivity, S')
title('T = 90, P = 25 bar, y0 = 0.01')
 set(gca,'FontSize',26)
 line([0.55 0.55], ylim,'Color','r','LineStyle','--','LineWidth',3);
 
figure(2)
plot(conversion1,V,'-o',conversion2,V,'-d',conversion3,V,'-v',...
    conversion4,V,'-s','LineWidth',2)
xlabel('conversion, X'); ylabel('Volume, V [L]')
title('T = 90, P = 25 bar, y0 = 0.01')
legend('MR = 20','MR = 2','MR = 8','MR = 14','Location','Northwest')
 set(gca,'FontSize',26)
 line([0.55 .55], ylim,'Color','r','LineStyle','--','LineWidth',3);