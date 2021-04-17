function [beta] = update_beta(X, Z)

V = length(X);
 
nu = zeros(V,1);
for v=1:V
    nu(v) = sum(sum((X{v}-X{v}*Z).^2));
end

tmp = sum(1./nu)^2;
beta = (1./nu).^2./tmp;

end

