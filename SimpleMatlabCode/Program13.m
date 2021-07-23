% p13.m - solve linear BVP ux_xx = exp(4x),  u(-1) = u(1) = 0
% BVP------ Boundary value problem****************************
N = 16;
[D,x] = cheb(N);
D2 = D^2;
D2 = D2(2:N, 2:N);    % boundary conditions
f = exp(4*x(2:N));
u = D2\f;                  % Poisson eq. solved here
u = [0;u;0];
clf, subplot('position', [0.1 0.4 0.8 0.5])
plot(x, u, '.', 'markersize', 16)
xx = -1:0.01:1;
uu = polyval(polyfit(x,u,N), xx)   % interpolate grid data
line(xx, uu, 'linewidth', 0.9)
grid on
exact =( exp(4*xx) - sinh(4)*xx - cosh(4)) / 16;
title(['max err = ' num2str(norm(uu - exact, inf))], 'fontsize', 12)