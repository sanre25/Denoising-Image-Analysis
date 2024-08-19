
function obj_val = obj_func(X,E,W_X,W_E,lam,eta)

S = svd(X);
sigma = S;

obj_val = sum(sigma.*W_X) + lam*(max(sum(abs(W_E.*E)))) + eta*TV_norm(X);

end

% Implementation of Objective Function
% It return the value of obj func at given velues - Scaler
% Input :- X, E, W_X, W_E, lam, eta

% random matrix
% X = randi([1, 10], 3, 3);
% E = rand([3, 3]);
% W_X = randi([1,5],3,1);
% W_E = randi([1,5],3,3);
% lam = 0.2;
% eta = 0.001;

