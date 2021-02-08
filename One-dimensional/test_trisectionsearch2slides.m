close all
interval = [-2, 10];
%tol = 1e-13;
tol = 1e-10;
[xmin, fmin, neval] = trisectionsearch2slides(@f,interval,tol)