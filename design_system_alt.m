% gonna set up design equations all 17 !!!

function X = design_system_alt(x,P,y0,KH_O2,dens_me,dens_w,dens_dmc,k_1,k_2,n_DMC,V,MR)

% Here we go

s_per_hr = 3600;

X = [(y0*x(1) - x(4)*x(3) - V*0.5*(x(9)+x(10))); %1 mol/hr
        (V*x(10) - x(6)*x(3));                  %2 mol/hr
        ((1-y0)*x(1) - x(5)*x(3) - V*(x(10)+x(9)));    %3 mol/hr
        (x(9) - s_per_hr*k_1*(x(8)^2)*((x(4)*P/KH_O2)^0.5)*(x(11)^(5/2))); %rate [=] mol/L/hr
        (x(10) - s_per_hr*k_2*(x(4)*P*x(11)/KH_O2)^0.5);
        (1 - x(8) - 2*x(7));            %7 unitless
        (x(7)*x(2) - n_DMC);            %8 units of n_DMC determine units of all other flowrates (mol/hr)
        (1 - x(4) - x(6) - x(5));       %9 unitless
        (x(11) - (x(8)/dens_me + x(7)*(1/dens_dmc + 1/dens_w))^-1); %10 mol/L
        (x(2) - y0*MR*x(1));    %11 mol/hr
        ((1 - x(8))*x(2) - 2*x(9)*V)];     %12 mol/hr

end
