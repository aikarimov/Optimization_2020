close all
tol = 1e-5;
searchpos = [-2,1];
[xmin, ~, neval] = mullersearch(@f, @df, searchpos, tol)