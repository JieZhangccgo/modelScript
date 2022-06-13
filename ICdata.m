icMesh = [0 0.39 0.41 0.59 0.61 1];
icData = [0.05 0.05 0.05 0.05 0.05 0.05; ...%CO2--1
    0.2, 0.2, 1, 1, 0.2, 0.2; ...%DOC--2
    1, 1, 0.2, 0.2, 1, 1; ... %O2--3
    1, 1, 1, 1, 1, 1; ...%b1, heterotroph--4
    0.2, 0.2, 1, 1, 0.2, 0.2;...%NH4--5
    0.1, 0.1, 0.1, 0.1, 0.1, 0.1;...%NO2--6
    0.5, 0.5, 0.1, 0.1, 0.5, 0.5;...%NO3--7
    0.01, 0.01, 0.01, 0.01, 0.01, 0.01;...%N2O--8
    0.2, 0.2, 0.2, 0.2, 0.2, 0.2];%b2, nit--9

yMesh = [0 0.2 0.3 0.6 0.8 1];
% Define a matrix data_Deff of sampling values vectors v1..v4
data_Deff = [0.5 0.6 0.7 0.8 0.6 0.5; ...%CO2--1
    0.5 0.6 0.7 0.8 0.6 0.5; ...%DOC--2
    0.5*10 0.6*10 0.7*10 0.8*10 0.6*10 0.5*10; ...%O2--3
    0 0 0 0 0 0; ...%b1, heterotroph--4
    0.5 0.6 0.7 0.8 0.6 0.5; ...%NH4--5
    0.5 0.6 0.7 0.8 0.6 0.5; ...%NO2--6
    0.5 0.6 0.7 0.8 0.6 0.5; ...%NO3--7
    0.5 0.6 0.7 0.8 0.6 0.5; ...%N2O--8
    0 0 0 0 0 0];%b2, nit--9
    


data_thetaR = [0.5 0.6 0.7 0.8 0.6 0.5; ...%CO2--1
    0.5 0.6 0.7 0.8 0.6 0.5; ...%DOC--2
    0.5 0.6 0.7 0.8 0.6 0.5; ...%O2--3
    1 1 1 1 1 1; ...%b1, heterotroph--4
    0.5 0.6 0.7 0.8 0.6 0.5; ...%NH4--5
    0.5 0.6 0.7 0.8 0.6 0.5; ...%NO2--6
    0.5 0.6 0.7 0.8 0.6 0.5; ...%NO3--7
    0.5 0.6 0.7 0.8 0.6 0.5; ...%N2O--8
    1 1 1 1 1 1];%b2, nit--9
  