clear
clc

load raw_xlsx_data.mat

%the row where data is a number in the dataset
tstart = 8;

%x values of thermocouples
x_loc = [0.54,0.635,0.635,0.54];
del_l = 1E-3;
x = zeros(1,length(x_loc));
for i = 1:length(x_loc)
    x(i) = sum(x_loc(1:i));
end
xq = 0:del_l:x(end); %query points for cubic interpolation

%list of different experimental setups
type_list = cell(length(s),1);

for i = length(s):-1:1
    
    %clean dataset - pull to specific tags based on reading .xls file.
    s(i).dim = size(s(i).data);
    s(i).time = s(i).data(tstart:end,1);
    s(i).temp = s(i).data(tstart:end,2:5);
    

    
    if s(i).dim(1,2) == 13
        s(i).volts = s(i).data(tstart:end,6);
        s(i).curr = s(i).data(tstart:end,7);
        s(i).v_l = s(i).data(tstart:end,8);
        s(i).w_area = s(i).data(1,13);
        s(i).w_ext = s(i).data(2,13);
        
    elseif s(i).dim(1,2) == 17
        s(i).tmv = s(i).data(tstart:end,6:9);
        s(i).cgc = s(i).data(tstart:end,10);
        s(i).gref = s(i).data(tstart:end,11);
        s(i).volts = s(i).data(tstart:end,6+6);
        s(i).curr = s(i).data(tstart:end,7+6);
        s(i).v_l = s(i).data(tstart:end,8+6);
        if (i >= 1 && i <= 25) || (i>=47 && i<=55)
                s(i).w_area = s(i).data(1,15);
                s(i).w_ext = s(i).data(2,15);   
        elseif (i >=25 && i <=35) || (i >= 41 && i <=46)
                s(i).w_area = s(i).data(2,16);
                s(i).w_ext = s(i).data(3,16);
        else
                s(i).w_area = s(i).data(2,15);
                s(i).w_ext = s(i).data(3,15);
        end
    end
    
    %calcs - av temp, resistivity, resistance
    s(i).temp_av = mean(s(i).temp,2);
    s(i).rho = s(i).volts * s(i).w_area ./ s(i).curr / s(i).w_ext;
    s(i).R = s(i).volts ./ s(i).curr;
    s(i).R = s(i).R(isnan(s(i).R) == 0);
    
    %normalization
    s(i).mu_R = mean(s(i).R);
    s(i).std_R = std(s(i).R);
    s(i).dR = (s(i).R - s(i).mu_R) / s(i).std_R;
    
    %cubic interpolation of T = f(x) and normalization
    for j = tstart:length(s(i).temp) % j = time index of gi
        if isnan(s(i).temp(j,:)) == zeros(1,length(s(i).temp(j,:)))
            s(i).temp_int(j) = spline(x,s(i).temp(j,:));
            temp_val = ppval(s(i).temp_int(j),xq);
            s(i).mu_T = mean(temp_val);
            s(i).std_T = std(temp_val);
            %s(i).dT(j,:) = (temp_val - s(i).mu_T) / s(i).std_T;
        end
    end
    
    %tag info - getting material and type of test for future reference.
    s(i).tags = strsplit(s(i).loc,'\');
    s(i).matl = s(i).tags{2};
    s(i).treat = s(i).tags{3};
    s(i).type = [s(i).tags{2},'-', s(i).tags{3}];
    s(i).type = strrep(char(sprintf(s(i).type)),' ','');
    
    type_list{i} = s(i).type;
    
end

type_list = unique(type_list);

save('raw_struct','s')
save('type_list', 'type_list')

