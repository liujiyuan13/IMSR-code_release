function [obj, term1, term2, term3] = cal_obj(X, Z, F, beta, lbd, gamma)

V = length(X);

term1 = 0;
for v=1:V
    tmp = X{v}-X{v}*Z;
    term1 = term1 + beta(v)*sum(sum(tmp.^2));
end

term2 = sum(sum(Z.^2));

tmp = Z-F'*F;
term3 = sum(sum(tmp.^2));

obj = term1 + lbd*term2 + gamma*term3;

end
