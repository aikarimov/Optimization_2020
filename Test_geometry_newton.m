%Геометрическая иллюстрация метода Ньютона

%% настройка вида, закрытие всех окон
close all
viewvect = [28, 35];


%% задание указателей на функции
%function
fun = @f_4;
%derivative
dfun = @df_4;
%second derivative
ddfun = @ddf_4;

%% генерирование сетки
%настройка пределов по осям
xmin = -3; ymin = -3; xmax = 3; ymax = 3; zmin = -100; zmax = 200;
%расчет массивов значений точек по x и y
x1 = xmin:0.03:xmax; m = length(x1);
y1 = ymin:0.03:ymax; n = length(y1);
%расчет сетки
[xx, yy] = meshgrid(x1,y1);
%массивы для значения функции и производных
F = zeros(n,m);
dFx = zeros(n,m);
dFy = zeros(n,m);

%точка, в которой вычисляем касательную
xp = [1.3; 2];

x0 = xp(1);
y0 = xp(2);
f0 = fun(xp);

%массивы для касательных
Tx = zeros(n,m);
Ty = zeros(n,m);

%параметры аппроксимаций
v = dfun(xp);
f0x = v(1);
f0y = v(2);

H = ddfun(xp);
f0xx = H(1,1);
f0xy = H(1,2);
f0yx = H(2,1);
f0yy = H(2,2);


%% вычисляем рельеф функций
for i = 1:n
    for j = 1:m
        
        %рельеф функции
        xcur = [xx(i,j);yy(i,j)];
        F(i,j) = fun(xcur);
        
        %значение производной
        v = dfun(xcur);
        dFx(i,j) = v(1);
        dFy(i,j) = v(2);
        
        %касательная к производной по x в точке x0
        Tx(i,j) = f0x + f0xx*(xx(i,j) - x0) + f0xy*(yy(i,j) - y0);
        %касательная к производной по y в точке y0
        Ty(i,j) = f0y + f0yx*(xx(i,j) -  x0) + f0yy*(yy(i,j) - y0);
    end
end

%% алгебраические уравнения для нахождения уравнений линий
% вычислим линию пересечения касательных плоскостей L1
a = (f0xy - f0yy);
b = -((f0x - f0y) - (f0xx - f0yx)*x0 - (f0xy - f0yy)*y0)/a;
k = (f0yx - f0xx)/a;

xline = x1;
yline = k*x1 + b;
zline = f0x + f0xx*(x1 - x0) + f0xy*(yline - y0); %in Tx

%вычислим нулевую точку для обеих плоскостей на линии L1

xzero = -(f0x - f0xx*x0 + f0xy*(b - y0))/(k*f0xy + f0xx);
yzero =  k*xzero + b;

fzero = fun([xzero;yzero]);

%вычислим линию пересечения касательной плоскости с нулем Tx = 0
if f0xy~= 0
    b = (-f0x + f0xy*y0 + f0xx*x0)/f0xy;
    k = -f0xx/f0xy;
    xlinex = x1;
    ylinex = k*x1 + b;
else
    ylinex = y1;
    xlinex =  (-f0x + f0xy*y0 + f0xx*x0)/f0xx + 0*x1;
end
zlinex = 0*x1;%умножение на 0, чтобы получился массив нужной размерности
    

%вычислим линию пересечения касательной плоскости с нулем Ty = 0

if f0yy~= 0
    b = (-f0y + f0yy*y0 + f0yx*x0)/f0yy;
    k = -f0xy/f0yy;
    xliney = x1;
    yliney = k*x1 + b;
else
    yliney = y1;
    xliney = (-f0y + f0yy*y0 + f0yx*x0)/f0xy  + 0*x1;
end
zliney = 0*x1;



%% рисуем график функции
figure(1);
hold on %режим рисования одного поверх другого
surf(xx,yy,F,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3); %полупрозрачная поверхность F
view(viewvect); %направление взгляда
grid; %сетка
%подписи осей
xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$f$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
set(1,'position',[10 100 370 300]);
%маркеры в точке xp и найденной точке fzero
scatter3(x0,y0,f0,'MarkerFaceColor','red','MarkerEdgeColor','black');
scatter3(xzero,yzero,fzero,'MarkerFaceColor','green','MarkerEdgeColor','black');

%% рисуем график производной функции по x с касательной плоскостью
figure(2);
hold on
%полупрозрачная поверхность производной по x
surf(xx,yy,dFx,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
material dull

%полупрозрачная поверхность производной по y
surf(xx,yy,Tx,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');
material metal

%линия взгляда
view(viewvect);
%гладкий шейдинг
shading interp
%сетка
grid;

%маркеры точек старта и пересечения с нулем
scatter3(x0,y0,f0x,'MarkerFaceColor','red','MarkerEdgeColor','black');
scatter3(xzero,yzero,0,'MarkerFaceColor','green','MarkerEdgeColor','black','LineWidth',0.6);
%линия пересечения с нулем
plot3(xlinex,ylinex,zlinex,'b-','LineWidth',1);

%настройка лимитов осей
axis([xmin xmax ymin ymax zmin zmax]);
%раскраска графиков в соответствии с лимитами по z
caxis([zmin zmax]);
%подписи осей
xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$f_x$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
%позиция и размер картинки
set(gcf,'position',[30 100 370 300]);

%% рисуем график производной функции по y с касательной плоскостью (комментарии см. к фиг. 2)
figure(3);
hold on
surf(xx,yy,dFy,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
view(viewvect);
material dull
surf(xx,yy,Ty,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');

grid;

scatter3(x0,y0,f0y,'MarkerFaceColor','red','MarkerEdgeColor','black');
scatter3(xzero,yzero,0,'MarkerFaceColor','green','MarkerEdgeColor','black','LineWidth',0.6);
plot3(xliney,yliney,zliney,'b-','LineWidth',1);

axis([xmin xmax ymin ymax zmin zmax]);
caxis([zmin zmax]);
xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$f_y$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
set(gcf,'position',[50 100 370 300]);

%% рисуем график пересечения касательных с нулевой плоскостью
figure(4);
hold on

%касательная по х
surf(xx,yy,Tx,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');
%касательная по у
surf(xx,yy,Ty,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');

grid;

material metal
shading interp
%линия взгляда
view(viewvect);
%маркер пересечения с нулем
scatter3(xzero,yzero,0,'MarkerFaceColor','green','MarkerEdgeColor','black','LineWidth',0.6);
%линии пересечения с нулем и пересечения плоскостей
plot3(xline,yline,zline,'k-','LineWidth',0.5);
plot3(xlinex,ylinex,zlinex,'b-','LineWidth',1);
plot3(xliney,yliney,zliney,'b-','LineWidth',1);

%пределы по осям
axis([xmin xmax ymin ymax zmin zmax]);
%раскрашивание графиков
caxis([zmin zmax]);
%подписи осей
xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
%позиция и размер
set(gcf,'position',[70 100 370 300]);

export_fig(1,'f4.jpg','-r300','-transparent','-q100');
export_fig(2,'f4x.jpg','-r300','-transparent','-q100')
export_fig(3,'f4y.jpg','-r300','-transparent','-q100')
export_fig(4,'f4z.jpg','-r300','-transparent','-q100')