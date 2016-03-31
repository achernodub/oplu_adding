function srn_net = srnnew(nin, nhidden, nout, hiddenfunc, outfunc)

srn_net.type = 'srn';
srn_net.nin = nin;
srn_net.nhidden = nhidden;
srn_net.nout = nout;
srn_net.hiddenfunc = hiddenfunc;
srn_net.outfunc = outfunc;

srn_net.nwts = (nin + 1)*nhidden + (nhidden + 1)*nout;

srn_net.beta = 1;
srn_net.r1_start = 0;

srn_net.b1 = zeros(1, nhidden);
srn_net.b2 = zeros(1, nout);
srn_net.prev_z1 = zeros(1, nhidden);

switch hiddenfunc
    case 'tanh'
        srn_net.w1_in = init_weights_xavier(nin, nhidden);
        srn_net.w1_rec = init_weights_xavier(nhidden, nhidden);
        srn_net.w2 = init_weights_xavier(nhidden, nout);
    case 'relu'
%         srn_net.w1_in = init_weights_relu(nin, nhidden);
%         srn_net.w1_rec = init_weights_relu(nhidden, nhidden);
%         srn_net.w2 = init_weights_relu(nhidden, nout);
%         srn_net.w1_in = init_weights_xavier(nin, nhidden);
%         srn_net.w1_rec = init_weights_xavier(nhidden, nhidden);
%         srn_net.w2 = init_weights_xavier(nhidden, nout);
        srn_net.w1_in = init_weights_pascanu(nin, nhidden);
        srn_net.w1_rec = init_weights_pascanu(nhidden, nhidden);
        srn_net.w2 = init_weights_pascanu(nhidden, nout);
    case 'oplu'
        srn_net.w1_in = init_weights_ortho(nin, nhidden);
        srn_net.w1_rec = init_weights_ortho(nhidden, nhidden);
        srn_net.w2 = init_weights_ortho(nhidden, nout);
    otherwise
        error('Not known activation function');
end

srn_net.nw1_in = numel(srn_net.w1_in);
srn_net.nw1_rec = numel(srn_net.w1_rec);
srn_net.nb1 = numel(srn_net.b1);
srn_net.nw2 = numel(srn_net.w2);
srn_net.nb2 = numel(srn_net.b2);

srn_net.nwts = srn_net.nw1_in + srn_net.nw1_rec + srn_net.nb1 + srn_net.nw2 + srn_net.nb2;

srn_net.nfield = 5;
srn_net.field1 = 'w1_in';
srn_net.field2 = 'w1_rec';
srn_net.field3 = 'b1';
srn_net.field4 = 'w2';
srn_net.field5 = 'b2';

j = 0;

for n = 1:srn_net.nfield
    eval(sprintf('curr_field = srn_net.field%d;', n))
    eval(sprintf('curr_nw = numel(srn_net.%s);', curr_field));
            
    j = j  + 1;
    eval(sprintf('srn_net.l%d = j;', n));
    j = j + curr_nw - 1;
    eval(sprintf('srn_net.m%d = j;', n));
    
    eval(sprintf('srn_net.sz%d_1 = size(srn_net.%s, 1);', n, curr_field));
    eval(sprintf('srn_net.sz%d_2 = size(srn_net.%s, 2);', n, curr_field));
end