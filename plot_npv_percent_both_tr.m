 figure
 plot(NPV_percent_both_tr(:,1),NPV_percent_both_tr(:,2),NPV_percent_both_tr(:,1),NPV_percent_both_tr(:,3),'LineWidth',3)
 xlabel('Conversion')
 ylabel('Net Present Value Percent [%]')
 set(gca,'FontSize',35)
 line([0.55 0.55], ylim,'Color','r','LineStyle','--','LineWidth',3);
