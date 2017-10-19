clc
clear

load('usol.mat')
load('u.mat')

data = [];
row = 56;

for i = length(usol.u):-1:1
    for j = length(usol.u(i).s):-1:1
        row = row - 1;
        sol = usol.u(i).s(j);
        
        %build table columns
        par_av = mean(sol.par,1);
        par_std = std(sol.par,1) ./ par_av;
        a1(row,1) = par_av(1);
        std_a1(row,1) = par_std(1);
        a2(row,1) = par_av(2);
        std_a2(row,1) = par_std(2);
        a3(row,1) = par_av(3);
        std_a3(row,1) = par_std(3);
                a4(row,1) = par_av(4);
        std_a4(row,1) = par_std(4);
        b1(row,1) = par_av(5);
        std_b1(row,1) = par_std(5);
        b2(row,1) = par_av(6);
        std_b2(row,1) = par_std(6);
        b3(row,1) = par_av(7);
        std_b3(row,1) = par_std(7);
                b4(row,1) = par_av(8);
        std_b4(row,1) = par_std(8);
        Ts(row,1) = mean(sol.Ts);
        std_Ts(row,1) = std(sol.Ts) / Ts(row,1);
        sse(row,1) = mean(sol.sse_val);
        std_sse(row,1) = std(sol.sse_val) / sse(row,1);
        
        %row identifiers
        type{row,1} = u(i).type;
        run(row,1) = j;
        data_file_location{row,1} = u(i).s(j).loc;
        
    end
end

usol_Table = table(a1,std_a1,a2,std_a2,a3,std_a3,a4,std_a4,b1,std_b1,b2,...
    std_b2,b3,std_b3,b4,std_b4,Ts,std_Ts,sse,std_sse,type,run,...
    data_file_location);

filename = 'usol.xlsx';
writetable(usol_Table,filename)

save('usol_Table.mat','usol_Table')