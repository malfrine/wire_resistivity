clear
close all
clc

load s.mat
load graphRead.mat

s = getRelData(s);
%check_sets = [23,24,51,11,52,39,35,40,33,30,34,28,26,21,20,11];

for i = 1:length(s)%check_sets
    
    temp_av = mean(s(i).temp,2);
    temp_ar = s(i).temp;
    res  = s(i).R;
    time = s(i).time;
    
    
    %plot relevant graphs for trimming information
    figure
    plot(time,res,'b*')
    xlabel('time (s)')
    ylabel('res (ohms)')
    ylim([0 1])
    
    figure
    plot(time,temp_av,'g*')
    xlabel('time (s)')
    ylabel('temp (degC')
    
    figure
    plot(temp_av,res,'r*')
    xlabel('temp (degC)')
    ylabel('res (ohms)')
    ylim([0 1])
    
    
    %beigin user input of relevant data
    fprintf('the current iteration number is: %i\n',i)
    
    %calculate start time based on when temp = 60
    tstart_bool = (round(temp_ar) >= 60 * ones(1,4));
    for j = 1:length(tstart_bool)
        if tstart_bool(j,:) == ones(1,4)
            tstart = time(j,1);
            break
        end
    end
    try
        gr(i).tstart = tstart(1,1);
        fprintf('the start time is at %f (s)\n', tstart);
    catch
        gr(i).tstart = time(end);
        disp('unable to determine start time');
    end
    %i = 23 is an exception
    if i == 23
        gr(i).tstart = 23;
    end
        
    %user input for stop time based on cutoff temp from Temp vs. R plot
%     try
%         fprintf('the current stop time is %f (s)\n',gr(i).tstop)
%     catch
%         disp('no stop time has previously been determined')
%     end
%     
%     endTemp = input('Enter end temp (degC):');
%     
%     try
%         tstop = time(temp_av >= endTemp);
%         tstop = tstop(1,1);
%     catch
%         disp('index is empty, given end temperature does not occur');
%         tstop = 0;
% %     end
%     
%     if ~isnan(tstop) || tstop ~= 0
%         gr(i).tstop = tstop;
%         fprintf('the stop time is %f (s)\n',tstop)
%     end
    
    
    %get user input for switch temperature estimations
    %gr(i).Ts_est = input('Enter guess Ts (degC):');
    %gr(i).Ts_ub = input('Enter Ts upperbound (degC):');
    %gr(i).Ts_lb = input('Enter Ts lowerbound (degC):');
    
    %wait for user input to continue
    input('Press any key to continue...')
    
    clc
    close all
    
end

save('graphRead.mat','gr')