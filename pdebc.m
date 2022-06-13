function [pl,ql,pr,qr] = pdebc(xl,ul,xr,ur,t) % Boundary Conditions
pl = [ul(1)-0.05; 0; ul(3)-1; 0];
ql = [0; 1; 0; 1];
pr = [ur(1)-0.05; 0; ur(3)-1; 0];
qr = [0; 1; 0; 1];

% pl = [ul(1)-0.05; 0; ul(3)-1; ul(4)-1];
% ql = [0; 1; 0; 0];
% pr = [ur(1)-0.05; 0; ur(3)-1; ur(4)-1];
% qr = [0; 1; 0; 0];
end