function Draw3QN(f,x0,xnew,g0,H,figptr)
xbds = [0,2];

x = xbds(1):0.02:xbds(2);
y = x;

nx = length(x);
ny = length(y);

[X,Y] = meshgrid(x);
v = zeros(nx,ny);
w2 = zeros(nx,ny);

%build z array
for i = 1:nx
    for j = 1:ny
        x1 = [X(i,j);Y(i,j)];
        %original
        v(i,j) = f(x1);
        %Taylor approx
        w2(i,j) = f(x0) + g0'*(x1 - x0) + 0.5*(x1 - x0)'*H*(x1 - x0);
        
    end
end
figure(figptr);
hold on
surf(X,Y,v,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
xlabel('\itx');
ylabel('\ity');
zlabel('\itf');
view([1 3 3]);
material dull

surf(X,Y,w2,'FaceAlpha',0.3,'EdgeColor','none','FaceColor','interp');
xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
zlabel('$f$','interpreter','latex');
set(gca,'TickLabelInterpreter','latex','FontSize',11);
%material metal

shading interp
%light('Position',[10 10 300],'Style','local');


scatter3(x0(1),x0(2),f(x0),'MarkerFaceColor','red','MarkerEdgeColor','black');
scatter3(xnew(1),xnew(2),f(xnew),'MarkerFaceColor','green','MarkerEdgeColor','black');

zmin = min([f(x0),f(xnew),0]); zmax = 300;
axis([xbds, xbds, zmin zmax]);
caxis([zmin zmax]);
axis square

title('$T(\mathbf{x}) = f(\mathbf{x}_0) + \nabla f(\mathbf{x}_0)^\top \Delta \mathbf{x} + \frac{1}{2}\Delta \mathbf{x}^\top B_k \Delta \mathbf{x}$','interpreter','latex');

export_fig(figptr,['QN',num2str(figptr),'.jpg'],'-r300','-transparent','-q100');
%saveas(figptr,['QN',num2str(figptr),'.fig']);
end