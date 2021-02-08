close all
interval = [-2, 10];
tol = 1e-10;
[xmin, fmin, neval] = goldensectionsearch(@f,interval,tol)