function [x_star,objective] = FGP_fun(b,lamda,N,oimg)
% it should return a matrix of size as b

% Procedure

objective = zeros(N,1);
% Step - 0
[m,n] = size(b) ;
t = zeros(1,N) ;
t(1) = 1;

pres_r = zeros(m-1, n);
pres_s = zeros(m, n-1);

prev_p = zeros(m-1, n);
prev_q = zeros(m, n-1);

% Step - k
for k = 1:N
   % [pres_p,pres_q] = [prev_r,prev_s] + (1/(8*lamda))*L_tr_fun(proj_C(b-lamda*L_fun(prev_r,prev_s),1,0));
   % 1 and 0 are upper and lower bound respectively [ub,lb] ..image value
   % to 1
    [res1,res2] = L_tr_fun(proj_C(b-lamda*L_fun(pres_r,pres_s),1,0));
    res1 = (1/(8*lamda))*res1;
    res2 = (1/(8*lamda))*res2;
    pres_p = pres_r + res1;
    pres_q = pres_s + res2;
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
   
    % estimation after each iteration
    Xiter = proj_C(b-lamda*L_fun(pres_p,pres_q),1,0);
    psnr = 10*log10(1*1/var(oimg(:)-Xiter(:)));
    objective(k) = obj_func(b,Xiter,lamda);
    fprintf('Iteration: %d, PSNR: %.2f dB,Objective Value: %.2f \n', k, psnr,objective(k));

end

% last step
x_star = proj_C(b-lamda*L_fun(pres_p,pres_q),1,0);
end