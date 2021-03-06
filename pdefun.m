%% Code Equations
% Formulate a system of 11 PDE/ODE equations. 8 partial differential equations (CO2, DOC, O2, NH4, NO2, NO3, N2O, N2) and 3 odinary differential equations (b1,b2,b3).
% independent varibales x and t, dependent variable u.
% x [m], t [h], u [mmol/L]
% indexes of vector u. 1: CO2, 2: DOC, 3: O2, 4: b1, 5: NH4, 6: NO2, 7: NO3, 8: N2O, 9: b2, 10: N2, 11: b3.
% INPUTS: 
% yMesh: sample points for thetaR and Deff. 
% data_thetaR(x): water-filled porosity (for solutes) or air filled porosity over depth
% (for gases), multiplied by retardation factor (for NH4 R>1, for others, R=1)
% data_Deff(x): effective diffusitivites for solutes and for gases over depth.
% par: parameters involved in reactions.
% Use interp1 to interpolate data_thetaR(x) and data_Deff(x) to the grid point x for which the solver requires information.
%%
function [c,f,s] = pdefun(x,t,u,dudx,msInfo,par) % Equation to solve
ku2=par(1);
ku3=par(2);
kI = ku3;
y_resp = par(3);
y_nit = par(3);
y_denit = par(3);

yMesh = msInfo.yMesh;
thetaMat = msInfo.thetaMat;
N_NH4 = msInfo.N_NH4;
KF_NH4 = msInfo.KF_NH4;
rhob = msInfo.rhob; %1.25 [kg/L soil]
DeffMat = msInfo.DeffMat;
theta_tot = msInfo.theta_tot;

theta = interp1(yMesh,thetaMat',x,'pchip')';% a function of x, returning interpolated values of thetaR at x for 11 components
FreuC_NH4 = KF_NH4 * N_NH4 * (18*u(5)).^(N_NH4-1); %KF[mg/kg][L/mg]^N, NH4 molar conc: u(5)[mmol/L], NH4 molar mass: 18[mg/mmol], NH4 mass conc:(18*u(5))[mg/L]
R_NH4 = 1 + rhob./theta(5).*FreuC_NH4; %rhob = 1.25[kg/L soil], FreuC_NH4 [L/kg]
c = theta.*[1 1 1 1 R_NH4 1 1 1 1 1 1]';
Deff = interp1(yMesh,DeffMat',x,'pchip')';% a function of x, returning interpolated values of Deff at x for 11 components
f = Deff.*dudx;

ix_CO2 = theta_tot.^(-4/3) * theta(1).^(4/3); %CO2--1, AIR-filled porosity
ix_DOC = theta_tot.^(-3) * theta(2).^3; %DOC--2, water-filled porosity
ix_O2 = theta_tot.^(-4/3) * theta(3).^(4/3); %O2--3, AIR-filled porosity
ix_NH4 = theta_tot.^(-3) * theta(5).^3; %NH4--5, water-filled porosity
ix_NO2 = theta_tot.^(-3) * theta(6).^3; %NO2--6, water-filled porosity
ix_NO3 = theta_tot.^(-3) * theta(7).^3; %NO3--7, water-filled porosity
ix_N2O = theta_tot.^(-4/3) * theta(8).^(4/3); %N2O--8, AIR-filled porosity
ix_N2 = theta_tot.^(-4/3) * theta(10).^(4/3); %N2--10, AIR-filled porosity

S_CO2pr = u(4).*ix_DOC.*u(2)./(ku2+ix_DOC.*u(2)).*ix_O2.*u(3)./(ku3+ix_O2.*u(3)); % CO2 production rate, NEED TO Multiply rhob on RHS
S_NO2pr_n = u(9).*ix_NH4.*u(5)./(ku2+ix_NH4.*u(5)).*ix_O2.*u(3)./(ku3+ix_O2.*u(3)); % NO2 production rate from nitrification.
S_NO3pr_n = u(9).*ix_NO2.*u(6)./(ku2+ix_NO2.*u(6)).*ix_O2.*u(3)./(ku3+ix_O2.*u(3)); % NO3 production rate from nit.
S_N2Opr_n = u(9).*ix_NH4.*u(5)./(ku2+ix_NH4.*u(5)).*ix_O2.*u(3)./(ku3+ix_O2.*u(3)).*kI./(kI+ix_O2.*u(3)); % N2O production rate from nit.
S_NO2pr_dn  = u(11).*ix_NO3.*u(7)./(ku2+ix_NO3.*u(7)).*ix_DOC.*u(2)./(ku3+ix_DOC.*u(2)).*kI./(kI+ix_O2.*u(3)); % NO2 production rate from denitrification.
S_N2Opr_dn  = u(11).*ix_NO2.*u(6)./(ku2+ix_NO2.*u(6)).*ix_DOC.*u(2)./(ku3+ix_DOC.*u(2)).*kI./(kI+ix_O2.*u(3)); % N2O production rate from denit.
S_N2pr_dn  = u(11).*ix_N2O.*u(8)./(ku2+ix_N2O.*u(8)).*ix_DOC.*u(2)./(ku3+ix_DOC.*u(2)).*kI./(kI+ix_O2.*u(3)); % N2 production rate from denit.

s = [S_CO2pr;... %CO2--1
    -S_CO2pr;... %DOC--2
    -S_CO2pr - 1.5*S_NO2pr_n - 0.5*S_NO3pr_n - 2*S_N2Opr_n;... %O2--3
    y_resp*S_CO2pr;... %b1, heterotroph--4
    -S_NO2pr_n - 2*S_N2Opr_n;... %NH4--5
    S_NO2pr_n - S_NO3pr_n + S_NO2pr_dn - 2*S_N2Opr_dn;... %NO2--6
    S_NO3pr_n - S_NO2pr_dn;... %NO3--7
    S_N2Opr_n + S_N2Opr_dn - S_N2pr_dn;... %N2O--8
    y_nit * (S_NO2pr_n + 2*S_N2Opr_n);...%b2, nit--9
    S_N2pr_dn;...%N2--10
    y_denit * S_NO2pr_dn ...%b3, denit--11
    ];
end