function sse_Ts = Ts_fn(Ts, id)
R = id(:,1);
w_a = id(:,2);
T = id(:,3:end);
dR = (R - mean(R)) / std(R);
dT = (T - mean(T(:))) / std(T(:));
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

%split data based on Ts

%calculate predicted resistance
dR_pred_Ts = getdR_pred(T,dpar_opt,Ts,w_a);


%denormalize parameters
par_opt = size(dpar_opt);
for i = 1:length(dpar_opt)
    if i == 1 || i == 4
        par_opt(i) = dpar_opt(i) / std(T(:))^2;
    end
    if i == 2 || i == 5
        par_opt(i) = -(2 * dpar_opt(i-1) * mean(T(:)) / std(T(:))^2 ...
            + dpar_opt(i) / std(T(:)));
    end
    if i == 3 || i == 6
        par_opt(i) = dpar_opt(i-2) * mean(T(:))^2 / std(T(:))^2 ...
            + dpar_opt(i-1) * mean(T(:)) / std(T(:)) ...
            + dpar_opt(i);
    end 
end

save par_opt.mat par_opt

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