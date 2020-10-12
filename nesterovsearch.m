function [xmin, fmin, neval] = nesterovsearch(f,df,x0,tol)
% NESTEROVSEARCH searches for minimum using Nesterov-Nemirovsky search
% 	[xmin, fmin, neval] = NESTEROVSEARCH(f,df,x0,tol)
%   INPUT ARGUMENTS
% 	f is a function
% 	df is its derivative
%   x0 is a starting point
% 	tol - set for bot range and function value
%   OUTPUT ARGUMENTS
% 	xmin is a function minimizer
% 	fmin = f(xmin)
% 	neval - number of function evaluations
text(x0(1) + 0.05, x0(2) - 0.05, num2str(0),'FontSize',7);
k = 1;
Kmax = 1000;
dx = realmax;
while(norm(dx) >= tol) && (k < Kmax)
    %recompute for k = k + 1
    H0 = H(df,x0, tol);
    g0 = feval(df,x0);
    delta0 = sqrt(g0'*(H0^-1)*g0);
    if delta0 <= 0.25
        al = 1;
    else
        al = 1/(1 + delta0);
    end
    dx = - H0\g0;
    x1 = x0 + al*dx;
    
    %draw new fragment
    text(x1(1)+ 0.2,x1(2)-0.05,num2str(k),'FontSize',8,'BackgroundColor','white','interpreter','latex');
    line([x0(1) x1(1)],[x0(2) x1(2)],'LineWidth',1,'Color','blue','Marker','s');  

    x0 = x1;
    k = k + 1;
    
    pause;
end
%plot final marker
text(x1(1) + 0.1, x1(2) - 0.1, num2str(k),'FontSize',8,'BackgroundColor','white','interpreter','latex');
scatter(x1(1),x1(2),'ro','MarkerFaceColor',[1 0 0]);

xmin = x1;
fmin = feval(f,xmin);
neval = k;
end

function ddf = H(df, X, tol)
n = length(X);
 ddf = zeros(n,n);
deltaX = 0.1*tol;
for i = 1:n
    dX = zeros(n,1);
    dX(i) = deltaX;
    temp = (feval(df,X + dX) - feval(df,X))/deltaX;
    ddf(:,i) = temp;
end
end