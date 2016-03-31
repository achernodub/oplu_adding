function w = init_weights_pascanu(nin, nout)

%a = 0.1;
a = 0.25;
w = (rand(nin, nout).*2 - 1).*a;