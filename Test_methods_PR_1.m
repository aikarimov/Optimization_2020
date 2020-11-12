%Рисовалка картиночек

%% Подготовка к рисованию
%Закроем все окна
close all

% настраиваем оси x и y
x1 = [-15:0.1:6]; m = length(x1);
y1 = [-5:0.1:5]; n = length(y1);

% делаем сетку
[xx, yy] = meshgrid(x1,y1);

%массивы для графиков функции и ее производных по x и y
F = zeros(n,m);
dFx = zeros(n,m);
dFy = zeros(n,m);

%% Добавляем указатели на тестовую функцию и ее производную

fun = @fun2;
dfun = @dfun2;
funname = 'Fun 2';

%% Добавляем указатели на функцию методов оптимизации

optimfun = @prsearch;
optfunname = 'Polak–Ribiere';

%% настраиваем начальную точку
x0=[2,-4]';

%% настраиваем точность (одна на все критерии останова)
tol = 1e-9;

%% вычисляем рельеф поверхности
for i = 1:n
    for j = 1:m
        F(i,j) = feval(fun,[xx(i,j),yy(i,j)]);
        v = feval(dfun,[xx(i,j),yy(i,j)]);
        dFx(i,j) = v(1);
        dFy(i,j) = v(2);
    end
end

%% рисуем контурный или трехмерный график
figure(1);
hold on

% для контурного графика:
nlevels = 20;  %число линий уровня
[M,c] = contour(xx,yy,F,nlevels);
c.LineWidth = 1;

axis square %делаем оси одинаковыми
% форматируем оси
xlabel('$x$','interpreter','latex','FontSize',13);
ylabel('$y$','interpreter','latex','FontSize',13);
set(1,'position',[100 30 660 600]);
set(gca,'TickLabelInterpreter','latex','FontSize',11);

%% запускаем оптимизацию
[xmin, fmin, neval, coordinates] = optimfun(fun,dfun,x0,tol);
drawPlot2(coordinates, neval);

%% получившуюся картинку экспортируем с помощью библиотеки export_fig
%export_fig(1,[funname,' ',optfunname,'.jpg'],'-transparent','-r300');