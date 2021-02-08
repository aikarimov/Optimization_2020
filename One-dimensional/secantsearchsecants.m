function [xmin, fmin, neval] = secantsearchsecants(f,df,interval,tol)
% secantsearch searches minimum using secant method
% [xmin, fmin, neval] = secantsearch(f,interval,tol)
% f - an objective function handle
% interval = [a, b] - search interval
% tol - set for bot range and function value
a = interval(1);
b = interval(2);

Nfig = 8;

x=b-(feval(df, b)*(b-a))/(feval(df, b)-feval(df,a));
neval = 1;
% VISUALIZATION
% 
% set(groot,'defaultAxesTickLabelInterpreter','latex'); 
% set(groot,'defaulttextinterpreter','latex');
% set(groot,'defaultLegendInterpreter','latex');

ytext = 3;
ytextval = 1.4;

ctr = 1;
figure(3); hold on
subplot (2,1,1);
text(x, feval(df, x) + ytext,num2str(ctr), 'BackgroundColor', 'white','interpreter','latex');
subplot (2,1,2);
text(x, feval(f, x) + ytext,num2str(ctr), 'BackgroundColor', 'white','interpreter','latex');
[miny maxy] = drawplot(f,df,a,b,x);
subplot(2,1,1);
ylim([miny, maxy + 9]);
%export_fig(gcf,'1-S.jpg','-transparent','-r300');


% MAIN LOOP
while  abs(feval(df, x)) > tol && abs(b - a) > tol
    
    if feval(df, x) > 0
        b = x;
    else
        a = x;
    end
    
    x=b-(feval(df, b)*(b-a))/(feval(df, b)-feval(df,a));
    neval = neval + 3;
 
    ctr = ctr + 1;
    if ctr < 10
        subplot (2,1,1);
        %text(x, feval(df, x)+5,num2str(ctr), 'BackgroundColor', 'white');
        text(x, feval(df, x) + ytext,num2str(ctr),'interpreter','latex');
        subplot (2,1,2);
        %text(x, feval(f, x)+10,num2str(ctr), 'BackgroundColor', 'white');
        text(x, feval(f, x) + ytextval,num2str(ctr),'interpreter','latex');
        drawplot(f,df,a,b,x);
    end    
     if ctr <= Nfig
    %     export_fig(gcf,[num2str(ctr),'-S.jpg'],'-transparent','-r300');
     end
end
xmin=x;
fmin=feval(f, x);

% set(groot,'defaultAxesTickLabelInterpreter','remove'); 
% set(groot,'defaulttextinterpreter','remove');
% set(groot,'defaultLegendInterpreter','remove');
end

function [miny maxy] = drawplot(f,df,a,b,x0)
    figure(3); 
    subplot(2,1,1); hold on
    
    h = (b-a)/100;
    x = a:h:b;
    y = feval(df,x);
 
    colp = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
    plot(x,y,'LineWidth',1,'Color',colp); 
    plot(x0, feval(df, x0), '*'); 
    scatter([a b],[feval(df,a), feval(df,b)],'Marker','o','MarkerFaceColor',colp,'MarkerEdgeColor',colp);
    miny = min(y); maxy = max(y);
    %ylim([miny, maxy + 20]);
    
    xlabel('$x$','interpreter','latex');
    ylabel('$f''(x)$','interpreter','latex');
    line([a b],[0 0],'Color','k','LineWidth',1); %axis x
    %secant
    col = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
    line([a b],[feval(df, a) feval(df, b)],'Marker','s','Color',col,'LineWidth',1,'MarkerSize',4);
    line([x0 x0],[feval(df, x0) 0],'Marker','s','Color',col,'LineWidth',1,'MarkerSize',4);
    
    subplot(2,1,2); hold on
    
    h = (b-a)/100;
    x = a:h:b;
    y = feval(f,x);
 
    plot(x,y,'LineWidth',1,'Color',colp); 
    plot(x0, feval(f, x0), '*'); 
    scatter([a b],[feval(f,a), feval(f,b)],'Marker','o','MarkerFaceColor',colp,'MarkerEdgeColor',colp);
    
    xlabel('$x$','interpreter','latex');
    ylabel('$f(x)$','interpreter','latex');
    line([a b],[0 0],'Color','k','LineWidth',1); %axis x
    
end