

% chek-in algo 2
[m,n] = size(M);
lam = 1/sqrt(max(m,n));
eta = 0.0002/sqrt(m);
del = 1.5;


oimg = imread("Lena512.tif");
oimg = double(oimg);
imshow(oimg,[0,255]);
sig = 20;
M = oimg + sig*randn(size(oimg));
M = M/255;
oimg = oimg/255;
imshow(M);
histogram(M);

PSNR1 = 10*log10(1*1/var(oimg(:)-M(:)));


% subplot(1, 3, 1);
% imshow(M)
% subplot(1, 3, 2);
% imshow(N)
% subplot(1, 3, 3);
% imshow(X_k);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% experiment with smaller size 256*256
oimg = imread("test_img\house256.tif");
oimg = double(oimg);
imshow(oimg,[0,255]);
sig = 40; % increase in sig decrease the inneriter of algo 2
M = oimg + sig*randn(size(oimg));
M = M/255;
oimg = oimg/255;
imshow(M);
histogram(M);

PSNR1 = 10*log10(1*1/var(oimg(:)-M(:)));
% enter in algo 1


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% experiment with smaller size 64*64

oimg = imread("test_img\house64.jpg");
oimg = im2gray(oimg);
oimg = double(oimg);
imshow(oimg,[0,255]);
sig = 20;
M = oimg + sig*randn(size(oimg));
M = M/255;
oimg = oimg/255;
imshow(M);
histogram(M);

PSNR1 = 10*log10(1*1/var(oimg(:)-M(:)));
% enter in algo 1











