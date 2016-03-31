clc
clear

addpath('synthetic_problems');
addpath('src');

%% Prepare data

%hiddenfunc = 'tanh';
%hiddenfunc = 'relu';
hiddenfunc = 'oplu';

nlength_array = [10, 30, 50, 70, 100, 150, 200];

problem_name = 'adding';
nin = 2;
nhidden = 100;
nout = 1;
outfunc = 'linear';

for n = 1:length(nlength_array)
    nlength = nlength_array(n);
    ntrain = 500;
    
    [U1, T1] = get_problem(nlength, ntrain, problem_name);
    
    %% Create net
    
    srn_pure_array = {};
    
    tic
    for i = 1:10
        srn_net = srnnew(nin, nhidden, nout, hiddenfunc, outfunc);
        srn_pure_array{i} = srn_net;
        
        if (2 == 1)
            [Y1, ~, Z1_1, R1_1, D_1] = srnfwd(srn_net, U1, nlength);
            [f, norm_gw1_in_in_time, norm_gw1_rec_in_time, norm_deltas_hidden_in_time] = make_plot_gradients(srn_net, Y1, U1, Z1_1, R1_1, T1, nlength, 'on', '', D_1);
            
            pause
        end
    end
    toc
    
    
    
    save(sprintf('nets_addition\\SRN_%d_%s_%s_WS', nlength, problem_name, hiddenfunc), 'srn_pure_array');
end