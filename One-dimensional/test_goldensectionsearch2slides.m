close all
interval = [-2, 10];
tol = 1e-10;
[xmin, ~, neval] = goldensectionsearch2slides(@f,interval,tol)