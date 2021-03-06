% p23.m - eigenvalues of perturbed Laplacian on [-1, 1] x [-1, 1]
%     (compare p16.m)
% Set up tensor product Laplacian and compute 4 eigenmedes:

N = 16;
[D, x] = cheb(N);
y = x;
[xx, yy] = meshgrid(x(2:N), y(2:N));
xx = xx(:); yy = yy(:);
D2 = D^2;
D2 = D2(2:N, 2:N);
I = eye(N - 1);
L = -kron(I, D2) - kron(D2, I);                  %Laplacian
% L = L + diag(exp(20 * (yy - xx - 1)));           % + perturbation
[V, D] =  eig(L);
D = diag(D);
[D, ii] =sort(D);
ii = ii(1:4);
V = V(:, ii);

% Resharp them to 2D grid, interpolate to finer grid, and plot:
[xx, yy] = meshgrid(x, y);
fine = -1:0.02:1;
[xxx, yyy] = meshgrid(fine, fine);
uu = zeros(N + 1, N+1);
[ay, ax] = meshgrid([0.56, 0.04], [0.1, 0.5]); clf
for i = 1:4
    uu(2:N, 2:N) = reshape(V(:, i), N-1, N-1);
    uu = uu / norm(uu(:), inf);
    uuu = interp2(xx, yy, uu, xxx, yyy, 'cubic');
    subplot('position', [ax(i) ay(i) 0.38 0.38])
    contour(fine, fine, uuu, -0.9:0.2:0.9)
    colormap([0 0 0]), axis square
    title(['eig = ' num2str(D(i) / pi^2/4, '%18.12f') '\pi^2/4'])
end