function [xm, k] = threedotsearch(dfunction,funct , a, b, tol) 
    format long g
    t = a:0.1:b; k = 1;
    epsilon = tol; delta = tol;
    %Visualization
    deltaX = (b-a)/100;
    figure(3); hold on
    [miny, maxy] = drawplot(dfunction,funct,a,b,a,b,k); %drawing plot of the function and derivative
    deltaY = abs(maxy - miny)/100;
    k = 0;
    print('-dpdf',[num2str(k), 'Bolcanoitter'])
    %Main algorithm
    xk = (a + b) / 2;
    %Three dots method
    xm = (a+b)./2;
    Lk = abs(b-a);
    x1 = (a+Lk/4);
    x2 = (b-Lk/4);
    while Lk>epsilon & k < 5
        if funct(x1)<funct(xm)
            b = xm;
            xm = x1;
        elseif (funct(x1)>=funct(xm)) & (funct(xm)<=funct(x2))
            a = x1;
            b = x2;
        else
            a = xm;
            xm = x2;
        end
        k = k + 1;
        xm = (a+b)./2;
        Lk = abs(b-a);
        x1 = (a+Lk/4);
        x2 = (b-Lk/4);
        drawplot(dfunction,funct,a,b,x1, x2 ,k);
        print('-dpdf',[num2str(k), 'Bolcanoitter'])
    end 
    x1, x2

    hold off
end

function [miny maxy] = drawplot(df, f, a, b, x1, x2, iternumber)
    
    figure(3); 
    h = (b-a)/100;
    %Drawing plot of dfunction
    dx = a:h:b;
    dy = feval(f,dx);
    miny = min(dy);
    maxy = max(dy);
    deltaX = (b-a) / 100;
    deltaY = abs(maxy - miny)/100;
    colp = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
    col = hsv2rgb([rand(), 1, 0.5+0.5*rand()]);
    %Drawing plot of the function
    x = a:h:b;
    y = feval(f,x);
    plot(x, y, 'LineWidth', 1, 'Color', colp);
    %xlim([2.8 3.4])
    line([a b],[-50 -50],'Color','k','LineWidth',1); %axis x
    ylim([-55 -30])
    xlabel('\itx')
    ylabel('\it{}f\rm (\it{}x\rm)')
    hold on
    line([x1 x1],[-50 feval(f, x1)],'Marker','s','Color',col,'LineWidth',1,'MarkerSize',4); 
    scatter(x1,feval(f, x1),'Marker','o','MarkerFaceColor',colp,'MarkerEdgeColor',colp);
    line([x2 x2],[-50 feval(f, x2)],'Marker','s','Color',col,'LineWidth',1,'MarkerSize',4); 
    scatter(x2,feval(f, x2),'Marker','o','MarkerFaceColor',colp,'MarkerEdgeColor',colp);
    textColor = 'black';
    textBackground = 'white';
    text(x1 - deltaX/2, feval(f, x1) + 4*deltaY + 1, num2str(iternumber),'Color', textColor,'BackgroundColor', textBackground);
    text(x2 - deltaX/2, feval(f, x2) + 4*deltaY + 1, num2str(iternumber));
    input("");
end