function [U, T] = get_multiplication_problem(nlength, ndata)

nin = 2;
T_period_tilda = ceil((11/10)*nlength);

U = rand(ndata, nin*nlength)*2 - 1;
T = zeros(ndata, 1);

zeros_idx = 2:2:nlength*2;

U(:, zeros_idx) = 0;

I = get_random_int(ndata, 1, 1, T_period_tilda / 10);
J = get_random_int(ndata, 1, (T_period_tilda / 10) + 1, T_period_tilda / 2);

I_idx_marker = I*nin;
I_idx_value = I*nin - 1;

J_idx_marker = J*nin;
J_idx_value = J*nin - 1;

for k = 1:ndata
    U(k, I_idx_marker(k)) = 1;
    U(k, J_idx_marker(k)) = 1;
    
    a = U(k, I_idx_value(k));
    b = U(k, J_idx_value(k));
    c = a*b;
    T(k) = c;
end