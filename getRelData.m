function s = getRelData(s)

tstart = 8;
for i = length(s):-1:1
    
    dim = size(s(i).data);
    
    s(i).time = s(i).data(tstart:end,1);
    s(i).temp = s(i).data(tstart:end,2:5);
    
    if dim(1,2) == 13
        volts = s(i).data(tstart:end,6);
        curr = s(i).data(tstart:end,7);
        s(i).R = volts ./ curr;
        s(i).w_area = s(i).data(1,13);
        s(i).w_ext = s(i).data(2,13);
        
    elseif dim(1,2) == 17
        volts = s(i).data(tstart:end,6+6);
        curr = s(i).data(tstart:end,7+6);
        s(i).R = volts ./ curr;
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
end

end