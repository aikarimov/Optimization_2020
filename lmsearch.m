function [xmin, fmin, neval] = lmsearch(f,df,x0,tol)
%LMSEARCH Levenberg-Marquardt method with visualization
% plots optimization path on current axis
% x must be not less then 2-dimensional
% LMSEARCH searches for minimum using Newton multidimensional method
%   [xmin, fmin, neval] = LMSEARCH(f,df,x0,tol)
%   INPUT ARGUMENTS
%   f is a function handle
%   df is a gradient function handle
%   x0 - starting point
%   tol - tolerance for both range and function value
%   OUTPUT ARGUMENTS
%   xmin is a function minimizer
%   fmin = f(xmin)
%   neval - number of function evaluations

%plot stating marker
scatter(x0(1),x0(2),'bs','MarkerFaceColor',[0 0 1]);
text(x0(1) + 0.2, x0(2) - 0.2, num2str(0),'FontSize',8,'interpreter','latex');
k = 1; %set iteration counter
Kmax = 1000; %max number of iterations
dx = realmax; %eeror in x
al = 100; %LM gradient coefficient
eta = 2; %minimization coeffitient
dim = length(x0);
I = eye(dim);
while(norm(dx) >= tol) && (k < Kmax) %check stopping criteria
    %recompute for k = k + 1
    H0 = H(df,x0, tol);
    g0 = feval(df,x0);
    dx = - (H0 + al*I)\g0;
    x1 = x0 + dx;
    
    if(feval(f,x1) < feval(f,x0))
        al = al/eta;
    end
    %draw new fragment
    text(x1(1)+ 0.1,x1(2)-0.05,num2str(k),'FontSize',8,'BackgroundColor','white','interpreter','latex');
    line([x0(1) x1(1)],[x0(2) x1(2)],'LineWidth',1,'Color','blue','Marker','s');  
    x0 = x1;
    k = k + 1;
    pause;
end
%plot final marker
text(x1(1) + 0.2, x1(2) - 0.2, num2str(k),'FontSize',8,'interpreter','latex');
scatter(x1(1),x1(2),'ro','MarkerFaceColor',[1 0 0]);

%return parameters
xmin = x1;
fmin = feval(f,xmin);
neval = k;
end

function ddf = H(df, X, tol)
% find Hessian (second derivative)
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