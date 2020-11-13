function [xmin, fmin, neval] = BB1(f,df,x0,tol)
%BB1 searches for minimum using Barzilai-Borwein 1 method
%   [xmin, fmin, neval] = BB1(f,df,x0,tol)
%   INPUT ARGUMENTS
%   f is a function handle
%   df is a gradient function handle
%   x0 - starting point
%   tol - tolerance for both range and function value
%   OUTPUT ARGUMENTS
%   xmin is a function minimizer
%   fmin = f(xmin)
%   neval - number of function evaluations
fSize = 11;
text(x0(1) + 0.2, x0(2) - 0.1, num2str(0),'FontSize',fSize,'interpreter','latex');
df0 = feval(df,x0);
g = df0/norm(df0);
f1dim = @(al)norm(al*x0 - g);
interval = [-3;3];
[al,~,~] = goldensectionsearch(f1dim,interval,tol);
al = al/norm(df0);
deltaX = tol;
k = 1;
Kmax = 1000;
while(norm(deltaX) >= tol) && (k < Kmax)
    x1 = x0 - al*df0;
    df1 = feval(df,x1);
    deltaX = x1 - x0;
    deltaF = df1 - df0;
    al = (deltaX'*deltaX) / (deltaX'*deltaF);
    
        %stabilization
     D = 0.1;
     al_stab = D/norm(df1);
     al = min([al,al_stab]);
    
    %draw new fragment
%     text(x1(1) + 0.2, x1(2) - 0.1, num2str(k),'FontSize',fSize,'BackgroundColor','white','interpreter','latex');
    line([x0(1) x1(1)],[x0(2) x1(2)],'LineWidth',1.2,'Color','blue','Marker','s');
    
    df0 = df1;
    x0 = x1;
    k = k + 1;
    
%      if(k < 10)
%          export_fig(gcf,['BB1',num2str(k), '.jpg'],'-r300','-transparent','-q100');
%      end
    
%    pause;
end
text(x1(1) + 0.2, x1(2) - 0.1, num2str(k),'FontSize',fSize,'BackgroundColor','white','interpreter','latex');
%export_fig(gcf,['BB1',num2str(k), '.jpg'],'-r300','-transparent','-q100');
%plot final marker
scatter(x1(1),x1(2),'ro','MarkerFaceColor',[1 0 0]);
xmin = x1;
fmin = feval(f,xmin);
neval = k;
end