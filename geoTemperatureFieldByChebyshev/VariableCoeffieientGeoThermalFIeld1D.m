% Variable Coefficient Geothermal Field Equation 1D
clear all;

cp = 1000;
rho = 3000;
rhocp = rho*cp;
a = 0;
b = 1000000;
xsize = b - a;
N = 300;
[D, xi] = cheb(N);
D = D / ((b - a) / 2);
x = (a + b) / 2 + xi * (b - a)/2;

for i = 1:N+1
    k(i) = 3;
    if(x(i) > xsize * 0.4 && x(i) < xsize * 0.6)
        k(i) = 10;
    end
end

dt = 5 * (1e+6 * 365.25 * 24 * 3600);
tsum = 600 * (1e+6 * 365.25 * 24 * 3600);
% tsum = 300 * (1e+6 * 365.25 * 24 * 3600);
t = 0:dt:tsum;

%set initial temperature distribution
T_back = 1000;
T_wave = 1300;
T = zeros(N, length(t));
for i = 1:N+1
    T(i, 1) = T_back;
    if(x(i) > xsize * 0.4 && x(i) < xsize * 0.6)
        T(i,1) = T_wave;
    end
end

%boundary condition
for n = 1:size(t,2)
    T(1,n) = T_back;
    T(N+1,n)=T_back;
end
K=zeros(N+1);
% D1
for j = 1:length(K)
    K(:,j) = k;
end

D_new = K.*D;
D2 = D * D_new;
D2 = (dt / rhocp)*D2;
L = eye(N+1) - D2;
L(1,:) = 0;
L(1,1) = 1;
L(N+1,:) = 0;
L(N+1,N+1) = 1;

pic_num = 1
for n = 2:length(t)
    T(:, n) = L \ T(:, n - 1);
    
    plot(x / 1000, T(:,n), 'r');
    axis([0 xsize / 1000 0.9*T_back 1.1*T_wave]);
    title(['numerical solution: t =', num2str(t(n) / (1e+6 * 365.25 * 24 * 3600)), 'Ma']);
    xlabel('x(km)');
    ylabel('Temperature(K)');
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