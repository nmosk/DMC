
toms_way;

conversion = conversion(5:n - 20);
selectivity = selectivity(5:n - 20);

MR2 = (1-y0)/y0;

feed_O2 = 0.5 * n_DMC ./ selectivity;
reactor_O2 = 0.5 * n_DMC ./ (selectivity.*conversion);
recycle_O2 = (1-conversion) .* n_DMC ./ (2 * selectivity.* conversion);

recycle_CO = n_DMC .* (MR2 - 2*conversion) ./ (2*conversion.*selectivity);
reactor_CO = MR2 * 0.5 * n_DMC ./ (selectivity.*conversion);
feed_CO = n_DMC ./ selectivity;

reactor_MeOH = MR * n_DMC * 0.5 ./ (selectivity.*conversion);
recycle_MeOH = (MR*0.5./(selectivity.*conversion) - 2) * n_DMC;
feed_MeOH = 2 * n_DMC * ones(size(conversion));

water_product = n_DMC * ones(size(conversion));
CO2_product = n_DMC * (1 - selectivity)./selectivity;

figure(3)
plot(conversion,feed_O2,'-o',conversion,reactor_O2,'-d',conversion,recycle_O2,'-v')
legend('Fresh 02','Reactor O2','Recycle O2')
xlabel('conversion, x');
ylabel('flowrates O2 [mol/hr]');

figure(4)
plot(conversion,feed_CO,'-o',conversion,reactor_CO,'-d',conversion,recycle_CO,'-v')
legend('Fresh CO','Reactor CO','Recycle CO')
xlabel('conversion, x');
ylabel('flowrates CO [mol/hr]');

figure(5)
plot(conversion,feed_MeOH,'-o',conversion,reactor_MeOH,'-d',conversion,recycle_MeOH,'-v')
legend('Fresh MeOH','Reactor MeOH','Recycle MeOH')
xlabel('conversion, x');
ylabel('flowrates MeOH [mol/hr]');

x_set = 12;

disp('Conversion =')
disp(conversion(x_set))
disp('Volume [L] =')
disp(V(x_set))

disp('Flow to plant:')
feed_O2_mol_hr = feed_O2(x_set)
feed_CO_mol_hr = feed_CO(x_set)
feed_MeOH_mol_hr = feed_MeOH(x_set)

disp('Recycle Flows:')
recycle_O2_mol_hr = recycle_O2(x_set)
recycle_CO_mol_hr = recycle_CO(x_set) 
recycle_MeOH_mol_hr = recycle_MeOH(x_set)

disp('Reactor Inlet Flows:')
reactor_O2_mol_hr = reactor_O2(x_set)
reactor_CO_mol_hr = reactor_CO(x_set)
reactor_MeOH_mol_hr = reactor_MeOH(x_set)

disp('Product & By-product flows:')
DMC_product_mol_hr = n_DMC
water_product_mol_hr = n_DMC
CO2_product_mol_hr = CO2_product(x_set)

 