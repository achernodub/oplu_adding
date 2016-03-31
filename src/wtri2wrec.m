function w_rec = wtri2wrec(w_tri)

% We assume that input w_tri is in packed form, i.e. it is Kx1 vector

K = length(w_tri);
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

w_rec = expm(C).*1.0;