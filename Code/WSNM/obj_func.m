function [obj_val] = obj_func(Y,X,NSig,c,lamada,p)
     % For a whole matrix n=1
     SigmaY =   svd(full(Y),'econ');
     SigmaX = svd(X);
     eps = 0.01;
     Temp         =   sqrt(max( SigmaY.^2 - NSig^2, 0 ));
     W_Vec    =   (c*NSig^2)./( Temp.^(1/p) + eps );
     obj_val = norm(Y-X,"fro")^2;
     obj_val = obj_val + lamada *sum(W_Vec .*(SigmaX.^p));
end