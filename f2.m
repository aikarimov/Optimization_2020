function v = f2(X)
% f is an optimized function
x = X(1);
y = X(2);
v = sin(0.5*x.^2 - 0.25*y.^2 + 3).*cos(2*x + 1 - exp(y));
end