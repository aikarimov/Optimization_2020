function [xmin, fmin, neval] = newtonsearch(f,df,interval,tol,x0)
% secantsearch searches minimum using secant method
% [xmin, fmin, neval] = secantsearch(f,interval,tol)
% f - an objective function handle
% interval = [a, b] - search interval
% tol - set for bot range and function value
a = interval(1);
b = interval(2);

Nfig = 10;

neval = 1;
% VISUALIZATION

set(groot,'defaultAxesTickLabelInterpreter','latex'); 
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

eps = tol;
ctr = 1;
figure(3); hold on

x = x0; %take a midpoint as start

subplot(2,1,1);
text(x0, feval(df, x0) + 4,num2str(1), 'BackgroundColor', 'white');

[miny, maxy, colp] = drawplot(f,df,a,b,x);
subplot(2,1,1);
ylim([miny, maxy + 9]);


export_fig(gcf,'1-N.jpg','-transparent','-r300');


% MAIN LOOP
while  abs(feval(df, x)) > tol
    D2f = 0.5 * (df(x + eps) - df(x - eps))/ eps;
    DDf = ddf(x);
    Df = feval(df, x);
    x = x - Df/DDf;
    neval = neval + 3;
 
    ctr = ctr + 1;
    if ctr < Nfig
        subplot (2,1,1);
       text(x, feval(df, x) + 4,num2str(ctr), 'BackgroundColor', 'white');
        %text(x, feval(df, x) + 3,num2str(ctr));
        subplot (2,1,2);
       text(x, feval(f, x) + 4,num2str(ctr), 'BackgroundColor', 'white');
        %text(x, feval(f, x) + 3,num2str(ctr));
        drawplot(f,df,a,b,x,colp);
    end    
     if ctr <= Nfig
         export_fig(gcf,[num2str(ctr),'-N.jpg'],'-transparent','-r300');
     end
end
xmin=x;
fmin=feval(f, x);
end

function [miny, maxy, colp] = drawplot(varargin)

f=varargin{1,1};
df=varargin{1,2};
a=varargin{1,3};
b=varargin{1,4};

if nargin > 4
    x0 = varargin{1,5};
else
    x0 = [];
end

if nargin > 5
    colp = varargin{1,6};
else
    colp = hsv2rgb([rand(), 1, 0.5 + 0.5*rand()]);
end
    figure(3); 
    subplot(2,1,1); hold on
    
    h = (b-a)/100;
    x = a:h:b;
    y = feval(df,x);
 
    plot(x,y,'LineWidth',1,'Color',colp);
    scatter([a b],[feval(df,a), feval(df,b)],'Marker','o','MarkerFaceColor',colp,'MarkerEdgeColor',colp);
    miny = min(y); maxy = max(y);
    
    xlabel('$x$');
    ylabel('$f''(x)$');
    line([a b],[0 0],'Color','k','LineWidth',1); %axis x
    
    if ~isempty(x0)
        plot(x0, feval(df, x0), '*'); 
        
        %tangent
        col = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
        k = ddf(x0);
        br = feval(df,x0);
        yt = k*(x - x0) + br;
        plot(x,yt,'Color',col,'LineWidth',1);
        
        line([x0 x0],[0 feval(df, x0)],'Color','k','LineWidth',0.5); %axis x
    end
    subplot(2,1,2); hold on
    
    h = (b-a)/100;
    x = a:h:b;
    y = feval(f,x);
 
    plot(x,y,'LineWidth',1,'Color',colp); 
    scatter([a b],[feval(f,a), feval(f,b)],'Marker','o','MarkerFaceColor',colp,'MarkerEdgeColor',colp);
    xlabel('$x$');
    ylabel('$f(x)$');
    line([a b],[0 0],'Color','k','LineWidth',1); %axis x
    if ~isempty(x0)
        plot(x0, feval(f, x0), '*'); 
    end
end