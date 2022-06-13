close all;clear;clc
trange = [0 120];
Cin = [5.1 3.1 387.05];
Q=100;
options=odeset('RelTol',1e-7,'AbsTol',1e-8);
[t,c] = ode45(@simul_dif, trange, Cin,options,Q);
[t1,c1] = ode45(@(t,c)simul_dif(t,c,Q), trange, Cin);

w=1;
x = linspace(0,1,20);
t = linspace(0,2,5);
m = 0;
%sol = pdepe(m,@pdex1pde,@pdex1ic,@pdex1bc,x,t,options,w);
sol1 = pdepe(m,@(x,t,u,dudx)pdex1pde(x,t,u,dudx,w),@pdex1ic,@pdex1bc,x,t);
%%
close all;clear;clc
x = linspace(0,1,20);
t = linspace(0,.1,5);
global x_vector;
global init_c_vector
init_c_vector = sin(x);
x_vector = x;
xx = x;
xxin = sin(x);
sol = pdepe(0,@pd_pde,@pd_initc,@pd_bc,x,t);
sol2 = pdepe(0,@pd_pde,@(x)pd_initcxxin(x,xx,xxin),@pd_bc,x,t);

u=sol(:,:,1);
plot(x, u(:,:),'-');
u2=sol2(:,:,1);
hold on;
plot(x, u2(:,:),'o');


%%

function f = simul_dif(t,c,Q)
    k1 = 3.58*10^8;
    k2 = 2.08*10^7;
    E1DR = 9758.3;
    E2DR = 9758.3;
    dHr = 78;
    A = 0.5;
    h = 1;
    %Q=100;
    k11 = (k1*exp(-E1DR/c(3)));
    k21 = (k2*exp(-E2DR/c(3)));
    rho = 934.2;
    Cp = 2;
    
    f(1,1) = ((-dHr/(rho*Cp)) * ((k11*c(1))-(k21*c(2))))+(Q/(A*h*rho*Cp));
    f(2,1) = (-k11*c(1))+(k21*c(2));
    f(3,1) = (k11*c(1))-(k21*c(2));
end
function [c,f,s] = pdex1pde(x,t,u,dudx,w) % Equation to solve
c = w*pi^2;
f = dudx;
s = 0;
end
%----------------------------------------------
function u0 = pdex1ic(x) % Initial conditions
u0 = sin(pi*x);
end
%----------------------------------------------
function [pl,ql,pr,qr] = pdex1bc(xl,ul,xr,ur,t) % Boundary conditions
pl = ul;
ql = 0;
pr = pi * exp(-t);
qr = 1;
end
%%
% --------------------------------------------------------------
function [c,f,s] = pd_pde(x,t,u,DuDx)
c = 1;
f = abs(DuDx)*DuDx;
s = 0;
end
% --------------------------------------------------------------
function u0 = pd_initc(x)
 %initialise global variables    
  global init_c_vector;
  global x_vector;
  % find the index of the x value pdepe wants to call
  [R,C] = find(x_vector==x,1,'first');
  %use the index to return the value of interest
  u0 = init_c_vector(R,C);
end
function u0 = pd_initcxxin(x,xx,xxin)
 %initialise global variables    
  % find the index of the x value pdepe wants to call
  [R,C] = find(xx==x,1,'first');
  u0 = xxin(R,C);
end
% --------------------------------------------------------------
function [pl,ql,pr,qr] = pd_bc(xl,ul,xr,ur,t)
pl = ul;
ql = 0;
pr = pi * exp(-t);
qr = 1;
end


