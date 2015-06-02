%Economic potential level 2 calculation
% SUMMARY _____________________________________
% EP level 2 calculations
% Takes in selectivity, conversion, MR, and product DMC
% Product of DMC needs to be in mol/hr
% s_12 is DMC and CO2
% _____________________________________________


% ORDER OF SPECIES
% -------------------------------------------------------
% 1 -> Methanol CH3OH "me"
% 2 -> Carbon monoxide CO "co"
% 3 -> Oxygen O2 "o2"
% 4 -> DMC "DMC"
% 5 -> Water H2O "h2o"
% 6 -> Carbon dioxide CO2 "co2"
% -------------------------------------------------------

function [EP,WC] = EP_DMC(s,MR,x,n_DMC)

time = 8400; % [hrs/yr]



% LITERATURE VALUES -------------------------------------

% Molecular weight 
MW = [32 28 32 90 18 44]; % [g/mol]

% Density
rho = [.792 0.001250 1.429 1.07 1 0.001977]; % [g/cm^3]

% Gas constant
R=1.987; %[cal/MolK]
r=8.3145*10^-5; % [m3 bar/K mol]
r_cal = 1.987204; % [cal/ K mol]

% -------------------------------------------------------

%%

% Product of DMC
% if n_DMC is in [mol/hr] then convert to [kmol/yr]
% -------------------------------------------------------
n_DMC = n_DMC*time/1000; % [kmol/yr]
P_DMC = n_DMC*MW(4); % [kg/yr]
% -------------------------------------------------------
%% 
% Prices [$/kg]
% -------------------------------------------------------
price_DMC = 0.9;
price_me = 0.49;
price_co = 0.18;
price_o2 = 0.38; 
price_water = 0.08/1000; 
price_fuel = 3; % [$/MMBTU]
    
price=[price_me price_co price_o2 price_DMC price_water price_fuel]; %price_fuel in [$/MMBTU], rest in [$/kg]

%fuel prices [$/kg fuel]
fuel_b = 0.12;
fuel_t = 0.12;
fuel_en = 0.14;
fuel_h = 0.40;
fuel_me = 0.16; 
%heat of combustion  [MJ/kg]
hc_co = 10.11 
hc_me = 22.7 

%% check oxygen fuel 

% 1 MJ = 0.000947 MM BTU
fuel_co = price_fuel .* hc_co .* 0.000947; %$/kg
fuel_me = price_fuel .* hc_me .* 0.000947; %$/kg

fuel=[fuel_me fuel_co 0 0 0 price_fuel]; %price_fuel in [$/MMBTU], rest in [$/kg]
% -------------------------------------------------------

%%
% CALCULATING EP___________________________________________________________

EP=zeros(length(s),1);

% Annual costs for operating equipment_________________________________

ac_reac = 8.4e3 ;
ac_columns = 4.7e4 ;
ac_cond_reboil = 7.5e6 ;
ac_cool_heat_pumps = 6.2e6 ; 
ac_water_streams = 5.2e5 ; 
vap_recov = 7.35e5 ;
annual_costs = ac_reac + ac_columns + ac_cond_reboil + ac_cool_heat_pumps + ac_water_streams + vap_recov
    
     EP = (price_DMC.*P_DMC - 2.*n_DMC.*price_me.*(MW(1)) - n_DMC./s .* price_co*(MW(2)) - n_DMC./(2.*s).*price_o2.*(MW(3))...
        - n_DMC.*price_water.*(MW(5)) - annual_costs );


%%
    plot(s,EP)
    axis([0 1 0 10^8])
  
        % FIGURE of EP
        % -------------------------------------------------------
%         figure
%         hold on
%         title('Annual economic potential (chemical by product) vs selectivity')
%         ylabel('EP, $/yr')
%         xlabel('s_1')
%         plot(s(:,1),EP,'LineWidth',2)
%         axis([0 1 0 7*10^8])
%         set(gca,'FontSize',26)
        % -------------------------------------------------------
% _________________________________________________________________________

%%
% CALCULATING EP when selling chemicals as fuel____________________________
       
    % EP when selling chemicals as fuel
    % -------------------------------------------------------
  
   
    % Working Capital
    % 2 months of raw material
    % -------------------------------------------------------
     WC = (2.*n_DMC.*price_me.*(MW(1)) + n_DMC./s .* price_co*(MW(2)) + n_DMC./(2.*s).*price_o2.*(MW(3))) / 12*2 ;
    % -------------------------------------------------------

%         % FIGURE of EP when selling chemicals as fuel
%         % -------------------------------------------------------
%         figure
%         hold on
%         title('Annual economic potential (fuel by product) vs selectivity')
%         ylabel('EPF, $/yr')
%         xlabel('s_1')
%         plot(s(:,1),EP,'LineWidth',2)
%         axis([0 1 0 7*10^8])
%         set(gca,'FontSize',26)
%         % -------------------------------------------------------
% _________________________________________________________________________
            
end