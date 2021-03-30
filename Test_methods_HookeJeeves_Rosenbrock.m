%Рисовалка картиночек

%% Подготовка к рисованию
%Закроем все окна
close all

% настраиваем оси x и y
x1 = [-4:0.1:4]; m = length(x1);
y1 = [-4:0.1:4]; n = length(y1);

% делаем сетку
[xx, yy] = meshgrid(x1,y1);

%массивы для графиков функции и ее производных по x и y
F = zeros(n,m);
dFx = zeros(n,m);
dFy = zeros(n,m);

%% Добавляем указатели на тестовую функцию и ее производную

%функция Розенброка
fun = @f_rosenbrock;
dfun = @df_rosenbrock;
funname = 'Rosenbrock';

%% Добавляем указатели на функцию методов оптимизации

optimfun = @hjsearch;
optfunname = 'Hooke-Jeeves search';

%% настраиваем начальную точку
% x0=[-1.5,-2.5]';
%x0=[1.5,3]';
x0 = [-2,0]';

%% настраиваем точность (одна на все критерии останова)
tol = 1e-3;

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

% для трехмерного графика:
% view([28, 35]);
% surf(xx,yy,F,'FaceAlpha',0.5,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
% zlabel('$f(x,y)$','interpreter','latex','FontSize',13);
% grid;

axis square %делаем оси одинаковыми
% форматируем оси
xlabel('$x$','interpreter','latex','FontSize',13);
ylabel('$y$','interpreter','latex','FontSize',13);
set(1,'position',[100 30 660 600]);
set(gca,'TickLabelInterpreter','latex','FontSize',11);

%% запускаем оптимизацию
[xmin, fmin, neval] = optimfun(fun,dfun,x0,tol);

%% получившуюся картинку экспортируем с помощью библиотеки export_fig
%export_fig(1,[funname,' ',optfunname,'.jpg'],'-transparent','-r300');