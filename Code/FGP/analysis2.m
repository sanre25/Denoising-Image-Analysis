
oimg = im2double(imread("test_images/cameramen_test.jpg"));

n = 5;
nsig = [10,20,30,50,100];
psnr_noise = zeros(length(nsig),1);
psnr_estimate = zeros(length(nsig),1);
lam = 0.1;

% Create a new folder for saving the results
resultsFolder = 'DeNoisingResults';
mkdir(resultsFolder);

for iter = 1:n
    nimg = oimg + (nsig(iter)/255)*randn(size(oimg));
    psnr_noise(iter) = 10*log10(1*1/var(oimg(:)-nimg(:)));

    N = 30;
    [estimg,objetive] = FGP_fun(nimg,lam,N,oimg);
    psnr_estimate(iter) = 10*log10(1*1/var(oimg(:)-estimg(:)));
    % save img
    imwrite(nimg,fullfile(resultsFolder, sprintf('noise_sigma_%d.png',nsig(iter))));
    imwrite(estimg, fullfile(resultsFolder, sprintf('est_sigma_%d.png',nsig(iter))));
    
   % Plot of objective value
    iterations = 1:N; 
    figure;
    plot(iterations, objetive); 
    xlabel('Iteration'); 
    ylabel('Objective Value'); 
    title(sprintf('Objective Value vs. Iteration for sigma = %d', nsig(iter)));
    % Save the plot
    saveas(gcf, fullfile(resultsFolder, sprintf('Objective_vs_Iteration_sigma_%d.png',nsig(iter))));
    
    close(gcf); % Close the figure window to free up system resources
end