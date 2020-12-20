%���� ������������ ����

%% ��������� ����, �������� ���� ����
close all
viewvect = [28, 35];

N = 4;
%% ������� ���������� �� �������
%function
qf = cell(1,N);
qf{1,1} = @(x,y)(x^2 + y^2);
qf{1,2} = @(x,y)(-x^2 - y^2);
qf{1,3} = @(x,y)(x^2);
qf{1,4} = @(x,y)(x^2 - y^2);
%% ������������� �����
%��������� �������� �� ����
xmin = -3; ymin = -3; xmax = 3; ymax = 3; zmin = -100; zmax = 200;
%������ �������� �������� ����� �� x � y
x1 = xmin:0.03:xmax; m = length(x1);
y1 = ymin:0.03:ymax; n = length(y1);
%������ �����
[xx, yy] = meshgrid(x1,y1);
F = zeros(n,m);
for k = 1:N
%������� ��� �������� ������� � �����������
fun = qf{1,k};
%% ��������� ������ �������
for i = 1:n
    for j = 1:m
        %������ �������
        F(i,j) = feval(fun,xx(i,j),yy(i,j));
    end
end

%% ������ ������ �������
figure(k); hold on
surf(xx,yy,F,'FaceAlpha',0.9,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3); %�������������� ����������� F
view(viewvect); %����������� �������
grid; %�����
%������� ����
xlabel('$x_1$','interpreter','latex');
ylabel('$x_2$','interpreter','latex');
zlabel('$f$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
set(k,'position',[10 100 370 300]);
%export_fig(k,['QF',num2str(k),'f4.jpg'],'-r300','-transparent','-q100');
end