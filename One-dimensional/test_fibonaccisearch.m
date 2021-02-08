close all
interval = [-2, 10];
%tol = 1e-13;
tol = 1e-5;
[xmin, fmin, neval] = fibonaccisearch(@f,interval,tol)