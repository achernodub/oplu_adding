function [f, norm_gw1_in_in_time, norm_gw1_rec_in_time, norm_deltas_hidden_in_time] = make_plot_gradients(srn_net, Y, U1, Z1, R1, T1, nlength, visible, s, D)

deltas_out = ones(size(T1));
[g, gw1_in, gw1_rec, gb1, gw2, gb2, deltas_hidden_bptt, Z1_deriv, norm_gw1_in_in_time, norm_gw1_rec_in_time, norm_u_in_time, norm_r_in_time, norm_dz_curr_dz_prev, norm_instant_dz_dz, norm_deltas_hidden_in_time]  = srnbkp(srn_net, U1, Z1, R1, deltas_out, 1, 1, D);

close all;
f = figure;
set(f, 'Position', [700 150 800 800]);
set(f, 'visible', visible);

plot(log10(norm_gw1_in_in_time));
hold on;
plot(log10(norm_gw1_rec_in_time), 'r');
plot(log10(norm_deltas_hidden_in_time), 'g');
title('\Delta_{OUT}=1');
legend('<||\Deltaw(k)_I_N||>', '<||\Deltaw(k)_R_E_C||>', '<||\delta(k)||>');
xlabel('k');
ylabel('log10 scale');
title(s);
%pause