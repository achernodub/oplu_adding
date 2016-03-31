function w_tri = wrec2wtri(w_rec)

N = size(w_rec, 1);
K = N.^2/2 - N/2;

w_tri = zeros(K, 1);

C = logm(w_rec);

cnt = 0;
for j = 2:N
   for i = 1:(j-1)
       cnt = cnt + 1;
       
       c1 = C(i, j);
       c2 = C(j, i);
       
       c = (c1 + (-c2)) / 2;
       
       w_tri(cnt) = c;
   end    
end