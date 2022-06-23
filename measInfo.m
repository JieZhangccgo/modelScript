%% Data for initial conditions, porosities and diffusivitiies. 


%%

%%
Catm_N2 = 33; %[mmol/L]
Catm_O2 = 8.9; %[mmol/L]
Catm_CO2 = 0.017; %[mmol/L]
Catm_N2O = 1.4E-5; %[mmol/L]

%msInfo.icMesh = 10^(-3)*[0 20 32 36 40 44 48 52 56 60 64 68 80 100];

msInfo.icMesh = 0.1*[0 0.39 0.41 0.59 0.61 1];
msInfo.icData = [Catm_CO2 Catm_CO2 Catm_CO2 Catm_CO2 Catm_CO2 Catm_CO2; ...%CO2--1
    0.2, 0.2, 1, 1, 0.2, 0.2; ...%DOC--2 [mmol/L]
    Catm_O2, Catm_O2, 0.2*Catm_O2, 0.2*Catm_O2, Catm_O2, Catm_O2; ... %O2--3
    24*0.02, 24*0.02, 24*0.02, 24*0.02, 24*0.02, 24*0.02; ...%b1, heterotroph--4
    0.2, 0.2, 1, 1, 0.2, 0.2;...%NH4--5
    0.1, 0.1, 0.1, 0.1, 0.1, 0.1;...%NO2--6
    0.5, 0.5, 0.1, 0.1, 0.5, 0.5;...%NO3--7
    Catm_N2O, Catm_N2O, Catm_N2O, Catm_N2O, Catm_N2O, Catm_N2O;...%N2O--8
    24*2e-2, 24*2e-2, 24*2e-2, 24*2e-2, 24*2e-2, 24*2e-2;...%b2, nit--9
    Catm_N2, Catm_N2, Catm_N2, Catm_N2, Catm_N2, Catm_N2;...%N2--10
    24*2e-2, 24*2e-2, 24*2e-2, 24*2e-2, 24*2e-2, 24*2e-2 ...%b3, denit--11
    ];
msInfo.yMesh = 0.1*[0 0.2 0.3 0.6 0.8 1];
    
msInfo.N_NH4 = 0.74; %
msInfo.KF_NH4 = 4.89; %(mg/kg)[L/mg]^N
msInfo.rhob = 1.25; %[kg/L soil]
msInfo.rhodry = 2.65; %[kg/L soil]

msInfo.Do_NO2 = 24*5.20E-06; %24*[m2/h] aqueous
msInfo.Do_NO3 = 24*5.18E-06; %[m2/h] aqueous
msInfo.Do_NH4 = 24*5.33E-06; %[m2/h] aqueous
msInfo.Do_DOC = 24*2.64E-06; %[m2/h] aqueous
msInfo.Do_N2O = 24*5.69E-02; %[m2/h] gas
msInfo.Do_N2 = 24*7.09E-02; %[m2/h] gas
msInfo.Do_CO2 = 24*5.61E-02; %[m2/h] gas
msInfo.Do_O2 = 24*7.09E-02; %[m2/h] gas


msInfo.theta_tot = 1-(msInfo.rhob)/(msInfo.rhodry);
msInfo.theta_w = [0.5 0.6 0.7 0.8 0.6 0.5].*msInfo.theta_tot;
msInfo.theta_a = msInfo.theta_tot - msInfo.theta_w;

msInfo.thetaMat = [msInfo.theta_a; ...%CO2--1, AIR-filled porosity
    msInfo.theta_w; ...%DOC--2, water-filled porosity
    msInfo.theta_a; ...%O2--3, AIR-filled porosity
    ones(1, length(msInfo.theta_w)); ...%b1, heterotroph--4
    msInfo.theta_w; ...%NH4--5, water-filled porosity
    msInfo.theta_w; ...%NO2--6, water-filled porosity
    msInfo.theta_w; ...%NO3--7, water-filled porosity
    msInfo.theta_a; ...%N2O--8, AIR-filled porosity
    ones(1, length(msInfo.theta_w)); ...%b2, nit--9
    msInfo.theta_a; ...%N2--10, AIR-filled porosity
    ones(1, length(msInfo.theta_w)) ...%b3, denit--11
    ];

msInfo.DeffMat(1,:) = msInfo.theta_a.^(4/3).*msInfo.Do_CO2; %CO2--1, AIR-filled porosity
msInfo.DeffMat(2,:) = msInfo.theta_w.^3.*msInfo.Do_DOC; %DOC--2, water-filled porosity
msInfo.DeffMat(3,:) = msInfo.theta_a.^(4/3).*msInfo.Do_O2; %O2--3, AIR-filled porosity
msInfo.DeffMat(4,:) = zeros(1, length(msInfo.theta_w)); %b1, heterotroph--4
msInfo.DeffMat(5,:) = msInfo.theta_w.^3.*msInfo.Do_NH4; %NH4--5, water-filled porosity
msInfo.DeffMat(6,:) = msInfo.theta_w.^3.*msInfo.Do_NO2; %NO2--6, water-filled porosity
msInfo.DeffMat(7,:) = msInfo.theta_w.^3.*msInfo.Do_NO3; %NO3--7, water-filled porosity
msInfo.DeffMat(8,:) = msInfo.theta_a.^(4/3).*msInfo.Do_N2O; %N2O--3, AIR-filled porosity
msInfo.DeffMat(9,:) = zeros(1, length(msInfo.theta_w)); %b2, nit--9
msInfo.DeffMat(10,:) = msInfo.theta_a.^(4/3).*msInfo.Do_N2; %N2--10, AIR-filled porosity
msInfo.DeffMat(11,:) = zeros(1, length(msInfo.theta_w)); %b3, denit--11


% Define a matrix data_Deff of sampling values vectors v1..v4
% msInfo.DeffMat1 = 10^(-5).*[0.5 0.6 0.7 0.8 0.6 0.5; ...%CO2--1
%     0.5 0.6 0.7 0.8 0.6 0.5; ...%DOC--2
%     0.5*10 0.6*10 0.7*10 0.8*10 0.6*10 0.5*10; ...%O2--3
%     0 0 0 0 0 0; ...%b1, heterotroph--4
%     0.5 0.6 0.7 0.8 0.6 0.5; ...%NH4--5
%     0.5 0.6 0.7 0.8 0.6 0.5; ...%NO2--6
%     0.5 0.6 0.7 0.8 0.6 0.5; ...%NO3--7
%     0.5 0.6 0.7 0.8 0.6 0.5; ...%N2O--8
%     0 0 0 0 0 0; ...%b2, nit--9
%     0.5 0.6 0.7 0.8 0.6 0.5; ...%N2--10
%     0 0 0 0 0 0 ...%b3, denit--11
%     ];
% 
% msInfo.thetaMat1 = [0.5 0.6 0.7 0.8 0.6 0.5; ...%CO2--1, AIR-filled porosity
%     0.5 0.6 0.7 0.8 0.6 0.5; ...%DOC--2, water-filled porosity
%     0.5 0.6 0.7 0.8 0.6 0.5; ...%O2--3, AIR-filled porosity
%     1 1 1 1 1 1; ...%b1, heterotroph--4
%     0.5 0.6 0.7 0.8 0.6 0.5; ...%NH4--5, water-filled porosity
%     0.5 0.6 0.7 0.8 0.6 0.5; ...%NO2--6, water-filled porosity
%     0.5 0.6 0.7 0.8 0.6 0.5; ...%NO3--7, water-filled porosity
%     0.5 0.6 0.7 0.8 0.6 0.5; ...%N2O--8, AIR-filled porosity
%     1 1 1 1 1 1; ...%b2, nit--9
%     0.5 0.6 0.7 0.8 0.6 0.5; ...%N2--10, AIR-filled porosity
%     1 1 1 1 1 1 ...%b3, denit--11
%     ];
% msInfo.icData = [0.05 0.05 0.05 0.05 0.05 0.05; ...%CO2--1
%     0.2, 0.2, 1, 1, 0.2, 0.2; ...%DOC--2
%     1, 1, 0.2, 0.2, 1, 1; ... %O2--3
%     1, 1, 1, 1, 1, 1; ...%b1, heterotroph--4
%     0.2, 0.2, 1, 1, 0.2, 0.2;...%NH4--5
%     0.1, 0.1, 0.1, 0.1, 0.1, 0.1;...%NO2--6
%     0.5, 0.5, 0.1, 0.1, 0.5, 0.5;...%NO3--7
%     0.01, 0.01, 0.01, 0.01, 0.01, 0.01;...%N2O--8
%     0.2, 0.2, 0.2, 0.2, 0.2, 0.2;...%b2, nit--9
%     0.01, 0.01, 0.01, 0.01, 0.01, 0.01;...%N2--10
%     0.2, 0.2, 0.2, 0.2, 0.2, 0.2 ...%b3, denit--11
%     ];