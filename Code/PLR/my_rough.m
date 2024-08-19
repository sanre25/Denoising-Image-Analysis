
image = im2double(imread("Lena512.tif"));
imshow(image);
sigma = 50;

randn('seed', 0);
[nx,nx]=size(image);
noisy=image+(sigma/255)*randn(nx);
imshow(image);

PSNR1 = 10*log10(1*1/var(image(:)-noisy(:)));

tic
est  = plr(noisy,sigma); 
time=toc;

PSNR2 = 10*log10(1*1/var(image(:)-est(:)));
imshow(est);

%%% objective value calculation -- iteration is not used in this algorithm
thr=1.5*sigma; % given in paper;
mu = thr^2;
Y = noisy;
X = est;
obj_val = norm(Y-X,"fro")^2 + mu*rank(X);
norm(Y-X,"fro");
