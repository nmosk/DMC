close all

load('sensitivity_analysis.mat')

%price changes in reactants and product
%NPV_0
figure
subplot(2,1,1)
plot(co_price_sens_analysis(:,1),co_price_sens_analysis(:,2),...
        O2_price_sens_analysis(:,1),O2_price_sens_analysis(:,2),...
        meoh_price_sens_analysis(:,1),meoh_price_sens_analysis(:,2),...
       dmc_price_sens_analysis(:,1),dmc_price_sens_analysis(:,2),'LineWidth',3)
ylabel('Net Present Value  [$]')
   xlabel('Percent Change in Price [%]')
   legend('CO','O_2','MeOH','DMC')
set(gca,'FontSize',26)
%NPV_percent
subplot(2,1,2)
plot(co_price_sens_analysis(:,1),co_price_sens_analysis(:,3),...
O2_price_sens_analysis(:,1),O2_price_sens_analysis(:,3),...
meoh_price_sens_analysis(:,1),meoh_price_sens_analysis(:,3),...
    dmc_price_sens_analysis(:,1),dmc_price_sens_analysis(:,3),'LineWidth',3)
axis([-50 50 -15 15])
ylabel('Net Present Value Percent [%]')
xlabel('Percent Change in Price [%]')
legend('CO','O_2','MeOH','DMC')
set(gca,'FontSize',26)

%% construction rate
figure
subplot(2,1,1)
plot(Const_rate_sens_anal(:,1),Const_rate_sens_anal(:,2),'LineWidth',3)
ylabel('Net Present Value  [$]')
xlabel('Change in Rate [%]')
set(gca,'FontSize',26)
subplot(2,1,2)
plot(Const_rate_sens_anal(:,1),Const_rate_sens_anal(:,3),'LineWidth',3)
ylabel('Net Present Value Percent [%]')
xlabel('Change in Rate [%]')
set(gca,'FontSize',26)

%% Enterprise Rate 
figure
subplot(2,1,1)
plot(ER_sens_analysis (:,1),ER_sens_analysis (:,2),'LineWidth',3)
ylabel('Net Present Value  [$]')
xlabel('Change in Rate [%]')
set(gca,'FontSize',26)
subplot(2,1,2)
plot(ER_sens_analysis (:,1),ER_sens_analysis (:,3),'LineWidth',3)
ylabel('Net Present Value Percent [%]')
xlabel('Change in Rate [%]')
set(gca,'FontSize',26)

%% Finance Rate

figure
subplot(2,1,1)
plot(fin_rate_sens_analysis(:,1),fin_rate_sens_analysis (:,2),'LineWidth',3)
ylabel('Net Present Value  [$]')
xlabel('Change in Rate [%]')
set(gca,'FontSize',26)
subplot(2,1,2)
plot(fin_rate_sens_analysis(:,1),fin_rate_sens_analysis(:,3),'LineWidth',3)
ylabel('Net Present Value Percent [%]')
xlabel('Change in Rate [%]')
set(gca,'FontSize',26)

%% Tax Rate

figure
subplot(2,1,1)
plot(tax_rate_sens_anaysis(:,1),tax_rate_sens_anaysis (:,2),'LineWidth',3)
ylabel('Net Present Value  [$]')
xlabel('Change in Rate [%]')
set(gca,'FontSize',26)
subplot(2,1,2)
plot(tax_rate_sens_anaysis(:,1),tax_rate_sens_anaysis(:,3),'LineWidth',3)
ylabel('Net Present Value Percent [%]')
xlabel('Change in Rate [%]')
set(gca,'FontSize',26)