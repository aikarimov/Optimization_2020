close all
interval = [-2, 10];
tol = 1e-6;
[xmin, ~, neval] = secantsearchsecants(@f,@df,interval,tol)