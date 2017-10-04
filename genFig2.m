function genFig2(u)

for k = length(u):-1:1
    labels = {};
    figure
    hold on
    for j = length(u(k).s):-1:1
        temp = u(k).s(j).temp;
        res = u(k).s(j).R;
        col = {'r*','b*','g*','c*','m*','r+','b+','g+','c+','m+'};
        
        plot(temp,res,col{j})
        xlabel('temp (degC)')
        ylabel('res (ohms)')
        ylim([0 1])
        
        labels = [labels, num2str(u(k).s(j).i)];
    end
    legend(labels)
    title(sprintf('%s',u(k).type))
    p = pwd;
    cd([pwd '\fig2'])
    figname = sprintf('%s.fig',u(k).type);
    saveas(gcf, figname)
    cd(p);
end

end