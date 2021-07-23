% Two dimension Homogeneous Poisson Equation
clear all;
N = 40;
[D, x] = cheb(N);
y = x;
[xx, yy] = meshgrid(x(2:N), y(2:N));
xx = xx(:); yy = yy(:);
f = 10 * sin(8 * xx .* (yy - 1));
D2 = D^2
D2 = D2(2:N, 2:N);
I = eye(N - 1);
L = kron(I, D2) + kron(D2, I);
u = L\f;
uu = zeros(N+1, N+1);
uu(2:N, 2:N) = reshape(u, N-1, N-1);
surfc(x, y, uu);
colorbar;
xlabel('x', 'fontsize', 20)
ylabel('y', 'fontsize', 20)
zlabel('u(x,y)', 'fontsize', 20)
