function [F] = update_F(Z, k)

n = size(Z, 1);

opts.disp = 0;
% [U,~,V] = svds(Z, k, 'largest', opts);
% F = (U*V')';

[Ftmp, ~] = eigs(Z+Z', k, 'la', opts);
F = Ftmp';

end

