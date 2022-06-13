function [c,f,s] = pdefun(x,t,u,dudx,yMesh,data_thetaR, data_Deff,par) % Equation to solve
ku2=par(1);
ku3=par(2);
y_resp = par(3);
thetaR = interp1(yMesh,data_thetaR',x,'pchip')';% interpolate after creating a matrix data_thetaR', whose COLUMNS are vectors v1..vn, size(thetaR): n*1
c = thetaR;
D = interp1(yMesh,data_Deff',x,'pchip')';% interpolate after creating a matrix data_Deff', whose COLUMNS are vectors v1..vn, size(D): n*1
f = D.*dudx;
S = u(4).*u(2)./(ku2+u(2)).*u(3)./(ku3+u(3));
s = [S;-S;-S;y_resp*S];
end