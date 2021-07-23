% one dimension Nonhomogeneous Poisson equ Dirichlet BC
clear all;
N = 20;
[D, x] = cheb(N);
D2 = D^2;
D2([1 N + 1], :) = 0;

D2(1,1) = 1;             % Nonhomogeneous   Dirichlet BC
D2(N+1, N+1) = 1;

f = zeros(N-1, 1) + 1;
f = [2; f; 3];

u = D2\f;  %  Approximate solution

xx = -1:0.01:1;
u_ana = xx.^2 / 2 + xx/2 + 2; %  Analytic solution

plot(x, u, 'ro');
hold on;
plot(xx, u_ana);
grid on
legend({'Approximate solution', 'Analytic solution'}, 'Fontsize', 18);
axis([-1.02, 1.02, 1.8, 3.05,]), 
xlabel('x');
ylabel('u');