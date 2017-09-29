clear
clc

load s.mat

%x values of thermocouples
x_loc = [0.54,0.635,0.635,0.54];
del_l = 1E-3;
x = zeros(1,length(x_loc));
for i = 1:length(x_loc)
    x(i) = sum(x_loc(1:i));
end
xq = 0:del_l:x(end); %query points for cubic interpolation

%get the different experimental types
genFig1(s);
[s,type_list] = getTypes(s);

%get data for only relevant tags (resistance, temps, time_stamps)
s = getRelData(s);

%trime data starting and endpoints based on user input from getTrimTime()
s = trimData(s);

%arrange s so that all data from the same experimental types are appended
t = sortByType(s,type_list);
genFig2(t);


%perform cubic interpolation of t.temp_int
for i = 1:length(t)
    for j = 1:length(t(i).temp)
        if isnan(t(i).temp(j,:)) == zeros(1,length(t(i).temp(j,:)))
            %t(i).T_int(j) = spline(x,t(i).temp(j,:));
            t(i).T_int(j,:) = interp1(x,t(i).temp(j,:),xq,'cubic','extrap');
            clc
        end
    end
end

save('t.mat','t')

