function [xmin, fmin, neval, coordinates] = prsearch(f,df,x0,tol)
% prsearch searches for minimum using Polak-Ribiere method
% 	[xmin, fmin, neval, coordinates] = prsearch(f,df,x0,tol)
%   INPUT ARGUMENTS
% 	f is a function handle
% 	df is a gradient function handle
%   x0 is a starting point
% 	tol is a tolerance for both range and function value
%   OUTPUT ARGUMENTS
% 	xmin is a function minimizer
% 	fmin = f(xmin)
% 	neval is a number of function evaluations
%   coordinates is an array of the coordinates for each step

k = 0;
Kmax = 1000;
df0=df(x0);
g0=df0;
p0=-g0;
interval = [-3;3];
coordinates = zeros(2,1000);
coordinates(:,1) = x0;
while((norm(g0) >= tol) && (k < Kmax))
    f1dim = @(al)(f(x0 + al*p0));
    [al,~,~] = goldensectionsearch(f1dim,interval,tol);
    
    x1 = x0 + al*p0;
    
    %update the coordinates
    coordinates(:,k+2) = x1;
    
    g = df(x1);
    b=(g'*(g-g0))/(g0'*g0); %Polak-Ribiere coefficient
    %for direction reset
    if b<0
        b=0;
    end
    p = -g+b*p0;
    
    if(norm(x1-x0)<tol)
        break;
    end
    x0 = x1;
    
    g0 = g;
    p0 = p;
    k = k + 1;
end

xmin = x1;
fmin = f(xmin);
neval = k;
end