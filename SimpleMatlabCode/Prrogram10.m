% p10.m - polynomials and corrseponding equipotential curves
N = 16;
clf
for i = 1:2
    if i == 1, 
         s = 'squispace points';
         x = -1 + 2 * (0:N)/N;
     end
     if i == 2,
         s = 'Chebyshev points';
         x = cos(pi * (0:N)/N);
     end
     
     p = poly(x);
     %plot p(x) over [-1,1]
     xx = -1:0.005:1;
     pp = polyval(p, xx);
     subplot(2,2,2*i-1)
     plot(x, 0*x, '.', 'markersize', 13), hold on
     plot(xx, pp, 'linewidth', 0.8), grid on
     set(gca, 'xtick', -1:0.5:1), title(s)
     %plot equipotential curve:
     subplot(2,2,2*i)
     plot(real(x), imag(x), '.', 'markersize', 13), hold on
     axis([-1.4 1.4 -1.12 1.12])
     xgrid = -1.40:0.02:1.40;
     ygrid = -1.12:0.02:1.12;
     [xx,yy] = meshgrid(xgrid, ygrid);
     zz = xx + 1i*yy;
     pp = polyval(p, zz);
     levels = 10.^(-4:0);
     contour(xx, yy, abs(pp), levels), title(s), colormap([0 0 0])
end