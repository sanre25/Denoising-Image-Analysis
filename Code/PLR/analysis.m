
oimg = im2double(imread("test_images/cameramen_test.jpg"));

n = 5;
nsig = [10,20,30,50,100];
psnr_noise = zeros(length(nsig),1);
psnr_estimate = zeros(length(nsig),1);
obj_val = zeros(length(nsig),1);

% Create a new folder for saving the results
resultsFolder = 'DeNoisingResults';
mkdir(resultsFolder);

for iter = 1:n
    nimg = oimg + (nsig(iter)/255)*randn(size(oimg));
    psnr_noise(iter) = 10*log10(1*1/var(oimg(:)-nimg(:)));

    estimg = plr(nimg,nsig(iter)); 
    psnr_estimate(iter) = 10*log10(1*1/var(oimg(:)-estimg(:)));

    imwrite(nimg,fullfile(resultsFolder, sprintf('noise_sigma_%d.png',nsig(iter))));
    imwrite(estimg, fullfile(resultsFolder, sprintf('est_sigma_%d.png',nsig(iter))));

    % calcluating objective value
    %%% objective value calculation -- iteration is not used in this algorithm
    thr=1.5*nsig(iter); % given in paper;
    mu = thr^2;
    Y = nimg;
    X = oimg;
    obj_val(iter) = norm(Y-X,"fro")^2 + mu*rank(X);
    disp(["Norm of Y-X for succesive sigmas",norm(Y-X,"fro")]);
end