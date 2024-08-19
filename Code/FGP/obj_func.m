function obj_val = obj_func(b,X,lamada)
obj_val = norm(b-X,"fro")^2 + 2*lamada*TV_norm(X);
end