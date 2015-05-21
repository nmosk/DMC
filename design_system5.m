% gonna set up design equations all 17 !!!
% design eqns with tau
function X = design_system5(x,tau,P,y0,KH_O2,dens_me,dens_co,dens_o2,k_1,k_2,n_DMC,MR)

% Here we go

s_per_hr = 3600; % s/hr


X = [(y0*x(1) - x(5)*x(3) - tau*x(12)*0.5*(x(10)+x(11)).*s_per_hr); % mol/hr
        (tau*x(12)*x(11).*s_per_hr - x(7)*x(3)); % mol/hr
        ((1-y0)*x(1) - x(6)*x(3) - tau*x(12)*(x(11)+x(10))); % mol/hr
        (tau*x(12)*x(10).*s_per_hr - x(8)*x(4)); % mol/hr         %4
        (x(10).*s_per_hr - s_per_hr*k_1*(x(9)^2)*((x(5)*P/KH_O2)^0.5)*(x(12)^5/2)); %rate [=] mol/L/hr
        (x(11).*s_per_hr - s_per_hr*k_2*(x(5)*P*x(12)/KH_O2)^0.5); % mol/L/hr
        (1 - x(9) - 2*x(8));     %unitless       %7
        (x(8)*x(4) - n_DMC); % mol/hr
        (1 - x(5) - x(6) - x(7));    % unitless   %9
        (x(12) - (y0*x(1)/dens_o2 + x(1).*(1-y0)./dens_co + x(2)/dens_me)) %mol/L
        (x(2) - y0*MR*x(1)); % mol/hr
        (x(2) - x(9)*x(4) - 2*x(10).*tau*x(12).*s_per_hr)   %12
        (x(13)- tau*x(12) ) ]  
end
