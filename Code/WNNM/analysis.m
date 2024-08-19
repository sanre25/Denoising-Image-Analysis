


oimg = imread("house.png");
oimg = im2gray(oimg);
oimg = double(oimg);
nsig = 100;
[n,n] = size(oimg);
M = oimg + nsig*randn(size(oimg)); % Noise 
M = M/255;
oimg = oimg/255;
imshow(M);
count1 = sum(M(:) > 1);

PSNR_Noise = psnr(oimg,M);

% WNNM Implementation
Par   = ParSet(nsig);
[X,objective] = WNNM_DeNoising( M, oimg, Par ); % one thing is observed that psnr value 
PSNR_Est = psnr(oimg,X);            % very high in first iteration then decrease
                                    % then increase but not attain value
                                    % which was attain in first iteration


% plot of obejctive value
iterations = 1:Par.Iter; 

plot(iterations, objective); % Create the line plot
xlabel('Iteration'); % Label for the x-axis
ylabel('Objective Value'); % Label for the y-axis
title('Objective Value vs. Iteration'); % Title for the plot
