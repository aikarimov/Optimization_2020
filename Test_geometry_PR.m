%Interpretation of Polak-Ribiere method

%% view
close all
viewvect = [28, 35];

%% function parameters
fun = @fun2;
dfun = @dfun2;
funname = 'Fun 2';

%% grid
%axes limits
xmin = -15; ymin = -5; xmax = 5; ymax = 5; zmin = -100; zmax = 200;
x1 = xmin:0.02:xmax; m = length(x1);
y1 = ymin:0.02:ymax; n = length(y1);

[xx, yy] = meshgrid(x1,y1);
%function values
F = zeros(n,m);

%% points
%starting point
xstart = [2; -4];
x0 = xstart(1);
y0 = xstart(2);
f0 = fun(xstart);

%gradient of xstart
t0=0.1; %coefficient for contracting the vectors
dxstart = dfun(xstart);
dx0 = dxstart(1); %way too long
dy0 = dxstart(2); 

%perform Polak-Ribiere method
tol = 1e-9;
[xmin_, fmin, ~, coordinates] = prsearch(fun,dfun,xstart,tol);

%second point (first iteration of PR)
xsecond = coordinates(:, 2);
x2=xsecond(1);
y2=xsecond(2);
f2=fun(xsecond);

%gradient of xsecond
dxsecond = dfun(xsecond);
dx2=dxsecond(1);
dy2=dxsecond(2);

%point of minus gradient step from xsecond
x23=x2-dx2*t0;
y23=y2-dy2*t0;
f23=f2;

%point between x2 and x3: 
%vector end of -grad(xsecond) and beta*p0 vector sum
t1=1.05; %coefficient for streching the vector
x23last=(((-dx2.*(-dx2+x2)./dy2-y2+x2-dx2)+x2.*(y3-y2)./(x3-x2))./((y3-y2)./(x3-x2)-dx2/dy2))*t1;
y23last=((x23last-x2).*(y3-y2)./(x3-x2)+y2)*t1;
f23last=f2;

%minimum point (last iteration of PR)
x3=xmin_(1);
y3=xmin_(2);
f3=fmin;

%% planes
%plane between xstart and xsecond
[zplane1, yplane1] = meshgrid(-100:20:100);
xplane1=(yplane1-y2).*(x0-x2)./(y0-y2)+x2;

%plane between xsecond and xmin_
zplane2=zplane1;    yplane2=yplane1;
xplane2=(yplane2-y2).*(x3-x2)./(y3-y2)+x2;


%% calculate
for i = 1:n
    for j = 1:m
        xcur = [xx(i,j);yy(i,j)];
        F(i,j) = fun(xcur);
    end
end


%% plot function, starting point, and minimum point
figure(1);
hold on

%function plot
surf(xx,yy,F,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
view(viewvect);
grid;

shading interp

%starting point
scatter3(x0,y0,f0,'MarkerFaceColor','red','MarkerEdgeColor','black');

%minimum point
scatter3(x3,y3,f3,'MarkerFaceColor','green','MarkerEdgeColor','black');

axis([xmin xmax ymin ymax zmin zmax]);

caxis([zmin zmax]);

xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');

set(gcf,'position',[30 100 370 300]);

%% plot function, starting point, and its (minus) gradient
figure(2);
hold on

%function plot
surf(xx,yy,F,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
view(viewvect);
grid;

shading interp

%starting point
scatter3(x0,y0,f0,'MarkerFaceColor','red','MarkerEdgeColor','black');

%direction
quiver3(x0,y0,f0,dx0,dy0,0, t0,'LineWidth',2,'Color','r'); %grad(xstart)
quiver3(x0,y0,f0,-dx0,-dy0,0,t0,'LineWidth',2,'Color','g'); %-grad(xstart)


axis([xmin xmax ymin ymax zmin zmax]);

caxis([zmin zmax]);

xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');

set(gcf,'position',[30 100 370 300]);

%% plot function, starting point, and first plane
figure(3);
hold on

%function plot
surf(xx,yy,F,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
view(viewvect);
grid;

shading interp

%starting point
scatter3(x0,y0,f0,'MarkerFaceColor','red','MarkerEdgeColor','black');

%first plane is between xstart and xsecond
surf(xplane1,yplane1,zplane1);

axis([xmin xmax ymin ymax zmin zmax]);

caxis([zmin zmax]);

xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');

set(gcf,'position',[30 100 370 300]);


%% plot function, starting point, first plane, and second point
figure(4);
hold on

%function plot
surf(xx,yy,F,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
view(viewvect);
grid;

shading interp

%starting point
scatter3(x0,y0,f0,'MarkerFaceColor','red','MarkerEdgeColor','black');

%second point
scatter3(x2,y2,f2,'MarkerFaceColor','red','MarkerEdgeColor','black');

%first plane is between xstart and xsecond
surf(xplane1,yplane1,zplane1);

axis([xmin xmax ymin ymax zmin zmax]);

caxis([zmin zmax]);

xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');

set(gcf,'position',[30 100 370 300]);


%% plot function, second point, and its (minus) gradient
figure(5);
hold on

%function plot
surf(xx,yy,F,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
view(viewvect);
grid;

shading interp

%second point
scatter3(x2,y2,f2,'MarkerFaceColor','red','MarkerEdgeColor','black');

%direction
quiver3(x2,y2,f2,dx2,dy2,0,t0,'LineWidth',2,'Color','r'); %grad(xsecond)
quiver3(x2,y2,f2,-dx2,-dy2,0,t0,'LineWidth',2,'Color','g'); %-grad(xsecond)

axis([xmin xmax ymin ymax zmin zmax]);

caxis([zmin zmax]);

xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');

set(gcf,'position',[30 100 370 300]);


%% plot function, second point, minus gradient, and vector beta*p0
figure(6);
hold on

%function plot
surf(xx,yy,F,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
view(viewvect);
grid;

shading interp

%second point
scatter3(x2,y2,f2,'MarkerFaceColor','red','MarkerEdgeColor','black');

%direction
quiver3(x2,y2,f2,-dx2,-dy2,0,t0,'LineWidth',2,'Color','g'); %-grad(xsecond)

%vector between x23 and x23last
quiver3(x23,y23,f23,-dx0,-dy0,0,t0*0.3,'LineWidth',2,'Color','y');

axis([xmin xmax ymin ymax zmin zmax]);

caxis([zmin zmax]);

xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');

set(gcf,'position',[30 100 370 300]);

%% plot function, second point, direction vector
figure(7);
hold on

%function plot
surf(xx,yy,F,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
view(viewvect);
grid;

shading interp

%second point
scatter3(x2,y2,f2,'MarkerFaceColor','red','MarkerEdgeColor','black');

%direction
quiver3(x2,y2,f2,-dx2,-dy2,0,t0,'LineWidth',2,'Color','g'); %-grad(xsecond)

%vector between x23 and x23last
quiver3(x23,y23,f23,-dx0,-dy0,0,t0*0.3,'LineWidth',2,'Color','y');

%sum vector of -grad(xsecond) and and beta*p0
line([x2 x23last],[y2 y23last],[f2 f23last],'LineWidth',2);

axis([xmin xmax ymin ymax zmin zmax]);

caxis([zmin zmax]);

xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');

set(gcf,'position',[30 100 370 300]);

%% plot function, second point, and second plane
figure(8);
hold on

%function plot
surf(xx,yy,F,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
view(viewvect);
grid;

shading interp

%second point
scatter3(x2,y2,f2,'MarkerFaceColor','red','MarkerEdgeColor','black');

%second plane between xsecond and xmin_
surf(xplane2,yplane2,zplane2);

axis([xmin xmax ymin ymax zmin zmax]);

caxis([zmin zmax]);

xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');

set(gcf,'position',[30 100 370 300]);

%% plot function, second point, second plane, and minimum point
figure(9);
hold on

%function plot
surf(xx,yy,F,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
view(viewvect);
grid;

shading interp

%second point
scatter3(x2,y2,f2,'MarkerFaceColor','red','MarkerEdgeColor','black');

%minimum point
scatter3(x3,y3,f3,'MarkerFaceColor','green','MarkerEdgeColor','black');

%second plane between xsecond and xmin_
surf(xplane2,yplane2,zplane2);

axis([xmin xmax ymin ymax zmin zmax]);

caxis([zmin zmax]);

xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');

set(gcf,'position',[30 100 370 300]);

%% plot function and points
figure(10);
hold on

%function plot
surf(xx,yy,F,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
view(viewvect);
grid;

shading interp

%starting point
scatter3(x0,y0,f0,'MarkerFaceColor','red','MarkerEdgeColor','black');

%second point
scatter3(x2,y2,f2,'MarkerFaceColor','red','MarkerEdgeColor','black');

%minimum point
scatter3(x3,y3,f3,'MarkerFaceColor','green','MarkerEdgeColor','black');

%connect the points
line([x0 x2], [y0 y2], [f0 f2], 'LineWidth', 2);
line([x2 x3], [y2 y3], [f2 f3], 'LineWidth', 2);

axis([xmin xmax ymin ymax zmin zmax]);

caxis([zmin zmax]);

xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$z$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex');

set(gcf,'position',[30 100 370 300]);
