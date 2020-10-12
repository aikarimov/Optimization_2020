function [xmin, fmin, neval] = BB2(f,df,x0,tol)
%BB2 searches for minimum using Barzilai-Borwein 2 method
% plots optimization path on current axis
% x must be not less then 2-dimensional
% LMSEARCH searches for minimum using Newton multidimensional method
%   [xmin, fmin, neval] = BB2(f,df,x0,tol)
%   INPUT ARGUMENTS
%   f is a function handle
%   df is a gradient function handle
%   x0 - starting point
%   tol - tolerance for both range and function value
%   OUTPUT ARGUMENTS
%   xmin is a function minimizer
%   fmin = f(xmin)
%   neval - number of function evaluations
df0 = feval(df,x0);
text(x0(1) + 0.05, x0(2) - 0.05, num2str(0),'FontSize',7);
g = df0/norm(df0);
f1dim = @(al)norm(x0 - al*g);
interval = [-3;3];
[al,~,~] = goldensectionsearch(f1dim,interval,tol);
al = al/norm(df0);
deltaX = tol;
k = 1;
D = realmax;
Kmax = 1000;
while(norm(deltaX) >= tol) && (k < Kmax)
    x1 = x0 - al*df0;
    df1 = feval(df,x1);
    deltaX = x1 - x0;
    deltaF = df1 - df0;
    %recompute for k = k + 1
    al = (deltaX'*deltaF) / (deltaF'*deltaF);
    
    %stabilization
%     D = 10*norm(deltaX);
%     al_stab = D/norm(df1);
%     al = min([al,al_stab]);
    
    %draw new fragment
    line([x0(1) x1(1)],[x0(2) x1(2)],'LineWidth',1,'Color','blue','Marker','s');  
    if norm(deltaX) < 0.1
        text(x1(1) + 0.1, x1(2) - 0.05, num2str(k),'FontSize',8,'interpreter','latex');
    else
        text(x1(1) + 0.1, x1(2) - 0.05, num2str(k),'FontSize',8,'interpreter','latex');
    end
    
    df0 = df1;
    x0 = x1;
    k = k + 1;
    
    pause;
end
text(x1(1) + 0.1, x1(2) - 0.1, num2str(k),'FontSize',8,'BackgroundColor','white','interpreter','latex');
%plot final marker
scatter(x1(1),x1(2),'ro','MarkerFaceColor',[1 0 0]);
xmin = x1;
fmin = feval(f,xmin);
neval = k;
end