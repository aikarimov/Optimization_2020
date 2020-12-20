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

%Himmelblau function
fun = @f_himmelblau;
dfun = @df_himmelblau;
funname = 'Himmelblau';

%% function pointers

optimfun = @dfpsearch3;
optfunname = 'The Davidon-Fletcher-Powell method';

%% starting point
% x0 = [1, 0]';
% x0 = [2, 1]';
x0 = [0, 0]';

%% tolerance
tol = 1e-3;
%% optimization
[xmin, fmin, neval] = optimfun(fun,dfun,x0,tol);

%% получившуюся картинку экспортируем с помощью библиотеки export_fig
%export_fig(1,[funname,' ',optfunname,'.jpg'],'-transparent','-r300');