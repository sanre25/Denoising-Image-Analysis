
oimg = im2double(imread("test_images/cameramen_test.jpg"));

n = 5;
nsig = [10,20,30,50,100];
psnr_noise = zeros(length(nsig),1);
psnr_estimate = zeros(length(nsig),1);

% Create a new folder for saving the results
resultsFolder = 'DeNoisingResults2';
mkdir(resultsFolder);

for iter = 1:n
    nimg = oimg + (nsig(iter)/255)*randn(size(oimg));
    psnr_noise(iter) = psnr(oimg,nimg);

    Par = ParSet(nsig(iter)/255);
    [estimg, objective] = WSNM_DeNoising(nimg, oimg, Par);
    psnr_estimate(iter) = psnr(oimg,estimg);
    

    imwrite(nimg,fullfile(resultsFolder, sprintf('noise_sigma_%d.png',nsig(iter))));
    % Save the denoised image
    imwrite(estimg, fullfile(resultsFolder, sprintf('est_sigma_%d.png',nsig(iter))));

    % Plot of objective value
    iterations = 1:Par.Iter; 
    figure;
    plot(iterations, objective); % Create the line plot
    xlabel('Iteration'); % Label for the x-axis
    ylabel('Objective Value'); % Label for the y-axis
    title(sprintf('Objective Value vs. Iteration for sigma = %d', nsig(iter))); % Title for the plot

    % Save the plot
    saveas(gcf, fullfile(resultsFolder, sprintf('Objective_vs_Iteration_sigma_%d.png',nsig(iter))));
    
    close(gcf); % Close the figure window to free up system resources
end