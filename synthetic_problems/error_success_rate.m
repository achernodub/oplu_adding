function e = error_success_rate(T, Y, problem_name)

switch problem_name
    case 'adding'
        e = error_regression(T, Y, 0.08);
    case 'multiplication'
        e = error_regression(T, Y);
    case 'temporder'
        e = error_classification(T, Y);
    case '3bit'
        e = error_classification(T, Y);        
    otherwise
        error 'Don''t know this problem!';
end