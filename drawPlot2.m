function drawPlot2(coordinates, neval)
%drawPlot2 draws an each step of method

fSize = 11;
x0=coordinates(:,1);
text(x0(1) + 0.2, x0(2) - 0.1, num2str(0),'FontSize',fSize,'interpreter','latex');
for i=1:1:neval
    
    x0 = coordinates(:, i);
    x1 = coordinates(:, i+1);
    line([x0(1) x1(1)],[x0(2) x1(2)],'LineWidth',1.2,'Color','blue','Marker','s');
    pause;
end

%plot final marker, 2D case
text(x1(1) + 0.2, x1(2) - 0.1, num2str(neval),'FontSize',fSize,'BackgroundColor','white','interpreter','latex');
scatter(x1(1),x1(2),'ro','MarkerFaceColor',[1 0 0]); % 2D case

end

