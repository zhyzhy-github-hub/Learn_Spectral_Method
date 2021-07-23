% Two Dimension Wave equation Chebyshev Method
clear all;
dt = 0.001;
t = 0:dt:0.2*10;
a = 0; b = 1;
c = 0; d = 1;

Nx = 30;
[Dx, xi] = cheb(Nx);
Dx = Dx / ((b - a) / 2);

Ny = 30;
[Dy, eta] = cheb(Ny);
Dy = Dy / ((d - c) / 2);

x = (a + b) / 2 + xi  * (b - a) / 2;
y = (c + d) / 2 + eta * (d - c) / 2;

%initial condition
for i = 1:length(y)
    for j = 1:length(x)
        u(i,j,1) = sin(pi * x(j)) * sin(pi * y(i));
        u(i,j,2) = sin(pi * x(j)) * sin(pi * y(i)) + 0 * dt;
    end
end

uu(:,1) = reshape(u(2:Ny, 2:Nx, 1), (Ny - 1) * (Nx - 1), 1);
uu(:,2) = reshape(u(2:Ny, 2:Nx, 2), (Ny - 1) * (Nx - 1), 1);

Dx2 = Dx^2;
Dx2 = Dx2(2:Nx, 2:Nx);
I1 = eye(Ny - 1);
Lx = kron(Dx2, I1);

Dy2 = Dy^2;
Dy2 = Dy2(2:Ny, 2:Ny);
I2 = eye(Nx - 1);
Ly = kron(I2, Dy2);

Lxy = Lx + Ly;

for k = 3:length(t)
    I = eye((Nx - 1) * (Ny - 1));
    L = I / dt / dt - Lxy / 2;
    P = (2 / dt / dt) * uu(:, k-1) - (1 / dt / dt) * uu(:, k - 2);
    uu(:, k) = L \ P;
end

pic_num = 1
for k = 1:10:length(t)
    u_new(:,:,k) = zeros(Ny + 1, Nx + 1);
    u_new(2:Ny, 2:Nx, k) = reshape(uu(:,k), Ny - 1, Nx -1);
    
    surf(x, y, u_new(:, :, k));
    colormap('cool');
    colorbar;
    caxis([-1,1])
    title(['approximate solution : t = ', num2str((k - 1) * dt)]);
    set(gca, 'XLim', [0, 1]);
    set(gca, 'YLim', [0, 1]);
    set(gca, 'ZLim', [-1, 1]);
    xlabel('x');
    ylabel('y');
    zlabel('u');
    shading flat;
    drawnow;
    pause(0.01);
    
    F=getframe(gcf);
    I=frame2im(F);
    [I,map]=rgb2ind(I,256);
    if pic_num == 1
        imwrite(I,map,'test.gif','gif', 'Loopcount',inf,'DelayTime',0.2);
    else
        imwrite(I,map,'test.gif','gif','WriteMode','append','DelayTime',0.2);
    end
    pic_num = pic_num + 1;
end
