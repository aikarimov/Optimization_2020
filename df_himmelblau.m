function v = df_himmelblau(X)
% DF_HIMMELBLAU is a Himmelblau function derivative
% 	v = DF_HIMMELBLAU(X)
%	INPUT ARGUMENTS:
%	X - is 2x1 vector of input variables
%	OUTPUT ARGUMENTS:
%	v is a derivative function value
x = X(1);
y = X(2);

v = X;
v(1) = 2*(x.^2 + y  - 11).*(2*x) + 2*(x + y.^2 - 7);
v(2) = 2*(x.^2 + y  - 11) + 2*(x + y.^2 - 7).*(2*y);
end