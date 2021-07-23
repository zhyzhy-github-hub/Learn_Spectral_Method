% one dimension Homogeneous Poisson equ Dirichlet BC
clear all;
N = 20;
[D, x] = cheb(N);
D2 = D^2;
D2 = D2(2:N, 2:N);
f = zeros(N-1, 1) + 1;
u = D2\f;
u = [0;u;0]; %  Approximate solution

xx = -1:0.01:1;
u_ana = (xx.^2 - 1) / 2; %  Analytic solution

plot(x, u, 'ro');
hold on;
plot(xx, u_ana);
grid on
legend({'Approximate solution', 'Analytic solution'}, 'Fontsize', 18);
axis([-1.02, 1.02, -0.55, 0.05,]), 
xlabel('x');
ylabel('u');