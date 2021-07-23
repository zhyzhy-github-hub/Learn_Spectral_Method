%EquidistantPointOrChebyshev
N = 20;
xx = -1.01:0.005:1.01;
for i = 1:2
    if i == 1
        s = 'Equidistant point';
        x = -1 + 2 * (0:N) / N;
    end
    if i == 2
        s = 'Chebyshev point';
        x = -cos(pi * (0:N) / N);
    end
    subplot(1,2,i)
    u = 1./(1 + 16 * x.^2);
    uu = 1./(1 + 16 * xx.^2);
    p = polyfit(x, u , N);
    pp = polyval(p, xx);
    plot(x, u, 'o', 'markersize', 10)
    line(xx, pp)
    axis([-1.1, 1.1, -1. 1.5]), 
    title(s)
    error = norm(uu - pp, inf);
    text(-0.5, -0.5, ['max error = ' num2str(error)], 'Fontsize',14)
    xlabel('x');
    ylabel('u(x)');
end
