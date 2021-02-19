function Rosenbrock1
close all

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
        v(i,j) = f_rosenbrock(x1);
    end
end

    figure(1);
    surf(X,Y,v,'FaceAlpha',0.7,'EdgeColor','none','FaceColor','interp','AmbientStrength',0.3);
    xlabel('\itx');
    ylabel('\ity');
    zlabel('\itf');
    view([1 -1 3]);
   % material dull
    
    shading interp
    
export_fig(1,'rosen1.jpg','-r300','-transparent','-q100');

zmin = 0; zmax = 1000;
axis([-4 4 -4 4 zmin zmax]);
caxis([zmin zmax]);

export_fig(1,'rosen2.jpg','-r300','-transparent','-q100');

end
