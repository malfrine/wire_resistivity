clc
clear
warning('off','all')

%load relevant data
load('u.mat')
load('type_list.mat')
load('graphRead.mat')

n_sims = 5;
len_u = length(u);
si = 0;


for i = 1:len_u
    for j = 1:length(u(i).s)
        si = si + 1;
        for k = 1:n_sims
            
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
            
            load par_opt.mat
            
            usol.u(i).s(j).par(k,:) = par_opt';
            usol.u(i).s(j).Ts(k) = Ts_opt;
            
            
            %compare validation and identification data
            R_val = val(:,1);
            w_a_val = val(:,2);
            T_val = val(:,3:end); 
            R_pred_val = getR_pred(T_val,par_opt,Ts_opt,w_a_val);
            sse_val = (R_val - R_pred_val)'*(R_val - R_pred_val);
            usol.u(i).s(j).sse_val(k) = sse_val; 
            
            %plot raw, val and id data then save figure
            T_id = id(:,3:end);
            R_id = id(:,1);
            
            T_val_av = mean(T_val,2);
            T_id_av = mean(T_id,2);
            
            simstr = sprintf(' - sim: %i',k);
            figtitle = [u(i).s(j).loc,simstr];
            Ts_txt = sprintf('Ts = %f degC',Ts_opt);
            figname = sprintf('u(%i)s(%i)sim%i', i, j, k);
            
            close all
            figure
            title(figtitle)
            plot(T_id_av, R_id,'ro',T_val_av,R_val,'gd');
            xlabel('Temperature (degC)');ylabel('Resistance');
            ylim([0,1]);
            legend({'identification','validation'},'Location','southeast');
            text(100,0.9,Ts_txt);
            
            %save figure
            p = pwd;
            cd([pwd '\fig3'])
            saveas(gcf, figname)
            cd(p);
            
        end
    end
end

save('usol.mat','usol')

