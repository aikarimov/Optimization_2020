function [xmin, fmin, neval] = goldensectionsearch2slides(f,interval,tol)
% goldensectionsearchvisual searches minimum using golden section
% [xmin, fmin, neval] = goldensectionsearch(f,interval,tol)
% f - an objective function handle
% interval = [a, b] - search interval
% tol - set for bot range and function value
flag = 0; %flag for saving or not

a = interval(1);
b = interval(2);

L = b - a;
neval = 2;
Fi = (1 + sqrt(5))/2;
Nfigs = 8;

% VISUALIZATION
ctr = 1;
deltaX = (b-a)/100;
figure(3); hold on
[miny, maxy] = drawplot(f,a,b,a,b);
deltaY = abs(maxy - miny)/100;
placelabel(a,0,deltaX,deltaY,ctr);
placelabel(b,0,deltaX,deltaY,ctr);
if flag
    export_fig(gcf,'1-G.jpg','-transparent','-r300');
end
% MAIN LOOP
while L > tol
    L = b - a;
    
    x1 = b - L/Fi;
    x2 = a + L/Fi;
    
    %do not do like this:
    y1 = feval(f,x1);
    y2 = feval(f,x2);
    %only 1 computation!
    ctr = ctr + 1;
    
    if ctr < Nfigs
        [~,~,colp] = drawplot(f,a,b,x1,x2);
    end
    
    if y1 > y2
        a = x1;
        placeasterix(x2,0,deltaX,deltaY,ctr,colp);
        placelabel(x1,0,deltaX,deltaY,ctr);
        xmin = x2;
        fmin = y2;
    else
        b = x2;
        placeasterix(x1,0,deltaX,deltaY,ctr,colp);
        placelabel(x2,0,deltaX,deltaY,ctr);
        xmin = x1;
        fmin = y1;
    end
    
    neval = neval + 1;
    
    if ctr <= Nfigs && flag
        export_fig(gcf,[num2str(ctr),'-G.jpg'],'-transparent','-r300');
    end
end
end

function [miny maxy colp] = drawplot(f,a,b,x1,x2)
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

function placelabel(x,y,deltaX,deltaY,iternumber)
if iternumber <=10
    text(x - deltaX/2,y + 4*deltaY,num2str(iternumber));
end
end

function placeasterix(x,y,deltaX,deltaY,iternumber,colp)
if iternumber <=10
    text(x - deltaX/2,y + 6*deltaY,'*','BackgroundColor', 'white','Color',colp);
end
end