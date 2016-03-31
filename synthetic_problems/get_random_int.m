function R1 = get_random_int(m, n, min_value, max_value)

min_value = round(min_value);
max_value = round(max_value);

%R = max(1, floor(min_value)) + floor( rand(m, n)*(max_value - min_value));

R1 = zeros(m, n);
for i = 1:m
    for j = 1:n   
        r1 = randi([min_value max_value]);
        R1(i, j) = r1;
    end
end