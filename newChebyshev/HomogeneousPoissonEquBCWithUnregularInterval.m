% one dimension Nonhomogeneous Poisson equ Dirichlet BC with interval [a,b]
clear all
a = 0;
b = 1;
N = 20;
[D, xi] = cheb(N);
D = D / ((b - a) / 2);
x = (a + b) / 2 + xi * (b - a) / 2;

D2 = D^2;
D2 = D2(2:N, 2:N);
f = zeros(N - 1, 1) + 1;

u = D2\f;
u = [0;u;0] ; %  Approximate solution

xx = 0:0.001:1;
u_ana = (xx.^2 - xx) / 2; %  Analytic solution

plot(x, u, 'ro');
hold on;
plot(xx, u_ana);
grid on
legend({'Approximate solution', 'Analytic solution'}, 'Fontsize', 18);
% axis([-1.02, 1.02, 1.8, 3.05,]), 
xlabel('x', 'fontsize', 22);
ylabel('u', 'fontsize', 22);

