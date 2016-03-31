clc
clear

% *************************************************************************
% Supplementary material for article "A.N. Chernodub, D.V. Nowicki, 
% Norm-preserving Orthogonal Permutation Linear Unit Activation Functions", 
% submitted to ICANN'2016.
% *************************************************************************

addpath('synthetic_problems');
addpath('src');
problem_name = 'adding';

%hiddenfunc = 'tanh';
%hiddenfunc = 'relu';
hiddenfunc = 'oplu';

nlength = 30;

load(sprintf('nets_%s\\SRN_%d_%s_%s_WS', problem_name, nlength, problem_name, hiddenfunc));

for NN_No = 1:10
    %% Prepare data
    
    ntrain = 20000;
    nvalidation = 1000;
    ntest = 10000;
    
    [U2, T2] = get_problem(nlength, nvalidation, problem_name);
    [U3, T3] = get_problem(nlength, ntest, problem_name);
    
    srn_net = srn_pure_array{NN_No};    
    
    out_path = sprintf('out_%s_%s_n%d_%s\\srn_%03d', problem_name, hiddenfunc, nlength, '', NN_No);
    mkdir(out_path);
    
    [Y2, ~, Z1_2, R1_2, D_2] = srnfwd(srn_net, U2, nlength);
    [f, norm_gw1_in_in_time, norm_gw1_rec_in_time, norm_deltas_hidden_in_time] = make_plot_gradients(srn_net, Y2, U2, Z1_2, R1_2, T2, nlength, 'off', '', D_2);
    %save(sprintf('normas_%s_%d_WS', hiddenfunc, nlength), 'norm_deltas_hidden_in_time');error A;
    saveas(f, sprintf('%s\\Gradients_%03d.jpg', out_path, 0));
    save(sprintf('%s\\net_init_WS', out_path), 'srn_net');
        
    %% Set train params
    
    nminibatch = 20;
    niterations = 50;
    
    lr = 1e-04;
    mu = 0.90;
    %mu = 0;
    
    [U1, T1] = get_problem(nlength, ntrain, problem_name);
    
    best_mse_val = 100500;
    
    mse_val_array = [];    
    for k = 1:2000
        tic
        srn_net = train_SGD_pak(srn_net, U1, T1, nlength, nminibatch, niterations, lr, mu);
        t=toc;
        
        Y2 = srnfwd(srn_net, U2, nlength);
        
        esr_val = error_success_rate(T2, Y2, problem_name);        
        mse_val = mse(T2 - Y2);
        
        mse_val_array = [mse_val_array;mse_val]; % store validation errors
        save(sprintf('%s\\_mse_vall_array_WS', out_path), 'mse_val_array');
        
        if (mse_val < best_mse_val)
            best_mse_val = mse_val;
            best_esr_val = esr_val;
            best_srn_net = srn_net;
            
            save(sprintf('%s\\_curr_best_%1.2f_k_%03d', out_path, best_esr_val, k), 'best_esr_val');
        end
        
        fprintf('<strong>NN_No=%d k = %d, esr_val = %1.1f%%, mse_val = %f, %1.2f sec</strong>\n', NN_No, k, esr_val, mse_val, t);
        
        if (esr_val > 99)
            break;
        end        
    end
    
    % Get the final accuracy
    Y3 = srnfwd(best_srn_net, U3, nlength);
    esr_test = error_success_rate(T3, Y3, problem_name);
    
    % Store the results
    max_k = k - 1;
    save(sprintf('%s\\data_WS', out_path), 'esr_test', 'max_k');
    save(sprintf('%s\\_accuracy_%1.2f', out_path, esr_test), 'esr_test');

    fn_results_out = sprintf('out_%s_%s_n%d_%s\\results.txt', problem_name, hiddenfunc, nlength, '');
    if (exist(fn_results_out))
        D_results = dlmread(fn_results_out);
    else
        D_results = [];
    end
    
    D_results = [D_results,esr_test];
    dlmwrite(fn_results_out, D_results, '|');
    
    fprintf('<strong>NN_No=%d, final esr_test = %1.1f%%</strong>\n', NN_No, esr_test);
end

% close all;
% plot(log10(e_array));
% title('Error Train, log scale');
% xlabel('Epoch');
% ylabel('MSE');