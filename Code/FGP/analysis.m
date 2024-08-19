

oimg = im2double(imread("cameraman.tif"));
sig = 0.1;
b = oimg + randn(size(oimg))*(sig);

psnr_noise = 10*log10(1*1/var(oimg(:)-b(:)));
lam = 0.1;

% estimated
N = 30;
[X,objetive] = FGP_fun(b,lam,N,oimg);
imshow(X);
psnr_est = 10*log10(1*1/var(oimg(:)-X(:)));

% Plot of objective value
iterations = 1:N; 
figure;
plot(iterations, objetive); 
xlabel('Iteration'); 
ylabel('Objective Value'); 
title(sprintf('Objective Value vs. Iteration for sigma = %d', sig)); % Title for the plot