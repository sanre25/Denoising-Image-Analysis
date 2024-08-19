function M_thresh = NonUniformSVT2(M, W)
    % Perform Singular Value Decomposition
    [U, S, V] = svd(M, 'econ');
    
    % Extract the diagonal elements (singular values) of S
    diagS = diag(S);
    
    % Apply Non-Uniform Thresholding to the singular values
    % Each singular value sigma_i is thresholded by lambda_i from vector W
    threshSingularValues = max(diagS - W(:), 0);
    
    % Construct the diagonal matrix of thresholded singular values
    S_thresh = diag(threshSingularValues);
    
    % Reconstruct the matrix using the thresholded singular values
    M_thresh = U * S_thresh * V';
end
