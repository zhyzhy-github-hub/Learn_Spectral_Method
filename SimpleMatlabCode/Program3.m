% p3.m - band-limited interpolation

h = 1;
xmax = 10; 
clf
x = -xmax:h:xmax                               %computeional grid
xx = -xmax - h / 20 : h / 10 : xmax + h / 20;  %poltting grid
for plt = 1:3
    subplot(4, 1, plt)
    switch plt
        case 1, v = (x == 0);                 % delta function
%         case 2, v = (abs(x) <= 3);            % square wave
        case 2, v = (((x.^3   x)));             

        case 3, v = max(0, 1 - abs(x) / 3)    % hat function
    end
    plot(x, v, '.', 'markersize', 14),
    grid on;
    p = zeros(size(xx));
    for i = 1:length(x)
        p = p + v(i) * sin(pi * (xx - x(i)) / h) ./ (pi * (xx - x(i)) / h);
    end
    line(xx, p, 'linewidth', .7),
%     axis([-xmax xmax -0.5 1.5])
    axis([-xmax xmax min(p), max(p)])
%     set(gca, 'xtick', []),
    
%     set(gca, 'ytick', [0 1])
end