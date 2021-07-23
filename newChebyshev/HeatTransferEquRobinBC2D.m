% Chebyshev Spectral Methods  2D Heat Transfer Problem Robin Boundary Condition
clear all;
dt = 0.01; 
t = 0:dt:1.05;
a = -1;
b = 1;
c = -1;
d = 1;

Nx = 30;
[Dx, xi] = cheb(Nx);
Dx = Dx / ((b - a) / 2);

Ny = 30;
[Dy, eta] = cheb(Ny); 
Dy = Dy / ((d - c)/2);

x = (a + b)/2 + xi * (b - a) / 2;
y = (c + d) / 2 + eta * (d - c) / 2;

%initial condition
for i = 1:length(y)
    for j = 1:length(x)
        u(i,j,1) = (1 + cos(pi * x(j))) * (1 + cos(pi * y(i))) ;
    end
end
uu(:,1) = reshape(u(:,:,1), (Ny + 1) * (Nx + 1), 1);

Dx2 = Dx^2;
I1 = eye(Ny + 1);
Lx = kron(Dx2, I1);

Dy2 = Dy^2;
I2 = eye(Nx + 1);
Ly = kron(I2, Dy2);

Lxy = Lx + Ly;

for kk = 2:length(t)
    L = eye((Nx + 1) * (Ny + 1)) / dt - Lxy;
    p = (eye((Nx + 1) * (Ny + 1)) / dt) * uu(:, kk - 1);
    for i = 1:Ny+1
        for j = 1:Nx+1
            k = (j-1)*(Ny+1) + i;
            I = eye((Nx+1)*(Ny+1));
            if(j==1)
                L(k,:)=0;
                L(k,k) = -1;
%                 L(k, k+1) = 1;
                L(k, k+Ny+1) = 1;
                p(k) = 0;
            elseif(j==Nx+1)
                L(k,:) = 0;
                L(k,k) = 1+10*(x(Nx+1)-x(Nx));
                L(k, k-Ny-1) = 1;
                p(k) = 0;
            elseif(i==1)
                L(k,:)=0;
                L(k,k) = -1;
                L(k,k+1) = 1;
                p(k) = 0;
            elseif(i==Ny+1)
                L(k,:)=0;
                L(k,k-1)=-1;
                L(k,k)=1;
                p(k)=0;
            end
        end
    end
    uu(:,kk) = L\p;
end

pic_num = 1
for k = 1:length(t)
    u_new(:,:,k) = reshape(uu(:,k), Ny+1,Nx+1);
    surf(x,y,u_new(:,:,k) );
    axis([-1, 1, -1, 1, 0, 4]);
    colorbar;
    colormap('cool');
    title(['t = ', num2str((k-1) * dt)]);
    xlabel('x');
    ylabel('y');
    zlabel('u(x,y,t)');
    drawnow;
    pause(0.03);
    
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