%% variable units
% c: mol/L, D: m2/h, 
% u_
% 
% 
% 

%% physical parameters
Do_NO2 = 24*5.20E-06; %24*[m2/h] aqueous
Do_NO3 = 24*5.18E-06; %[m2/h] aqueous
Do_NH4 = 24*5.33E-06; %[m2/h] aqueous
Do_DOC = 24*2.64E-06; %[m2/h] aqueous
Do_N2O = 24*5.69E-02; %[m2/h] gas
Do_N2 = 24*7.09E-02; %[m2/h] gas
Do_CO2 = 24*5.61E-02; %[m2/h] gas
Do_O2 = 24*7.09E-02; %[m2/h] gas

%% biotic parameters
% Respiration, half-saturation rate
kC_CO2_r = 0.2; % mol C/L
kO2_CO2_r = 0.2; % mol O2/L in air

% Nitrification, half-saturation rate
kNH4_NO2_n = 0.2; % mol N/L
kO2_NO2_n = 0.2; % mol N/L
kNO2_NO3_n = 0.2; % mol N/L
kO2_NO3_n = 0.2; % mol N/L
kNH4_N2O_n = 0.2; % mol N/L
kO2_N2O_n = 0.2; % mol N/L

% Denitrification, half-saturation rate
kNO3_NO2_dn = 0.2; % mol N/L 
kC_NO2_dn = 0.2; % mol N/L 
kNO2_N2O_dn = 0.2; % mol N/L 
kC_N2O_dn = 0.2; % mol N/L 
kN2O_N2_dn = 0.2; % mol N/L 
kC_N2_dn = 0.2; % mol N/L 

% O2 inihibition rate in N and DN
kI_NO2 = 0.2; % mol N/L
kI_N2O = 0.2; % mol N/L
kI_N2 = 0.2; % mol N/L

% maximum reaction rate per unit of microbial biomass
u_CO2_r = 1 %mol g-1 h-1
u_NO2_n = 1 %mol g-1 h-1
u_NO3_n = 1 %mol g-1 h-1
u_NO2_dn = 1 %mol g-1 h-1
u_N2O_dn = 1 %mol g-1 h-1
u_N2_dn = 1 %mol g-1 h-1
% or fewer parameters, keep maximum reaction rate the same
% u_r = 1 %mol g-1 h-1
% u_n = 1 %mol g-1 h-1
% u_dn = 1 %mol g-1 h-1

% microbial biomass decomposers, nitrifiers, and denitirifers
B_r = 1 %g m-3
B_n = 1 %g m-3
B_dn = 1 %g m-3

% yield coefficients in monod equation
y_r = 1 %g m-3
y_n = 1 %g m-3
y_dn = 1 %g m-3

% 29 biotic parameters at most,
% 