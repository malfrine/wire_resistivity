function [s,type_list] = getTypes(s)
    %get the different experimental types
    len_s = length(s);
    type_list = cell(length(s),1);
    for i = 1:len_s
        tags = strsplit(s(i).loc,'\');
        s(i).type = [tags{2},'-', tags{3}];
        s(i).type = strrep(char(sprintf(s(i).type)),' ','');
        type_list{i} = s(i).type;
    end
    type_list = unique(type_list);
end