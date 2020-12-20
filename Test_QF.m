%Виды квадратичных форм

%% настройка вида, закрытие всех окон
close all
viewvect = [28, 35];

N = 4;
%% задание указателей на функции
%function
qf = cell(1,N);
qf{1,1} = @(x,y)(x^2 + y^2);
qf{1,2} = @(x,y)(-x^2 - y^2);
qf{1,3} = @(x,y)(x^2);
qf{1,4} = @(x,y)(x^2 - y^2);
%% генерирование сетки
%настройка пределов по осям
xmin = -3; ymin = -3; xmax = 3; ymax = 3; zmin = -100; zmax = 200;
%расчет массивов значений точек по x и y
x1 = xmin:0.03:xmax; m = length(x1);
y1 = ymin:0.03:ymax; n = length(y1);
%расчет сетки
[xx, yy] = meshgrid(x1,y1);
F = zeros(n,m);
for k = 1:N
%массивы для значения функции и производных
fun = qf{1,k};
%% вычисляем рельеф функций
for i = 1:n
    for j = 1:m
        %рельеф функции
        F(i,j) = feval(fun,xx(i,j),yy(i,j));
    end
end

%% рисуем график функции
figure(k); hold on
surf(xx,yy,F,'FaceAlpha',0.9,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3); %полупрозрачная поверхность F
view(viewvect); %направление взгляда
grid; %сетка
%подписи осей
xlabel('$x_1$','interpreter','latex');
ylabel('$x_2$','interpreter','latex');
zlabel('$f$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
set(k,'position',[10 100 370 300]);
%export_fig(k,['QF',num2str(k),'f4.jpg'],'-r300','-transparent','-q100');
end