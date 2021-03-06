% DESCRIPTION -------------------------------------------
% This script is the Discount Cash Flow Analysis function
% Performs the economic analysis for the conceptual design portion of the
% project. Outputs different economic information for different diameters
% of different volumes. Specifically calculates ROI_BT, TCI, and NPV
% values.

% Inputs V, WC, EP, X
%   Corresponding indices from V and X correspond with each other
%       I.E: V(5) corresponds with X(5)
%   Similarily, corresponding indices from EP and WC match V and X
%       I.E: EP(3) -> WC(3) -> V(3) -> X(3)

% Is used in the mainscript of the PFR code

% NOTE:
%   1) WC is calculated in this function. WC from EP function is unused.
%      WC is calculated as 20% of FC as calculated in a Discounted Cash
%      Flow analysis.

%   2) Most values are outputted in arrays
%   Arrays outputted from this function are structured as follows:
% I.E: ARRAY= [
%               D: j = 1 , 2 , 3 , 4 ... N
%           V: i =  1  #   #   #   # ... #
%                   2  #   #   #   # ... #
%                   3  #   #   #   # ... #
%                   4  #   #   #   # ... #
%                   .  .   .   .   . ... #
%                   .  .   .   .   . ... #
%                   .  .   .   .   . ... #
%                   N  #   #   #   # ... #   ]
%   3) Outputs of TCI, NPVs, ROI_BT: plot ONLY the diagonals
% -------------------------------------------------------

% ABBREVIATIONS of SPECIES ------------------------------
% ethylbenzene -> eB
% styrene -> St
% benzene -> B
% toulene -> T
% ethylene -> eN
% hydrogen -> H2
% methane -> Me
% water-> H20
% -------------------------------------------------------

function [Profit_AT_SV,SV,P_BT,ROI_BT, ic_reac, V_ft, D_fact ,WC_CF ,PO_CF ,  TCI, H, D, FC,TI, SU, WCap, Profit_BT, Profit_AT, C_F, Cashflow_d, Bond_Fin, D_CF, NPV_0, NPV_proj,NPV_percent,Depreciation] = conceptual_econ_DMC(V, WC, EP,X)


% DISCOUNT CASH FLOW ANALYSIS COEFFICIENTS --------------


% Construction factor ___________________________________

% Correction factor for pressure vessels_ shell material
F_m=1;

% Correction factor for pressure vessels: pressure
F_p=1;

% Correction factor for distillation column
F_s=2.2;

% Calculating construction factor F_c
F_c=F_m*F_p;

% ______________________________________________________

% Finance rate
FR=.04;

% Tax rate
TR=.48;

% Enterprise rate
ER=0.08;

% Marshall and Swift cost index
MAS=1600;

% 'a' coefficients
an3=0.00;
an2=0.00;
an1=0.50;
a0=0.50;

format long

% Number of constructions
Nconst=2; % Nconstructions

% Number of operations
Nop=10; %Noperations

% Alpha values
alphaSU=.1;
alphasv=0.03; %alpha salvage value

% Installation factor
IF=2.18; %installation factor for labor, foundations, supports, etc

% Construction rate
CR=.06; %Construction rate -- chosen independently

%%
a=1/3; b=6; %[m]

D=transpose(a:abs((a-b)./(length(V)-1)):b); %diameter in [m]

% Changes diameter from meters to feet
D=D*3.28; % [ft]

% Changes V from meters^3 to feet^3
V_ft=35.3147.*V';

% Calculates corresponding height to chosen D and
H = V_ft./(pi.*(D./2).^2); % [ft]

P_BT = EP;%_fuel; %have form EP_fuel


%%

Bond_Fin=zeros(10,length(D));
ROI_BT=[]; TCI=[]; FC=[];
NPV_0=[]; NPV_proj=[]; NPV_percent=[]; Depreciation=[]; Profit_AT=[];C_F=[];D_CF=[];


%Discount factors
D_fact=zeros(10,1);
D_fact(1)=1/(1+ER); %discount factors with enterprise rate at year 1
for k=2:10
    D_fact(k)=D_fact(k-1)/(1+ER); % discount factors with enterprise rate at subsequent years
end

%% Installed Costs for column 

% installed costs for reactor
ic_reac = MAS./280.*101.9.*(D.^1.066).*(H.^0.82 ); % purchasing cost of reactor;

% installed costs for columns

ic_columns = 4.4e4;

% installed cost of heater and cooler
 
ic_heat_cool_pumps = 8.8e6;

% installed costs condensers and reboilers

ic_cond_reboil = 2.6e7 ;

%installed cost base equipment

installed_costs = ic_reac + ic_columns + ic_heat_cool_pumps + ic_cond_reboil 

%%


ISBL= installed_costs; %Installation cost


% Fixed capital
FC=2.28*ISBL ;
FC=FC';


% Start up
SU = 0.1.*FC; %SU=10% of FC

% Total Fixed Capital ???
%FC = 1.1*FC + WC';


% Working Capital
WCap=FC.*.2;


% Total investment
TI = FC * (1+.2+.1);

FC_n3=FC*an3;
FC_n2=FC*an2;
FC_n1=FC*an1;
FC_0=FC*a0;

FC_n3=transpose(FC_n3);
FC_n2=transpose(FC_n2) ;
FC_n1=transpose(FC_n1);
FC_0=transpose(FC_0);

F_d=[(1+CR)^3 (1+CR)^2 (1+CR)^1 1 1 1]; %Discount factors for Y-3 to Y-0 then WC, SU

Cashflow_d=[F_d(1).*FC_n3 F_d(2).*FC_n2 F_d(3).*FC_n1 FC_0.*F_d(4) WCap'.*F_d(5) SU'.*F_d(6)];
Cashflow_d=Cashflow_d';
TCI=abs(sum(Cashflow_d));

%%

% IMPORTANT OUTPUT*********************************************************
% CALCULATING RETURN OF INVESTMENT BEFORE TAXES -------------------
ROI_BT=P_BT'./TI; %percent -- make sure to look at (i,j) cell

% b coefficients
b_1=0.8;
b_2=0.9;
b_3=0.95;
b_coeff=[b_1 b_2 b_3];

% calcs profit before taxes for the first 3 years
% -----------------------------------------------------------------

% *************************************************************************


Profit_BT = transpose(b_coeff)*transpose(P_BT);

Profit_BT = [Profit_BT; repmat(transpose(P_BT),7,1)];



% CALCULATING BOND FINANCING --------------------------------------
Bond_Fin = -FR*TCI;

%Depreciation
Depreciation=-0.1.*FC.*(1+alphaSU); % depriciation allowed -0.1*FC*(1+alpha_Start_Up_Capital)
%should be 10 by length(D) but all 10 rows are same value


% Bond financing
Bond_Fin = repmat(Bond_Fin,10,1) ;

%Depreciation=Depreciation'
Depreciation = repmat(Depreciation,10,1) ;

% Profit after taxes
Profit_AT = (Profit_BT + Bond_Fin + Depreciation)*(1-TR);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% CALCULATING DISCOUNTED  CASH FLOW ------------------------------
% Cash flow
C_F = Profit_AT - Depreciation;

% Discounted cash flow
D_CF=(repmat(D_fact,1,length(C_F))).*C_F; % discounted cash flows

% Summing discounted cash flow
sum_D_CF=sum(D_CF);
% ---------------------------------------------------------------
%%
% Alpha salvage value
SV=FC.*alphasv; %alpha salvage value

% Pay off TCI
Pay_Off_TCI=-TCI;

% Profit after tax for salvage value
Profit_AT_SV= SV*(1-TR);

% Discounted cashflow for salvage value
SV_CF = D_fact(end)*Profit_AT_SV;

% Discounted cashflow for WC
WC_CF= WCap*D_fact(end);

% Discounted cashflow for WC
PO_CF= Pay_Off_TCI*D_fact(end);


%%

% IMPORTANT OUTPUT*********************************************************

% NPV_0
NPV_0=sum_D_CF+SV_CF+WC_CF+ PO_CF;

%NPV_proj
NPV_proj=NPV_0/((1+ER)^Nconst);

%NPV
NPV_percent=(NPV_proj./TCI./(Nconst+Nop)).*100;

% *************************************************************************
ROI_BT=ROI_BT*100;

end
