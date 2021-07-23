% Two dimension Homogeneous Poisson Equation with Unregular Interval
clear all;
a = 0;
b = 20;
c = 0; 
d = 10;
Nx = 40;
[Dx, xi] = cheb(Nx);
Dx = Dx / ((b - a) / 2);
Ny = 20;
[Dy,eta] = cheb(Ny); 
Dy = Dy / ((d - c) / 2);

x = (a + b) / 2 + xi * (b - a) / 2;
y = (c + d) / 2 + eta * (d - c) / 2;
f = zeros((Nx - 1) * (Ny - 1), 1) + 1;

Dx2 = Dx^2;
Dx2 = Dx2(2:Nx, 2:Nx);
I1 = eye(Ny - 1);
Lx = kron(Dx2, I1);

Dy2 = Dy^2;
Dy2 = Dy2(2:Ny, 2:Ny);
I2 = eye(Nx - 1);
Ly = kron(I2, Dy2);

L = Lx + Ly;
u = L\f;
uu = zeros(Ny + 1, Nx + 1);
uu(2:Ny, 2:Nx) = reshape(u, Ny - 1, Nx - 1);

surfc(x, y, uu);
colorbar;
xlabel('x');
ylabel('y');
zlabel('u(x, y)');