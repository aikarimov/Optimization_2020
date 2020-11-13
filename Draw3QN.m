function Draw3QN(@f,x0,g0,H,figptr)
x = -4:0.02:4;
y = x;

nx = length(x);
ny = length(y);

[X,Y] = meshgrid(x);
v = zeros(nx,ny);
w0 = zeros(nx,ny);
w1 = zeros(nx,ny);
w2 = zeros(nx,ny);

x0 = [0;0];
%build z array
for i = 1:nx
    for j = 1:ny
        x1 = [X(i,j);Y(i,j)];
        %original
        v(i,j) = f_himmelblau(x1);
        %Taylor approx
        
        w0(i,j) = f_himmelblau(x0);
        w1(i,j) = f_himmelblau(x0) + (df_himmelblau(x0))'*(x1 - x0);
        w2(i,j) = f_himmelblau(x0) + (df_himmelblau(x0))'*(x1 - x0) + 0.5*(x1 - x0)'*(ddf_himmelblau(x0))*(x1 - x0);
        
    end
end

W = cell(1,3);
W{1,1} = w0;
W{1,2} = w1;
W{1,3} = w2;

for i = 1:3
    figure(i);
    hold on
    surf(X,Y,v,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
    xlabel('\itx');
    ylabel('\ity');
    zlabel('\itf');
    view([1 3 3]);
    material dull
    
    surf(X,Y,W{1,i},'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');
    xlabel('$x$','interpreter','latex');
    ylabel('$y$','interpreter','latex');
    zlabel('$f$','interpreter','latex');
    set(gca,'TickLabelInterpreter','latex','FontSize',11);
    %material metal
    
    shading interp
    %light('Position',[10 10 300],'Style','local');
    
    
    scatter3(x0(1),x0(2),f_himmelblau(x0),'MarkerFaceColor','red','MarkerEdgeColor','black');
    
    zmin = 0; zmax = 300;
    axis([-4 4 -4 4 zmin zmax]);
    caxis([zmin zmax]);
    axis square
end


export_fig(1,'T0.jpg','-r300','-transparent','-q100');
export_fig(2,'T1.jpg','-r300','-transparent','-q100');
export_fig(3,'T2.jpg','-r300','-transparent','-q100');

figure(1);
title('$T(\mathbf{x}) = f(\mathbf{x}_0)$','interpreter','latex');
figure(2);
title('$T(\mathbf{x}) = f(\mathbf{x}_0) + \nabla f(\mathbf{x}_0)\Delta \mathbf{x}$','interpreter','latex');
figure(3);
title('$T(\mathbf{x}) = f(\mathbf{x}_0) + \nabla f(\mathbf{x}_0)^\top \Delta \mathbf{x} + \frac{1}{2}\Delta \mathbf{x}^\top \nabla^2 f(\mathbf{x}_0)\Delta \mathbf{x}$','interpreter','latex');

figure(4); hold on
h = surfc(X,Y,v,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
h(2).LevelStep = 15;
zmin = 0; zmax = 300;
axis([-4 4 -4 4 zmin zmax]);
caxis([zmin zmax]);
view([1 3 3]);
xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$f$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex','FontSize',11);
scatter3(x0(1),x0(2),f_himmelblau(x0),'MarkerFaceColor','red','MarkerEdgeColor','black');

plot3(x0(1),x0(2),0,'r*','MarkerSize',8);
axis square

export_fig(4,'H.jpg','-r300','-transparent','-q100');

saveas(1,'T0.fig');
saveas(2,'T1.fig');
saveas(3,'T2.fig');
saveas(4,'H.fig');
end



function v = f_himmelblau(X)
% F_HIMMELBLAU is a Himmelblau function
% 	v = F_HIMMELBLAU(X)
%	INPUT ARGUMENTS:
%	X - is 2x1 vector of input variables
%	OUTPUT ARGUMENTS:
%	v is a function value
x = X(1);
y = X(2);
v = (x.^2 + y  - 11).^2 + (x + y.^2 - 7).^2;
end

function g = df_himmelblau(X)
% DF_HIMMELBLAU is a Himmelblau function derivative
% 	g = DF_HIMMELBLAU(X)
%	INPUT ARGUMENTS:
%	X - is 2x1 vector of input variables
%	OUTPUT ARGUMENTS:
%	g is a derivative function value
x = X(1);
y = X(2);

g = X;
g(1) = 2*(x.^2 + y  - 11).*(2*x) + 2*(x + y.^2 - 7);
g(2) = 2*(x.^2 + y  - 11) + 2*(x + y.^2 - 7).*(2*y);
end

function H = ddf_himmelblau(X)
% DDF_HIMMELBLAU is a Himmelblau function 2nd derivative
% 	H = DF_HIMMELBLAU(X)
%	INPUT ARGUMENTS:
%	X - is 2x1 vector of input variables
%	OUTPUT ARGUMENTS:
%	H is a Hessian function value
x = X(1);
y = X(2);

H = zeros(2);

H(1,1) = -42 + 12*x.^2 + 4*y;
H(1,2) = 4*(x + y);
H(2,1) = 4*(x + y);
H(2,2) = -26 + 4*x + 12*y.^2;
end
