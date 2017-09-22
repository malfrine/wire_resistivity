clear
clc

load('type_list.mat')
load('raw_struct.mat')

fields_to_rm = {'data', 'dim', 'time', 'temp_av', 'tmv', 'cgc', 'gref',...
    'volts', 'curr', 'v_l', 'rho','tags','matl','treat'};
s = rmfield(s,fields_to_rm);

%combine structs based on type
count = zeros(length(type_list),1);
for i = length(s):-1:1
    for j = length(type_list):-1:1
        jtype = type_list{j};
        if strcmp(s(i).type,jtype)
            count(j) = count(j) + 1;
            t(j).s(count(j)) = s(i);
        end
    end
end

%manipulate t for optimization







save('comb_struct','t')