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
    
    
    getTstart = time(round(temp) >= 60);
    try
        gr(i).tstart = getTstart(1,1);
    catch
        gr(i).tstart = time(end);
    end
    gr(i).tstop = input('Enter end time (s):');
    
    close all
    
    figure
    plot(temp,res,'r*')
    xlabel('temp (degC)')
    ylabel('res (ohms)')
    ylim([0 1])
    
    gr(i).Ts_est = input('Enter guess Ts (degC):');
    gr(i).Ts_ub = input('Enter Ts upperbound (degC):');
    gr(i).Ts_lb = input('Enter Ts lowerbound (degC):');
    
    clc
    close all
end

save('graphRead.mat','gr')
