function [miny, maxy] = drawplot(f, a, b, x1, x2)
    figure(3);
    h = (b - a)/100;
    x = a:h:b;
    y = feval(f, x);
    
    miny = min(y);
    maxy = max(x);
    colp = hsv2rgb ([ rand() , 1 , 0.5+0.5*rand() ]);
    plot (x ,y ,'LineWidth' ,1 ,'Color', 'r');
    scatter([ a b ] ,[ feval(f , a) , feval(f , b)] , 'Marker','o', 'MarkerFaceColor', 'r' ,'MarkerEdgeColor', 'r');
    xlabel('\itx');
	ylabel('\ity');
	line([a b], [0 0] , 'Color','k','LineWidth',1) ; % axis x
	col = hsv2rgb ([rand(), 1 , 0.5+0.5*rand()]);
	y1 = feval(f , x1);
	line([ x1 x1 ] ,[0 y1], 'Marker','s','Color','r' ,'LineWidth', 1, 'MarkerSize', 4);
	y2 = feval(f, x2);
	line([x2 x2] ,[0 y2], 'Marker','s','Color','r' ,'LineWidth' ,1 ,'MarkerSize' , 4);
end