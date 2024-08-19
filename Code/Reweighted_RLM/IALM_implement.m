mat = double(imread("Lena512.tif"))
% matrix values in rgb from 0 to 255
[nx,nx] = size(mat)

lambda = 1/sqrt(nx) % this is provided in research paper in one of the place

[A, E] = inexact_alm_rpca(mat, lambda)

sum(E)