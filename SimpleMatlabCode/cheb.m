% CHEB compute D = differentiation matrix, x = Chebyshev grid

function [ D,x ] = cheb( N )
%UNTITLED8 此处显示有关此函数的摘要
%   此处显示详细说明
if N==0, 
    D = 0;
    x=1;
    return,
end
x = cos(pi * (0:N)/N)';
c = [2; ones(N-1,1);2].*(-1).^(0:N)';
X = repmat(x,1,N+1);
dX = X - X';
D = (c*(1./c)')./(dX + (eye(N+1)));                % off-diagonal entries
D = D - diag(sum(D'));                                  % diagonal entries

end

