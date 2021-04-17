function [Z, obj] = IMSC(X, Im, k, lbd, gamma)

V = size(X, 1);
n = size(X{1}, 2);
max_iter = 100;

% init 
beta = ones(V,1)/V;
for v=1:V
    X{v}(:,Im{v}) = 0;
end
[Z] = init_Z(X, beta, lbd);

t = 0;
flag = 1;
while flag
    %% update F
    [F] = update_F(Z, k);
    %% update Z
    [Z] = update_Z(X, F, beta, lbd, gamma);
    %% update X
    [X] = update_X(X, Im, Z);
    %% update beta 
%     [beta] = update_beta(X, Z);
    %% cal obj
    t = t+1;
    [obj(t),~,~,~] = cal_obj(X, Z, F, beta, lbd, gamma);
    if t>=2 && (abs((obj(t-1)-obj(t))/(obj(t)))<1e-3 || t>max_iter)
        flag =0;
    end
end
  
end
