xMesh = [0 0.4 0.6 1];
icData = [0.5 0.5 0.5 0.5; 0, 1, 1, 0; 1, 0.2, 0.2, 1];
a=pdeic(0.5)
b=pdeicv1(0.5)
%% 
x = (-5:5);
v1 = x.^2;
v2 = 2*x.^2 + 2;
v3 = 3*x.^2 + 4;
v = [v1;v2;v3];
xq = -5:0.1:5;
vq = interp1(x,v',xq,'pchip');
figure
plot(x,v,'o',xq,vq);

h = gca;
h.XTick = -5:5;
%%
% How to use interp1 to interpolate multiple sets of data
yMesh = [0 0.2 0.3 0.6 0.8 1];%Define the sample points.
data_Deff = [0.5 0.6 0.7 0.8 0.6 0.5; 0.5+0.1 0.6+0.1 0.7+0.1 0.8+0.1 0.6+0.1 ...
    0.5+0.1; 0.5+0.2 0.6+0.2 0.7+0.2 0.8+0.2 0.6+0.2 0.5+0.2; 0 0 0 0 0 0]; % Define a matrix data_Deff of sampling values vectors v1..v4
D = interp1(yMesh,data_Deff',0:0.01:1,'pchip')'; % create a matrix data_Deff', whose COLUMNS are vectors v1..v4
figure
plot(yMesh,data_Deff,'o',0:0.01:1,D);

%%

yMesh = [0 0.2 0.3 0.6 0.8 1]; %Define the sample points.
yData = [0.5 0.6 0.7 0.8 0.6 0.5];  %
thetaR = interp1(yMesh,yData,0:0.01:1,'pchip')';
figure
plot(yMesh,yData,'o',0:0.01:1,thetaR);
A=[3-2
    4];
initcond;
%%
function u0 = pdeic(x) % Initial Conditions
u0 = [0.05; 0; 1];
if x >= 0.4 && x <= 0.6
  u0(1) = 0.05;
  u0(2) = 1;
  u0(3) = 0.2;
end
end
function u0 = pdeicv1(x)
xMesh = [0 0.4 0.6 1];
icData = [0.5 0.5 0.5 0.5; 0, 1, 1, 0; 1, 0.2, 0.2, 1];
u0 = interp1(xMesh,icData',x,'pchip')
end
