close all
interval = [-2, 7];
tol = 0.01;
[xmin, ~, neval] = newtonsearch(@f,@df,interval,tol,1.3)