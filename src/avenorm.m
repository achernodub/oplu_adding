function ave = avenorm(x)

ndata = size(x, 1);
norms = zeros(ndata, 1);

for k = 1:ndata
    norms(k) = norm(x(k, :));
end

ave = mean(norms, 1);