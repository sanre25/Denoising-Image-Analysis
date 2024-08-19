oimg = im2double(imread("Lena512.tif"));
% matrix values in rgb from 0 to 1
[ nx,nx] = size(oimg);

sig = 0.1;
noise = oimg + sig*randn(size(oimg));
psnr_noise=10*log10(1*1/var(oimg(:)-noise(:)));
lambda = 1/sqrt(nx); % this is provided in research paper in one of the place

[A, E,iter,objective] = inexact_alm_rpca(noise, lambda);
psnr_est=10*log10(1*1/var(oimg(:)-A(:)));

% Plot of objective value
    iterations = 1:iter; 
    objective = cell2mat(objective).';
    figure;
    plot(iterations, objective); % Create the line plot
    xlabel('Iteration'); % Label for the x-axis
    ylabel('Objective Value'); % Label for the y-axis
    title(sprintf('Objective Value vs. Iteration for sigma = %d', nsig(iter)));

