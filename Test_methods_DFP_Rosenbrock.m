%Drawing thing

%% Preparation for drawing
%Close all windows
close all

% adjust the x and y axes
x1 = [-4:0.1:4]; m = length(x1);
y1 = [-4:0.1:4]; n = length(y1);

% grid
[xx, yy] = meshgrid(x1,y1);

%array for function plot
F = zeros(n,m);

%% test function pointers

%Rosenbrock function
fun = @f_rosenbrock;
dfun = @df_rosenbrock;
funname = 'Rosenbrock';

%% function pointers

optimfun = @dfpsearch;
optfunname = 'The Davidon-Fletcher-Powell method';

%% starting point
x0 = [-3, -3]';
%x0 = [0, 0]';

%% tolerance
tol = 1e-3;

%% function 
for i = 1:n
    for j = 1:m
        F(i,j) = feval(fun,[xx(i,j),yy(i,j)]);
    end
end

%% plot
figure(1);
hold on

% for contour plot:
 nlevels = 20;  %number of level lines
[M,c] = contour(xx,yy,F,nlevels);
c.LineWidth = 1;

% for 3D graphics:
% view([28, 35]);
% surf(xx,yy,F,'FaceAlpha',0.5,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
% zlabel('$f(x,y)$','interpreter','latex','FontSize',13);
% grid;

axis square %make the axes the same
% format the axes
xlabel('$x$','interpreter','latex','FontSize',13);
ylabel('$y$','interpreter','latex','FontSize',13);
set(1,'position',[100 30 660 600]);
set(gca,'TickLabelInterpreter','latex','FontSize',11);

%% optimization
[xmin, fmin, neval, coordinates] = optimfun(fun,dfun,x0,tol);
%draw plot
drawPlot2(coordinates, neval);

%% получившуюся картинку экспортируем с помощью библиотеки export_fig
%export_fig(1,[funname,' ',optfunname,'.jpg'],'-transparent','-r300');