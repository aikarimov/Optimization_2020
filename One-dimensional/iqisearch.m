function [xmin, fmin, count] = iqisearch(f, df,searchpos,tol)

%figure(3);
count = 0;
x0 = searchpos(1);
x2 = searchpos(2);
x1 = (x2 + x0)/2;
x3 = 0;

Nfig = 7;

ea = realmax;
left = x0;
right = x2;

a = 0;
b = 0;
c = 0;
figure(3);
hold on
%[miny, maxy] = drawplot(f,df, a,b,c, x0, x1, x2, count);
subplot(2,1,1);
x = x0:0.01:x2; dfx = df(x);
miny = min(dfx); maxy = max(dfx);
ylim([miny-8, maxy + 8]);
xlim([x0-0.5 x2+0.5]);

subplot(2,1,2);
xlim([x0-0.5 x2+0.5]);
%placelabel(left,0,count);
%placelabel(right,0,count);

%export_fig(gcf, 'M-1.jpg', '-transparent', '-r300');

%iterative computation

while(ea > tol)
    
    count = count+1;
    %1. compute for h0,h1,d0,d1
    
    fx0 = df(x0);
    fx1 = df(x1);
    fx2 = df(x2);
    
    x3 = fx1*fx2/(fx0 - fx1)/(fx0 - fx2)*x0 + fx0*fx2/(fx1 - fx0)/(fx1 - fx2)*x1 + fx0*fx1/(fx2 - fx0)/(fx2 - fx1)*x2;

    drawplot(f, df,  fx0, fx1, fx2, x0, x1, x2, count);
    if count <= Nfig
    %    export_fig(gcf,['Q-',num2str(count),'.jpg'],'-transparent','-r300');
    end
    
    %5. compute error
    ea = abs(df(x3));
    
    %6. adjust values for next iteration
    if x3 < x0
        x2 = x1; x1 = x0; x0 = x3;
    else
        if (x3 >= x0) && (x3 < x1)
            x2 = x1; x1 = x3;
        else
            if (x3 >= x1) && (x3 < x2)
                x0 = x1;
                x1 = x3;
            else
                x0 = x1; x1 = x2; x2 = x3;
            end
        end    
    end
%     xvect = [x1 x2 x3]; xvect = sort(xvect);
%     x0 = xvect(1);
%     x1 = xvect(2);
%     x2 = xvect(3);
end
%worst case scenario: count maxed out
%sprintf('Maximum iterations exhausted')
xmin = x3;
fmin = f(x3);
end

function [miny, maxy] = drawplot(f, df, fx1, fx2, fx3, x1, x2, x3, count)
figure(3);
subplot(2,1,1); hold on

h = 0.05;
left = x1 - 0.5;
right = x3 +0.5;

x = x1:h:x3;
y = f(x);
dy = df(x);
miny = min(dy)-15;
maxy = max(dy)+15;
dyspan = miny:0.01:maxy;

colp = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
hyper = @(y) ((y - fx2).*(y - fx3)./(fx1 - fx2)./(fx1 - fx3).*x1 + (y - fx1).*(y - fx3)./(fx2 - fx1)./(fx2 - fx3).*x2 + (y - fx1).*(y - fx2)./(fx3 - fx1)./(fx3 - fx2).*x3);
xh = hyper(dyspan);

subplot(2,1,1);
hold on
col = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
subplot(2,1,1);

y1 = df(x1);
y2 = df(x2);
y3 = df(x3);

placelabel(x1,y1 + 7,count);
placelabel(x2,y2 + 7,count);
placelabel(x3,y3 + 7,count);

plot(x,dy,'Color', colp, 'LineWidth',1);

line([left right],[0 0],'Color','k','LineWidth',1); %axis x
plot(xh,dyspan,'Color',col, 'LineWidth',0.5);
line([x1 x1],[0 y1],'Marker','s','Color',col,'LineWidth',0.5,'MarkerSize',4);
line([x2 x2],[0 y2],'Marker','s','Color',col,'LineWidth',0.5,'MarkerSize',4);
line([x3 x3],[0 y3],'Marker','s','Color',col,'LineWidth',0.5,'MarkerSize',4);
scatter([x1 x3],[df(x1), df(x3)],'Marker','o','MarkerFaceColor',colp,'MarkerEdgeColor',colp);

xlabel('$x$','interpreter','latex');
ylabel('$f''(x)$','interpreter','latex');

subplot(2,1,2);
hold on
xlabel('$x$','interpreter','latex');
ylabel('$f(x)$','interpreter','latex');

y1 = f(x1);
y2 = f(x2);
y3 = f(x3);

placelabel(x1,y1 + 5,count);
placelabel(x2,y2 + 5,count);
placelabel(x3,y3 + 5,count);

line([left right],[0 0],'Color','k','LineWidth',1); %axis x
line([x1 x1],[0 y1],'Marker','s','Color',col,'LineWidth',1,'MarkerSize',4);
line([x2 x2],[0 y2],'Marker','s','Color',col,'LineWidth',1,'MarkerSize',4);
line([x3 x3],[0 y3],'Marker','s','Color',col,'LineWidth',1,'MarkerSize',4);

scatter([x1 x3],[f(x1), f(x3)],'Marker','o','MarkerFaceColor',colp,'MarkerEdgeColor',colp);
plot(x,y,'Color', colp, 'LineWidth',1);

%axis([asixLeft asixRight -1000 1000]);
end

function placelabel(x,y,iternumber)
    text(x, y, num2str(iternumber), 'BackgroundColor', 'white');
end