

function tv_norm = TV_norm(X)
    % Initialize the total variation norm to zero
    tv_norm = 0;
    
    % Get the size of the matrix
    [m, n] = size(X);
    
    % Calculate the square root term for the first part of the formula
    for i = 1:(m-1)
        for j = 1:(n-1)
            diff_i = X(i,j) - X(i+1,j); % Difference in i direction
            diff_j = X(i,j) - X(i,j+1); % Difference in j direction
            tv_norm = tv_norm + sqrt(diff_i^2 + diff_j^2);
        end
    end
    
    % Add the absolute differences along the last column
    for i = 1:(m-1)
        tv_norm = tv_norm + abs(X(i,n) - X(i+1,n));
    end
    
    % Add the absolute differences along the last row
    for j = 1:(n-1)
        tv_norm = tv_norm + abs(X(m,j) - X(m,j+1));
    end
end
