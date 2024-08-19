function DW_X = NSVT(X,W)
% X is n x n and W is n x 1
[U, S, V] = svd(X);
[n,n] = size(X);
sigma = diag(S);

S_w = diag(max(sigma - W, zeros(n,1)));
DW_X = U * S_w * V' ;
end
%DW_X = U*S_w*transpose(V);
%disp(['Size of U: ', mat2str(size(U))]);
%disp(['Size of S_w: ', mat2str(size(S_w))]);
%disp(['Size of V: ', mat2str(size(V))]);

% testing input X and W_X of algo1
%nsvtmy = NSVT(X,W_X)
%nsvtgpt = NonUniformSVT2(X,W_X)
%norm(nsvtmy-nsvtgpt,"fro")
%norm(X-nsvtgpt,"fro")
%norm(X-nsvtmy,"fro")
% result no destruction of img
