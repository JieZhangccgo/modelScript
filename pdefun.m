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
thetaData = msInfo.thetaData;
N_NH4 = msInfo.N_NH4;
KF_NH4 = msInfo.KF_NH4;
rhob = msInfo.rhob;
Deff = msInfo.Deff;

theta = interp1(yMesh,thetaData',x,'pchip')';% a function of x, returning interpolated values of thetaR at x for 11 components
FreuC_NH4 = KF_NH4 * N_NH4 * (18*u(5)).^(N_NH4-1); %KF[mg/kg][L/mg]^N, NH4 molar conc: u[mmol/L], NH4 molar mass: 18[mg/mmol], NH4 mass conc:(18*x)[mg/L]
R_NH4 = 1 + rhob./theta(5).*FreuC_NH4; %rhob = 1.25[kg/L soil], FreuC_NH4 [L/kg]
c = theta.*[1 1 1 1 R_NH4 1 1 1 1 1 1]';
D = interp1(yMesh,Deff',x,'pchip')';% a function of x, returning interpolated values of Deff at x for 11 components
f = D.*dudx;
S_CO2pr = u(4).*u(2)./(ku2+u(2)).*u(3)./(ku3+u(3)); % CO2 production rate
S_NO2pr_n = u(9).*u(5)./(ku2+u(5)).*u(3)./(ku3+u(3)); % NO2 production rate from nitrification.
S_NO3pr_n = u(9).*u(6)./(ku2+u(6)).*u(3)./(ku3+u(3)); % NO3 production rate from nit.
S_N2Opr_n = u(9).*u(5)./(ku2+u(5)).*u(3)./(ku3+u(3)).*kI./(kI+u(3)); % N2O production rate from nit.
S_NO2pr_dn  = u(11).*u(7)./(ku2+u(7)).*u(2)./(ku3+u(2)).*kI./(kI+u(3)); % NO2 production rate from denitrification.
S_N2Opr_dn  = u(11).*u(6)./(ku2+u(6)).*u(2)./(ku3+u(2)).*kI./(kI+u(3)); % N2O production rate from denit.
S_N2pr_dn  = u(11).*u(8)./(ku2+u(8)).*u(2)./(ku3+u(2)).*kI./(kI+u(3)); % N2 production rate from denit.

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