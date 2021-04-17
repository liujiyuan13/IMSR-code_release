function [Z] = init_Z(X, beta, lbd)
  
V = length(X);
n = size(X{1}, 2);

D = zeros(n, n);
D = D + lbd*diag(ones(n,1));
for v=1:V
  D = D + beta(v)*X{v}'*X{v};
end
D = inv(D);

Z = -D./diag(D)';
Z = Z - diag(diag(Z));
  
% Z = Z./sum(Z,1);

Z = (Z+Z')/2;
end
