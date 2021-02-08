function v = f_4(X)
% F_4 is a 4th power function
% 	v = F_4(X)
%	INPUT ARGUMENTS:
%	X - is 2x1 vector of input variables
%	OUTPUT ARGUMENTS:
%	v is a function value
x = X(1);
y = X(2);
v = (x.^4 + 100*y.^4 + 1*x*y);
end