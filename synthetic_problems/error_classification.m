function e = error_classification(T, Y)

ndata = size(T, 1);

success_count = 0;
for k = 1:ndata    
    y = Y(k, :);
    t_bin = T(k, :);
    
    y_bin = zeros(size(y));
    y_max_idx = find(y == max(y));
    y_max_idx = y_max_idx(1);
    y_bin(y_max_idx) = 1;
    
    if (t_bin == y_bin)
        success_count = success_count + 1;
    end        
end

e = (success_count / ndata).*100;




