function R_pred = getR_pred(T,par,Ts,w_a)

del_l = 1e-3;

Rho_pred = ...
    (par(1)*T.^2 + par(2)*T + par(3)) .* (T <= Ts) + ...
    (par(4)*T.^2 + par(5)*T + par(6)) .* (T > Ts);

R_pred = sum(Rho_pred,2) ./ w_a * del_l;
end