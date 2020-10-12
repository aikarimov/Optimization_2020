%plots for test functions
clear all
close all

x = -4:0.05:4;
N = length(x);
y = x;
Z = zeros(N);
Z2 = Z;
[X,Y] = meshgrid(x);
for i = 1:N
    for j = 1:N
       Z(i,j) = feval(@f,[X(i,j),Y(i,j)]);
    end
end

for i = 1:N
    for j = 1:N
       Z2(i,j) = feval(@f3,[X(i,j),Y(i,j)]);
    end
end

figure(1);
m = round(length(x)/2);
subplot(1,2,1);
surf(X,Y,Z,'FaceAlpha',0.9,'EdgeColor','none');
xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$f$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
axis([-4 4 -4 4]);
axis square
view([1 1 1]);
title('Rosenbrock function','interpreter','latex');

subplot(1,2,2);

surf(X,Y,Z2,'FaceAlpha',0.9,'EdgeColor','none');
xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$f$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
axis([-4 4 -4 4]);
axis square
view([1 1 1]);
title('Himmelblau function','interpreter','latex');

set(1,'position',[22   195   1140   420]);
