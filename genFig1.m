function genFig1(s)

for i = length(s):-1:1
   temp = mean(s(i).temp,2);
   res = s(i).R;
   
   figure
   plot(temp,res,'*')
   xlabel('temp (degC)')
   ylabel('res (ohms)')
   title(s(i).loc)
   ylim([0 1])
   
   p = pwd;
   cd([pwd '\fig1'])
   figname = sprintf('s(%i)',i);
   saveas(gcf, figname) 
   close all
   cd(p)
end

end