function [xmin, fmin, neval] = bisectionsearch2slides(f,df,interval,tol)
% bisectionsearch2slides searches minimum using bisection method
% [xmin, fmin, neval] = bisectionsearch2slides(f,interval,tol)
% f - an objective function handle
% interval = [a, b] - search interval
% tol - set for bot range and function value
a = interval(1);
b = interval(2);
L = b - a;
neval = 0;
Nvisualiter = 8;%number of visualized iterations
eps = 10*tol;%for numerical differentiation

% VISUALIZATION
ctr = 1;
deltaX = (b-a)/100;
figure(3); hold on
[~, ~, colp] = drawplot(f,a,b,a);
[miny, maxy] = drawplot(f,a,b,b,colp);
deltaY = abs(maxy - miny)/100;
placelabel(a,0,deltaX,deltaY,ctr);
placelabel(b,0,deltaX,deltaY,ctr);
export_fig(gcf,'1-B.jpg','-transparent','-r300');

% MAIN LOOP
while L > tol
    L = b - a;
    
    xmin = .5*(a + b);
    
    
    
    if ctr < Nvisualiter
        [~,~,colp] = drawplot(f,a,b,xmin);
        
    end
    
    %g = .5*(f(xmin + eps) -  f(xmin - eps))/eps; %approx f'
    g = df(xmin);
    if g <= 0
        a = xmin;
    else
        b = xmin;
    end
    placelabel(xmin,0,deltaX,deltaY,ctr);
    
    neval = neval + 1;
    ctr = ctr + 1;
    
    if ctr <= Nvisualiter
        export_fig(gcf,[num2str(ctr),'-B.jpg'],'-transparent','-r300');
    end
end
fmin = f(xmin);
end

function [miny maxy colp] = drawplot(varargin)
f=varargin{1,1};
a=varargin{1,2};
b=varargin{1,3};
x1=varargin{1,4};
if nargin > 4
    colp = varargin{1,5};
else
    colp = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
end
figure(3);
h = (b-a)/100;
x = a:h:b;
y = feval(f,x);

miny = min(y);
maxy = max(y);


plot(x,y,'LineWidth',1,'Color',colp);
scatter([a b],[feval(f,a), feval(f,b)],'Marker','o','MarkerFaceColor',colp,'MarkerEdgeColor',colp);
xlabel('\itx');
ylabel('\ity');
line([a b],[0 0],'Color','k','LineWidth',1); %axis x
%col = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
y1 = feval(f,x1);
line([x1 x1],[0 y1],'Marker','s','Color',colp,'LineWidth',1,'MarkerSize',4);
end

function placelabel(x,y,deltaX,deltaY,iternumber)
if iternumber <=10
    text(x - deltaX/2,y + 4*deltaY,num2str(iternumber));
end
end