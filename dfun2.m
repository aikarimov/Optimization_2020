function v = dfun2(X)
%	INPUT ARGUMENTS:
%	X - is 2x1 vector of input variables
%	OUTPUT ARGUMENTS:
%	v is a function value
x = X(1);
y = X(2);
v=X;
v(1) = 4.*x+2.*y+20;
v(2) = 4.*y+2.*x+10;
end

