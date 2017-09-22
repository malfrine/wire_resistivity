clear
clc

load('type_list.mat')
load('raw_struct.mat')

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

save('comb_struct','t')