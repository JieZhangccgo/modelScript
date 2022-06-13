close all;clear;clc
%%
% SCRIPT FILE FOR RUNNING THE REACTIVE TRANSPORT MODEL (a.k.a. the respiration-nitrification-denitrification model)
% AUTHOR: JIE ZHANG 
%% Discretize space and define the output time invertals
x = linspace(0,1,25);
t = linspace(0,0.2,20);% output time interval
m = 0;

%% Load data
% Load initial measurements, sampling distance (icMesh) and measured values (icData)
icMesh = [0 0.39 0.41 0.59 0.61 1];
icData = [0.05 0.05 0.05 0.05 0.05 0.05; 0, 0, 1, 1, 0, 0; 1, 1, 0.2, 0.2, 1, 1; 1, 1, 1, 1, 1, 1];
% Load fixed parameters theta*R on LHS and diffusivities D(z) on RHS
yMesh = [0 0.2 0.3 0.6 0.8 1];
data_Deff = [0.5 0.6 0.7 0.8 0.6 0.5; 0.5 0.6 0.7 0.8 0.6 0.5; 0.5 0.6 0.7 0.8 0.6 0.5; 0 0 0 0 0 0]; % Define a matrix data_Deff of sampling values vectors v1..v4
data_thetaR = [0.5 0.6 0.7 0.8 0.6 0.5; 0.5 0.6 0.7 0.8 0.6 0.5; 0.5 0.6 0.7 0.8 0.6 0.5; 1 1 1 1 1 1];  
% Load parameters
par=[0.2 0.2 0.8];
% paramters;
% Solve the pde system
sol = pdepe(m,@(x,t,u,dudx)pdefun(x,t,u,dudx,yMesh,data_thetaR, data_Deff,par),@(x)pdeic(x,icMesh,icData),@pdebc,x,t);

u1 = sol(:,:,1);
u2 = sol(:,:,2);
u3 = sol(:,:,3);
u4 = sol(:,:,4);

%% plotting
figFun(x,u1,u2,u3,u4);
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