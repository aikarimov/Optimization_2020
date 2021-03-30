function [xmin, fmin, neval] = hjsearch(f,df,x0,tol)
%Hooke-Jeeves method for 2 dimensions
    global NmaxStep;
    global nStep;
    global nEval;

    NmaxStep = 1500;
    nStep = 1;
    
    filename = 'hjr';

    X0 = x0;
    P = 0.5;
    T = tol;
    
    F = f;

    %plot stating marker
    scatter(x0(1),x0(2),'bo','MarkerFaceColor',[0 0 1]);
    text(x0(1) + 0.2, x0(2) - 0.2, num2str(0),'FontSize',11,'interpreter','latex');
    
    export_fig(gcf,[filename,num2str(1), '.jpg'],'-r300','-transparent','-q100');
    
    F0 = F(X0); 
    nStep = nStep + 1;
    nEval = 1;
    while P >= T && NmaxStep > nStep
        [dX, F1] = ExplorStep(X0,F0,P,F);
        if(nStep < 10)
            export_fig(gcf,[filename,num2str(nStep), '.jpg'],'-r300','-transparent','-q100');
        end
        nStep = nStep + 1;
        if F1 < F0
            X1 = X0 + dX; line([X0(1) X1(1)],[X0(2) X1(2)],'Color','black');
            F2 = F1; t = 1;
            while F2 < F1 || t == 1
                t = 0;
                F1 = F2;
                X2 = PatternStep(X0,X1);
                line([X2(1) X0(1)],[X2(2) X0(2)],'Color','black');
                if(nStep < 10)
                    export_fig(gcf,[filename,num2str(nStep), '.jpg'],'-r300','-transparent','-q100');
                end
                nStep = nStep + 1;
                
                [dX, F2] = ExplorStep(X2,F(X2),P,F);
                F0 = F1;
                X0 = X1;
                X1 = X2 + dX;
                %line([X2(1) X1(1)],[X2(2) X1(2)]);
                if(nStep < 10)
                    export_fig(gcf,[filename,num2str(nStep), '.jpg'],'-r300','-transparent','-q100');
                end
                nStep = nStep + 1;
            end
        else
            P = P/2;
        end
      %  pause;
    end
    text(X0(1) + 0.2, X0(2) - 0.2, num2str(nStep),'FontSize',11,'interpreter','latex');
    scatter(X0(1),X0(2),'ro','MarkerFaceColor',[1 0 0]);
    fmin = feval(f,X0);
    xmin = X0;
    neval = nEval;
    export_fig(gcf,[filename,num2str(nStep), '.jpg'],'-r300','-transparent','-q100');
end



% function y2 = F2(x,y)
%     global nStep;
% 
%     y2 = (x).^2 + y.^2;
%     
%     if length(x) == 1
%         nStep = nStep + 1;
%         disp([num2str(nStep),'. f(',num2str(x),',',num2str(y),') = ',num2str(y2)]);
%     end
%     
% end
% 
% function y = F(X)
%     y = F2(X(1),X(2));
% end

function [dX, F1] = ExplorStep(X,F0,P,F)
global nEval
     x = X(1); y = X(2);
     dx = P;
     
     %by X
     F1 = F([x + dx, y]); plot([x,x + dx], [y,y],'-sb');  nEval = nEval + 1;
     
     if(F1 > F0)
         dx = -P;
         F1 = F([x + dx; y]); plot([x,x + dx], [y,y],'-sb');  nEval = nEval + 1;
         if(F1 > F0)
             dx = 0;
         end
     end
     
     F0 = min(F0,F1); %best found
     
     %by Y
     dy = P;
     F1 = F([x + dx; y + dy]); plot([x + dx,x + dx], [y,y + dy],'-sb'); nEval = nEval + 1;
     if(F1 > F0)
         dy = -P;
         F1 = F([x + dx; y + dy]); plot([x + dx,x + dx], [y,y + dy],'-sb');  nEval = nEval + 1;
         if(F1 > F0)
             dy = 0;
         end 
     end
     
     F1 = min(F0,F1); %best found
     %plot([x,x + dx], [y,y + dy],'-b');
     scatter(x + dx, y + dy,'og','MarkerFaceColor',[0 1 0]);
     dX = [dx; dy];
end

function X2 = PatternStep(X0,X1)
    a = 2;
    X2 = X0 + a*(X1 - X0);
    scatter(X2(1), X2(2),'sk','MarkerFaceColor',[0 0 0]);
end
