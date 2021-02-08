function [xmin, fmin, neval] = goldensectionsearch(f,interval,tol)
% GOLDENSECTIONSEARCH searches for minimum using golden section
% 	[xmin, fmin, neval] = GOLDENSECTIONSEARCH(f,interval,tol)
%   INPUT ARGUMENTS
% 	f is a function
% 	interval = [a, b] - search interval
% 	tol - set for bot range and function value
%   OUTPUT ARGUMENTS
% 	xmin is a function minimizer
% 	fmin = f(xmin)
% 	neval - number of function evaluations

    %unparse the search interval
    a = interval(1);
    b = interval(2);
    Phi = (1 + sqrt(5))/2; %constant Phi
    
    %preliminary work
    L = b - a;
    x1 = b - L/Phi; x2 = a + L/Phi;
    y1 = feval(f,x1);
    y2 = feval(f,x2); 
    neval = 2;
    xmin = x1; fmin = y1; %stub
    %main loop
    while L > tol
        if y1 > y2
            a = x1;
            xmin = x2;
            fmin = y2;
            x1 = x2; y1 = y2;
            L = b - a;
            x2 = a + L/Phi;
            y2 = feval(f,x2); neval = neval + 1;
        else
            b = x2;
            xmin = x1;
            fmin = y1;
            x2 = x1; y2 = y1;
            L = b - a;
            x1 = b - L/Phi;
            y1 = feval(f,x1); neval = neval + 1;
        end
    end
end