% Homogeneous Dirichlet boundary condition 1D heat transfer problem
clear all;
dt = 0.1;
t = 0:dt:1; 
a = 0;
b = 1;
N = 30;
[D, xi] = cheb(N);
D = D / ((b - a) / 2);
x = (a + b) / 2 + xi * (b - a) / 2;

D2 = D^2;
D2 = D2(2:N, 2:N);
D2 = (dt / 4) * D2;

u(:, 1) = sin(pi * x); %Initial condition
u(1, :) = 0;  % BC
u(N + 1, :) = 0;

for i = 2:length(t)  % Approximate solution
    L = eye(N - 1) - D2;
    u(2:N, i) = L \ u(2:N, i -1);
end

[xx, tt] = meshgrid(x, t);  % analytic solution
for k = 1:length(t)
    for i = 1:length(x)
        u_true(i, k) = sin(pi * x(i)) * exp(-0.25 * pi * pi * tt(k));
    end
end

subplot(211);
surfc(x, t, u');
colorbar;
colormap('cool');
title('approximate solution','fontsize',24);
xlabel('x','fontsize',24);
ylabel('t','fontsize',24);
zlabel('u(x, t)','fontsize',24);

subplot(212);
surfc(x, t, u_true');
colorbar;
colormap('cool');
title('analytic solution','fontsize',24);
xlabel('x','fontsize',24);
ylabel('t','fontsize',24);
zlabel('u(x, t)','fontsize',24);
