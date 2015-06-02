% VAPOR RECOVERY SYSTEM ___________________________________________________
% Costs the vapor recovery system
% Takes in Tsurr, Y, and F
    % Y is the flowrate of the CO2 rich stream
    % F is the flowrate of the feed
    % Tsurr is the temperature of the surroundings
% Loops over many guesses of zco2
    % zco2 is the fraction of CO2 in the feed
% _________________________________________________________________________

R = 8.3145; % [J/molK]

% -------------------------------------------------------------------------
Tsurr=130+273; % Tsurr is the temperature of the surroundings (K)
Y=106; % Y is the flowrate of the CO2 rich stream (mol/hr)
F=7395 % F is the flowrate of the feed (mol/hr)
% -------------------------------------------------------------------------


    zco2=.999*.01; % zco2 is the fraction of CO2 in the feed
xi=0.0143    
xi = Y/(zco2*F);
y = @(x) (1-x)*log(1/(1-(x*xi)))-(xi*x*log(x));
y_test= @(x) x*(1-x)*log((1-xi)/(1-(x*xi)));
Wmin = y(zco2)*F*R*Tsurr;

% Net effective operating cost [$/time]
% ----------------------------------------------
    lambda = 6; % for membrane systems
    epsilon = 0.06; % [$/kWh]
C = lambda.*epsilon.*Wmin;
% ----------------------------------------------



