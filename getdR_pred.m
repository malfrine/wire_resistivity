function [dR_pred,dRho_pred] = getdR_pred(T,dp,Ts,w_a)

dT = (T - mean(T(:))) / std(T(:));
del_l = 1e-3;

dRho_pred = ...
    (dp(1)*dT.^3 + dp(2)*dT.^2 + dp(3)*dT + dp(4)) .* (T <= Ts) + ...
    (dp(5)*dT.^5 + dp(6)*dT.^2 + dp(7)*dT + dp(8)) .* (T > Ts);

dR_pred = sum(dRho_pred,2) ./ w_a * del_l;

end