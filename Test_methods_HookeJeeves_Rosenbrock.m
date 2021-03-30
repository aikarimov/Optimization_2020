%��������� ����������

%% ���������� � ���������
%������� ��� ����
close all

% ����������� ��� x � y
x1 = [-4:0.1:4]; m = length(x1);
y1 = [-4:0.1:4]; n = length(y1);

% ������ �����
[xx, yy] = meshgrid(x1,y1);

%������� ��� �������� ������� � �� ����������� �� x � y
F = zeros(n,m);
dFx = zeros(n,m);
dFy = zeros(n,m);

%% ��������� ��������� �� �������� ������� � �� �����������

%������� ����������
fun = @f_rosenbrock;
dfun = @df_rosenbrock;
funname = 'Rosenbrock';

%% ��������� ��������� �� ������� ������� �����������

optimfun = @hjsearch;
optfunname = 'Hooke-Jeeves search';

%% ����������� ��������� �����
% x0=[-1.5,-2.5]';
%x0=[1.5,3]';
x0 = [-2,0]';

%% ����������� �������� (���� �� ��� �������� ��������)
tol = 1e-3;

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

% ��� ����������� �������:
% view([28, 35]);
% surf(xx,yy,F,'FaceAlpha',0.5,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
% zlabel('$f(x,y)$','interpreter','latex','FontSize',13);
% grid;

axis square %������ ��� �����������
% ����������� ���
xlabel('$x$','interpreter','latex','FontSize',13);
ylabel('$y$','interpreter','latex','FontSize',13);
set(1,'position',[100 30 660 600]);
set(gca,'TickLabelInterpreter','latex','FontSize',11);

%% ��������� �����������
[xmin, fmin, neval] = optimfun(fun,dfun,x0,tol);

%% ������������ �������� ������������ � ������� ���������� export_fig
%export_fig(1,[funname,' ',optfunname,'.jpg'],'-transparent','-r300');