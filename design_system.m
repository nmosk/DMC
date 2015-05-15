% gonna set up design equations all 17 !!!

function X = design_system(x)

global r R P y0 KH_O2 KH_CO KH_C2 dens_me dens_w dens_dmc T k_1 k_2 n_DMC tau


% Here we go

X = [(x(2)-x(5)*x(4) - tau*x(14)*x(16)); 
    (y0*x(1) - x(13)*x(3) - x(10)*x(4) - 0.5*tau*x(16)*(x(14)+x(15)));
    (tau*x(16)*x(14) - x(9)*x(4));
    ((1-y0)*x(1) - x(11)*x(3) - x(6)*x(4) - tau*x(16)*(x(14)+x(15)));
    (tau*x(16)*x(15) - x(12)*x(3) - x(7)*x(4)); %5
    (tau*x(16)*x(8)*x(4));
    (1 - x(5) - x(6) - x(7) - x(8) - x(9) - x(10));
    (1 - x(11) - x(12) - x(13)); %8
    (1 - (x(13)*P)/(x(10)*KH_O2)); 
    (1 - (x(11)*P)/(x(6)*KH_CO)); %10
    (1 - (x(12)*P)/(x(7)*KH_C2));
    (x(17) - (x(5)*dens_me + x(9)*dens_w + x(8)*dens_dmc)); %12
    (x(15) - k_2*(x(10)*x(17))^0.5);
    (x(14) - k_1*x(5)*(x(10)^0.5)*(x(17)^2.5)); %14
    (x(9)*x(4) - n_DMC);
    (x(8)*x(4) - n_DMC); %16
    (x(16) - tau((x(2)/x(17)) + x(1)*R*(T+273)/P))];

end

    