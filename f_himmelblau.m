function v = f_himmelblau(X)
% F_HIMMELBLAU is a Himmelblau function
% 	v = F_HIMMELBLAU(X)
%	INPUT ARGUMENTS:
%	X - is 2x1 vector of input variables
%	OUTPUT ARGUMENTS:
%	v is a function value
x = X(1);
y = X(2);
v = (x.^2 + y  - 11).^2 + (x + y.^2 - 7).^2;
end