% Two Dimension Wave equation
clear all
dx = 0.02;
dy = 0.02;
dt = 0.01;
x = 0 : dx : 1;
y = 0 : dy : 1;
t = 0 : dt : 2;
[X,Y] = meshgrid(x,y);
u = zeros(size(y,2), size(x,2), size(t,2)); 

pic_num = 1;
for k = 1:size(t,2)
    u(:,:,k) = sin(pi * X) .* sin(pi * Y) * cos(pi * t(k));
    
    surf(x, y, u(:, :, k));
    colormap('jet');
    colorbar;
    caxis([-1,1])
    title(['analytic solution : t = ', num2str((k - 1) * dt)]);
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