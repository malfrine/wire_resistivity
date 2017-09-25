function t = sortByType(s,type_list)
%combine structs based on typ
for j = length(type_list):-1:1
    jtype = type_list{j};
    t(j).type = jtype;
    t(j).temp = [];
    t(j).time = [];
    t(j).R = [];
    t(j).w_a = [];
    t(j).w_l = [];
    for i = length(s):-1:1
        if strcmp(s(i).type,jtype)
            t(j).temp = [t(j).temp; s(i).temp];
            t(j).time = [t(j).time; s(i).time];
            t(j).R = [t(j).R; s(i).R];
            len_t = length(s(i).time);
            t(j).w_a = [t(j).w_a; ones(len_t,1) * s(i).w_area];
            t(j).w_l = [t(j).w_l; ones(len_t,1) * s(i).w_ext];
        end
    end
end



end