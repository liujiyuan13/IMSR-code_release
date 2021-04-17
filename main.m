clear
clc
warning off

proj_path = 'D:\Work\IMSR-code_release\';
addpath(genpath(proj_path));

data_path = 'D:\Work\datasets\setting\random remove\';
data_name = 'orlRnSp';
load([data_path, data_name], 'data', 'truth', 'per');
X = data'; Y = truth - min(truth) + 1;
k = length(unique(Y));
V = size(X, 1);
n = size(X{1}, 2);
% normalize data
X = normalize_data(X);

missing_ratios = [0.1:0.1:0.5];
iters = 10;
for iter = 1:iters
    for mr = 1:length(missing_ratios)
        
        fprintf('\n data_name: %s, missing rate: %.1f, iter: %d', data_name, missing_ratios(mr), iter);
        
        for v=1:size(per{mr}{iter},2)
            Im{v} = find(per{mr}{iter}(:,v)==0);
        end
        
        % parameters
        lbd_set = 2.^[-10:2:10];
        gamma_set = 2.^[-10:2:10]; 

        for il = 1:length(lbd_set)
            for ig = 1:length(gamma_set)
                % algorithm
                [Ztmp, objtmp] = IMSC(X, Im, k, lbd_set(il), gamma_set(ig));

                % cal res
                Ztmp = (abs(Ztmp)+abs(Ztmp)')/2;
                [Utmp] = baseline_spectral_onkernel(Ztmp , k);
                iters_eval = 1; % set to reduce the randomness of k-means
                for i=1:1
                    [ytmp] = my_lite_kmeans(Utmp, k);
                    [evals(i,:)] = my_eval_y(ytmp, Y);
                end
                eval = mean(evals,1);
                fprintf('\nil: %d, ig: %d, acc: %.4f, nmi: %.4f, pur: %.4f', il, ig, eval(1), eval(2), eval(3)); 
            end
        end

    end
end

