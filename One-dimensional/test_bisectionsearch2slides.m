close all
interval = [-2, 10];
tol = 1e-10;
[xmin, ~, neval] = bisectionsearch2slides(@f,@df,interval,tol)