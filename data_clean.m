clear
clc
warning('off','all')

load s.mat


%get the different experimental types
[s,type_list] = getTypes(s);

%get data for only relevant tags (resistance, temps, time)
s = getRelData(s);

%trim data starting and endpoints based on user input from getTrimTime()
s = trimData(s);

%generate figures for each i in s(i)
genFig1(s);

%arrange s so that all data from the same experimental types are appended
[u,t] = sortByType(s,type_list);

%perform cubic interpolation of t.temp
% for i = 1:length(t)
%     for j = 1:length(t(i).temp)
%         if isnan(t(i).temp(j,:)) == zeros(1,length(t(i).temp(j,:)))
%             %t(i).T_int(j) = spline(x,t(i).temp(j,:));
%             t(i).T_int(j,:) = interp1(x,t(i).temp(j,:),xq,'cubic','extrap');
%             clc
%         end
%     end
% end




save('t.mat','t')
save('u.mat','u')
