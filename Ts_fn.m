function sse_Ts = Ts_fn(Ts, id)
R = id(:,1);
w_a = id(:,2);
T = id(:,3:end);
dR = (R - mean(R)) / std(R);
dT = (T - (ones(size(T))*diag(mean(T)))) ./ ...
    (ones(size(T))*diag(std(T)));
del_l = 1e-3;

%get initial point
dR_start = [sum(dT.^2,2) sum(dT,2) size(dT,2)*ones(size(dT,1),1)] * 1e-3 ./ w_a ;
dp_start = [pinv(dR_start)*dR; 0.9*pinv(dR_start)*dR];

%quadratic parameters optimization
opts = optimset(...
    'LargeScale','off',...
    'Algorithm','active-set',...
    'MaxFunEvals',1e5,...
    'MaxIter',1e5,...
    'TolX',1e-12,...
    'TolFun',1e-8,...
    'Display','iter-detailed');

[dp_par,fval] = fminunc(@par_fun,dp_start,opts);

%calculate predicted resistance
dR_pred_Ts = getdR_pred(T,dp_par,Ts,w_a);

save dp_par.mat dp_par
sse_Ts = (dR - dR_pred_Ts)'*(dR - dR_pred_Ts);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function sse_par = par_fun(dp_par)
        dR_pred_par = getdR_pred(T,dp_par,Ts,w_a);
        sse_par = (dR-dR_pred_par)'*(dR-dR_pred_par);
        if isnan(sse_par)
            stop = 1;
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end