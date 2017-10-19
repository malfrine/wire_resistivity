function [R_pred, Rho_pred] = getR_pred(T,par,Ts,w_a)

del_l = 1e-3;

Rho_pred = ...
    (par(1)*T.^3 + par(2)*T.^2 + par(3)*T + par(4)) .* (T <= Ts) + ...
    (par(5)*T.^3 + par(6)*T.^2 + par(7)*T + par(8)) .* (T > Ts);

R_pred = sum(Rho_pred,2) ./ w_a * del_l;
end