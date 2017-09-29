clc
clear

fid = fopen('locs.txt');
file_loc = textscan(fid,'%s','Delimiter','\n');
fclose(fid);

%clean strings
file_loc = file_loc{1};
for i = 1:length(file_loc)
    file_loc{i} = strrep(file_loc{i},'"','');
end

%data_clean
N = length(file_loc);
s(N).data = [];
s(N).loc = [];

for i = 1:N
    
    %load raw data to s .xlsx file based on the given path from file_loc
    try
        s(i).data = xlsread(file_loc{i});
    catch
        s(i).data = [];
        fprintf('s(%i) is empty\n',i)
    end
    
    %save file path to s
    s(i).loc = file_loc{i};
end

save('s.mat','s');