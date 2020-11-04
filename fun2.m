function v = fun2(X)
%	INPUT ARGUMENTS:
%	X - is 2x1 vector of input variables
%	OUTPUT ARGUMENTS:
%	v is a function value
x = X(1);
y = X(2);
v = 2.*x.^2+2.*y.^2+2.*x.*y+20.*x+10.*y+10;
end

