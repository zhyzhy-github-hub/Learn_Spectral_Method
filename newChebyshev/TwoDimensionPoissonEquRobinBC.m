% Two dimension Poisson Euqation with Robin BC
clear all;
a = -2; b = 2;
c = -2; d = 2;

Nx = 40;
[Dx, xi] = cheb(Nx);
Dx = Dx / ((b - a)/2);

Ny = 40;
[Dy, eta] = cheb(Ny);
Dy = Dy / ((d - c)/2);

x = (a + b)/2 + xi * (b - a) / 2;
y = (c + d) / 2 + eta * (d - c) / 2;

[xx, yy] = meshgrid(x, y);
xx = xx(:);
yy = yy(:);

f = sin((xx + 5) .* (yy + 2));

Dx2 = Dx^2;
I1 = eye(Ny + 1);
Lx = kron(Dx2, I1);
Hx = kron(Dx, I1);

Dy2 = Dy^2;
I2 = eye(Nx + 1);
Ly = kron(I2, Dy2);
Hy = kron(I2, Dy);
L = Lx + Ly;

for i = 1:Ny + 1
    for j = 1 : Nx + 1
        k = (j - 1) * (Ny + 1) + i;
        I = eye((Nx + 1) * (Ny + 1));
        if(i == 1 || i == Ny + 1)
            L(k, :) = Hy(k, :) + 10 * I(k, :);
            f(k, 1) = 10;
        elseif(j == 1 || j == Nx + 1)
            L(k, :) = Hx(k, :) + 10 * I(k, :);
            f(k, 1) = 10;
        end
    end
end

u = L \ f;
u_new = reshape(u, Ny + 1, Nx + 1);

surfc(x, y, u_new);
colorbar;
% colormap('summer')
colormap('cool')
xlabel('x','fontsize',24);
ylabel('y','fontsize',24);
zlabel('u(x,y)','fontsize',24);



