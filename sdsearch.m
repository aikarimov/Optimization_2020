function [xmin, fmin, neval] = sdsearch(f,df,x0,tol)
% SDSEARCH searches for minimum using steepest descent method
% 	[xmin, fmin, neval] = SDSEARCH(f,df,x0,tol)
%   INPUT ARGUMENTS
% 	f is a function
% 	df is its derivative
%   x0 is a starting point
% 	tol - set for bot range and function value
%   OUTPUT ARGUMENTS
% 	xmin is a function minimizer
% 	fmin = f(xmin)
% 	neval - number of function evaluations
df0 = feval(df,x0);

text(x0(1)+0.05,x0(2)-0.05,'0','FontSize',8,'interpreter','latex');
scatter([x0(1)],[x0(2)],'LineWidth',1.2,'Marker','s','MarkerEdgeColor','b');

g = df0/norm(df0);
f1dim = @(al)(feval(f,x0 - al*g));
interval = [0;10];
[al,~,~] = goldensectionsearch(f1dim,interval,tol);
deltaX = tol;
k = 1;
export_fig(gcf,['sd',num2str(k), '.jpg'],'-r300','-transparent','-q100');

while(norm(deltaX) >= tol)
    x1 = x0 - al*df0/norm(df0);
    %text(x1(1)+ 0.1,x1(2)-0.05,num2str(k),'FontSize',8,'BackgroundColor','white','interpreter','latex');
    line([x0(1) x1(1)],[x0(2) x1(2)],'LineWidth',1.2,'Color','blue','Marker','s');  

    df1 = feval(df,x1);
    deltaX = x1 - x0;
    
    g = df1/norm(df1);
    f1dim = @(al)(feval(f,x1 - al*g));
    [al,~,~] = goldensectionsearch(f1dim,interval,tol);
    
    df0 = df1;
    x0 = x1;
    k = k + 1;
    %pause;
    if(k <= 7)
         export_fig(gcf,['sd',num2str(k), '.jpg'],'-r300','-transparent','-q100');
    end
end
%plot final marker
text(x1(1) + 0.1, x1(2) - 0.1, num2str(k),'FontSize',11,'BackgroundColor','white','interpreter','latex');
scatter(x1(1),x1(2),'ro','MarkerFaceColor',[1 0 0]);
export_fig(gcf,['sd',num2str(k), '.jpg'],'-r300','-transparent','-q100');
xmin = x1;
fmin = feval(f,xmin);
neval = k;
end