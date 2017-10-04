function [u,t] = sortByType(s,type_list)

load graphRead.mat

count = zeros(length(type_list),1);

x_loc = [0.54,0.635,0.635,0.54]; %x values of thermocouples
del_l = 1E-3;

x = zeros(1,length(x_loc));
for i = 1:length(x_loc)
    x(i) = sum(x_loc(1:i));
end
xq = 0:del_l:x(end); %query points for cubic interpolation


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
    t(j).T_int = [];
    
    for i = length(s):-1:1
        if strcmp(s(i).type,jtype)
            count(j,1) = count(j,1) + 1;
            
            %create t array
            t(j).temp = [t(j).temp; s(i).temp];
            t(j).time = [t(j).time; s(i).time];
            t(j).R = [t(j).R; s(i).R];
            
            %cubic interpolation of temp
            T_int = [];
            for k = 1:length(s(i).temp)
                if isnan(s(i).temp(k,:)) == zeros(1,length(s(i).temp(k,:)))
                    %t(i).T_int(j) = spline(x,t(i).temp(j,:));
                    T_int(k,:) = interp1(x,s(i).temp(k,:),xq,'cubic','extrap');
                    clc
                end
            end
            t(j).T_int = [t(j).T_int; T_int];
            
            %create arrays for x-sect area, ext, and Ts guesses
            %so it is easier to determine which values correspond to
            %their respective datasets.
            len_time = length(s(i).time);
            t(j).w_a = [t(j).w_a; ones(len_time,1) * s(i).w_area];
            t(j).w_l = [t(j).w_l; ones(len_time,1) * s(i).w_ext];
            t(j).Ts_est = [t(j).Ts_est; ones(len_time,1) * gr(i).Ts_est];
            t(j).Ts_ub = [t(j).Ts_ub; ones(len_time,1) * gr(i).Ts_ub];
            t(j).Ts_lb = [t(j).Ts_lb; ones(len_time,1) * gr(i).Ts_lb];
            
            %create u array
            u(j).s(count(j,1)).temp =  mean(s(i).temp,2);
            u(j).s(count(j,1)).R  =  s(i).R;
            u(j).s(count(j,1)).w_a = ones(len_time,1) * s(i).w_area;
            u(j).s(count(j,1)).w_l = ones(len_time,1) * s(i).w_ext;
            u(j).s(count(j,1)).loc = s(i).loc;
            u(j).s(count(j,1)).i = i;
            u(j).s(count(j,1)).T_int = T_int;
            u(j).type = s(i).type;
            
        end
    end
end

genFig2(u)


end