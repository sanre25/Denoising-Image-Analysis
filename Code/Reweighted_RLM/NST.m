function SW = NST(X,W)
% X and W should be same size m*n
[m,n] = size(X);
SW = sign(X)*max(abs(X)-W,zeros(m,n));
end
