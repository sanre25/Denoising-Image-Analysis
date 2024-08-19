
function [X_k,E_k] = algo1_SRLRMR(M)
[m,n] = size(M) ;
% initialise
eps = 1e-8;
k = 0;     % iteration track
maxiter = 1 ;

W_X = zeros(n,1);   
W_E = zeros(m,n) ;

eps_X = 0.01 ;
eps_E = 0.01 ;

lambda = 1/sqrt(m) ;
[X, E] = inexact_alm_rpca(M, lambda) ;
obj_val1 = obj_func(X,E,W_X,W_E,lam,eta);
PSNR2 = 10*log10(1*1/var(oimg(:)-X(:))); 


[U,S,V] = svd(X) ;

%W_X = 1/(diag(S) + eps_X);
myvec = diag(S) + eps_X ;
for i=1:n
    W_X(i,1) = 1/myvec(i);
end
%W_X = reshape(W_X, 512, 1);
 W_E = 1 ./ (abs(E) + eps_E);

 % 
while norm(M-X-E,"fro")/norm(M,"fro") > eps & (k < maxiter)
    % step 1 using algo 2 find X(k) and E(k)
    % input to the the algo 2 is W_E and W_E
    [X,E] = algo2(M,W_X,W_E,1/sqrt(max(m,n)), 0.0002/sqrt(m),1.5); % default del = 1.5 
    % in above func call instead of M, X can be passed (one possibility)
    % but no change 

    % Step - 2
    [U,S,V] = svd(X);
   % W_X = 1/(diag(S) + eps_X);
    myvec = diag(S) + eps_X ;
    for i=1:n
        W_X(i,1) = 1/myvec(i);
    end
    W_E = 1 ./ (abs(E) + eps_E);

    k = k + 1;
    disp("I am Inside while loop algo 1");
end
% X and E are final answer or output
X_k = X ;
E_k = E ;

end