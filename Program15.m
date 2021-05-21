% p15.m - solve eigenvalue BVP u_xx = lambda * u, u(-1) = u(1) = 0
N = 36;
[D, x] = cheb(N);
D2 = D^2;
D2 = D2(2:N, 2:N);
[V, Lam] = eig(D2);
lam = diag(Lam);
[foo, ii] = sort(-lam);
lam = lam(ii);
V = V(:,ii); clf
for j = 5:5:30
    u = [0; V(:,j); 0];
    subplot(7, 1, j/5)
    plot(x, u, '.', 'markersize', 12), grid on
    xx = -1:0.01:1;
    uu = polyval(polyfit(x, u, N),xx);
    line(xx, uu, 'linewidth', 0.7), axis off
    text(-0.4, 0.5, sprintf('eig %d = %20.13f * 4 / pi^2', j, lam(j)*4/pi^2))
    text(0.7, 0.5, sprintf('%4.1f ppw', 4*N/(pi * j)))
end
    