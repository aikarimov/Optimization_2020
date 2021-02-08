function [xmin, fmin, neval] = armijosearch(f,df,s,c1)
% ARMIJOSEARCH searches for minimum using Armijo algorithm
% 	[xmin, fmin, neval] = ARMIJOSEARCH(f,df,s,c1)
%   INPUT ARGUMENTS
% 	f is a function
%   df is derivative
% 	s - interval length
% 	c1 - constant for armijo rule
%   OUTPUT ARGUMENTS
% 	xmin is a function minimizer
% 	fmin = f(xmin)
% 	neval - number of function evaluations
    a = s;
    b = 0.5;
    f0 = f(0);
    df0 = df(0);
    c2df0 = 0.9*abs(df0);
    k = 1;
    %unparse the search interval
    while (f(a) > f0 + c1*a*f0 || abs(df(a)) > c2df0) && k < 20
        a = b*a;
        k = k + 1;
    end
    xmin = a;
    fmin = f(a);
    neval = k + 1;
end