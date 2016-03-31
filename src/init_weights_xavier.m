function w = init_weights_xavier(nin, nout)

a = sqrt(6/(nin+nout));
w = (rand(nin, nout).*2 - 1).*a;