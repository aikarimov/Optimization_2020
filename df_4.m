function v = df_4(X)
% dF_4 is a 4th power function gradient
% 	v = dF_4(X)
%	INPUT ARGUMENTS:
%	X - is 2x1 vector of input variables
%	OUTPUT ARGUMENTS:
%	v is a function gradient value
x = X(1);
y = X(2);
v = X;
v(1) = (4*x.^3 + 1*y);
v(2) = (4*y.^3 + 1*x);
end