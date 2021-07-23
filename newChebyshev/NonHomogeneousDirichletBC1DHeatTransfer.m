% NonHomogeneous Dirichlet boundary condition 1D heat transfer problem
clear all;
dt = 0.005;
t = 0:dt:0.1; 
a = 0;
b = 1;
N = 50;
[D, xi] = cheb(N);
D = D / ((b - a) / 2);
x = (a + b) / 2 + xi * (b - a) / 2;

u(:,1) = 3 * sin(5 * pi * x) + 100 % initial condition

D2 = D^2;
D2 = (dt) * D2;

L = eye(N + 1) - D2;

L(1, :) = 0;
L(1, 1) = 1;
L(N + 1, :) = 0;
L(N + 1, N + 1) = 1;

for i = 2:length(t)  % Approximate solution
    u(1, i - 1) = 100;
    u(N + 1, i - 1) = 100;
    u(:, i) = L \ u(:, i -1);
end

[xx, tt] = meshgrid(x, t);  % analytic solution
for k = 1:length(t)
    for i = 1:length(x)
        u_true(i, k) = 100 + 3 * sin(5 * pi * x(i)) * exp(-25 * pi * pi * tt(k));
    end
end

subplot(211);
surfc(x, t, u');
colorbar;
colormap('cool');
shading flat;
title('approximate solution','fontsize',24);
xlabel('x','fontsize',24);
ylabel('t','fontsize',24);
zlabel('u(x, t)','fontsize',24);

subplot(212);
surfc(x, t, u_true');
shading flat;
colorbar;
colormap('cool');
title('analytic solution','fontsize',24);
xlabel('x','fontsize',24);
ylabel('t','fontsize',24);
zlabel('u(x, t)','fontsize',24);