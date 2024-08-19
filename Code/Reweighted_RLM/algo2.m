function [X_star,E_star,obj_val] = algo2(M,W_X,W_E,lam,eta,del)

if isempty(del)
        del = 1.5; % Replace defaultValue1 with the actual default value
end
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
inneriter = 12;

obj_val = zeros(inneriter,1);

% there was a problem in inner iter  it should be less than 100 ...

while (norm(M-H-E,"fro")/norm(M,"fro"))>eps & (t < inneriter)
    % step -1
    L = M + X - E + (Y1*(1/mu)) + (Y2*(1/mu));
    % after this step image get sligtly brighter ( first iteration)
    % norm(L-M,"fro")
    % output - 38.9450 
    pho = eta/mu;
    % H_WX = NSVT(L,W_X)
    %  H_W = NSVT(L,W)
    % norm(L-H_WX,"fro") = 9.1883 image no destruction
    % norm(L-H_W,"fro") = 77.8043 destruction
    H = NSVT(L,W_X*(1/mu)) ;
    % modified H
    %H = NSVT(L,W_X) ; % for the first iteration it works well but after
                      % second iteration image again start vanishing or
                      % getting brighter and same thing happen as the
                      % animate show us,,i.e. image start to recover at the
                      % 8-10 iterations and after that it start
                      % disappearing final fully blank,. this implies that
                      % there is problem in update states due to mu del
                      % etc.(setting param's)  

    % step - 2
    R = H - Y2 ;
    X = FGP_fun(R,pho,2); % default N = 2 work
    imshow(X);

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

end
X_star = X;
E_star = E ;
end