%Quiver plots for CG motivation
close all

% set x and y
x1 = [-4:0.1:4]; m = length(x1);
y1 = [-4:0.1:4]; n = length(y1);

% make grid
[xx, yy] = meshgrid(x1,y1);

%arrays for all fncts 
F = zeros(n,m);
dFx = zeros(n,m);
dFy = zeros(n,m);

% compute relief
for i = 1:n
    for j = 1:m
        F(i,j) = feval(fun,[xx(i,j),yy(i,j)]);
        v = feval(dfun,[xx(i,j),yy(i,j)]);
        dFx(i,j) = v(1);
        dFy(i,j) = v(2);
    end
end

figure(1);
hold on
nlevels = 20;  %number of levels
[M,c] = contour(xx,yy,F,nlevels);
c.LineWidth = 1;
%apply format
axis square
xlabel('$x$','interpreter','latex','FontSize',13);
ylabel('$y$','interpreter','latex','FontSize',13);
set(1,'position',[100 30 660 600]);
set(gca,'TickLabelInterpreter','latex','FontSize',11);


%% Добавляем указатели на тестовую функцию и ее производную
 
%функция Розенброка
fun = @f_rosenbrock;
dfun = @df_rosenbrock;
funname = 'Rosenbrock';


%% Добавляем указатели на функцию методов оптимизации

optimfun = @gradsearch;
optfunname = 'Gradient';

%% настраиваем начальную точку
%x0 = [-2, -3]';
x0 = [1.3, 2]';
%x0 = [2, 1]';
%% настраиваем точность (одна на все критерии останова)
tol = 1e-10;



%% рисуем контурный или трехмерный график
figure(1);


% для трехмерного графика:
% view([28, 35]);
% surf(xx,yy,F,'FaceAlpha',0.5,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
% zlabel('$f(x,y)$','interpreter','latex','FontSize',13);
% grid;


%% запускаем оптимизацию
[xmin, fmin, neval] = feval(optimfun,fun,dfun,x0,tol)

%% получившуюся картинку экспортируем с помощью библиотеки export_fig
%export_fig(1,[funname,' ',optfunname,'.jpg'],'-transparent','-r300');