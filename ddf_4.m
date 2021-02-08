function H = ddf_4(X)
% Compute Hessian matrix for F_4, a 4th power function
% 	H = F_4''(X)
%	INPUT ARGUMENTS:
%	X - is 2x1 vector of input variables
%	OUTPUT ARGUMENTS:
%	H is Hessian matrix
x = X(1);
y = X(2);
H = zeros(2);
%second derivative
H(1,1) = 12*x.^2;
H(1,2) = 1;
H(2,1) = 1;
H(2,2) = 1200*y.^2;
end