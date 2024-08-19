
%oimg = imread("Lena512.tif");

% experiment with smaller size 256*256
%oimg = imread("test_img\house256.tif");

oimg = imread("test_img\house64.jpg");
oimg = im2gray(oimg);
oimg = double(oimg);
imshow(oimg,[0,255]);
sig = 40;
M = oimg + sig*randn(size(oimg));
M = M/255;
oimg = oimg/255;
imshow(M);

% To save the results
resultsDir = 'results';
if ~exist(resultsDir, 'dir')
    mkdir(resultsDir);
end

PSNR_Noise = 10*log10(1*1/var(oimg(:)-M(:)));

fileName = fullfile(resultsDir, 'Noise.png');
imwrite(M, fileName);

% Enter in Algo-1
[m,n] = size(M) ;
eps = 1e-8;
k = 0;     % iteration track
maxiter = 1 ;

W_X = zeros(n,1);   
W_E = zeros(m,n) ;

eps_X = 0.01 ;
eps_E = 0.01 ;

lambda = 1/sqrt(m) ;
[X, E] = inexact_alm_rpca(M, lambda) ;

% for Algo-2 : Parameters
lam = 1/sqrt(max(m,n));
eta = 0.0002/sqrt(m);
del = 1.5;

Obj_IALM = obj_func(X,E,W_X,W_E,lam,eta);
PSNR_IALM = 10*log10(1*1/var(oimg(:)-X(:)));

[U,S,V] = svd(X) ;

%W_X = 1/(diag(S) + eps_X);
myvec = diag(S) + eps_X ;
for i=1:n
    W_X(i,1) = 1/myvec(i);
end
%W_X = reshape(W_X, 512, 1);
 W_E = 1 ./ (abs(E) + eps_E);

fileName = fullfile(resultsDir, 'E_IALM.png');
imwrite(X, fileName);

% While loop of algo 1
while norm(M-X-E,"fro")/norm(M,"fro") > eps & (k < maxiter)
    % input to the the algo 2 is W_E and W_E
    [X,E,obj_val] = algo2_copy(M,W_X,W_E,lam,eta,del); % default del = 1.5 
    PSNR_algo2 =  10*log10(1*1/var(oimg(:)-X(:)));

    [U,S,V] = svd(X);
    myvec = diag(S) + eps_X ;
    for i=1:n
        W_X(i,1) = 1/myvec(i);
    end
    W_E = 1 ./ (abs(E) + eps_E);
    k = k + 1;
    disp("I am Inside while loop algo 1");
end

x = 1:20;
plot(x,log(obj_val));
xlabel('ineriter-Algo2');
ylabel('log(Objective Value)');
title('log-Objective Value vs. X');