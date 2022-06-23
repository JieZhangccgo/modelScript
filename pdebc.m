%% Code Boundary Conditions 
% All components have symmetric Boundary Conditions. 
% Left boundary defined by pl, ql; Right boundary defined by pr, qr.
% -> CO2,O2,N2O,N2 are assigned with Dirichlet boundary condition, gas concentration same to
% the atmospheric concentrations. pl=ul-C_air; ql=0; pr=ur-C_air; qr=0.
% -> DOC,b1,NH4,NO2,NO3,b2,b3 are assigned with Neumann boundary conditions, derivative on the boundary equals to zero.
% pl=0; ql=1; pr=0; qr=1.

%% write a function that returns the boundary condition
function [pl,ql,pr,qr] = pdebc(xl,ul,xr,ur,t) % Boundary Conditions

Catm_N2 = 33; %[mmol/L]
Catm_O2 = 8.9; %[mmol/L]
Catm_CO2 = 0.017; %[mmol/L]
Catm_N2O = 1.4E-5; %[mmol/L]

pl = [ul(1)-Catm_CO2;... %CO2--1
    0;... %DOC--2
    ul(3)-Catm_O2; ... %O2--3
    0;... %b1, heterotroph--4
    0;... %NH4--5
    0;... %NO2--6
    0;... %NO3--7
    ul(8)-Catm_N2O;... %N2O--8
    0; ...%b2, nit--9
    ul(10)-Catm_N2; ...%N2--10
    0 ...%b3, denit--11
    ];

ql = [0; ... %CO2--1
    1; ... %DOC--2
    0;  ... %O2--3
    1; ... %b1, heterotroph--4
    1; ... %NH4--5
    1; ... %NO2--6
    1; ... %NO3--7
    0; ... %N2O--8
    1; ...%b2, nit--9
    0; ...%N2--10
    1 ...%b3, denit--11
    ];

pr = [ur(1)-Catm_CO2; ... %CO2--1
    0; ... %DOC--2
    ur(3)-Catm_O2; ... %O2--3
    0;... %b1, heterotroph--4
    0;... %NH4--5
    0;... %NO2--6
    0;... %NO3--7
    ur(8)-Catm_N2O;... %N2O--8
    0; ...%b2, nit--9
    ur(10)-Catm_N2; ...%N2--10
    0 ...%b3, denit--11
    ];
qr = [0; ... %CO2--1
    1; ... %DOC--2
    0; ... %O2--3
    1; ... %b1, heterotroph--4
    1; ... %NH4--5
    1; ... %NO2--6
    1; ... %NO3--7
    0; ... %N2O--8
    1; ...%b2, nit--9
    0; ...%N2--10
    1 ...%b3, denit--11
    ];

end