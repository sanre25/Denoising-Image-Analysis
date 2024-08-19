
% Input to the function
img = im2double(imread("Lena512.tif")) ;
% observed image
% Mean and standard deviation of the Gaussian noise
mean = 0;
sd = 0.1;
var = sd^2;
% Add Gaussian noise to the image
b = imnoise(img, 'gaussian', mean, var);

lamda = 0.1; % hyperparameter
N = 100; % number of iteration

% it should return a matrix of size as b

% Procedure

% Step - 0
[m,n] = size(b) ;
t = zeros(1,N) ;
t(1) = 1

prev_r = zeros(m-1, n);
prev_s = zeros(m, n-1);

prev_p = zeros(m-1, n);
prev_q = zeros(m, n-1);

% Step - k
for k = 1:N
   % [pres_p,pres_q] = [prev_r,prev_s] + (1/(8*lamda))*L_tr_fun(proj_C(b-lamda*L_fun(prev_r,prev_s),1,0));
   % 1 and 0 are upper and lower bound respectively [ub,lb] ..image value
   % to 1
    [res1,res2] = L_tr_fun(proj_C(b-lamda*L_fun(prev_r,prev_s),1,0));
    res1 = (1/(8*lamda))*res1;
    res2 = (1/(8*lamda))*res2;
    pres_p = prev_r + res1;
    pres_q = prev_s + res2;
    [pres_p,pres_q] = projection_pq_pho(pres_p,pres_q);

    t(k+1) = 1+sqrt(1+4*(t(k)^2));
    %[pres_r,pres_s] = [pres_p,pres_q] + (t(k)-1)/(t(k+1))*[pres_p-prev_p,pres_q-prev_q];
    %[res3,res4] = [pres_p-prev_p,pres_q-prev_q];
    res3 = pres_p-prev_p;
    res4 = pres_q-prev_q;
    res3 = ((t(k)-1)/(t(k+1)))*res3;
    res4 = ((t(k)-1)/(t(k+1)))*res4;
    pres_r = pres_p + res3;
    pres_s = pres_q + res4;
end

% last step
x_star = proj_C(b-lamda*L_fun(pres_p,pres_q),1,0);
