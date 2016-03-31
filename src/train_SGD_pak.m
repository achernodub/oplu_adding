function srn_net_out = train_SGD_pak(srn_net, U, T, nlength, nminibatch, niterations, lr, mu)

% if (nargin < 3)
%     nlength = size(U, 2) / 2; % for "Addition problem" only
% end

flag_make_pak = 1;
flag_calculate_norm = 0;
ndata = size(U, 1);
nhidden = srn_net.nhidden;

w = srnpak(srn_net);
v = zeros(size(w));

for i = 1:niterations
    mb_idx = randi(ndata, nminibatch, 1);
    mb_U = U(mb_idx, :);
    mb_T = T(mb_idx, :);
    [mb_Y, ~, mb_Z1, mb_R1, mb_D] = srnfwd(srn_net, mb_U, nlength);
    deltas_out = -(mb_T - mb_Y);

    [gw]  = srnbkp(srn_net, mb_U, mb_Z1, mb_R1, deltas_out, flag_make_pak, flag_calculate_norm, mb_D);
    
    v = mu*v - lr*gw;
    
    w = w + v;
    srn_net = srnunpak(srn_net, w);
end

srn_net_out =  srn_net;