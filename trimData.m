function s = trimData(s)

load graphRead.mat

for i = 1:length(s)
   idx_start = find(s(i).time == gr(i).tstart); 
   idx_stop = find(s(i).time == gr(i).tstop);
   
   s(i).time = s(i).time(idx_start:idx_stop);
   s(i).temp = s(i).temp(idx_start:idx_stop,:);
   s(i).R = s(i).R(idx_start:idx_stop);
    
end


end