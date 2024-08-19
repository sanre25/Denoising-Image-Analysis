function [X_star,E_star,obj_val] = algo2_copy(M,W_X,W_E,lam,eta,del)

[m,n] = size(M);
% initialise done using experimental setting section of paper
X =  zeros(m,n);
E =  zeros(m,n);
H =  zeros(m,n);
M_spec_norm = max(sqrt(eig(M.'*M))); % same as norm(M)
M_inf_norm = norm(M, inf);
scalar=(1 / max(M_spec_norm, (M_inf_norm / lam)));
Y1 = M * scalar;
Y2 = zeros(m,n);
mu = 0.25/norm(M);
eps = 1e-7;
t=0;
inneriter = 20;

% to store the objective
obj_val = zeros(inneriter,1);

% To save the results
resultsDir = 'results';
if ~exist(resultsDir, 'dir')
    mkdir(resultsDir);
end

while (norm(M-H-E,"fro")/norm(M,"fro"))>eps & (t < inneriter)
    % step -1
    L = M + X - E + (Y1*(1/mu)) + (Y2*(1/mu));
    pho = eta/mu;
    H = NSVT(L,W_X*(1/mu)) ;

    % step - 2
    R = H - Y2 ;
    X = FGP_fun(R,pho,2); % default N = 2 work
    % step - 3
    E = NST(M-H+Y1/mu ,(lam/mu)*W_E) ;

    % step - 4 & 5
    Y1 = Y1 + mu*(M-H-E);
    Y2 = Y2 + mu*(X-H) ;

    % step 6
    mu = del*mu;
    t = t + 1;
    obj_val(t) = obj_func(X,E,W_X,W_E,lam,eta);
    %disp("I am Inside while loop algo 2");

    % Save X as an image after each iteration
    % Formulate the file name with iteration number for uniqueness
    fileName = sprintf('%s/X_iteration_%d.png', resultsDir, t);
    imwrite(X, fileName);
end
X_star = X;
E_star = E ;
end
