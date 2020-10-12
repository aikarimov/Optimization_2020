function v = df_rosenbrock(X)
% DF_ROSENBROCK is a Rosenbrock function derivative
% 	v = DF_ROSENBROCK(X)
%	INPUT ARGUMENTS:
%	X - is 2x1 vector of input variables
%	OUTPUT ARGUMENTS:
%	v is a derivative function value
x = X(1);
y = X(2);

v = X;
v(1) = -2*(1 - x) + 200*( y - x.^2).*( - 2*x);
v(2) = 200*(y - x.^2);
end