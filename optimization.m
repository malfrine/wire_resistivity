clear
clc

%load relevant data
load('t.mat')
load('type_list.mat')


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
        
        %optimization
        options = optimset(...
            'MaxFunEval',1e4,...
            'MaxIter',1e4,...
            'Display','iter',...
            'TolX',1e-8);
        
        
    end
end

