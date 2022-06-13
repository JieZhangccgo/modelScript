function [c,f,s] = pdefun(x,t,u,dudx,yMesh,data_thetaR, data_Deff,par) % Equation to solve
ku2=par(1);
ku3=par(2);
kI = ku3;
y_resp = par(3);
y_nit = par(3);
thetaR = interp1(yMesh,data_thetaR',x,'pchip')';% interpolate after creating a matrix data_thetaR', whose COLUMNS are vectors v1..vn, size(thetaR): n*1
c = thetaR;
D = interp1(yMesh,data_Deff',x,'pchip')';% interpolate after creating a matrix data_Deff', whose COLUMNS are vectors v1..vn, size(D): n*1
f = D.*dudx;
S_CO2pr = u(4).*u(2)./(ku2+u(2)).*u(3)./(ku3+u(3));
S_NO2pr_n = u(9).*u(5)./(ku2+u(5)).*u(3)./(ku3+u(3));
S_NO3pr_n = u(9).*u(6)./(ku2+u(6)).*u(3)./(ku3+u(3));
S_N2Opr_n = u(9).*u(5)./(ku2+u(5)).*u(3)./(ku3+u(3)).*kI./(kI+u(3));

s = [S_CO2pr;... %CO2--1
    -S_CO2pr;... %DOC--2
    -S_CO2pr - 1.5*S_NO2pr_n - 0.5*S_NO3pr_n - 2*S_N2Opr_n;... %O2--3
    y_resp*S_CO2pr;... %b1, heterotroph--4
    -S_NO2pr_n - 2*S_N2Opr_n;... %NH4--5
    S_NO2pr_n - S_NO3pr_n;... %NO2--6
    S_NO3pr_n;... %NO3--7
    S_N2Opr_n;... %N2O--8
    y_nit * (S_NO2pr_n + 2*S_N2Opr_n)...%b2, nit--9
    ];
end