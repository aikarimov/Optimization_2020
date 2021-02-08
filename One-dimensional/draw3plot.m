function [miny, maxy] = draw3plot(f, df, xZero, A, B, C, x1, x2, x3, count)
h = 0.05;
asixLeft = - 20;
asixRight = 20;
left = asixLeft -100;
right = asixLeft +100;
 
x = left:h:right;
y = f(x);
miny = min(y) - 10;
maxy = max(y) + 10;
dy = df(x);
mindy = min(dy) - 10;
maxdy = max(dy) + 10;
 
colp = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
hyper = @(x) A*(x-x3).^2 + B*(x-x3) + C;
yh = hyper(x);
col = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
 
newplot;
set(gcf, 'Position', [10 10 1000 1000]);
hold on
xlabel('\itx');
ylabel('\ity');
scatter([left right],[f(left), f(right)],'Marker','o','MarkerFaceColor','r','MarkerEdgeColor','r');
 
newplot;
hold on
col = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
subplot(2,1,1);
line([left right],[0 0],'Color','k','LineWidth',1); %axis x
plot(x,yh,'Color','r', 'LineWidth',0.5);
y1 = hyper(x1);
 
place3label(x1,y1,count);
line([x1 x1],[0 y1],'Marker','s','Color','r','LineWidth',1,'MarkerSize',4);
y2 = hyper(x2);
place3label(x2,y2,count);
line([x2 x2],[0 y2],'Marker','s','Color','r','LineWidth',1,'MarkerSize',4);
y3 = hyper(x3);
place3label(x3,y3,count);
line([x3 x3],[0 y3],'Marker','s','Color','r','LineWidth',1,'MarkerSize',4);
plot(x,dy,'Color','b', 'LineWidth',2);
axis([asixLeft asixRight -100 100]);
 
newplot;
hold on
subplot(2,1,2);
line([left right],[0 0],'Color','k','LineWidth',1); %axis x
y1 = f(x1);
line([x1 x1],[0 y1],'Marker','s','Color','r','LineWidth',1,'MarkerSize',4);
y2 = f(x2);
line([x2 x2],[0 y2],'Marker','s','Color','r','LineWidth',1,'MarkerSize',4);
y3 = f(x3);
line([x3 x3],[0 y3],'Marker','s','Color','r','LineWidth',1,'MarkerSize',4);
plot(x,y,'Color','b', 'LineWidth',2);
axis([asixLeft asixRight -200 200]);
end