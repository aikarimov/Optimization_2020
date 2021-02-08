function [xmin, fmin, neval] = trisectionsearch2slides(f,interval,tol)
% bisectionsearch2slides searches minimum using bisection method
% [xmin, fmin, neval] = bisectionsearch2slides(f,interval,tol)
% f - an objective function handle
% interval = [a, b] - search interval
% tol - set for bot range and function value
flag = 0; %flag for saving or not

a = interval(1);
b = interval(2);

L = b - a;
neval = 1;
Nvisualiter = 8;%number of visualized iterations
eps = tol/10;%for numerical differentiation
%Three dots method
xm = (a+b)./2;
fm = f(xm);
% VISUALIZATION
ctr = 1;
deltaX = (b-a)/100;
figure(3); hold on
[miny, maxy, colp] = drawplot(f,a,b,a,b,xm);
deltaY = abs(maxy - miny)/100;
placelabel(a,0,deltaX,deltaY,ctr);
placelabel(b,0,deltaX,deltaY,ctr);

placelabel(xm,0,deltaX,deltaY,ctr);
if flag
    export_fig(gcf,'1-T.jpg','-transparent','-r300');
end
%pause
% MAIN LOOP
while L > tol
    L = b - a;
    Lk = abs(b-a);
    x1 = (a+Lk/4);
    x2 = (b-Lk/4);
    
    ctr = ctr + 1;
    
    if ctr < Nvisualiter
        [~,~,colp] = drawplot(f,a,b,x1,x2,xm);
    end
    
    f1 = f(x1);
    f2 = f(x2);
    
    
    if f1 < fm
        b = xm; xm = x1; fm = f1;
    else
        if (f1 >= fm) && (f2 >= fm)
            b = x2; a = x1;
        else
            a = xm; xm = x2; fm = f2;
        end
    end
    placelabel(x1,0,deltaX,deltaY,ctr);
    placelabel(x2,0,deltaX,deltaY,ctr);
    
    neval = neval + 2;
    
    if ctr <= Nvisualiter && flag
       export_fig(gcf,[num2str(ctr),'-T.jpg'],'-transparent','-r300');
    end
    
    %pause
end
xmin = xm;
fmin = f(xm);
end

function [miny maxy colp] = drawplot(varargin)
f=varargin{1,1};
a=varargin{1,2};
b=varargin{1,3};
x1=varargin{1,4};
x2=varargin{1,5};
xm=varargin{1,6};
if nargin > 6
    colp = varargin{1,7};
else
    colp = hsv2rgb([rand(), 1, 0.5 + 0.5*rand()]);
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
y2 = feval(f,x2);
line([x2 x2],[0 y2],'Marker','s','Color',colp,'LineWidth',1,'MarkerSize',4);
ym = feval(f,xm);
line([xm xm],[0 ym],'Marker','s','Color',colp,'LineWidth',1,'MarkerSize',4);
end

function placelabel(x,y,deltaX,deltaY,iternumber)
if iternumber <=10
    text(x - deltaX/2,y + 4*deltaY,num2str(iternumber));
end
end