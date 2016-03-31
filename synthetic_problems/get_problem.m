function [U, T] = get_problem(nlength, ndata, problem_name)

[U, T] = eval(sprintf('get_%s_problem(nlength, ndata)', problem_name));