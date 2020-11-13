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

%������� �����������
% fun = @f_himmelblau;
% dfun = @df_himmelblau;
% funname = 'Himmelblau';


%���������� 4 �������
% fun = @f_4;
% dfun = @df_4;
% funname = 'Fun 4 ord';

%% ��������� ��������� �� ������� ������� �����������

optimfun = @lmsearch;
optfunname = 'Levenberg-Marquardt';

%optimfun = @BB2;
%optfunname = 'Barzilai-Borwein 2';

% optimfun = @sdsearch;
% optfunname = 'Steepest Descent';

% optimfun = @gradsearch;
% optfunname = 'Gradient';

% optimfun = @newtsearch;
% optfunname = 'Newton';

% optimfun = @nesterovsearch;
% optfunname = 'Nesterov';

%% ����������� ��������� �����
%x0 = [-2, -3]';
%x0 = [1.3, 2]';
%x0 = [2, 1]';
X0 = [-2;-2]';
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
[xmin, fmin, neval] = feval(optimfun,fun,dfun,x0,tol);

%% ������������ �������� ������������ � ������� ���������� export_fig
%export_fig(1,[funname,' ',optfunname,'.jpg'],'-transparent','-r300');