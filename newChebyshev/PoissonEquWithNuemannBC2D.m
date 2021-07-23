% 2D Poisson Euqation with Neumann BC
clear all;
a = 0; b = 1;
c = 0; d = 1;

Nx =40;
[Dx, xi] = cheb(Nx);
Dx = Dx / ((b - a) / 2);

Ny = 40;
[Dy, eta] = cheb(Ny);
Dy = Dy / ((d - c) / 2);

x = (a + b)/2 + xi * (b - a) / 2;
y = (c + d) / 2 + eta * (d - c) / 2;

[xx, yy] = meshgrid(x, y);
xx = xx(:);
yy = yy(:);
f = -13 * pi * pi * sin(3 * pi * xx + pi / 4) .* sin(2 * pi * yy + pi / 4);

Dx2 = Dx^2;
I1 = eye(Ny + 1);
Lx = kron(Dx2, I1);
Hx = kron(Dx, I1);

Dy2 = Dy^2;
I2 = eye(Nx + 1);
Ly = kron(I2, Dy2);

L = Lx + Ly;

for i = 1:Ny + 1
    for j = 1:Nx + 1
        k = (j - 1) * (Ny + 1) + i;
        if(i == 1 || i == Ny + 1)
            f(k, 1) = sin(pi / 4) * sin(3 * pi * xx(k) + pi / 4);
            L(k, :) = 0;
            L(k, k) = 1;
        elseif(j == 1)
            f(k,1) = 3 * pi * cos(pi / 4) * sin(2 * pi * yy(k) + pi / 4);
            L(k, :) = Hx(k, :);
        elseif(j == Nx + 1)
            f(k + 1) =  -3 * pi * cos(pi / 4) * sin(2 * pi * yy(k) + pi / 4);
            L(k, :) = Hx(k, :);
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
