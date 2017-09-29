clear
close all
clc

load s.mat
load graphRead.mat

s = getRelData(s);

for i = 23:-1:23
    
    temp = mean(s(i).temp,2);
    res  = s(i).R;
    time = s(i).time;
    
    figure
    plot(time,res,'b*')
    xlabel('time (s)')
    ylabel('res (ohms)')
    ylim([0 1])
    
    figure
    plot(time,temp,'g*')
    xlabel('time (s)')
    ylabel('temp (degC')
    
    figure
    plot(temp,res,'r*')
    xlabel('temp (degC)')
    ylabel('res (ohms)')
    ylim([0 1])
    
    disp(i)
    disp(gr(i).tstop)
    endTemp = input('Enter end temp (degC):');
    
    
    try
        endTimeArray = time(temp >= endTemp);
        tstop = endTimeArray(1,1);
    catch
        disp('index is empty, given temp does not occur');
        tstop = 0;
    end
    
    if ~isnan(tstop) || tstop ~= 0
        gr(i).tstop = tstop;
    end
    disp(tstop)
    
    input('Press any key to continue...')
    
    clc
    close all
    
end

save('graphRead.mat','gr')