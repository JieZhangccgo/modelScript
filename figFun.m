function figFun(x,u1,u2,u3,u4)
figure(1);
subplot(2,2,1)
plot(x, u1(:,:));
title('C_{CO_2}(z,t)');
xlabel('Distance z');
ylabel('Concentration');

subplot(2,2,2)
plot(x, u2(:,:));
title('C_{DOC}(z,t)');
xlabel('Distance z');
ylabel('Concentration');

subplot(2,2,3)
plot(x, u3(:,:));
title('C_{O_2}(z,t)');
xlabel('Distance z');
ylabel('Concentration');
subplot(2,2,4)
plot(x, u4(:,:));
title('B(z,t)');
xlabel('Distance z');
ylabel('Concentration');
end