% Two Dimension Nonhomogeneous Poisson Equ Dirichlet BC
clear all;
a = 0; b = 10;
c = 0; d = 10;
Nx = 40;
[Dx, xi] = cheb(Nx);
Dx = Dx / ((b - a)/ 2);
Ny = 40;
[Dy, eta] = cheb(Ny);
Dy = Dy / ((d - c) / 2);
x = (a + b) / 2 + xi * (b - a) / 2;
y = (c + d) / 2 + eta * (d - c) / 2;
f = zeros((Nx + 1) * (Ny + 1), 1) + 1;

Dx2 = Dx^2;
I1 = eye(Ny + 1);
Lx = kron(Dx2, I1);

Dy2 = Dy^2;
I2 = eye(Nx + 1);
Ly = kron(I2, Dy2);

L = Lx + Ly;

% impose Dirichlet BC
for i = 1:Ny + 1
    for j = 1:Nx + 1
        k = (j - 1) * (Ny + 1) + i;
        if(i == 1 || j == 1 || j == Nx +1)
            L(k,:) = 0; 
            L(k,k) = 1;
            f(k,1) = 0;
        elseif(i == Ny + 1)
            L(k,:) = 0;
            L(k,k) = 1;
            f(k, 1) = 100;
        end
    end
end
u = L\f;
u_new = reshape(u, Ny+1, Nx+1);
contourf(x, y, u_new, 20);
% surfc(x, y, u_new);
colormap('cool')
colorbar;
xlabel('x');
ylabel('y');
zlabel('u(x,y)');
