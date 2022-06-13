function figFun(x,u1,u2,u3,u4,u5,u6,u7,u8,u9)
figure(1);

subplot(3,3,1)
N = size(u1,1);
for i=1:N
    plot(x, u1(i,:),'Color', blueGRADIENTflexible(i,N));
    hold on
end
title('C_{CO_2}(z,t)');
xlabel('Distance z');
ylabel('Concentration');

subplot(3,3,2)
for i=1:N
    plot(x, u2(i,:),'Color', blueGRADIENTflexible(i,N));
    hold on
end
title('C_{DOC}(z,t)');
xlabel('Distance z');
ylabel('Concentration');

subplot(3,3,3)
for i=1:N
    plot(x, u3(i,:),'Color', blueGRADIENTflexible(i,N));
    hold on
end
title('C_{O_2}(z,t)');
xlabel('Distance z');
ylabel('Concentration');

subplot(3,3,4)
for i=1:N
    plot(x, u4(i,:),'Color', blueGRADIENTflexible(i,N));
    hold on
end
title('B_het(z,t)');
xlabel('Distance z');
ylabel('Concentration');

subplot(3,3,5)
for i=1:N
    plot(x, u5(i,:),'Color', blueGRADIENTflexible(i,N));
    hold on
end
title('C_{NH4}(z,t)');
xlabel('Distance z');
ylabel('Concentration');

subplot(3,3,6)
for i=1:N
    plot(x, u6(i,:),'Color', blueGRADIENTflexible(i,N));
    hold on
end
title('C_{NO2}(z,t)');
xlabel('Distance z');
ylabel('Concentration');

subplot(3,3,7)
for i=1:N
    plot(x, u7(i,:),'Color', blueGRADIENTflexible(i,N));
    hold on
end
title('C_{NO3}(z,t)');
xlabel('Distance z');
ylabel('Concentration');

subplot(3,3,8)
for i=1:N
    plot(x, u8(i,:),'Color', blueGRADIENTflexible(i,N));
    hold on
end
title('C_{N2O}(z,t)');
xlabel('Distance z');
ylabel('Concentration');

subplot(3,3,9)
for i=1:N
    plot(x, u9(i,:),'Color', blueGRADIENTflexible(i,N));
    hold on
end
title('B_nit(z,t)');
xlabel('Distance z');
ylabel('Concentration');
end