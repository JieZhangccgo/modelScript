close all;clear;clc
%%
% SCRIPT FILE FOR RUNNING THE REACTIVE TRANSPORT MODEL (a.k.a. the respiration-nitrification-denitrification model)
% AUTHOR: JIE ZHANG jiezh@agro.au.dk
%% Discretize space and define the output time invertals
x = linspace(0,0.1,51); % x[m] x = 10^(-3)*[0 20 32 36 40 44 48 52 56 60 64 68 80 100];
t = 0:6/24:28;  %linspace(0, 28, 29);% t[h] output time interval
m = 0;

% Load data
% Load initial measurements, sampling distance (icMesh) and measured values (icData)
% Load fixed parameters theta*R on LHS and diffusivities D(z) on RHS
measInfo; % load measurement data structure msInfo
% Load parameters
par=[0.2 0.2 0.08];
% paramters;

%
% Solve the pde system
sol = pdepe(m,@(x,t,u,dudx)pdefun(x,t,u,dudx,msInfo,par),@(x)pdeic(x,msInfo),@pdebc,x,t);
%%
u1 = sol(:,:,1); %CO2--1
u2 = sol(:,:,2);
u3 = sol(:,:,3); %O2--3
u4 = sol(:,:,4);
u5 = sol(:,:,5);
u6 = sol(:,:,6);
u7 = sol(:,:,7);
u8 = sol(:,:,8); %N2O--8
u9 = sol(:,:,9);
u10 = sol(:,:,10); %N2--10
u11 = sol(:,:,11);
% plotting
figFun(x,u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11);

% Gas emission rate
% flux = Deff/dx*dc
D = 1;
dt = t(2);
J_CO2 = 2*D*(u1(:,2) - u1(:,1))/dt;
J_N2O = 2*D*(u8(:,2) - u8(:,1))/dt;
J_N2 = 2*D*(u10(:,2) - u10(:,1))/dt;

figure(2);
subplot(2,2,1)
plot(t, J_CO2);

subplot(2,2,2)
plot(t, J_N2O);

subplot(2,2,3)
plot(t, J_N2);

subplot(2,2,4)
plot(t, J_N2O);
hold on
plot(t, J_N2);

%%
% filename = sprintf('CO2.gif');
% h=figure;
% firstrun=1;
% for i = 1:length(t)
%     plot(x,u1(i,:),'color',blueGRADIENTflexible(i,length(t))); %loop over all curves in plot
%     hold on
%     
%     xlabel('Depth')
%     ylabel('C_{CO_2}')
%     
%     drawnow
%     frame = getframe(h); 
%     im = frame2im(frame); 
%     [imind,cm] = rgb2ind(im,256); 
%         % Write to the GIF File 
%     if firstrun == 1 
%         imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
%         firstrun=2;
%     else 
%         imwrite(imind,cm,filename,'gif','WriteMode','append', 'delaytime', 0.1); 
%     end 
% end
% box off
% %%
% filename = sprintf('all.gif');
% h=figure;
% firstrun=1;
% for i = 1:length(t)
%     subplot(2,2,1);
%     plot(x,u1(i,:),'color',blueGRADIENTflexible(i,length(t))); %loop over all curves in plot
%     xlabel('Depth')
%     ylabel('C_{CO_2}')
%     hold on 
%     
%     subplot(2,2,2);
%     plot(x,u2(i,:),'color',blueGRADIENTflexible(i,length(t))); %loop over all curves in plot
%     xlabel('Depth')
%     ylabel('C_{DOC}')
%     hold on 
% 
%     subplot(2,2,3);
%     plot(x,u3(i,:),'color',blueGRADIENTflexible(i,length(t))); %loop over all curves in plot
%     xlabel('Depth')
%     ylabel('C_{O_2}')
%     hold on 
%     
%     subplot(2,2,4);
%     plot(x,u4(i,:),'color',blueGRADIENTflexible(i,length(t))); %loop over all curves in plot
%     xlabel('Depth')
%     ylabel('C_{microbe}')
%     
%     hold on 
%     drawnow
%     frame = getframe(h); 
%     im = frame2im(frame); 
%     [imind,cm] = rgb2ind(im,256); 
%         % Write to the GIF File 
%     if firstrun == 1 
%         imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
%         firstrun=2;
%     else 
%         imwrite(imind,cm,filename,'gif','WriteMode','append', 'delaytime', 0.1); 
%     end 
% end
% box off