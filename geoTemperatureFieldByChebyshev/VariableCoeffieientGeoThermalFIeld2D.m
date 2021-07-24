% Variable Coefficient Geothermal Field Equation 2D
clear all;

cp = 1000;
rho = 3000;
rhocp = rho*cp;
a = 0;
b = 1000000;
xsize = b - a;
c = 0;
d = 1000000;
ysize = d - c;

Nx = 30*4;
[Dx, xi] = cheb(Nx);
Dx = Dx / ((b - a) / 2);

Ny = 30*4;
[Dy, eta] = cheb(Ny);
Dy = Dy / ((d - c) / 2);

x = (a + b) / 2 + xi  * (b - a)/2;
y = (c + d) / 2 + eta * (d - c)/2; 

for i = 1:Ny+1
    for j = 1:Nx+1
        k(i,j)=3;
        if(y(i)>ysize*0.3 && y(i)<ysize*0.7 ...
            && x(j)>xsize*0.3 && x(j)<xsize*0.7)
            k(i,j)=10;
        end
    end
end

dt = 5 * (1e+6 * 365.25 * 24 * 3600);
tsum = 600 * (1e+6 * 365.25 * 24 * 3600);
% tsum = 300 * (1e+6 * 365.25 * 24 * 3600);
t = 0:dt:tsum;

T_back = 1000;
T_wave = 1300;
T = zeros(Ny+1, Nx+1, length(t));

%initial temperature distribution
for i = 1:Ny+1
    for j = 1:Nx+1
        T(i,j,1)=T_back;
        if(y(i)>ysize*0.3 && y(i)<ysize*0.7 ...
            && x(j)>xsize*0.3 && x(j)<xsize*0.7)
            T(i,j,1)=T_wave;
        end
    end
end

TT(:,1) = reshape(T(:,:,1), (Ny+1) * (Nx+1), 1);

%Chebyshev Spectral method compution
k_new = reshape(k, (Nx+1) * (Ny+1), 1);
for i = 1:(Nx+1)*(Ny+1)
    K(:,i) = k_new;
end

K=sparse(K);

I1 = eye(Ny+1);
Lx = kron(Dx, I1)*(K.*kron(Dx,I1));

I2 = eye(Nx+1);
Ly = kron(I2, Dy)*(K.*kron(I2,Dy));
Lxy=Lx+Ly;

mymap = [254 229 217
        252 174 145
        251 106 74
        222 45  38
        165 15  21];
mymap = mymap / 255;

pic_num = 1

for n = 2:size(t,2)
    L=eye((Nx+1)*(Ny+1)) - (dt/rhocp)*Lxy;
    for i = 1:Ny+1
        for j = 1:Nx+1
            s = (j-1)*(Ny+1)+i;
            if(i==1 || i==Ny+1 || j==1 || j == Nx+1)
                L(s,:)=0;
                L(s,s)=1;
            end
        end
    end
    TT(:,n)=L\TT(:,n-1);
    
    %add B.C
    T(:,:,n) = reshape(TT(:,n), Ny+1, Nx+1);
    T(1,:,n) = T_back;
    T(Ny+1,:,n) = T_back;
    T(:,1,n) = T_back;
    T(:,Nx+1,n) = T_back;
    
    
    imagesc(x/1000, y/1000, T(:,:,n));
    colorbar;
    caxis([1000,1300])
    colormap(mymap);
    title(['numerical solution: t = ' num2str(t(n)/(1e+6 * 365.25 * 24 * 3600)), 'Ma']);
    xlabel('x(km)');
    ylabel('y(km)');
    zlabel('z(km)');
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
