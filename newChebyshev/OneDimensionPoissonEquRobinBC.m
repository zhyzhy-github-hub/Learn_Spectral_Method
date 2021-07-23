% One dimension Poisson Euqation Robin BC
clear all; 
a = 0;
b = 1;
N = 20;
[D, xi] = cheb(N);
D = D / ((b - a) / 2);
x = (a + b) / 2 + xi * (b -a) / 2;
D2 = D^2;

% left BC
I = eye(N + 1);
D2(1, :) = D(1, :) - 1 * I(1, :);
% right BC
D2(N + 1, :) = 0;
D2(N + 1, N + 1) = 1;
f = zeros(N - 1, 1) + 1;
f = [0.1; f; 0];
u = D2\f; % Approximate solution

xx = 0:0.001:1;
u_ana = xx .^ 2 / 2 - 0.2 * xx - 0.3; % analytic solution

plot(x, u, 'ro', 'markersize', 10);
hold on;
plot(xx, u_ana, 'lineWidth', 2);
grid on
legend({'approximate solution', 'analytic solution'},'fontsize',20);
xlabel('x');
ylabel('y');

