function w = init_weights_ortho(nin, nout)

N = max(nin, nout);
%O = orth(rand(N, N));

O = wtri2wrec(rand(nwrec2nwtri(N), 1));

w = O(1:nin, 1:nout);