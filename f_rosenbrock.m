function v = f_rosenbrock(X)
% F_ROSENBROCK is a Rosenbrock function
% 	v = F_ROSENBROCK(X)
%	INPUT ARGUMENTS:
%	X - is 2x1 vector of input variables
%	OUTPUT ARGUMENTS:
%	v is a function value
x = X(1);
y = X(2);
v = (1 - x).^2 + 100*( y - x.^2).^2;
end