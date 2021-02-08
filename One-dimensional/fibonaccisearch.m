function [ xmin , fmin , neval ] = fibonaccisearch (f , interval , tol )
% FIBONACCISEARCH searches for minimum using fibonacci numbers
% instead of golden number in golden search
%   [xmin , fmin , neval ] = FIBONACCISEARCH (f, interval ,tol)
% INPUT ARGUMENTS :
%   f is a function
%   interval = [a, b] - search interval
%   tol - set for bot range and function value
% OUTPUT ARGUMENTS :
%   xmin is a function minimizer
%   fmin = f( xmin )
%   neval - number of function evaluations

% unparse the search interval
flag = 0; %flag for saving or not

a = interval (1) ;
b = interval (2) ;
Nfigs = 10;

%fibonacci numbers
fibnums = [1; 1];
fibmax = 1;
n = 3;
Flarge = abs(b - a)/tol;

while (fibmax < Flarge) %find F(n)>(b-a)/tol
    fibmax = fibnums(n-1) + fibnums(n-2);
    fibnums = [fibnums; fibmax];
    n = n + 1;
end

k=1; n = n - 1;

x1 = a + (fibnums(n-2)/ fibnums(n))*(b-a) ;
x2 = a + (fibnums(n-1)/ fibnums(n))*(b-a);

% VISUALIZATION
ctr = 1;
deltaX = (b-a)/100;
figure(3); hold on
[miny, maxy, colp] = drawplot(f, a, b, a, b);
deltaY = abs(maxy - miny)/100;
placelabel(a, 0, deltaX, deltaY, ctr,Nfigs);
placelabel(b, 0, deltaX, deltaY, ctr,Nfigs);

if flag
    export_fig(gcf, '1-F.jpg', '-transparent', '-r300');
end

%preliminary work
y1 = feval(f,x1);
y2 = feval(f,x2);
neval = 2;
xmin = x1; fmin = y1; %stub

while k < n-2
    ctr = ctr + 1;
    
    if(ctr < Nfigs)
        [~,~,colp] = drawplot(f,a,b,x1,x2);

    end
    
    % set new bounds
    if y1 >= y2
        a = x1;
        placeasterix(x2,0,deltaX,deltaY,ctr,colp,Nfigs);
        placelabel(x1, 0, deltaX, deltaY, ctr,Nfigs);
        x1 = x2;
        y1 = y2;
        x2 = a + (fibnums(n-k-1)/fibnums(n-k)) * (b-a);
        y2 = feval(f,x2); neval = neval + 1; 
    else
        b = x2 ;
        placeasterix(x1,0,deltaX,deltaY,ctr,colp,Nfigs);
        placelabel(x2,0,deltaX,deltaY,ctr,Nfigs);
        x2 = x1;
        y2 = y1;
        x1 = a + (fibnums(n-k-2)/fibnums(n-k)) * (b-a);
        y1 = feval(f,x1); neval = neval + 1;
    end
    if ctr <= Nfigs && flag
        export_fig(gcf, [num2str(ctr), '-F.jpg'], '-transparent', '-r300');
    end
    k=k+1;
end
x2 = x1+tol;
y2 = feval (f , x2 ) ;
%finally, find new bounds
if y1>y2
    xmin=(x1+b)/2 ;
    fmin= feval (f , xmin ) ;
else
    xmin=(a+x2)/2;
    fmin= feval (f , xmin ) ;
end
neval = neval + 1;
end

function [miny, maxy, colp] = drawplot(f,a,b,x1,x2)
    figure(3); 
    h = (b-a)/100;
    x = a:h:b;
    y = feval(f,x);
    
    miny = min(y);
    maxy = max(y);
    
    colp = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
    plot(x,y,'LineWidth',1,'Color',colp);
    scatter([a b],[feval(f,a), feval(f,b)],'Marker','o','MarkerFaceColor',colp,'MarkerEdgeColor',colp);
    xlabel('\itx');
    ylabel('\ity');
    line([a b],[0 0],'Color','k','LineWidth',1); %axis x
    %col = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
    y1 = feval(f,x1);
    line([x1 x1],[0 y1],'Marker','s','Color',colp,'LineWidth',1,'MarkerSize',4); 
    y2 = feval(f,x2);
    line([x2 x2],[0 y2],'Marker','s','Color',colp,'LineWidth',1,'MarkerSize',4); 
end

function placelabel(x,y,deltaX,deltaY,iternumber,Nfigs)
if iternumber <=Nfigs
    text(x - deltaX/2,y + 4*deltaY,num2str(iternumber));
end
end

function placeasterix(x,y,deltaX,deltaY,iternumber,colp,Nfigs)
if iternumber <=Nfigs
    text(x - deltaX/2,y + 6*deltaY,'*','BackgroundColor', 'white','Color',colp);
end
end