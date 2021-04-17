function [Z] = update_Z(X, F, beta, lbd, gamma)

V = length(X);
n = size(X{1}, 2);


% cal K and C
K = zeros(n, n);
for v=1:V
    K = K + beta(v)*X{v}'*X{v};
end
C = F'*F;
base = K + (lbd+gamma)*eye(n);

% Z = Z1 + Z2
% cal Z1
D = inv(base);
beta = diag(D); % for cal Z2
Z1 = -D./diag(D)';
Z1 = Z1 - diag(diag(Z1));

% form 4
C = C - diag(diag(C)); a = D*C; a = a - diag(diag(a));
b = diag(Z1'*C); 
c = beta.*b;
d = Z1*diag(c); d = d - diag(diag(d));
Z2 = gamma*(a-d);

% % cal Z2
% Z2 = zeros(n,n);
% if gamma ~= 0
%     for i=1:n
%         ind = setdiff([1:n], i);
% %         % form 1
% %         bibiT = Z1(ind,i)*Z1(ind,i)';
% %         Ei= D(ind,ind) - beta(i)*bibiT;
% %         Z2(ind,i) = Ei*gamma*C(ind,i);
% %         % form 2
%         Z2(ind,i) = D(ind,ind)*gamma*C(ind,i) - beta(i)*Z1(ind,i)*(Z1(ind,i)'*gamma*C(ind,i));
% %         % form 3
% %         Z2(ind,i) = gamma*( a(ind,i) - beta(i)*Z1(ind,i)*b(i));
%     end 
% end

Z = Z1+Z2;

end

