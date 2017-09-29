function t = sortByType(s,type_list)
load graphRead.mat
count = zeros(length(type_list),1);
%combine structs based on typ
for j = length(type_list):-1:1
    jtype = type_list{j};
    
    %init matrices for appending
    t(j).type = jtype;
    t(j).temp = [];
    t(j).time = [];
    t(j).R = [];
    t(j).w_a = [];
    t(j).w_l = [];
    t(j).Ts_est = [];
    t(j).Ts_ub = [];
    t(j).Ts_lb = [];
    
    for i = length(s):-1:1
        if strcmp(s(i).type,jtype)
            count(j,1) = count(j,1) + 1;
            
            
            %get begin/end indices in order to trim data
            idx_start = find(s(i).time == gr(i).tstart); 
            idx_stop = find(s(i).time == gr(i).tstop); 
            
            
            %trim data based idx
            t(j).temp = [t(j).temp; s(i).temp(idx_start:idx_stop,:)];
            t(j).time = [t(j).time; s(i).time(idx_start:idx_stop)];
            t(j).R = [t(j).R; s(i).R(idx_start:idx_stop)];
            

            %create arrays for x-sect area, ext, and Ts guesses
            %so it is easier to determine which values correspond to
            %their respective datasets.
            len_t = length(s(i).time(idx_start:idx_stop));
            t(j).w_a = [t(j).w_a; ones(len_t,1) * s(i).w_area];
            t(j).w_l = [t(j).w_l; ones(len_t,1) * s(i).w_ext];
            t(j).Ts_est = [t(j).Ts_est; ones(len_t,1) * gr(i).Ts_est];
            t(j).Ts_ub = [t(j).Ts_ub; ones(len_t,1) * gr(i).Ts_ub];
            t(j).Ts_lb = [t(j).Ts_lb; ones(len_t,1) * gr(i).Ts_lb];
            
            %for figure structure
            u(j).s(count(j,1)).temp =  mean(s(i).temp(idx_start:idx_stop,:),2);
            u(j).s(count(j,1)).R  =  s(i).R(idx_start:idx_stop,:);
            u(j).s(count(j,1)).loc = s(i).loc;
            u(j).s(count(j,1)).i = i;
            u(j).type = s(i).type;
        end
    end
end

genFig2(u)


end