close all
tol = 1e-10;
searchpos = [-2,1.6];
[xmin, ~, neval] = iqisearch(@f, @df, searchpos, tol)