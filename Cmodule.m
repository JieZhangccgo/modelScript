close all;clear;clc

N = 10; % Number of intervals
dz=1/N; % Spatial step size
z=0:dz:1; % x vector for plot
dt=0.001; % Temporal step size
t_end=0.2; % End time, determined from solution manual
t_steps = t_end/dt; % Number of time steps
VonR = dt/dz^2; % Stability criterion (12.139)

%initialize C
CO2=zeros(N+1,t_steps+1); % Preallocating
CO2(:,1)=0.05*[1 1 1 1 1 1 1 1 1 1 1];
DOC=zeros(N+1,t_steps+1); % Preallocating
DOC(:,1)=[0 0 0 0 0 1 0 0 0 0 0]; % Inserting initial condition at t=0
O=zeros(N+1,t_steps+1); % Preallocating
O(:,1)=[1 1 1 1 1 0.2 1 1 1 1 1];

O_bd=1;
CO2_bd = 0.05;

D=ones(N+1,t_steps+1);
Kc=0.2;
Ko=0.2;
H_co2 =1; %Henry's constant
H_o2 = 1;
R_co2_lq = zeros(N+1,t_steps);% no reaction rate at time 0, so use t_steps
R_co2_g=R_co2_lq/H_co2;

for j=1:t_steps % Temporal loop
    for i=1:N+1 % Spatial loop
        R_co2_lq(i,j) = DOC(i,j)/(Kc+DOC(i,j))*O(i,j)/(Ko+O(i,j));
        R_co2_g(i,j) = R_co2_lq(i,j)/H_co2; % converting from aqueous reaction rate to gaseous reaction rate
        if i==1 %First point, dDOC/dz=0, DOC(i-1,j)=DOC(i,j); O(i,j)=O_bd; CO2(i,j)=CO2_bd
            CO2(i,j+1) = CO2_bd;
            DOC(i,j+1) = DOC(i,j)+dt*((D(i+1,j)-D(i,j))*(DOC(i+1,j)-DOC(i,j))/(4*dz^2) + D(i,j)*(DOC(i+1,j)-2*DOC(i,j)+DOC(i,j))/(dz^2) - R_co2_lq(i,j));
            O(i,j+1) = O_bd;
        elseif i==N+1 % Final point, dDOC/dz=0, DOC(i+1,j)=DOC(i,j);O(i,j)=O_bd; CO2(i,j)=CO2_bd
            CO2(i,j+1) = CO2_bd;
            DOC(i,j+1) = DOC(i,j)+dt*((D(i,j)-D(i-1,j))*(DOC(i,j)-DOC(i-1,j))/(4*dz^2) + D(i,j)*(DOC(i,j)-2*DOC(i,j)+DOC(i-1,j))/(dz^2) - R_co2_lq(i,j));
            O(i,j+1) = O_bd;
        else % Remaining internal points
            CO2(i,j+1) = CO2(i,j)+dt*((D(i+1,j)-D(i-1,j))*(CO2(i+1,j)-CO2(i-1,j))/(4*dz^2) + D(i,j)*(CO2(i+1,j)-2*CO2(i,j)+CO2(i-1,j))/(dz^2) + R_co2_g(i,j));
            DOC(i,j+1) = DOC(i,j)+dt*((D(i+1,j)-D(i-1,j))*(DOC(i+1,j)-DOC(i-1,j))/(4*dz^2) + D(i,j)*(DOC(i+1,j)-2*DOC(i,j)+DOC(i-1,j))/(dz^2) - R_co2_lq(i,j));
            O(i,j+1) = O(i,j)+dt*((D(i+1,j)-D(i-1,j))*(O(i+1,j)-O(i-1,j))/(4*dz^2) + D(i,j)*(O(i+1,j)-2*O(i,j)+O(i-1,j))/(dz^2) - R_co2_g(i,j));            
        end
    end
end
figure()
subplot(2,2,1)
plot(z,DOC(:,1:end)) % Plotting solution

hold on
subplot(2,2,2)
plot(z,O(:,1:end))

hold on
subplot(2,2,3)
plot(z,CO2(:,1:end))

hold on
subplot(2,2,4)
plot(z,R_co2_lq(:,1:end))
