function e = error_regression(T, Y, success_value)

if (nargin < 3)
    success_value = 0.04;
end   

ndata = size(T, 1);
success_count = 0;

for k = 1:ndata
   if (abs(T(k) - Y(k)) <= success_value)
       success_count = success_count + 1;
   end
end

e = (success_count ./ ndata).*100;

% abs(T - Y)
% success_count
% e
%pause