% Neumann BC 1D equ
clear all;
a = 0;
b = 1;
N = 20;
[D, xi] = cheb(N);
x = (a + b) / 2 + xi * (b -a) / 2;
D = D / ((b - a) / 2);
D2 = D^2;

D2(1,:) = D(1,:); % Neumann BC D2 -> D
D2(N + 1, :) = 0; % Dirichlet BC
D2(N + 1, N + 1) = 1;

f = exp(x(1: N+1));
f(1) = 0;
f(N + 1) = 0;
u = D2 \ f;   % Approximate solution
xx = 0:0.001:1;
u_ana = exp(xx) - xx + (1 - exp(1)); % Analytic solution

plot(x, u, 'ro', 'markersize', 10);
hold on;
plot(xx, u_ana, 'lineWidth', 2);
grid on
legend({'approximate solution', 'analytic solution'},'fontsize',20);
xlabel('x');
ylabel('y');




