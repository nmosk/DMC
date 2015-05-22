% gonna set up design equations all 17 !!!

function X = toms_syst(x,P,y0,KH_O2,dens_me,dens_w,dens_dmc,k_1,k_2,n_DMC,V,MR)

% Here we go

s_per_hr = 3600;

X = [(x(1) - x(6) - 2*x(8)*V);
    (x(8)*V - x(7));
    (x(2)*y0 - x(3) - 0.5*V*(x(8) + x(9)));
    (x(2)*(1-y0) - x(4) - V*(x(8) + x(9)));
    (V*x(9) - x(5));
    (x(8) - s_per_hr*k_1 * ((P/KH_O2)*(x(3)/(x(3)+x(4)+x(5))))^0.5*(x(6)/(x(6)+2*x(7)))^2*x(10)^(5/2));
    (x(9) - s_per_hr*k_2 * ((P/KH_O2)*(x(3)/(x(3)+x(4)+x(5))))^0.5*x(10)^0.5);
    (x(10) - ((x(6)+2*x(7))/(x(6)/dens_me + x(7)*(1/dens_w+1/dens_dmc))));
    (x(7) - n_DMC);
    (x(1) - MR * y0 *x(2))];

end