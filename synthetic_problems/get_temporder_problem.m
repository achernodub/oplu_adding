function [U, T] = get_temporder_problem(nlength, ndata)

nin = 6;

U_num = zeros(ndata, nlength);
U_bin = zeros(ndata, nlength*nin);

I = get_random_int(ndata, 1, nlength / 10, 2*nlength / 10);
J = get_random_int(ndata, 1, 4*nlength / 10, 5*nlength / 10);

T_bin = zeros(ndata, 4);

for i = 1:ndata
    for j = 1:nlength        
        coin_d = randi([3 6]);        
        U_num(i, j) = coin_d;        
    end
    
    coin_out = randi([1 4]);
    
    switch coin_out
       case 1
          s = 1;
          e = 1;
       case 2
          s = 1;
          e = 2;
       case 3
          s = 2;
          e = 1;
       case 4
          s = 2;
          e = 2;          
        otherwise
          error strange_error;
    end
    
    start_idx = I(i);
    end_idx = J(i);
    
    U_num(i, start_idx) = s;
    U_num(i, end_idx) = e;    
    
    for j = 1:nlength
        j1 = (j-1)*nin + 1;
        j2 = j*nin;
        
        U_bin(i, j1:j2) = num2bin(U_num(i, j), 6);        
    end    
    
    T_bin(i, :) = num2bin(coin_out, 4);
end

U = U_bin;
T = T_bin;