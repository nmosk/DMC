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

function [EP,EP_Fuel,WC, priceeb, pricest, priceby] = EP_PFR_FINAL_vector(s_12,MR,x,n_DMC)

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
kg_DMC = n_DMC*MW(4); % [kg/yr]
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

price_fuel=[0 0 fuel_b fuel_t fuel_en fuel_h fuel_me 0]; %[$/kg fuel]
% -------------------------------------------------------

%%
% CALCULATING EP___________________________________________________________
s=0.01:0.01:1;
selectivity = 0:0.01:(1-s); 
    EP=zeros(length(s_12),1);

    EP = (price_DMC.*P_DMC - 2.*n_DMC.*price_MeOH.*(MW_MeOH) - n_DMC./s.*price_CM*(MW_CM) - n_DMC./(2.*s).*price_O.*(MW_O)...
        - n_DMC.*price_water.*(MW_water));
    
    plot(s,EP)
    axis([0 1 0 10^8])
   % EP = (price(4)*kg_DMC ...
   %     - (n_st*MW_eb./s_12(:,1)).*price_eb - (MR*n_st*MW(8)*price_water) +(n_st*MW_en*s_12(:,2)./s_12(:,1)).*price_en ...
   %     + (n_st*MW_b*s_12(:,2)./s_12(:,1)).*price_b + (n_st*MW_t)*(s_12(:,3))./s_12(:,1)*price_t ...
   %     + (n_st*MW_me)*(s_12(:,3))./s_12(:,1)*fuel_me + (n_st*MW_h)*(1-s_12(:,2))./s_12(:,1).*price_h-(5.*10.^5./x));

        % FIGURE of EP
        % -------------------------------------------------------
        figure
        hold on
        title('Annual economic potential (chemical by product) vs selectivity')
        ylabel('EP, $/yr')
        xlabel('s_1')
        plot(s_12(:,1),EP,'LineWidth',2)
        axis([0 1 0 7*10^8])
        set(gca,'FontSize',26)
        % -------------------------------------------------------
% _________________________________________________________________________

%%
% CALCULATING EP when selling chemicals as fuel____________________________
        % priceeb= (n_st*MW_eb./s_12(:,1)).*price_eb ;
        % pricest= price_st*P_st;
        % priceby=((n_st*MW_en*s_12(:,2)./s_12(:,1)).*fuel_en ...
        %        + (n_st*MW_b*s_12(:,2)./s_12(:,1)).*fuel_b + (n_st*MW_t)*(s_12(:,3))./s_12(:,1)*fuel_t ...
        %       + (n_st*MW_me)*(s_12(:,3))./s_12(:,1)*fuel_me + (n_st*MW_h)*(1-s_12(:,2))./s_12(:,1).*fuel_h)- (MR*n_st*MW(8)*price_water)+(n_st*MW_en*s_12(:,2)./s_12(:,1)).*fuel_en ;
    
    % EP when selling chemicals as fuel
    % -------------------------------------------------------
    EP_Fuel= pricest - priceeb + priceby...
        -(5.*10.^5./x);
    % -------------------------------------------------------
    
    % Working Capital
    % -------------------------------------------------------
    WC= ((n_st*MW_eb./s_12(:,1)).*price_eb - (MR*n_st*MW(8)*price_water))/12*2 ; % cost for 2 months
    % -------------------------------------------------------

        % FIGURE of EP when selling chemicals as fuel
        % -------------------------------------------------------
        figure
        hold on
        title('Annual economic potential (fuel by product) vs selectivity')
        ylabel('EPF, $/yr')
        xlabel('s_1')
        plot(s_12(:,1),EP_Fuel,'LineWidth',2)
        axis([0 1 0 7*10^8])
        set(gca,'FontSize',26)
        % -------------------------------------------------------
% _________________________________________________________________________
            
end


