clear
clc

%load relevant data
load('raw_struct_backup.mat')
load('type_list.mat')



len_type = length(type_list);
var0 = [1e-3*ones(len_type,6),400*ones(len_type,1)]; 

for i = len_type:-1:1
    itype = type_list{i}
    if s(i).type == itype
        a(i).soln = fminbnd(@objfun,var0);
        
    end
end

fminbnd