%% define initial conditions for the model
D=1; %[m2 s-1]

% Respiration, kM
kC_CO2 = 0.2; % mol C/L
kO2_CO2 = 0.2; % mol O2/L in air

% Nitrification, kM
kNH4_NO2 = 0.2; % mol N/L
kO2_NO2 = 0.2; % mol N/L
kNO2_NO3 = 0.2; % mol N/L
kO2_NO3 = 0.2; % mol N/L
kNH4_N2O = 0.2; % mol N/L
kO2_N2O = 0.2; % mol N/L

% Denitrification, kM
kNO3_NO2 = 0.2; % mol N/L 
kC_NO2 = 0.2; % mol N/L 
kNO2_N2O = 0.2; % mol N/L 
kC_N2O = 0.2; % mol N/L 
kN2O_N2 = 0.2; % mol N/L 
kC_N2 = 0.2; % mol N/L 

% N and DN O2 inhibiting, kI
kI_NO2 = 0.2; % mol N/L
kI_N2O = 0.2; % mol N/L
kI_N2 = 0.2; % mol N/L


u_resp = 1 %mol g-1 h-1
u_n = 1 %mol g-1 h-1
u_dn = 1 %mol g-1 h-1
B_resp = 1 %g m-3
B_n = 1 %g m-3
B_dn = 1 %g m-3
y_resp = 1 %g m-3
y_n = 1 %g m-3
y_dn = 1 %g m-3