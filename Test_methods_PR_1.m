%��������� ����������

%% ���������� � ���������
%������� ��� ����
close all

% ����������� ��� x � y
x1 = [-15:0.1:6]; m = length(x1);
y1 = [-5:0.1:5]; n = length(y1);

% ������ �����
[xx, yy] = meshgrid(x1,y1);

%������� ��� �������� ������� � �� ����������� �� x � y
F = zeros(n,m);
dFx = zeros(n,m);
dFy = zeros(n,m);

%% ��������� ��������� �� �������� ������� � �� �����������

fun = @fun2;
dfun = @dfun2;
funname = 'Fun 2';

%% ��������� ��������� �� ������� ������� �����������

optimfun = @prsearch;
optfunname = 'Polak�Ribiere';

%% ����������� ��������� �����
x0=[2,-4]';

%% ����������� �������� (���� �� ��� �������� ��������)
tol = 1e-9;

%% ��������� ������ �����������
for i = 1:n
    for j = 1:m
        F(i,j) = feval(fun,[xx(i,j),yy(i,j)]);
        v = feval(dfun,[xx(i,j),yy(i,j)]);
        dFx(i,j) = v(1);
        dFy(i,j) = v(2);
    end
end

%% ������ ��������� ��� ���������� ������
figure(1);
hold on

% ��� ���������� �������:
nlevels = 20;  %����� ����� ������
[M,c] = contour(xx,yy,F,nlevels);
c.LineWidth = 1;

axis square %������ ��� �����������
% ����������� ���
xlabel('$x$','interpreter','latex','FontSize',13);
ylabel('$y$','interpreter','latex','FontSize',13);
set(1,'position',[100 30 660 600]);
set(gca,'TickLabelInterpreter','latex','FontSize',11);

%% ��������� �����������
[xmin, fmin, neval, coordinates] = optimfun(fun,dfun,x0,tol);
drawPlot2(coordinates, neval);

%% ������������ �������� ������������ � ������� ���������� export_fig
%export_fig(1,[funname,' ',optfunname,'.jpg'],'-transparent','-r300');