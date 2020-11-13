function [xmin, fmin, neval] = dampnewtsearch(f,df,x0,tol)
% DAMPNEWTSEARCH searches for minimum using damped Newton multidimensional method
% 	[xmin, fmin, neval] = DAMPNEWTSEARCH(f,df,x0,tol)
%   INPUT ARGUMENTS
% 	f is a function handle
% 	df is a gradient function handle
%   x0 - starting point
% 	tol - tolerance for both range and function value
%   OUTPUT ARGUMENTS
% 	xmin is a function minimizer
% 	fmin = f(xmin)
% 	neval - number of function evaluations
fSize = 11;
text(x0(1) + 0.2, x0(2) - 0.1, num2str(0),'FontSize',fSize,'interpreter','latex');
scatter([x0(1)],[x0(2)],'LineWidth',1.2,'Marker','s','MarkerEdgeColor','b');

%text(x0(1) + 0.2, x0(2) - 0.1, f(x0), num2str(0),'FontSize',fSize,'interpreter','latex');
k = 1;
Kmax = 1000;
dx = realmax;
al = 0.4;

%pause;
export_fig(gcf,['newt',num2str(k), '.jpg'],'-r300','-transparent','-q100');

while(norm(dx) >= tol) && (k < Kmax)
    %recompute for k = k + 1
    H0 = H(df,x0, tol);
    g0 = feval(df,x0);
    dx = - H0\g0;
    x1 = x0 + al*dx;
     
    %draw new fragment
    % for 2D case
    %text(x1(1) + 0.2, x1(2) - 0.1, num2str(k),'FontSize',fSize,'BackgroundColor','white','interpreter','latex');
    line([x0(1) x1(1)],[x0(2) x1(2)],'LineWidth',1.2,'Color','blue','Marker','s');  
    
    %for 3D case
    %line([x0(1) x1(1)],[x0(2) x1(2)],[f(x0) f(x1)],'LineWidth',1.2,'Color','blue','Marker','s'); 

    x0 = x1;
    k = k + 1;
    
    %pause; %pause and go after button pressed
    
     if(k < 10)
         export_fig(gcf,['newt',num2str(k), '.jpg'],'-r300','-transparent','-q100');
    end
end
%plot final marker, 2D case
text(x1(1) + 0.2, x1(2) - 0.1, num2str(k),'FontSize',fSize,'BackgroundColor','white','interpreter','latex');
% 3D case
%text(x1(1) + 0.2, x1(2) - 0.1, f(x1), num2str(k),'FontSize',fSize,'interpreter','latex');

scatter(x1(1),x1(2),'ro','MarkerFaceColor',[1 0 0]); % 2D case
%scatter3(x1(1),x1(2),f(x1),'ro','MarkerFaceColor',[1 0 0]); % 3D case
export_fig(gcf,['newt',num2str(k), '.jpg'],'-r300','-transparent','-q100');

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