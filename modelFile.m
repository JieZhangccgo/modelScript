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
% Load fixed parameters theta*R on LHS and diffusivities D(z) on RHS
ICdata;
% Load parameters
par=[0.2 0.2 0.8];
% paramters;

%%
% Solve the pde system
sol = pdepe(m,@(x,t,u,dudx)pdefun(x,t,u,dudx,yMesh,data_thetaR, data_Deff,par),@(x)pdeic(x,icMesh,icData),@pdebc,x,t);
%%
u1 = sol(:,:,1);
u2 = sol(:,:,2);
u3 = sol(:,:,3);
u4 = sol(:,:,4);
u5 = sol(:,:,5);
u6 = sol(:,:,6);
u7 = sol(:,:,7);
u8 = sol(:,:,8);
u9 = sol(:,:,9);
%% plotting
figFun(x,u1,u2,u3,u4,u5,u6,u7,u8,u9);

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