% p24.m - pseudospectra of Davies' complex harmonic oscillator
%         (for finer, slower plot, change 0:2 to 0:5
% Eigenvalues:
N = 70;
[D, x] = cheb(N); 
x = x(2:N);
L = 6;
x = L*x;
D = D/L;   %rescale to [-L, L]
A = -D^2;
A = A(2:N, 2:N) + (1 + 3i) * diag(x.^2);
clf, plot(eig(A), '.', 'markersize', 14);
axis([0 50 0 40]), drawnow, hold on

% Pseudospectra:
x = 0:0.5:50;
y = 0:0.5:40;
[xx, yy] = meshgrid(x,y);
zz = xx + 1i*yy;
I = eye(N-1);
sigmin = zeros(length(y), length(x));
h = waitbar(0, 'please wait ... ');
for j = 1:length(x), waitbar(j/length(x))
    for i = 1:length(y),
        sigmin(i, j) = min(svd(zz(i, j) * I - A));
    end
end
close(h)
contour(x, y, sigmin, 10.^(-4:0.5:-0.5)),
colormap([0 0 0])