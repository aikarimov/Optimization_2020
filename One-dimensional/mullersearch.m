function [xmin, fmin, count] = mullersearch(f, df,searchpos,tol)

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
ylim([miny, maxy + 9]);
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
    
    h0 = x1-x0;
    h1 = x2-x1;
    h2 = x2 - x0;
    d0 = ( fx1-fx0 ) / h0;
    d1 = ( fx2-fx1 ) / h1;
    d2 = (fx2 - fx0) / h2;
    
    %2. compute for a,b,c
    a = (d1-d0) / (x2 - x0);
    %b = a*h1 + d1;
    b = d1 + d2 - d0;
    c = fx2;
    %if count == 3
    %end
    
    %3. check for sign
    temp = real(sqrt( b*b - 4*a*c ));
    checkpos = b + temp;%holder for |b+sqrt(b^2-4ac)|
    checkneg = b - temp;%holder for |b-sqrt(b^2-4ac)|
    
    x3p = x2 - (2*c) / checkpos;
    x3n = x2 - (2*c) / checkneg;
    
    if abs(checkpos) < abs(checkneg)
        x3 = x3n;
    else
        x3 = x3p;
    end
    
    %4. compute for x3, using form according to sign
%     if x3p < x0 || x3p > x2
%         x3 = x3n;
%     else
%         if x3n < x0 || x3n > x2
%             x3 = x3p;
%         else
%             if abs(df(x3p)) < abs(df(x3n))
%                 x3 = x3p;
%             else
%                 x3 = x3n;
%             end
%         end
%     end
    drawplot(f, df,  a, b, c, x0, x1, x2, count);
    if count <= Nfig
  %      export_fig(gcf,['M-',num2str(count),'.jpg'],'-transparent','-r300');
    end
    
    %5. compute error
    ea = abs(df(x3));
    
    %6. adjust values for next iteration
%     if x3 < x0
%         x2 = x1; x1 = x0; x0 = x3;
%     else
%         if (x3 >= x0) && (x3 < x1)
%             x2 = x1; x1 = x3;
%         else
%             if (x3 >= x1) && (x3 < x2)
%                 x0 = x1;
%                 x1 = x3;
%             else
%                 x0 = x1; x1 = x2; x2 = x3;
%             end
%         end    
%     end
    xvect = [x1 x2 x3]; xvect = sort(xvect);
    x0 = xvect(1);
    x1 = xvect(2);
    x2 = xvect(3);
    
end
%worst case scenario: count maxed out
%sprintf('Maximum iterations exhausted')
xmin = x3;
fmin = f(x3);
end

function [miny, maxy] = drawplot(f, df, A, B, C, x1, x2, x3, count)
figure(3);
subplot(2,1,1); hold on

h = 0.05;
left = x1;
right = x3;

x = left:h:right;
y = f(x);
miny = min(y);
maxy = max(y);
dy = df(x);

colp = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
hyper = @(x) A*(x-x3).^2 + B*(x-x3) + C;
yh = hyper(x);

subplot(2,1,1);
hold on
col = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
subplot(2,1,1);

y1 = hyper(x1);
y2 = hyper(x2);
y3 = hyper(x3);

placelabel(x1,y1 + 7,count);
placelabel(x2,y2 + 7,count);
placelabel(x3,y3 + 7,count);

plot(x,dy,'Color', colp, 'LineWidth',1);

line([left right],[0 0],'Color','k','LineWidth',1); %axis x
plot(x,yh,'Color',col, 'LineWidth',0.5);
line([x1 x1],[0 y1],'Marker','s','Color',col,'LineWidth',0.5,'MarkerSize',4);
line([x2 x2],[0 y2],'Marker','s','Color',col,'LineWidth',0.5,'MarkerSize',4);
line([x3 x3],[0 y3],'Marker','s','Color',col,'LineWidth',0.5,'MarkerSize',4);
scatter([left right],[df(left), df(right)],'Marker','o','MarkerFaceColor',colp,'MarkerEdgeColor',colp);

xlabel('$x$','interpreter','latex');
ylabel('$f''(x)$','interpreter','latex');

subplot(2,1,2);
hold on
xlabel('$x$','interpreter','latex');
ylabel('$f(x)$','interpreter','latex');

y1 = f(x1);
y2 = f(x2);
y3 = f(x3);

placelabel(x1,y1 - 5,count);
placelabel(x2,y2 - 5,count);
placelabel(x3,y3 - 5,count);

line([left right],[0 0],'Color','k','LineWidth',1); %axis x
line([x1 x1],[0 y1],'Marker','s','Color',col,'LineWidth',1,'MarkerSize',4);
line([x2 x2],[0 y2],'Marker','s','Color',col,'LineWidth',1,'MarkerSize',4);
line([x3 x3],[0 y3],'Marker','s','Color',col,'LineWidth',1,'MarkerSize',4);

scatter([left right],[f(left), f(right)],'Marker','o','MarkerFaceColor',colp,'MarkerEdgeColor',colp);
plot(x,y,'Color', colp, 'LineWidth',1);

%axis([asixLeft asixRight -1000 1000]);
end


function placelabel(x,y,iternumber)
if iternumber <=10
    text(x, y, num2str(iternumber), 'BackgroundColor', 'white');
    %text(x, y + 4, num2str(iternumber));
end
end