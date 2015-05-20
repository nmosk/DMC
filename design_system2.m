% gonna set up design equations all 17 !!!

function X = design_system2(x,P,y0,KH_O2,dens_me,dens_w,dens_dmc,k_1,k_2,n_DMC,V,MR)

% Here we go

s_per_hr = 3600;

X = [(y0*x(1) - x(5)*x(3) - V*0.5*(x(10)+x(11)));
        (V*x(11) - x(7)*x(3));
        ((1-y0)*x(1) - x(6)*x(3) - V*(x(11)+x(10)));
        (V*x(10) - x(8)*x(4));          %4
        (x(10) - s_per_hr*k_1*(x(9)^2)*((x(5)*P/KH_O2)^0.5)*(x(12)^5/2)); %rate [=] mol/L/hr
        (x(11) - s_per_hr*k_2*(x(5)*P*x(12)/KH_O2)^0.5);
        (1 - x(9) - 2*x(8));            %7
        (x(8)*x(4) - n_DMC);
        (1 - x(5) - x(6) - x(7));       %9
        (x(12) - x(9)*dens_me - x(8)*(dens_dmc + dens_w));
        (x(2) - y0*MR*x(1));
        (x(2) - x(9)*x(4) - 2*x(10)*V)]     %12

end
