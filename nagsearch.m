function [xmin, fmin, neval] = nagsearch(f,df,x0,tol)
% NAGSEARCH searches for minimum using simple gradient search
% 	[xmin, fmin, neval] = NAGSEARCH(f,df,x0,tol)
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

text(x0(1)+0.05,x0(2)-0.05,'0','FontSize',11);

%set initial step using goldensection method
g = df0/norm(df0);
f1dim = @(al)(feval(f,x0 - al*g));
interval = [-1;1];
[al,~,~] = goldensectionsearch(f1dim,interval,tol);
deltaX = tol;
k = 1;
nu=0.001; %parameter nu from 0.001 to 1 (maybe yes maybe no)
y0 = x0;
while(norm(deltaX) >= tol)
    
    %x1 = x0 - al*df0/norm(df0);
   
    x1 = y0 - nu*df0;
    y1 = x1 + k/(k+3)*(x1 - x0);

    
    %plot new line fragment
    text(x1(1)+ 0.1,x1(2)-0.05,num2str(k),'FontSize',8,'BackgroundColor','white','interpreter','latex');
    line([x0(1) x1(1)],[x0(2) x1(2)],'LineWidth',1,'Color','blue','Marker','s');  


    df0 = feval(df,y1);
    deltaX = x1 - x0;
    x0 = x1;
    y0 = y1;
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