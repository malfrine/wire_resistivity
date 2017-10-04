clc
clear
%load relevant data
load('u.mat')
load('type_list.mat')
load('graphRead.mat')

%[T_opt,fval]=fminbnd(@mdl_build,T_lb,T_ub,options,T_id,R_id,Tmean,Tstd,Rmean,Rstd);
%[p_opt,fval] = fminunc(@mdl_optim,p,opts);

n_sims = 10;
len_u = length(u);
si = 0;


for i = len_u:-1:1
    for j = length(u(i).s)
        si = si + 1;
        for k = n_sims:-1:1
            
            data = [u(i).s(j).R, u(i).s(j).w_a, u(i).s(j).T_int];
            
            %split data
            n = randperm(size(data,1));
            n_id = 1:ceil(0.6*length(n));
            n_val = length(n_id)+1:length(n);
            
            %Identification data
            id = [data(1,:);data(n(n_id),:);data(end,:)];
            
            %Validation data
            val = data(n(n_val),:);
            
            %Ts optimization
            options = optimset(...
                'MaxFunEval',1e4,...
                'MaxIter',1e4,...
                'Display','iter-detailed',...
                'TolX',1e-8);
            
            T_lb = gr(si).Ts_lb;
            T_ub = gr(si).Ts_ub;
            
            [Ts_opt,fval] = fminbnd(@Ts_fn,T_lb,T_ub,options,id);
            
            load dpar_opt.mat
            
            sol.u(i).s(j).par(k,:) = par_opt';
            sol.u(i).s(j).Ts(k) = Ts_opt;
            
            
            %compare validation and identification data
            R_val = val(:,1);
            w_a_val = val(:,2);
            T_val = val(:,3:end); 
            R_pred_val = getR_pred(T_val,par_opt,Ts_opt,w_a_val);
            sse_val = (R_val - R_pred_val)'*(R - R_pred_val);
            sol.u(i).s(j).sse_val(k) = sse_val; 
        end
    end
end

save('usol.mat','sol')

