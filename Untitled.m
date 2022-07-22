close all; clear; clc

%NH4data = Book1.mean; % import parameter range

%%
% case 1: the Freudrich isotherm based on adsorbed NH4-N [mg N/kg] and dissolved NH4-N [mg N/L]
tic;
c_tot = Book1.meanmgNH4Nkg; %[mg N/kg]
rho_b = Book1.bulkDensitykgL; %[kg/L]
kF = 4.89;
N = 0.74;
theta = Book1.waterContent; %[-]
A = [];
for i=1:length(c_tot)
    syms b real; %[mg N/L]
    eqn = kF.*N.*b.^N.*rho_b(i) + theta(i).*b - c_tot(i).*rho_b(i) == 0;
    c_w = real(double(vpasolve(eqn))); %%[mg N/L] calculate the dissolved NH4-N conc. in water phase; calling the numeric solver vpasolve and return the real number.
    c_s = double(kF*N*c_w^N);  %[mg N/kg]
    checkval = c_tot(i) - c_w*theta(i)/rho_b(i) - c_s;
    ratio = c_w*theta(i)/rho_b(i)/c_tot(i); %
    A(i,:) = [c_w, c_s, checkval, ratio]; %
    clear b;
end
toc;
%%
% case 2: the Freudrich isotherm based on adsorbed NH4 [mg/kg] and dissolved NH4 [mg/L]
tic;
c_tot_2 = Book1.meanmgNH4Nkg./14.*18; %[mg/kg]
rho_b = Book1.bulkDensitykgL; %[kg/L]
kF = 4.89;
N = 0.74;
theta = Book1.waterContent; %[-]
A_2 = [];
for i=1:length(c_tot_2)
    syms b real; %[mg/L]
    eqn = kF.*N.*b.^N.*rho_b(i) + theta(i).*b - c_tot_2(i).*rho_b(i) == 0;
    c_w = real(double(vpasolve(eqn))); %%[mg/L] calculate the dissolved NH4-N conc. in water phase; calling the numeric solver vpasolve and return the real number.
    c_s = double(kF*N*c_w^N);  %[mg/kg]
    checkval = c_tot_2(i) - c_w*theta(i)/rho_b(i) - c_s;
    ratio = c_w*theta(i)/rho_b(i)/c_tot_2(i); %
    A_2(i,:) = [c_w, c_s, checkval, ratio]; %
    clear b;
end
A_2(:,5) = A_2(:,1)./18.*14; % from [mg/L] to [mg N/L]
toc;

meth_diff = (A_2(:,5)-A(:,1))./A(:,1); %calculated c_w [mg N/L] increased 6% -9% from case 1 (adsorption isotherm based on N) to case 2 (adsorption isotherm based on NH4)
%%
a = 0:0.01:0.5;
y = kF.*N.*a.^N.*rho_b + theta.*a - c_tot(32).*rho_b;
plot(a,y)
%%
syms b; %[mg/L]
eqn = kF.*N.*b.^N.*rho_b + theta.*b - c_tot(32).*rho_b == 0;
c_w = real(double(vpasolve(eqn))) %%[mg/L] calling the numeric solver vpasolve and specifying the interval.
c_s = double(kF*N*c_w^N)  %[mg/kg]
checkval = c_tot(32) - c_w*theta/rho_b - c_s
%A = [c_w, c_s, checkval]

