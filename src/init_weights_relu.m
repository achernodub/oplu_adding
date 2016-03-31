function w = init_weights_relu(nin, nout)

a = sqrt(2/nout);
w = (rand(nin, nout).*2 - 1).*a;