function [xmin, fmin, neval] = qbeziersearch(f,df,x0,tol)
% QBEZIERSEARCH searches for minimum using simple quadratic Bezier approximation search
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

text(x0(1)+0.05,x0(2)-0.05,'0','FontSize',11,'interpreter','latex');

%set initial step using goldensection method
%initialize randomly x1 and g1
g1 = 0;
x1 = 0;

x2 = x0;
g2 = feval(df,x2);
a_interval = [0;0.003]; %interval for a
t_interval = [0; 2]; %interval for t
deltaX = tol;
k = 1; %iteration counter
flag = 0; %0 and 1 for line search, 2 for quadratic search


while  (norm(deltaX) >= tol) %(norm(g2) >= tol)
    if flag < 2
        %line search
        f1dim = @(al)(feval(f,x2 - al*g2));
        [al,~,~] = goldensectionsearch(f1dim,a_interval,tol);
        x3 = x2 - al*g2; %line step
        %plot new line fragment
        line([x2(1) x3(1)],[x2(2) x3(2)],'LineWidth',1,'Color','blue','Marker','s');  
        %next step is parabola step
        flag = flag + 1;
    else 
        %parabola search
        p0 = x0; 
        %p1 = x1;
        p2 = x2;
%        %calculate p1
         kvect = [g0, - g2]\(x0 - x2);
         %kvect = [(g0 + 0.5*g1)/1.5, - (g2 + 0.5*g1)/1.5]\(x0 - x2);
         kvect = [(g0 + g1)/2, - (g2 + g1)/2]\(x0 - x2);
         p10 = -g0*kvect(1) + x0;
         p11 = -g2*kvect(2) + x2;
         p1 = 0.5*(p10 + p11);

        %new 1-dim search function
        f1dim = @(t)(feval(f, (1 - t)^2*p0 + 2*t*(1-t)*p1 + t^2*p2));
        [t,~,~] = goldensectionsearch(f1dim,t_interval,tol);
        
        %make parabola step
        x3 = (1 - t)^2*p0 + 2*t*(1-t)*p1 + t^2*p2;
        
        %plot it using some additional code
        drawBezier2(p0,p1,p2,t);
        
%         if t <= 1 && t >= 0 %if new step is within interval
%             flag = 0;
%         end
    end
    
    g3 = feval(df,x3); %new gradient
    
    deltaX = x3 - x2;
    %memory shift
    g0 = g1;
    g1 = g2;
    g2 = g3;
    
    x0 = x1;
    x1 = x2;
    x2 = x3;

    k = k + 1;
    %pause;
end
%plot final marker
text(x3(1) + 0.35, x3(2) + 0.1, num2str(k),'FontSize',11,'BackgroundColor','white','interpreter','latex');
scatter(x3(1),x3(2),'ro','MarkerFaceColor',[1 0 0]);
xmin = x1;
fmin = feval(f,xmin);
neval = k;
end

function drawBezier2(p0,p1,p2,tmax)
    h = tmax/20; %20 fragments of the curve
    t = 0:h:tmax;
    Bspan = (1 - t).^2.*p0 + 2*t.*(1-t).*p1 + t.^2.*p2;
    line(Bspan(1,:),Bspan(2,:),'LineWidth',1,'Color','blue');  
    scatter(Bspan(1,1),Bspan(2,1),'bs','LineWidth',1);
    scatter(Bspan(1,end),Bspan(2,end),'bs','LineWidth',1);
    scatter(p1(1),p1(2),'xr','LineWidth',0.75);
end

