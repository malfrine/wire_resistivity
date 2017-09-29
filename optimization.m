clc

%load relevant data
load('t.mat')
<<<<<<< HEAD
=======
load('type_list.mat')
>>>>>>> 675ab194123474da2e9e1cb44549b98d3780b213

n_sims = 10; %* change to 10
len_t = length(t);

<<<<<<< HEAD

for i = len_t:-1:1
    for j = n_sims:-1:1
        
        data = [t(i).R, t(i).w_a, t(i).T_int];
        
        %split data
        n = randperm(size(data,1));
        n_id = 1:ceil(0.6*length(n));
        n_val = length(n_id)+1:length(n);
        
        %Identification data
        id = [data(1,:);data(n(n_id),:);data(end,:)];
        
        %Validation data
        val = data(n(n_val),:);
=======
%[T_opt,fval]=fminbnd(@mdl_build,T_lb,T_ub,options,T_id,R_id,Tmean,Tstd,Rmean,Rstd);
%[p_opt,fval] = fminunc(@mdl_optim,p,opts);

n_sims = 10;
len_t = length(t);


for i = len_t:-1:1
    for j = n_sims:-1:1
        %splitData
        a = [t(i).T_int,t(i).R];
        n_samps = ceil(0.6*length(a));
        training_set = intersect(a,randsample(a,n_samps));        
        test_set = a(~ismember(a,trainingset));
>>>>>>> 675ab194123474da2e9e1cb44549b98d3780b213
        
        %optimization
        options = optimset(...
            'MaxFunEval',1e4,...
            'MaxIter',1e4,...
<<<<<<< HEAD
            'Display','iter-detailed',...
            'TolX',1e-8);
        
        T_lb = 100;
        T_ub = 1500;
        
        [Ts_opt,fval] = fminbnd(@Ts_fn,T_lb,T_ub,options,id);
        
        
        load dp_par.mat
        t(i).param_mat(j,:) = dp_par';
        t(i).Ts_mat(j) = Ts_opt;
=======
            'Display','iter',...
            'TolX',1e-8);
        
>>>>>>> 675ab194123474da2e9e1cb44549b98d3780b213
        
    end
end

<<<<<<< HEAD
save 'pray'
=======
>>>>>>> 675ab194123474da2e9e1cb44549b98d3780b213
