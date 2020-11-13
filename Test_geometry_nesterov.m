%�������������� ����������� ������ ���������-������������

%% ��������� ����, �������� ���� ����
close all
viewvect = [28, 35];


%% ������� ���������� �� �������
%function
fun = @f_4;
%derivative
dfun = @df_4;
%second derivative
ddfun = @ddf_4;

%% ������������� �����
%��������� �������� �� ����
xmin = -3; ymin = -3; xmax = 3; ymax = 3; zmin = -100; zmax = 200;
%������ �������� �������� ����� �� x � y
x1 = xmin:0.03:xmax; m = length(x1);
y1 = ymin:0.03:ymax; n = length(y1);
%������ �����
[xx, yy] = meshgrid(x1,y1);
%������� ��� �������� ������� � �����������
F = zeros(n,m);
dFx = zeros(n,m);
dFy = zeros(n,m);

%�����, � ������� ��������� �����������
xp = [1.3; 2];

x0 = xp(1);
y0 = xp(2);
f0 = fun(xp);

%������� ��� �����������
Tx = zeros(n,m);
Ty = zeros(n,m);

%��������� �������������
v = dfun(xp);
f0x = v(1);
f0y = v(2);

%������� �����
H = ddfun(xp);
f0xx = H(1,1);
f0xy = H(1,2);
f0yx = H(2,1);
f0yy = H(2,2);


%����������� ������������ �����
% g0 = dfun(xp);
% delta0 = sqrt(g0'*(H^-1)*g0);
% if delta0 <= 0.25
%     al = 1;
% else
%     al = 1/(1 + delta0);
% end
%an actual alpha = 0.1586

%alpha for illustrative purposes
alpha = 0.4;


%% ��������� ������ �������
for i = 1:n
    for j = 1:m
        
        %������ �������
        xcur = [xx(i,j);yy(i,j)];
        F(i,j) = fun(xcur);
        
        %�������� �����������
        v = dfun(xcur);
        dFx(i,j) = v(1);
        dFy(i,j) = v(2);
        
        %����������� � ����������� �� x � ����� x0
        Tx(i,j) = f0x + f0xx*(xx(i,j) - x0) + f0xy*(yy(i,j) - y0);
        %����������� � ����������� �� y � ����� y0
        Ty(i,j) = f0y + f0yx*(xx(i,j) -  x0) + f0yy*(yy(i,j) - y0);
    end
end

%% �������������� ��������� ��� ���������� ��������� �����
% �������� ����� ����������� ����������� ���������� L1
a = (f0xy - f0yy);
b = -((f0x - f0y) - (f0xx - f0yx)*x0 - (f0xy - f0yy)*y0)/a;
k = (f0yx - f0xx)/a;

xline = x1;
yline = k*x1 + b;
zline = f0x + f0xx*(x1 - x0) + f0xy*(yline - y0); %in Tx

%�������� ������� ����� ��� ����� ���������� �� ����� L1

xzero = -(f0x - f0xx*x0 + f0xy*(b - y0))/(k*f0xy + f0xx);
yzero =  k*xzero + b;

fzero = fun([xzero;yzero]);

%�������� ����� ����������� ����������� ��������� � ����� Tx = 0
if f0xy~= 0
    b = (-f0x + f0xy*y0 + f0xx*x0)/f0xy;
    k = -f0xx/f0xy;
    xlinex = x1;
    ylinex = k*x1 + b;
else
    ylinex = y1;
    xlinex =  (-f0x + f0xy*y0 + f0xx*x0)/f0xx + 0*x1;
end
zlinex = 0*x1;%��������� �� 0, ����� ��������� ������ ������ �����������
    

%�������� ����� ����������� ����������� ��������� � ����� Ty = 0

if f0yy~= 0
    b = (-f0y + f0yy*y0 + f0yx*x0)/f0yy;
    k = -f0xy/f0yy;
    xliney = x1;
    yliney = k*x1 + b;
else
    yliney = y1;
    xliney = (-f0y + f0yy*y0 + f0yx*x0)/f0xy  + 0*x1;
end
zliney = 0*x1;


%����� �����
%actual point
% x_nest = x0-(x0-xzero)*al;
% y_nest = y0-(y0-yzero)*al;
% z_nest = f0y*(1-al);

%point for presentation purposes
x_nest = x0-(x0-xzero)*alpha;
y_nest = y0-(y0-yzero)*alpha;
z_nest = f0y*(1-alpha);

fun_nest = fun([x_nest,y_nest]);
%% ������ ������ �������
figure(1);
hold on %����� ��������� ������ ������ �������
surf(xx,yy,F,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3); %�������������� ����������� F
view(viewvect); %����������� �������
grid; %�����
%������� ����
xlabel('$x_1$','interpreter','latex');
ylabel('$x_2$','interpreter','latex');
zlabel('$f$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
set(1,'position',[10 100 370 300]);
%������� � ����� xp � ��������� ����� *_nest
scatter3(x0,y0,f0,'MarkerFaceColor','red','MarkerEdgeColor','black');
scatter3(x_nest,y_nest,fun_nest,'MarkerFaceColor','blue','MarkerEdgeColor','black','LineWidth',0.6);
% scatter3(xzero,yzero,fzero,'MarkerFaceColor','green','MarkerEdgeColor','black');

%% ������ ������ ����������� ������� �� x � ����������� ����������
figure(2);
hold on
%�������������� ����������� ����������� �� x
surf(xx,yy,dFx,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
material dull

%�������������� ����������� ����������� �� y
surf(xx,yy,Tx,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');
material metal

%����� �������
view(viewvect);
%������� �������
shading interp
%�����
grid;

%������� ����� ������ � ����������� � �����
scatter3(x0,y0,f0x,'MarkerFaceColor','red','MarkerEdgeColor','black');
scatter3(xzero,yzero,0,'MarkerFaceColor','green','MarkerEdgeColor','black','LineWidth',0.6);
%����� ����������� � �����
plot3(xlinex,ylinex,zlinex,'b-','LineWidth',1);

%��������� ������� ����
axis([xmin xmax ymin ymax zmin zmax]);
%��������� �������� � ������������ � �������� �� z
caxis([zmin zmax]);
%������� ����
xlabel('$x_1$','interpreter','latex');
ylabel('$x_2$','interpreter','latex');
zlabel('$f_{x_1}$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
%������� � ������ ��������
set(gcf,'position',[30 100 370 300]);

%% ������ ������ ����������� ������� �� y � ����������� ���������� (����������� ��. � ���. 2)
figure(3);
hold on
surf(xx,yy,dFy,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
view(viewvect);
material dull
surf(xx,yy,Ty,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');

grid;

scatter3(x0,y0,f0y,'MarkerFaceColor','red','MarkerEdgeColor','black');
scatter3(xzero,yzero,0,'MarkerFaceColor','green','MarkerEdgeColor','black','LineWidth',0.6);
plot3(xliney,yliney,zliney,'b-','LineWidth',1);

axis([xmin xmax ymin ymax zmin zmax]);
caxis([zmin zmax]);
xlabel('$x_1$','interpreter','latex');
ylabel('$x_2$','interpreter','latex');
zlabel('$f_{x_2}$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
set(gcf,'position',[50 100 370 300]);

%% ������ ������ ����������� ����������� � ������� ����������
figure(4);
hold on

%����������� �� �
surf(xx,yy,Tx,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');
%����������� �� �
surf(xx,yy,Ty,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');

grid;

material metal
shading interp
%����� �������
view(viewvect);
%������ ����������� � �����
scatter3(xzero,yzero,0,'MarkerFaceColor','green','MarkerEdgeColor','black','LineWidth',0.6);
%������ ��������� �����
scatter3(x0,y0,f0y,'MarkerFaceColor','red','MarkerEdgeColor','black');

%����� ����������� � ����� � ����������� ����������
plot3(xline,yline,zline,'k-','LineWidth',0.5);
plot3(xlinex,ylinex,zlinex,'b-','LineWidth',1);
plot3(xliney,yliney,zliney,'b-','LineWidth',1);

%������� �� ����
axis([xmin xmax ymin ymax zmin zmax]);
%������������� ��������
caxis([zmin zmax]);
%������� ����
xlabel('$x_1$','interpreter','latex');
ylabel('$x_2$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
%������� � ������
set(gcf,'position',[70 100 370 300]);

%% ��������� ����� ������
figure(5);
hold on

%����������� �� �
surf(xx,yy,Tx,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');
%����������� �� �
surf(xx,yy,Ty,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');

grid;

material metal
shading interp
%����� �������
view(viewvect);
%������ ����������� � �����
scatter3(xzero,yzero,0,'MarkerFaceColor','green','MarkerEdgeColor','black','LineWidth',0.6);
%������ ��������� �����
scatter3(x0,y0,f0y,'MarkerFaceColor','red','MarkerEdgeColor','black');

line([xzero x0], [yzero y0], [0 f0y],'Color','black','LineWidth',1.5);

%����� ����������� ����������
plot3(xline,yline,zline,'k-','LineWidth',0.5);

%������� �� ����
axis([xmin xmax ymin ymax zmin zmax]);
%������������� ��������
caxis([zmin zmax]);
%������� ����
xlabel('$x_1$','interpreter','latex');
ylabel('$x_2$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
%������� � ������
set(gcf,'position',[70 100 370 300]);

%% ������ ����� ����� �� ������
figure(6);
hold on

%����������� �� �
surf(xx,yy,Tx,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');
%����������� �� �
surf(xx,yy,Ty,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');

grid;

material metal
shading interp
%����� �������
view(viewvect);

%������ ����������� � �����
scatter3(xzero,yzero,0,'MarkerFaceColor','green','MarkerEdgeColor','black','LineWidth',0.6);
%������ ��������� �����
scatter3(x0,y0,f0y,'MarkerFaceColor','red','MarkerEdgeColor','black');
%������ ����� �����
scatter3(x_nest,y_nest,z_nest,'MarkerFaceColor','blue','MarkerEdgeColor','black','LineWidth',0.6);

%����� ����������� ����������
plot3(xline,yline,zline,'k-','LineWidth',0.5);

line([xzero x0], [yzero y0], [0 f0y],'Color','black','LineWidth',1.5);

%������� �� ����
axis([xmin xmax ymin ymax zmin zmax]);
%������������� ��������
caxis([zmin zmax]);
%������� ����
xlabel('$x_1$','interpreter','latex');
ylabel('$x_2$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
%������� � ������
set(gcf,'position',[70 100 370 300]);

%% ������ ������ ������ ���� ������ ���������-������������
figure(7);
hold on

%����������� �� �
surf(xx,yy,Tx,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');
%����������� �� �
surf(xx,yy,Ty,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');

grid;

material metal
shading interp
%����� �������
view(viewvect);

%������ ��������� �����
scatter3(x0,y0,f0y,'MarkerFaceColor','red','MarkerEdgeColor','black');
%������ ����� �����
scatter3(x_nest,y_nest,z_nest,'MarkerFaceColor','blue','MarkerEdgeColor','black','LineWidth',0.6);

%����� ����������� ����������
plot3(xline,yline,zline,'k-','LineWidth',0.5);

%������� �� ����
axis([xmin xmax ymin ymax zmin zmax]);
%������������� ��������
caxis([zmin zmax]);
%������� ����
xlabel('$x_1$','interpreter','latex');
ylabel('$x_2$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');
%������� � ������
set(gcf,'position',[70 100 370 300]);


export_fig(1,'df4.jpg','-r300','-transparent','-q100')
export_fig(2,'df4x.jpg','-r300','-transparent','-q100')
export_fig(3,'df4y.jpg','-r300','-transparent','-q100')
export_fig(4,'df4z1.jpg','-r300','-transparent','-q100')
export_fig(5,'df4z2.jpg','-r300','-transparent','-q100')
export_fig(6,'df4z3.jpg','-r300','-transparent','-q100')
export_fig(7,'df4z4.jpg','-r300','-transparent','-q100')