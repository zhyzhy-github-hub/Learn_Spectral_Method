%First derivative of using Chebyshev matrix
xx = -1 : 0.01 : 1;
uu = exp(xx) .* sin(5*xx);
for N = [10,20]
    [D,x] = cheb(N);
    u = exp(x).*sin(5*x);
    subplot('position', [0.15, 0.66-0.4*(N==20), 0.31, 0.28])
    plot(x, u, '.', 'markersize', 14);
    grid on
    line(xx, uu);
    title(['u(x),  N = ' int2str(N)]);
    xlabel('x');
    ylabel('u(x)');
    error = D*u - exp(x).*(sin(5*x) + 5 * cos(5*x));
    subplot('position', [0.55, 0.66-0.4*(N==20), 0.31, 0.28])
    plot(x, error, '.', 'markersize', 14);
    grid on
    line(x, error);
    title(['u''(x) error, N = ' int2str(N)]);
    xlabel('x');
    ylabel('D_N * u(x) - u(x)');
end