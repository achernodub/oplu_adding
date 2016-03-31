function C = wtri2C(w_tri)

% We assume that input w_tri is in packed form, i.e. it is Kx1 vector

K = size(w_tri, 1);
N = (1 + sqrt(1 + 8*K)) / 2;

C = zeros(N, N);

% Create skew-symmetric matrix from upper-triagonal
cnt = 0;
for j = 2:N
   for i = 1:(j-1)
       cnt = cnt + 1;
       
       C(i, j) = w_tri(cnt);
       C(j, i) = -w_tri(cnt);       
   end    
end