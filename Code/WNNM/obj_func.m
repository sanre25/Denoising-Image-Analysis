
function [obj_val] = obj_func(Y,X,c)
     % For a whole matrix n=1
     S = svd(X);
     eps = 10^(-16);
     w = c ./(S+eps);
     obj_val = norm(Y-X,"fro")^2;
     obj_val = obj_val + sum(S.*w);
end