function srn_net = srnunpak(srn_net, w)

nin = srn_net.nin;
nhidden = srn_net.nhidden;
nout = srn_net.nout;
nw1_in = srn_net.nw1_in;
nw1_rec = srn_net.nw1_rec;
nb1 = srn_net.nb1;
nw2 = srn_net.nw2;
nb2 = srn_net.nb2;

%w = [srn_net.w1_in(:);srn_net.w1_rec(:);srn_net.b1(:);srn_net.w2;srn_net.b2];

mark1 = nw1_in;
srn_net.w1_in = reshape(w(1:mark1), nin, nhidden);

mark2 = mark1 + nw1_rec;
srn_net.w1_rec = reshape(w(mark1 + 1:mark2), nhidden, nhidden);

mark3 = mark2 + nb1;
srn_net.b1 = reshape(w(mark2 + 1: mark3), 1, nhidden);

mark4 = mark3 + nw2;
srn_net.w2 = reshape(w(mark3 + 1:mark4), nhidden, nout);

mark5 = mark4 + nb2;
srn_net.b2 = reshape(w(mark4 + 1:mark5), 1, nout);