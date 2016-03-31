function [Y, A1, Z1, R1, D] = srnfwd(srn_net, U, nlength)

if (nargin < 3)
    nlength = size(U, 2) / 2; % for "Addition problem" only
end

w1_in = srn_net.w1_in;
w1_rec = srn_net.w1_rec;
b1 = srn_net.b1;
w2 = srn_net.w2;
b2 = srn_net.b2;
hiddenfunc = srn_net.hiddenfunc;

ndata = size(U, 1);
nin = size(w1_in, 1);
nhidden = size(w1_rec, 1);

A1 = zeros(ndata, nhidden, nlength);
Z1 = zeros(ndata, nhidden, nlength);
R1 = zeros(ndata, nhidden, nlength);
D = cell(nlength, 2);
idx_A = 1:2:nhidden;
idx_B = 2:2:nhidden;

r1 = zeros(ndata, nhidden);

for n = 1:nlength
    u = U(:, nin*(n-1)+1:nin*n);
    
    a1 = u*w1_in + r1*w1_rec + ones(ndata, 1)*b1;
    
    switch hiddenfunc
        case 'tanh'
            z1 = tanh(a1);
        case 'relu'
            z1 = max(a1, 0);
        case 'oplu'
            a1_A = a1(:, idx_A);
            a1_B = a1(:, idx_B);
            diff = a1_A - a1_B;
            
            diff_pairs_indexes = find(diff > 0);
            
            [diff_cols, diff_rows] = ind2sub(size(diff), diff_pairs_indexes);
            perm_2nd_cols = diff_rows*2;
            perm_1st_cols = perm_2nd_cols - 1;
            
            size_a1 = size(a1);
            perm_pairs_indexes_1st = sub2ind(size_a1, diff_cols, perm_1st_cols);
            perm_pairs_indexes_2nd = sub2ind(size_a1, diff_cols, perm_2nd_cols);
            
            z1 = a1;
            z1(perm_pairs_indexes_1st) = a1(perm_pairs_indexes_2nd);
            z1(perm_pairs_indexes_2nd) = a1(perm_pairs_indexes_1st);
            
            D{n, 1} = perm_pairs_indexes_1st;
            D{n, 2} = perm_pairs_indexes_2nd;            
        otherwise
            error('Not known activation function');
    end
    
    A1(:, :, n) = a1;
    Z1(:, :, n) = z1;
    R1(:, :, n) = r1;
    
    r1 = z1;
end

A2 = z1*w2 + ones(ndata, 1)*b2;

switch srn_net.outfunc
    case 'linear'
        Z2 = A2;
        Y = Z2;
    case 'tanh'
        Z2 = tanh(A2);
        Y = Z2;
    case 'softmax'
        maxcut = log(realmax) - log(srn_net.nout);
        mincut = log(realmin);
        A2 = min(A2, maxcut);
        A2 = max(A2, mincut);
        temp = exp(A2);
        Z2 = temp./(sum(temp, 2)*ones(1, srn_net.nout));
        Y = Z2;
    otherwise
        error 'Don''t know outfunc!';
end