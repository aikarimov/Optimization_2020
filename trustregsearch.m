function [xmin, fmin, neval] = trustregsearch(f,df,x0,tol)
%TRUSTREGSEARCH trust region method with visualization
% plots optimization path on current axis
% x must be not less then 2-dimensional
% TRUSTREGSEARCH searches for minimum using Newton multidimensional method
%   [xmin, fmin, neval] = TRUSTREGSEARCH(f,df,x0,tol)
%   INPUT ARGUMENTS
%   f is a function handle
%   df is a gradient function handle
%   x0 - starting point
%   tol - tolerance for both range and function value
%   OUTPUT ARGUMENTS
%   xmin is a function minimizer
%   fmin = f(xmin)
%   neval - number of function evaluations


%Delta = 0.3; %initial radius
Delta = 1; %initial radius
Deltamax = 1; %max radius

k = 1; %set iteration counter
Kmax = 1000; %max number of iterations
dx = realmax; %eeror in x
eta = 0.1;
%plot stating marker
scatter(x0(1),x0(2),'bs','MarkerFaceColor',[0 0 1]);
text(x0(1) + 0.2, x0(2) - 0.2, num2str(0),'FontSize',11,'interpreter','latex');
plotReg(x0(1),x0(2),Delta); %show region in plot
export_fig(gcf,['trustreg',num2str(k), '.jpg'],'-r300','-transparent','-q100');
%pause;
B0 = eye(2);
while(norm(dx) >= tol) && (k < Kmax) %check stopping criteria
    
    
    %find coefficients for the model
    %B0 = H(df,x0, tol);
    g0 = feval(df,x0);
    f0 = feval(f,x0);
    
    mod = @(p)(f0 + p'*g0 + 0.5*p'*B0*p); %model
    
    pmin = doglegsearch(mod,g0,B0,Delta,tol);
    
    rho = (f(x0) - f(x0 + pmin))/(mod([0;0]) - mod(pmin));
    
    %update x
    if rho > eta
        x1 = x0 + pmin;
        dx = pmin;
        
        %BFGS update
        y = df(x1) - g0; 
        B0 = B0 + y*y'/(y'*pmin) - (B0*pmin)*pmin'*B0'/(pmin'*B0*pmin);
    else
        x1 = x0;
    end

    %update trust region radius
    if rho < 0.25
        Delta = 0.25*Delta;
    else
        if (rho > 0.75 && abs(norm(pmin) - Delta) < tol)
            Delta = min([2*Delta,Deltamax]);
        end
    end
    
    

    
    %draw new fragment
    %text(x1(1)+ 0.1,x1(2)-0.05,num2str(k),'FontSize',8,'BackgroundColor','white','interpreter','latex');
    line([x0(1) x1(1)],[x0(2) x1(2)],'LineWidth',1,'Color','blue','Marker','s');  
    x0 = x1;
    k = k + 1;
    plotReg(x0(1),x0(2),Delta); %show region in plot
    
    %pause;
    if(k < 10)
         export_fig(gcf,['trustreg',num2str(k), '.jpg'],'-r300','-transparent','-q100');
    end
end
%plot final marker
text(x1(1) + 0.2, x1(2) - 0.2, num2str(k),'FontSize',11,'interpreter','latex');
scatter(x1(1),x1(2),'ro','MarkerFaceColor',[1 0 0]);

export_fig(gcf,['trustreg',num2str(k), '.jpg'],'-r300','-transparent','-q100');
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

function plotReg(x0,y0,Delta)
%plot trust region
r=Delta;
fimplicit(@(x,y)((x-x0).^2 + (y-y0).^2 - r^2)); %plot circle
end

function pmin = doglegsearch(mod,g0,B0,Delta,tol)
%dogleg local search
pU = -g0'*g0/(g0'*B0*g0)*g0;
pB = - B0^-1*g0;
al = goldensectionsearch( @(al)( mod(al*pB)), [-Delta/norm(pB),Delta/norm(pB)] , tol);
pB = al*pB;
tau = goldensectionsearch( @(tau)( mod(pparam(pU,pB,tau)) ),[0,2],tol);
pmin = pparam(pU,pB,tau);
if norm(pmin) > Delta
    pmin = (Delta / norm(pmin)) *pmin;
end
end

function p = pparam(pU,pB,tau)
    if (tau <= 1)
        p = tau*pU;
    else
        p = pU + (tau - 1)*(pB - pU);
    end
end