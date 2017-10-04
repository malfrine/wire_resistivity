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
            
            load dp_par.mat
            u(i).s(j).param_mat(k,:) = dp_par';
            u(i).s(j).Ts_mat(k) = Ts_opt;
        end
    end
end

save('u.mat','u')

