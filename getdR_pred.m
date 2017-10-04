function dR_pred = getdR_pred(T,dp,Ts,w_a)

dT = (T - (ones(size(T))*diag(mean(T)))) ./ ...
    (ones(size(T))*diag(std(T)));
del_l = 1e-3;

dRho_pred = ...
    (dp(1)*dT.^2 + dp(2)*dT + dp(3)) .* (T <= Ts) + ...
    (dp(4)*dT.^2 + dp(5)*dT + dp(6)) .* (T > Ts);

dR_pred = sum(dRho_pred,2) ./ w_a * del_l;
end