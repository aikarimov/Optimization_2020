function [xmin, fmin, neval, coordinates] = dfpsearch(f,df,x0,tol)
% DFPSEARCH searches for minimum using Davidon–Fletcher–Powell method
% 	[xmin, fmin, neval] = DFPSEARCH(f,df,x0,tol)
%   INPUT ARGUMENTS
% 	f is a function handle
% 	df is a gradient function handle
%   x0 - starting point
% 	tol - tolerance for both range and function value
%   OUTPUT ARGUMENTS
% 	xmin is a function minimizer
% 	fmin = f(xmin)
% 	neval - number of function evaluations
%   coordinates is an array of the coordinates for each step
k = 1;
Kmax = 1000;
S0=eye(2);
d0=1;
interval = [-3;3];
coordinates = zeros(2,1000);
coordinates(:,1) = x0;
while(norm(d0) >= tol) && (k < Kmax)
    %recompute for k = k + 1
    g0=df(x0);
    d0 = -S0*g0;
    f1dim = @(al)(f(x0 + al*d0));
    [al,~,~] = goldensectionsearch(f1dim,interval,tol);
    
    x1 = x0 + al*d0;
    
    %update the coordinates
    coordinates(:,k+2) = x1;
    
    p0=al*d0;
    g1=df(x1);
    q0=g1-g0;
    %update the inverse Hessian approximation
    S1 = S0 +(p0*p0')/(p0'*q0) - ((S0*q0)*(q0'*S0))/(q0'*S0*q0);
    
    x0 = x1;
    S0=S1;
    k = k + 1;
    
end

xmin = x1;
fmin = feval(f,xmin);
neval = k;
end